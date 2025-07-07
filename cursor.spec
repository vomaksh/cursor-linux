Name:           cursor
Version: 1.2.1
Release:        1%{?dist}
Summary:        The AI Code Editor
License: 		Proprietary

%define _build_id_links none
%global debug_package %{nil}

Source0:        %{name}-%{version}.tar.gz

ExclusiveArch:  x86_64

BuildArch:      x86_64

%description
The AI Code Editor

%prep
%setup -q

%install
mkdir -p %{buildroot}/opt/cursor
cp -a * %{buildroot}/opt/cursor/

mkdir -p %{buildroot}/usr/share/cursor
mkdir -p %{buildroot}/usr/bin
cp * -ar ./usr/share/cursor/* %{buildroot}/usr/share/cursor/
cp -r %{buildroot}/usr/share/cursor/resources/linux/bin %{buildroot}/usr/share/cursor
chmod 755 %{buildroot}/usr/share/cursor/bin/cursor
ln -sf /usr/share/cursor/bin/cursor %{buildroot}/usr/bin/cursor

install -Dm0644 %{buildroot}/opt/cursor/cursor.desktop %{buildroot}/usr/share/applications/cursor.desktop
install -Dm0644 %{buildroot}/opt/cursor/co.anysphere.cursor.png %{buildroot}/usr/share/pixmaps/co.anysphere.cursor.png

rm -rf %{buildroot}/opt/cursor

%files
%attr(0755,root,root) /usr/bin/cursor
/usr/share/applications/cursor.desktop
/usr/share/pixmaps/co.anysphere.cursor.png
/usr/share/cursor
