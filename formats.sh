for filename in *.md; do
  echo $filename
  # TODO: Counter of progress

  # Create PDFs
  pandoc --from=markdown+yaml_metadata_block --smart -o "$filename".pdf --latex-engine=xelatex $filename
  pandoc --from=markdown+yaml_metadata_block --smart -o "$filename".epub $filename



  # Create Individual PNGs
  #convert -density 72 -depth 8 -quality 85 pod/pdf/cards/products/accessories/"$(basename "$filename" .md)".pdf simulators/tabletop_simulator/cards/products/accessories/"$(basename "$filename" .md)".png
done
