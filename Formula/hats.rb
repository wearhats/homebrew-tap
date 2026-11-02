class Hats < Formula
  desc "Run several Claude accounts side by side and see every running Claude"
  homepage "https://github.com/wearhats/hats"
  url "https://github.com/wearhats/hats/releases/download/v0.1.2/hats-macos-universal.tar.gz"
  sha256 "b3dc5a514e2809728958c100e51f4809767e0fff5fac764d307ccc50e6cb1105"
  license "MIT"
  head "https://github.com/wearhats/hats.git", branch: "main"

  depends_on macos: :sonoma

  def install
    if build.head?
      system "swift", "build", "--disable-sandbox", "-c", "release"
      bin.install ".build/release/hats"
    else
      bin.install "hats"
    end
  end

  def caveats
    <<~EOS
      Get started with:
        hats setup
      Launchers call #{HOMEBREW_PREFIX}/bin/hats, so they keep working across upgrades.
    EOS
  end

  test do
    assert_match "Run several Claude accounts", shell_output("#{bin}/hats --help")
  end
end
