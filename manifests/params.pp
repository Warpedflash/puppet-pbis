class pbis::params {

  # package options
  $repository            = 'http://localhost'
  $package               = 'pbis-open'
  $upgrade_package       = 'pbis-open-upgrade'
  $version               = '8.5.0.153'
  $service_name          = 'lwsmd'

  # domainjoin-cli options
  $ou                    = undef
  $enabled_modules       = undef
  $disabled_modules      = undef

  # PBIS configuration
  $assume_default_domain = false
  $create_home_dir       = true
  $home_dir_prefix       = '/home'
  $home_dir_umask        = '022'
  $home_dir_template     = '%H/local/%D/%U'
  $login_shell_template  = '/bin/sh'
  $require_membership_of = undef
  $skeleton_dirs         = '/etc/skel'
  $user_domain_prefix    = undef

  # update-dns options
  $dns_ipaddress         = undef
  $dns_ipv6address       = undef

  if !( $::architecture in ['amd64', 'x86_64', 'i386'] ) {
    fail("Unsupported architecture: ${::architecture}.")
  }

  # PBIS Open is packaged for Red Hat, Suse, and Debian derivatives.
  # When using Puppet's built-in fileserver, choose the .deb or .rpm 
  # automatically.

  # Get the packaging Format and Set the package installation provider
  case $::osfamily {
    'Debian':        {
      $package_file_provider = 'dpkg'
      $package_format = 'deb'
    }
    'RedHat','Suse': {
      $package_file_provider = 'rpm'
      $package_format = 'rpm'
    }
    default:         {
      fail("Unsupported operating system: ${::operatingsystem}.")
    }
  }

  # Build the file names.
  $package_file =
    "${package}-${version}.linux.${::architecture}.${package_format}.sh"
}