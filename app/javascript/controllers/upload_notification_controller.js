import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "input", "label" ]
    static classes = [ "notify" ]

    check() {
        if(this.inputTarget.files.length != 0) {
            this.labelTarget.classList.add(this.notifyClass)
        }
    }
}