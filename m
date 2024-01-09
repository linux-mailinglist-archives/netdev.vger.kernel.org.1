Return-Path: <netdev+bounces-62564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D42E827E0A
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 06:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6EFB23709
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 05:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE0C39B;
	Tue,  9 Jan 2024 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAQmWzGU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1167476
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cce70ad1a3so28995921fa.1
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 21:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704776741; x=1705381541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6VRW6LiblqkEjmRQNsd43ZUW0VC7I25KZYSeGGUaRE=;
        b=LAQmWzGUb2tAoMe0P4Uj1bbA9M1ZHSds36GN/iUj/GeQdCZyAsyDk58YrCt4PyHB07
         6aVuib6oI0RR981ctltrd+jZ0zGtbLV2kXVLdu8hVXuIP72oSKSinbHjG+bqhQFWSKul
         JRG27x7zKqvj47aDquvDHGU4Vn26RNR5sf2J8EEr5ScZjyfZe1HXOUmV7f2I2NxwzE3+
         aCEFpouVyjykcKOnl9/3jXmGXX0xN5C/SdOLIqR0V5GquPJ/j2k2vrx/scPfkuNFgSiu
         iAWTCgluEUBdRdOayWQ1zBCWK4HwqrYBrrkiKGHf8XjS9XdaoiRLFZXjOfHZcFMKdpk1
         lD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704776741; x=1705381541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6VRW6LiblqkEjmRQNsd43ZUW0VC7I25KZYSeGGUaRE=;
        b=XRu8nbqkGz6obX4qt2im2rMLBkaL77XYH4whIIAzvXeOEveU3w+pjV07cE6VmvKqxT
         7CrTFDCTyUVS69YvTKI2Syo8rWNL7E5xGhr6YzBDbKcLhV/rgiBKxiRpTqP0OYKu0w9o
         Z3jTUXt/9yLEf2izsU9t/rBV3PipXakQgqehaDE/z6mbBy3XHxnz6AeE39+3Gw6k+Hdp
         64fyBmreXaTprKTav1K+mD+WmgW/SdYq1xUbrwAqJeXvcszRQBBFwa1VkDCot0Q695Jk
         Rr3Y2c4SU0JyB9xyIZs6VSJcWf4MSulil7qrkwKLxaMrISPM9h+WqPFAjfrxcpHmDDgO
         hMDQ==
X-Gm-Message-State: AOJu0Yx2y9ZAQE9EN9wzjCd6U2TadaIpbN1mLWPG3MzuXNtX4TgKNBhl
	BU6cSd9a3hbedsg8WpbT0I2v1D7r5OM0itZj2nI=
X-Google-Smtp-Source: AGHT+IEp5qR44u3bkC3HoOA8NWK1h6x55dSMex8bPM0KRpW/p2NXiyXORQC3Kfkqf9EYY15e0G9qh7hnt1zJX85uYVw=
X-Received: by 2002:a05:651c:c1:b0:2cd:34b1:a9ef with SMTP id
 1-20020a05651c00c100b002cd34b1a9efmr1825191ljr.90.1704776740700; Mon, 08 Jan
 2024 21:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-4-luizluca@gmail.com>
 <20240108140002.wpf6zj7qv2ftx476@skbuf>
