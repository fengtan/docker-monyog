#!/bin/bash
# Monyog provides no option to run in the foreground.
# The workaround is to run it through this wrapper.
# See https://unix.stackexchange.com/questions/354444/how-to-force-a-program-to-run-in-the-foreground
perl -MPOSIX -le '
  require "syscall.ph";
  syscall(&SYS_prctl,36,1) >= 0 or die "cannot set subreaper: $!";
  if (!fork) {
    exec @ARGV;
    exit(127);
  }
  # now reporting on all children and grand-children:
  while (($pid = wait) > 0) {
   print "$pid: " . WEXITSTATUS($?)
  }' $1
