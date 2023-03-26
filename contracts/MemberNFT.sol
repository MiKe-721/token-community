// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract MemberNFT is ERC721Enumerable, ERC721URIStorage, Ownable{
    /**
     * @dev
     * - _tokenIdsはCountersの全関数が利用可能
     */
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    /**
     * @dev
     * - 色の構造体定義、配列変数colorsを定義
     */
    struct Color {
        string name;
        string code;
    }

    Color[] public colors;


    /**
     * @dev
     * - 誰にどのtokenId,URIをmintしたかを記録する
     */
    event TokenURIChanged(address indexed to, uint256 indexed tokenId);


    /**
     * @dev
     * - 変数配列colorsに色データをpush
     */
    constructor() ERC721("MemberNFT","MEM") {
        colors.push(Color("Yellow","#ffff00"));
        colors.push(Color("Whitesmoke","#f5f5f5"));
        colors.push(Color("Blue","#0000ff"));
        colors.push(Color("Pink","#ffc0cb"));
        colors.push(Color("Green","#008000"));
        colors.push(Color("Gold","#FFD700"));
        colors.push(Color("Purple","#800080"));
        colors.push(Color("Light Green","#90EE90"));
        colors.push(Color("Orange","#FFA500"));
        colors.push(Color("Gray","#808080"));  
    }


    /**
     * @dev
     * - このコントラクトをデプロイしたアドレスだけがmint可能
     */
    function nftMint(address to) external onlyOwner{
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        bytes32 hashed = keccak256(abi.encodePacked(newTokenId, block.timestamp));
        Color memory color = colors[uint256(hashed)%colors.length];

        string memory imageFan = _getImage(color.code);

        bytes memory metaData = abi.encodePacked(
            '{"name": "',
            'FanNFT # ',
            Strings.toString(newTokenId),
            '", "description": "Fan NFTs",',
            '"image": "data:image/svg+xml;base64,',
            Base64.encode(bytes(imageFan)),
            '"}'  
        );

        string memory uri = string(abi.encodePacked("data:application/json;base64,",Base64.encode(metaData)));

        _mint(to, newTokenId);
        _setTokenURI(newTokenId, uri);


        emit TokenURIChanged(to, newTokenId);
    }

    function _getImage(string memory colorCode) internal pure returns (string memory){
        return (
            string(
                abi.encodePacked(
                    '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 841.9 595.3" style="enable-background:new 0 0 841.9 595.3;" xml:space="preserve">',
                    '<style type="text/css">',
                        '.st0{fill:',
                        colorCode,
                        ';stroke:#222;stroke-width:1;}',
                        '.st1{fill:',
                        colorCode,
                        ';stroke:#222;stroke-width:1;}',
                        '.st2{fill:#FECE5C;}',
                        '.kaname {transform-origin:419.5px 521px;}',
                        '.ougi {animation:ougi 4s linear alternate infinite;}',
                        '@keyframes ougi {from {transform:scaleX(0);}}',
                        '.set {animation:set 4s linear alternate infinite;}',
                        '@keyframes set {from {transform:rotate(0deg);}}',
                        '#copy2 {transform:rotate(-60deg);}',
                        '#copy1 {transform:rotate(-30deg);}',
                        '#copy3 {transform:rotate(30deg);}',
                        '#copy4 {transform:rotate(60deg);}',
                        '#layer_2 {transform-origin:center;transform:scale(0.9);}',
                        '#oya_usiro {transform:rotate(-75deg);}',
                        '#oya_mae {transform:rotate(75deg);}',
                    '</style>',
                    '<g id="layer_1">',
                        '<rect width="841.9" height="595.3" fill = "#fff"/>',
                    '</g>',
                    '<g id="layer_2">',
                        '<path id = "oya_usiro" class="st2 kaname set" d="M426.9,553.5h-14.7c-4.1,0-7.5-3.4-7.5-7.5V52.9c0-4.1,3.4-7.5,7.5-7.5h14.7c4.1,0,7.5,3.4,7.5,7.5V546',
                            'C434.4,550.2,431,553.5,426.9,553.5z"/>',
                        '<g id = "copy2" class = "kaname set">',
                        '<path class="st2 kaname" d="M426.9,553.5h-14.7c-4.1,0-7.5-3.4-7.5-7.5V52.9c0-4.1,3.4-7.5,7.5-7.5h14.7c4.1,0,7.5,3.4,7.5,7.5V546',
                            'C434.4,550.2,431,553.5,426.9,553.5z"/>',
                        '<polygon class="st0 kaname ougi" points="419.5,46.8 542.3,63 464,355 419.5,349.7"/>',
                        '<polygon class="st1 kaname ougi" points="296.8,63 419.5,46.8 419.5,349.7 375.1,355"/>',
                        '</g>',
                        '<g id = "copy1" class = "kaname set">'
                        '<path class="st2 kaname" d="M426.9,553.5h-14.7c-4.1,0-7.5-3.4-7.5-7.5V52.9c0-4.1,3.4-7.5,7.5-7.5h14.7c4.1,0,7.5,3.4,7.5,7.5V546',
                            'C434.4,550.2,431,553.5,426.9,553.5z"/>',
                        '<polygon class="st0 kaname ougi" points="419.5,46.8 542.3,63 464,355 419.5,349.7"/>',
                        '<polygon class="st1 kaname ougi" points="296.8,63 419.5,46.8 419.5,349.7 375.1,355"/>',
                        '</g>',
                        '<path class="st2 kaname" d="M426.9,553.5h-14.7c-4.1,0-7.5-3.4-7.5-7.5V52.9c0-4.1,3.4-7.5,7.5-7.5h14.7c4.1,0,7.5,3.4,7.5,7.5V546',
                            'C434.4,550.2,431,553.5,426.9,553.5z"/>',
                        '<polygon class="st0 kaname ougi" points="419.5,46.8 542.3,63 464,355 419.5,349.7"/>',
                        '<polygon class="st1 kaname ougi" points="296.8,63 419.5,46.8 419.5,349.7 375.1,355"/>',
                        '<g id = "copy3" class = "kaname set">',
                        '<path class="st2 kaname" d="M426.9,553.5h-14.7c-4.1,0-7.5-3.4-7.5-7.5V52.9c0-4.1,3.4-7.5,7.5-7.5h14.7c4.1,0,7.5,3.4,7.5,7.5V546',
                            'C434.4,550.2,431,553.5,426.9,553.5z"/>',
                        '<polygon class="st0 kaname ougi" points="419.5,46.8 542.3,63 464,355 419.5,349.7"/>',
                        '<polygon class="st1 kaname ougi" points="296.8,63 419.5,46.8 419.5,349.7 375.1,355"/>',
                        '</g>',
                        '<g id = "copy4" class = "kaname set">',
                        '<path class="st2 kaname" d="M426.9,553.5h-14.7c-4.1,0-7.5-3.4-7.5-7.5V52.9c0-4.1,3.4-7.5,7.5-7.5h14.7c4.1,0,7.5,3.4,7.5,7.5V546',
                            'C434.4,550.2,431,553.5,426.9,553.5z"/>',
                        '<polygon class="st0 kaname ougi" points="419.5,46.8 542.3,63 464,355 419.5,349.7"/>',
                        '<polygon class="st1 kaname ougi" points="296.8,63 419.5,46.8 419.5,349.7 375.1,355"/>',
                        '</g>',
                        '<path id = "oya_mae" class="st2 kaname set" d="M426.9,553.5h-14.7c-4.1,0-7.5-3.4-7.5-7.5V52.9c0-4.1,3.4-7.5,7.5-7.5h14.7c4.1,0,7.5,3.4,7.5,7.5V546',
                            'C434.4,550.2,431,553.5,426.9,553.5z"/>',
                        '<circle cx="419.5" cy="521" r="11.2"/>',
                    '</g>',
                    '</svg>'

                )      
            )
        );
    }




    /**
     * @dev
     * - オーバーライド
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    /**
     * @dev
     * - オーバーライド
     */
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    /**
     * @dev
     * - オーバーライド
     */
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }


    /**
     * @dev
     * - オーバーライド
     */
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}

