class EbpfGuardian < Formula
  desc "Rust-based CLI tool for performing static semantic and behavioral analysis of eBPF programs"
  homepage "https://github.com/glnreddy421/ebpf-guardian"
  url "https://github.com/glnreddy421/ebpf-guardian/releases/download/v0.1.0/ebpf-guardian-0.1.0-x86_64-apple-darwin.tar.gz"
  sha256 "be777811046e0ab12fabce035f1d1a896a981127f09090e82c09065616db61d1"
  version "0.1.0"
  license "MIT OR Apache-2.0"

  def install
    bin.install "ebguard"
  end

  test do
    system "#{bin}/ebguard", "--help"
  end
end