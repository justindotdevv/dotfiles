# Markdown LSP Test File

This is a test document for verifying the markdown language server is working correctly.

## Introduction

The quick brown fox jumps over the lazy dog. This sentence contains every letter of the English alphabet and is commonly used to test fonts, keyboards, and other text-rendering systems.

## Features to Test

Here are some markdown features worth checking:

- **Bold text** should render in bold
- *Italic text* should render in italics
- ~~Strikethrough~~ should appear crossed out
- `inline code` should use a monospace font
- [Links](https://example.com) should be clickable

### Nested Lists

1. First item
2. Second item
   - Nested bullet
   - Another nested bullet
3. Third item

## Code Blocks

```lua
local function greet(name)
  return "Hello, " .. name .. "!"
end

print(greet("world"))
```

```python
def fibonacci(n):
    if n < 2:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)
```

## Blockquotes

> The only way to do great work is to love what you do.
> If you haven't found it yet, keep looking. Don't settle.

## Tables

| Language | Year | Creator       |
| -------- | ---- | ------------- |
| Lua      | 1993 | Roberto I.    |
| Python   | 1991 | Guido van R.  |
| Rust     | 2010 | Graydon Hoare |

## Conclusion

This file should help exercise diagnostics, formatting, completion, and hover features of the markdown LSP. If everything renders and behaves as expected, the setup is working.
