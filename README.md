[![Version](https://img.shields.io/badge/version-v1.2.0-blue.svg)](https://github.com/huxiaoxu2019/hass-addon-frp-client/tree/v1.2.0)

# Hass Addon FRP Client
Home Assistant Community Add-on: FRP Client

You can leverage this add-on to achieve remote access to local Home Assistant OS by port forwarding.

## Architecture
<img width="800" src="https://github.com/huxiaoxu2019/hass-addon-frp-client/assets/5491423/58b8770e-dca5-4353-af27-e45494f78278">

## Installation
- Go to Settings -> Add-ons -> Add-on Store (bottom right)
- Click Repositories (top right)
<img width="600" src="https://github.com/huxiaoxu2019/hass-addon-frp-client/assets/5491423/699fac45-2b53-4213-811e-5fd0c4362b3b">

- Add the current repository `https://github.com/huxiaoxu2019/hass-addon-frp-client/`
<img width="600" src="https://github.com/huxiaoxu2019/hass-addon-frp-client/assets/5491423/91e886d5-dc3b-40a3-951a-9295687cf3f7">

- Wait and refresh the Add-on Store page, then you can see one new add-on `Frp Client`, click it and install
<img width="600" src="https://github.com/huxiaoxu2019/hass-addon-frp-client/assets/5491423/0bad82a7-f535-46b1-acf6-1a4151fb6420">
<br />
<img width="600" src="https://github.com/huxiaoxu2019/hass-addon-frp-client/assets/5491423/c0941c9e-6fff-40ad-8d7b-f89d4b937f92">
<br />
<img width="600" src="https://github.com/huxiaoxu2019/hass-addon-frp-client/assets/5491423/bee156da-282a-4831-9803-8e45f4331c2c">

- Add the configurations shown as below in your `configurations.yaml` with File Editor addon
```
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 0.0.0.0/0
```

It's better to modify the `0.0.0.0/0` to your proxy server IP

<img width="600"  src="https://github.com/huxiaoxu2019/hass-addon-frp-client/assets/5491423/47c4e863-1481-486a-9acb-41019c388fde">
<br />

## Configuration Options

### Basic Configuration
- **serverAddr**: Your FRP server address (e.g., "example.com")
- **serverPort**: Your FRP server port (default: 7000)
- **authToken**: Authentication token for your FRP server
- **customDomain**: Custom domain for accessing your Home Assistant (e.g., "ha.example.com")
- **proxyName**: Name for your Home Assistant proxy (default: "homeassistant")

### SSH Access Configuration
- **sshProxyName**: Name for your SSH proxy (default: "ssh")
- **sshDeviceName**: Device name for SSH access (e.g., "ssh-device")

### HTTP Authentication
- **httpUser**: Username for HTTP authentication
- **httpPassword**: Password for HTTP authentication
- **locationPath**: Path for accessing your Home Assistant (e.g., "/homeassistant")

### Web Server Configuration (Optional)
- **webServerPort**: Port for the FRP web server (default: 7500)
- **webServerUser**: Username for the FRP web server (default: "admin")
- **webServerPassword**: Password for the FRP web server

## Usage Tutorial
<a href="https://www.youtube.com/watch?v=1UTcnqsiDg8">
  <img width="800" src="https://github.com/huxiaoxu2019/hass-addon-frp-client/assets/5491423/d1f0820b-d0c4-450b-b476-cdae386b7e5d">
</a>

## Contribution
Welcome and appreciate contributions from the Home Assistant community. If you have ideas for improvements, bug fixes, or new features, feel free to contribute by submitting a pull request (PR). Before you start, please make sure to follow these guidelines:

### Bug Reports
If you encounter any bugs or have ideas for new features, please open an issue on the issue tracker.

### Pull Request
- Clearly describe the purpose of your changes in the pull request
- Provide step-by-step instructions for testing your changes
- Ensure that your changes do not introduce new issues

### Code of Conduct
Please note that this project follows [Home Assistant's Code of Conduct](https://www.home-assistant.io/code_of_conduct/). Be respectful and considerate in all interactions.

## Author
Xiaoxu Hu admin@ihuxu.com

Special thanks to: [@steplov](https://github.com/steplov) for the setup script
