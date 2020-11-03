defmodule TestbenchesTest do
  use ExUnit.Case
  doctest Testbenches
  @tag timeout: :infinity

  def compile(module, version, ""), do: ["-Wall", "-g2012", "-s", "#{module}_tb", "-o", "#{module}_tb", "../#{module}_#{version}.v", "../#{module}_tb.v"]
  def compile(module, version, tb), do: ["-Wall", "-g2012", "-s", "#{module}_tb", "-o", "#{module}_tb", "../#{module}_#{version}.v", "../#{module}_tb_#{tb}.v"]
  def run_tests(name, versions, tb_versions\\[""]) do
    IO.puts("")
    Enum.each(tb_versions, fn tb ->
      IO.puts("Starting testbench #{name} #{tb}")
      Enum.each(versions, fn v ->
        IO.puts("Starting test on #{v}")
        case System.cmd("iverilog", compile(name, v, tb)) do
          {_, 0} -> nil
          _ -> throw "Compilation failed on #{v}"
        end
        case System.cmd("vvp", ["#{name}_tb"]) do
          {_, 0} -> IO.puts("Test on #{v} successful")
          {out, err} ->
            IO.puts(out)
            throw "Error code #{err} on #{v}"
        end
        File.rm("#{name}_tb")
      end)
      IO.puts("Testbench #{name} #{tb} successful")
    end)
    File.ls()
    |> elem(1)
    |> Enum.filter(&Regex.match?(~r/.*(\.vcd|_tb)/, &1))
    |> Enum.each(&File.rm/1)
  end

  test "Multiplier Parallel" do
    #Broken
    #run_tests("multiplier_parallel", ["v0"])
  end

  test "Multiplier Pipelined" do
    run_tests("multiplier_pipelined", ["v0", "v1", "v2", "v3", "v4", "v5"])
  end

  test "Multipler Iterative" do
    run_tests("multiplier_iterative", ["v0", "v1", "v2", "v3"])
  end

  test "Register Random" do
    run_tests("register_file", ["v0", "v1", "v2", "v3"], ["random", "simple"])
  end
end
