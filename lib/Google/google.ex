defmodule Google do
  use HTTPoison.Base
  @google_user_profile "https://www.googleapis.com/oauth2/v3/userinfo"
  @expected_fields ~w(
    sub name given_name family_name picture email email_verified locale
  )

  def process_request_url(token) do
    "#{@google_user_profile}?access_token=#{token}"
  end

  def process_response_body(body) do
    new_body = body
    |> Poison.decode!
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)

    new_body
  end

end
