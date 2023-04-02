defmodule PocketFlask do
  @moduledoc """
  Documentation for `PocketFlask`.
  """
  alias Options.{CreateOpts, ListOpts, OneOpts, UpdateOpts}
  defdelegate create(collection_name, data, opts \\ %CreateOpts{}), to: PocketFlask.Create
  defdelegate create!(collection_name, data, opts \\ %CreateOpts{}), to: PocketFlask.Create
  defdelegate get_list(collection_name, opts \\ %ListOpts{}), to: PocketFlask.GetList
  defdelegate get_list!(collection_name, opts \\ %ListOpts{}), to: PocketFlask.GetList
  defdelegate get_one(collection_name, id, opts \\ %OneOpts{}), to: PocketFlask.GetOne
  defdelegate get_one!(collection_name, id, opts \\ %OneOpts{}), to: PocketFlask.GetOne
  defdelegate update(collection_name, id, data, opts \\ %UpdateOpts{}), to: PocketFlask.Update
  defdelegate update!(collection_name, id, data, opts \\ %UpdateOpts{}), to: PocketFlask.Update
  defdelegate delete(collection_name, id), to: PocketFlask.Delete
  defdelegate delete!(collection_name, id), to: PocketFlask.Delete

  @doc """
  Documentation for `RestUrl`.
  """

  def rest_url do
    Application.fetch_env!(:pocket_flask, :rest_url)
  end
end
