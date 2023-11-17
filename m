Return-Path: <netdev+bounces-48790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99A7EF94D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987611F265F0
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA8746435;
	Fri, 17 Nov 2023 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyl6LHRc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0EAD72
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 13:14:33 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50a93c5647cso3379603e87.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 13:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700255672; x=1700860472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDCjfmiuHBUjatIg/qkEZFqocLpL7dO+sq9K2E5tmZQ=;
        b=Lyl6LHRcSlQORAtb9fqg33lqAFO4wJnSOaqeW18h1r3sP4MXxmOkAUrL3psxPRdbKf
         Wt90UlUjN9iD3SwciwZrC7oRro+D6YBBLymytUmPPlLt+/SXqY2flBtXkWn3RZ82Sisd
         XgPtAEEzLrRUCIoKFIKRyAQmyu02nvS/QEoo6YHWLcIRiuIbeWi7hRadnzGc1e2BjIRK
         Mx1rYzDazyA1TL+l6s9H35b26cfmYSVBiArYfwZdb2/tIEtC5tuYZdUmIxr4pL40kXv2
         6xqkh1c4RXZp98kEbE3J5Aby9oQw8EPBlZspctZz8Tzs4OplQ9UaZcV83e6H0WkBEnEL
         gt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255672; x=1700860472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDCjfmiuHBUjatIg/qkEZFqocLpL7dO+sq9K2E5tmZQ=;
        b=XVZWWbohKb7GO0mQ3SaL87Jxgz7JRhU9ccfMC3u6OQVVWpfCIuFSu3GYGciuW8hQir
         yjZhynkQ5nfff9DDOllpllgfs7JPkx4dw8h5kQJT+DgtSJr5PLX9m3E7xY3pdggAp1TZ
         DRP9X0rV8VXioQqlXjxW4CBrX/sOqcrskVEp09Vl7wELfkdT+93gyeA620npUh1ZJRCn
         6bmoj0KZE/nie+q3NgnkVHIZuP7jnH50VPjzhlhZu61t5AmzNxEMFWmrIodPFKvgz7ph
         KJxoLDkKMNK0E0v7TGcy2ZV8Wbat2+ouKzsVSrfm6E5OyMJZ5d8P0sakKZWCmzOrMYjh
         BQ2w==
X-Gm-Message-State: AOJu0Yz/V+M6nqvX7MkPxpcUTU9GbRzImaMbMEMPhqHg7XZ+OgExQtNR
	hm+J4O9XvtTkWMBOr0kDnqzkTDuEgUFT5cIN/PQ=
X-Google-Smtp-Source: AGHT+IGKDLm953maWwHbLtbnOmaDzZX8AmYo8vjmUsaK4ixoaBdLyogSeIdUMYpol5G/thlS4I18t0gbRC0Umh7JhXo=
X-Received: by 2002:ac2:5216:0:b0:500:b63f:4db3 with SMTP id
 a22-20020ac25216000000b00500b63f4db3mr559052lfl.35.1700255671166; Fri, 17 Nov
 2023 13:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111215647.4966-1-luizluca@gmail.com> <20231111215647.4966-5-luizluca@gmail.com>
 <qaijsywlvxewssd2nxsfowvlzrua3ipgu3l7iesdq3lci7upd7@t73e2tsc3mhy>
