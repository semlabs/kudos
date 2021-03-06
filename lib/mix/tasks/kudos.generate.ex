defmodule Mix.Tasks.Kudos.Generate do
  use Mix.Task

  @shortdoc "Generates a licenses file"
  @recursive false

  def run(args \\ []) do
    IO.puts("Generating Licenses file...")

    resp =
      include_dev_deps?(args)
      |> Kudos.generate()
      |> handle_licenses(dry_run?(args))

    case resp do
      :ok -> IO.puts("Done!")
      _ -> IO.puts("Failed!")
    end
  end

  defp handle_licenses(content, true) do
    IO.puts(content)
    :ok
  end

  defp handle_licenses(content, false) do
    File.write("licenses.md", content)
  end

  defp dry_run?(args) do
    Enum.member?(args, "--dry-run")
  end

  defp include_dev_deps?(args) do
    Enum.member?(args, "--include-dev-deps")
  end
end
