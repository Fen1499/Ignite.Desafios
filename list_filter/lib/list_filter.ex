defmodule ListFilter do

  #Por acaso eu tinha lido sobre enums e maps mais cedo
  def call(list) when is_list(list) do
    list
    |> Enum.filter(fn x -> is_number(x) end) #Muito parecido com aquele truque do js, () => function{}
    |> Enum.count(fn x -> Integer.mod(x,2) == 0 end) #Demorei um pouco pra encontrar o mod, ele não fica no kernel
  end

end
