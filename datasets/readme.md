# Documentation

## Dataset Information
The dataset required for this project is too large to be uploaded directly to GitHub due to the platform's file size limitations (maximum 20MB per file). Therefore, the dataset can be downloaded from the following **Google Drive** link:

[https://drive.google.com/drive/folders/1rrZWlnXSFTZMz0s4z7fpfBYzrBDH7Z3_?usp=drive_link](https://drive.google.com/drive/folders/1rrZWlnXSFTZMz0s4z7fpfBYzrBDH7Z3_)

### Instructions for Setting Up the Dataset
1. Download the `datasets` folder from the provided Google Drive link.
2. After downloading, ensure that the `crm` and `erp` directories are placed inside the `datasets` directory of this project.

The directory structure should look like this:

```
├── docs/                       # Documentation files
│   └── datawarehouse_architechture.png
├── scripts/
│   ├── bronze/                 # Scripts for bronze layer implementation
│   ├── silver/                 # Scripts for silver layer implementation
│   └── gold/                   # Scripts for gold layer implementation
├── dataset/
│   ├── crm/                    # Source CSV files
│   └── erp/                    # Source CSV files
├── test/                       # Some tests
└── readme.md                   # Project documentation
```