Name:           thrift-sasl-cpp
Version:        0.1
Release:        1%{?dist}
Summary:        Thrift C++ Sasl Transport 
Group:          System Environment/Libraries
License:        Apache 2.0
URL:            https://github.com/hurdad/thrift-sasl-cpp
Source:         %{name}-%{version}.tar.gz      
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires:  gcc-c++
BuildRequires:  boost-devel
BuildRequires:  cyrus-sasl-devel

%description
Thrift C++ Sasl Transport 

%package devel
Summary:	%{name} c++ development package
Group:		Development/Libraries
Requires:	%{name} = %{version}

%description devel
C++ Development files for %{name}.

%prep
%setup -n %{name}-%{version}

%build
make

%install
rm -rf $RPM_BUILD_ROOT
make DESTDIR=$RPM_BUILD_ROOT PREFIX=/usr install

%clean
rm -rf $RPM_BUILD_ROOT

%post
ldconfig

%postun
ldconfig

%files
%defattr(-,root,root,-)
%doc README.md
%{_libdir}/libthrift-sasl.so

%files devel
%defattr(-,root,root,-)
%{_includedir}
%{_libdir}/libthrift-sasl.a

%changelog