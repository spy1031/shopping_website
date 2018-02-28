namespace :dev do
  task fake_product: :environment do
    Product.destroy_all

    1000.times do 
      product = Product.new(
        name: FFaker::Product::product_name,
        description: FFaker::Lorem::sentence(30),
        price: 100+rand(1000),
        image: File.open(Rails.root.join("public/seed_img/#{rand(1..6)}.jpg"))
        )
      product.save!
      puts product.name
    end

  end




end