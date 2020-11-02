defmodule TestbenchesTest do
  use ExUnit.Case
  doctest Testbenches

  def compile(name, extension, tb_extension), do: ["-Wall", "-g2012", "-s", "#{name}_tb", "-o", "#{name}_tb", "../"<>name<>"_"<>extension<>".v", "../"<>name<>"_tb#{if tb_extension != "", do: "_#{tb_extension}", else: ""}.v"]

  def run_tests(name, versions, tb_versions\\[""]) do
    Enum.each(tb_versions, fn tb ->
      IO.puts("Starting testbench #{name} #{tb}")
      Enum.each(versions, fn v ->
        IO.puts("Starting test on #{v}")
        case System.cmd("iverilog", compile(name, v, tb)) do
          {_, 0} -> nil
          {out, err} ->
            IO.puts(hd(compile(name, v, tb)))
            throw "Compilation failed on #{v}"
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
  end

  test "Multiplier Parallel" do
    # File doesn't exist
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
