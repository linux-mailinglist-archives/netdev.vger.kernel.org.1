Return-Path: <netdev+bounces-44030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5B7D5E43
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE33B20FAD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106A1B283;
	Tue, 24 Oct 2023 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2MsTS/r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481A4735C
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:33:46 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54B10E3
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:33:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ba081173a3so787915466b.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698186822; x=1698791622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOegmv00WB5JEzEmIKJDW506j90jj78tNCIh2bZvrCc=;
        b=D2MsTS/r7Rno4dWZu2zCG32wcZiXFA/zJydSSOASJr1FK6KZQyvLzCzT7zQiqm+mEQ
         S1jsFjHxJ40NwmE9eGHWg9mOgqBbGQrDGY+E+Tl77BUzLTynkRlb2Q+2RgqGcnJRX0WF
         uQNhhHr3qmGy6e53nKVhR20AitczCMg3tWia9ngdS3wlHJwGlW/0K20zi1gQuym+87Z5
         QU6V6rDan0VTFCTdbKdR1ZB359vnZbuMX3hdVaE0sT9euitjCUQWMkONM9cQdVHqskHP
         rnWsCNejs619WBNOr9tKnuCnD0wktDE2EqKQi5Xmd/7mfvkND36OoNBc5VsEewq+Xc2j
         UqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186822; x=1698791622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOegmv00WB5JEzEmIKJDW506j90jj78tNCIh2bZvrCc=;
        b=FVUsortKwsp7GJDhALLnHtf1flZUdGLuxeGoqiSMBjKSiiC5KrVjtCe923o2V1lS4R
         VLBQh1JETF63F2hXqqsb9VGfvEdCqPvm2gVNkWxG7Mg7hVQL3FJrQ5JMOZ6hkm/QI7sH
         5J/j0T5E29gxfoAr6kfQHyTvSd7lVECOc70beria2zRN2IiaPlb9JHqC9pQ3eaCv5RK5
         u5NqL0G4QSXR/JMQDzOo9ykJSRe6y+lZo07Ynky23XIT0h+CIMEh2maEhDbuPbYNkaAX
         mfGvMhE9ZDj5HHE1tl4JMmiPMll9X/7Qrgz3gZFmivnzTCleGoKTI1Y2rkq+4qTpuMpp
         U9iA==
X-Gm-Message-State: AOJu0YzBf/+WSRzVVFBW7w9qLZ2ARGwVW3lnNAAlsXxvLuIR9In+JVh7
	+xoMmTHY0d7Z7Rj0eBZVr3E=
X-Google-Smtp-Source: AGHT+IGYp+hCPek8J42+Pa1kSDMuP45PKXamAq0vV+eIkD/ngWhDXjFp/z3uuDT/SaCnQHoFr+M7Ig==
X-Received: by 2002:a17:907:a03:b0:9be:dce3:6e06 with SMTP id bb3-20020a1709070a0300b009bedce36e06mr11309524ejc.52.1698186822029;
        Tue, 24 Oct 2023 15:33:42 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906711600b0099b7276235esm8838919ejj.93.2023.10.24.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 15:33:41 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:33:39 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzk+dt@kernel.org, arinc.unal@arinc9.com
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: support reset controller
Message-ID: <20231024223339.ccyybyvzrd22bxnh@skbuf>
References: <20231024205805.19314-1-luizluca@gmail.com>
 <20231024205805.19314-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024205805.19314-1-luizluca@gmail.com>
 <20231024205805.19314-1-luizluca@gmail.com>

On Tue, Oct 24, 2023 at 05:58:04PM -0300, Luiz Angelo Daros de Luca wrote:
> The 'reset-gpios' will not work when the switch reset is controlled by a
> reset controller.
> 
> Although the reset is optional and the driver performs a soft reset
> during setup, if the initial reset state was asserted, the driver will
> not detect it.
> 
> This is an example of how to use the reset controller:
> 
>         switch {
>                 compatible = "realtek,rtl8366rb";
> 
>                 resets = <&rst 8>;
>                 reset-names = "switch";
> 
> 		...
> 	}

Mix of tabs and spaces here.
Also, examples belong to the dt-schema.

