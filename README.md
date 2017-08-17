## About

Vagrant box which automates the creation of Chef Omnibus packages for Raspberry Pi.

## System requirements

 * [Vagrant](https://www.vagrantup.com/downloads.html) 1.9+
 * [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 5.1+
 * [vagrant-scp](https://github.com/invernizzi/vagrant-scp) plugin

## Why?

Raspberry Pi deservers automation too! Installing Chef via non-standard methods leads to certain development and deployment consistency issues. A package which is compliant with the upstream Chef client packages solves that issue.

## Tell me more

This is achieved by running an LXC container with a foreign architecture (armhf). All the binaries are wrapped with qemu-user-static, but the heavy lifting is being done by LXC.

I have found that Ubuntu 16.04 is close enough to Raspbian in order to produce suitable binaries for Raspberry Pi. The same Ubuntu version is used for both the Vagrant box and the LXC container.

Building in an emulated ARM environment is slow, but building on an actual Raspberry Pi, even the latest 3 Model B with the quad core CPU, is roughly the same. I haven't done any actual measurements. Extreme patience is required, but the whole build process has been automated.

## How to use

To start the build, run:

```bash
rake up
```

If the build fails, roughly in the Omnibus process, it may be retried by running:

```bash
rake provision
```

After the build is successful, you may be able to get the build artefact(s) with:

```bash
rake fetch
```

To clean the build box, run:

```bash
rake clean
```

The `clean` task won't delete the build artefacts.
