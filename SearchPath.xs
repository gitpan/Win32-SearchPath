#include <windows.h>
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"


MODULE = Win32::SearchPath		PACKAGE = Win32::SearchPath			


SV *
SearchPath(szName)
   const char *szName;

   PROTOTYPE: $

   CODE:
      DWORD dwRetn;
      char *pEnd = NULL;
      char  szOutPath[FILENAME_MAX+1];

      dwRetn = SearchPath (NULL, szName, ".exe", FILENAME_MAX, szOutPath, &pEnd);
      if (!dwRetn)        
          XSRETURN_UNDEF;          /* Return undef */
      
      RETVAL = newSVpvn (szOutPath, strlen(szOutPath));

   OUTPUT:
      RETVAL


