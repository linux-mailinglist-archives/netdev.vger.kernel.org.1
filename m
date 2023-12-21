Return-Path: <netdev+bounces-59436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD90081AD13
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121D11F24D36
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2B4A19;
	Thu, 21 Dec 2023 03:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn8MLXkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85359BA43
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e4a637958so479701e87.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 19:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703128287; x=1703733087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PCo5nRIZUbAiAVBnzyT+BbNeE0cWhrl4itSuQg1iCZc=;
        b=Fn8MLXkCehi1Z+/JzP/8Buwc4258LxU0TBjG3Xkp4Pfw1opsB1JfY6fZIyZ8OR/H9M
         W1B+0d9KjYMPIibfSl7+tp6i/DsnTeVaUR6SH4Qq+wpU5NR3wkD7OCt4CmQJMaAfcWjX
         tS78BwhpETeiNxPLb9h0IGdUVqJ2ddg5TM9XEL2AgurDFvHEhsXNvwIPWbAcPULhX93p
         ga0s3ust3h4p+0RiLeqiBAf9sLSKlGjd6jZAIo+fYKnS7tEitnhQWzgWgu3wZyl8Ke6f
         TJqXptwVSZpCaggkt5EqiDACnyE8YWdKtu/Jy9AhtJtuP4VwW49tygRW+esvfCAsADdZ
         KolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128287; x=1703733087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCo5nRIZUbAiAVBnzyT+BbNeE0cWhrl4itSuQg1iCZc=;
        b=h0kqpJPkDYA8rOKkwV1+yu36Rdy+MJPZj0K3nknyuGONZKW5tM/ChO1S/oF5wL2FUl
         o6oIKzazJdJs433pZW4iocJNs17wCfJs/aACEAwBFRCfMiJwwPWZa+i1XMUKZfzVu4ym
         Cf4ty3OsHoiT1y96bW4/L875CURrGBBn1PpoOutBPLvcgWfni4MDAP3svLMT18z3s1V1
         e50Z/ymMoGCj1QOzVJtZMP6dxTlmVmX6aqFawdP50mZDuOcXhY09nGajbO5yJfxzXq9n
         5mbN8lJR9RMkOyJfM+N4O801NiaYuBxBXJC3Q5aJLZm5s85MADo2SybMIfVCyuWn4bVE
         uEDg==
X-Gm-Message-State: AOJu0Yzv1rkXZbcjLhIO37sWhDnDObEDvbpFn58H87tbA6lEgEoW7Mxp
	6gfTUbRw97HzMmh6b2vf4vh15sTOqVypNlUL1ys=
X-Google-Smtp-Source: AGHT+IHOJXUZywCkTIytTeHtAh41RGdMC1NhJZZKnkpN7iBQ8AZ8SFmTm00I6S1ZaEdYgWkQZ2sBPrIi/jlwdZhIKkE=
X-Received: by 2002:a2e:b60c:0:b0:2cc:8e2a:a401 with SMTP id
 r12-20020a2eb60c000000b002cc8e2aa401mr505504ljn.107.1703128287090; Wed, 20
 Dec 2023 19:11:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231220042632.26825-4-luizluca@gmail.com>
 <m7aqhrk5zydicvxdrl225tcgwe5g3esu27mafoee7pqjitjnzs@5ldkbzqmmpte>
