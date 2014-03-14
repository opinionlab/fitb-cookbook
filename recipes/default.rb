#
# Cookbook Name:: fitb
# Recipe:: default
#
# Copyright 2014, OpinionLab, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "fitb::_mysql"
include_recipe "fitb::_apache"
include_recipe "fitb::_fitb"
