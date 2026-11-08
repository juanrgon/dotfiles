My global dotfiles

Works on macOS (Homebrew), Debian/Ubuntu (apt), and Arch (pacman).

# Install

```
sudo curl --location https://raw.githubusercontent.com/juanrgon/dotfiles/master/download.sh | bash
```

# Test

Quickly test these dotfiles in a fresh Ubuntu or Arch container:

```
./test.sh
./test.sh arch
```

On first install, any file the dotfiles replace is kept next to it with a `.pre-dotfiles` suffix. An existing nvim config that isn't this one is moved to `~/.config/nvim.pre-dotfiles-<timestamp>`.
