const express =require("express")
const collection=require("./mongo");
const router =express.Router();

router.post('/signup',async(req,res)=>{
    const {email,password}=req.body;
    const data = {
        email: email,
        password: password
    };

    try {
        const check = await collection.findOne({ email: email });

        if (check) {
            res.json("exist");
        } else {
            await collection.insertMany([data]);
            res.json("notexist");
        }
    } catch (e) {
        res.json("fail");
    }
})

router.post("/signin", async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await collection.findOne({ email: email, password: password });
        if (user) {
            res.json("exist");
        } else {
            res.json("notexist");
        }
    } catch (e) {
        res.json("fail");
    }
});

module.exports=router