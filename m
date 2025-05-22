Return-Path: <netdev+bounces-192621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39741AC08AF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730511BA593E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E98267F5D;
	Thu, 22 May 2025 09:29:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBF70814
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906198; cv=none; b=ROowHgAcZud9FtQoqyPReEmQGSyR9Hv9T9Ku/qLLZXDH63bWoPzWMtn2tyq41t/JzC52CJq47tUU6Fk+YoRTA1e583RiqBSgjX2Q9rAlLrdJKHOK6mbl2PlVAHraVPn2qoSlhVSUtmrgAsXRnCBRtl3G3z/AogvywXFh29u848I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906198; c=relaxed/simple;
	bh=IgJS/CW5D3saR5ixa29J1GhVTdlLoZnxPxHSV44nzrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1fhqwCI5LDpmO3oIud5TjOzKV1K2MBP0h2+2IJsgB2vJEId2EIjDgYQK3nO7IQqcQUzgxwXGt/C8kriWb7QCUC2pQW9bUWFmZgvt3zbJAwrPXhm9caIdY+9nlqSKmy3QuOOzzsWkkHnSXxrzGuPPAdYWWaJyXUm6NeYxXYokuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uI2FD-0000kN-Hu; Thu, 22 May 2025 11:29:43 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uI2FC-000iCb-03;
	Thu, 22 May 2025 11:29:42 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uI2FB-002ip5-2n;
	Thu, 22 May 2025 11:29:41 +0200
Date: Thu, 22 May 2025 11:29:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
Message-ID: <aC7uhSMJG_VHtSCB@pengutronix.de>
References: <f975f23e-84a7-48e6-a2b2-18ceb9148675@adtran.com>
 <584b7975-1544-4833-8f8a-00a8769a80c2@adtran.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <584b7975-1544-4833-8f8a-00a8769a80c2@adtran.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Piotr,

here are some comments.

On Fri, May 16, 2025 at 01:07:18PM +0000, Piotr Kubik wrote:
> From: Piotr Kubik <piotr.kubik@adtran.com>
> 
> Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
> controller.
> 
> Based on the TPS23881 driver code.
> 
> Driver supports basic features of Si3474 IC:
> - get port status,
> - get port power,
> - get port voltage,
> - enable/disable port power.
> 
> Only 4p configurations are supported at this moment.
> 
> Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>
> ---
>  drivers/net/pse-pd/Kconfig  |  10 +
>  drivers/net/pse-pd/Makefile |   1 +
>  drivers/net/pse-pd/si3474.c | 649 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 660 insertions(+)
>  create mode 100644 drivers/net/pse-pd/si3474.c
> 
> diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
> index 7fab916a7f46..d1b100eb8c52 100644
> --- a/drivers/net/pse-pd/Kconfig
> +++ b/drivers/net/pse-pd/Kconfig
> @@ -32,6 +32,16 @@ config PSE_PD692X0
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pd692x0.
>  
> +config PSE_SI3474
> +	tristate "Si3474 PSE controller"
> +	depends on I2C
> +	help
> +	  This module provides support for Si3474 regulator based Ethernet
> +	  Power Sourcing Equipment.

Will be good to add here current limitation, that is supports only
4-pair mode.