In-Reply-To: <m7aqhrk5zydicvxdrl225tcgwe5g3esu27mafoee7pqjitjnzs@5ldkbzqmmpte>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 Dec 2023 00:11:15 -0300
Message-ID: <CAJq09z5m-r1pTsJQ-SYDojcG5JwgCUMvcXrxTaJsyED89o5Yhw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/7] net: dsa: realtek: common realtek-dsa module
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> On Wed, Dec 20, 2023 at 01:24:26AM -0300, Luiz Angelo Daros de Luca wrote:
> > Some code can be shared between both interface modules (MDIO and SMI)
> > and among variants. These interface functions migrated to a common
> > module:
> >
> > - realtek_common_lock
> > - realtek_common_unlock
> > - realtek_common_probe
> > - realtek_common_register_switch
> > - realtek_common_remove
> >
> > The reset during probe was moved to the end of the common probe. This way,
> > we avoid a reset if anything else fails.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  drivers/net/dsa/realtek/Makefile         |   2 +
> >  drivers/net/dsa/realtek/realtek-common.c | 137 +++++++++++++++++++++++
> >  drivers/net/dsa/realtek/realtek-common.h |  16 +++
> >  drivers/net/dsa/realtek/realtek-mdio.c   | 114 +++----------------
> >  drivers/net/dsa/realtek/realtek-smi.c    | 117 +++----------------
> >  drivers/net/dsa/realtek/realtek.h        |   6 +-
> >  drivers/net/dsa/realtek/rtl8365mb.c      |   9 +-
> >  drivers/net/dsa/realtek/rtl8366rb.c      |   9 +-
> >  8 files changed, 199 insertions(+), 211 deletions(-)
> >  create mode 100644 drivers/net/dsa/realtek/realtek-common.c
> >  create mode 100644 drivers/net/dsa/realtek/realtek-common.h
> >
> > diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
> > index 0aab57252a7c..f4f9c6340d5f 100644
> > --- a/drivers/net/dsa/realtek/Makefile
> > +++ b/drivers/net/dsa/realtek/Makefile
> > @@ -1,4 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_NET_DSA_REALTEK)                += realtek-dsa.o
> > +realtek-dsa-objs                     := realtek-common.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_MDIO)   += realtek-mdio.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_SMI)    += realtek-smi.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
> > diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
> > new file mode 100644
> > index 000000000000..c7507b6cdcdd
> > --- /dev/null
> > +++ b/drivers/net/dsa/realtek/realtek-common.c
> > @@ -0,0 +1,137 @@
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
> > +
> > +/* sets up driver private data struct, sets up regmaps, parse common device-tree
> > + * properties and finally issues a hardware reset.
> > + */
>
> Please use kdoc format if you add such comments. But I think we agreed
> that the name is quite informative now, so you can also just drop it.

OK

