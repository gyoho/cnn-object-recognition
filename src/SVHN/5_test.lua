-- This script implements a test procedure, to report accuracy

require 'torch'
require 'xlua'
require 'optim'

print '==> defining test procedure'

-- test function
function test()
   local time = sys.clock()

   -- averaged param use
   if average then
      cachedparams = parameters:clone()
      parameters:copy(average)
   end   

   -- test over test data
   print('==> testing on test set:')
   for t = 1,testData:size() do
      -- disp progress
      xlua.progress(t, testData:size())

      -- get new sample
      local input = testData.data[t]
      if opt.type == 'double' then input = input:double()
      elseif opt.type == 'cuda' then input = input:cuda() end
      local target = testData.labels[t]

      -- test sample
      local pred = model:forward(input)
      confusion:add(pred, target)
   end

   -- time spent
   time = sys.clock() - time
   time = time / testData:size()
   print("\n==> time to test 1 sample = " .. (time*1000) .. 'ms')

   -- print confusion matrix
   print(confusion)

   -- update log/plot
   testLogger:add{['% mean class accuracy (test set)'] = confusion.totalValid * 100}
   if opt.plot then
      testLogger:style{['% mean class accuracy (test set)'] = '-'}
      testLogger:plot()
   end
  
   if average then
      -- restore parameters
      parameters:copy(cachedparams)
   end 

   -- next iteration:
   confusion:zero()
end
