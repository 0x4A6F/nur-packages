{ lib
, rustPlatform
, fetchFromGitLab
, makeDesktopItem
, dejavu_fonts
, SDL2
, SDL2_ttf
}:

let

  pname = "freenukum";
  description = "Clone of the original Duke Nukum 1 Jump'n Run game";

  desktopItem = makeDesktopItem {
    desktopName = pname;
    name = pname;
    exec = pname;
    icon = pname;
    comment = description;
    categories = [ "Game" "ArcadeGame" "ActionGame" ];
    genericName = pname;
  };

in

rustPlatform.buildRustPackage rec {
  inherit pname;
  version = "0.3.5";

  src = fetchFromGitLab {
    owner = "silwol";
    repo = pname;
    rev = "v${version}";
    sha256 = "0yqfzh0c8fqk92q9kmidy15dc5li0ak1gbn3v7p3xw5fkrzf99gy";
  };

  cargoSha256 = "1mi98ccp4026gdc5x9jc6518zb7z4dplxl8vir78ivgdpifzz4pw";

  buildInputs = [
    SDL2
    SDL2_ttf
  ];

  postPatch = ''
    substituteInPlace src/graphics.rs \
      --replace /usr $out
  '';

  postInstall = ''
    mkdir -p $out/share/fonts/truetype/dejavu
    ln -sf \
      ${dejavu_fonts}/share/fonts/truetype/DejaVuSans.ttf \
      $out/share/fonts/truetype/dejavu/DejaVuSans.ttf
    mkdir -p $out/share/doc/freenukum
    install -Dm644 README.md CHANGELOG.md COPYING $out/share/doc/freenukum/
    install -Dm644 doc/freenukum.6 $out/share/man/man6/freenukum.6
    install -Dm644 "${desktopItem}/share/applications/"* -t $out/share/applications/
  '';

  meta = with lib; {
    description = "Clone of the original Duke Nukum 1 Jump'n Run game";
    homepage = "https://gitlab.com/silwol/freenukum";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ _0x4A6F ];
    platforms = platforms.unix;
  };
}
