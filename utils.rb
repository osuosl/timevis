def find_activity(activities, slug)
	activities.each do |activity|
	  if activity["slug"] == slug
	    return activity["name"]
	  end
	end
end