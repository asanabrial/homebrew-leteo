# The formula pours the release binary rather than building it.
#
# Homebrew prefers a source build and this is the documented exception: a
# prebuilt archive with a checksum, which is what the release workflow already
# publishes for five targets. Building from source here would mean a Rust
# toolchain and several minutes on a machine that has neither reason.
class Leteo < Formula
  desc "Local-first persistent memory for AI coding agents"
  homepage "https://github.com/asanabrial/leteo"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.3.0/leteo-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "cebbb0438d544d81ed43716a77db476dac7cb5145275dbcf10cadfaed22d5070"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.3.0/leteo-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "51b0c5d7de208e7f2ba292627afbc7107a8a8fdc90a7f11e964714c85af699d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.3.0/leteo-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bb70595fd3a1fd2239d189bf46e0c4979471531f969353d4aef4646c18634e89"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.3.0/leteo-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "afd3e9a4e3c8f968ae3d59a2535778f205c5a42691a9fd371d782cadc85f6b32"
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
