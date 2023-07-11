#!/bin/bash

screen_lock_cmd='~/scripts/other/swaylock.sh'

swayidle -w \
	timeout 300 $screen_lock_cmd \
	before-sleep $screen_lock_cmd
