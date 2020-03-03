#!/usr/bin/env sh

UMASK=$(which umask)
UMASK_SET=${UMASK_SET:-022}

if [[ ! -x $UMASK ]]; then
  echo "umask binary not found"
  exit 1
fi

echo $UMASK "$UMASK_SET"
$UMASK "$UMASK_SET"

CONFD=$(which confd)

if [[ ! -x $CONFD ]]; then
  echo "confd binary not found"
  exit 1
fi

echo $CONFD -onetime -backend env -log-level debug
$CONFD -onetime -backend env -log-level debug || exit 1

PDNS_RECURSOR=$(which pdns_recursor)
if [[ ! -x $PDNS_RECURSOR ]]; then
  echo "pdns_recursor binary not found"
  exit 1
fi

echo ${*:-${PDNS_RECURSOR}}
exec ${*:-${PDNS_RECURSOR}}