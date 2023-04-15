const fs = require("fs");

const main = async () => {
    const addr1 = "0x296714c6903ff6016A32d9E427E8ec29992e2210";
    const addr2 = "0x0D9FdD0B8C7B1208397AE1a0FB97462474FEd231";
    const addr3 = "0x6b21536Ede699579BB19d47303982a16CC9c1e06";

    // deploy
    const MemberNFT = await ethers.getContractFactory("MemberNFT");
    const memberNFT = await MemberNFT.deploy();
    await memberNFT.deployed();

    console.log(`Contract deployed to: ${memberNFT.address}`);

    // NFTをmintする
    let tx = await memberNFT.nftMint(addr1);
    await tx.wait();
    console.log("Fan#1 minted...");
    tx = await memberNFT.nftMint(addr1);
    await tx.wait();
    console.log("Fan#2 minted...");
    tx = await memberNFT.nftMint(addr2);
    await tx.wait();
    console.log("Fan#3 minted...");
    tx = await memberNFT.nftMint(addr2);
    await tx.wait();
    console.log("Fan#4 minted...");

    // コントラクトアドレスの書き出し
    fs.writeFileSync("./memberNFTContract.js",
    `
    module.exports = "${memberNFT.address}"
    `
    );
}

const memberNFTDeploy = async () => {
    try{
        await main();
        process.exit(0);
    } catch(err) {
        console.log(err);
        process.exit(1);
    }
};

memberNFTDeploy();