In-Reply-To: <20240108140002.wpf6zj7qv2ftx476@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 9 Jan 2024 02:05:29 -0300
Message-ID: <CAJq09z6g+qTbzzaFAy94aV6HuESAeb4aLOUHWdUkOB4+xR_vDg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa module
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 8 de jan. de 2024 =C3=A0s 11:00, Vladimir Oltean
<olteanv@gmail.com> escreveu:
>
> On Fri, Dec 22, 2023 at 09:46:31PM -0300, Luiz Angelo Daros de Luca wrote=
:
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
> > The reset during probe was moved to the end of the common probe. This w=
ay,
> > we avoid a reset if anything else fails.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> > diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa=
/realtek/realtek-common.c
> > new file mode 100644
> > index 000000000000..80b37e5fe780
> > --- /dev/null
> > +++ b/drivers/net/dsa/realtek/realtek-common.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <linux/module.h>
> > +
> > +#include "realtek.h"
> > +#include "realtek-common.h"
> > +
> > +void realtek_common_lock(void *ctx)
> > +{
> > +     struct realtek_priv *priv =3D ctx;
> > +
> > +     mutex_lock(&priv->map_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_common_lock);
>
> Would you mind adding some kernel-doc comments above each of these
> exported functions? https://docs.kernel.org/doc-guide/kernel-doc.html
> says "Every function that is exported to loadable modules using
> EXPORT_SYMBOL or EXPORT_SYMBOL_GPL should have a kernel-doc comment.
> Functions and data structures in header files which are intended to be
> used by modules should also have kernel-doc comments."
>
> It is something I only recently started paying attention to, so we don't
> have consistency in this regard. But we should try to adhere to this
> practice for code we change.
>

Sure. I'll pay attention to that too.

> > +
> > +void realtek_common_unlock(void *ctx)
> > +{
> > +     struct realtek_priv *priv =3D ctx;
> > +
> > +     mutex_unlock(&priv->map_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_common_unlock);
> > +
> > +struct realtek_priv *
> > +realtek_common_probe(struct device *dev, struct regmap_config rc,
> > +                  struct regmap_config rc_nolock)
>
> Could you use "const struct regmap_config *" as the data types here, to
> avoid two on-stack variable copies? Regmap will copy the config structure=
s
> anyway.

I could do that for rc_nolock but not for rc as we need to modify it
before passing to regmap. I would still need to duplicate rc, either
using the stack or heap. What would be the best option?

1) pass two pointers and copy one to stack
2) pass two pointers and copy one to heap
3) pass two structs (as it is today)
4) pass one pointer and one struct

The old code was using 1) and I'm inclined to adopt it and save a
hundred and so bytes from the stack, although 2) would save even more.

> > +{
> > +     const struct realtek_variant *var;
> > +     struct realtek_priv *priv;
> > +     int ret;
> > +
> > +     var =3D of_device_get_match_data(dev);
> > +     if (!var)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     priv =3D devm_kzalloc(dev, size_add(sizeof(*priv), var->chip_data=
_sz),
> > +                         GFP_KERNEL);
> > +     if (!priv)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     mutex_init(&priv->map_lock);
> > +
> > +     rc.lock_arg =3D priv;
> > +     priv->map =3D devm_regmap_init(dev, NULL, priv, &rc);
> > +     if (IS_ERR(priv->map)) {
> > +             ret =3D PTR_ERR(priv->map);
> > +             dev_err(dev, "regmap init failed: %d\n", ret);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     priv->map_nolock =3D devm_regmap_init(dev, NULL, priv, &rc_nolock=
);
> > +     if (IS_ERR(priv->map_nolock)) {
> > +             ret =3D PTR_ERR(priv->map_nolock);
> > +             dev_err(dev, "regmap init failed: %d\n", ret);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     /* Link forward and backward */
> > +     priv->dev =3D dev;
> > +     priv->variant =3D var;
> > +     priv->ops =3D var->ops;
> > +     priv->chip_data =3D (void *)priv + sizeof(*priv);
> > +
> > +     dev_set_drvdata(dev, priv);
> > +     spin_lock_init(&priv->lock);
> > +
> > +     priv->leds_disabled =3D of_property_read_bool(dev->of_node,
> > +                                                 "realtek,disable-leds=
");
> > +
> > +     /* TODO: if power is software controlled, set up any regulators h=
ere */
> > +
> > +     priv->reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_L=
OW);
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
> > +EXPORT_SYMBOL(realtek_common_probe);
> > diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realte=
k/realtek.h
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
> >       void                    *chip_data; /* Per-chip extra variant dat=
a */
> >  };
>
> Can the changes to struct realtek_priv be a separate patch, to
> clarify what is being changed, and to leave the noisy code movement
> more isolated?

Sure, although it will not be a patch that makes sense by itself. If
it helps with the review, I'll split it. We can fold it back if
needed.

Regards,

Luiz

