# Metal-Snake/homebrew-tap

Homebrew casks for two macOS apps:

- [Mousecape](https://github.com/Metal-Snake/Mousecape), a cursor manager, for macOS 14 or
  later on Apple silicon.
- [Xee Classic](https://github.com/Metal-Snake/xee-classic), an image viewer and browser for
  folders and archives, for macOS 12 or later on Apple silicon and Intel.

```
brew tap metal-snake/tap
brew trust metal-snake/tap      # Homebrew 7 or later asks for this once
brew install --cask mousecape
brew install --cask xee-classic
```

Both apps aren't notarized by Apple; the casks remove the quarantine flag after
installing, so macOS opens them (the same as `xattr -cr` by hand).

## Mousecape

The cask also links `mousecloak`, Mousecape's command line tool. Mousecape is signed with
a self-signed certificate.

An upgrade stops Mousecape's background agent; if it is turned on in Mousecape's
Settings, the cask sets it up again, and it starts at the next login or when you open
Mousecape (Homebrew's sandbox can't start it).

`brew uninstall --cask mousecape` removes the app and its login agent;
`brew uninstall --zap --cask mousecape` also removes the cape library
(`~/Library/Application Support/Mousecape`) and Mousecape's own preferences.

Mousecape is free for personal, non-commercial use only; see its
[licence](https://github.com/Metal-Snake/Mousecape/blob/master/LICENSE).

## Xee Classic

The cask is called `xee-classic` because Homebrew's own `xee` cask installs Xee³, the
commercial successor. This is the open source Xee 2, maintained for current macOS.

Xee Classic keeps its settings under the same name as earlier Xee 2 versions, so they carry over.
`brew uninstall --zap --cask xee-classic` also removes those settings.

Xee was released into the public domain by its author, Dag Ågren.
