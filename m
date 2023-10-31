Return-Path: <netdev+bounces-45352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD97DC39C
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 01:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A2B20CD5
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 00:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DA6365;
	Tue, 31 Oct 2023 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg6MKbgG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2848110D
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 00:31:00 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E8EA9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 17:30:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507f1c29f25so7053611e87.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698712257; x=1699317057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNHoKAVEG6TuXxdwoqHBkOX3RuDdDda789iFr0CjnJs=;
        b=Bg6MKbgGHNVPuRl1BJbo1lj6xBm0/wJ0grgNQGLdsCQ/FaDG9vCAr3+cXfrC2OM8IB
         kzTpvqQME2Y3fcQPj/jtpS/53descD1WxLl34zp2SbJHXveWD0puxHWR80miBoNXMA4B
         VHHm2Jkwgo1H5k0UJvmeiispZ/3JWr1+SgeQaLpRUkrzPK9BoyBPMmm1l4/RtgldIyw4
         qFoPWmCdEU9ie8ex3g/Tb6Nwh2G22BR5/AKYiczoSspPajOBqKurlYEO6rihpiRz9vdC
         OG8RnKTbdooCRcGqcfPOswjQDY8YjOZ8Fuv4cV6yRdN9SXEb0B+O72Pb7eebFWCWyoaZ
         9aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698712257; x=1699317057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNHoKAVEG6TuXxdwoqHBkOX3RuDdDda789iFr0CjnJs=;
        b=rFDI2XzDwL/1HoQE4GncA8rBzuurx16naT3RB9s0pYvpibSnDpk5NRu2Tr0qtMB5AX
         GXM5BQhRfgSjIbg/0/CST5h1l4PVuXvrh+LyJNVBlxHSYCll+A3jF3GLGGSZnC51FDw4
         XMAYbu8jxeQLxq/uLOkWz8sWrFKw5flAH5pVmXw+uY5tkWhR0hDu1B4cV4Y/VwNVgrVh
         nNTwFPAeAE6fNPOV/oJm5c4sgi8oSxChvraZH3xKK7o7ewmaKIvSSl4iHUNsOFvdovff
         PYOus48kEUyD29zYUGWKYp19bpbqcISh+dg1f5nkaoOeqoZbQzg9Wrctbi9LPoAbV77h
         gyzQ==
X-Gm-Message-State: AOJu0Yz189A3vSpOzCIED8J+el28XaIOwwiNO9tF7sfbcyNVe+uGE/1C
	qtUDFGgwAQn9zBfnRnBsRhm50zr7XyA1JpOcbbI=
X-Google-Smtp-Source: AGHT+IGRQhRDYBFCIGXXq313T1Qr1tLuznIvI7sU4BozTfzBOnGQGCjytyAlQMLHNiu35/B6MQ9FPo0EzSIc/LOhMZc=
X-Received: by 2002:a05:6512:3caa:b0:509:f6b:1de1 with SMTP id
 h42-20020a0565123caa00b005090f6b1de1mr7193805lfv.12.1698712256625; Mon, 30
 Oct 2023 17:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027190910.27044-1-luizluca@gmail.com> <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf>
