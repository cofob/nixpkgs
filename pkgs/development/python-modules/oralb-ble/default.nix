{ lib
, bluetooth-data-tools
, bluetooth-sensor-state-data
, buildPythonPackage
, fetchFromGitHub
, home-assistant-bluetooth
, poetry-core
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "oralb-ble";
  version = "0.15.0";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "Bluetooth-Devices";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-c5bsynNozFkY1VtAesKFXpwC81d8iZd48kFBHPRf43M=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    bluetooth-data-tools
    bluetooth-sensor-state-data
    home-assistant-bluetooth
  ];

  checkInputs = [
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=oralb_ble --cov-report=term-missing:skip-covered" ""
  '';

  pythonImportsCheck = [
    "oralb_ble"
  ];

  meta = with lib; {
    description = "Library for Oral B BLE devices";
    homepage = "https://github.com/Bluetooth-Devices/oralb-ble";
    changelog = "https://github.com/Bluetooth-Devices/oralb-ble/releases/tag/v${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
