#!/usr/bin/env ruby

#Install in .bashrc
#PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\$(/home/daniel/bin/ncurses/bat.rb) - \u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

#Modify this line with your battery (sudo find /sys -name "BAT*")
bat = '/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/PNP0C0A:00/power_supply/BAT0'

full = '/charge_full'
now = '/charge_now'
present = '/present'
alarm = '/alarm'
status = '/status'

non='\033[00m'
bld='\033[01m'
red='\033[01;31m'
grn='\033[01;32m'
yel='\033[01;33m'


cfull = ''
cnow = ''
prst = '1'
stts = ''


if !( File.exist? bat )
  prst = '0'
end

if prst == '1'
  open( bat + full, 'r' ) do |cf|
    cfull = cf.read
  end

  open( bat + now, 'r' ) do |cn|
    cnow = cn.read
  end

  open( bat + present, 'r' ) do |pr|
    prst = pr.read.chop
  end

  open( bat + status, 'r' ) do |st|
    stts = st.read.chop
  end

  stts_leg = '(' + stts + ')'
end

level = ''
if prst == '1'
  level = cnow.to_i * 100 / cfull.to_i
  level = stts_leg + ' ' + level.to_s + '%'
else
  level = 'AC'
end

print level
