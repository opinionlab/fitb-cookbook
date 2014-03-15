#
# Cookbook Name:: fitb
# Recipe:: default
#
# Copyright 2014, OpinionLab, Inc.
#
# All rights reserved - Do Not Redistribute
#

# use proper package management for distro
case node["platform"]
  when "debian", "ubuntu"
    include_recipe "apt::default"
  when "redhat", "centos", "fedora"
    include_recipe "yum::default"
    include_recipe "yum::epel"
  end

include_recipe "fitb::_mysql"
include_recipe "fitb::_apache"
include_recipe "fitb::_fitb"
