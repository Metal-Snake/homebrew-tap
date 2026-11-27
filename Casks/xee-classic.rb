cask "xee-classic" do
  version "0.1.0"
  sha256 "03cc972ce4c24922221021029c5c9f21c356c8f1ead23173acc628dcf33aade0"

  url "https://github.com/Metal-Snake/xee-classic/releases/download/v#{version}/Xee-#{version}.zip"
  name "Xee"
  desc "Image viewer and browser for folders and archives"
  homepage "https://github.com/Metal-Snake/xee-classic"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Xee.app"

  # The app is only ad-hoc signed and not notarized, so Gatekeeper would block it.
  # The README tells users who download the zip to run the same command by hand.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Xee.app"],
        writable_paths: ["Xee.app"],
        writable_base:  :appdir
  end

  uninstall quit: "cx.c3.xee"

  # cx.c3.xee is the preferences domain of every Xee 2 release, so --zap also removes
  # settings left by older versions.
  zap trash: [
    "~/Library/Caches/cx.c3.xee",
    "~/Library/Preferences/cx.c3.xee.plist",
    "~/Library/Saved Application State/cx.c3.xee.savedState",
  ]
end
