require 'query_helper/finder'
require 'query_helper/query'
require 'query_helper/dataset_finder'
require 'query_helper/datasets_query'
require 'query_helper/inventories_query'
require 'query_helper/inventory_finder'
require 'query_helper/product_finder'
require 'query_helper/products_query'
require 'query_helper/store_finder'
require 'query_helper/stores_query'

module QueryHelper
  MIN_PER_PAGE = 5
  MAX_PER_PAGE = 100

  class NotFoundError < StandardError; end
  class NotImplementedError < StandardError; end
  class JsonpError < StandardError; end
  class BadQueryError < StandardError; end

  def self.is_float?(val)
    return false unless val
    return true if val.is_a?(Numeric)
    val =~ /\A\-{0,1}[0-9]+\.[0-9]+\Z/ ? true : false
  end

  def self.find(type, *args)
    { store:     StoreFinder,
      product:   ProductFinder,
      inventory: InventoryFinder,
      dataset:   DatasetFinder
    }[type].find(*args)
  end

  def self.query(type, request, params)
    { stores:              StoresQuery,
      store:               StoreFinder,
      products:            ProductsQuery,
      product:             ProductFinder,
      inventories:         InventoriesQuery,
      inventory:           InventoryFinder,
      datasets:            DatasetsQuery,
      dataset:             DatasetFinder,
    }[type].new(request, params)
  end
end
