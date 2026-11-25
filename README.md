# Metal-Snake/homebrew-tap

Homebrew casks for [Mousecape](https://github.com/Metal-Snake/Mousecape), a cursor manager
for macOS 14 or later on Apple silicon.

```
brew tap metal-snake/tap
brew trust metal-snake/tap      # Homebrew 7 or later asks for this once
brew install --cask mousecape
```

This also links `mousecloak`, Mousecape's command line tool. Mousecape is signed with a
self-signed certificate and isn't notarized by Apple; the cask removes the quarantine flag
after installing, so macOS opens it (the same as `xattr -cr` by hand).

An upgrade stops Mousecape's background agent; if it is turned on in Mousecape's
Settings, the cask sets it up again, and it starts at the next login or when you open
Mousecape (Homebrew's sandbox can't start it).

`brew uninstall --cask mousecape` removes the app and its login agent;
`brew uninstall --zap --cask mousecape` also removes the cape library
(`~/Library/Application Support/Mousecape`) and Mousecape's own preferences.

Mousecape is free for personal, non-commercial use only; see its
[licence](https://github.com/Metal-Snake/Mousecape/blob/master/LICENSE).
