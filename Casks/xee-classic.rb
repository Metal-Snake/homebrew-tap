cask "xee-classic" do
  version "2.4.0"
  sha256 "e5886ed7194ceb172f3e725dfcf2a807aefe081952ddb1240efbab116b91f4f8"

  url "https://github.com/Metal-Snake/xee/releases/download/v#{version}/Xee-#{version}.zip"
  name "Xee"
  desc "Image viewer and browser for folders and archives"
  homepage "https://github.com/Metal-Snake/xee"

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
