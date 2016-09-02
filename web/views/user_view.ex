defmodule Ectoservice.UserView do
     use Ectoservice.Web, :view
     alias FirstProject.User
    @doc """
      def first_name( %User{name: name} ) do
      name
      |> String.split(" ")
      |> Enum.at(0)
      end
      """

      def render("text.json", %{user: users})do
      	%{value: render_many(users, Ectoservice.UserView, "user.json")}
      end
      def render("user.json",%{user: user})do
      	%{
      		id: user.id,
      		details: user.details,
      		name: user.name, 
      		age: user.age
      	}
      end
end
