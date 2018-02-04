module ProductsController
  def products_index_action
    product_hashs = get_request("/products")
    products = Product.convert_hashs(product_hashs)

    products_index_view(products)
  end

  def products_show_action
    input_id = products_id_form

    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)

    products_show_view(product)

    puts "Press enter to continue or type 'o' to add to cart"
    user_choice = gets.chomp
    if user_choice == 'o'
      print "Enter a quantity to order: "
      input_quantity = gets.chomp
      client_params = {
                       quantity: input_quantity,
                       product_id: input_id
                      }
      # json_data = post_request("/orders", client_params)

      response = Unirest.post("http://localhost:3000/carted_products", parameters: client_params)

      if response.code == 200
        puts JSON.pretty_generate(response.body)
      elsif response.code == 401
        puts "Nope, try logging in first"
      end
    end
  end

  def products_create_action
    client_params = products_new_form
    response = Unirest.post("http://localhost:3000/products", parameters: client_params)

    if response.code == 200
      product = Product.new(response.body)
      products_show_view(product)
    elsif response.code == 422
      errors = response.body["errors"]
      products_errors_view(errors)
    elsif response.code == 401
      puts JSON.pretty_generate(response.body)
    end
  end

  def products_update_action
    input_id = products_id_form
    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)

    client_params = products_update_form(product)
    response = Unirest.patch("http://localhost:3000/products/#{input_id}", parameters: client_params)

    if response.code == 200
      product = Product.new(response.body)
      products_show_view(product)
    elsif response.code == 422
      errors = response.body["errors"]
      products_errors_view(errors)
    elsif response.code == 401
      puts JSON.pretty_generate(response.body)
    end
  end

  def products_destroy_action
    input_id = products_id_form

    json_data = delete_request("/products/#{input_id}")
    puts json_data["message"]
  end

  def products_search_action
    print "Enter a name to search by: "
    search_term = gets.chomp

    product_hashs = get_request("/products?search=#{search_term}")
    products = Product.convert_hashs(product_hashs)

    products_index_view(products)
  end

  def products_sort_action(attribute)
    product_hashs = get_request("/products?sort=#{attribute}")
    products = Product.convert_hashs(product_hashs)

    products_index_view(products)
  end

  # def carted_products_create_action
  #   client_params = carted_products_form
  #   response = Unirest.post("http://localhost:3000/carted_products", parameters: client_params)

  #   if response.code == 200
  #     product = Product.new(response.body)
  #     products
  #   end
  # end

  def carted_products_index_action
    carted_products_hash = get_request("/carted_products")        
    products = Product.convert_hashs(carted_products_hash)

    carted_products_index_action(carted_products)
  end
end













# module ProductsController
#   def products_index_action
#     product_hashs = get_request("/products")
#     products = Product.convert_hashs(product_hashs)

#     products_index_view(products)
#   end

#   def products_show_action
#     input_id = products_id_form

#     product_hash = get_request("/products/#{input_id}")
#     product = Product.new(product_hash)

#     products_show_view(product)
#   end

#   def products_create_action
#     client_params = products_new_form
#     json_data = post_request("/products", client_params)

#     if !json_data["errors"]
#       product = Product.new(json_data)
#       products_show_view(product)
#     else
#       errors = json_data["errors"]
#       products_errors_view(errors)
#     end
#   end

#   def products_update_action
#     input_id = products_id_form
#     product_hash = get_request("/products/#{input_id}")
#     product = Product.new(product_hash)

#     client_params = products_update_form(product)
#     json_data = patch_request("/products/#{input_id}", client_params)

#     if !json_data["errors"]
#       product = Product.new(json_data)
#       products_show_view(product)
#     else
#       errors = json_data["errors"]
#       products_errors_view(errors)
#     end
#   end

#   def products_destroy_action
#     input_id = products_id_form

#     json_data = delete_request("/products/#{input_id}")
#     puts json_data["message"]
#   end

#   def products_search_action
#     print "Enter a name to search by: "
#     search_term = gets.chomp

#     product_hashs = get_request("/products?search=#{search_term}")
#     products = Product.convert_hashs(product_hashs)

#     products_index_view(products)
#   end

#   def products_sort_action(attribute)
#     product_hashs = get_request("/products?sort=#{attribute}")
#     products = Product.convert_hashs(product_hashs)

#     products_index_view(products)
#   end
# end


































# module ProductsController
#   # def user_create_action 
#   #   client_params = users_new_form
#   #   response = Unirest.post(
#   #                           "http://localhost:3000/products", parameters: client_params
#   #                           )
#   #   user_hash = post_request("/users",client_params)

#   #   if response.code == 200
#   #     user_hash = response.body
#   #     user = User.new(user_hash)
#   #     users_show_view(user)
#   #   else
#   #     errors = response.body["errors"]
#   #     users_errors_view(errors)
#   #   end
#   # end

#   def products_index_action
#     product_hashs = get_request("/products")
#     products = Product.convert_hashs(product_hashs)

#     products_index_view(products)
#   end

#   def products_show_action
#     input_id = products_id_form

#     product_hash = get_request("/products/#{input_id}")
#     product = Product.new(product_hash)

#     products_show_view(product)
#   end

#   def products_create_action
#     client_params = products_new_form
#     response = Unirest.post(
#                             "http://localhost:3000/products",
#                             parameters: client_params
#                             )

#     product_hash = post_request("/product", client_params)

#     if response.code == 200
#       product_hash = response.body
#       product = Product.new(product_hash)
#       products_show_view(product)
#     else
#       errors = response.body["errors"]
#       products_errors_view(errors)
#     end
#   end

#   def products_update_action
#     input_id = products_id_form
#     product_hash = get_request("/products/#{input_id}")
#     product = Product.new(product_hash)

#     client_params = products_update_form(product)
#     response = Unirest.patch(
#                             "http://localhost:3000/products/#{input_id}",
#                             parameters: client_params
#                             )

#     if response.code == 200
#       product_hash = response.body
#       product = Product.new(product_hash)
#       products_show_view(product)
#     else
#       errors = response.body["errors"]
#       products_errors_view(errors)
#     end
#   end

#   def products_destroy_action
#     input_id = products_id_form

#     response = Unirest.delete("http://localhost:3000/products/#{input_id}")
#     data = response.body
#     puts data["message"]
#   end

#   def products_search_action
#     print "Enter a name to search by: "
#     search_term = gets.chomp

#     product_hashs = get_request("/products?search=#{search_term}")
#     products = Product.convert_hashs(product_hashs)

#     products_index_view(products)
#   end

#   def products_sort_action(attribute)
#     product_hashs = get_request("/products?sort=#{attribute}")
#     products = Product.convert_hashs(product_hashs)

#     products_index_view(products)
#   end
# end