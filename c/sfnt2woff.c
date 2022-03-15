
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "sfnt2woff.h"
#include "woff.h"

static void reportErr(uint32_t status) {
  woffPrintStatus(stderr, status, "### ");
  exit(2);
}

const uint8_t *sfnt2woff(const uint8_t *sfntData, uint32_t sfntLen,
                         uint32_t *woffLen) {
  unsigned int maj = 0, min = 0;
  uint32_t status = eWOFF_ok;

  //  uint32_t woffLen;
  const uint8_t *woffData =
      woffEncode(sfntData, sfntLen, maj, min, woffLen, &status);

  // free((void *)sfntData);
  if (WOFF_FAILURE(status)) {
    reportErr(status);
  }

  if (WOFF_WARNING(status)) {
    woffPrintStatus(stderr, status, "### ");
  }
  return woffData;
}
