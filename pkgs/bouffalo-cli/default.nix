{ pkgs, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "bouffalo-cli";
  version = "0.0.2";

  src = fetchFromGitHub {
    owner = "mkroman";
    repo = "bouffalo-cli";
    rev = "v${version}";
    sha256 = "0qg4hnr5ddqc5xbigk2jrmfkc9knzrgzcdy6zizpymzpv7r6hk6x";
  };

  cargoSha256 = "sha256:0mg1vvai234m6y92axr2mx3jhpbdpin1cj3awj4ipkcspyn0bgd4";

  meta = with pkgs.lib; {
    description = "BL602 Boot ROM utility";
    homepage = "https://github.com/mkroman/bouffalo-cli";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ _0x4A6F ];
  };
}
