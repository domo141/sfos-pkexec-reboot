#
# There is probably a proper way (one-command-build after git clone)
# but I could not find a way to do it. The following worked for me...

# podman run --pull=never --rm -it --privileged -v $PWD:$PWD -w $PWD \
#            -h podman-container sailfishos-platform-sdk-aarch64:latest sudo \
#            rpmbuild --build-in-place -D "%_rpmdir $PWD" -bb *.spec

# Used podman pull docker.io/coderus/sailfishos-platform-sdk-aarch64
# to get that particular container image (2021-09-02).

Name:        pkexec-reboot
Summary:     Reboot or Poweroff via pkexec(1)
Version:     1.0
Release:     1
License:     BSD-2-Clause
Requires:    sailfishsilica-qt5 >= 0.10.9
Requires:    pyotherside-qml-plugin-python3-qt5
Requires:    libsailfishapp-launcher
BuildArch:   noarch
BuildRequires:  desktop-file-utils


%description
Reboot or Poweroff via pkexec(1)


%prep
cat "$0"
#env
#id
#%setup -q -n %{name}-%{version}
#%setup -q
#cp $OLDPWD/pwpingen* .


%build
# nothing to build -- even python is code embedded in qml

%install
set -euf
# protection around "user error" with --buildroot=$PWD (tried before
# --build-in-place) -- rpmbuild w/o sudo and container image default
# uid/gid saved me from deleting all files from current directory).
# "inverse logic" even though it is highly unlikely rm -rf fails...
test ! -f %{buildroot}/pkexec-reboot.qml && rm -rf %{buildroot} ||
rm -rf %{buildroot}%{_datadir}
mkdir -p %{buildroot}%{_datadir}/
mkdir %{buildroot}%{_datadir}/%{name}/ \
      %{buildroot}%{_datadir}/%{name}/qml/ \
      %{buildroot}%{_datadir}/applications/ \
      %{buildroot}%{_datadir}/icons/ \
      %{buildroot}%{_datadir}/icons/hicolor/ \
      %{buildroot}%{_datadir}/icons/hicolor/86x86/ \
      %{buildroot}%{_datadir}/icons/hicolor/86x86/apps/
install -m 755 pkexec-reboot.qml %{buildroot}%{_datadir}/%{name}/qml/.
install -m 644 pkexec-reboot.png \
        %{buildroot}%{_datadir}/icons/hicolor/86x86/apps/.
install -m 644 pkexec-reboot.desktop %{buildroot}%{_datadir}/applications/.

set +f
desktop-file-install --delete-original \
        --dir %{buildroot}%{_datadir}/applications \
        %{buildroot}%{_datadir}/applications/*.desktop


%clean
set -euf
# protection around "user error" with --buildroot=$PWD ...
test ! -f %{buildroot}/pkexec-reboot.qml && rm -rf %{buildroot} ||
rm -rf %{buildroot}%{_datadir}


%files
%defattr(-,root,root,-)
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/86x86/apps/%{name}.png
