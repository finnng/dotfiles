# Finn's Dotfiles

This repository contains my personal configuration files (dotfiles) for various tools and applications. These configurations are tailored to my workflow but are free to use and can be modified to suit your needs.

## Repository Structure

```
.
├── README.md
├── aliases.sh
├── karabiner/
│   ├── assets/
│   │   └── complex_modifications/
│   │       ├── app-switching.json
│   │       └── misc.json
│   ├── automatic_backups/
│   └── karabiner.json
├── kitty/
│   ├── current-theme.conf
│   ├── kitty.conf
│   └── kitty.conf.bak
├── nvim/
│   ├── colors/
│   ├── init.lua
│   ├── lazy-lock.json
│   ├── lua/
│   ├── my-lsp-config.lua
│   └── snippets/
├── old_nvim/
│   ├── coc-settings.json
│   ├── init-windows.vim
│   ├── init.vim
│   └── vimvscode.vimrc
├── windows/
│   ├── Microsoft.PowerShell_profile.ps1
│   └── autohotkey.ahk
└── zshrc.sh
```

## Contents

1. **aliases.sh**: Shell aliases for common commands and shortcuts.

2. **karabiner/**: Configuration files for Karabiner-Elements, a powerful keyboard customizer for macOS.
   - `assets/complex_modifications/`: Custom key mappings and modifications.
   - `automatic_backups/`: Automatically generated backups of Karabiner configurations.
   - `karabiner.json`: Main configuration file for Karabiner-Elements.

3. **kitty/**: Configuration files for Kitty, a fast, feature-rich, GPU-based terminal emulator.
   - `current-theme.conf`: Current color theme configuration.
   - `kitty.conf`: Main configuration file for Kitty.

4. **nvim/**: Configuration files for Neovim, a hyperextensible Vim-based text editor.
   - `colors/`: Custom color schemes.
   - `init.lua`: Main configuration file for Neovim.
   - `lazy-lock.json`: Lock file for lazy.nvim plugin manager.
   - `lua/`: Lua configuration files for various plugins and settings.
   - `snippets/`: Custom code snippets for different languages.

5. **old_nvim/**: Older Neovim configurations (kept for reference).
   - Includes configurations for CoC (Conquer of Completion), Windows-specific settings, and VSCode Neovim integration.

6. **windows/**: Configuration files specific to Windows.
   - `Microsoft.PowerShell_profile.ps1`: PowerShell profile configuration.
   - `autohotkey.ahk`: AutoHotkey script for custom keyboard shortcuts and automation.

7. **zshrc.sh**: Configuration file for Zsh shell.

## Usage

To use these dotfiles:

1. Clone this repository:
   ```
   git clone https://github.com/your-username/dotfiles.git
   ```

2. Symlink or copy the desired configuration files to their respective locations in your home directory.

3. For Neovim configuration:
   - Ensure you have Neovim 0.5+ installed.
   - Copy or symlink the `nvim` directory to `~/.config/nvim/`.

4. For Kitty configuration:
   - Copy or symlink `kitty/kitty.conf` to `~/.config/kitty/kitty.conf`.

5. For Karabiner-Elements:
   - Copy the contents of `karabiner/` to `~/.config/karabiner/`.

6. For Windows-specific configurations:
   - Place `Microsoft.PowerShell_profile.ps1` in your PowerShell profile directory.
   - Set up AutoHotkey and use the provided `autohotkey.ahk` script.

7. Source the `zshrc.sh` and `aliases.sh` in your `.zshrc` file:
   ```
   source ~/path/to/dotfiles/zshrc.sh
   source ~/path/to/dotfiles/aliases.sh
   ```

## Customization

Feel free to fork this repository and modify the configurations to suit your needs. Remember to backup your existing configurations before replacing them with these files.

## Contributing

If you have suggestions for improvements or bug fixes, please feel free to open an issue or submit a pull request.

## License

This project is open-source and available under the [MIT License](LICENSE).
