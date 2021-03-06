# @summary Docker basic setup
#
# Docker basic setup
#
# @example
#   include dockerinstall::setup
class dockerinstall::setup (
  Boolean $manage_docker_certdir = $dockerinstall::manage_docker_certdir,
  Boolean $manage_docker_tlsdir  = $dockerinstall::manage_docker_tlsdir,
  Stdlib::Unixpath
          $docker_tlsdir         = $dockerinstall::params::docker_tlsdir,
  String  $docker_dir_ensure     = $dockerinstall::docker_dir_ensure,
) inherits dockerinstall::params
{
  file { '/etc/docker':
    ensure  => $docker_dir_ensure,
    recurse => true,
    force   => true,
  }

  if $manage_docker_certdir {
    file { '/etc/docker/certs.d':
      ensure => directory,
      owner  => 'root',
      mode   => '0700',
    }
  }

  if $manage_docker_tlsdir {
    file { $docker_tlsdir:
      ensure => directory,
      owner  => 'root',
      mode   => '0700',
    }
  }
}
