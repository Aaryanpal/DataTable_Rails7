namespace :flipkart do

    task scrap_the_product: :environment do
        phone_url = "https://www.flipkart.com/search?sid=tyy%2C4io&otracker=CLP_Filters&p%5B%5D=facets.fulfilled_by%255B%255D%3DPlus%2B%2528FAssured%2529&page="
        laptop_url = "https://www.flipkart.com/laptops/~cs-zr9ty1tpfl/pr?sid=6bo%2Cb5g&collection-tab-name=Premium+Laptops&ctx=eyJjYXJkQ29udGV4dCI6eyJhdHRyaWJ1dGVzIjp7InRpdGxlIjp7Im11bHRpVmFsdWVkQXR0cmlidXRlIjp7ImtleSI6InRpdGxlIiwiaW5mZXJlbmNlVHlwZSI6IlRJVExFIiwidmFsdWVzIjpbIlByZW1pdW0gTGFwdG9wcyJdLCJ2YWx1ZVR5cGUiOiJNVUxUSV9WQUxVRUQifX19fX0%3D&wid=25.productCard.PMU_V2_3&page="
        tv_url = "https://www.flipkart.com/search?count=40&otracker=CLP_filters&p%5B%5D=facets.smart_tv%255B%255D%3DYes&p%5B%5D=facets.resolution%255B%255D%3DUltra%2BHD%2B%25284K%2529&sid=ckf%2Fczl&otracker=nmenu_sub_TVs%20and%20Appliances_0_Smart%20and%20Ultra%20HD&otracker=nmenu_sub_TVs%20%26%20Appliances_0_Smart%20%26%20Ultra%20HD&otracker=nmenu_sub_TVs%20%26%20Appliances_0_Smart%20%26%20Ultra%20HDpage="
        tablet_url = "https://www.flipkart.com/tablets/~apple-ipads/pr?sid=tyy,hry&otracker=nmenu_sub_Electronics_0_Apple%20iPads&otracker=nmenu_sub_Electronics_0_Apple%20iPads&page="
        water_purifier_url = "https://www.flipkart.com/water-purifiers/pr?sid=j9e%2Cabm%2Ci45&otracker=nmenu_sub_Appliances_0_Water%20Purifiers&otracker=nmenu_sub_TVs%20%26%20Appliances_0_Water%20Purifiers&otracker=nmenu_sub_TVs%20%26%20Appliances_0_Water%20Purifiers&otracker=nmenu_sub_TVs%20%26%20Appliances_0_Water%20Purifiers&otracker=nmenu_sub_TVs%20%26%20Appliances_0_Water%20Purifiers&page="
        x = Thread.new{scrapper_function(phone_url)}
        y = Thread.new{scrapper_function(laptop_url)}
        z = Thread.new{scrapper_function(tv_url)}
        k = Thread.new{scrapper_function(tablet_url)}
        l = Thread.new{scrapper_function(water_purifier_url)}
        x.join
        y.join
        z.join
        k.join
        l.join
    end

    def scrapper_function(uniq_url)
        5.times do |i|
            url = uniq_url + "#{i+1}"
            doc = Nokogiri::HTML(URI.open(url))
            index = doc.search('div._2kHMtA')
            categories = doc.search('h1._10Ermr').text
            index.each do |p|
                name = p.search('div._4rR01T').text
                current_price = p.search('div._25b18c').children[0].children.text.tr('₹,','').to_i
                actual_price = p.search('div._25b18c').children[1].nil? ? current_price : p.search('div._25b18c').children[1].children.text.tr('₹,','').to_i  
                discount = p.search('div._25b18c').children[2].nil? ? 0 : p.search('div._25b18c').children[2].children.text.tr('% off','').to_i 
                rating =   p.search('div._3LWZlK').children.text
                        # skip persisting job if it already exists in db
                        if Customer.where(name:name,categories:categories, current_price:current_price, actual_price:actual_price, discount:discount, rating:rating ).count <= 0
                            Customer.create(name:name,categories:categories,current_price:current_price, actual_price:actual_price, discount:discount, rating:rating )
                        puts 'Added: ' + (name ? name : '')
                        else
                        puts 'Skipped: ' + (name ? name : '')
                        end   
                end 
            end
    end
end