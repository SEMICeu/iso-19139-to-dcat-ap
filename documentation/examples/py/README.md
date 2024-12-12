## Running iso-19139-to-dcat-ap.py

## Prerequisites

Make sure you have [Python 3.6 ](https://www.python.org/downloads/)or higher installed on your system.

### Creating a virtual environment

To create a virtual environment, follow these steps:

1. Open a terminal and navigate to the directory containing the `iso-19139-to-dcat-ap.py` script.

2. Create a virtual environment by issuing the following command:

    - On Windows:

        ```sh
        python -m venv env
        ```

    - On MacOS and Linux:

        ```sh
        python3 -m venv env
        ```

3. Enable the virtual environment:

    - On Windows:

        ```sh
        .\env\Scripts\activate
        ```

    - On MacOS and Linux:

        ```sh
        source env/bin/activate
        ```

### Installing the prerequisites

With the virtual environment activated, install the necessary prerequisites by running the following command:

- On Windows, MacOS and Linux:

    ```sh
    pip install -r requirements.txt
    ```

## Configuration

### Generating the `config.yaml`

To configure the script, you need to create a `config.yaml` file based on the provided `config.yaml.example`. You can do this by copying the example file:

- On Windows:

    ```sh
    copy config.yaml.example config.yaml
    ```

- On MacOS and Linux:

    ```sh
    cp config.yaml.example config.yaml
    ```

### Options in `config.yaml`

- `xml_url`: The URL to the CSW endpoint. Example:
  ```yaml
  xml_url: http://some.site/csw?request=GetRecords&service=CSW&version=2.0.2&namespace=xmlns%28csw=http://www.opengis.net/cat/csw%29&resultType=results&outputSchema=http://www.isotc211.org/2005/gmd&outputFormat=application/xml&typeNames=csw:Record&elementSetName=full&constraintLanguage=CQL_TEXT&constraint_language_version=1.1.0&maxRecords=10
  ```

- `xsl_url`: The URL to the XSLT transformation or the local XSLT file path. Example:
  ```yaml
  xsl_url: https://raw.githubusercontent.com/mjanez/iso-19139-to-dcat-ap/refs/heads/develop/iso-19139-to-dcat-ap.xsl
  ```

### Running the script

Once you have configured the `config.yaml` file, you can run the script as follows:

```sh
python iso-19139-to-dcat-ap.py
```
