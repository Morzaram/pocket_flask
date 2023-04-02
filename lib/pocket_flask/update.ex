defmodule PocketFlask.Update do
  alias Options.UpdateOpts
  import PocketFlask

  def update(collection_name, id, data, opts \\ %UpdateOpts{}) do
    Req.patch(update_url(collection_name, id, opts), json: data)
  end

  def update!(collection_name, id, data, opts \\ %UpdateOpts{}) do
    Req.patch!(update_url(collection_name, id, opts), json: data)
  end

  defp update_url(collection_name, id, opts \\ %UpdateOpts{}) do
    "#{rest_url()}/collections/#{collection_name}/records/#{id}"
  end
end
