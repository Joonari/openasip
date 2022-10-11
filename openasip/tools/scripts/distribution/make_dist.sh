#!/bin/sh
# Builds a .tar.gz out of the current tree, suitable
# for a release.

if ! bzr diff > /dev/null; 
then
    echo "Your TCE checkout must be clean to proceed."
    exit 1
fi

# A hack to ensure newlib dir is fresh and clean because
# it's packaged as-is.
rm -r newlib-1.17.0 && bzr revert newlib-1.17.0

# Similarly for the unit test directory. Its subidrs do not have 
# the EXTRA_DIST variables set so we'll just include the whole dir 
# recursively using the root Makefile.am's EXTRA_DIST.
rm -r test && bzr revert test

# Remove the test Makefiles from the configure.ac
sed -i '/## REMOVE FROM DIST START/,/## REMOVE FROM DIST END/d' configure.ac

echo "A dummy file that marks this a root of a distributed TCE release." > distro
./autogen.sh
./configure
make dist
rm -f distro

bzr revert configure.ac
