json.extract! product, :id, :name, :categories, :current_price, :actual_price, :discount, :rating, :created_at, :updated_at
json.url product_url(product, format: :json)
