import json
from pathlib import Path
import pandas as pd
from train import fit_reference

def test_fit_reference_runs():
    config = json.loads(Path('config.json').read_text())
    df = pd.read_csv('dataset/train.csv')
    model, accuracy = fit_reference(df, config)
    assert 0 <= accuracy <= 1
