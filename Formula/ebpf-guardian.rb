class EbpfGuardian < Formula
  desc "Static analyzer for eBPF programs with security rule engine"
  homepage "https://github.com/ebpf-guardian/cli"
  url "https://github.com/ebpf-guardian/cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT OR Apache-2.0"
  head "https://github.com/ebpf-guardian/cli.git", branch: "main"

  depends_on "rust" => :build
  depends_on "llvm@17" => :recommended

  def install
    ENV["LLVM_SYS_170_PREFIX"] = Formula["llvm@17"].opt_prefix if build.with?("llvm@17")
    
    if build.with?("llvm@17")
      system "cargo", "install", *std_cargo_args(path: ".")
    else
      system "cargo", "install", *std_cargo_args(path: "."), "--no-default-features"
    end

    generate_completions_from_executable(bin/"ebguard", "completion")
  end

  option "without-llvm@17", "Build without LLVM features (limited functionality)"

  test do
    assert_match "ebguard", shell_output("#{bin}/ebguard --help")
    assert_match version.to_s, shell_output("#{bin}/ebguard --version")
    
    (testpath/"test-rules.yaml").write <<~EOS
      - id: test-rule
        name: Test Rule
        description: A simple test rule
        severity: low
        enabled: true
        condition:
          type: uses_helper
          helper_name: bpf_trace_printk
    EOS
    
    system bin/"ebguard", "validate-rules", "--file", testpath/"test-rules.yaml"
  end
end