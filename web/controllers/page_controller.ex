defmodule Ectoservice.PageController do
  use Ectoservice.Web, :controller

  def index(conn, _params) do
## >>> For number formation starting from 01,02,03 series
        IO.inspect l=1..12
            ss= for i <- l do
                    String.rjust(Integer.to_string(i),3, ?0)
                      end
          IO.inspect ss


     #x=Repo.get!(Ectoservice.Tranc,"pic")
     #IO.inspect changeset=build_assoc(x, :tranc_by ,%{details: "no where to go",tranc_id: x.name})
  #   IO.inspect changeset1=Tranc_by.changeset(%Tranc_by{},changeset);
    # case Repo.insert(changeset)
    #   {:ok, _} ->
    #     conn
    #     |> put_flash(:info, "Role created successfully.")
    #     |> redirect(to: role_path(conn, :index))
    #   {:error, changeset} ->
    #       IO.inspect changeset.error
    # end
    ##  render conn, "index.html"
    render conn, "index.html"
  end
end
