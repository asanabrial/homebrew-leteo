# The formula pours the release binary rather than building it.
#
# Homebrew prefers a source build and this is the documented exception: a
# prebuilt archive with a checksum, which is what the release workflow already
# publishes for five targets. Building from source here would mean a Rust
# toolchain and several minutes on a machine that has neither reason.
class Leteo < Formula
  desc "Local-first persistent memory for AI coding agents"
  homepage "https://github.com/asanabrial/leteo"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.1.2/leteo-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "6462706f05faf7c9d4ccc57e41cb438a157bb4c0f762ff06634408337e8e7a6f"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.1.2/leteo-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "0bfc6437a7f1756f41b522222bf12248d6bb836b489765bb1b858df29819199a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/asanabrial/leteo/releases/download/v0.1.2/leteo-v0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6de8796a4defb797429af08df7dca889dde454eff875c4af5e591029daeca007"
    end
    on_intel do
      url "https://github.com/asanabrial/leteo/releases/download/v0.1.2/leteo-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5a00a2be5d28de19b9aa1993d67ef7dc43dc774be673200e2af9c9c4f4197ec4"
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
