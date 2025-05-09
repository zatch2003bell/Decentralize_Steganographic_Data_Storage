// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ImageStorage {
    struct Image {
        uint256 timestamp;
        string ipfsCID;
        address owner;
    }

    struct Retrieve {
        string ipfsid;
        uint256 length;
    }

    mapping(address => bool) encode;
    mapping(address => string[]) private ownerToImages; // Owner => List of CIDs
    mapping(string => bool) private isRegistered; // Check if an image exists
    mapping(string => Image) private images; // CID => Image struct
    mapping(string => Retrieve) getImage; // CID => Retrieve struct
    mapping(string => string) getoriginal;
    mapping(string => uint) getlength;

    event ImageUploaded(address indexed owner, string cid, uint256 timestamp);
    event ImageRetrieved(
        address indexed user,
        address indexed owner,
        string cid,
        uint256 cost
    );
    event OwnershipTransferred(string cid, address indexed newOwner);

    function setimage(
        string memory cid,
        string memory ncid,
        uint len
    ) external payable {
        // Retrieve storage img = getImage[cid];
        // img.ipfsid=ncid;
        // img.length=len;
        require(msg.value == 3 ether, "Pay 3 ether stinky");

        getoriginal[cid] = ncid;
        getlength[cid] = len;
    }

    function getimage(string memory cid) external view returns (string memory) {
        return getoriginal[cid];
    }

    function getLength(string memory cid) external view returns (uint) {
        return getlength[cid];
    }

    /// Upload an image (Costs 3 ETH)
    function uploadImage(string memory cid) external payable {
        require(!isRegistered[cid], "Image already exists");
        require(msg.value == 3 ether, "Uploading costs 3 ETH");

        Image storage newImage = images[cid];
        newImage.timestamp = block.timestamp;
        newImage.ipfsCID = cid;
        newImage.owner = msg.sender;

        ownerToImages[msg.sender].push(cid);
        isRegistered[cid] = true;

        emit ImageUploaded(msg.sender, cid, block.timestamp);
    }

    function retrieveImagesByOwner(
        address owner
    ) external payable returns (string[] memory) {
        require(
            ownerToImages[owner].length > 0,
            "No images found for this owner"
        );

        uint256 cost = (msg.sender == owner) ? 5 ether : 10 ether;
        require(msg.value == cost, "Incorrect retrieval fee");

        string[] memory cids = ownerToImages[owner];

        for (uint i = 0; i < cids.length; i++) {
            emit ImageRetrieved(msg.sender, owner, cids[i], cost);
        }
        return ownerToImages[owner];
    }

    /// Get all image CIDs owned by an address (view function, no cost)
    function getImagesByOwner(
        address owner
    ) external view returns (string[] memory) {
        return ownerToImages[owner];
    }

    /// Transfer ownership of an image
    function transferOwnership(string memory cid, address newOwner) external {
        require(isRegistered[cid], "Image not found");
        require(msg.sender == images[cid].owner, "Only the owner can transfer");

        images[cid].owner = newOwner;
        ownerToImages[newOwner].push(cid);

        emit OwnershipTransferred(cid, newOwner);
    }

    function encoder(address owner, bool decide) external {
        encode[owner] = decide;
    }
}
