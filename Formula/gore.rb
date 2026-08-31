class Gore < Formula
  desc "Batch orchestration CLI using Starlark scripts instead of shell"
  homepage "https://github.com/dsbitor/gore-releases"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.95/gore-0.1.95-darwin-arm64.tar.gz"
      sha256 "1710b14e3be5098b0c58676c0b565a944ed2600e33e081a3bad2444768e9359f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.95/gore-0.1.95-linux-amd64.tar.gz"
      sha256 "cd2e03c664dd4ea3a00cd328414d6d5960cc04a306321d81972f706c26c87bf0"
    end

    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.95/gore-0.1.95-linux-arm64.tar.gz"
      sha256 "43007f413e838bc005499f877ae17dfcd2e4d631de62e72351ff0470abdc7d03"
    end
  end

  resource "prm" do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.95/gore-prm.pdf"
    sha256 "25a4517a9657c2d5d1edd0a58682d4d2da990897d0480aedeecf123a3a306f25"
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
