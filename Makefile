#
# Build mock and local RPM versions of tools
#

MOCKS+=epel-6-i386
MOCKS+=epel-5-i386
MOCKS+=epel-4-i386

MOCKS+=epel-6-x86_64
MOCKS+=epel-5-x86_64
MOCKS+=epel-4-x86_64

all:: $(MOCKS)

srpm:: nagios-plugins-check_svn_repo.spec FORCE
	rm -f *.src.rpm
	rpmbuild --define '_sourcedir $(PWD)' \
		--define '_srcrpmdir $(PWD)' \
		-bs nagios-plugins-check_svn_repo.spec --nodeps

build:: srpm FORCE
	rpmbuild --rebuild nagios-plugins-check_svn_repo*.src.rpm

$(MOCKS):: nagios-plugins-check_svn_repo.spec FORCE
	rm -rf $@
	mock -r $@ --sources=$(PWD) --resultdir=$(PWD)/$@ \
		--buildsrpm --spec=nagios-plugins-check_svn_repo.spec
	name=`basename $@/*.src.rpm` && \
		/bin/mv $@/$$name $@.src.rpm && \
		rm -rf $@ && \
		mock -r $@ --resultdir=$(PWD)/$@ $@.src.rpm

mock:: $(MOCKS)

clean::
	rm -rf $(MOCKS)

realclean distclean:: clean
	rm -f *.src.rpm

FORCE:
