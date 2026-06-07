# Supported Languages

dotvim provides full IDE-grade support for these languages via LSP + vim-polyglot syntax.

## Language Matrix

| Language | LSP Server | Syntax | Format | Lint | Debug |
|----------|-----------|--------|--------|------|-------|
| **C/C++** | clangd | ✅ | clang-format | ✅ | GDB via terminal |
| **Python** | pyright | ✅ | | ✅ | pdb via terminal |
| **Go** | gopls | ✅ | goimports | ✅ | delve via terminal |
| **Rust** | rust-analyzer | ✅ | rustfmt | ✅ | |
| **JavaScript/TS** | typescript-language-server | ✅ | prettier | ✅ | |
| **HTML** | vscode-html-language-server | ✅ | | | |
| **CSS** | vscode-css-language-server | ✅ | | | |
| **Bash/Shell** | bash-language-server | ✅ | | shellcheck | |
| **YAML** | yaml-language-server | ✅ | | ✅ | |
| **JSON** | vscode-json-language-server | ✅ | | ✅ | |
| **XML** | | ✅ | | | |
| **LaTeX** | texlab | ✅ | | ✅ | |
| **MATLAB** | | ✅ | | | |
| **Dockerfile** | dockerfile-language-server | ✅ | | | |
| **Terraform** | terraform-ls | ✅ | terraform fmt | ✅ | |
| **CMake** | cmake-language-server | ✅ | | | |
| **BitBake (Yocto)** | | ✅ | | | |
| **Protobuf** | | ✅ | | | |

## Per-Language Settings

### C/C++ (2-space indent, cindent)

```vim
autocmd FileType c,cpp,h,hpp setlocal tabstop=2 shiftwidth=2 cindent
```

- LSP: clangd (auto-installed)
- Format: clang-format (auto on save for files < 10k lines)
- Compile: `Space mk` (make), `Space mb` (cmake build)

### Python (4-space indent)

```vim
autocmd FileType python setlocal tabstop=4 shiftwidth=4
```

- LSP: pyright (auto-installed)
- Run: `:FloatermNew python3 %`

### Go (tabs, not spaces)

```vim
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
```

- LSP: gopls (auto-installed, includes goimports on save)
- Run: `:FloatermNew go run .`

### JavaScript/TypeScript

- LSP: typescript-language-server
- Syntax: vim-polyglot (JSX/TSX included)

### LaTeX

- LSP: texlab (completion, references, build)
- Compile: `:FloatermNew latexmk -pdf %`

### YAML/JSON

- LSP: yaml-language-server / vscode-json-language-server
- Schema validation included

## Installing a Language Server

Open any file of that language type and run:

```vim
:LspInstallServer
```

That's it. The server downloads, installs, and activates automatically.

## Checking LSP Status

```vim
:LspStatus
```
