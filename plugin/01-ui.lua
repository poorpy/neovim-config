-- experimental built-in message/cmdline UI (replaces nvim-notify)
require("vim._core.ui2").enable {
    msg = {
        targets = { default = "cmd", progress = "msg" },
    },
}
