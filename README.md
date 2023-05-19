# .dots

![Desktop](./screen.png)

New and upgraded dotfiles, now with Ansible!

## What is this?

This Ansible project serves to configure and maintain my personal workstations, which includes software installation,
management of dotfiles, handling configurations, and more.

## Danger, Will Robinson!

For clear reasons, it's not advisable to apply this configuration on your personal machine. If you do, it will
disrupt your existing system, replace it with my own setup, and could potentially cause harm to your cat or any other
domestic animals that may be nearby.

You are welcome to use this repository as a foundation for your setup, and it's recommended to experiment with it on a
disposable virtual machine.

The main branch is compatible with Fedora 37+. While there may be other branches for various operating systems,
please note that these are for testing and not actively maintained.

## Goals and non-goals

The primary objective here is to swiftly configure my desktop environment on a new machine installation or after a
re-installation with minimal manual steps.

While this repository isn't geared towards offering a production-grade Ansible project, I will strive to maintain the
roles and associated elements as manageable as possible for the sake of my personal convenience and sanity. If you're on
the hunt for model examples of how to write production Ansible roles for sharing with others, I must mention that this
may not serve as an ideal reference. However, it could provide a starting point for you. There are numerous shortcuts
that have been used here primarily because they suit my requirements.

## What is automated

- Individual dotfiles, shell configurations, and related items.
- Almost all software applications I utilize on my workstations (excluding user configurations which are yet to be
  done).
- Default settings for themes, fonts, dconf settings for GNOME3, and extensions.
- Certain standard security settings and more.

## Components

- GNOME desktop
- [Nord Theme](https://github.com/EliverLara/Nordic)
- Papirus Dark icons
- [IBM Plex](https://www.ibm.com/plex/) and [JetBrains Mono](https://www.jetbrains.com/lp/mono/) fonts
- ... software, tools, things.

### dconf settings and system defaults

The configuration of the desktop user experience is intentionally set as a system-wide default profile, rather than
employing per-user settings. This is a deliberate choice because not all my machines are identical. By using system-wide
defaults, I retain the flexibility to override certain settings locally without the risk of them being reversed later by
Ansible.

## How to use

### Obtain a fork

1. Fork this repository.
2. Review and modify [workstation playbook](./workstation.yml).
3. Review and modify [files](./files) and [templates](./templates).
4. Commit and push your changes to your fork.
5. Follow the "How to use" as described below.

**IMPORTANT**: Please refrain from adding anything confidential to a public repository. This includes, but is not
limited to, passwords, private keys, and other sensitive information.

### Using Ansible to deploy the configuration

1. Begin by setting up a machine with a basic installation of Fedora featuring a minimal desktop environment.
    - If you plan to complete the installation remotely, an SSH server is required.
2. Shift to a non-default TTY or SSH into the machine remotely.
3. Install Ansible and other dependencies using the command `sudo dnf install python3 python3-pip git`
4. Proceed with Ansible's installation using sudo `pip3 install ansible`
5. Clone this repository to a location of your choice. I typically use `~/dots/`.
6. Modify `workstation.yml` as necessary.

To run Ansible in check mode, use `ansible-playbook workstation.yml -K -C`.
To run Ansible against localhost, use `ansible-playbook workstation.yml -K`.

Setting up requires root privileges (as you might expect). Ansible will prompt you for your password to become the root
user. This is necessary because Ansible automates package installation, modifies settings only accessible to the root,
etc.

After the playbooks have been applied, a reboot might be necessary.

## Known issues

- During the initial setup, there may be an instance where dconf update doesn't execute properly and might necessitate a
  manual second run after all changes are applied. To resolve this, simply log in and run dconf update as root.

## The backstory

Until around June 2020, Elementary was my preferred distribution for all my personal workstation machines. These
machines were semi-managed using a blend of shell scripts and manual work.

A few changes within Elementary itself, Ubuntu upstream, and some subjective reasons (a particularly bored night, for
instance) led me to reconsider whether Elementary was still the optimal choice for my personal use case, as it had been
when I first started using it. GNOME and its associated elements have transformed significantly since its early days.

I experimented with multiple distributions, using each for a few days, to gauge their integration potential within my
workflows and daily routine. Initially, I leaned towards Debian, a system with which I have a lengthy history. It had
been my go-to operating system for all my personal servers and was my main desktop operating system until mid-2012,
before I shifted to Elementary. In fact, my first exposure to a Linux operating system was with Debian, version 2.2 at
that time - nearly two decades ago.

While it's relatively easy to designate a spare machine for testing an operating system, transferring all your tools,
configurations, and software to a similar, albeit slightly different, distribution is a whole other task. This becomes
even more challenging if you are managing multiple machines - several of which I use daily, and others occasionally.
Nonetheless, they all require the same setup as my daily use machines.

This Ansible project was developed to address the challenge of synchronizing work environments across all my physical
machines, thus maintaining a more or less consistent configuration over prolonged periods.

As of approximately August 2022, numerous changes have transpired. Most notably:

- I've decreased the number of physical machines I regularly use from around five to just two - my main mobile
  workstation and my stationary desktop, which I primarily use for media and the occasional game or two.
- I've transitioned both of these machines to Fedora, a move made considerably easier thanks to this Ansible project!
- This repository has been significantly simplified and no longer relies on a roles-based structure. Employing just one
  playbook that includes everything has proved to be more convenient, though not necessarily the "correct" way.

## FAQ

### What about syncthing?

If you have a primary and a secondary machine, and you only ever make changes to one of them, you could potentially use
Syncthing for your dotfiles. However, you are restricted to syncing files only. Generally, this is not the most
recommended approach.

If you have more than two machines to configure and are considering using Syncthing to synchronize your configurations
and dotfiles, it's likely not the best choice. Unless, of course, you don't mind potential disruptions to your system.

### What about git?

This project indeed uses Git. In theory, you could bind your home directory with `.git` and `#!/bin/bash` - but why
would you? Maintaining this project is significantly simpler.

### What about other 5,000 tools someone created to configure their machines/dotfiles?

Ultimately, you should opt for whatever strategy suits you best. Ansible is a standard tool employed by countless system
administrators, operations professionals, and developers for tasks far more critical than this. By choosing Ansible,
you're in good company, and there are very few tasks you can't handle with Ansible in the current year.

### Does Ansible work on MAC?

Absolutely, it does. It covers Homebrew package management, configuration file management, and much more.

### But but but my bootstrap scripts and manual copy-pasting of everything?!

Haha Ansible playbooks go brrr

    
