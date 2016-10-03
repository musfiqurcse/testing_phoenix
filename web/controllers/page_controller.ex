defmodule Ectoservice.PageController do
  use Ectoservice.Web, :controller
  import FFmpex
  @ibm_username Application.get_env(:ibm_watson, :username )
  @ibm_password Application.get_env(:ibm_watson, :password )
use FFmpex.Options

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
  def file_audio(conn, _params)do

  render conn, "file.html", file: "Hello"
  end
  def file_receive(conn, %{"session" => file})do
    HTTPoison.start
  #  %{"session" => file} IO.inspect file
IO.inspect "============="
IO.inspect upload=file["roleid"]
IO.inspect   extension = Path.extname(upload.filename)
IO.inspect   File.cp(upload.path, "../phoenixEcto/ssss#{extension}")
command =
  FFmpex.new_command
  |> add_global_option(option_y)
  |> add_input_file("e:/temp Project/erlang/Phoenix/uploadPractice/phoenixEcto/ssss#{extension}")
  |> add_output_file("e:/temp Project/erlang/Phoenix/uploadPractice/phoenixEcto/ssss1.flac")
    |> add_stream_specifier(stream_type: :audio)
      |> add_stream_option(option_b("64k"))
    |> add_file_option(option_maxrate("128k"))
    |> add_file_option(option_bufsize("64k"))

:ok = execute(command)
# IO.inspect "--------"
# IO.inspect audio=File.read!("../phoenixEcto/ssss1.flac")
# IO.inspect "================"
url="https://stream.watsonplatform.net/speech-to-text/api/v1/recognize"
# body = Poison.encode!(%{
#   "call": "MyCall",
#   "app_key": key,
#   "param": [
#     %{
#       "page": page,
#       "registres": registers,
#       "filter": filter
#     }
#   ]
# })
# headers = [{"Content-type", "application/flac"}]
#


IO.inspect auth = [hackney: [basic_auth: {@ibm_username, @ibm_password}]]

# IO.inspect HTTPoison.post(url,{:file, "d:/binary.flac"},%{},auth)content_type = "application/json"
IO.inspect "================="
    headers = [{"Content-type", "audio/flac"}]
    headers = case auth_header(@ibm_username,@ibm_password) do
      nil -> headers
      base64 -> [base64 | headers]
    end
     IO.inspect headers= headers++[{"modal","en-US_NarrowbandModel"}]
IO.inspect "================="
IO.inspect  Poison.decode(HTTPoison.post!(url, {:file , "e:/temp Project/erlang/Phoenix/uploadPractice/phoenixEcto/ssss1.flac" },headers, [{:timeout , 160000 },{:recv_timeout, 150000}] ).body)



# IO.inspect HTTPoison.post!("https://stream.watsonplatform.net/speech-to-text/api/v1/recognize",{:file, "d:/binary.flac"},[{"username", @ibm_username},{"password", @ibm_password},{"Content-Type","audio/flac"},{"modal","en-US_NarrowbandModel"}]).body
 # IO.inspect HTTPoison.post!("https://stream.watsonplatform.net/speech-to-text/api/v1/recognize",{:file, "d:/binary.flac"},[{"Content-Type","audio/flac"},{"modal","en-US_NarrowbandModel"}]).body

  redirect conn, to: page_path(conn, :file_audio)
  end

  defp auth_header(username, password) do
    encoded = Base.encode64("#{username}:#{password}")
    {"Authorization", "Basic #{encoded}"}
  end

end
