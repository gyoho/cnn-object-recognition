local turbo = require "turbo"

local ImgRecHandler = class("ImgRecHandler", turbo.web.RequestHandler)
function ImgRecHandler:get()
    -- This handler takes one GET argument.
    self:write("Argument is: " .. self:get_argument("query"))
end

function ImgRecHandler:post()
    -- This handler takes one POST argument.
    -- self:write("Argument is: " .. self:get_argument("query"))
    local body = self:get_json()
self:set_status(200)
    local result_table = {} 
    result_table["name"] = classifyImg(self,body.url)["1"]
    self:write(turbo.escape.json_encode(result_table))	
end

function classifyImg(self,image_name)
    os.execute('th classify.lua -img '..image_name.. ' > result.txt')
    return get_predictions()	
end

function get_predictions()
	local fp = io.open('result.txt', "r")
	if fp == nil then
	  print("ERROR:Error opening file.")
	  -- TODO: Send 500
	  error(turbo.web.HTTPError(500, "Error while processing the image.")) 
	  os.exit(1)
	end
        
	local s = fp:read("*a")
	fp:close()
	print("["..os.date("%d-%m-%Y %I:%M:%S %p").."] " .. s)
	local pred={} ; i=1
	for str in string.gmatch(s, "([^~~]+)") do
                pred[i..""] = str
                i = i + 1
        end
	--turbo.log.debug(pred)
	return pred 
end

function createImageFile(self)
    local imgData = self:get_argument("img")
    local image_name = "img_"..os.time()..".jpg"
    local fp = io.open("jpegs/"..image_name,"w+")
    fp:write(imgData)
    fp:close()
    return image_name
end

local MultiPartImgRecHandler = class("MultiPartImgRecHandler" , turbo.web.RequestHandler)
function MultiPartImgRecHandler:post()
    self:add_header('Access-Control-Allow-Origin','*')
    local image_name = createImageFile(self)
    self:set_status(200)
    local result_table = {} 
    result_table["name"] = classifyImg(self,image_name)["1"]
    self:write(turbo.escape.json_encode(result_table))	
end

local HealthHandler = class("HealthHandler", turbo.web.RequestHandler)
function HealthHandler:get()
    -- This handler takes one GET argument.
    self:set_status(200)
    local result_table = {}
    result_table["time"] = os.date ("%A %I:%M %p, %d %B %Y")
    self:write(turbo.escape.json_encode(result_table))  
end


function MultiPartImgRecHandler:options()
     self:add_header('Access-Control-Allow-Methods', 'POST')
     self:add_header('Access-Control-Allow-Headers', 'multipart/form-data')
     self:add_header('Access-Control-Allow-Origin', '*')
   end


local port = 8080
turbo.web.Application():set_server_name("NeuralShift server v0.2")
turbo.web.Application({
    {"^/neuralshift/link/imgrec$", ImgRecHandler},
    {"^/health$", HealthHandler},
    {"^/neuralshift/data/imgrec$", MultiPartImgRecHandler},
    {"^/logs$", turbo.web.StaticFileHandler, "logs/server.log"},
    {"^/(.+)$", turbo.web.StaticFileHandler, "public/"},
    {"^/$", turbo.web.StaticFileHandler, "public/index.html"}
}):listen(port)
turbo.log.notice("Web server started on port: " .. port)
turbo.ioloop.instance():start()
