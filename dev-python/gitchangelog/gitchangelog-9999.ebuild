# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Creates a changelog from git log history"
HOMEPAGE="https://github.com/vaab/gitchangelog"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/vaab/gitchangelog.git"
	EGIT_BRANCH="master"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/vaab/gitchangelog/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE="test"

RDEPEND="${PYTHON_DEPS}
	dev-python/pystache[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
"

DEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/d2to1[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/minimock[${PYTHON_USEDEP}] )
"

python_test() {
	"${EPYTHON}" -m nose -sx . || die "Testing failed with ${EPYTHON}"
}