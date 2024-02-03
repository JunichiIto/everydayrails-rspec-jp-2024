import Rails from "@rails/ujs"
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task"
export default class extends Controller {
  submit() {
    Rails.fire(this.element, 'submit');
  }
}
