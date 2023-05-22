pkgname=cherry-kde-theme
pkgver=1.6
pkgrel=2
pkgdesc="Clean, Flat, Δ Theme for KDE Plasma Desktop"
arch=('any')
url="https://github.com/nullxception/cherry-kde-theme"
license=('GPL3')
optdepends=('konsole: For the Konsole color scheme'
            'kvantum-qt5: For the Qt application style')
makedepends=('git')
options=(!strip)
source=("${pkgname}::git+${url}.git")
sha256sums=('SKIP')

pkgver() {
    cd "${pkgname}"
    git describe --long --tags | sed -r 's/([^-]*-g)/r\1/;s/-/./g'
}

package() {
    cd "${pkgname}"
    ./install.sh --prefix="${pkgdir}/usr" --clear-cache=false
}
