import { Controller } from "@hotwired/stimulus";
import $ from "jquery";
import "select2";

export default class extends Controller {
  connect() {
    $(this.element).select2({
      width: "100%",
      placeholder: "Select a pokemon"
    });

    // Fixing auto focus on the select2 field
    $(document).on('select2:open', () => {
      document.querySelector('.select2-search__field').focus();
    });
  }
}
