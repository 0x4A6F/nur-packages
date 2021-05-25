{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "routinator";
  version = "0.9.0-rc2";

  src = fetchFromGitHub {
    owner = "NLnetLabs";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-U4POuUpx7xjT0gUvk2hgHjObt8w8OLqVBZ/8J/Lyh9o=";
  };

  cargoSha256 = "sha256-b9pLmyLeGRt+RvkDCM5t8JL6GtDK2EhtV3XWLFmqUlE=";

  doInstallCheck = true;
  installCheckPhase = ''
    if [[ "$("$out/bin/${pname}" --version)" == "Routinator ${version}" ]]; then
      $out/bin/${pname} config | grep -q log
      echo '${pname} smoke check passed'
    else
      echo '${pname} smoke check failed'
      return 1
    fi
  '';

  meta = with lib; {
    description = "An RPKI Validator written in Rust";
    homepage = "https://github.com/NLnetLabs/routinator";
    license = licenses.bsd3;
    maintainers = with maintainers; [ _0x4A6F ];
    platforms = platforms.linux;
  };
}