In-Reply-To: <20231030205025.b4dryzqzuunrjils@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 30 Oct 2023 21:30:45 -0300
Message-ID: <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset controller
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> On Fri, Oct 27, 2023 at 04:00:57PM -0300, Luiz Angelo Daros de Luca wrote:
> > The 'reset-gpios' will not work when the switch reset is controlled by a
> > reset controller.
> >
> > Although the reset is optional and the driver performs a soft reset
> > during setup, if the initial reset state was asserted, the driver will
> > not detect it.
> >
> > The reset controller will take precedence over the reset GPIO.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  drivers/net/dsa/realtek/realtek-mdio.c | 51 ++++++++++++++++++++++----
> >  drivers/net/dsa/realtek/realtek-smi.c  | 49 ++++++++++++++++++++++---
> >  drivers/net/dsa/realtek/realtek.h      |  2 +
> >  3 files changed, 89 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 292e6d087e8b..aad94e49d4c9 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -140,6 +140,40 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
> >       .disable_locking = true,
> >  };
> >
> > +static void realtek_mdio_reset_assert(struct realtek_priv *priv)
> > +{
> > +     int ret;
> > +
> > +     if (priv->reset_ctl) {
> > +             ret = reset_control_assert(priv->reset_ctl);
> > +             if (ret)
> > +                     dev_warn(priv->dev, "Failed to assert the switch reset control. Error: %i",
> > +                              ret);
>
> Instead of "Error: %i" you can say ".. reset control: %pe\n", ERR_PTR(ret)
> which will print the error as a symbolic error name (if CONFIG_SYMBOLIC_ERRNAME=y)
> rather than just a numeric value.
>
> Also, I don't know if this is explicit in the coding style, but I
> believe it is more consistent if single function calls are enveloped in
> curly braces if they span multiple lines, like so:
>
>                 if (ret) {
>                         dev_warn(priv->dev,
>                                  "Failed to assert the switch reset control: %pe",
>                                  ERR_PTR(ret));
>                 }
>
> Also, please note that netdev still prefers the 80 character line limit.

Sure.

> > +
> > +             return;
> > +     }
> > +
> > +     if (priv->reset)
> > +             gpiod_set_value(priv->reset, true);
> > +}
> > +
> > +static void realtek_mdio_reset_deassert(struct realtek_priv *priv)
> > +{
> > +     int ret;
> > +
> > +     if (priv->reset_ctl) {
> > +             ret = reset_control_deassert(priv->reset_ctl);
> > +             if (ret)
> > +                     dev_warn(priv->dev, "Failed to deassert the switch reset control. Error: %i",
> > +                              ret);
> > +
> > +             return;
>
> Is there a particular reason why this has to ignore a reset GPIO if
> present, rather than fall through, checking for the latter as well?

Something like this, disregard white space issues?

static void realtek_smi_reset_assert(struct realtek_priv *priv)
{
       int ret;

       if (priv->reset_ctl) {
               ret = reset_control_assert(priv->reset_ctl);
               if (!ret)
                       return;

               dev_warn(priv->dev,
                        "Failed to assert the switch reset control: %pe\n",
                        ERR_PTR(ret));
       }

       if (priv->reset)
               gpiod_set_value(priv->reset, true);
}

> > +     }
> > +
> > +     if (priv->reset)
> > +             gpiod_set_value(priv->reset, false);
> > +}
> > +
> >  static int realtek_mdio_probe(struct mdio_device *mdiodev)
> >  {
> >       struct realtek_priv *priv;
> > @@ -194,20 +228,24 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
> >
> >       dev_set_drvdata(dev, priv);
> >
> > -     /* TODO: if power is software controlled, set up any regulators here */
>
> As Andrew mentions, this commit does not make power software-controlled,
> so don't remove this.

I'll return it and move specific this TODO after the leds_disabled as
it should be before the reset. The one in realtek-smi was in the right
position.

> >       priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
> >
> > +     priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
> > +     if (IS_ERR(priv->reset_ctl)) {
> > +             ret = PTR_ERR(priv->reset_ctl);
> > +             return dev_err_probe(dev, ret, "failed to get reset control\n");
> > +     }
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
> > +             realtek_mdio_reset_assert(priv);
> >               dev_dbg(dev, "asserted RESET\n");
> >               msleep(REALTEK_HW_STOP_DELAY);
> > -             gpiod_set_value(priv->reset, 0);
> > +             realtek_mdio_reset_deassert(priv);
> >               msleep(REALTEK_HW_START_DELAY);
> >               dev_dbg(dev, "deasserted RESET\n");
> >       }
> > @@ -246,8 +284,7 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
> >       dsa_unregister_switch(priv->ds);
> >
> >       /* leave the device reset asserted */
> > -     if (priv->reset)
> > -             gpiod_set_value(priv->reset, 1);
> > +     realtek_mdio_reset_assert(priv);
> >  }
> >
> >  static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> > diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> > index bfd11591faf4..a99e53b5b662 100644
> > --- a/drivers/net/dsa/realtek/realtek-smi.c
> > +++ b/drivers/net/dsa/realtek/realtek-smi.c
> > @@ -408,6 +408,40 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
> >       return ret;
> >  }
> >
> > +static void realtek_smi_reset_assert(struct realtek_priv *priv)
> > +{
> > +     int ret;
> > +
> > +     if (priv->reset_ctl) {
> > +             ret = reset_control_assert(priv->reset_ctl);
> > +             if (ret)
> > +                     dev_warn(priv->dev, "Failed to assert the switch reset control. Error: %i",
> > +                              ret);
> > +
> > +             return;
> > +     }
> > +
> > +     if (priv->reset)
> > +             gpiod_set_value(priv->reset, true);
> > +}
> > +
> > +static void realtek_smi_reset_deassert(struct realtek_priv *priv)
> > +{
> > +     int ret;
> > +
> > +     if (priv->reset_ctl) {
> > +             ret = reset_control_deassert(priv->reset_ctl);
> > +             if (ret)
> > +                     dev_warn(priv->dev, "Failed to deassert the switch reset control. Error: %i",
> > +                              ret);
> > +
> > +             return;
> > +     }
> > +
> > +     if (priv->reset)
> > +             gpiod_set_value(priv->reset, false);
> > +}
> > +
>
> To respond here, in a single email, to your earlier question (sorry):
> https://lore.kernel.org/netdev/CAJq09z7miTe7HUzsL4GBSwkrzyy4mVi6z40+ETgvmY=iWGRN-g@mail.gmail.com/
>
> | Both interface modules, realtek-smi and realtek-mdio, do not share
> | code, except for the realtek.h header file. I don't know if it is
> | worth it to put the code in a new shared module. What is the best
> | practice here? Create a realtek_common.c linked to both modules?
>
> The answer is: I ran "meld" between realtek-mdio.c and realtek-smi.c,
> and the probe, remove and shutdown functions are surprisingly similar
> already, and perhaps might become even more similar in the future.
> I think it is worth introducing a common kernel module for both
> interface drivers as a preliminary patch, rather than keeping duplicated
> probe/remove/shutdown code.

