cask "mousecape" do
  version "3.6.0"
  sha256 "a371169b2e43ec7a50bdb273e6f831abdd1052ac77e417a778c62098921f8d58"

  url "https://github.com/Metal-Snake/Mousecape/releases/download/v#{version}/Mousecape-#{version}.zip"
  name "Mousecape"
  desc "Cursor manager: apply, edit and import cursor themes"
  homepage "https://github.com/Metal-Snake/Mousecape"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Mousecape.app"
  binary "#{appdir}/Mousecape.app/Contents/MacOS/mousecloak"

  # The app is signed with a self-signed certificate and not notarized, so Gatekeeper
  # would block it. The README asks users to run the same command by hand.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Mousecape.app"],
        writable_paths: ["Mousecape.app"],
        writable_base:  :appdir
    # Homebrew runs the uninstall stanza on upgrades too, which removes the login agent.
    # This puts it back, running the new build, if it is turned on in Mousecape's Settings.
    run "{{appdir}}/Mousecape.app/Contents/MacOS/mousecloak",
        args:           ["--repair-agent"],
        must_succeed:   false,
        print_stdout:   true,
        writable_paths: [
          "Library/LaunchAgents",
          "Library/Logs/Mousecape",
          "Library/Application Support/Mousecape/Agent",
        ],
        writable_base:  :home
  end

  # The agent runs from a copy of mousecloak outside the app.
  uninstall_postflight_steps do
    remove "Library/Application Support/Mousecape/Agent/io.github.metal-snake.Mousecape",
           base:      :home,
           recursive: true
  end

  # launchctl also removes the agent's plist. Not `delete`, which runs with sudo.
  uninstall launchctl: "io.github.metal-snake.Mousecape.listener",
            quit:      "io.github.metal-snake.Mousecape"

  # The preferences domain com.alexzielenski.Mousecape is shared with the original
  # Mousecape, so it is left alone.
  zap trash: [
    "~/Library/Application Support/Mousecape",
    "~/Library/Logs/Mousecape",
    "~/Library/Preferences/io.github.metal-snake.Mousecape.plist",
  ]
end
