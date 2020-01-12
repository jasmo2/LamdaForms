defmodule Ash.Oauth.Google do
  @google_user_profile "https://www.googleapis.com/oauth2/v3/userinfo"
  def get_info(token) do
    token
    |> get_user_profile # user
    |> normalize
  end

  @spec get_user_profile(String.t) :: String.t
  defp get_user_profile(token) do
    "#{@google_user_profile}?access_token=#{token}"
    |> HTTPoison.get()
    |> parse_body_response()
  end

  @spec parse_body_response({atom, String.t}) :: String.t
  defp parse_body_response({:error, err}), do: {:error, err}
  defp parse_body_response({:ok, response}) do
    body = Map.get(response, :body)
    if body == nil do
      {:error, :no_body}
    else # make keys of map atoms for easier access in templates
      {:ok, str_key_map} = Poison.decode(body)
      atom_key_map = for {key, val} <- str_key_map, into: %{},
        do: {String.to_atom(key), val}
      {:ok, atom_key_map}
    end # https://stackoverflow.com/questions/31990134
  end

  defp normalize({:ok, atom_key_map}) do
    IO.inspect "TCL: atom_key_map #{atom_key_map}"

    %{
      google_id: atom_key_map["id"],
      picture: atom_key_map["picture"],
      first_name: atom_key_map["first_name"],
      last_name: atom_key_map["last_name"],
      email: atom_key_map["email"]
    }
  end
end
