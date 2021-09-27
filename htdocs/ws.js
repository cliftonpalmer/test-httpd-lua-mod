// @connect
// Connect to the websocket
var socket;
const connect = function() {
    return new Promise((resolve, reject) => {
        const socketProtocol = (window.location.protocol === 'https:' ? 'wss:' : 'ws:')
        const port = window.location.port;
        const socketUrl = `${socketProtocol}//${window.location.hostname}:${port}/ws/`

        // Define socket
        socket = new WebSocket(socketUrl);

        socket.onopen = (e) => {
            resolve();
        }

        socket.onmessage = (msg) => {
            console.log(msg)
        }

        socket.onerror = (e) => {
            console.log(e);
            resolve();

            // Try to connect again
            connect();
        }
    });
}

// finish
document.getElementById("send").onclick = function () {
    // new game, new session, etc
    socket.send("Here's a websocket message!")
};

connect();
