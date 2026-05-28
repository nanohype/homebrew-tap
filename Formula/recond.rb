# typed: false
# frozen_string_literal: true

# recond is a pure-Bash toolkit (architecture-independent), so this formula
# installs from the tagged source tarball rather than per-arch release binaries.
class Recond < Formula
  desc "Infrastructure reconnaissance CLI — DNS, TLS, HTTP, ports, CORS, WAF, takeover, and exposure scanning with security scoring"
  homepage "https://github.com/nanohype/recond"
  url "https://github.com/nanohype/recond/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "dd95443fb308bf80d84911e67793e45930adbe6d60dd582173147f385bcb6703"
  license "Apache-2.0"

  depends_on "bash"
  depends_on "bind" # provides dig
  depends_on "jq"
  depends_on "openssl@3"
  depends_on "whois"
  depends_on "yq"

  def install
    # Mirror the repo layout (bin/ lib/ etc/ as siblings) so recond resolves
    # its libraries relative to the symlinked entry point.
    libexec.install "bin", "lib", "etc"
    bin.install_symlink libexec/"bin/recond"
  end

  test do
    assert_match "recond version", shell_output("#{bin}/recond --version")
  end
end
