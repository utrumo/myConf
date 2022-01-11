function onChangeCopy {
  cp $1 $2;
  while inotifywait -e close_write $1; do cp $1 $2; done
}

function doOnChange {
  cmd=$1;
  shift;
  $SHELL -c "$cmd";
  while inotifywait -e close_write $@; do $SHELL -c "$cmd"; done
}
