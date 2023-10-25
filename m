Return-Path: <netdev+bounces-44234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E07D7347
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413C3281CC6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF71BDF9;
	Wed, 25 Oct 2023 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcyoM3NJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6631A77
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 18:30:42 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADF9AB
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:30:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507bd644a96so8855441e87.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698258639; x=1698863439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vDVKoLoJ4dyFfeYV9ndAiG0dnLZU/HFcZhyPY9CUWYo=;
        b=UcyoM3NJTmBhn1utrk4Pxnkft1tMN0U1E+eS76ZwoPDBsc15bLPLPY2p0v9MDwqYGQ
         wQkfz8oGE2wDHEy8z3tbE4G52hXux7zZYraSKT4r2nw4aD9trwjjNF62KLt9QldFQwZv
         TABvQ0GRh+9fX06ciOY9WxSlgzduIA/+TzKcUBtca9zRn3dBTvYeRyYI3yCbzwnGpez9
         dJptzL6/f8ahNhQmsJNkQOmOHtpIbGvnVDChEMXnZaABA+FQSIucJ90SUrvmwNKKMKnf
         /MDnzLbxjOGeTLKFu1HkRHNRJmab6ApJjYl4g6caBlZNlZ852ZK27Mfs/446byxQTAA+
         6z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258639; x=1698863439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDVKoLoJ4dyFfeYV9ndAiG0dnLZU/HFcZhyPY9CUWYo=;
        b=Xb3T/TrUV1Bq0U+hM2hZegnb//52VWyYBLH9VnoAPOA9SmFCXSQqOnsmjRnQxlH5Vn
         PrKk7ZHQQDBCkv6UJEY+kDdcNbvPUGC4/3dhSH+i5HLq9ebE0tNdcReSw1FIMASxcVEp
         0fG+plTq0SF/6drEyuTD6POOFs8KXgG+jr8o4/cg+AwidCN6TazaxMuIQZuHLMPVJU6W
         oY5U97pyO9xZ/6K5tw9kRk3hVY8HQqrDwQfmMbYwF9dBr8G+tyfTTaSjPsTL/QodjbXF
         qVpxe65gX/YlKWcRs9Nya7+nqp0OQEhCZZSIusgW/+XnSIjha7qDlYFamO3poE1EXhSH
         FMfw==
X-Gm-Message-State: AOJu0Yx0hdlEt0iLE9bzO6v+R6Ues3KXfMh8fcHp6T35DfDpfjcU/SNi
	tKAy9vY0mfTXzEs/xric9E7XEpuTJCnblIQfsQU=
X-Google-Smtp-Source: AGHT+IEdfW+l6RVK04zgkV8oMHeJmlQ1CfBGYP+wvn9XxKWCodbJivlv8BKr2NDqIl8v9Iz6tSZNF5BPRO2NA8A0mfM=
X-Received: by 2002:a19:ee13:0:b0:507:96a3:596d with SMTP id
 g19-20020a19ee13000000b0050796a3596dmr11277368lfb.49.1698258638359; Wed, 25
 Oct 2023 11:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024205805.19314-1-luizluca@gmail.com> <20231024223339.ccyybyvzrd22bxnh@skbuf>
In-Reply-To: <20231024223339.ccyybyvzrd22bxnh@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 25 Oct 2023 15:30:27 -0300
Message-ID: <CAJq09z7miTe7HUzsL4GBSwkrzyy4mVi6z40+ETgvmY=iWGRN-g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: support reset controller
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Oct 24, 2023 at 05:58:04PM -0300, Luiz Angelo Daros de Luca wrote:
> > The 'reset-gpios' will not work when the switch reset is controlled by a
> > reset controller.
> >
> > Although the reset is optional and the driver performs a soft reset
> > during setup, if the initial reset state was asserted, the driver will
> > not detect it.
> >
> > This is an example of how to use the reset controller:
> >
> >         switch {
> >                 compatible = "realtek,rtl8366rb";
> >
> >                 resets = <&rst 8>;
> >                 reset-names = "switch";
> >
> >               ...
> >       }
>
> Mix of tabs and spaces here.
> Also, examples belong to the dt-schema.

OK

