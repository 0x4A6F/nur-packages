{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "zellij";
  version = "0.5.0-beta";

  src = fetchFromGitHub {
    owner = "zellij-org";
    repo = "zellij";
    rev = "v${version}";
    sha256 = "0mhxq0pr87lz36wfn3g9yvgx5k6xwf69yvvjvrm3vf1l6hwm9nf6";
  };

  cargoSha256 = "19465z1yv480hsx153nb7qz4hw1zp9wzqfm90sqsvp06zlpxps8g";

  doCheck = false;

  meta = with lib; {
    description = "A terminal workspace with batteries included";
    homepage = "https://github.com/zellij-org/zellij";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ _0x4A6F ];
  };
}
