Return-Path: <netdev+bounces-55713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA280C09A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1E81F20E9B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 05:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1950C1CABE;
	Mon, 11 Dec 2023 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDJVfweA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E00C3
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:14:09 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50c04ebe1bbso3936696e87.1
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702271648; x=1702876448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qx8liq3AGiWl9TmY9j+u1l6MW+dDbS3u7tlQvJ+1AWg=;
        b=YDJVfweAAzGqT8oxHjMdSJ7r68ivcOv3Dcr2zyhubMmlnKSxIpsfhNbFbjECUIxANP
         Nx/z/eFUxkniNBdAHWwtR85nn+EukC6DFdmuEousyAvyFuQH0StGKWEBKMJTZuXHc2Uc
         PzqnenLiGK2zq5VVVTOF14/vObZaYAcIDGsNhYZj7D2NDmAEMz8Ww4ufS4aKmGTrAM6B
         C8t5Q3rH/+z8GycT+A7GGgcDSiD6j48TjOy5lxJ6/GRWl09GCiUsKbcV/29z7zjtaydC
         Ltcs2ItSyq2Oa+YS0lXtkdPGQ79+6wvqdqy2iifIOnA/c7QlWTbfV3M8166rvBF3FPKH
         PM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702271648; x=1702876448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qx8liq3AGiWl9TmY9j+u1l6MW+dDbS3u7tlQvJ+1AWg=;
        b=eGA9nT7yNgQLKUP1djqIvea9DC99TZ0CXoPRzySl5XKatDxRUQAmiGRoDhk0ZCm+0D
         XYB3FUvorXLKSqr0tiYkdaZwiD7RbyTGKpZj2IkwsjeQlEYZxlpxB4XXr5e8eJf5jHDL
         J8XXkuXyGKRA3zC76WhVNh7oYsBq4oAERwSWvf3JOooHGn2gnaJTLtZZsXkaPK3x/NMH
         WueXzrVJxKutZhgSOhT0e4NboACie8AiZ4zNmRO86aGoWgiPMaao09Hm5Zj697SVYLnx
         TnZLoGpHRYIcL4D7WqpSbfZfMtdFjH86xkAiUqt7+4sW2CBMKmgqZMdIOc+LDKimLTun
         ZcsA==
X-Gm-Message-State: AOJu0YwmiPY5S0K/i6TXfYWuwJrYwjFDPy9nVKD6AYJS4YNYvweH/aYI
	RTmBCr3JFoQv00X7BETDhz1q9JH/nbXXlL6SzOg=
X-Google-Smtp-Source: AGHT+IHf2pAR6Q8PUvQZ3cTerVG5mzuCP5m4ZUIg6/7dvs2mvZ4gJkImZqtxsfCAYoGam8UllMLA+eGq6DUbJ56GSlY=
X-Received: by 2002:a05:6512:2821:b0:50b:c0f1:f532 with SMTP id
 cf33-20020a056512282100b0050bc0f1f532mr2853395lfb.26.1702271647721; Sun, 10
 Dec 2023 21:14:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-6-luizluca@gmail.com>
 <foqrrb6oox3z4ptmm3n4bon457jyr25blk2f57itipdf4rppt3@5vpukw2pnucj>
