defmodule Ectoservice.PageController do
  use Ectoservice.Web, :controller
  import Ectoservice.Router.Helpers
  import FFmpex
      @ibm_username Application.get_env(:ibm_watson, :username )
      @ibm_password Application.get_env(:ibm_watson, :password )
  alias Ectoservice.Endpoint
use FFmpex.Options

  def index(conn, _params) do
## >>> For number formation starting from 01,02,03 series
        IO.inspect l=1..12
            ss= for i <- l do
                    String.rjust(Integer.to_string(i),3, ?0)
                      end
          IO.inspect ss
     #x=Repo.get!(Ectoservice.Tranc,"pic")
     #IO.inspect changeset= (x, :tranc_by ,%{details: "no where to go",tranc_id: x.name})
    #  IO.inspect changeset1=Tranc_by.changeset(%Tranc_by{},changeset);
    # case Repo.insert(changeset)
    #   {:ok, _} ->
    #     conn
    #     |> put_flash(:info, "Role created successfully.")
    #     |> redirect(to: role_path(conn, :index))
    #   {:error, changeset} ->
    #       IO.inspect changeset.error
    # end
    ##  render conn, "index.html"
    #  redirect conn, to: role_mapping_path(conn, :delete, 17),request: :delete
    redirect conn, to: page_path(conn, :download, download: "phoenix.png")
    #  render conn, "index.html"
  end
  def testing(conn, %{"time" => name}) do

  render conn,"test.html" , testing: name

  end
def file_new do
 
 
end


  def file_audio(conn, _params)do

  render conn, "file.html", file: "Hello"
  end

  @doc """
 IBM Watson file recieve process
  """

        def file_receive(conn, %{"session" => file})do
              HTTPoison.start
                #  %{"session" => file} IO.inspect file
              IO.inspect   "============="
              IO.inspect   upload=file["roleid"]
              IO.inspect   extension = Path.extname(upload.filename)
              filename=Path.basename(upload.filename,extension)
              IO.inspect filename
              if extension === ".mp4" or extension === ".mov" or extension ===".avi" do
                conn
                |> put_flash(:info ,"Error file format #{extension} . Only support .mp4 , .mov and .avi")
                |> redirect(to: page_path(conn, :file_audio))
      end

IO.inspect   File.cp(upload.path, "../phoenixEcto/web/static/assets/video/#{upload.filename}")
command =
  FFmpex.new_command
  |> add_global_option(option_y)
  |> add_input_file("e:/temp Project/erlang/Phoenix/uploadPractice/phoenixEcto/web/static/assets/video/#{upload.filename}")
  |> add_output_file("e:/temp Project/erlang/Phoenix/uploadPractice/phoenixEcto/web/static/assets/video/#{filename}.mp3")
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
# IO.inspect  Poison.decode(HTTPoison.post!(url, {:file , "e:/temp Project/erlang/Phoenix/uploadPractice/phoenixEcto/priv/static/ssss1.flac" },headers, [{:timeout , 160000 },{:recv_timeout, 150000}] ).body)



# IO.inspect HTTPoison.post!("https://stream.watsonplatform.net/speech-to-text/api/v1/recognize",{:file, "d:/binary.flac"},[{"username", @ibm_username},{"password", @ibm_password},{"Content-Type","audio/flac"},{"modal","en-US_NarrowbandModel"}]).body
 # IO.inspect HTTPoison.post!("https://stream.watsonplatform.net/speech-to-text/api/v1/recognize",{:file, "d:/binary.flac"},[{"Content-Type","audio/flac"},{"modal","en-US_NarrowbandModel"}]).body

  # redirect conn, to: page_path(conn, :file_audio)
  redirect conn, to: page_path(conn, :download, "phoenix.png")

  end
  def download( conn, %{"download" => download }) do
      render conn, "download.html", download
  end

  defp auth_header(username, password) do
    encoded = Base.encode64("#{username}:#{password}")
    {"Authorization", "Basic #{encoded}"}

  end
  def show_data(conn, _params)do
  end
  def  error_dis(conn, %{"id" => id}  ) do
            error= start(String.to_integer(id))
      render conn, "error_file.html",  error: error 
  end
      def start (n) do
              try do
                x= "nothing"
                IO.puts raise_error(n)
                IO.puts "ge"
                # rescue 
                #   [FunctionClauseError , RuntimeError, KeyError] ->
                #    "no function match or runtime error"
                #   #   # error in [ArithmeticError] -> 
                #   #   #    "Uh-oh! ArithmeticError: #{error.message}"
                #   #   #   # raise error, [message: "too late, we're doomed" ]
                #      others_errors -> 
                #          "Disasters ! #{others_errors.message}"
                #         after
                #            "Done"
                # #  errors ->
                # #     "Error happened in  #{errors.message}"
                catch
                      # :exit, code -> "Exited with code #{inspect code}"
                      # :throw, value -> "throw called with #{inspect value}"
                      #:here
                     _error, message -> "Error occuring for #{inspect message}"
                        

              end
       end

            defp raise_error(0) do
                  IO.puts "No error"
            end
            defp raise_error(1) do
                   IO.puts "About to divide by zero"
                    1 / 0
            end
            defp raise_error(2) do
                   IO.puts "About to call a function that doesn't exist"
                    raise_error(99)
            end
            defp raise_error(3) do
                   IO.puts "About to try creating a directory with no permission"
                   File.mkdir!("/not_allowed")
            end
  end
