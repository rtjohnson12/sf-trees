# -*- coding: utf-8 -*-
import click
import logging
import requests
import pandas as pd
import json
from pathlib import Path
from dotenv import find_dotenv, load_dotenv


def import_parks():
    data_id = "3nje-yn2u"
    raw = requests.get(f"https://data.sfgov.org/resource/{data_id}.json")
    raw.content
    pass

def import_contours():
    pass

def import_trees():
    pass

@click.command()
@click.argument('input_filepath', type=click.Path(exists=True))
@click.argument('output_filepath', type=click.Path())
def main(input_filepath, output_filepath):
    """ Runs data processing scripts to turn raw data from (../raw) into
        cleaned data ready to be analyzed (saved in ../processed).
    """
    logger = logging.getLogger(__name__)
    logger.info('making final data set from raw data')

if __name__ == '__main__':
    log_fmt = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    logging.basicConfig(level=logging.INFO, format=log_fmt)

    # not used in this stub but often useful for finding various files
    project_dir = Path(__file__).resolve().parents[2]

    # find .env automagically by walking up directories until it's found, then
    # load up the .env entries as environment variables
    load_dotenv(find_dotenv())

    main()
