package = "cnn-object-recognition"
version = "0.0-1"
source = {
  url = "git://github.com/gyoho/cnn-object-recognition",
  tag = "0.0.1"
}
description = {
   summary = "Object recognition using Convolutional neural network",
   homepage = "https://github.com/gyoho/cnn-object-recognition",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1",
   "busted >= 2.0"
}
build = {
   type = "builtin",
   modules = {
      svhn = "src/SVHN/doall.lua"
   }
}
