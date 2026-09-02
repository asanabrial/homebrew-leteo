# The formula pours the release binary rather than building it.
#
# Homebrew prefers a source build and this is the documented exception: a
# prebuilt archive with a checksum, which is what the release workflow already
# publishes for five targets. Building from source here would mean a Rust
# toolchain and several minutes on a machine that has neither reason.
class Leteo < Formula
  desc "Local-first persistent memory for AI coding agents"
  homepage "https://github.com/asanabrial/leteo"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.2.1/leteo-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "1606d9cc134e5ea916f0aea7ae41495e95545a843891a237e5e93a11042d737b"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.2.1/leteo-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "716a84da5c2835014b4c78f0de441ffc9fc5b19aacb99d2fbaa30478df405f5b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.2.1/leteo-v0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cc57ec4ca22d7de0b593e7cd78e78a71ef08e58554e6e57e2d65a9ebb6472855"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.2.1/leteo-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "27482a43e0dbbc6d83305267d9c54edf1d1b99414fd6c4c568a2e54d45358cad"
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
