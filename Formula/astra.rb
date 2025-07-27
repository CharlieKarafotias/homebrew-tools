class Astra < Formula
    desc "Astra is a powerful daily wallpaper generator that brings stunning, high-quality wallpapers to your desktop"
    homepage "https://github.com/CharlieKarafotias/astra"
    version "1.0.2"
    url "https://github.com/CharlieKarafotias/astra/archive/refs/tags/v1.0.2.tar.gz"
    sha256 "beb8bf011bda47fdd5d8c4210408c38d044b2181ed85e657bf35426e5801e6b3"
    license "MIT"

    depends_on "rust" => :build

    def install
        system "cargo", "build", "--release"
        bin.install "target/release/astra"

        # Generate and install completions
        bash_output = Utils.safe_popen_read("#{bin}/astra", "generate-completions", "bash")
        (bash_completion/"astra").write bash_output

        zsh_output = Utils.safe_popen_read("#{bin}/astra", "generate-completions", "zsh")
        (zsh_completion/"_astra").write zsh_output

        fish_output = Utils.safe_popen_read("#{bin}/astra", "generate-completions", "fish")
        (fish_completion/"astra.fish").write fish_output
    end

    test do
        system "#{bin}/astra", "--version"
    end
end