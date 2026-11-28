cask "xee-classic" do
  version "0.2.0"
  sha256 "6fd91b167b5dc3dad4a1ddb2982ed5497a1687a84564707385fe82d06dda6a94"

  url "https://github.com/Metal-Snake/xee-classic/releases/download/v#{version}/Xee-Classic-#{version}.zip"
  name "Xee Classic"
  desc "Image viewer and browser for folders and archives"
  homepage "https://github.com/Metal-Snake/xee-classic"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Xee Classic.app"

  # The app is only ad-hoc signed and not notarized, so Gatekeeper would block it.
  # The README tells users who download the zip to run the same command by hand.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Xee Classic.app"],
        writable_paths: ["Xee Classic.app"],
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
