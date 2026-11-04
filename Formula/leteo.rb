# The formula pours the release binary rather than building it.
#
# Homebrew prefers a source build and this is the documented exception: a
# prebuilt archive with a checksum, which is what the release workflow already
# publishes for five targets. Building from source here would mean a Rust
# toolchain and several minutes on a machine that has neither reason.
class Leteo < Formula
  desc "Local-first persistent memory for AI coding agents"
  homepage "https://github.com/asanabrial/leteo"
  version "0.4.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.4.3/leteo-v0.4.3-aarch64-apple-darwin.tar.gz"
      sha256 "a746f28d814e36b412d58b7eda48909c7ad754c9a9432142c8215b8e30318aa1"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.4.3/leteo-v0.4.3-x86_64-apple-darwin.tar.gz"
      sha256 "d52f336ca8b10c3fc1b4194981b7b92e8bf8a291f4786c96afb9d8a86cd68aa1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.4.3/leteo-v0.4.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2cb1c7cbfabf0364207669d59b6187ee34c58ff3087f75c5cd0706fb586d94a2"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.4.3/leteo-v0.4.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e430cef132feeb735f08f86af92b7471853d635fbddad4d18ebda2526f860852"
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
