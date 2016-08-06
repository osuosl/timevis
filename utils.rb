def find_activity(activities, slug)
  activities.each do |activity|
    if activity['slug'] == slug
      return activity['name']
    end
  end
end

def find_project_slug(projects, name)
  projects.each do |project|
    if project['name'] == name
      return project['slugs'][0]
    end
  end
end

