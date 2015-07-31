# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Global used to access variables from external places.
window.Application ||= {}

# HELPER FUNCTIONS #
delay = (ms, func) -> setTimeout func, ms

# CURSOR CLASS #
# Creates an object to track a location within the notes tree. #
class Cursor
  constructor: () ->
    @position_line = 0
    @position_char = 0

  # Movement methods
  move_up: ->
    if @position_line > 0
      @position_line--
    console.log("Moving up to " + @position_line)
    return

  move_down: ->
    @position_line++
    console.log("Moving down to " + @position_line)
    return

  move_left: ->
    if @position_char > 0
      @position_char--
    console.log("Moving left to " + @position_char)
    return

  move_right: ->
    @position_char++
    console.log("Moving right to " + @position_char)
    return

  # Create a new note nested under the current cursor position.
  new_note: ->
    current_div = document.getElementById("list_parent")
    new_div_id = @position_line++ #TODO: how do I handle new id's?

    # Create the new note html
    note = document.createElement("li")
    note.innerHTML = "A new note!"
    note.id = new_div_id

    # Add below the current note
    current_div.appendChild(note)

    console.log("Creating a new note at " + @position_line)

    return new_div_id

# KEYBOARD EVENTS #
notesKeyEvent = (e) ->
  key = e.keyCode or e.which
  console.log("Recieved key: " + key)

  switch key
    # Arrow Keys
    when 37 then Application.cursor.move_left()
    when 38 then Application.cursor.move_up()
    when 39 then Application.cursor.move_right()
    when 40 then Application.cursor.move_down()

  return

# AJAX REQUESTS #
sendAjaxCreate = (msg, callback) ->
  $.ajax(url: "/notes", type:'POST', data: {note:{'text':msg}}).done (res) ->
    console.log("RESPONSE: " + res)
    callback(res)

$(document).ready ->
  Application.cursor = new Cursor()
  Application.cursor.new_note()

  # Add events to html #
  notes_div = document.getElementById("notes_container")

  # Focus on the notes div and keep it there.
  notes_div.focus()
  notes_div.onblur = () -> delay(0, () -> notes_div.focus())

  # New note button
  document.getElementById("note_btn").onclick = () -> Application.cursor.new_note()

  # Keypress events for notes
  document.getElementById("notes_container").onkeypress = (event) -> notesKeyEvent(event)

  # Ajax button
  document.getElementById("ajax_btn").onclick = () ->
    sendAjaxCreate("AJAX FUNC!", (res) ->
      console.log("Callback!")
    )
    # $.ajax(url: "/notes", type:'POST', data: {note:{'text':'AJAX!'}}).done ->
    # console.log("finished creating note")

  return
