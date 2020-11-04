defmodule TestbenchesTest do
  use ExUnit.Case
  doctest Testbenches
  @moduletag timeout: :infinity

  def compile(module, version, ""), do: ["-Wall", "-g2012", "-s", "#{module}_tb", "-o", "#{module}_tb", "../#{module}_#{version}.v", "../#{module}_tb.v"]
  def compile(module, version, tb), do: ["-Wall", "-g2012", "-s", "#{module}_tb", "-o", "#{module}_tb", "../#{module}_#{version}.v", "../#{module}_tb_#{tb}.v"]
  def run_tests(name, versions, tb_versions\\[""]) do
    IO.puts("")
    Enum.each(tb_versions, fn tb ->
      IO.puts("Starting testbench #{name} #{tb}")
      Enum.each(versions, fn v ->
        IO.puts("Starting test on #{v}")

        # Run the compilation & elaboration

        case System.cmd("iverilog", compile(name, v, tb)) do
          {_, 0} -> nil
          _ -> flunk "Compilation failed on #{v}"
        end

        # As running ```./<verilog "binary">```
        # is an alias for ```vvp <verilog "binary>```
        # We pattern-match the return code
        # 0 is a successful test
        # Anything else is an error

        case System.cmd("vvp", ["#{name}_tb"]) do
          {_, 0} -> IO.puts("Test on #{name} #{v} successful")
          {out, err} ->
            IO.puts(out)
            flunk "Error code #{err} on #{name} #{v}"
        end
        File.rm("#{name}_tb")
      end)
      IO.puts("Testbench #{name} #{tb} successful")
    end)

    # If the program made it here there weren't any errors
    # So we tidy up after ourselves by deleting the files we generated
    # Pseudobinaries will end in _tb, and var dumps will end in .vcd
    # So we run a regex search for any of these in the current directory
    # And delete them.

    File.ls()
    |> elem(1)
    |> Enum.filter(&Regex.match?(~r/.*(\.vcd|_tb)/, &1))
    |> Enum.each(&File.rm/1)
  end

  test "Multiplier Parallel", do:
    run_tests("multiplier_parallel", ["v0"])

  test "Multiplier Pipelined", do:
    run_tests("multiplier_pipelined", ["v0", "v1", "v2", "v3", "v4"]) #, "v5"]) # v5 commented out as it takes over 5 minutes to run on my laptop.

  test "Multipler Iterative", do:
    run_tests("multiplier_iterative", ["v0", "v1", "v2", "v3"])

  test "Register Random", do:
    run_tests("register_file", ["v0", "v1", "v2", "v3"], ["random", "simple"])
end
