FROM docker.io/bitnami/mediawiki:1.41.0
## Install some more packages
USER 0
RUN install_packages curl graphviz imagemagick
RUN cd /tmp && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl
# Revert to the original non-root user
USER 1001

## Install some more Mediawiki extension from here: https://extdist.wmflabs.org/dist/extensions/
RUN cd /opt/bitnami/mediawiki/extensions && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/Elastica-REL1_41-324bd77.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/MsUpload-REL1_41-bf77716.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/intersection-REL1_41-b29681a.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/PluggableAuth-REL1_41-0273c84.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/OpenIDConnect-REL1_41-7aa039e.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/SimpleSAMLphp-REL1_41-1af2e29.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/VEForAll-REL1_41-c9af2c5.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/HeaderTabs-REL1_41-dec6d3f.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/Lockdown-REL1_41-f86778d.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/LabeledSectionTransclusion-REL1_41-31068fc.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/PageForms-REL1_41-1a7f4a1.tar.gz | tar -xzf -

## Install more extensions using 'composer'
RUN cd /opt/bitnami/mediawiki && \
    # composer -q -n require --no-update mediawiki/semantic-bundle && \
    composer -q -n require --no-update mediawiki/semantic-media-wiki "~4.1" && \
    composer -q -n require --no-update mediawiki/semantic-result-formats "~4.1"  && \
    composer -q -n require --no-update phpoffice/phpspreadsheet "~1" && \
    composer -q -n require --no-update mediawiki/validator "2.2.*" && \
    composer -q -n update --no-dev

## Add some more stuff to the file system
# COPY rootfs /
