class Gore < Formula
  desc "Batch orchestration CLI using Starlark scripts instead of shell"
  homepage "https://github.com/dsbitor/gore-releases"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.77/gore-0.1.77-darwin-arm64.tar.gz"
      sha256 "3305500882d6c640acc2bb3b4d00e2cf2e05a95e25c457c4e9c3750fbd945467"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.77/gore-0.1.77-linux-amd64.tar.gz"
      sha256 "6bd775d4aa0ca86cbeb9d866e2002d62fd7d2beb02fb1f21a6071453eaaedf5f"
    end

    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.77/gore-0.1.77-linux-arm64.tar.gz"
      sha256 "8914cef14a309880b4b0135aa77676b78ff210e616e8acb2d620194ea72b5b99"
    end
  end

  resource "prm" do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.77/gore-prm.pdf"
    sha256 "a7b3354435cff60af7190037a6e27a042f6d816d9ca0a36fca8de6103d821066"
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
