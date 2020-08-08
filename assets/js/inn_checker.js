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
                        this.setDangerAlert()
                        this._channel.push("verify", payload)
                                        .receive("error", (err) => this.setDangerAlert(err.reason))
                        this._innInput.value = ""
                })

                this._channel.on("new_inn", resp => {
                        this._lastInnId = resp.id
                        let template = this.renderStatus(resp)
                        this._innContainer.prepend(template)
                })

                this._channel.join()
                        .receive("ok", resp => {
                                let ids = resp.inns.map(inn => inn.id)
                                if (ids.length > 0) {this._lastInnId = Math.max(...ids)}
                                resp.inns.forEach(inn => {
                                        let template = this.renderStatus(inn)
                                        this._innContainer.appendChild(template)
                                })
                                console.log("Joined successfully", resp)
                        })
                        .receive("error", resp => { console.log("Unable to join", resp) })
        },

        esc(str) {
                let div = document.createElement("div")
                div.appendChild(document.createTextNode(str))
                return div.innerHTML
        },

        setDangerAlert(text) {
                let alert = document.getElementsByClassName("alert-danger")[0]
                if (text) {
                        alert.innerText = this.esc(text)
                } else {
                        alert.innerText = ""
                }
        },

        renderStatus(inn) {
                let template = document.createElement("div")
                template.innerHTML = `[${this.esc(inn.updated_at)}] ${this.esc(inn.inn)}: ${this.esc(inn.status)}`
                return template
        }
}

export default InnChecker