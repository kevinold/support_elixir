defmodule Support.RegistrationController do
  use Support.Web, :controller

  alias Support.User

  def new(conn, _params) do
    changeset = User.changeset(%User{}, :register)
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, :register, user_params)
    #IO.inspect changeset

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Registered Successfully")
        |> put_session(:current_user, user.id)
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:errro, "Error")
        |> render("new.html", changeset: changeset)
    end
  end
end
