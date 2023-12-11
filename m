Return-Path: <netdev+bounces-55710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FC80C088
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C5BB20342
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 05:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F225B1C29E;
	Mon, 11 Dec 2023 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYrHcmYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C84FEA
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:02:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bfa7f7093so5120525e87.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702270950; x=1702875750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tAu5cnEeQYJPt7HvKDRTWT2xlpazvLS8i4k5JL7a/1U=;
        b=GYrHcmYSXzfj4Tj8t4hliM4KmSshrj+TD2TGkPEmqC/EzHNXC8oLm57JyuGnmkXzvN
         W6qZIFkA83b2rj3r2sMHDbY7olT+dgqsd65m+9jP+MPZrqLYF/1moxWhqRARppcGwMuI
         rBYT2GBXJAHd+m6v5JRAFvQvOyG3qcqz75xywVE5Js26cMaTCdB0ljW1wv9P9K0Ur6AB
         L/fU961lqWHmUYOr9K/br/Ax0a3oXfOj8J0Wk+6LraDXLOcMZgHUti/GFYiX2PrhMi+1
         BWq11RVD+/U70PIGiq7O1dfE94tz174dlYxqXYTUhGK5ry3toOlBKxbvFqJ5vtMKVc0R
         2z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702270950; x=1702875750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAu5cnEeQYJPt7HvKDRTWT2xlpazvLS8i4k5JL7a/1U=;
        b=LuFpfMVED/lMBHE9RjYhXi/LlSK1KgFC93v7GOUFj1M1ft9XuNdkuBvtf4i7/LnYzc
         zPNzfOBVk/5TfUsyzQecfIaNrMQHLSI8qZkWQuJePHwEL1JfpmFdXYBeK154td9LQ8cU
         GL3nScK1AXm7c5gxA83hu1Sj9XB9PeG3/smiV484WAR5ikoi35RltaBB0gwWFYU8d+vo
         ipWrZuqociXKiyluVU1kOF3qwR1sJxmynslo+FEvj6mxfA7wqq3s7JT/UPfIdv8WA/ux
         /vE3VcJr5Fpg6UHg+vb4BFgKIVMjHtzV3S7Qnq+Xvf4iUbR0sIrmraNtmrlai/dCsJzY
         60dQ==
X-Gm-Message-State: AOJu0YzY0cSwysXxU6hiWW7+dHVSaLApPQ4icQ5Ak5hrBHMvT0M5mmhX
	xjdYD/OEtqBwss69wt4pLkvMg73hfXngqEMEZf8=
X-Google-Smtp-Source: AGHT+IEH1pq5zD6831HnY6iUih55F5MD5l9CUQ9zyFGOEDDVdlrI85vXXtt27lpFLE3+QCm0iWoY4ccQlew3PHVkFIc=
X-Received: by 2002:a19:8c05:0:b0:50b:f836:9027 with SMTP id
 o5-20020a198c05000000b0050bf8369027mr1885921lfd.93.1702270950008; Sun, 10 Dec
 2023 21:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-5-luizluca@gmail.com>
 <hycvlka3sdsbpgq6al2wsqaqnaczvz5stxicjuxntsbfo6kzgj@evunbox7qcct>
In-Reply-To: <hycvlka3sdsbpgq6al2wsqaqnaczvz5stxicjuxntsbfo6kzgj@evunbox7qcct>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 11 Dec 2023 02:02:18 -0300
Message-ID: <CAJq09z73Q5uu_Nx_kbxSCjc7JwxvoQzLp+=5WX6b2dn6+SH3Ew@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] net: dsa: realtek: create realtek-common
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> On Fri, Dec 08, 2023 at 01:41:40AM -0300, Luiz Angelo Daros de Luca wrote:
> > Some code can be shared between both interface modules (MDIO and SMI)
> > and among variants. Currently, these interface functions are shared:
> >
> > - realtek_common_lock
> > - realtek_common_unlock
> > - realtek_common_probe
> > - realtek_common_remove
> >
> > The reset during probe was moved to the last moment before a variant
> > detects the switch. This way, we avoid a reset if anything else fails.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/net/dsa/realtek/Makefile         |   1 +
> >  drivers/net/dsa/realtek/realtek-common.c | 136 +++++++++++++++++++++++
> >  drivers/net/dsa/realtek/realtek-common.h |  16 +++
> >  drivers/net/dsa/realtek/realtek-mdio.c   | 121 ++------------------
> >  drivers/net/dsa/realtek/realtek-smi.c    | 124 +++------------------
> >  drivers/net/dsa/realtek/realtek.h        |   6 +-
> >  drivers/net/dsa/realtek/rtl8365mb.c      |   9 +-
> >  drivers/net/dsa/realtek/rtl8366rb.c      |   9 +-
> >  8 files changed, 194 insertions(+), 228 deletions(-)
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
>
> No corresponding Kconfig change?

