import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-rate"
export default class extends Controller {
  static targets = ["start_date", "end_date", "rate", "info"];
  static values = { rate: Number };

  update() {
    const ratePerDay = parseInt(this.rateValue, 10);
    // make sure the user has chosen a start date and end date
    if (
      this.start_dateTarget.value !== "" &&
      this.end_dateTarget.value !== ""
    ) {
      // calculating the time from the values in the HTML
      const diffInMs =
        new Date(this.end_dateTarget.value) -
        new Date(this.start_dateTarget.value);
      const diffInDays = diffInMs / (1000 * 60 * 60 * 24);
      if (diffInDays > 0) {
        // displays the total rate per nigh
        this.infoTarget.innerText = `¥${ratePerDay} x ${diffInDays} nights`;
        this.rateTarget.innerHTML = `<span>¥${(
          diffInDays * ratePerDay
        ).toLocaleString()}</span> <small class='fw-light'>total</small> `;
        console.log(ratePerDay);

      } else if (diffInDays === 0) {
        // displays 1-night minimum if end date is same as start date
        this.infoTarget.innerText = "";
        this.rateTarget.innerHTML =
          "<span class='text-danger fw-light'>1-night mininum</span>";
      } else {
        // displays invalid if the end date is before the start or not overnight
        this.infoTarget.innerText = "";
        this.rateTarget.innerHTML =
          "<span class='text-danger fw-light'>Invalid dates</span>";
      }
    }
  }
}
