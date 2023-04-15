const fs = require("fs");
const memberNFTAddress = require("../memberNFTContract");

const main = async () => {
    const addr1 = "0x296714c6903ff6016A32d9E427E8ec29992e2210";
    const addr2 = "0x0D9FdD0B8C7B1208397AE1a0FB97462474FEd231";
    const addr3 = "0x6b21536Ede699579BB19d47303982a16CC9c1e06";
    const addr4 = "0x03eE3a8d5C9053d698cdEB43969a4149Eddb0776";

    // deploy
    const TokenBank = await ethers.getContractFactory("Tokenbank");
    const tokenBank = await TokenBank.deploy("TokenBank", "TBK", memberNFTAddress);
    await tokenBank.deployed();
    console.log(`Contract deployed to: ${tokenBank.address}`);

    // トークンを移転する
    let tx = await tokenBank.transfer(addr2, 300);
    await tx.wait();
    console.log("transferred to addr2");
    tx = await tokenBank.transfer(addr3, 200);
    await tx.wait();
    console.log("transferred to addr3");
    tx = await tokenBank.transfer(addr4, 100);
    await tx.wait();
    console.log("transferred to addr4");

    // Verifyで読み込むargument.jsを生成
    fs.writeFileSync("./argument.js",
    `
    module.exports = [
        "TokenBank",
        "TBK",
        "${memberNFTAddress}"
    ]
    `
    );

    // フロントエンドアプリが読み込むcontracts.jsを生成
    fs.writeFileSync("./contracts.js",
    `
    export const memberNFTAddress = "${memberNFTAddress}"
    export const tokenBankAddress = "${tokenBank.address}"
    `
    );
}


const tokenBankDeploy = async () => {
    try{
        await main();
        process.exit(0);
    } catch(err) {
        console.log(err);
        process.exit(1);
    }
};

tokenBankDeploy();