#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with phppgadmin](#setup)
    * [What phppgadmin affects](#what-phppgadmin-affects)
    * [Beginning with phppgadmin](#beginning-with-phppgadmin)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A puppet module to install [phpPgAdmin](http://phppgadmin.sourceforge.net).

## Module Description

phpPgAdmin is a web application used to administrator PostgreSQL.  This puppet module will install and configure phpPgAdmin.  An example is provided below on how to use this with the [puppetlabs/apache](https://forge.puppetlabs.com/puppetlabs/apache) module to also set up Apache.

## Setup

### What phppgadmin affects

* phpPgAdmin package
* phpPgAdmin configuration

### Beginning with phppgadmin

phpPgAdmin can be installed simply by including the module:

```puppet
    class { 'phppgadmin': }
```

## Usage

By itself, installing phpPgAdmin will not be very useful as it needs a webserver to run.  To install phppgadmin with puppetlab's apache module:

```puppet
    class { 'apache': }
    class { 'apache::mod::php': }
    apache::vhost { 'phppgadmin':
      docroot     => '/var/www/html',
      port        => 80,
      aliases     => [
        {
          alias => '/phpPgAdmin',
          path  => '/usr/share/phpPgAdmin'
        }, {
          alias => '/phppgadmin',
          path  => '/usr/share/phpPgAdmin'
        }
      ],
    }
```

## Reference

### Public classes

#### Class: `phpmyadmin`

##### `config`

Configuration parameters to apply to phppgadmin.  This should be a hash with the key as the property and the appropriate value.

##### `servers`

Servers to be added phpPgAdmin.  This is an array of hashes with the hash containing the properties and values for the host.

##### `srv_groups`

Server groups to be added to phpPgAdmin.  This is an array of hashes with the hash containing the properties and values for the group.

##### `config_file`

Location of the phpPgAdmin configuration file.

##### `package_name`

Name of the phpPgAdmin package

##### `www_user`
User name the config file should be owend by.  This will typically be your web server

##### `www_group`

Group the config file should be owend by.  This will typically be your web server

##### `version`

Version of phpMyAdmin to install

## Limitations

This has only been tested on CentOS 6 and 7.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
