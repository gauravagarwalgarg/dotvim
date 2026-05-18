# 🔧 Embedded Development Workflow in Vim

> C/C++ firmware development with IDE-grade intelligence no GUI required.

---

## 📌 Overview

This guide covers a complete embedded development workflow in Vim:
- LSP-powered code intelligence (clangd)
- Cross-compilation awareness
- Build system integration (CMake, Make, Yocto)
- Debugging with GDB
- Serial monitor integration
- Device tree editing
- ctags for legacy codebases

---

## 🧠 LSP Setup for Embedded C/C++

### clangd Configuration

clangd is the gold standard for C/C++ intelligence. It needs a `compile_commands.json` to understand your project.

**Generate compile_commands.json:**

```bash
# CMake projects
cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -s build/compile_commands.json .

# Make projects (using Bear)
bear -- make

# Yocto/BitBake
# Add to your local.conf:
# INHERIT += "cmake"
# then extract from build directory
```

**Cross-compilation support** create `.clangd` in project root:

```yaml
CompileFlags:
  Add:
    - --target=arm-none-eabi
    - -I/path/to/toolchain/include
    - -DSTM32F407xx
  Remove:
    - -mfpu=*
    - -mfloat-abi=*
    
Diagnostics:
  UnusedIncludes: Strict
  ClangTidy:
    Add:
      - bugprone-*
      - modernize-*
      - readability-*
    Remove:
      - modernize-use-trailing-return-type
```

### Install clangd in Vim

```vim
" Open any .c or .cpp file, then:
:LspInstallServer
" This auto-installs clangd via vim-lsp-settings
```

### What You Get

- **Autocomplete** with full semantic awareness (struct members, function signatures)
- **Go to definition** across translation units (`gd`)
- **Find references** project-wide (`gr`)
- **Rename symbol** safely across all files (`<leader>rn`)
- **Inline diagnostics** (errors, warnings, clang-tidy suggestions)
- **Hover docs** showing function signatures and documentation (`K`)
- **Include completion** with path awareness
- **Code actions** for quick fixes (`<leader>ca`)

---

## 🏗️ Build System Integration

### CMake Projects

```vim
" Build with AsyncRun (non-blocking)
<leader>mb    " Runs: cmake --build build

" Custom build commands
:AsyncRun cmake -B build -DCMAKE_BUILD_TYPE=Debug
:AsyncRun cmake --build build --target flash
:AsyncRun cmake --build build -- -j$(nproc)

" Errors appear in quickfix window
:copen        " Open quickfix
:cnext        " Jump to next error
:cprev        " Jump to previous error
```

### Make Projects

```vim
" Standard make
<leader>mk    " Runs: make

" Make with target
:AsyncRun make flash
:AsyncRun make clean && make -j$(nproc)

" Set makeprg for :make command
set makeprg=make\ -C\ build\ -j$(nproc)
:make         " Build and populate quickfix with errors
```

### Yocto/BitBake

```vim
" BitBake commands via Floaterm
:FloatermNew bitbake my-image
:FloatermNew bitbake -c compile my-recipe
:FloatermNew bitbake -c devshell my-recipe

" Or via AsyncRun for quickfix integration
:AsyncRun bitbake my-recipe 2>&1 | head -100
```

---

## 🐛 Debugging with GDB

### Using Vim's built-in terminal + GDB

```vim
" Start GDB in a terminal split
:terminal gdb build/firmware.elf

" Or use Floaterm for a floating GDB session
:FloatermNew gdb -tui build/firmware.elf
```

### Using vim-dispatch for remote GDB

```vim
" Connect to OpenOCD GDB server
:FloatermNew arm-none-eabi-gdb -ex "target remote :3333" build/firmware.elf

" Common GDB commands (in terminal):
" b main          → breakpoint at main
" c               → continue
" n               → next (step over)
" s               → step (step into)
" p variable      → print variable
" bt              → backtrace
" info registers  → show CPU registers
" x/16xw 0x20000000 → examine memory
```

### OpenOCD Integration

```vim
" Start OpenOCD in background terminal
:FloatermNew --name=openocd openocd -f interface/stlink.cfg -f target/stm32f4x.cfg

" Flash firmware
:AsyncRun openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program build/firmware.elf verify reset exit"
```

---

## 📡 Serial Monitor

```vim
" Open serial monitor in floating terminal
:FloatermNew minicom -D /dev/ttyUSB0 -b 115200

" Or with screen
:FloatermNew screen /dev/ttyACM0 115200

" Or with picocom (recommended clean exit with Ctrl+A Ctrl+X)
:FloatermNew picocom -b 115200 /dev/ttyUSB0
```

---

## 🌳 Device Tree Editing

Vim with LSP doesn't natively support DTS, but you can still get good support:

```vim
" Filetype detection (already in vimrc)
au BufRead,BufNewFile *.dts,*.dtsi setfiletype dts

" Syntax highlighting comes from vim-polyglot

" Useful mappings for DTS navigation
" Jump to included file
gf            " Works if include paths are set

" Set include paths for device tree
set path+=/path/to/linux/include
set path+=/path/to/linux/arch/arm/boot/dts
```

