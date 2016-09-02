defmodule Ectoservice.PagejsonView do
	use Ectoservice.Web, :view
	def render("user.json", %{pagejson: user}) do
		%{
			id: user.id,
			name: user.name,
			age: user.age,
			details: user.details
		}
	end
	def render("index.json", %{all: all}) do
		%{data: render_many(all, Ectoservice.PagejsonView, "user.json")}
	end
end