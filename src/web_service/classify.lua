-- Imagenet classification with Torch7 demo
--
require 'image'
require 'nn'
require 'cudnn'

-- Rescales and normalizes the image
function preprocess(im, img_mean)
  -- rescale the image
  local im3 = image.scale(im,224,224,'bilinear')
  -- subtract imagenet mean and divide by std
  for i=1,3 do im3[i]:add(-img_mean.mean[i]):div(img_mean.std[i]) end
  return im3
end

local image_url = arg[2]
local network_url = 'model_last_final.t7'
--local network_url = 'model_23.t7'
local image_name = 'jpegs/' .. paths.basename(image_url)
local network_name = paths.basename(network_url)
if not paths.filep(image_name) then os.execute('wget '..image_url..' -P jpegs/')   end
if not paths.filep(network_name) then os.execute('wget '..network_url)   end

--print '==> Loading network'
local net = torch.load(network_name):unpack():float()
net:evaluate()
--print(net)

--print '==> Loading synsets'
--print 'Loads mapping from net outputs to human readable labels'
local synset_words = {}
for line in io.lines'synset_words.txt' do table.insert(synset_words, line:sub(11)) end

--print '==> Loading image and imagenet mean'
local im = image.load(image_name)

--print '==> Preprocessing'
--print('ImageNet ', net.transform)
local I = preprocess(im, net.transform):view(1,3,224,224):float()

--print 'Propagate through the network, sort outputs in decreasing order and show 5 best classes'
local _,classes = net:forward(I):view(-1):sort(true)
local s=""
local comma =""
for i=1,5 do
  --print('predicted class '..tostring(i)..': ', synset_words[classes[i]] )
 	s = s .. comma .. synset_words[classes[i]]
	comma = "~~"
end
--print(s)
io.write(s)

os.execute('rm '..image_name)
