# Ghostty Configuration

My [Ghostty](https://ghostty.org/) terminal configuration and a quick reference
for the default keyboard shortcuts.

## Installation

### macOS

1. Install Ghostty with Homebrew:

   ```sh
   brew install --cask ghostty
   ```

   Alternatively, download the app from the [official website](https://ghostty.org/download).

2. Install the `JetBrainsMono Nerd Font` used by `config`. For example, with
   Homebrew:

   ```sh
   brew install --cask font-jetbrains-mono-nerd-font
   ```

3. Start Ghostty. To apply changes in an already running app, press
   `Cmd + Shift + ,`.

### Linux

1. Install Ghostty using your distribution's package manager. For example:

   ```sh
   # Arch Linux
   sudo pacman -S ghostty

   # Ubuntu 26.04 and newer
   sudo apt install ghostty

   # Any distribution with Snap
   sudo snap install ghostty --classic
   ```

   See the [official installation guide](https://ghostty.org/docs/install/binary)
   for other distributions and installation methods.

2. Install `JetBrainsMono Nerd Font` from your distribution's repository or
   download it from [Nerd Fonts](https://www.nerdfonts.com/font-downloads).

3. Start Ghostty. To reload the configuration, press `Ctrl + Shift + ,`.

Ghostty reads `~/.config/ghostty/config` on both macOS and Linux.

## Keyboard Shortcuts

The shortcuts below are the main default key bindings for Ghostty on macOS.

## Configuration

| Shortcut | Action |
| --- | --- |
| `Cmd + ,` | Open the Ghostty configuration file |
| `Cmd + Shift + ,` | Reload the configuration |
| `Cmd + Shift + P` | Open or close the command palette |

## Windows and Tabs

| Shortcut | Action |
| --- | --- |
| `Cmd + N` | Open a new window |
| `Cmd + T` | Open a new tab |
| `Cmd + W` | Close the current surface |
| `Cmd + Option + W` | Close the current tab |
| `Cmd + Shift + W` | Close the current window |
| `Cmd + Shift + [` | Go to the previous tab |
| `Cmd + Shift + ]` | Go to the next tab |
| `Cmd + 1` … `Cmd + 8` | Go to a numbered tab |
| `Cmd + 9` | Go to the last tab |
| `Cmd + Enter` | Toggle fullscreen mode |

## Splits

| Shortcut | Action |
| --- | --- |
| `Cmd + D` | Create a split on the right |
| `Cmd + Shift + D` | Create a split below |
| `Cmd + [` | Focus the previous split |
| `Cmd + ]` | Focus the next split |
| `Cmd + Option + Arrow` | Focus the split in that direction |
| `Cmd + Control + Arrow` | Resize the split in that direction |
| `Cmd + Control + =` | Equalize all splits |
| `Cmd + Shift + Enter` | Toggle zoom for the current split |

## Search and Navigation

| Shortcut | Action |
| --- | --- |
| `Cmd + F` | Search terminal output |
| `Cmd + G` | Go to the next search result |
| `Cmd + Shift + G` | Go to the previous search result |
| `Esc` | Close search |
| `Cmd + Up` | Jump to the previous prompt |
| `Cmd + Down` | Jump to the next prompt |
| `Cmd + Home` | Scroll to the top |
| `Cmd + End` | Scroll to the bottom |
| `Cmd + Page Up` | Scroll one page up |
| `Cmd + Page Down` | Scroll one page down |
| `Cmd + K` | Clear the screen |

## Text and Display

| Shortcut | Action |
| --- | --- |
| `Cmd + C` | Copy the selection |
| `Cmd + V` | Paste from the clipboard |
| `Cmd + A` | Select all |
| `Cmd + +` | Increase the font size |
| `Cmd + -` | Decrease the font size |
| `Cmd + 0` | Reset the font size |
| `Option + Left` | Move back one word |
| `Option + Right` | Move forward one word |
