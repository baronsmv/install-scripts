# Install Scripts

A series of shell scripts designed to automate several installation processes on Debian-based systems.

## Overview

### From a text file

Scripts, such as `install-apt.fish`, facilitate the installation of packages from a text file with specific patterns in the columns, as described below:

- First column:
  - `#` : Uninstalls the package.
  - `##` : Marks a package to be ignored.
- Second column:
  - `.bp` : Installs a package from the Debian backports repository.
  - `.fp` : Installs a Flatpak package from FlatHub.
  - `.fb` : Installs a Flatpak package from FlatHub Beta.
  - `.pi` : Installs a Python package using `pipx install`.
  - `.np` : Installs an NPM package globally using `npm install -g`.

### From GitHub

These scripts, located in the `gh` directory, are used to install and update `.deb` packages hosted on GitHub. The `gh/packages` directory contains scripts that call `gh/install-gh.fish` with the following arguments:

1. GitHub Profile.
2. GitHub Repository.
3. Pattern.
4. Antipattern.

Execute `gh/install-all.fish` to install and update all the scripts located there.

The script `gh/install-gh.fish` downloads a GitHub executable (instead of the `.deb` package) and places it in a local `bin` directory.

### From a repository

These scripts, located in the `repo` directory, are used to add repositories to Debian, using standard locations and process. Each script requires the following arguments:

1. Name of repository.
2. URL of GPG key.
3. URL of repository.
