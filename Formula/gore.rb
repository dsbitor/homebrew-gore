class Gore < Formula
  desc "Batch orchestration CLI using Starlark scripts instead of shell"
  homepage "https://github.com/dsbitor/gore-releases"
  license :cannot_represent

  on_macos do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.4.133/gore-0.4.133-darwin-arm64.tar.gz"
    sha256 "a861df9a6f0e9ead189b8dc53911fe78629ae805410d84d19ca3c9ea57025b68"
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.4.133/gore-0.4.133-linux-amd64.tar.gz"
      sha256 "0a2bfc2aa9fcaecd4e6288d13f6cb2b1d6115b453a12955b952f3bc9434f73d4"
    end

    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.4.133/gore-0.4.133-linux-arm64.tar.gz"
      sha256 "d485b1c71a5b8d19a6b6f7f37ddc7c6cc41d0d90626f395b59937f8f17769573"
    end
  end

  resource "prm" do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.4.133/gore-prm.pdf"
    sha256 "f715de9ec474f41b506365efcc16e50760a5f8565f7ff9dd5dbfe0cf69050258"
  end

  def install
    binary_name = if OS.mac?
      "gore-darwin-arm64"
    elsif Hardware::CPU.arm?
      "gore-linux-arm64"
    else
      "gore-linux-amd64"
    end
    bin.install binary_name => "gore"

    resource("prm").stage do
      doc.install "gore-prm.pdf"
    end
  end

  def caveats
    <<~EOS
      The gore Programmer's Reference Manual (PDF) was installed to:
        #{doc}/gore-prm.pdf
    EOS
  end

  test do
    assert_match "gore #{version}", shell_output("#{bin}/gore version")
  end
end
