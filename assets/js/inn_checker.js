let InnChecker = {
        init(socket) {
                if (!socket) {return}
                socket.connect()

                this._innInput     = document.getElementById("inn-input")
                this._innSubmit    = document.getElementById("inn-submit")
                this._innContainer = document.getElementById("inn-listing")
                this._lastInnId    = 0
                this._channel      = socket.channel("channel:inn", {last_inn_id: this._lastInnId})

                this._innSubmit.addEventListener("click", (e) => {
                        let payload = {
                                inn: this._innInput.value
                        }
                        this._channel.push("verify", payload)
                        this._innInput.value = ""
                })

                this._channel.on("new_inn", resp => {
                        this._lastInnId = resp.id
                        this.renderStatus(resp)
                })

                this._channel.join()
                        .receive("ok", resp => {
                                let ids = resp.inns.map(inn => inn.id)
                                if (ids.length > 0) {this._lastInnId = Math.max(...ids)}
                                resp.inns.forEach(inn => {this.renderStatus(inn)})
                                console.log("Joined successfully", resp)
                        })
                        .receive("error", resp => { console.log("Unable to join", resp) })
        },

        esc(str) {
                let div = document.createElement("div")
                div.appendChild(document.createTextNode(str))
                return div.innerHTML
        },

        renderStatus(inn) {
                let template = document.createElement("div")
                template.innerHTML = `${this.esc(inn.inn)}: ${this.esc(inn.status)}`
                this._innContainer.prepend(template)
        }
}

export default InnChecker