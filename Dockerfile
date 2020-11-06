# Build Scipy fork

# Upstream numpy image
ARG BASE=celsiustx/numpy
FROM $BASE

WORKDIR /opt/src

# Clone
RUN git clone --recurse-submodules https://github.com/celsiustx/scipy.git
WORKDIR scipy
RUN git remote add -f upstream https://github.com/scipy/scipy.git

# Checkout
ARG REF=origin/ctx
RUN git checkout $REF

# Install
RUN pip install -e .
RUN python setup.py build_ext --inplace

# Build (redundant with build_ext above?)
RUN python runtests.py -b

# Test
RUN python runtests.py

WORKDIR /

# Verify
RUN python -c 'import scipy.linalg'
RUN python -c 'import scipy.linalg._flinalg'
