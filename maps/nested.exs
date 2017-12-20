defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %{}, details: "", severity: 1
end

iex(5)> report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}
%BugReport{details: "broken",
 owner: %Customer{company: "Pragmatic", name: "Dave"}, severity: 1}
iex(6)> report.owner.company
"Pragmatic"
iex(8)> put_in(report.owner.company, "PragProg")
%BugReport{details: "broken",
 owner: %Customer{company: "PragProg", name: "Dave"}, severity: 1}
iex(9)> update_in(report.owner.name, &("Mr. " <> &1))
%BugReport{details: "broken",
 owner: %Customer{company: "PragProg", name: "Mr. Dave"}, severity: 1}