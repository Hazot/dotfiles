# linux-config-dotfiles

PRIVATE LINUS CONFIG DOTFILES, DO NOT PUT PUBLIC BECAUSE KEYS ARE IN IT

# WSL2

In ``/etc/wsl.conf``, add:
```
[boot]
systemd=true

[interop]
appendWindowsPath = False
``````
