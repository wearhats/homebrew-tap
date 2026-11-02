class Hats < Formula
  desc "Run several Claude accounts side by side and see every running Claude"
  homepage "https://github.com/wearhats/hats"
  url "https://github.com/wearhats/hats/releases/download/v0.1.0/hats-macos-universal.tar.gz"
  sha256 "2da5a31cee7b4c1d808e9d59a9060e802d9260d69276e9b540595c9938ac56d5"
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
