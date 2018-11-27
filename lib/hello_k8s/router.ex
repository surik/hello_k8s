defmodule HelloK8s.Router do
  use Plug.Router

  plug Plug.RequestId
  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json], pass: ["*/*"], json_decoder: Jason
  plug :match
  plug :dispatch

  get "/persons/:id" do
    case HelloK8s.Person.get(id) do
      nil -> send_resp(conn, 404, "Not Found")
      person ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(person))
    end
  end

  get "/persons" do
    persons = HelloK8s.Person.get()
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(persons))
  end

  delete "/persons/:id" do
    case HelloK8s.Person.delete(id) do
      :ok -> send_resp(conn, 201, "")
      {:error, :not_found} -> send_resp(conn, 404, "Not Found")
    end
  end

  post "/persons" do
    case HelloK8s.Person.insert(conn.body_params) do
      {:ok, %{id: id}} -> send_resp(conn, 201, Jason.encode!(%{id: id}))
      _ -> send_resp(conn, 400, "Bad request")
    end
  end

  get "/" do
    send_resp(conn, 200, "Ready")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
