%define debug_package %{nil}

Summary:	Nagios Plugin for Subversion Repository
Name:		nagios-plugins-check_svn_repo
Version:	0.4
Release:	0.1%{?dist}
License:	GPLv1
Group:		Applications/System
URL:		http://exchange.nagios.org/directory/Plugins/Others/Check_Svn
Source0:	check_svn.txt
Requires:	nagios-plugins
Requires:	subversion
BuildArch:	noarch
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

%description
Checks a Subversion repository is online and accessible. Accepts
username/password credentials and can connect to any networked
subversion repository using either svn://, http:// or https://.

%prep

%build

%install
%{__rm} -rf %{buildroot}
echo SOURCE0: %{SOURCE0}
install -D -p -m 0755 %{SOURCE0} %{buildroot}%{_libdir}/nagios/plugins/check_svn_repo

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%{_libdir}/nagios/plugins/check_svn_repo

%changelog
* Mon Apr 16 2012 Nico Kadel-Garcia <nkadel@gmail.com> - 0.4
- Built from Nagios Exchange "Check_Svn" package
- Renamed 'check_svn_repo' to avoid confusion with working copy checks
