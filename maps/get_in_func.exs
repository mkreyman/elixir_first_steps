# There’s a cool trick that the dynamic versions of both get_in and get_and_update_in support—if you pass a
# function as a key, that function is invoked to return the corresponding values.

authors = [
  %{ name: "José", language: "Elixir" },
  %{ name: "Matz", language: "Ruby" },
  %{ name: "Larry", language: "Perl" }
]

languages_with_an_r = fn (:get, collection, next_fn) ->
  for row <- collection do
    if String.contains?(row.language, "r") do
      next_fn.(row)
    end
  end
end

IO.inspect get_in(authors, [languages_with_an_r, :name])
#=> [ "José", nil, "Larry" ]