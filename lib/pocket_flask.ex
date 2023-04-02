defmodule PocketFlask do
  @moduledoc """
  Documentation for `PocketFlask`.
  """
  alias Options.{CreateOpts, ListOpts, OneOpts, UpdateOpts}

  def get_list(collection_name, opts \\ %ListOpts{}) do
    Req.get(get_list_url(collection_name))
  end

  def get_list!(collection_name, opts \\ %ListOpts{}) do
    Req.get!(get_list_url(collection_name))
  end

  defp get_list_url(collection_name) do
    "#{rest_url()}/collections/#{collection_name}/records"
  end

  def get_one(collection_name, id, opts \\ %OneOpts{}) do
    Req.get(get_one_url(collection_name, id))
  end

  def get_one!(collection_name, id, opts \\ %OneOpts{}) do
    Req.get!(get_one_url(collection_name, id))
  end

  defp get_one_url(collection_name, id, opts \\ %OneOpts{}) do
    "#{rest_url()}/collections/#{collection_name}/records/#{id}"
  end

  def create(collection_name, data, opts \\ %Options.CreateOpts{}) do
    Req.post(create_url(collection_name, opts), json: data)
  end

  def create!(collection_name, data, opts \\ %Options.CreateOpts{}) do
    Req.post!(create_url(collection_name, opts), json: data)
  end

  defp create_url(collection_name, opts \\ %Options.CreateOpts{}) do
    "#{rest_url()}/collections/#{collection_name}/records"
  end

  def update(collection_name, id, data, opts \\ %UpdateOpts{}) do
    Req.patch(update_url(collection_name, id, opts), json: data)
  end

  def update!(collection_name, id, data, opts \\ %UpdateOpts{}) do
    Req.patch!(update_url(collection_name, id, opts), json: data)
  end

  defp update_url(collection_name, id, opts \\ %UpdateOpts{}) do
    "#{rest_url()}/collections/#{collection_name}/records/#{id}"
  end

  def delete(collection_name, id) do
    Req.delete(delete_url(collection_name, id))
  end

  def delete!(collection_name, id) do
    Req.delete!(delete_url(collection_name, id))
  end

  defp delete_url(collection_name, id) do
    "#{rest_url()}/collections/#{collection_name}/records/#{id}"
  end

  defp rest_url do
    Application.fetch_env!(:pocket_flask, :rest_url)
  end
end
