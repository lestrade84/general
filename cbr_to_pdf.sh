#!/bin/bash

# Pre-requistes:
#    1. ImageMagick and unrar packages are required

# Cambio de espacios por guiones bajos en todos los .cbr
for fichero_cbr in *.cbr; do
        if [[ "$fichero_cbr" != "${fichero_cbr// /_}" ]]; then
                mv "$fichero_cbr" "${fichero_cbr// /_}"
        fi
done

# Descompresión, cambio de .JPG a .jpg (si es que hay .JPG) y conversión a PDF
for fichero_cbr in *.cbr; do
        unrar e $fichero_cbr
        for fichero_JPG in *.JPG; do
                mv "$fichero_JPG" "${fichero_JPG//.JPG/.jpg}" 2> /dev/null
        done
        convert *.jpg "${fichero_cbr//.cbr/.pdf}"
        rm $fichero_cbr
        rm *.jpg
done
