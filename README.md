# dotfiles-chef

## Description

This cookbook clones a git repository per specified user and afterwards calls a configuration script.

## Usage

Use `recipe[dotfiles::default]` for cloning a git repository per user.

## Requirements

### Platform

It should work on any *nix.

Requires the git cookbook. And `sudo` is required (to easily change user with home directory).

## Recipes

### default

Uses a hash of user_name -> config mappings in `node['dotfiles']['users']` to determine the users and their git clone URLs from e.g `node['dotfiles']['users']['foo']['repo']` (and respects `node['dotfiles']['users']['foo']['ref']`) and calls a `configure.sh` after cloning.

## License

chef-dotfiles is licensed under the Apache License, Version 2.0. See LICENSE for more information.
