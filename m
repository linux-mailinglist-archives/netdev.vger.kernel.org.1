Return-Path: <netdev+bounces-133214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D88995540
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005A71C23465
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D41E1042;
	Tue,  8 Oct 2024 17:04:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB4433B5
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407054; cv=none; b=luUCpipqaOfGB5j6u++y7TGKVdpBTfhMIFsGTZ5q20bFZgkqfR3+sOFRbTizUVUcPMVy5Uk8U++7vbkMKDmiFANvJJw+DHecLAVqcXte+gmvfdHZEvkQPlKpE/JvnCWGrnih5JLCCmlvF3zlizmIr5u+vGKJRhJXjD9VKl8ULjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407054; c=relaxed/simple;
	bh=UKNMGSkZ+V1fkAicUqPJOmhDOGpOc3lT7VSrNpUDHKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUK3bCh4q0CSz8oWk/MAViT7Anqyg8Vg78HTwXW+MQ55FYwqGLfyAaQyOqw7VLurvA295ILE6nLX5NAYS2RCfnfFHp7SXMu617RhzGwmSPUrrmB3WlOB+PIV7lQVHZVK/EmJqRaMjX0RDEPuDmdr/1FsVzXYWGCwxGx/zkFDbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1syDcw-0002JG-6O; Tue, 08 Oct 2024 19:04:02 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1syDcr-000PcA-R3; Tue, 08 Oct 2024 19:03:57 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1syDcr-000SM4-2L;
	Tue, 08 Oct 2024 19:03:57 +0200
Date: Tue, 8 Oct 2024 19:03:57 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 12/12] net: pse-pd: tps23881: Add support for
 PSE events and interrupts
