class Gore < Formula
  desc "Batch orchestration CLI using Starlark scripts instead of shell"
  homepage "https://github.com/dsbitor/gore-releases"
  license :cannot_represent

  on_macos do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.4.121/gore-0.4.121-darwin-arm64.tar.gz"
    sha256 "934a7a10eb088e4ee6d4203bca10cd39deccbde86aaeba0086aeb2eb24c223be"
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.4.121/gore-0.4.121-linux-amd64.tar.gz"
      sha256 "347c6636ab9f0bd4c6d3735b3ed722284e47486e463b4d2582b7072d2710d602"
    end

    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.4.121/gore-0.4.121-linux-arm64.tar.gz"
      sha256 "1d96865bd4dfeef686b94e85c524bbb230a4dcf092dbbd252f89249ad49854ad"
    end
  end

  resource "prm" do
    url "https://github.com/dsbitor/gore-releases/releases/download/v0.4.121/gore-prm.pdf"
    sha256 "2ac3d5fd16bf9235b87db31c5c5bd9ba27d4a12a71695d975758c12c355166c0"
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
