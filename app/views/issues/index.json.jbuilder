json.array!(@issues) do |issue|
  json.extract! issue, :year, :volume, :number
  json.url issue_url(issue, format: :json)
end
