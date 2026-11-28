# JankyBorders fork by Metal-Snake, installed as the command "borders".
class Jankyborders < Formula
  desc "Window border system for macOS with themes and dark/light mode support"
  homepage "https://github.com/Metal-Snake/JankyBorders"
  url "https://github.com/Metal-Snake/JankyBorders/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "7ff9918f20214222f5b5eb3837ea8e7d09a1e4faa7caf88465cb059c649e9611"
  license "GPL-3.0-only"
  head "https://github.com/Metal-Snake/JankyBorders.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on macos: :sonoma

  conflicts_with "felixkratz/formulae/borders", because: "both install the `borders` command"

  # The makefile links private macOS frameworks (SkyLight); Homebrew's
  # compiler shims would get in the way.
  env :std

  def install
    ENV.delete("CFLAGS")
    ENV.delete("LDFLAGS")
    system "make"
    # Ad-hoc signature, so macOS keeps permissions such as Accessibility
    # attached to the same binary.
    system "codesign", "--force", "-s", "-", "bin/borders"
    bin.install "bin/borders"
    man1.install "docs/borders.1"
  end

  service do
    run opt_bin/"borders"
    environment_variables PATH: std_service_path_env, LANG: "en_US.UTF-8"
    keep_alive true
    process_type :interactive
    log_path var/"log/jankyborders/borders.out.log"
    error_log_path var/"log/jankyborders/borders.err.log"
  end

  def caveats
    <<~EOS
      Themes live in ~/.config/borders/themes; select one with
        borders --theme <name>
      An existing bordersrc is still read, but deprecated: move it into the
      themes folder. Old configuration scripts are converted, not run.
    EOS
  end

  test do
    assert_match "borders-v#{version}", shell_output("#{bin}/borders --version")
  end
end
