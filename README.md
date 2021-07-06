# .dots

![Desktop](./media/screen.png)

New and upgraded dotfiles, now with Ansible!

## What is this?

This is an Ansible project I use to configure and maintain my personal workstations, install software, manage
dotfiles, manage the configuration and more.

Note: this is a detached branch/fork that is designed to be used with Ubuntu LTS (20.04).

## Danger, Will Robinson!

For obvious reasons, you **should not** apply this configuration on your own machine. Doing so **will break your stuff**,
**replace it with my stuff** and possibly, **kill your cat** or any other household pets you might have in the immediate
vicinity. However, you can definitely use this repository to bootstrap your own setup and to try it all out on
a disposable virtual machine.

The `ubuntu2004` brand is only guaranteed to be comptible with Ubuntu 20.04.

## Goals and non-goals

The goal is to be able to configure my desktop environment on a fresh machine installs as fast as possible and with 
as few manual steps as possible. 

Having a production grade Ansible project is not a goal of this repository, however I will try my best to keep the roles and 
such somewhat maintainable for the benefit of my own, personal sanity. If you are looking for examples on how to write
production Ansible roles to be shared with others - this is NOT a good example (though it could help you
get started). Many shortcuts have been taken here because it is acceptable to *me*.

## What is automated

- Personal dotfiles, shell setup, etc.
- Nearly all the software I use on my workstations (sans user configs @ todo).
- Defaults for themes, fonts, dconf settings for GNOME3 and extensions.
- Some security defaults, SSHD config etc.

## Components

- GNOME desktop.
- [Arc Menu](https://extensions.gnome.org/extension/1228/arc-menu/) extension.
- [Dash to Panel](https://extensions.gnome.org/extension/1160/dash-to-panel/) extension.
- [OpenWeather](https://extensions.gnome.org/extension/750/openweather/) extension.
- [User Themes](https://extensions.gnome.org/extension/19/user-themes/) extension.
- [Arc Dark](https://packages.ubuntu.com/focal/arc-theme) GTK theme and shell theme.
- [Papirus Dark](https://packages.ubuntu.com/focal/papirus-icon-theme) icons.
- [IBM Plex](https://www.ibm.com/plex/) and [JetBrains Mono](https://www.jetbrains.com/lp/mono/) fonts.
- ... software, tools, things.

### dconf settings and system defaults

Desktop user experience configuration is set as a system wide default profile instead of using per-user settings.
This is done on purpose - not all of my machines are exactly the same and by using system defaults I can still override
some settings locally without having them later reverted by Ansible.

## How to use

### Using manual installation

1. Set up machine with basic installation of Ubuntu 20.04. When prompted, select `minimal install`.
3. Move to non-default TTY or SSH into the machine remotely.
2. Install Ansible and other dependencies `sudo apt install python3 python3-pip git`
3. Install Ansible `sudo pip3 install ansible`
4. Clone this repository somewhere. I usually use `~/dots/`.
5. Edit `group_vars/all` as required.
6. As a regular user (probably the same as in `group_vars/all.yml`), execute Ansible as shown bellow:

`ansible-playbook -i hosts site.yml -K -C` to run Ansible in check mode.
`ansible-playbook -i hosts site.yml -K` to run Ansible against localhost.

Setup requires root privileges (but of course it does). Ansible will ask you for your password to become root user. 
This is required because Ansible automates package installation, changes settings only accessible to root etc.

### How to modify and use

1. Fork this repository.
2. Review and modify [workstation main task collection](./roles/workstation/tasks/main.yml).
3. Review and modify [files](./roles/workstation/files) and [templates](roles/workstation/templates).
4. Review and modify [group_vars](./group_vars/all.yml).
5. Commit and push your changes to your fork. 
6. Follow the "How to use" as described above.

**IMPORTANT**: you should NEVER add anything you want to keep secret to a public repository, including passwords,
    private keys and such.

## Things not yet automated

- Gnome shell extensions are not automatically installed, but are required 
    - [Arc menu](https://extensions.gnome.org/extension/3628/arcmenu/)
    - [Dash to panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
    - [OpenWeather](https://extensions.gnome.org/extension/750/openweather/)
    - [UserThemes](https://extensions.gnome.org/extension/19/user-themes/)
- [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/) (no deb available).

## Known issues

- During initial setup, `dconf update` might not be executed properly and might need to be run second time manually 
  after all changes are applied. Simply sign in and run `dconf update` as `root`.

## Credits

Wallpaper artwork - "Small Memory" © [Mikael Gustafsson](https://mikaelgustafsson.art) - [Dribbble](https://dribbble.com/MikaelGustafsson) - [Twitter](https://twitter.com/mklgustafsson).

## But but but my bootstrap scripts and manual copy-pasting of everything?!

Haha Ansible manifests go brrr
