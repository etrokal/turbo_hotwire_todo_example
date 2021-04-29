import {Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["form"]
  static values = {url: String}

  toggle() {
    Rails.fire(this.formTarget, 'submit')
  }
}