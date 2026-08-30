class Gore < Formula
  desc "Batch orchestration CLI using Starlark scripts instead of shell"
  homepage "https://github.com/dsbitor/gore-releases"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.74/gore-0.1.74-darwin-arm64.tar.gz"
      sha256 "5a20695ae43d98ba692ae4ac9a356f7738934f97f1cf859d629d45686829d391"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.74/gore-0.1.74-linux-amd64.tar.gz"
      sha256 "5f2154846e69a42882370ce975a4ed0a51cf69a363024e0361d64c78ca810d86"
    end

    on_arm do
      url "https://github.com/dsbitor/gore-releases/releases/download/v0.1.74/gore-0.1.74-linux-arm64.tar.gz"
      sha256 "5767da0cfd4caee8cb521a3c9e7f5113865203a45ee6533aab7fd8e0136ee40d"
    end
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
  end

  test do
    assert_match "gore #{version}", shell_output("#{bin}/gore version")
  end
end
