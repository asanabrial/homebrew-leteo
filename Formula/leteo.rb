# The formula pours the release binary rather than building it.
#
# Homebrew prefers a source build and this is the documented exception: a
# prebuilt archive with a checksum, which is what the release workflow already
# publishes for five targets. Building from source here would mean a Rust
# toolchain and several minutes on a machine that has neither reason.
class Leteo < Formula
  desc "Local-first persistent memory for AI coding agents"
  homepage "https://github.com/asanabrial/leteo"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.4.2/leteo-v0.4.2-aarch64-apple-darwin.tar.gz"
      sha256 "6480f70e967ec9f7e3bd53669623a92fc6989af41857016929db8aaf2eb824e1"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.4.2/leteo-v0.4.2-x86_64-apple-darwin.tar.gz"
      sha256 "7de6d13a9b8ac25b3704819916360c61a70264413563f8a9a9e18349911391c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.4.2/leteo-v0.4.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5b7741cf1d778a9b84da5999533ce0589d4cc875255ebb4b16d2c0edc469f854"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.4.2/leteo-v0.4.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2fe5afce8ddaa6b422ffc55fd97b2874135eeedf1d773b6505132eb48c836dc5"
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
