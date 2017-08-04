#
# http http://127.0.0.1:8880/product/fdas
# echo '{"age":22, "gender":"male", "name":{"first_name": "ross", "last_name":"crawford"}, "avatar_url":"https://lh3.googleusercontent.com/-UPgtz_Ljyz0/AAAAAAAAAAI/AAAAAAAAAAA/AMp5VUpYx_Tsj9SyVZFtCp1ZfX_LtJONEQ/s64-c-mo-md/photo.jpg"}' | http post http://127.0.0.1:8880/product/12
#
defmodule ProductModule.Router.Product do
  use Maru.Router

  namespace :product do
    route_param :slug do
      get do
        json(conn, %{ product: params[:slug] })
      end

      desc "description"
      params do
        requires :age,    type: Integer, values: 18..65
        requires :gender, type: Atom, values: [:male, :female], default: :female
        group    :name,   type: Map do
          requires :first_name
          requires :last_name
        end
        optional :intro,  type: String, regexp: ~r/^[a-z]+$/
        optional :avatar, type: File
        optional :avatar_url, type: String
        exactly_one_of [:avatar, :avatar_url]
      end
      post do
        json(conn, %{ product: params })
      end
      patch do
        json(conn, %{ product: :world })
      end
    end
  end
end


defmodule ProductModule.Router.Products do
  use Maru.Router

  get do
    json(conn, %{ products: [:product1,
                             :product2] })
  end

  mount ProductModule.Router.Product
end


defmodule ProductModule.API do
  use Maru.Router

  before do
    plug Plug.Logger
    plug Plug.Static, at: "/static", from: "/my/static/path/"
  end

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]
  
  mount ProductModule.Router.Products

  rescue_from Unauthorized, as: e do
    IO.inspect e

    conn
    |> put_status(401)
    |> text("Unauthorized")
  end

  rescue_from [MatchError, RuntimeError], with: :custom_error
  rescue_from :all , with: :custom_error
    
  defp custom_error(conn, exception) do
    conn
    |> put_status(500)
    |> text(exception.message)
  end
end