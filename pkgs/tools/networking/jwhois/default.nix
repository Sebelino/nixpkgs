{stdenv, lynx, fetchurl}:

stdenv.mkDerivation {
  name = "jwhois-4.0";

  src = fetchurl {
    url = "mirror://gnu/jwhois/jwhois-4.0.tar.gz";
    sha256 = "0knn7iaj5v0n6jpmldyv2yk4bcy9dn3kywmv63bwc5drh9kvi6zs";
  };

  postInstall = ''
    ln -s jwhois $out/bin/whois
    sed -i -e "s|/usr/bin/lynx|${lynx}/bin/lynx|g" $out/etc/jwhois.conf
  '';

  patches = [ ./connect.patch ./service-name.patch ];

  makeFlags = [ "AR=${stdenv.cc.bintools.targetPrefix}ar" ];

  meta = {
    description = "A client for the WHOIS protocol allowing you to query the owner of a domain name";
    homepage = "https://www.gnu.org/software/jwhois/";
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.unix;
  };
}