>
> > +struct realtek_priv *
> > +realtek_common_probe(struct device *dev, struct regmap_config rc,
> > +                  struct regmap_config rc_nolock)
> > +{
> > +     const struct realtek_variant *var;
> > +     struct realtek_priv *priv;
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
> > +     priv->variant = var;
> > +     priv->ops = var->ops;
> > +     priv->chip_data = (void *)priv + sizeof(*priv);
> > +
> > +     dev_set_drvdata(dev, priv);
> > +     spin_lock_init(&priv->lock);
> > +
> > +     priv->leds_disabled = of_property_read_bool(dev->of_node,
> > +                                                 "realtek,disable-leds");
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
>
> I simply cannot understand why you insist on moving this part despite
> our earlier discussion on it where I pointed out that it makes no
> sense to move it. Is chip hardware reset not the discipline of the chip
> variant driver?
>
> Why don't you just keep it in its original place? It will make your
> patch smaller, which is what you seemed to care about the last time I
> raised this.

If I keep where it was, it will be in the interface code, not the
variant one. The only variant specific code during probe is the
detect. We could explode each probe for each interface and each
variant and drop the realtek_ops->detect callback but it now saves a
lot of duplications.

> Sorry, but I cannot give my Reviewed-by on this patch with this part
> moved around.

Should I add a new realtek_common_hwreset() with the reset code and
add a call to it at the beginning of each variant detect?

> > +
> > +     return priv;
> > +}
> > +EXPORT_SYMBOL(realtek_common_probe);
> > +
> > +/* Detects the realtek switch id/version and registers the dsa switch.
> > + */
> > +int realtek_common_register_switch(struct realtek_priv *priv)
> > +{
> > +     int ret;
> > +
> > +     ret = priv->ops->detect(priv);
> > +     if (ret) {
> > +             dev_err_probe(priv->dev, ret, "unable to detect switch\n");
> > +             return ret;
> > +     }
> > +
> > +     priv->ds = devm_kzalloc(priv->dev, sizeof(*priv->ds), GFP_KERNEL);
> > +     if (!priv->ds)
> > +             return -ENOMEM;
> > +
> > +     priv->ds->priv = priv;
> > +     priv->ds->dev = priv->dev;
> > +     priv->ds->ops = priv->ds_ops;
> > +     priv->ds->num_ports = priv->num_ports;
> > +
> > +     ret = dsa_register_switch(priv->ds);
> > +     if (ret) {
> > +             dev_err_probe(priv->dev, ret, "unable to register switch\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(realtek_common_register_switch);
> > +
> > +void realtek_common_remove(struct realtek_priv *priv)
> > +{
> > +     if (!priv)
> > +             return;
>
> This check is not really necessary.
>
> > +
> > +     /* leave the device reset asserted */
> > +     if (priv->reset)
> > +             gpiod_set_value(priv->reset, 1);
> > +}
> > +EXPORT_SYMBOL(realtek_common_remove);
> > +
> > +MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
> > +MODULE_DESCRIPTION("Realtek DSA switches common module");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
> > new file mode 100644
> > index 000000000000..518d091ff496
> > --- /dev/null
> > +++ b/drivers/net/dsa/realtek/realtek-common.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef _REALTEK_COMMON_H
> > +#define _REALTEK_COMMON_H
> > +
> > +#include <linux/regmap.h>
> > +
> > +void realtek_common_lock(void *ctx);
> > +void realtek_common_unlock(void *ctx);
> > +struct realtek_priv *
> > +realtek_common_probe(struct device *dev, struct regmap_config rc,
> > +                  struct regmap_config rc_nolock);
> > +int realtek_common_register_switch(struct realtek_priv *priv);
> > +void realtek_common_remove(struct realtek_priv *priv);
> > +
> > +#endif /* _REALTEK_COMMON_H */
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 58966d0625c8..1eed09ab3aa1 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -26,6 +26,7 @@
> >
> >  #include "realtek.h"
> >  #include "realtek-mdio.h"
> > +#include "realtek-common.h"
> >
> >  /* Read/write via mdiobus */
> >  #define REALTEK_MDIO_CTRL0_REG               31
> > @@ -100,20 +101,6 @@ static int realtek_mdio_read(void *ctx, u32 reg, u32 *val)
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
> > @@ -124,8 +111,8 @@ static const struct regmap_config realtek_mdio_regmap_config = {
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
> > @@ -143,96 +130,23 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
> >
> >  int realtek_mdio_probe(struct mdio_device *mdiodev)
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
> > +     priv = realtek_common_probe(dev, realtek_mdio_regmap_config,
> > +                                 realtek_mdio_nolock_regmap_config);
> > +     if (IS_ERR(priv))
> > +             return PTR_ERR(priv);
> >
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
> > -
> > -     priv->mdio_addr = mdiodev->addr;
> >       priv->bus = mdiodev->bus;
> > -     priv->dev = &mdiodev->dev;
> > -     priv->chip_data = (void *)priv + sizeof(*priv);
> > -
> > -     priv->clk_delay = var->clk_delay;
> > -     priv->cmd_read = var->cmd_read;
> > -     priv->cmd_write = var->cmd_write;
> > -     priv->ops = var->ops;
> > -
> > +     priv->mdio_addr = mdiodev->addr;
> >       priv->write_reg_noack = realtek_mdio_write;
> > +     priv->ds_ops = priv->variant->ds_ops_mdio;
> >
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
> > -
> > -     ret = priv->ops->detect(priv);
> > -     if (ret) {
> > -             dev_err(dev, "unable to detect switch\n");
> > -             return ret;
> > -     }
> > -
> > -     priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
> > -     if (!priv->ds)
> > -             return -ENOMEM;
> > -
> > -     priv->ds->dev = dev;
> > -     priv->ds->num_ports = priv->num_ports;
> > -     priv->ds->priv = priv;
> > -     priv->ds->ops = var->ds_ops_mdio;
> > -
> > -     ret = dsa_register_switch(priv->ds);
> > -     if (ret) {
> > -             dev_err(priv->dev, "unable to register switch ret = %d\n", ret);
> > +     ret = realtek_common_register_switch(priv);
> > +     if (ret)
> >               return ret;
> > -     }
> >
> >       return 0;
> >  }
> > @@ -247,9 +161,7 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
> >
> >       dsa_unregister_switch(priv->ds);
> >
> > -     /* leave the device reset asserted */
> > -     if (priv->reset)
> > -             gpiod_set_value(priv->reset, 1);
> > +     realtek_common_remove(priv);
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_mdio_remove);
> >
> > diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> > index 31ac409acfd0..fc54190839cf 100644
> > --- a/drivers/net/dsa/realtek/realtek-smi.c
> > +++ b/drivers/net/dsa/realtek/realtek-smi.c
> > @@ -41,12 +41,13 @@
> >
> >  #include "realtek.h"
> >  #include "realtek-smi.h"
> > +#include "realtek-common.h"
> >
> >  #define REALTEK_SMI_ACK_RETRY_COUNT          5
> >
> >  static inline void realtek_smi_clk_delay(struct realtek_priv *priv)
> >  {
> > -     ndelay(priv->clk_delay);
> > +     ndelay(priv->variant->clk_delay);
> >  }
> >
> >  static void realtek_smi_start(struct realtek_priv *priv)
> > @@ -209,7 +210,7 @@ static int realtek_smi_read_reg(struct realtek_priv *priv, u32 addr, u32 *data)
> >       realtek_smi_start(priv);
> >
> >       /* Send READ command */
> > -     ret = realtek_smi_write_byte(priv, priv->cmd_read);
> > +     ret = realtek_smi_write_byte(priv, priv->variant->cmd_read);
> >       if (ret)
> >               goto out;
> >
> > @@ -250,7 +251,7 @@ static int realtek_smi_write_reg(struct realtek_priv *priv,
> >       realtek_smi_start(priv);
> >
> >       /* Send WRITE command */
> > -     ret = realtek_smi_write_byte(priv, priv->cmd_write);
> > +     ret = realtek_smi_write_byte(priv, priv->variant->cmd_write);
> >       if (ret)
> >               goto out;
> >
> > @@ -311,20 +312,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
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
> > @@ -335,8 +322,8 @@ static const struct regmap_config realtek_smi_regmap_config = {
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
> > @@ -411,99 +398,32 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
> >
> >  int realtek_smi_probe(struct platform_device *pdev)
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
>
> You don't mention these parts in your commit message. Could be a patch
> in its own right too.
>
> > -     priv->ops = var->ops;
> > -
> > -     priv->setup_interface = realtek_smi_setup_mdio;
> > -     priv->write_reg_noack = realtek_smi_write_reg_noack;
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
> > +     priv = realtek_common_probe(dev, realtek_smi_regmap_config,
> > +                                 realtek_smi_nolock_regmap_config);
> > +     if (IS_ERR(priv))
> > +             return PTR_ERR(priv);
> >
> >       /* Fetch MDIO pins */
> >       priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
> >       if (IS_ERR(priv->mdc))
> >               return PTR_ERR(priv->mdc);
> > +
> >       priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
> >       if (IS_ERR(priv->mdio))
> >               return PTR_ERR(priv->mdio);
> >
> > -     priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
> > +     priv->write_reg_noack = realtek_smi_write_reg_noack;
> > +     priv->setup_interface = realtek_smi_setup_mdio;
> > +     priv->ds_ops = priv->variant->ds_ops_smi;
> >
> > -     ret = priv->ops->detect(priv);
> > -     if (ret) {
> > -             dev_err(dev, "unable to detect switch\n");
> > +     ret = realtek_common_register_switch(priv);
> > +     if (ret)
> >               return ret;
> > -     }
> > -
> > -     priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
> > -     if (!priv->ds)
> > -             return -ENOMEM;
> >
> > -     priv->ds->dev = dev;
> > -     priv->ds->num_ports = priv->num_ports;
> > -     priv->ds->priv = priv;
> > -
> > -     priv->ds->ops = var->ds_ops_smi;
> > -     ret = dsa_register_switch(priv->ds);
> > -     if (ret) {
> > -             dev_err_probe(dev, ret, "unable to register switch\n");
> > -             return ret;
> > -     }
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_smi_probe);
> > @@ -516,12 +436,11 @@ void realtek_smi_remove(struct platform_device *pdev)
> >               return;
> >
> >       dsa_unregister_switch(priv->ds);
> > +
> >       if (priv->user_mii_bus)
> >               of_node_put(priv->user_mii_bus->dev.of_node);
> >
> > -     /* leave the device reset asserted */
> > -     if (priv->reset)
> > -             gpiod_set_value(priv->reset, 1);
> > +     realtek_common_remove(priv);
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_smi_remove);
> >
> > diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> > index e9ee778665b2..fbd0616c1df3 100644
> > --- a/drivers/net/dsa/realtek/realtek.h
> > +++ b/drivers/net/dsa/realtek/realtek.h
> > @@ -58,11 +58,9 @@ struct realtek_priv {
> >       struct mii_bus          *bus;
> >       int                     mdio_addr;
> >
> > -     unsigned int            clk_delay;
> > -     u8                      cmd_read;
> > -     u8                      cmd_write;
> >       spinlock_t              lock; /* Locks around command writes */
> >       struct dsa_switch       *ds;
> > +     const struct dsa_switch_ops *ds_ops;
> >       struct irq_domain       *irqdomain;
> >       bool                    leds_disabled;
> >
> > @@ -79,6 +77,8 @@ struct realtek_priv {
> >       int                     vlan_enabled;
> >       int                     vlan4k_enabled;
> >
> > +     const struct realtek_variant *variant;
> > +
> >       char                    buf[4096];
> >       void                    *chip_data; /* Per-chip extra variant data */
> >  };
> > diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> > index 1ace2239934a..58ec057b6c32 100644
> > --- a/drivers/net/dsa/realtek/rtl8365mb.c
> > +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> > @@ -103,6 +103,7 @@
> >  #include "realtek.h"
> >  #include "realtek-smi.h"
> >  #include "realtek-mdio.h"
> > +#include "realtek-common.h"
> >
> >  /* Family-specific data and limits */
> >  #define RTL8365MB_PHYADDRMAX         7
> > @@ -691,7 +692,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
> >       u32 val;
> >       int ret;
> >
> > -     mutex_lock(&priv->map_lock);
> > +     realtek_common_lock(priv);
> >
> >       ret = rtl8365mb_phy_poll_busy(priv);
> >       if (ret)
> > @@ -724,7 +725,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
> >       *data = val & 0xFFFF;
> >
> >  out:
> > -     mutex_unlock(&priv->map_lock);
> > +     realtek_common_unlock(priv);
> >
> >       return ret;
> >  }
> > @@ -735,7 +736,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
> >       u32 val;
> >       int ret;
> >
> > -     mutex_lock(&priv->map_lock);
> > +     realtek_common_lock(priv);
> >
> >       ret = rtl8365mb_phy_poll_busy(priv);
> >       if (ret)
> > @@ -766,7 +767,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
> >               goto out;
> >
> >  out:
> > -     mutex_unlock(&priv->map_lock);
> > +     realtek_common_unlock(priv);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
> > index cc2fd636ec23..e60a0a81d426 100644
> > --- a/drivers/net/dsa/realtek/rtl8366rb.c
> > +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> > @@ -24,6 +24,7 @@
> >  #include "realtek.h"
> >  #include "realtek-smi.h"
> >  #include "realtek-mdio.h"
> > +#include "realtek-common.h"
> >
> >  #define RTL8366RB_PORT_NUM_CPU               5
> >  #define RTL8366RB_NUM_PORTS          6
> > @@ -1707,7 +1708,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
> >       if (phy > RTL8366RB_PHY_NO_MAX)
> >               return -EINVAL;
> >
> > -     mutex_lock(&priv->map_lock);
> > +     realtek_common_lock(priv);
> >
> >       ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
> >                          RTL8366RB_PHY_CTRL_READ);
> > @@ -1735,7 +1736,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
> >               phy, regnum, reg, val);
> >
> >  out:
> > -     mutex_unlock(&priv->map_lock);
> > +     realtek_common_unlock(priv);
> >
> >       return ret;
> >  }
> > @@ -1749,7 +1750,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
> >       if (phy > RTL8366RB_PHY_NO_MAX)
> >               return -EINVAL;
> >
> > -     mutex_lock(&priv->map_lock);
> > +     realtek_common_lock(priv);
> >
> >       ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
> >                          RTL8366RB_PHY_CTRL_WRITE);
> > @@ -1766,7 +1767,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
> >               goto out;
> >
> >  out:
> > -     mutex_unlock(&priv->map_lock);
> > +     realtek_common_unlock(priv);
> >
> >       return ret;
> >  }
> > --
> > 2.43.0
> >

