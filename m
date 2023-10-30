Return-Path: <netdev+bounces-45317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFA57DC168
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 21:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFAD1C20ADC
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6B2199BD;
	Mon, 30 Oct 2023 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MetTbEX+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7531718E1E
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 20:50:31 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6FF1
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 13:50:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so12402246a12.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 13:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698699028; x=1699303828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxmFp6bdPS9z+utWL6tGCQj1eEUR5A+Z69x4x+c0MEw=;
        b=MetTbEX+x2q5VYKrC2B1h4PYcKq33ItCd+Z7Rm4EFTXU440KnkqVLzNZu/PStje2/2
         Lx5jrcqbqPqqWbWCoB5+WKxroC/aBm0KLTNDtoQTzWe9AH5qKPDuemTxXOEXPr3L1LvK
         GI/ALI0kBlNyB4hj5ua/etDtq1LokhjFDJRk73Hb2F3bI80If0mPdxf4dKQnrxLvojXX
         DEz2aoARa0dsDKg42hlWM92KNdgD66F7ohrI40sdHOoo5u4w7FcEdOqz/rabuybXrlwR
         mKMb2OgocgrGRvZ4mFk7bWcoE1FrJgZc8S893kCMsKb5cc3KfhR3CwM7ZpW7o4Z1qAvJ
         rDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699028; x=1699303828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxmFp6bdPS9z+utWL6tGCQj1eEUR5A+Z69x4x+c0MEw=;
        b=q7fkjR6+1ml1EwPL7dAIvw0nsnhNVKwTN9sV47jW+FCvmpzfFV2hGMEeka2BbgQNK+
         j1luEGY19MYuy+JunfTdTLE7knptfjiXhhQkwj/ivad0RGW9aSCtTFHfofA2oPi8v98V
         h4apJZd1P3x4tghV/On2741Xn3QGyJOA194BX7LawrRJJCOaE5z4B62hUruA5AzP3MX8
         IIP8hnYtdzUZGXyt9SD670TvI1pbqg2MdVrW3DGencrm6DPiDnE/ip0mfMVRjFlw4bq0
         NqQYe1JBDwok/Fnv6WI23/SL2mUWxMhk8rPvCjzTj+Z5NhQhuEzzGIsvNapwdHXkRN8g
         YYDA==
X-Gm-Message-State: AOJu0Yyb0Qs9BHazP/bxDADm9vwieX9QDzHTeW6ZZrjvs25cDOl0I5wp
	+rSASGpgB+gNjge3n2AA8Gw=
X-Google-Smtp-Source: AGHT+IGDY0LuARDtJR4kU42Z7Qs3rHZ19+x5OdJAGc+xxd2vys1xPU5Z0vvSMXdbxZXDZe5WHmOK1g==
X-Received: by 2002:a17:906:7b52:b0:9b2:cee1:1f82 with SMTP id n18-20020a1709067b5200b009b2cee11f82mr658655ejo.7.1698699027450;
        Mon, 30 Oct 2023 13:50:27 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id gu25-20020a170906f29900b009c764341f74sm6550120ejb.71.2023.10.30.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:50:27 -0700 (PDT)
Date: Mon, 30 Oct 2023 22:50:25 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzk+dt@kernel.org, arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset
 controller
Message-ID: <20231030205025.b4dryzqzuunrjils@skbuf>
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027190910.27044-4-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>

