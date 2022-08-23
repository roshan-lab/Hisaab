const server=require("ws").Server;
const wss=new server({port:8000});

wss.on("connection",e=>{
    e.on("message",msg=>{
        msg=msg.toString();

    })
})