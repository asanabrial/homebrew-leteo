# The formula pours the release binary rather than building it.
#
# Homebrew prefers a source build and this is the documented exception: a
# prebuilt archive with a checksum, which is what the release workflow already
# publishes for five targets. Building from source here would mean a Rust
# toolchain and several minutes on a machine that has neither reason.
class Leteo < Formula
  desc "Local-first persistent memory for AI coding agents"
  homepage "https://github.com/asanabrial/leteo"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.5.0/leteo-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "6906f61cb8657a58d7a2e8e1a423cab5b0710d6264222da7344f7e4c301b74ec"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.5.0/leteo-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "021770ab70b751cca58dc7487e320e0983d3875a040869d30ef66af106f65785"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.5.0/leteo-v0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c706983bb46cfe721204a81844e0e275a032471b82af7ac0a82c97000fa8de22"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.5.0/leteo-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c83007d6ca0206155855c6efde70d0ad7a81ceaa52b5e64fadca2dc77983317d"
    end
  end

  # The archive holds a directory named after the release, so the binary is one
  # level down rather than at the root.
  def install
    bin.install Dir["leteo-v#{version}-*/leteo"].first => "leteo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leteo --version")
    # A store of its own under the test's sandbox, never the caller's: the
    # database path is explicit precisely so this cannot touch ~/.leteo.
    system bin/"leteo", "stats", "--database", testpath/"test.db"
  end
end