The remove/shutdown are probably similar to any other DSA driver. I
think the extra code around a shared code in a new module would be
bigger than the duplicated code.

realtek-mdio is an MDIO driver while realtek-smi is a platform driver
implementing a bitbang protocol. They might never be used together in
a system to share RAM and not even installed together in small
systems. If I do need to share the code, I would just link it twice.
Would something like this be acceptable?

drivers/net/dsa/realtek/Makefile
-obj-$(CONFIG_NET_DSA_REALTEK_MDIO)     += realtek-mdio.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI)      += realtek-smi.o
+obj-$(CONFIG_NET_DSA_REALTEK_MDIO)     += realtek-mdio.o realtek_common.o
+obj-$(CONFIG_NET_DSA_REALTEK_SMI)      += realtek-smi.o realtek_common.o

drivers/net/dsa/realtek/realtek.h:
+void realtek_reset_assert(struct realtek_priv *priv);
+void realtek_reset_deassert(struct realtek_priv *priv);

realtek_common:
+void realtek_reset_assert(struct realtek_priv *priv) {}
+void realtek_reset_deassert(struct realtek_priv *priv) {}

If that realtek_common grows, we could convert it into a module. For
now, it would just introduce extra complexity.

> >  static int realtek_smi_probe(struct platform_device *pdev)
> >  {
> >       const struct realtek_variant *var;
> > @@ -457,18 +491,22 @@ static int realtek_smi_probe(struct platform_device *pdev)
> >       dev_set_drvdata(dev, priv);
> >       spin_lock_init(&priv->lock);
> >
> > -     /* TODO: if power is software controlled, set up any regulators here */
> > +     priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
> > +     if (IS_ERR(priv->reset_ctl)) {
> > +             ret = PTR_ERR(priv->reset_ctl);
> > +             return dev_err_probe(dev, ret, "failed to get reset control\n");
> > +     }
> >
> >       priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> >       if (IS_ERR(priv->reset)) {
> >               dev_err(dev, "failed to get RESET GPIO\n");
> >               return PTR_ERR(priv->reset);
> >       }
> > -     if (priv->reset) {
> > -             gpiod_set_value(priv->reset, 1);
> > +     if (priv->reset_ctl || priv->reset) {
> > +             realtek_smi_reset_assert(priv);
> >               dev_dbg(dev, "asserted RESET\n");
> >               msleep(REALTEK_HW_STOP_DELAY);
> > -             gpiod_set_value(priv->reset, 0);
> > +             realtek_smi_reset_deassert(priv);
> >               msleep(REALTEK_HW_START_DELAY);
> >               dev_dbg(dev, "deasserted RESET\n");
> >       }
> > @@ -518,8 +556,7 @@ static void realtek_smi_remove(struct platform_device *pdev)
> >               of_node_put(priv->slave_mii_bus->dev.of_node);
>
> slave_mii_bus was renamed to user_mii_bus, and this prevents the
> application of the patch currently, so you will need to respin. But I
> think net-next is going to close soon for 2 weeks, so either you respin
> as RFC or you wait until it reopens.

I'll wait. I hope the comments on this thread might be enough to get
this patch sorted out.

>
> >
> >       /* leave the device reset asserted */
> > -     if (priv->reset)
> > -             gpiod_set_value(priv->reset, 1);
> > +     realtek_smi_reset_assert(priv);
> >  }
> >

Regards,

Luiz

