# Homebrew Tap for eBPF Guardian

This is a Homebrew tap for [eBPF Guardian](https://github.com/glnreddy421/ebpf-guardian), a Rust-based CLI tool for performing static semantic and behavioral analysis of eBPF programs.

## Installation

To install eBPF Guardian via Homebrew:

```bash
brew tap glnreddy421/ebpf-guardian
brew install ebpf-guardian
```

## Usage

After installation, you can use the `ebguard` command:

```bash
ebguard --help
ebguard scan --file ./path/to/program.o
```

For more information, see the [main project repository](https://github.com/glnreddy421/ebpf-guardian).