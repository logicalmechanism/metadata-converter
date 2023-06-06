# Metadata Converter

The Python script called `convert_metadata.py` has the capability to convert standard 721 metadata into CIP68 metadatum format. 

## Use

The simpliest way to convert metadata is with the `convert.sh` bash script. This assumes 721 and standard formatting.

```bash
./convert.sh path/to/metadata/file.json
```

This will assume a single token metadata inside the metadata file and will auto populate a `metadatum.json` file inside the directory.

The python script can be used directly with the code below:

```py
from convert_metadata import convert_metadata
file_path  = "../data/meta/example.metadata.json"
datum_path = "../data/meta/example.metadatum.json"
tag        = '721'
pid        = '<policy_id_hex>'
tkn        = '<asset_name_ascii>'
version    = 1
convert_metadata(file_path, datum_path, tag, pid, tkn, version)
```

The converter function requires the following inputs:

- Metadata path: The path to the original 721 metadata file.
- Metadatum path: The desired path for the converted metadatum file.
- Tag standard: The tag standard used in the original metadata.
- Policy ID: The policy ID associated with the token.
- Token name: The name of the token.
- Version: The version number of the metadatum.

By providing these inputs, the converter function will convert the standard 721 metadata into the CIP68 metadatum format. This allows for compatibility and usage of the converted metadatum in the CIP68 contract.

## Metadata to Metadatum

Metadata, pre-cip68, is typically in the 721 format like below:

```json
{
  "721": {
    "policy_id": {
      "token_name": {
        "album_title": "A Song",
        "artists": [
          {
            "name": "You"
          }
        ],
        "copyright": [
          "© 2022 Fake LLC"
        ],
        "country_of_origin": "United States",
        "track_number": 1
      }
    },
    "version": 1
  }
}
```

Now in cip68, this metadata becomes metadatum with the form below:

```json
{
    "constructor": 0,
    "fields": [
        {
            "map": [
                {
                    "k": {
                        "bytes": "616c62756d5f7469746c65"
                    },
                    "v": {
                        "bytes": "4120536f6e67"
                    }
                },
                {
                    "k": {
                        "bytes": "61727469737473"
                    },
                    "v": {
                        "list": [
                            {
                                "map": [
                                    {
                                        "k": {
                                            "bytes": "6e616d65"
                                        },
                                        "v": {
                                            "bytes": "596f75"
                                        }
                                    }
                                ]
                            }
                        ]
                    }
                },
                {
                    "k": {
                        "bytes": "636f70797269676874"
                    },
                    "v": {
                        "list": [
                            {
                                "bytes": "c2a920323032322046616b65204c4c43"
                            }
                        ]
                    }
                },
                {
                    "k": {
                        "bytes": "636f756e7472795f6f665f6f726967696e"
                    },
                    "v": {
                        "bytes": "556e6974656420537461746573"
                    }
                },
                {
                    "k": {
                        "bytes": "747261636b5f6e756d626572"
                    },
                    "v": {
                        "int": 1
                    }
                }
            ]
        },
        {
            "int": 1
        }
    ]
}
```