> +static int si3474_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
> +				     struct pse_admin_state *admin_state)
> +{
> +	struct si3474_priv *priv = to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	bool is_enabled = false;
> +	u8 chan0, chan1;
> +	s32 ret;
> +
> +	if (id >= SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	chan0 = priv->pi[id].chan[0];
> +	chan1 = priv->pi[id].chan[1];
> +
> +	if (chan0 < 4)
> +		client = priv->client[0];
> +	else
> +		client = priv->client[1];
> +
> +	ret = i2c_smbus_read_byte_data(client, PORT_MODE_REG);

There are repeating patterns in client and channel calculation.
Some of them can be uput in a separate function.

> +	if (ret < 0) {
> +		admin_state->c33_admin_state =
> +			ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN;
> +		return ret;
> +	}
> +
> +	is_enabled = ((ret & (0x03 << (2 * (chan0 % 4)))) |
> +		      (ret & (0x03 << (2 * (chan1 % 4))))) != 0;

Please replace magic numbers with defines.

> +
> +	if (is_enabled)
> +		admin_state->c33_admin_state =
> +			ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
> +	else
> +		admin_state->c33_admin_state =
> +			ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
> +
> +	return 0;
> +}
> +
> +static int si3474_pi_get_pw_status(struct pse_controller_dev *pcdev, int id,
> +				   struct pse_pw_status *pw_status)
> +{
> +	struct si3474_priv *priv = to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	bool delivering = false;
> +	u8 chan0, chan1;
> +	s32 ret;
> +
> +	if (id >= SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	chan0 = priv->pi[id].chan[0];
> +	chan1 = priv->pi[id].chan[1];
> +
> +	if (chan0 < 4)
> +		client = priv->client[0];
> +	else
> +		client = priv->client[1];
> +
> +	ret = i2c_smbus_read_byte_data(client, POWER_STATUS_REG);
> +	if (ret < 0) {
> +		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN;
> +		return ret;
> +	}
> +
> +	delivering = (ret & (BIT((chan0 % 4) + 4) | BIT((chan1 % 4) + 4))) != 0;
> +
> +	if (delivering)
> +		pw_status->c33_pw_status =
> +			ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
> +	else
> +		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
> +
> +	return 0;
> +}
> +
> +/* Parse pse-pis subnode into chan array of si3474_priv */
> +static int si3474_get_of_channels(struct si3474_priv *priv)
> +{
> +	struct device_node *pse_node;
> +	struct pse_pi *pi;
> +	u32 pi_no, chan_id;
> +	s8 pairset_cnt;
> +	s32 ret = 0;
> +
> +	pse_node = of_get_child_by_name(priv->np, "pse-pis");
> +	if (!pse_node) {
> +		dev_warn(&priv->client[0]->dev,
> +			 "Unable to parse DT PSE power interface matrix, no pse-pis node\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node_scoped(pse_node, node) {
> +		if (!of_node_name_eq(node, "pse-pi"))
> +			continue;
> +
> +		ret = of_property_read_u32(node, "reg", &pi_no);
> +		if (ret) {
> +			dev_err(&priv->client[0]->dev,
> +				"Failed to read pse-pi reg property\n");
> +			goto out;
> +		}
> +		if (pi_no >= SI3474_MAX_CHANS) {
> +			dev_err(&priv->client[0]->dev,
> +				"Invalid power interface number %u\n", pi_no);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		pairset_cnt = of_property_count_elems_of_size(node, "pairsets",
> +							      sizeof(u32));
> +		if (!pairset_cnt) {
> +			dev_err(&priv->client[0]->dev,
> +				"Failed to get pairsets property\n");
> +			goto out;
> +		}
> +
> +		pi = &priv->pcdev.pi[pi_no];
> +		if (!pi->pairset[0].np) {
> +			dev_err(&priv->client[0]->dev,
> +				"Missing pairset reference, power interface: %u\n",
> +				pi_no);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		ret = of_property_read_u32(pi->pairset[0].np, "reg", &chan_id);
> +		if (ret) {
> +			dev_err(&priv->client[0]->dev,
> +				"Failed to read channel reg property, ret:%d\n",
> +				ret);
> +			goto out;
> +		}
> +		priv->pi[pi_no].chan[0] = chan_id;

should we validated chan_id?


> +		priv->pi[pi_no].is_4p = FALSE;

Please use lower case variant (false/true).

> +
> +		if (pairset_cnt == 2) {
> +			if (!pi->pairset[1].np) {
> +				dev_err(&priv->client[0]->dev,
> +					"Missing pairset reference, power interface: %u\n",
> +					pi_no);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			ret = of_property_read_u32(pi->pairset[1].np, "reg",
> +						   &chan_id);
> +			if (ret) {
> +				dev_err(&priv->client[0]->dev,
> +					"Failed to read channel reg property\n");
> +				goto out;
> +			}
> +			priv->pi[pi_no].chan[1] = chan_id;

same here

> +			priv->pi[pi_no].is_4p = TRUE;
> +		} else {
> +			dev_err(&priv->client[0]->dev,
> +				"Number of pairsets incorrect - only 4p configurations supported\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	of_node_put(pse_node);
> +	return ret;
> +}
> +
...

> +static int si3474_pi_get_chan_current(struct si3474_priv *priv, u8 chan)
> +{
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 reg;
> +	u64 tmp_64;
> +
> +	if (chan < 4)
> +		client = priv->client[0];
> +	else
> +		client = priv->client[1];
> +
> +	/* Registers 0x30 to 0x3d */
> +	reg = PORT1_CURRENT_LSB_REG + (chan % 4) * 4;

Do this values are valid channels is not enabled and/or not delivering? 

> +	ret = i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	tmp_64 = ret * SI3474_NA_STEP;
> +
> +	/* uA = nA / 1000 */
> +	tmp_64 = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000);
> +	return (int)tmp_64;
> +}
> +
> +static int si3474_pi_get_chan_voltage(struct si3474_priv *priv, u8 chan)
> +{
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 reg;
> +	u32 val;
> +
> +	if (chan < 4)
> +		client = priv->client[0];
> +	else
> +		client = priv->client[1];
> +
> +	/* Registers 0x32 to 0x3f */
> +	reg = PORT1_VOLTAGE_LSB_REG + (chan % 4) * 4;
> +
> +	ret = i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = ret * SI3474_UV_STEP;
> +
> +	return (int)val;
> +}
> +
> +static int si3474_pi_get_voltage(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct si3474_priv *priv = to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	u8 chan0, chan1;
> +	s32 ret;
> +
> +	chan0 = priv->pi[id].chan[0];
> +	chan1 = priv->pi[id].chan[1];
> +
> +	if (chan0 < 4)
> +		client = priv->client[0];
> +	else
> +		client = priv->client[1];
> +
> +	/* Check which channels are enabled*/
> +	ret = i2c_smbus_read_byte_data(client, POWER_STATUS_REG);
> +	if (ret < 0)
> +		return ret;

Do voltage values are valide if channel is enabled by not delivering?

> +	/* Take voltage from the first enabled channel */
> +	if (ret & BIT(chan0 % 4))
> +		ret = si3474_pi_get_chan_voltage(priv, chan0);
> +	else if (ret & BIT(chan1))

should it be (chan1 % 4) ?

> +		ret = si3474_pi_get_chan_voltage(priv, chan1);
> +	else
> +		/* 'should' be no voltage in this case */
> +		return 0;
> +
> +	return ret;
> +}
> +
> +static int si3474_pi_get_actual_pw(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct si3474_priv *priv = to_si3474_priv(pcdev);
> +	s32 ret;
> +	u32 uV, uA;
> +	u64 tmp_64;
> +	u8 chan0, chan1;
> +
> +	if (id >= SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	ret = si3474_pi_get_voltage(&priv->pcdev, id);
> +	if (ret < 0)
> +		return ret;
> +	uV = ret;
> +
> +	chan0 = priv->pi[id].chan[0];
> +	chan1 = priv->pi[id].chan[1];
> +
> +	ret = si3474_pi_get_chan_current(priv, chan0);
> +	if (ret < 0)
> +		return ret;
> +	uA = ret;
> +
> +	ret = si3474_pi_get_chan_current(priv, chan1);
> +	if (ret < 0)
> +		return ret;
> +	uA += ret;
> +
> +	tmp_64 = uV;
> +	tmp_64 *= uA;
> +	/* mW = uV * uA / 1000000000 */
> +	return DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
> +}
> +
> +static const struct pse_controller_ops si3474_ops = {
> +	.setup_pi_matrix = si3474_setup_pi_matrix,
> +	.pi_enable = si3474_pi_enable,
> +	.pi_disable = si3474_pi_disable,
> +	.pi_get_actual_pw = si3474_pi_get_actual_pw,
> +	.pi_get_voltage = si3474_pi_get_voltage,
> +	.pi_get_admin_state = si3474_pi_get_admin_state,
> +	.pi_get_pw_status = si3474_pi_get_pw_status,
> +};
> +
> +static void si3474_ancillary_i2c_remove(void *data)
> +{
> +	struct i2c_client *client = data;
> +
> +	i2c_unregister_device(client);
> +}
> +
> +static int si3474_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct si3474_priv *priv;
> +	s32 ret;
> +	u8 fw_version;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(dev, "i2c check functionality failed\n");
> +		return -ENXIO;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ret = i2c_smbus_read_byte_data(client, VENDOR_IC_ID_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != SI3474_DEVICE_ID) {
> +		dev_err(dev, "Wrong device ID: 0x%x\n", ret);
> +		return -ENXIO;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(client, FIRMWARE_REVISION_REG);
> +	if (ret < 0)
> +		return ret;
> +	fw_version = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, CHIP_REVISION_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(dev, "Chip revision: 0x%x, firmware version: 0x%x\n",
> +		ret, fw_version);
> +
> +	priv->client[0] = client;
> +	i2c_set_clientdata(client, priv);
> +
> +	priv->client[1] = i2c_new_ancillary_device(priv->client[0], "secondary",
> +						   priv->client[0]->addr + 1);
> +	if (IS_ERR(priv->client[1]))
> +		return PTR_ERR(priv->client[1]);
> +
> +	ret = devm_add_action_or_reset(dev, si3474_ancillary_i2c_remove, priv->client[1]);
> +	if (ret < 0) {
> +		dev_err(&priv->client[1]->dev, "Cannot register remove callback\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(priv->client[1], VENDOR_IC_ID_REG);
> +	if (ret < 0) {
> +		dev_err(&priv->client[1]->dev, "Cannot access secondary PSE controller\n");
> +		return ret;
> +	}
> +
> +	if (ret != SI3474_DEVICE_ID) {
> +		dev_err(&priv->client[1]->dev,
> +			"Wrong device ID for secondary PSE controller: 0x%x\n", ret);
> +		return -ENXIO;
> +	}
> +
> +	priv->np = dev->of_node;
> +	priv->pcdev.owner = THIS_MODULE;
> +	priv->pcdev.ops = &si3474_ops;
> +	priv->pcdev.dev = dev;
> +	priv->pcdev.types = ETHTOOL_PSE_C33;
> +	priv->pcdev.nr_lines = SI3474_MAX_CHANS;

Do we actually have SI3474_MAX_CHANS (8 channels) in 4p mode? I guess it
will be 4.

> +
> +	ret = devm_pse_controller_register(dev, &priv->pcdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register PSE controller: 0x%x\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id si3474_id[] = {
> +	{ "si3474" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, si3474_id);
> +
> +static const struct of_device_id si3474_of_match[] = {
> +	{
> +		.compatible = "skyworks,si3474",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, si3474_of_match);
> +
> +static struct i2c_driver si3474_driver = {
> +	.probe = si3474_i2c_probe,
> +	.id_table = si3474_id,
> +	.driver = {
> +		.name = "si3474",
> +		.of_match_table = si3474_of_match,
> +	},
> +};
> +module_i2c_driver(si3474_driver);
> +
> +MODULE_AUTHOR("Piotr Kubik <piotr.kubik@adtran.com>");
> +MODULE_DESCRIPTION("Skyworks Si3474 PoE PSE Controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.0
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