NET_DSA_REALTEK already existed for "Realtek Ethernet switch family
support" entry to the Realtek DSA switch submenu. In the way we used
to use it, I believe it should be a bool entry, not a tristate. Now,
with a common module, a tristate fits just fine. So, by mistake, no
change is needed.

> >  obj-$(CONFIG_NET_DSA_REALTEK_MDIO)   += realtek-mdio.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_SMI)    += realtek-smi.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
> > diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
> > new file mode 100644
> > index 000000000000..75b6aa071990
> > --- /dev/null
> > +++ b/drivers/net/dsa/realtek/realtek-common.c
> > @@ -0,0 +1,136 @@
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
> > +struct realtek_priv *
> > +realtek_common_probe_pre(struct device *dev, struct regmap_config rc,
> > +                      struct regmap_config rc_nolock)
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
> > +     priv->variant = var;
> > +     priv->ops = var->ops;
> > +     priv->chip_data = (void *)priv + sizeof(*priv);
> > +
> > +     dev_set_drvdata(dev, priv);
> > +     spin_lock_init(&priv->lock);
> > +
> > +     np = dev->of_node;
>
> This is kind of a pointless variable, just do
> of_property_read_bool(dev->of_node, ...) below.

OK.

>
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
> > +     return priv;
> > +}
> > +EXPORT_SYMBOL(realtek_common_probe_pre);
> > +
> > +int realtek_common_probe_post(struct realtek_priv *priv)
> > +{
> > +     int ret;
> > +
> > +     ret = priv->ops->detect(priv);
> > +     if (ret) {
> > +             dev_err(priv->dev, "unable to detect switch\n");
>
> dev_err_probe()?

I'm not sure if detect() is able to return -EPROBE. At least for SMI,
gpio read/write never returns errors. However, it will not hurt to use
dev_err_probe() here.

>
> > +             return ret;
> > +     }
> > +
> > +     priv->ds = devm_kzalloc(priv->dev, sizeof(*priv->ds), GFP_KERNEL);
> > +     if (!priv->ds)
> > +             return -ENOMEM;
>
> I guess this could actually just be embedded in realtek_priv and then
> you don't need to allocate it dynamically here.

It makes sense. However, shouldn't it be a different commit? This one
is just moving stuff to a common file, not trying to optimize de code.

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
> > +EXPORT_SYMBOL(realtek_common_probe_post);
> > +
> > +void realtek_common_remove(struct realtek_priv *priv)
> > +{
> > +     if (!priv)
> > +             return;
> > +
> > +     dsa_unregister_switch(priv->ds);
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
> > index 000000000000..405bd0d85d2b
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
> > +void realtek_common_lock(void *ctx);
> > +void realtek_common_unlock(void *ctx);
> > +struct realtek_priv *
> > +realtek_common_probe_pre(struct device *dev, struct regmap_config rc,
> > +                      struct regmap_config rc_nolock);
> > +int realtek_common_probe_post(struct realtek_priv *priv);
>
> Maybe it is worth describing what these functions do with a comment.
>
> pre:  sets up driver private data struct, sets up regmaps, issues
>       hardware reset
>
> post: registers the dsa switch, calls detect() and then expects
>       priv->num_ports to be set

Sure. I'm not sure about the "expects". If I need something, I should
check and fail. The DSA switch will already fail to register without a
non-zero number of ports. (although too silently for my taste).

I don't like names that need too much explanation. It is just a
symptom of a bad name. Would it make more sense to have

realtek_common_probe_pre -> realtek_common_probe
realtek_common_probe_post -> realtek_common_register_switch (although
it is also detecting the switch)

?

> The detect() function in itself is a bit funny. Maybe it's not even
> necessary. Both chip variants set a static num_ports value anyway. You
> can maybe dump detect() completely and move that code into the
> variant-specific probe between the calls to common_probe_{pre,post}().

The probe is not variant-specific but interface-specific. We could,
indeed, put a static num_ports into realtek_variant and use it.
However, the main use for detect is to validate you really got a
supported switch, with the setups being a secondary function. I would
leave it as is for now. I'm trying to keep the series as small as
possible.

> > +void realtek_common_remove(struct realtek_priv *priv);
> > +
> > +#endif
>
> #endif /* _REALTEK_INTERFACE_H */
>
> Actually shouldn't it be _REALTEK_COMMON_H?

Yes, bad ctrl+c/ctrl+v from Vladmir example code.

> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 58966d0625c8..4c9a744b72f8 100644
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
> > @@ -143,98 +130,21 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
> >
> >  int realtek_mdio_probe(struct mdio_device *mdiodev)
> >  {
> > -     struct realtek_priv *priv;
> >       struct device *dev = &mdiodev->dev;
> > -     const struct realtek_variant *var;
> > -     struct regmap_config rc;
> > -     struct device_node *np;
> > -     int ret;
> > -
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
> > +     struct realtek_priv *priv;
> >
> > -     rc = realtek_mdio_nolock_regmap_config;
> > -     priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
> > -     if (IS_ERR(priv->map_nolock)) {
> > -             ret = PTR_ERR(priv->map_nolock);
> > -             dev_err(dev, "regmap init failed: %d\n", ret);
> > -             return ret;
> > -     }
> > +     priv = realtek_common_probe_pre(dev, realtek_mdio_regmap_config,
> > +                                     realtek_mdio_nolock_regmap_config);
> > +     if (IS_ERR(priv))
> > +             return PTR_ERR(priv);
> >
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
> > -             return ret;
> > -     }
> > +     return realtek_common_probe_post(priv);
> >
> > -     return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_mdio_probe);
> >
> > @@ -242,14 +152,7 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
> >  {
> >       struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
> >
> > -     if (!priv)
> > -             return;
> > -
> > -     dsa_unregister_switch(priv->ds);
> > -
> > -     /* leave the device reset asserted */
> > -     if (priv->reset)
> > -             gpiod_set_value(priv->reset, 1);
> > +     realtek_common_remove(priv);
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_mdio_remove);
> >
> > diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> > index 55586d158c0e..246024eec3bd 100644
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
> > @@ -411,100 +398,28 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
> >
> >  int realtek_smi_probe(struct platform_device *pdev)
> >  {
> > -     const struct realtek_variant *var;
> >       struct device *dev = &pdev->dev;
> >       struct realtek_priv *priv;
> > -     struct regmap_config rc;
> > -     struct device_node *np;
> > -     int ret;
> > -
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
> > -
> > -     priv->setup_interface = realtek_smi_setup_mdio;
> > -     priv->write_reg_noack = realtek_smi_write_reg_noack;
> > -
> > -     dev_set_drvdata(dev, priv);
> > -     spin_lock_init(&priv->lock);
> >
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
> > +     priv = realtek_common_probe_pre(dev, realtek_smi_regmap_config,
> > +                                     realtek_smi_nolock_regmap_config);
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
> > +     priv->write_reg_noack = realtek_smi_write_reg_noack;
> > +     priv->setup_interface = realtek_smi_setup_mdio;
> > +     priv->ds_ops = priv->variant->ds_ops_smi;
> >
> > -     priv->ds->ops = var->ds_ops_smi;
> > -     ret = dsa_register_switch(priv->ds);
> > -     if (ret) {
> > -             dev_err_probe(dev, ret, "unable to register switch\n");
> > -             return ret;
> > -     }
> > -     return 0;
> > +     return (priv);
>
> ret = realtek_common_probe_post(priv);
> if (ret)
>   return ret;
>
> return 0;

The ret variable is no more. Is it worth it to replace a single line
with 4 more?

> >  }
> >  EXPORT_SYMBOL_GPL(realtek_smi_probe);
> >
> > @@ -512,14 +427,7 @@ void realtek_smi_remove(struct platform_device *pdev)
> >  {
> >       struct realtek_priv *priv = platform_get_drvdata(pdev);
> >
> > -     if (!priv)
> > -             return;
> > -
> > -     dsa_unregister_switch(priv->ds);
> > -
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
> > index 526bf98cef1d..ac848b965f84 100644
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
> > index 09c17de19457..1cc4de3cf54f 100644
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

Regards,

Luiz

