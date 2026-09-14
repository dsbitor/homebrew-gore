class Gore < Formula
  desc "Batch orchestration CLI using Starlark scripts instead of shell"
  homepage "https://github.com/dsbitor/gore-releases"
  license :cannot_represent

  on_macos do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.2.112/gore-0.2.112-darwin-arm64.tar.gz"
    sha256 "61db42e06d0949740f2b97c026b81ba3f3ce11a82af36f1fc919534cd6e9b443"
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.2.112/gore-0.2.112-linux-amd64.tar.gz"
      sha256 "6e3e616449c5c89ce9489697820bba7894685e10497d31e64e32e8891b33792c"
    end

    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.2.112/gore-0.2.112-linux-arm64.tar.gz"
      sha256 "299185cd27350e3a7b85075b489c339b6f4e3ae6f5e36747513830159a5d3f93"
    end
  end

  resource "prm" do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.2.112/gore-prm.pdf"
    sha256 "69f1697443f03c9c82f3f228a23f362ef61c5e24ae369807b2018c59639163a1"
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
