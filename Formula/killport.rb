class Killport < Formula
  desc "macOS menu bar app to kill listening ports with a click"
  homepage "https://github.com/caaarlxs/killport"
  url "https://github.com/caaarlxs/killport.git", tag: "v1.0.0"
  license "MIT"

  depends_on :macos
  depends_on :xcode => ["12.0", :build]

  def install
    system "swiftc", "-o", "killport", "KillPort.swift", "-framework", "AppKit", "-O"
    bin.install "killport"
  end

  service do
    run opt_bin/"killport"
    keep_alive false
    run_at_load true
    process_type :interactive
  end

  def caveats
    <<~EOS
      To start KillPort now and auto-start on login:
        brew services start killport

      To stop it:
        brew services stop killport

      Look for the network icon in your menu bar.
    EOS
  end

  test do
    assert_predicate bin/"killport", :executable?
  end
end
