import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task"
export default class extends Controller {
  submit() {
    this.element.requestSubmit();
  }
}
