import QtQuick

// The mouse's own back button, where a thumb already expects it.
//
// It reports rather than decides: `canGoBack` is the window's answer to
// whether there is anywhere to go, and the step itself is the caller's. The
// step wanted here is `back()` — the history — and not Escape's `goBack()`.
// Escape's job is everything a person could want out of: a query being typed,
// a selection, an open dock. A thumb reaching for the previous page has asked
// for the page, and a back button that also emptied the search field would be
// answering a question nobody put to it.
//
// The guard is not politeness. `back()` on an empty history closes the window,
// which is right for a Back that is only drawn when there is somewhere to go
// and wrong for a button sitting under the thumb whatever the window shows —
// unguarded, the second of two presses in the reader shuts the mailbox. A
// browser's back at the first page does nothing, and neither does this.
//
// Only `Qt.BackButton` is accepted, so every other button reaches whatever is
// under the pointer exactly as before. That is also why this may lie under the
// whole window: nothing above it accepts this button, so the press arrives
// here having passed everything else.
MouseArea {
  id: root

  objectName: "mouseBack"

  property bool canGoBack: false

  signal activated()

  acceptedButtons: Qt.BackButton

  onPressed: function(mouse) {
    if (root.canGoBack) root.activated()
    mouse.accepted = true
  }
}
