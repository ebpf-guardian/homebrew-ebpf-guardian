class EbpfGuardian < Formula
  desc "Static analyzer for eBPF programs with security rule engine"
  homepage "https://github.com/ebpf-guardian/cli"
  url "https://github.com/ebpf-guardian/cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT OR Apache-2.0"

  depends_on "rust" => :build
  depends_on "llvm@17" => :recommended

  def install
    if build.with?("llvm@17")
      ENV["LLVM_SYS_170_PREFIX"] = Formula["llvm@17"].opt_prefix
      system "cargo", "install", *std_cargo_args(path: ".")
    else
      ohai "Building without LLVM features (limited functionality)"
      system "cargo", "install", *std_cargo_args(path: "."), "--no-default-features"
    end
  end

  def caveats
    return unless build.without?("llvm@17")

    <<~EOS
      This build was compiled without LLVM features.
      
      Available features:
        ✅ Analyze existing eBPF object files (.o)
        ✅ Control flow graph analysis
        ✅ Security rule engine
        ✅ JSON/table output
        
      Missing features:
        ❌ Cannot build from C source files
        ❌ Advanced LLVM optimizations
        
      To get full functionality:
        brew uninstall ebpf-guardian
        brew install llvm@17
        brew install ebpf-guardian
    EOS
  end

  test do
    assert_match "ebguard", shell_output("#{bin}/ebguard --help")
    assert_match version.to_s, shell_output("#{bin}/ebguard --version")
  end
end