---

## 🏷️ ctags for Legacy Codebases

When LSP isn't available (old toolchains, no compile_commands.json):

```bash
# Generate tags for your project
ctags -R --languages=C,C++ --exclude=build .

# For kernel development
ctags -R --languages=C --exclude=Documentation --exclude=tools .
```

```vim
" Navigate with ctags
<C-]>         " Jump to definition
<C-t>         " Jump back
<C-\>         " Jump to definition in new tab (custom mapping)
<leader>]     " Jump to definition in vertical split (custom mapping)
:ts /pattern  " Search tags by pattern
g]            " Show all matching tags (choose from list)

" Auto-regenerate tags on save
autocmd BufWritePost *.c,*.h silent! !ctags -R &
```

---

## 📁 Project Structure Navigation

### Typical Embedded Project

```
firmware/
├── CMakeLists.txt
├── .clangd
├── compile_commands.json → build/compile_commands.json
├── src/
│   ├── main.c
│   ├── drivers/
│   ├── hal/
│   └── app/
├── include/
├── tests/
├── linker/
│   └── STM32F407.ld
└── build/
```

### Quick Navigation Patterns

```vim
" Find any file instantly
<C-p>                     " Fuzzy find by filename

" Find symbol across project
<leader>fg               " Grep for pattern
:Rg struct my_device     " Find struct definition

" Jump between header and source
" (with vim-lsp)
:LspSwitchSourceHeader   " Toggle .c ↔ .h

" Or manual mapping:
nnoremap <leader>oh :e %:r.h<CR>    " Open corresponding .h
nnoremap <leader>oc :e %:r.c<CR>    " Open corresponding .c
```

---

## 🔍 Code Analysis Patterns

### Find All Usages of a Register/Peripheral

```vim
" Search for all accesses to a peripheral register
:Rg 'GPIOA->'           " All GPIOA register accesses
:Rg 'RCC_.*Enable'      " All clock enable calls
:Rg '#define.*IRQ'      " All IRQ definitions
```

### Trace Interrupt Handlers

```vim
" Find all ISR implementations
:Rg '_IRQHandler'
:Rg 'void.*Handler\b'

" Find where interrupts are enabled
:Rg 'NVIC_EnableIRQ\|HAL_NVIC_EnableIRQ'
```

### Memory Map Analysis

```vim
" Open linker script and navigate sections
:e linker/STM32F407.ld
/\.text                  " Find text section
/\.bss                   " Find BSS section
/MEMORY                  " Find memory layout
```

---

## ⚡ Productivity Shortcuts for Embedded

### Quick Hex/Binary Conversion

```vim
" In insert mode, evaluate expressions
<C-r>=printf('0x%X', 255)<CR>        " → 0xFF
<C-r>=printf('%d', 0xFF)<CR>         " → 255
<C-r>=printf('0b%08b', 42)<CR>       " → 0b00101010

" Convert hex under cursor to decimal (and vice versa)
" Add to vimrc:
nnoremap <leader>hd :echo printf('%d', expand('<cword>'))<CR>
nnoremap <leader>dh :echo printf('0x%X', expand('<cword>'))<CR>
```

### Register Bit Manipulation Snippets

```vim
" Abbreviations for common patterns
iabbrev SETBIT(reg, bit) ((reg) |= (1U << (bit)))
iabbrev CLRBIT(reg, bit) ((reg) &= ~(1U << (bit)))
iabbrev TOGBIT(reg, bit) ((reg) ^= (1U << (bit)))
iabbrev GETBIT(reg, bit) (((reg) >> (bit)) & 1U)
```

### Size/Alignment Quick Check

```vim
" Check sizeof in hover (clangd provides this)
K             " Hover over a type to see its size

" Quick compile check without full build
:AsyncRun gcc -fsyntax-only -Wall -Wextra %
```

---

## 🧪 Unit Testing Integration

### Running Tests

```vim
" Run all tests
:AsyncRun cmake --build build --target test

" Run specific test
:AsyncRun ctest --test-dir build -R test_name

" Run Unity/CUnit tests
:AsyncRun make test VERBOSE=1
```

### Test Navigation

```vim
" Jump between source and test file
nnoremap <leader>ot :e %:s?src?tests?:r_test.c<CR>
nnoremap <leader>os :e %:s?tests?src?:s?_test??<CR>
```

---

## 📋 Recommended Workflow

1. **Open project**: `vim .` or `vim` then `<C-p>` to find files
2. **Navigate**: `gd` for definitions, `gr` for references, `<C-p>` for files
3. **Edit**: Use text objects, macros, and dot-repeat for efficiency
4. **Build**: `<leader>mk` or `<leader>mb` errors go to quickfix
5. **Fix errors**: `:cnext` to jump through errors, `]d` for LSP diagnostics
6. **Debug**: `<leader>t` for terminal, run GDB/OpenOCD
7. **Monitor**: Floaterm with serial console
8. **Commit**: `<leader>gs` for git status, stage hunks with `<leader>hs`

---

*"In embedded development, you're never more than one register write away from bricking your board. Vim's undo tree is your safety net."*
