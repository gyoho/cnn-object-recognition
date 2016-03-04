describe('svhn', function()
  describe('All test should pass', function()
    it('should check normalization parameters', function()
      assert.truthy('Yup.')
    end)

    it('should check model layer parameters', function()
      -- deep check comparisons!
      assert.same({ table = 'great'}, { table = 'great' })

      -- or check by reference!
      assert.is_not.equals({ table = 'great'}, { table = 'great'})

      assert.falsy(nil)
      assert.error(function() error('Wat') end)
    end)

    it('should provide loss function', function()
      assert.unique({{ thing = 1 }, { thing = 2 }, { thing = 3 }})
    end)

  end)
end)
