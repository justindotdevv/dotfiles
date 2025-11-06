# GEMINI.md: Waybar Configuration

## Project Overview

This directory contains the configuration for the [Waybar](https://github.com/Alexays/Waybar) status bar. It is part of a larger configuration management setup, likely named "omarchy", as evidenced by the various `omarchy-` commands and script paths in the configuration files.

The configuration is composed of three main files:

*   `config.jsonc`: The main Waybar configuration file. It defines the layout and modules of the status bar.
*   `style.css`: A CSS file for styling the Waybar and its modules. It imports a theme from the `omarchy` setup.
*   `scripts/weather.sh`: A custom script to display weather information, fetched from `wttr.in`.

The main technologies used are:

*   **Waybar**: The status bar application.
*   **JSONC**: For the main configuration file.
*   **CSS**: For styling.
*   **Shell Scripting (Bash)**: For the custom weather module.

## Building and Running

This is a configuration project for Waybar and does not need to be "built". Waybar reads these files to render the status bar.

To apply any changes made to the configuration files, you need to reload Waybar. You can typically do this by sending a `SIGUSR2` signal to the `waybar` process.

```bash
# To reload waybar configuration
killall -SIGUSR2 waybar
```

If Waybar is not running, it can be started from the terminal:

```bash
waybar &
```

## Development Conventions

*   **Configuration**: The main configuration is in `config.jsonc`. It is structured with modules organized into `modules-left`, `modules-center`, and `modules-right`.
*   **Styling**: The styling is done via CSS in `style.css`. The file imports a base theme from `../omarchy/current/theme/waybar.css`, and then applies specific styles for this configuration.
*   **Custom Scripts**: Custom modules are implemented as shell scripts. The `weather.sh` script is an example of this. It outputs JSON that Waybar can parse.
*   **Dependencies**: This configuration depends on the "omarchy" scripts and setup. Many `on-click` actions in `config.jsonc` call `omarchy-` prefixed commands. The `weather.sh` script depends on `curl` and `jq`.