> 
> The reset controller will take precedence over the reset GPIO.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  drivers/net/dsa/realtek/realtek-mdio.c | 36 +++++++++++++++++++++-----
>  drivers/net/dsa/realtek/realtek-smi.c  | 34 +++++++++++++++++++-----
>  drivers/net/dsa/realtek/realtek.h      |  6 +++++
>  3 files changed, 63 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index 292e6d087e8b..600124c58c00 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -140,6 +140,23 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
>  	.disable_locking = true,
>  };
>  
> +static int realtek_mdio_hwreset(struct realtek_priv *priv, bool active)
> +{
> +#ifdef CONFIG_RESET_CONTROLLER
> +	if (priv->reset_ctl) {
> +		if (active)
> +			return reset_control_assert(priv->reset_ctl);
> +		else
> +			return reset_control_deassert(priv->reset_ctl);
> +	}
> +#endif
> +
> +	if (priv->reset)
> +		gpiod_set_value(priv->reset, active);
> +
> +	return 0;
> +}
> +

This "bool active" artificially unifies two discrete code paths in the
same function, where the callers are not the same and the implementation
is not the same (given a priv->reset_ctl presence), separated by an "if".

Would it make more sense to have discrete functions, each with its
unique caller, like this?

static int realtek_reset_assert(struct realtek_priv *priv)
{
	if (priv->reset_ctl)
		return reset_control_assert(priv->reset_ctl);

	if (priv->reset)
		gpiod_set_value(priv->reset, 1);

	return 0;
}

static int realtek_reset_deassert(struct realtek_priv *priv)
{
	if (priv->reset_ctl)
		return reset_control_deassert(priv->reset_ctl);

	if (priv->reset)
		gpiod_set_value(priv->reset, 0);

	return 0;
}

Also, you return int but ignore error values everywhere. I guess it
would make more sense to return void, but print warnings within the
reset functions if the calls to the reset control fail.

>  static int realtek_mdio_probe(struct mdio_device *mdiodev)
>  {
>  	struct realtek_priv *priv;
> @@ -194,20 +211,26 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
>  
>  	dev_set_drvdata(dev, priv);
>  
> -	/* TODO: if power is software controlled, set up any regulators here */

I'm not sure if "power" and "reset" are the same thing...

>  	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
>  
> +#ifdef CONFIG_RESET_CONTROLLER
> +	priv->reset_ctl = devm_reset_control_get(dev, "switch");
> +	if (IS_ERR(priv->reset_ctl)) {
> +		dev_err(dev, "failed to get switch reset control\n");
> +		return PTR_ERR(priv->reset_ctl);

		ret = PTR_ERR(priv->reset_ctl);
		return dev_err_probe(dev, err, "failed to get reset control\n");

This suppresses -EPROBE_DEFER prints.

> +	}
> +#endif
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
> +		realtek_mdio_hwreset(priv, 1);
>  		dev_dbg(dev, "asserted RESET\n");
>  		msleep(REALTEK_HW_STOP_DELAY);
> -		gpiod_set_value(priv->reset, 0);
> +		realtek_mdio_hwreset(priv, 0);
>  		msleep(REALTEK_HW_START_DELAY);
>  		dev_dbg(dev, "deasserted RESET\n");
>  	}
> @@ -246,8 +269,7 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
>  	dsa_unregister_switch(priv->ds);
>  
>  	/* leave the device reset asserted */
> -	if (priv->reset)
> -		gpiod_set_value(priv->reset, 1);
> +	realtek_mdio_hwreset(priv, 1);

nitpick: "bool" arguments should take "true" or "false".

>  }
>  
>  static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> index bfd11591faf4..751159d71223 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -408,6 +408,23 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
>  	return ret;
>  }
>  
> +static int realtek_smi_hwreset(struct realtek_priv *priv, bool active)
> +{
> +#ifdef CONFIG_RESET_CONTROLLER
> +	if (priv->reset_ctl) {
> +		if (active)
> +			return reset_control_assert(priv->reset_ctl);
> +		else
> +			return reset_control_deassert(priv->reset_ctl);
> +	}
> +#endif
> +
> +	if (priv->reset)
> +		gpiod_set_value(priv->reset, active);
> +
> +	return 0;
> +}

What is the reason for duplicating realtek_mdio_hwreset()?

