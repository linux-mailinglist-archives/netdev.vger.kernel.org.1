Return-Path: <netdev+bounces-48852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97BC7EFC00
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B01F21664
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C94446CB;
	Fri, 17 Nov 2023 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km+Cl07g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C6CD5D
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:05:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507e85ebf50so3336335e87.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700262301; x=1700867101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gwemhbNNOs1AoIO1rwc7E7AXMu1ZYSaTMIOhbsK1JJI=;
        b=Km+Cl07g3FimukPf/YSIXN6n/dqsDdWEDcxkSNxYNxYM42Kb5RW1x/GiCsdE1J1Qpn
         2fHiLResHS+uolryr4qTN3nS9cGaW7cT/sCIrIkjGvfcUBkMYnXT25HCHCwdOw9+Tn2B
         +BibHIdH+w79XkZP0KCghGrW0yZyF2JY2CSCK6Cvd3YrRV8Ei2dYMc83I7/BCy4AguFN
         1xcVjfifohWMFnMHsHr8euoaDfwyVrFNUlrB0pSKqwglGTYummIShMnTf7g45L9b1qLE
         1RjvB08kp8/kXj7876yD9HTI+8Mq+b1GgH+IbqibswtjbpniYKFJ93GVt3XBolnhCXCL
         UGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700262301; x=1700867101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwemhbNNOs1AoIO1rwc7E7AXMu1ZYSaTMIOhbsK1JJI=;
        b=QyUmHXhiS77DaLqQHvX4PEg1OaY+vdhWXBAkz6/BIbtDmVBQz9F/SetKlDRuAc1lgY
         QbLS+8z6b7f8uCJl9WT/lLcOYMoiNEy9lYIXabjrF69oMlsSZ3zAu5nvj35cBqPNQD7U
         pQ8I+eTKlkGjbLeTmCCU803zL3uPy6vy73dOXj/b6LgccV0Yw3iTlgxF0RrtNnzDyDW2
         PFwyDgKrNtDmC7RVlCbUZXx+OPtYNm6rWohi5TY2hnQsxTwwqAHQ1X9Lvkn3zCGGyYJ1
         uKXAiz0PpcmQHrzDGEdfCyO3Ue961mhuX9VFW5nk7Jc7ldDaJRidtJV3vp9vsDP/ALTh
         sVmw==
X-Gm-Message-State: AOJu0YwiCmy9h+CFfjhE35rZw/FBO8VboCBTcWCIg6gEG5qnRr9IjpMp
	vFYGdDvBHq3r9o4ZYA5GgxvxSxJquZIv3/6Pqd8=
X-Google-Smtp-Source: AGHT+IFO5bLTIDXPfu+3sPgqf63cAZbCRlsnZ88qcZBGbHXRHbSuIhzO58kc8L0jk3osvGe+BvAlpaeeSSZZwbOdDgc=
X-Received: by 2002:ac2:4157:0:b0:509:8f66:2617 with SMTP id
 c23-20020ac24157000000b005098f662617mr615375lfi.42.1700262300387; Fri, 17 Nov
 2023 15:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111215647.4966-1-luizluca@gmail.com> <20231111215647.4966-4-luizluca@gmail.com>
 <hwqjwynektptoyyx3yqfnckb7yx5wd6ykvjc4wtdsklp35yal6@c33vrtbkehwk>
