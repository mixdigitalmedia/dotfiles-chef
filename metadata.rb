name             "dotfiles"
maintainer       "Mix Digital Media, LLC (Inspired by Christian Nicolai)"
maintainer_email "info@mixdigitalmedia.com"
license          "Apache 2.0"
description      "This cookbook clones a git repository per specified user and afterwards calls a configuration script."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

depends "git"

supports "debian"
