defmodule PocketBaseInstaller do
  def download_and_run_pocketbase(force \\ false) do
    # remove zip if exists
    if File.exists?("pocketbase_*.zip") do
      File.rm("pocketbase_*.zip")
    end

    if !File.exists?("pocketbase") || force do
      os = :os.type()

      download_url =
        case os do
          {:unix, :linux} ->
            "https://github.com/pocketbase/pocketbase/releases/download/v0.14.2/pocketbase-linux.zip"

          {:unix, :darwin} ->
            "https://github.com/pocketbase/pocketbase/releases/download/v0.14.2/pocketbase_0.14.2_darwin_arm64.zip"

          {:win32, _} ->
            "https://github.com/pocketbase/pocketbase/releases/download/v0.14.2/pocketbase-windows.zip"

          _ ->
            IO.puts("Unsupported operating system.")
            System.halt(1)
        end

      File.rm("pocketbase_*.zip")
      File.rm("CHANGELOG.md")
      File.rm("LICENSE.md")
      # Download the correct PocketBase release
      System.cmd("wget", [download_url])

      # Extract the downloaded zip file
      System.cmd("unzip", ["pocketbase_*.zip"])
      File.rm("pocketbase_*.zip")
      File.rm("CHANGELOG.md")
      File.rm("LICENSE.md")
      File.rm("pocketbase_*.zip")
    end
  end
end

PocketBaseInstaller.download_and_run_pocketbase()