On Fri, Oct 27, 2023 at 04:00:57PM -0300, Luiz Angelo Daros de Luca wrote:
> The 'reset-gpios' will not work when the switch reset is controlled by a
> reset controller.
> 
> Although the reset is optional and the driver performs a soft reset
> during setup, if the initial reset state was asserted, the driver will
> not detect it.
> 
> The reset controller will take precedence over the reset GPIO.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  drivers/net/dsa/realtek/realtek-mdio.c | 51 ++++++++++++++++++++++----
>  drivers/net/dsa/realtek/realtek-smi.c  | 49 ++++++++++++++++++++++---
>  drivers/net/dsa/realtek/realtek.h      |  2 +
>  3 files changed, 89 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index 292e6d087e8b..aad94e49d4c9 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -140,6 +140,40 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
>  	.disable_locking = true,
>  };
>  
> +static void realtek_mdio_reset_assert(struct realtek_priv *priv)
> +{
> +	int ret;
> +
> +	if (priv->reset_ctl) {
> +		ret = reset_control_assert(priv->reset_ctl);
> +		if (ret)
> +			dev_warn(priv->dev, "Failed to assert the switch reset control. Error: %i",
> +				 ret);

Instead of "Error: %i" you can say ".. reset control: %pe\n", ERR_PTR(ret)
which will print the error as a symbolic error name (if CONFIG_SYMBOLIC_ERRNAME=y)
rather than just a numeric value.

Also, I don't know if this is explicit in the coding style, but I
believe it is more consistent if single function calls are enveloped in
curly braces if they span multiple lines, like so:

		if (ret) {
			dev_warn(priv->dev,
				 "Failed to assert the switch reset control: %pe",
				 ERR_PTR(ret));
		}

Also, please note that netdev still prefers the 80 character line limit.

> +
> +		return;
> +	}
> +
> +	if (priv->reset)
> +		gpiod_set_value(priv->reset, true);
> +}
> +
> +static void realtek_mdio_reset_deassert(struct realtek_priv *priv)
> +{
> +	int ret;
> +
> +	if (priv->reset_ctl) {
> +		ret = reset_control_deassert(priv->reset_ctl);
> +		if (ret)
> +			dev_warn(priv->dev, "Failed to deassert the switch reset control. Error: %i",
> +				 ret);
> +
> +		return;

Is there a particular reason why this has to ignore a reset GPIO if
present, rather than fall through, checking for the latter as well?

> +	}
> +
> +	if (priv->reset)
> +		gpiod_set_value(priv->reset, false);
> +}
> +
>  static int realtek_mdio_probe(struct mdio_device *mdiodev)
>  {
>  	struct realtek_priv *priv;
> @@ -194,20 +228,24 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
>  
>  	dev_set_drvdata(dev, priv);
>  
> -	/* TODO: if power is software controlled, set up any regulators here */

As Andrew mentions, this commit does not make power software-controlled,
so don't remove this.

>  	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
>  
> +	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
> +	if (IS_ERR(priv->reset_ctl)) {
> +		ret = PTR_ERR(priv->reset_ctl);
> +		return dev_err_probe(dev, ret, "failed to get reset control\n");
> +	}
> +
>  	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(priv->reset)) {
>  		dev_err(dev, "failed to get RESET GPIO\n");
>  		return PTR_ERR(priv->reset);
>  	}
> -
> -	if (priv->reset) {
> -		gpiod_set_value(priv->reset, 1);
> +	if (priv->reset_ctl || priv->reset) {
> +		realtek_mdio_reset_assert(priv);
>  		dev_dbg(dev, "asserted RESET\n");
>  		msleep(REALTEK_HW_STOP_DELAY);
> -		gpiod_set_value(priv->reset, 0);
> +		realtek_mdio_reset_deassert(priv);
>  		msleep(REALTEK_HW_START_DELAY);
>  		dev_dbg(dev, "deasserted RESET\n");
>  	}
> @@ -246,8 +284,7 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
>  	dsa_unregister_switch(priv->ds);
>  
>  	/* leave the device reset asserted */
> -	if (priv->reset)
> -		gpiod_set_value(priv->reset, 1);
> +	realtek_mdio_reset_assert(priv);
>  }
>  
>  static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> index bfd11591faf4..a99e53b5b662 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -408,6 +408,40 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
>  	return ret;
>  }
>  
> +static void realtek_smi_reset_assert(struct realtek_priv *priv)
> +{
> +	int ret;
> +
> +	if (priv->reset_ctl) {
> +		ret = reset_control_assert(priv->reset_ctl);
> +		if (ret)
> +			dev_warn(priv->dev, "Failed to assert the switch reset control. Error: %i",
> +				 ret);
> +
> +		return;
> +	}
> +
> +	if (priv->reset)
> +		gpiod_set_value(priv->reset, true);
> +}
> +
> +static void realtek_smi_reset_deassert(struct realtek_priv *priv)
> +{
> +	int ret;
> +
> +	if (priv->reset_ctl) {
> +		ret = reset_control_deassert(priv->reset_ctl);
> +		if (ret)
> +			dev_warn(priv->dev, "Failed to deassert the switch reset control. Error: %i",
> +				 ret);
> +
> +		return;
> +	}
> +
> +	if (priv->reset)
> +		gpiod_set_value(priv->reset, false);
> +}
> +

To respond here, in a single email, to your earlier question (sorry):
https://lore.kernel.org/netdev/CAJq09z7miTe7HUzsL4GBSwkrzyy4mVi6z40+ETgvmY=iWGRN-g@mail.gmail.com/

| Both interface modules, realtek-smi and realtek-mdio, do not share
| code, except for the realtek.h header file. I don't know if it is
| worth it to put the code in a new shared module. What is the best
| practice here? Create a realtek_common.c linked to both modules?

The answer is: I ran "meld" between realtek-mdio.c and realtek-smi.c,
and the probe, remove and shutdown functions are surprisingly similar
already, and perhaps might become even more similar in the future.
I think it is worth introducing a common kernel module for both
interface drivers as a preliminary patch, rather than keeping duplicated
probe/remove/shutdown code.

>  static int realtek_smi_probe(struct platform_device *pdev)
>  {
>  	const struct realtek_variant *var;
> @@ -457,18 +491,22 @@ static int realtek_smi_probe(struct platform_device *pdev)
>  	dev_set_drvdata(dev, priv);
>  	spin_lock_init(&priv->lock);
>  
> -	/* TODO: if power is software controlled, set up any regulators here */
> +	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
> +	if (IS_ERR(priv->reset_ctl)) {
> +		ret = PTR_ERR(priv->reset_ctl);
> +		return dev_err_probe(dev, ret, "failed to get reset control\n");
> +	}
>  
>  	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(priv->reset)) {
>  		dev_err(dev, "failed to get RESET GPIO\n");
>  		return PTR_ERR(priv->reset);
>  	}
> -	if (priv->reset) {
> -		gpiod_set_value(priv->reset, 1);
> +	if (priv->reset_ctl || priv->reset) {
> +		realtek_smi_reset_assert(priv);
>  		dev_dbg(dev, "asserted RESET\n");
>  		msleep(REALTEK_HW_STOP_DELAY);
> -		gpiod_set_value(priv->reset, 0);
> +		realtek_smi_reset_deassert(priv);
>  		msleep(REALTEK_HW_START_DELAY);
>  		dev_dbg(dev, "deasserted RESET\n");
>  	}
> @@ -518,8 +556,7 @@ static void realtek_smi_remove(struct platform_device *pdev)
>  		of_node_put(priv->slave_mii_bus->dev.of_node);

slave_mii_bus was renamed to user_mii_bus, and this prevents the
application of the patch currently, so you will need to respin. But I
think net-next is going to close soon for 2 weeks, so either you respin
as RFC or you wait until it reopens.

>  
>  	/* leave the device reset asserted */
> -	if (priv->reset)
> -		gpiod_set_value(priv->reset, 1);
> +	realtek_smi_reset_assert(priv);
>  }
>  

