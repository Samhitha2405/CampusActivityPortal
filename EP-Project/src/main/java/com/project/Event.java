package com.project;

public class Event {
    private int id;
    private String title;
    private String description;
    private String date;
    private String location;
   

    public Event(int id, String title, String description, String date, String location) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.date = date;
        this.location=location;
        
    }

    // Getters and setters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public String getDate() { return date; }
    public String getLocation() {
    	return location;
    }
   
}