In-Reply-To: <hwqjwynektptoyyx3yqfnckb7yx5wd6ykvjc4wtdsklp35yal6@c33vrtbkehwk>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 17 Nov 2023 20:04:48 -0300
Message-ID: <CAJq09z7PC+ykW7ejTQZgmb8+fHBDCwPZ4W1X92Z5DNeKY6d+Sg@mail.gmail.com>
Subject: Re: [RFC net-next 3/5] net: dsa: realtek: create realtek-common
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> > Some code can be shared between both interface modules (MDIO and SMI)
> > and amongst variants. For now, these interface functions are shared:
> >
> > - realtek_common_lock
> > - realtek_common_unlock
> > - realtek_common_probe
> > - realtek_common_remove
> >
> > The reset during probe was moved to the last moment before a variant
> > detects the switch. This way, we avoid a reset if anything else fails.
> >
> > The symbols from variants used in of_match_table are now in a single
> > match table in realtek-common, used by both interfaces.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  drivers/net/dsa/realtek/Makefile         |   1 +
> >  drivers/net/dsa/realtek/realtek-common.c | 139 +++++++++++++++++++++++
> >  drivers/net/dsa/realtek/realtek-common.h |  16 +++
> >  drivers/net/dsa/realtek/realtek-mdio.c   | 116 +++----------------
> >  drivers/net/dsa/realtek/realtek-smi.c    | 127 +++------------------
> >  drivers/net/dsa/realtek/realtek.h        |   2 +
> >  6 files changed, 184 insertions(+), 217 deletions(-)
> >  create mode 100644 drivers/net/dsa/realtek/realtek-common.c
> >  create mode 100644 drivers/net/dsa/realtek/realtek-common.h
> >
> > diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
> > index 0aab57252a7c..5e0c1ef200a3 100644
> > --- a/drivers/net/dsa/realtek/Makefile
> > +++ b/drivers/net/dsa/realtek/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_NET_DSA_REALTEK)                += realtek-common.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_MDIO)   += realtek-mdio.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_SMI)    += realtek-smi.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
> > diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
> > new file mode 100644
> > index 000000000000..36f8b60771be
> > --- /dev/null
> > +++ b/drivers/net/dsa/realtek/realtek-common.c
> > @@ -0,0 +1,139 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <linux/module.h>
> > +
> > +#include "realtek.h"
> > +#include "realtek-common.h"
> > +
> > +void realtek_common_lock(void *ctx)
> > +{
> > +     struct realtek_priv *priv = ctx;
> > +
> > +     mutex_lock(&priv->map_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_common_lock);
> > +
> > +void realtek_common_unlock(void *ctx)
> > +{
> > +     struct realtek_priv *priv = ctx;
> > +
> > +     mutex_unlock(&priv->map_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_common_unlock);
>
> Shouldn't you update the raw mutex_{lock,unlock}() calls in the chip drivers to
> use these common functions as well?

I wasn't focusing on chip drivers for now but, yes, they should. There
might be more code to be shared between those chip drivers but I don't
want to touch that for now.

> > +struct realtek_priv *realtek_common_probe(struct device *dev,
> > +             struct regmap_config rc, struct regmap_config rc_nolock)
> > +{
> > +     const struct realtek_variant *var;
> > +     struct realtek_priv *priv;
> > +     struct device_node *np;
> > +     int ret;
> > +
> > +     var = of_device_get_match_data(dev);
> > +     if (!var)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     priv = devm_kzalloc(dev, size_add(sizeof(*priv), var->chip_data_sz),
> > +                         GFP_KERNEL);
> > +     if (!priv)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     mutex_init(&priv->map_lock);
> > +
> > +     rc.lock_arg = priv;
> > +     priv->map = devm_regmap_init(dev, NULL, priv, &rc);
> > +     if (IS_ERR(priv->map)) {
> > +             ret = PTR_ERR(priv->map);
> > +             dev_err(dev, "regmap init failed: %d\n", ret);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc_nolock);
> > +     if (IS_ERR(priv->map_nolock)) {
> > +             ret = PTR_ERR(priv->map_nolock);
> > +             dev_err(dev, "regmap init failed: %d\n", ret);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     /* Link forward and backward */
> > +     priv->dev = dev;
>
> > +     priv->clk_delay = var->clk_delay;
> > +     priv->cmd_read = var->cmd_read;
> > +     priv->cmd_write = var->cmd_write;
>
> These are only used by the SMI interface. Since you are storing a pointer to var
> in priv anyway, maybe you can remove this part and update the SMI code to use
> priv->var->clk_delay etc. Because this is not really common.

Yes. variants are statically allocated and there is no reason to copy
those static values to a dynamic allocated structure.
I'll drop them and use the variant reference.

> The same goes for a couple of other things inside the realtek_priv struct,
> e.g. mdio_addr. At the risk of making things too hairy, perhaps you could have
> an interface_data pointer just like there is a chip_data pointer. Then the
> per-interface stuff can be stored there and the common code is truly common.

I think these are all fields used only by MDIO interface:

       struct mii_bus          *bus;
       int                     mdio_addr;
       struct mii_bus          *user_mii_bus;
       spinlock_t              lock;

And these are for SMI:

       struct gpio_desc        *mdc;
       struct gpio_desc        *mdio;

I don't know the kernel internal memory allocator but I believe that a
couple of unused fields in a structure might be better than using
kmalloc twice.

> > +     priv->variant = var;
> > +     priv->ops = var->ops;
> > +     priv->chip_data = (void *)priv + sizeof(*priv);
> > +
> > +     dev_set_drvdata(dev, priv);
> > +     spin_lock_init(&priv->lock);
> > +
> > +     /* Fetch MDIO pins */
> > +     priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
> > +     if (IS_ERR(priv->mdc))
> > +             return ERR_CAST(priv->mdc);
> > +
> > +     priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
> > +     if (IS_ERR(priv->mdio))
> > +             return ERR_CAST(priv->mdio);
>
> Also not common, but specific to the SMI interface driver.

I was trying to do all the device-tree ops before actually resetting
the switch just to let it possibly fail sooner than the msleep().
However, a failed device-tree prop that would break probing is just
too rare in a production system to care. I'll move it to realtek-smi.

> > +
> > +     np = dev->of_node;
> > +
> > +     priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
> > +
> > +     /* TODO: if power is software controlled, set up any regulators here */
> > +
> > +     priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > +     if (IS_ERR(priv->reset)) {
> > +             dev_err(dev, "failed to get RESET GPIO\n");
> > +             return ERR_CAST(priv->reset);
> > +     }
> > +     if (priv->reset) {
> > +             gpiod_set_value(priv->reset, 1);
> > +             dev_dbg(dev, "asserted RESET\n");
> > +             msleep(REALTEK_HW_STOP_DELAY);
> > +             gpiod_set_value(priv->reset, 0);
> > +             msleep(REALTEK_HW_START_DELAY);
> > +             dev_dbg(dev, "deasserted RESET\n");
> > +     }
> > +
> > +     priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
> > +     if (!priv->ds)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     priv->ds->dev = dev;
> > +     priv->ds->priv = priv;
>
> Any reason why you left the assignment of ds->num_ports in the interface
> drivers?

The priv->num_ports is set by the chip variants during
priv->ops->detect(priv), which requires some priv setting specific for
each interface. In fact, I noticed that when I tested the code.

> > +
> > +     return priv;
> > +}
> > +EXPORT_SYMBOL(realtek_common_probe);
> > +
> > +void realtek_common_remove(struct realtek_priv *priv)
> > +{
> > +     if (!priv)
> > +             return;
> > +
> > +     dsa_unregister_switch(priv->ds);
>
> It seems a little unbalanced to me that the interface driver's probe function is
> responsible for calling dsa_register_switch(), but the common code calls
> dsa_unregister_switch().

Yes, it is. I don't like it but moving the detect+register code to a
realtek_common_{probe2/detect/register} will create a strange function
and splitting them will be too much abstraction for nothing.
It will get a little worse in the 4/5 patch when we need to call
realtek_variant_put() that will run module_put() if the probe fails.
It would be easier if we had a devm_try_module_get() that would handle
the module_put().

> I understand that you have already done a lot here - all you wanted was to
> support reset controllers after all :) - so you don't need to do all this
> stuff I am suggesting if you don't want to. But for the parts that you do touch,
> please try to keep some balance so that subsequent refactoring is easier.
>
> > +     if (priv->user_mii_bus)
> > +             of_node_put(priv->user_mii_bus->dev.of_node);
>
> Similarly this is only used by the SMI interface driver. I think there is a
> general need for balance here - not that it was great to begin with. There is
> already a setup_interface op in realtek_priv, which is called in the DSA setup
> op of the chip drivers. Intuitively I would then expect a teardown_interface op
> in realtek_priv to be called in the DSA teardown op of the chip drivers.

I agree. The same module responsible to register/get should be the one
unregistering/putting whenever possible.

We might need some extra refactoring. I just noticed, for example,
realtek_ops->cleanup is not in use. I believe rtl8366-core.c would
better fit in realtek-common as it is probably usable by rtl8365mb for
vlan support. However, I prefer to merge this smaller series that will
already give the users benefits while it also paves the way for
further refactoring.

> > +
> > +     /* leave the device reset asserted */
> > +     if (priv->reset)
> > +             gpiod_set_value(priv->reset, 1);
> > +}
> > +EXPORT_SYMBOL(realtek_common_remove);
> > +
> > +const struct of_device_id realtek_common_of_match[] = {
> > +#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
> > +     { .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
> > +#endif
> > +#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
> > +     { .compatible = "realtek,rtl8365mb", .data = &rtl8366rb_variant, },
>
> Copy-paste error? .data = &rtl8365mb_variant.

Yes. I didn't test this intermediate patch with rtl8365mb. Thanks.


>
> > +#endif
> > +     { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, realtek_common_of_match);
> > +EXPORT_SYMBOL_GPL(realtek_common_of_match);
> > +
> > +MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
> > +MODULE_DESCRIPTION("Realtek DSA switches common module");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
> > new file mode 100644
> > index 000000000000..90a949386518
> > --- /dev/null
> > +++ b/drivers/net/dsa/realtek/realtek-common.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef _REALTEK_INTERFACE_H
> > +#define _REALTEK_INTERFACE_H
> > +
> > +#include <linux/regmap.h>
> > +
> > +extern const struct of_device_id realtek_common_of_match[];
> > +
> > +void realtek_common_lock(void *ctx);
> > +void realtek_common_unlock(void *ctx);
> > +struct realtek_priv *realtek_common_probe(struct device *dev,
> > +             struct regmap_config rc, struct regmap_config rc_nolock);
> > +void realtek_common_remove(struct realtek_priv *priv);
> > +
> > +#endif
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 292e6d087e8b..6f610386c977 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/regmap.h>
> >
> >  #include "realtek.h"
> > +#include "realtek-common.h"
> >
> >  /* Read/write via mdiobus */
> >  #define REALTEK_MDIO_CTRL0_REG               31
> > @@ -99,20 +100,6 @@ static int realtek_mdio_read(void *ctx, u32 reg, u32 *val)
> >       return ret;
> >  }
> >
> > -static void realtek_mdio_lock(void *ctx)
> > -{
> > -     struct realtek_priv *priv = ctx;
> > -
> > -     mutex_lock(&priv->map_lock);
> > -}
> > -
> > -static void realtek_mdio_unlock(void *ctx)
> > -{
> > -     struct realtek_priv *priv = ctx;
> > -
> > -     mutex_unlock(&priv->map_lock);
> > -}
> > -
> >  static const struct regmap_config realtek_mdio_regmap_config = {
> >       .reg_bits = 10, /* A4..A0 R4..R0 */
> >       .val_bits = 16,
> > @@ -123,8 +110,8 @@ static const struct regmap_config realtek_mdio_regmap_config = {
> >       .reg_read = realtek_mdio_read,
> >       .reg_write = realtek_mdio_write,
> >       .cache_type = REGCACHE_NONE,
> > -     .lock = realtek_mdio_lock,
> > -     .unlock = realtek_mdio_unlock,
> > +     .lock = realtek_common_lock,
> > +     .unlock = realtek_common_unlock,
> >  };
> >
> >  static const struct regmap_config realtek_mdio_nolock_regmap_config = {
> > @@ -142,75 +129,19 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
> >
> >  static int realtek_mdio_probe(struct mdio_device *mdiodev)
> >  {
> > -     struct realtek_priv *priv;
> >       struct device *dev = &mdiodev->dev;
> > -     const struct realtek_variant *var;
> > -     struct regmap_config rc;
> > -     struct device_node *np;
> > +     struct realtek_priv *priv;
> >       int ret;
> >
> > -     var = of_device_get_match_data(dev);
> > -     if (!var)
> > -             return -EINVAL;
> > -
> > -     priv = devm_kzalloc(&mdiodev->dev,
> > -                         size_add(sizeof(*priv), var->chip_data_sz),
> > -                         GFP_KERNEL);
> > -     if (!priv)
> > -             return -ENOMEM;
> > -
> > -     mutex_init(&priv->map_lock);
> > -
> > -     rc = realtek_mdio_regmap_config;
> > -     rc.lock_arg = priv;
> > -     priv->map = devm_regmap_init(dev, NULL, priv, &rc);
> > -     if (IS_ERR(priv->map)) {
> > -             ret = PTR_ERR(priv->map);
> > -             dev_err(dev, "regmap init failed: %d\n", ret);
> > -             return ret;
> > -     }
> > -
> > -     rc = realtek_mdio_nolock_regmap_config;
> > -     priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
> > -     if (IS_ERR(priv->map_nolock)) {
> > -             ret = PTR_ERR(priv->map_nolock);
> > -             dev_err(dev, "regmap init failed: %d\n", ret);
> > -             return ret;
> > -     }
> > +     priv = realtek_common_probe(dev, realtek_mdio_regmap_config,
> > +                                 realtek_mdio_nolock_regmap_config);
> > +     if (IS_ERR(priv))
> > +             return PTR_ERR(priv);
> >
> >       priv->mdio_addr = mdiodev->addr;
> >       priv->bus = mdiodev->bus;
> > -     priv->dev = &mdiodev->dev;
> > -     priv->chip_data = (void *)priv + sizeof(*priv);
> > -
> > -     priv->clk_delay = var->clk_delay;
> > -     priv->cmd_read = var->cmd_read;
> > -     priv->cmd_write = var->cmd_write;
> > -     priv->ops = var->ops;
> > -
> >       priv->write_reg_noack = realtek_mdio_write;
> > -
> > -     np = dev->of_node;
> > -
> > -     dev_set_drvdata(dev, priv);
> > -
> > -     /* TODO: if power is software controlled, set up any regulators here */
> > -     priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
> > -
> > -     priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > -     if (IS_ERR(priv->reset)) {
> > -             dev_err(dev, "failed to get RESET GPIO\n");
> > -             return PTR_ERR(priv->reset);
> > -     }
> > -
> > -     if (priv->reset) {
> > -             gpiod_set_value(priv->reset, 1);
> > -             dev_dbg(dev, "asserted RESET\n");
> > -             msleep(REALTEK_HW_STOP_DELAY);
> > -             gpiod_set_value(priv->reset, 0);
> > -             msleep(REALTEK_HW_START_DELAY);
> > -             dev_dbg(dev, "deasserted RESET\n");
> > -     }
> > +     priv->ds->ops = priv->variant->ds_ops_mdio;
> >
> >       ret = priv->ops->detect(priv);
> >       if (ret) {
> > @@ -218,18 +149,12 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
> >               return ret;
> >       }
> >
> > -     priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
> > -     if (!priv->ds)
> > -             return -ENOMEM;
> > -
> > -     priv->ds->dev = dev;
> >       priv->ds->num_ports = priv->num_ports;
> > -     priv->ds->priv = priv;
> > -     priv->ds->ops = var->ds_ops_mdio;
> >
> >       ret = dsa_register_switch(priv->ds);
> >       if (ret) {
> > -             dev_err(priv->dev, "unable to register switch ret = %d\n", ret);
> > +             dev_err_probe(dev, ret, "unable to register switch ret = %pe\n",
> > +                           ERR_PTR(ret));
> >               return ret;
> >       }
> >
> > @@ -243,11 +168,7 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
> >       if (!priv)
> >               return;
> >
> > -     dsa_unregister_switch(priv->ds);
> > -
> > -     /* leave the device reset asserted */
> > -     if (priv->reset)
> > -             gpiod_set_value(priv->reset, 1);
> > +     realtek_common_remove(priv);
> >  }
> >
> >  static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> > @@ -262,21 +183,10 @@ static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> >       dev_set_drvdata(&mdiodev->dev, NULL);
> >  }
> >
> > -static const struct of_device_id realtek_mdio_of_match[] = {
> > -#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
> > -     { .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
> > -#endif
> > -#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
> > -     { .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
> > -#endif
> > -     { /* sentinel */ },
> > -};
> > -MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
> > -
> >  static struct mdio_driver realtek_mdio_driver = {
> >       .mdiodrv.driver = {
> >               .name = "realtek-mdio",
> > -             .of_match_table = realtek_mdio_of_match,
> > +             .of_match_table = realtek_common_of_match,
> >       },
> >       .probe  = realtek_mdio_probe,
> >       .remove = realtek_mdio_remove,
> > diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> > index 755546ed8db6..0cf89f9db99e 100644
> > --- a/drivers/net/dsa/realtek/realtek-smi.c
> > +++ b/drivers/net/dsa/realtek/realtek-smi.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/if_bridge.h>
> >
> >  #include "realtek.h"
> > +#include "realtek-common.h"
> >
> >  #define REALTEK_SMI_ACK_RETRY_COUNT          5
> >
> > @@ -310,20 +311,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
> >       return realtek_smi_read_reg(priv, reg, val);
> >  }
> >
> > -static void realtek_smi_lock(void *ctx)
> > -{
> > -     struct realtek_priv *priv = ctx;
> > -
> > -     mutex_lock(&priv->map_lock);
> > -}
> > -
> > -static void realtek_smi_unlock(void *ctx)
> > -{
> > -     struct realtek_priv *priv = ctx;
> > -
> > -     mutex_unlock(&priv->map_lock);
> > -}
> > -
> >  static const struct regmap_config realtek_smi_regmap_config = {
> >       .reg_bits = 10, /* A4..A0 R4..R0 */
> >       .val_bits = 16,
> > @@ -334,8 +321,8 @@ static const struct regmap_config realtek_smi_regmap_config = {
> >       .reg_read = realtek_smi_read,
> >       .reg_write = realtek_smi_write,
> >       .cache_type = REGCACHE_NONE,
> > -     .lock = realtek_smi_lock,
> > -     .unlock = realtek_smi_unlock,
> > +     .lock = realtek_common_lock,
> > +     .unlock = realtek_common_unlock,
> >  };
> >
> >  static const struct regmap_config realtek_smi_nolock_regmap_config = {
> > @@ -410,78 +397,18 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
> >
> >  static int realtek_smi_probe(struct platform_device *pdev)
> >  {
> > -     const struct realtek_variant *var;
> >       struct device *dev = &pdev->dev;
> >       struct realtek_priv *priv;
> > -     struct regmap_config rc;
> > -     struct device_node *np;
> >       int ret;
> >
> > -     var = of_device_get_match_data(dev);
> > -     np = dev->of_node;
> > -
> > -     priv = devm_kzalloc(dev, sizeof(*priv) + var->chip_data_sz, GFP_KERNEL);
> > -     if (!priv)
> > -             return -ENOMEM;
> > -     priv->chip_data = (void *)priv + sizeof(*priv);
> > -
> > -     mutex_init(&priv->map_lock);
> > -
> > -     rc = realtek_smi_regmap_config;
> > -     rc.lock_arg = priv;
> > -     priv->map = devm_regmap_init(dev, NULL, priv, &rc);
> > -     if (IS_ERR(priv->map)) {
> > -             ret = PTR_ERR(priv->map);
> > -             dev_err(dev, "regmap init failed: %d\n", ret);
> > -             return ret;
> > -     }
> > -
> > -     rc = realtek_smi_nolock_regmap_config;
> > -     priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
> > -     if (IS_ERR(priv->map_nolock)) {
> > -             ret = PTR_ERR(priv->map_nolock);
> > -             dev_err(dev, "regmap init failed: %d\n", ret);
> > -             return ret;
> > -     }
> > -
> > -     /* Link forward and backward */
> > -     priv->dev = dev;
> > -     priv->clk_delay = var->clk_delay;
> > -     priv->cmd_read = var->cmd_read;
> > -     priv->cmd_write = var->cmd_write;
> > -     priv->ops = var->ops;
> > +     priv = realtek_common_probe(dev, realtek_smi_regmap_config,
> > +                                 realtek_smi_nolock_regmap_config);
> > +     if (IS_ERR(priv))
> > +             return PTR_ERR(priv);
> >
> >       priv->setup_interface = realtek_smi_setup_mdio;
> >       priv->write_reg_noack = realtek_smi_write_reg_noack;
> > -
> > -     dev_set_drvdata(dev, priv);
> > -     spin_lock_init(&priv->lock);
> > -
> > -     /* TODO: if power is software controlled, set up any regulators here */
> > -
> > -     priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > -     if (IS_ERR(priv->reset)) {
> > -             dev_err(dev, "failed to get RESET GPIO\n");
> > -             return PTR_ERR(priv->reset);
> > -     }
> > -     if (priv->reset) {
> > -             gpiod_set_value(priv->reset, 1);
> > -             dev_dbg(dev, "asserted RESET\n");
> > -             msleep(REALTEK_HW_STOP_DELAY);
> > -             gpiod_set_value(priv->reset, 0);
> > -             msleep(REALTEK_HW_START_DELAY);
> > -             dev_dbg(dev, "deasserted RESET\n");
> > -     }
> > -
> > -     /* Fetch MDIO pins */
> > -     priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
> > -     if (IS_ERR(priv->mdc))
> > -             return PTR_ERR(priv->mdc);
> > -     priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
> > -     if (IS_ERR(priv->mdio))
> > -             return PTR_ERR(priv->mdio);
> > -
> > -     priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
> > +     priv->ds->ops = priv->variant->ds_ops_smi;
> >
> >       ret = priv->ops->detect(priv);
> >       if (ret) {
> > @@ -489,20 +416,15 @@ static int realtek_smi_probe(struct platform_device *pdev)
> >               return ret;
> >       }
> >
> > -     priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
> > -     if (!priv->ds)
> > -             return -ENOMEM;
> > -
> > -     priv->ds->dev = dev;
> >       priv->ds->num_ports = priv->num_ports;
> > -     priv->ds->priv = priv;
> >
> > -     priv->ds->ops = var->ds_ops_smi;
> >       ret = dsa_register_switch(priv->ds);
> >       if (ret) {
> > -             dev_err_probe(dev, ret, "unable to register switch\n");
> > +             dev_err_probe(dev, ret, "unable to register switch ret = %pe\n",
> > +                           ERR_PTR(ret));
> >               return ret;
> >       }
> > +
> >       return 0;
> >  }
> >
> > @@ -513,13 +435,7 @@ static void realtek_smi_remove(struct platform_device *pdev)
> >       if (!priv)
> >               return;
> >
> > -     dsa_unregister_switch(priv->ds);
> > -     if (priv->user_mii_bus)
> > -             of_node_put(priv->user_mii_bus->dev.of_node);
> > -
> > -     /* leave the device reset asserted */
> > -     if (priv->reset)
> > -             gpiod_set_value(priv->reset, 1);
> > +     realtek_common_remove(priv);
> >  }
> >
> >  static void realtek_smi_shutdown(struct platform_device *pdev)
> > @@ -534,27 +450,10 @@ static void realtek_smi_shutdown(struct platform_device *pdev)
> >       platform_set_drvdata(pdev, NULL);
> >  }
> >
> > -static const struct of_device_id realtek_smi_of_match[] = {
> > -#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
> > -     {
> > -             .compatible = "realtek,rtl8366rb",
> > -             .data = &rtl8366rb_variant,
> > -     },
> > -#endif
> > -#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
> > -     {
> > -             .compatible = "realtek,rtl8365mb",
> > -             .data = &rtl8365mb_variant,
> > -     },
> > -#endif
> > -     { /* sentinel */ },
> > -};
> > -MODULE_DEVICE_TABLE(of, realtek_smi_of_match);
> > -
> >  static struct platform_driver realtek_smi_driver = {
> >       .driver = {
> >               .name = "realtek-smi",
> > -             .of_match_table = realtek_smi_of_match,
> > +             .of_match_table = realtek_common_of_match,
> >       },
> >       .probe  = realtek_smi_probe,
> >       .remove_new = realtek_smi_remove,
> > diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> > index 790488e9c667..8d9d546bf5f5 100644
> > --- a/drivers/net/dsa/realtek/realtek.h
> > +++ b/drivers/net/dsa/realtek/realtek.h
> > @@ -79,6 +79,8 @@ struct realtek_priv {
> >       int                     vlan_enabled;
> >       int                     vlan4k_enabled;
> >
> > +     const struct realtek_variant *variant;
> > +
> >       char                    buf[4096];
> >       void                    *chip_data; /* Per-chip extra variant data */
> >  };
> > --
> > 2.42.1
> >

