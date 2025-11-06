# Hyprland Configuration Agents Guide

## Build/Lint/Test Commands
This is a Hyprland configuration repository - no build/test commands needed.
Use `hyprctl reload` to apply configuration changes.
Use `hyprshade on <shader-name>` to test shader effects.

## Code Style Guidelines

### Configuration Files (.conf)
- Use consistent indentation (2 spaces)
- Group related settings with comments
- Source files in logical order: defaults → theme → personal overrides
- Use descriptive comments for custom rules

### GLSL Shaders (.glsl)
- Use uppercase for shader names in comments
- Include usage example: `// Use with: hyprshade on <name>`
- Add descriptive comment explaining the effect
- Use #version 300 es with highp precision
- Structure: uniforms → main function → effect logic → clamp output
- Keep effects performant, avoid complex calculations

### File Organization
- Keep personal configs in root directory
- Shaders go in shaders/ directory with descriptive kebab-case names
- Maintain separation between Omarchy defaults and personal overrides

### Naming Conventions
- Shader files: kebab-case (e.g., cyberpunk-neon.glsl)
- Config files: lowercase with hyphens (e.g., looknfeel.conf)
- Use descriptive names that clearly indicate purpose