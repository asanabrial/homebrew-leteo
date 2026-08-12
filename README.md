# Homebrew tap for Leteo

[Leteo](https://github.com/asanabrial/leteo) is local-first persistent memory
for AI coding agents: one Rust binary over one SQLite database.

```sh
brew install asanabrial/leteo/leteo
```

Or tap first, if you would rather type less afterwards:

```sh
brew tap asanabrial/leteo
brew install leteo
```

## What this repository is

One formula, and a workflow that keeps it current. The formula pours the
release binary rather than building it — Homebrew's documented exception for a
prebuilt archive with a checksum, which is what Leteo's release workflow
already publishes for five targets. Building from source here would ask for a
Rust toolchain and several minutes from a machine with no reason to have
either.

Everything else — what Leteo is, how it works, what it promises — lives in
[the main repository](https://github.com/asanabrial/leteo). A tap that
duplicates a README is a tap with a second copy to keep true.

## Why a tap and not homebrew-core

`homebrew-core` requires a formula to build from source or to install
platform-independent output; a binary-only formula belongs in a tap or a cask.
It also asks for notability that a project of this age does not have yet. The
tap costs the user one longer command and nothing else, and it can move to
core later without anybody's install breaking.