In-Reply-To: <qaijsywlvxewssd2nxsfowvlzrua3ipgu3l7iesdq3lci7upd7@t73e2tsc3mhy>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 17 Nov 2023 18:14:19 -0300
Message-ID: <CAJq09z6319jY6oB_t09fBjhEhWxyoV4To7hESyPm=GkSH1KO0w@mail.gmail.com>
Subject: Re: [RFC net-next 4/5] net: dsa: realtek: load switch variants on demand
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> On Sat, Nov 11, 2023 at 06:51:07PM -0300, Luiz Angelo Daros de Luca wrote:
> > realtek-common had a hard dependency on both switch variants. That way,
> > it was not possible to selectively load only one model at runtime. Now
> > variants are registered at the realtek-common module and interface
> > modules look for a variant using the compatible string.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  drivers/net/dsa/realtek/realtek-common.c | 125 ++++++++++++++++++++---
> >  drivers/net/dsa/realtek/realtek-common.h |   3 +
> >  drivers/net/dsa/realtek/realtek-mdio.c   |   9 +-
> >  drivers/net/dsa/realtek/realtek-smi.c    |   9 +-
> >  drivers/net/dsa/realtek/realtek.h        |  36 ++++++-
> >  drivers/net/dsa/realtek/rtl8365mb.c      |   4 +-
> >  drivers/net/dsa/realtek/rtl8366rb.c      |   4 +-
> >  7 files changed, 162 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
> > index 36f8b60771be..e383db21c776 100644
> > --- a/drivers/net/dsa/realtek/realtek-common.c
> > +++ b/drivers/net/dsa/realtek/realtek-common.c
> > @@ -1,10 +1,76 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >
> >  #include <linux/module.h>
> > +#include <linux/of_device.h>
> >
> >  #include "realtek.h"
> >  #include "realtek-common.h"
> >
> > +static LIST_HEAD(realtek_variants_list);
> > +static DEFINE_MUTEX(realtek_variants_lock);
> > +
> > +void realtek_variant_register(struct realtek_variant_entry *var_ent)
> > +{
> > +     mutex_lock(&realtek_variants_lock);
> > +     list_add_tail(&var_ent->list, &realtek_variants_list);
> > +     mutex_unlock(&realtek_variants_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_variant_register);
> > +
> > +void realtek_variant_unregister(struct realtek_variant_entry *var_ent)
> > +{
> > +     mutex_lock(&realtek_variants_lock);
> > +     list_del(&var_ent->list);
> > +     mutex_unlock(&realtek_variants_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_variant_unregister);
> > +
> > +const struct realtek_variant *realtek_variant_get(
> > +             const struct of_device_id *match)
> > +{
> > +     const struct realtek_variant *var = ERR_PTR(-ENOENT);
> > +     struct realtek_variant_entry *var_ent;
> > +     const char *modname = match->data;
> > +
> > +     request_module(modname);
> > +
> > +     mutex_lock(&realtek_variants_lock);
> > +     list_for_each_entry(var_ent, &realtek_variants_list, list) {
> > +             const struct realtek_variant *tmp = var_ent->variant;
> > +
> > +             if (strcmp(match->compatible, var_ent->compatible))
> > +                     continue;
> > +
> > +             if (!try_module_get(var_ent->owner))
> > +                     break;
> > +
> > +             var = tmp;
> > +             break;
> > +     }
>
> Why not:
>
> list_for_each_entry(...) {
>   if (strcmp(...))
>     continue;
>
>   if (!try_module_get(...))
>     break;
>
>   var = var_ent->variant;
>   break;
> }
>
> no need for tmp.
>
> Maybe also rename var to variant? tmp, var, foo, etc. have somewhat throw-away
> variable connotations... ;)

You are right. That tmp came from dsa tag.c. At first, it had some use
as the match was using fields from the variant. However, once I opted
to use the compatible string, variant became just the result.

> > +     mutex_unlock(&realtek_variants_lock);
> > +
> > +     return var;
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_variant_get);
> > +
> > +void realtek_variant_put(const struct realtek_variant *var)
> > +{
> > +     struct realtek_variant_entry *var_ent;
> > +
> > +     mutex_lock(&realtek_variants_lock);
> > +     list_for_each_entry(var_ent, &realtek_variants_list, list) {
> > +             if (var_ent->variant != var)
> > +                     continue;
> > +
> > +             if (var_ent->owner)
> > +                     module_put(var_ent->owner);
> > +
> > +             break;
> > +     }
> > +     mutex_unlock(&realtek_variants_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_variant_put);
> > +
> >  void realtek_common_lock(void *ctx)
> >  {
> >       struct realtek_priv *priv = ctx;
> > @@ -25,18 +91,30 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
> >               struct regmap_config rc, struct regmap_config rc_nolock)
> >  {
> >       const struct realtek_variant *var;
> > +     const struct of_device_id *match;
> >       struct realtek_priv *priv;
> >       struct device_node *np;
> >       int ret;
> >
> > -     var = of_device_get_match_data(dev);
> > -     if (!var)
> > +     match = of_match_device(dev->driver->of_match_table, dev);
> > +     if (!match || !match->data)
> >               return ERR_PTR(-EINVAL);
> >
> > +     var = realtek_variant_get(match);
> > +     if (IS_ERR(var)) {
> > +             ret = PTR_ERR(var);
> > +             dev_err_probe(dev, ret,
> > +                           "failed to get module for '%s'. Is '%s' loaded?",
> > +                           match->compatible, match->data);
> > +             goto err_variant_put;
> > +     }
> > +
> >       priv = devm_kzalloc(dev, size_add(sizeof(*priv), var->chip_data_sz),
> >                           GFP_KERNEL);
> > -     if (!priv)
> > -             return ERR_PTR(-ENOMEM);
> > +     if (!priv) {
> > +             ret = -ENOMEM;
> > +             goto err_variant_put;
> > +     }
> >
> >       mutex_init(&priv->map_lock);
> >
> > @@ -45,14 +123,14 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
> >       if (IS_ERR(priv->map)) {
> >               ret = PTR_ERR(priv->map);
> >               dev_err(dev, "regmap init failed: %d\n", ret);
> > -             return ERR_PTR(ret);
> > +             goto err_variant_put;
> >       }
> >
> >       priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc_nolock);
> >       if (IS_ERR(priv->map_nolock)) {
> >               ret = PTR_ERR(priv->map_nolock);
> >               dev_err(dev, "regmap init failed: %d\n", ret);
> > -             return ERR_PTR(ret);
> > +             goto err_variant_put;
> >       }
> >
> >       /* Link forward and backward */
> > @@ -69,23 +147,27 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
> >
> >       /* Fetch MDIO pins */
> >       priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
> > -     if (IS_ERR(priv->mdc))
> > -             return ERR_CAST(priv->mdc);
> > +
> > +     if (IS_ERR(priv->mdc)) {
> > +             ret = PTR_ERR(priv->mdc);
> > +             goto err_variant_put;
> > +     }
> >
> >       priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
> > -     if (IS_ERR(priv->mdio))
> > -             return ERR_CAST(priv->mdio);
> > +     if (IS_ERR(priv->mdio)) {
> > +             ret = PTR_ERR(priv->mdio);
> > +             goto err_variant_put;
> > +     }
> >
> >       np = dev->of_node;
> > -
> >       priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
> >
> >       /* TODO: if power is software controlled, set up any regulators here */
> > -
> >       priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> >       if (IS_ERR(priv->reset)) {
> > +             ret = PTR_ERR(priv->reset);
> >               dev_err(dev, "failed to get RESET GPIO\n");
> > -             return ERR_CAST(priv->reset);
> > +             goto err_variant_put;
> >       }
> >       if (priv->reset) {
> >               gpiod_set_value(priv->reset, 1);
> > @@ -97,13 +179,20 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
> >       }
> >
> >       priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
> > -     if (!priv->ds)
> > -             return ERR_PTR(-ENOMEM);
> > +     if (!priv->ds) {
> > +             ret = -ENOMEM;
> > +             goto err_variant_put;
> > +     }
> >
> >       priv->ds->dev = dev;
> >       priv->ds->priv = priv;
> >
> >       return priv;
> > +
> > +err_variant_put:
> > +     realtek_variant_put(var);
> > +
> > +     return ERR_PTR(ret);
> >  }
> >  EXPORT_SYMBOL(realtek_common_probe);
> >
> > @@ -116,6 +205,8 @@ void realtek_common_remove(struct realtek_priv *priv)
> >       if (priv->user_mii_bus)
> >               of_node_put(priv->user_mii_bus->dev.of_node);
> >
> > +     realtek_variant_put(priv->variant);
> > +
> >       /* leave the device reset asserted */
> >       if (priv->reset)
> >               gpiod_set_value(priv->reset, 1);
> > @@ -124,10 +215,10 @@ EXPORT_SYMBOL(realtek_common_remove);
> >
> >  const struct of_device_id realtek_common_of_match[] = {
> >  #if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
> > -     { .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
> > +     { .compatible = "realtek,rtl8366rb", .data = REALTEK_RTL8366RB_MODNAME, },
> >  #endif
> >  #if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
> > -     { .compatible = "realtek,rtl8365mb", .data = &rtl8366rb_variant, },
> > +     { .compatible = "realtek,rtl8365mb", .data = REALTEK_RTL8365MB_MODNAME, },
> >  #endif
> >       { /* sentinel */ },
> >  };
> > diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
> > index 90a949386518..089fda2d4fa9 100644
> > --- a/drivers/net/dsa/realtek/realtek-common.h
> > +++ b/drivers/net/dsa/realtek/realtek-common.h
> > @@ -12,5 +12,8 @@ void realtek_common_unlock(void *ctx);
> >  struct realtek_priv *realtek_common_probe(struct device *dev,
> >               struct regmap_config rc, struct regmap_config rc_nolock);
> >  void realtek_common_remove(struct realtek_priv *priv);
> > +const struct realtek_variant *realtek_variant_get(
> > +             const struct of_device_id *match);
> > +void realtek_variant_put(const struct realtek_variant *var);
> >
> >  #endif
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 6f610386c977..6d81cd88dbe6 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -146,7 +146,7 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
> >       ret = priv->ops->detect(priv);
> >       if (ret) {
> >               dev_err(dev, "unable to detect switch\n");
> > -             return ret;
> > +             goto err_variant_put;
> >       }
> >
> >       priv->ds->num_ports = priv->num_ports;
> > @@ -155,10 +155,15 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
> >       if (ret) {
> >               dev_err_probe(dev, ret, "unable to register switch ret = %pe\n",
> >                             ERR_PTR(ret));
> > -             return ret;
> > +             goto err_variant_put;
> >       }
> >
> >       return 0;
> > +
> > +err_variant_put:
> > +     realtek_variant_put(priv->variant);
> > +
> > +     return ret;
> >  }
> >
> >  static void realtek_mdio_remove(struct mdio_device *mdiodev)
> > diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> > index 0cf89f9db99e..a772bb7dbe35 100644
> > --- a/drivers/net/dsa/realtek/realtek-smi.c
> > +++ b/drivers/net/dsa/realtek/realtek-smi.c
> > @@ -413,7 +413,7 @@ static int realtek_smi_probe(struct platform_device *pdev)
> >       ret = priv->ops->detect(priv);
> >       if (ret) {
> >               dev_err(dev, "unable to detect switch\n");
> > -             return ret;
> > +             goto err_variant_put;
> >       }
> >
> >       priv->ds->num_ports = priv->num_ports;
> > @@ -422,10 +422,15 @@ static int realtek_smi_probe(struct platform_device *pdev)
> >       if (ret) {
> >               dev_err_probe(dev, ret, "unable to register switch ret = %pe\n",
> >                             ERR_PTR(ret));
> > -             return ret;
> > +             goto err_variant_put;
> >       }
> >
> >       return 0;
> > +
> > +err_variant_put:
> > +     realtek_variant_put(priv->variant);
> > +
> > +     return ret;
> >  }
> >
> >  static void realtek_smi_remove(struct platform_device *pdev)
> > diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> > index 8d9d546bf5f5..f9bd6678e3bd 100644
> > --- a/drivers/net/dsa/realtek/realtek.h
> > +++ b/drivers/net/dsa/realtek/realtek.h
> > @@ -16,6 +16,38 @@
> >  #define REALTEK_HW_STOP_DELAY                25      /* msecs */
> >  #define REALTEK_HW_START_DELAY               100     /* msecs */
> >
> > +#define REALTEK_RTL8365MB_MODNAME    "rtl8365mb"
> > +#define REALTEK_RTL8366RB_MODNAME    "rtl8366"
>
> The solution is a little baroque but I see the benefit. This however seems
> rather brittle. I don't have a good idea of how to improve this but maybe
> somebody else will chime in.

