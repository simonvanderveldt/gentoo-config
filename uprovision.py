#!/usr/bin/env python3
"""
Simple desktop/laptop provisioning
Provisions files from config packages into / by copying or symlinking
Supports additional commands to be run via shell scripts

Example package structure:
<package>
├── copy
│   └── etc
|       └── foo.cfg
├── init
│   └── install.sh
└── link
    └── var
        └── bar.cfg
"""
# Use of directories for copy, link and init borrowed from
# https://github.com/cowboy/dotfiles#how-the-dotfiles-command-works
# TODO
# Add subcommands? (apply, show (show current state), get (pull file(s) into a package config)
# Add --interactive flag to apply to choose what to do per file?
# Don't overwrite in non-interactive mode by default?
#  When doing so add --force flag to apply to overwrite all files?
# ~Store installed files to be able to delete installed files that are removed from a package?~
#  Add del command instead to remove/clean up the target file
# Add some way to view changes?
#  For links this would be change of symlink target or change from regular file -> symlink
#  For copy this would be a diff (using difflib)

import argparse
import hashlib
import shutil
import subprocess
import sys
from pathlib import Path

GREEN = "\33[32m"
YELLOW = "\33[93m"
ENDC = "\33[0m"

STATE_ICONS = {
    "new": f"{YELLOW}✚{ENDC}",
    "changed": f"{YELLOW}✸{ENDC}",
    "ok": f"{GREEN}✔{ENDC}"
}

class ProvisionedFile:
    def __init__(self, source, step):
        self.source = source
        self.destination = Path("/").joinpath(source.relative_to(*source.parts[:2]))
        self.step = step
        self._state = None

    @property
    def state(self):
        if not self._state:
            if not self.destination.exists():
                self._state = "new"
            else:
                source_hash = get_hash(self.source)
                target_hash = get_hash(self.destination)
                if self.step == "link" and not self.destination.samefile(self.source):
                    self._state = "changed"
                elif self.step == "copy" and source_hash != target_hash:
                    self._state = "changed"
                else:
                    self._state = "ok"
        return self._state

    def install(self):
        if self.step == "link":
            self.destination.symlink_to(self.source.resolve())
        if self.step == "copy":
            shutil.copy(self.source, self.destination)

def get_hash(path):
    with open(path, "rb") as file_:
        file_hash = hashlib.blake2b()
        for chunk in iter(lambda: file_.read(4096), b""):
            file_hash.update(chunk)
    return file_hash.hexdigest()

def summary(ok_files, new_files, changed_files, changes_only=False):
    ok_string = f"{len(ok_files)}{STATE_ICONS['ok']}" if ok_files else None
    new_string = f"{len(new_files)}{STATE_ICONS['new']}" if new_files else None
    changed_string = f"{len(changed_files)}{STATE_ICONS['changed']}" if changed_files else None

    return " ".join(filter(None, [ok_string if not changes_only else None, new_string, changed_string]))

parser = argparse.ArgumentParser()
parser.add_argument("package")
args = parser.parse_args()

files = []
for source_path in Path().glob(f"{args.package}/copy/**/*"):
    if source_path.is_file():
        files.append(ProvisionedFile(source_path, step="copy"))
for source_path in Path().glob(f"{args.package}/link/**/*"):
    if source_path.is_file():
        files.append(ProvisionedFile(source_path, step="link"))

ok_files = [file for file in files if file.state == "ok"]
new_files = [file for file in files if file.state == "new"]
changed_files = [file for file in files if file.state == "changed"]
init_scripts = [init_script for init_script in Path().glob(
    f"{args.package}/init/*.sh")if init_script.is_file()]

for file in ok_files + new_files + changed_files:
    print(file.destination, STATE_ICONS[file.state])

# Install files
if new_files or changed_files:
    choice = input(f"Do you want to apply these changes?"
                   f"({summary(ok_files, new_files, changed_files, True)}) [y/n] ").lower()
    if choice == "y":
        for file in new_files + changed_files:
            file.install()
    elif choice == "n":
        pass
    else:
        sys.exit("Please respond with 'y' or 'n'")
else:
    print(f"{summary(ok_files, new_files, changed_files)}")

# Run init scripts
if init_scripts:
    for script in init_scripts:
        print(script)
    choice = input("Do you want to run these scripts? [y/n] ").lower()
    if choice == "y":
        # Run init script(s)
        for init_script in init_scripts:
            print(f"Running init script {init_script}")
            subprocess.run([init_script], shell=True, check=True)
    elif choice == "n":
        sys.exit()
    else:
        sys.exit("Please respond with 'y' or 'n'")
