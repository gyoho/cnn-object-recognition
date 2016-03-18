mkdir val && mv ILSVRC2012_img_val.tar val/ && cd val
tar -xvf ILSVRC2012_img_val.tar && rm -f ILSVRC2012_img_val.tar
find . -name "*.tar" | while read NAME ; do mkdir -p "${NAME%.tar}"; tar -xvf "${NAME}" -C "${NAME%.tar}"; rm -f "${NAME}"; done
