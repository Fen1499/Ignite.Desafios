defmodule GenReport do
  def call do
    File.read!("gen_report.csv")
  end
end