In-Reply-To: <foqrrb6oox3z4ptmm3n4bon457jyr25blk2f57itipdf4rppt3@5vpukw2pnucj>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 11 Dec 2023 02:13:56 -0300
Message-ID: <CAJq09z5nyuzAPcsGcn+fOFmO4nAdvmX9rpFPPykHY7gZux8OCg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/7] net: dsa: realtek: merge interface modules
 into common
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> > As both realtek-common and realtek-{smi,mdio} must always be loaded
> > together, we can save some resources merging them into a single module.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  drivers/net/dsa/realtek/Kconfig          | 4 ++--
> >  drivers/net/dsa/realtek/Makefile         | 8 +++++---
> >  drivers/net/dsa/realtek/realtek-common.c | 1 +
> >  drivers/net/dsa/realtek/realtek-mdio.c   | 4 ----
> >  drivers/net/dsa/realtek/realtek-smi.c    | 4 ----
> >  5 files changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
> > index 9d182fde11b4..6989972eebc3 100644
> > --- a/drivers/net/dsa/realtek/Kconfig
> > +++ b/drivers/net/dsa/realtek/Kconfig
> > @@ -16,14 +16,14 @@ menuconfig NET_DSA_REALTEK
> >  if NET_DSA_REALTEK
> >
> >  config NET_DSA_REALTEK_MDIO
> > -     tristate "Realtek MDIO interface support"
> > +     bool "Realtek MDIO interface support"
> >       depends on OF
> >       help
> >         Select to enable support for registering switches configured
> >         through MDIO.
> >
> >  config NET_DSA_REALTEK_SMI
> > -     tristate "Realtek SMI interface support"
> > +     bool "Realtek SMI interface support"
> >       depends on OF
> >       help
> >         Select to enable support for registering switches connected
> > diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
> > index 5e0c1ef200a3..88f6652f9850 100644
> > --- a/drivers/net/dsa/realtek/Makefile
> > +++ b/drivers/net/dsa/realtek/Makefile
> > @@ -1,7 +1,9 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-$(CONFIG_NET_DSA_REALTEK)                += realtek-common.o
> > -obj-$(CONFIG_NET_DSA_REALTEK_MDIO)   += realtek-mdio.o
> > -obj-$(CONFIG_NET_DSA_REALTEK_SMI)    += realtek-smi.o
> > +obj-$(CONFIG_NET_DSA_REALTEK)                += realtek_common.o
> > +realtek_common-objs-y                        := realtek-common.o
>
> This is weird with the - and _. Also realtek-common is not a very
> descriptive module name. Maybe realtek-dsa?
>
> obj-$(CONFIG_NET_DSA_REALTEK) += realtek-dsa.o
> realtek-dsa-objs-y            += realtek-common.o
> realtek-dsa-objs-$(..._MDIO)  += realtek-mdio.o
> realtek-dsa-objs-$(..._SMI)   += realtek-smi.o

Yes, I'm not proud of it. The realtek_common/realtek-common trick is
just to bypass the fact that I cannot link multiple files into a
module that has the same name as one of these files. But realtek-dsa
is fine and it would avoid conflicts with other realtek stuff in the
kernel that might have a common module. However, I would introduce
that name already in the previous patch.

> Also what happens if I just enable CONFIG_NET_DSA_REALTEK and nothing
> else. Do I get a module that doesn't do anything? Not sure if it's a big
> deal.

The config language might not be good enough to handle that nicely.
There is the "imply" keyword but it does not force anything. I don't
know how to require "at least one of these two interfaces" without
creating a dependency cycle. I would just let it build a useless
common module. Building without variants does make a little bit of
sense if you want to build a new driver out-of-tree.

> > +realtek_common-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) += realtek-mdio.o
> > +realtek_common-objs-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
> > +realtek_common-objs                  := $(realtek_common-objs-y)
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
> >  rtl8366-objs                                 := rtl8366-core.o rtl8366rb.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
> > diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
> > index 75b6aa071990..73c25d114dd3 100644
> > --- a/drivers/net/dsa/realtek/realtek-common.c
> > +++ b/drivers/net/dsa/realtek/realtek-common.c
> > @@ -132,5 +132,6 @@ void realtek_common_remove(struct realtek_priv *priv)
> >  EXPORT_SYMBOL(realtek_common_remove);
> >
> >  MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
> > +MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> >  MODULE_DESCRIPTION("Realtek DSA switches common module");
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 4c9a744b72f8..bb5bff719ae9 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -168,7 +168,3 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> >       dev_set_drvdata(&mdiodev->dev, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_mdio_shutdown);
> > -
> > -MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
> > -MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
> > -MODULE_LICENSE("GPL");
> > diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> > index 246024eec3bd..1ca2aa784d24 100644
> > --- a/drivers/net/dsa/realtek/realtek-smi.c
> > +++ b/drivers/net/dsa/realtek/realtek-smi.c
> > @@ -443,7 +443,3 @@ void realtek_smi_shutdown(struct platform_device *pdev)
> >       platform_set_drvdata(pdev, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_smi_shutdown);
> > -
> > -MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> > -MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
> > -MODULE_LICENSE("GPL");
> > --
> > 2.43.0
> >

