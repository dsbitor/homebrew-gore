class Gore < Formula
  desc "Batch orchestration CLI using Starlark scripts instead of shell"
  homepage "https://github.com/dsbitor/gore-releases"
  license :cannot_represent

  on_macos do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.3.114/gore-0.3.114-darwin-arm64.tar.gz"
    sha256 "158de65d6fd9fbd18125a64f53aca42bde22ea0ab9ee07e802e786c170c1233d"
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.3.114/gore-0.3.114-linux-amd64.tar.gz"
      sha256 "ed4ac21b07aa172df6fe125416c826513b37ffda475d39abbcd89384dbf38579"
    end

    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.3.114/gore-0.3.114-linux-arm64.tar.gz"
      sha256 "ba8a4600f090a900e342e944a4ee9b54573b70d869975919f3be8af749e6067b"
    end
  end

  resource "prm" do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.3.114/gore-prm.pdf"
    sha256 "818c0bee144f52c5acd8f471d5ed9adf250e2c2657344551247ea67185a04e0d"
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
