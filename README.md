# Metal-Snake/homebrew-tap

Homebrew casks for [Mousecape](https://github.com/Metal-Snake/Mousecape), a cursor manager
for macOS 14 or later on Apple silicon.

```
brew install --cask metal-snake/tap/mousecape
```

This also links `mousecloak`, Mousecape's command line tool. Mousecape is signed with a
self-signed certificate and isn't notarized by Apple; the cask removes the quarantine flag
after installing, so macOS opens it (the same as `xattr -cr` by hand).

`brew uninstall --cask mousecape` removes the app and its login agent;
`brew uninstall --zap --cask mousecape` also removes the cape library
(`~/Library/Application Support/Mousecape`).

Mousecape is free for personal, non-commercial use only; see its
[licence](https://github.com/Metal-Snake/Mousecape/blob/master/LICENSE).