Message-ID: <ZwVl_eaUO6twk1Fs@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-12-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-12-787054f74ed5@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Oct 02, 2024 at 06:28:08PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add support for PSE event reporting through interrupts. Set up the newly
> introduced devm_pse_irq_helper helper to register the interrupt. Events are
> reported for over-current and over-temperature conditions.
> 
> This patch also adds support for an OSS GPIO line to turn off all low
> priority ports in case of an over-current event.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/net/pse-pd/tps23881.c | 123 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
> index ddb44a17218a..03f36b641bb4 100644
> --- a/drivers/net/pse-pd/tps23881.c
> +++ b/drivers/net/pse-pd/tps23881.c
> @@ -17,6 +17,13 @@
>  
>  #define TPS23881_MAX_CHANS 8
>  
> +#define TPS23881_REG_IT		0x0
> +#define TPS23881_REG_IT_MASK	0x1
> +#define TPS23881_REG_IT_IFAULT	BIT(5)
> +#define TPS23881_REG_IT_SUPF	BIT(7)
> +#define TPS23881_REG_FAULT	0x7
> +#define TPS23881_REG_SUPF_EVENT	0xb
> +#define TPS23881_REG_TSD	BIT(7)
>  #define TPS23881_REG_PW_STATUS	0x10
>  #define TPS23881_REG_OP_MODE	0x12
>  #define TPS23881_OP_MODE_SEMIAUTO	0xaaaa
> @@ -25,6 +32,7 @@
>  #define TPS23881_REG_PW_PRIO	0x15
>  #define TPS23881_REG_GEN_MASK	0x17
>  #define TPS23881_REG_NBITACC	BIT(5)
> +#define TPS23881_REG_INTEN	BIT(7)
>  #define TPS23881_REG_PW_EN	0x19
>  #define TPS23881_REG_2PAIR_POL1	0x1e
>  #define TPS23881_REG_PORT_MAP	0x26
> @@ -59,6 +67,7 @@ struct tps23881_priv {
>  	struct pse_controller_dev pcdev;
>  	struct device_node *np;
>  	struct tps23881_port_desc port[TPS23881_MAX_CHANS];
> +	struct gpio_desc *oss;
>  };
>  
>  static struct tps23881_priv *to_tps23881_priv(struct pse_controller_dev *pcdev)
> @@ -1088,11 +1097,112 @@ static int tps23881_flash_sram_fw(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static void tps23881_turn_off_low_prio(struct tps23881_priv *priv)
> +{
> +	dev_info(&priv->client->dev,
> +		 "turn off low priority ports due to over current event.\n");
> +	gpiod_set_value_cansleep(priv->oss, 1);
> +
> +	/* TPS23880 datasheet (Rev G) indicates minimum OSS pulse is 5us */
> +	usleep_range(5, 10);
> +	gpiod_set_value_cansleep(priv->oss, 0);

Ah, now I understand why 1 bit priority mode is used. The "fast" shutdown
path is done over interrupt and gpio bitbang.

It is not your fault...

> +}
> +
> +static int tps23881_irq_handler(int irq, struct pse_irq_data *pid,
> +				unsigned long *dev_mask)
> +{
> +	struct tps23881_priv *priv = (struct tps23881_priv *)pid->data;
> +	struct i2c_client *client = priv->client;
> +	struct pse_err_state *stat;
> +	int ret, i;
> +	u16 val;
> +
> +	*dev_mask = 0;
> +	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
> +		stat = &pid->states[i];
> +		stat->notifs = 0;
> +		stat->errors = 0;
> +	}
> +

Please add comment that two registers are read here in one run.

> +	ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT);
> +	if (ret < 0)
> +		return PSE_FAILED_RETRY;
> +
> +	val = (u16)ret;
> +	if (val & TPS23881_REG_IT_SUPF) {
> +		ret = i2c_smbus_read_word_data(client, TPS23881_REG_SUPF_EVENT);
> +		if (ret < 0)
> +			return PSE_FAILED_RETRY;
> +
> +		if (ret & TPS23881_REG_TSD) {
> +			for (i = 0; i < TPS23881_MAX_CHANS; i++) {
> +				stat = &pid->states[i];
> +				*dev_mask |= 1 << i;
> +				stat->notifs = PSE_EVENT_OVER_TEMP;
> +				stat->errors = PSE_ERROR_OVER_TEMP;
> +			}
> +		}
> +	}
> +
> +	if (val & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8)) {

Ok, i see, you are reading two registers in one run and wont to test if
mask and status bits are active. In this code you will get true every
time the interrupt handler is executed.

> +		ret = i2c_smbus_read_word_data(client, TPS23881_REG_FAULT);
> +		if (ret < 0)
> +			return PSE_FAILED_RETRY;
> +
> +		val = (u16)(ret & 0xf0f);
> +
> +		/* Power cut detected, shutdown low priority port */
> +		if (val && priv->oss)
> +			tps23881_turn_off_low_prio(priv);
> +
> +		*dev_mask |= val;
> +		for (i = 0; i < TPS23881_MAX_CHANS; i++) {
> +			if (val & BIT(i)) {
> +				stat = &pid->states[i];
> +				stat->notifs = PSE_EVENT_OVER_CURRENT;
> +				stat->errors = PSE_ERROR_OVER_CURRENT;
> +			}
> +		}
> +	}
> +
> +	return PSE_ERROR_CLEARED;
> +}
> +
> +static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
> +{
> +	int errs = PSE_ERROR_OVER_CURRENT | PSE_ERROR_OVER_TEMP;
> +	struct i2c_client *client = priv->client;
> +	struct pse_irq_desc irq_desc = {
> +		.name = "tps23881-irq",
> +		.map_event = tps23881_irq_handler,
> +		.data = priv,
> +	};
> +	int ret;
> +	u16 val;
> +
> +	val = TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_SUPF |
> +	      TPS23881_REG_IT_IFAULT << 8 | TPS23881_REG_IT_SUPF << 8;
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_IT_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, TPS23881_REG_GEN_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (u16)(ret | TPS23881_REG_INTEN | TPS23881_REG_INTEN << 8);
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_GEN_MASK, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_pse_irq_helper(&priv->pcdev, irq, 0, errs, &irq_desc);
> +}
> +
>  static int tps23881_i2c_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct tps23881_priv *priv;
> -	struct gpio_desc *reset;
> +	struct gpio_desc *reset, *oss;
>  	int ret;
>  	u8 val;
>  
> @@ -1169,6 +1279,17 @@ static int tps23881_i2c_probe(struct i2c_client *client)
>  				     "failed to register PSE controller\n");
>  	}
>  
> +	oss = devm_gpiod_get_optional(dev, "oss", GPIOD_OUT_LOW);
> +	if (IS_ERR(oss))
> +		return dev_err_probe(&client->dev, PTR_ERR(oss), "Failed to get OSS GPIO\n");
> +	priv->oss = oss;
> +
> +	if (client->irq) {
> +		ret = tps23881_setup_irq(priv, client->irq);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return ret;
>  }
>  
> 
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

