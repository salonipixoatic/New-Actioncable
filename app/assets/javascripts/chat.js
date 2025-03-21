// import consumer from "../channels/consumer"
import consumer from "channels/consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log("connected")
  },
  received(data) {
    const messages = document.querySelector("#messages")
    messages.insertAdjacentHTML("beforeend", `<p>${data.content}</p>`)
    messages.lastElementChild.scrollIntoView({behavior: "smooth"})
  }
})