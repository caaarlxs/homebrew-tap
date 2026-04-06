class KillportApp < Formula
  desc "macOS menu bar app to kill listening ports with a click"
  homepage "https://github.com/caaarlxs/killport"
  url "https://github.com/caaarlxs/killport.git", tag: "v1.0.0"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-o", "killport-app", "KillPort.swift", "-framework", "AppKit", "-O"
    bin.install "killport-app"
  end

  service do
    run opt_bin/"killport-app"
    keep_alive false
    run_at_load true
    process_type :interactive
  end

  def caveats
    <<~EOS
      To start KillPort and auto-start on login:
        brew services start killport-app

      To stop it:
        brew services stop killport-app

      Look for the network icon in your menu bar.
    EOS
  end

  test do
    assert_predicate bin/"killport-app", :executable?
  end
end
