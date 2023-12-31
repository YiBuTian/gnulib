#!/bin/sh

# Test whether a french locale is installed.
: "${LOCALE_FR=fr_FR}"
: "${LOCALE_FR_UTF8=fr_FR.UTF-8}"
if test $LOCALE_FR != none; then
  testlocale=$LOCALE_FR
else
  if test $LOCALE_FR_UTF8 != none; then
    testlocale=$LOCALE_FR_UTF8
  else
    if test -f /usr/bin/localedef; then
      echo "Skipping test: no french locale is installed"
    else
      echo "Skipping test: no french locale is supported"
    fi
    exit 77
  fi
fi

if $LC_NUMERIC_IMPLEMENTED; then
  :
else
  echo "Skipping test: LC_NUMERIC category of locales is not implemented"
  exit 77
fi

LC_ALL=$testlocale \
${CHECKER} ./test-vasnwprintf-posix2${EXEEXT}
