cask "mousecape" do
  version "3.4.0"
  sha256 "72232b5e1285189b48d7d5b9df4667e879a4c25213c9d50c8e715370bdfa69f0"

  url "https://github.com/Metal-Snake/Mousecape/releases/download/v#{version}/Mousecape-#{version}.zip"
  name "Mousecape"
  desc "Cursor manager: apply, edit and import cursor themes"
  homepage "https://github.com/Metal-Snake/Mousecape"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Mousecape.app"
  binary "#{appdir}/Mousecape.app/Contents/MacOS/mousecloak"

  # The app is signed with a self-signed certificate and not notarized, so Gatekeeper
  # would block it. The README asks users to run the same command by hand.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Mousecape.app"]
  end

  uninstall launchctl: "io.github.metal-snake.Mousecape.listener",
            quit:      "io.github.metal-snake.Mousecape",
            delete:    "~/Library/LaunchAgents/io.github.metal-snake.Mousecape.listener.plist"

  # The preferences domain com.alexzielenski.Mousecape is shared with the original
  # Mousecape, so it is left alone.
  zap trash: [
    "~/Library/Application Support/Mousecape",
    "~/Library/Logs/Mousecape",
  ]
end
