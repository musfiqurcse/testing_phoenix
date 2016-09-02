defmodule Ectoservice.PagejsonController do
	use Ectoservice.Web, :controller 
	alias Ectoservice.User
	#Json Callling  demo process to the work
	def index(conn, _params) do
		allUser=Repo.all(User)
		render conn,"index.json", all: allUser
	end
	def testing(conn, _parms) do
		
	end
end