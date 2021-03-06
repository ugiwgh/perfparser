
isEmpty(PERFPARSER_APP_DESTDIR): PERFPARSER_APP_DESTDIR = $$shadowed($$PWD)/bin
isEmpty(PERFPARSER_ELFUTILS_DESTDIR): PERFPARSER_ELFUTILS_DESTDIR = $$shadowed($$PWD)/lib
isEmpty(PERFPARSER_ELFUTILS_BACKENDS_DESTDIR) {
    PERFPARSER_ELFUTILS_BACKENDS_DESTDIR = $$PERFPARSER_ELFUTILS_DESTDIR/elfutils
}

isEmpty(PERFPARSER_INSTALLDIR_PREFIX): PERFPARSER_INSTALLDIR_PREFIX = /usr/local
isEmpty(PERFPARSER_APP_INSTALLDIR): PERFPARSER_APP_INSTALLDIR = $$PERFPARSER_INSTALLDIR_PREFIX/bin
isEmpty(PERFPARSER_ELFUTILS_INSTALLDIR) {
    PERFPARSER_ELFUTILS_INSTALLDIR = $$PERFPARSER_INSTALLDIR_PREFIX/lib
}
isEmpty(PERFPARSER_ELFUTILS_BACKENDS_INSTALLDIR) {
    PERFPARSER_ELFUTILS_BACKENDS_INSTALLDIR = $$PERFPARSER_ELFUTILS_INSTALLDIR/elfutils
}

defineReplace(libraryName) {
   RET = $$1$$qtPlatformTargetSuffix()
   win32 {
      VERSION_LIST = $$split(VERSION, .)
      RET = $$RET$$first(VERSION_LIST)
   }
   return($$RET)
}

defineReplace(libraryRefName) {
   RET = $$1$$qtPlatformTargetSuffix()
   win32: RET = $$RET$$2
   return($$RET)
}
