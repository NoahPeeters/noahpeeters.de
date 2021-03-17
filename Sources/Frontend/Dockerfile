# ================================
# Build image
# ================================
FROM ghcr.io/swiftwasm/carton:latest as build

# Install OS updates and, if needed, sqlite3
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
&& apt-get -q update \
&& apt-get -q dist-upgrade -y \
&& rm -rf /var/lib/apt/lists/*

# Set up a build area
WORKDIR /build

# First just resolve dependencies.
# This creates a cached layer that can be reused
# as long as your Package.swift/Package.resolved
# files do not change.
COPY ../../Package.* ./
RUN swift package resolve

# Copy entire repo into container
COPY ../.. .

# Build everything, with optimizations
carton bundle --product Frontend

# Switch to the staging area
WORKDIR /staging

# Copy bundle products to staging area
RUN cp /build/Bundle/* ./

# ================================
# Run image
# ================================
FROM httpd:2.4

# Make sure all system packages are up to date.
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && \
    apt-get -q update && apt-get -q dist-upgrade -y && rm -r /var/lib/apt/lists/*

# Copy built executable and any staged resources from builder
COPY --from=build  /staging /usr/local/apache2/htdocs