I need some way to map "this CHIP requires module XXX" in order to let
it request the module. DSA tags, for example, have a module format
based on the tag name. Here, rtl8365mb matches the compatible string
but rtl8366rb doesn't. We discussed in the past to keep a single
compatible string for each driver when we dropped the "rtl8367s"
string. We could migrate the rtl8366-core to realtek-common and rename
the module from rtl8366 to rtl8366rb.

Anyway, I'll try another solution for now. How about
MODULE_ALIAS("realtek,rtl8365mb")? It seems to work nicely.

> > +
> > +struct realtek_variant_entry {
> > +     const struct realtek_variant *variant;
> > +     const char *compatible;
> > +     struct module *owner;
> > +     struct list_head list;
> > +};
> > +
> > +#define module_realtek_variant(__variant, __compatible)                      \
> > +static struct realtek_variant_entry __variant ## _entry = {          \
> > +     .compatible = __compatible,                                     \
> > +     .variant = &(__variant),                                        \
> > +     .owner = THIS_MODULE,                                           \
> > +};                                                                   \
> > +static int __init realtek_variant_module_init(void)                  \
> > +{                                                                    \
> > +     realtek_variant_register(&__variant ## _entry);                 \
> > +     return 0;                                                       \
> > +}                                                                    \
> > +module_init(realtek_variant_module_init)                             \
> > +                                                                     \
> > +static void __exit realtek_variant_module_exit(void)                 \
> > +{                                                                    \
> > +     realtek_variant_unregister(&__variant ## _entry);               \
> > +}                                                                    \
> > +module_exit(realtek_variant_module_exit)
> > +
> > +void realtek_variant_register(struct realtek_variant_entry *var_ent);
> > +void realtek_variant_unregister(struct realtek_variant_entry *var_ent);
> > +
> >  struct realtek_ops;
> >  struct dentry;
> >  struct inode;
> > @@ -120,6 +152,7 @@ struct realtek_ops {
> >  struct realtek_variant {
> >       const struct dsa_switch_ops *ds_ops_smi;
> >       const struct dsa_switch_ops *ds_ops_mdio;
> > +     const struct realtek_variant_info *info;
>
> Unused member variable.

Removed.

Thanks Alvin, I might send a new series with 3/5 and 4/5 soon with the
changes after some more tests.

Regards,

Luiz