>
> >
> > The reset controller will take precedence over the reset GPIO.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  drivers/net/dsa/realtek/realtek-mdio.c | 36 +++++++++++++++++++++-----
> >  drivers/net/dsa/realtek/realtek-smi.c  | 34 +++++++++++++++++++-----
> >  drivers/net/dsa/realtek/realtek.h      |  6 +++++
> >  3 files changed, 63 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 292e6d087e8b..600124c58c00 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -140,6 +140,23 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
> >       .disable_locking = true,
> >  };
> >
> > +static int realtek_mdio_hwreset(struct realtek_priv *priv, bool active)
> > +{
> > +#ifdef CONFIG_RESET_CONTROLLER
> > +     if (priv->reset_ctl) {
> > +             if (active)
> > +                     return reset_control_assert(priv->reset_ctl);
> > +             else
> > +                     return reset_control_deassert(priv->reset_ctl);
> > +     }
> > +#endif
> > +
> > +     if (priv->reset)
> > +             gpiod_set_value(priv->reset, active);
> > +
> > +     return 0;
> > +}
> > +
>
> This "bool active" artificially unifies two discrete code paths in the
> same function, where the callers are not the same and the implementation
> is not the same (given a priv->reset_ctl presence), separated by an "if".
>
> Would it make more sense to have discrete functions, each with its
> unique caller, like this?
>
> static int realtek_reset_assert(struct realtek_priv *priv)
> {
>         if (priv->reset_ctl)
>                 return reset_control_assert(priv->reset_ctl);
>
>         if (priv->reset)
>                 gpiod_set_value(priv->reset, 1);
>
>         return 0;
> }
>
> static int realtek_reset_deassert(struct realtek_priv *priv)
> {
>         if (priv->reset_ctl)
>                 return reset_control_deassert(priv->reset_ctl);
>
>         if (priv->reset)
>                 gpiod_set_value(priv->reset, 0);
>
>         return 0;
> }

Sure. It is better.

> Also, you return int but ignore error values everywhere. I guess it
> would make more sense to return void, but print warnings within the
> reset functions if the calls to the reset control fail.
>
> >  static int realtek_mdio_probe(struct mdio_device *mdiodev)
> >  {
> >       struct realtek_priv *priv;
> > @@ -194,20 +211,26 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
> >
> >       dev_set_drvdata(dev, priv);
> >
> > -     /* TODO: if power is software controlled, set up any regulators here */
>
> I'm not sure if "power" and "reset" are the same thing...
>
> >       priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
> >
> > +#ifdef CONFIG_RESET_CONTROLLER
> > +     priv->reset_ctl = devm_reset_control_get(dev, "switch");
> > +     if (IS_ERR(priv->reset_ctl)) {
> > +             dev_err(dev, "failed to get switch reset control\n");
> > +             return PTR_ERR(priv->reset_ctl);
>
>                 ret = PTR_ERR(priv->reset_ctl);
>                 return dev_err_probe(dev, err, "failed to get reset control\n");
>
> This suppresses -EPROBE_DEFER prints.

OK

>
> > +     }
> > +#endif
> > +
> >       priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> >       if (IS_ERR(priv->reset)) {
> >               dev_err(dev, "failed to get RESET GPIO\n");
> >               return PTR_ERR(priv->reset);
> >       }
> > -
> > -     if (priv->reset) {
> > -             gpiod_set_value(priv->reset, 1);
> > +     if (priv->reset_ctl || priv->reset) {
> > +             realtek_mdio_hwreset(priv, 1);
> >               dev_dbg(dev, "asserted RESET\n");
> >               msleep(REALTEK_HW_STOP_DELAY);
> > -             gpiod_set_value(priv->reset, 0);
> > +             realtek_mdio_hwreset(priv, 0);
> >               msleep(REALTEK_HW_START_DELAY);
> >               dev_dbg(dev, "deasserted RESET\n");
> >       }
> > @@ -246,8 +269,7 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
> >       dsa_unregister_switch(priv->ds);
> >
> >       /* leave the device reset asserted */
> > -     if (priv->reset)
> > -             gpiod_set_value(priv->reset, 1);
> > +     realtek_mdio_hwreset(priv, 1);
>
> nitpick: "bool" arguments should take "true" or "false".

OK

>
> >  }
> >
> >  static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> > diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> > index bfd11591faf4..751159d71223 100644
> > --- a/drivers/net/dsa/realtek/realtek-smi.c
> > +++ b/drivers/net/dsa/realtek/realtek-smi.c
> > @@ -408,6 +408,23 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
> >       return ret;
> >  }
> >
> > +static int realtek_smi_hwreset(struct realtek_priv *priv, bool active)
> > +{
> > +#ifdef CONFIG_RESET_CONTROLLER
> > +     if (priv->reset_ctl) {
> > +             if (active)
> > +                     return reset_control_assert(priv->reset_ctl);
> > +             else
> > +                     return reset_control_deassert(priv->reset_ctl);
> > +     }
> > +#endif
> > +
> > +     if (priv->reset)
> > +             gpiod_set_value(priv->reset, active);
> > +
> > +     return 0;
> > +}
>
> What is the reason for duplicating realtek_mdio_hwreset()?

Both interface modules, realtek-smi and realtek-mdio, do not share
code, except for the realtek.h header file. I don't know if it is
worth it to put the code in a new shared module. What is the best
practice here? Create a realtek_common.c linked to both modules?

Regards,

Luiz

