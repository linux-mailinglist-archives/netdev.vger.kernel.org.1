Return-Path: <netdev+bounces-46274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950FD7E2FEB
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E808BB20A68
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4410C171D3;
	Mon,  6 Nov 2023 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhfPhTBw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655A2FE08
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 22:37:16 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0194D71
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 14:37:13 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso66636841fa.2
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 14:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699310232; x=1699915032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dCJkjY6uC/Q6/RQGmw2m0dgx9xG6v4WbTpOv5WhlsvM=;
        b=JhfPhTBw8P/dGmFQLJHI/c/6Q/+FWJDxlsh0UoVipggD61+5Zc73XFpKOFvgdFtjkt
         OWQRulqyO8rfAv7BDlQs0sgMSVAq99nxvFc41ixmHDW+vw8Alc+n/+XSbrX/1dcw0YWB
         7ElxJ30PLdjiMdoYXncLwSZfvqMLNgTGeEcXxXuhXrHTT4xnJLWvLD91HxHbcZDW7mru
         hqQHbIzaBrEkx728qJULS3xGQZ6kTiL5VucdlUS1x7eWxD/D2W2dochwhzHVv8WwbQU6
         +/R+487Svg+vzUTIJy3zWWP8ce4GEyoRkxRrkZOqtBirrdDCHtrbMnrrzAaRaRXis3ld
         q9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310232; x=1699915032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCJkjY6uC/Q6/RQGmw2m0dgx9xG6v4WbTpOv5WhlsvM=;
        b=eCLwlzdOEBjsLKkPWOjRl2kAeRkuAZqTXpYJgcyccXKYCzxHOVhcL69TGHFea1LPqE
         3PPUM6gfnR6xoCieNP9wPckbkn9w6mfPu34lWBmD+Dk3w6CDW6QeRr+OyYy9OJ6klyF5
         i2PkbPbSItdTW+1E8jnlTqGLuiA9QP1xzUS0cwu+ESVRaQhH9LnkpGMj5Rtoz82zlVsT
         Ttr5Yq+Idlppr+PaXcDFlx0ZmjOB8PZWq1ibIHf0PpAGMMdIjGrW0tSMu4sKNT7YZKQg
         mqG8AulbEp8Fpp1RPlMeuB37uyMeKrTf9Sk00cxQE8BsztmtYR/YY1tVI0FdXTCdk6Fa
         fFTg==
X-Gm-Message-State: AOJu0YzCj6osYaPWnysZIx1PH/jF5IiAxxek8Om+J53dWWwJg34PVz2T
	yJr23jeB9pVANFSe4B5uqsR14I/INKQILUlSsoE=
X-Google-Smtp-Source: AGHT+IHmVGswSZp5PRXi0BkTF1KCoQoD1x21HJkdyDbzIjVXBw0BGCEcT0RYno88E/S0hVikcNoDAC/e1hs/hEU0/O4=
X-Received: by 2002:ac2:4c2d:0:b0:509:46fb:1fe3 with SMTP id
 u13-20020ac24c2d000000b0050946fb1fe3mr10609176lfq.42.1699310231745; Mon, 06
 Nov 2023 14:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027190910.27044-1-luizluca@gmail.com> <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf> <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
 <CACRpkdairxqm_YVshEuk_KbnZw9oH2sKiHapY_sTrgc85_+AmQ@mail.gmail.com> <20231102155521.2yo5qpugdhkjy22x@skbuf>
In-Reply-To: <20231102155521.2yo5qpugdhkjy22x@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 6 Nov 2023 19:37:00 -0300
Message-ID: <CAJq09z5muf01d1gDAP9kcsxC9-V3sbmyqTok=FPOqLXfZB9gNw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset controller
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, netdev@vger.kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> On Thu, Nov 02, 2023 at 03:59:48PM +0100, Linus Walleij wrote:
> > I don't know if this is an answer to your question, but look at what I did in
> >
> > drivers/usb/fotg210/Makefile:
> >
> > # This setup links the different object files into one single
> > # module so we don't have to EXPORT() a lot of internal symbols
> > # or create unnecessary submodules.
> > fotg210-objs-y                          += fotg210-core.o
> > fotg210-objs-$(CONFIG_USB_FOTG210_HCD)  += fotg210-hcd.o
> > fotg210-objs-$(CONFIG_USB_FOTG210_UDC)  += fotg210-udc.o
> > fotg210-objs                            := $(fotg210-objs-y)
> > obj-$(CONFIG_USB_FOTG210)               += fotg210.o
> >
> > Everything starting with CONFIG_* is a Kconfig option obviously.
> >
> > The final module is just one file named fotg210.ko no matter whether
> > HCD (host controller), UDC (device controller) or both parts were
> > compiled into it. Often you just need one of them, sometimes you may
> > need both.
> >
> > It's a pretty clean example of how you do this "one module from
> > several optional parts" using Kbuild.
>
> To be clear, something like this is what you mean, right?
>
> diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
> index 060165a85fb7..857a039fb0f1 100644
> --- a/drivers/net/dsa/realtek/Kconfig
> +++ b/drivers/net/dsa/realtek/Kconfig
> @@ -15,39 +15,37 @@ menuconfig NET_DSA_REALTEK
>
>  if NET_DSA_REALTEK
>
> +config NET_DSA_REALTEK_INTERFACE
> +       tristate
> +       help
> +         Common interface driver for accessing Realtek switches, either
> +         through MDIO or SMI.
> +
>  config NET_DSA_REALTEK_MDIO
> -       tristate "Realtek MDIO interface driver"
> -       depends on OF
> -       depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
> -       depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
> -       depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
> +       tristate "Realtek MDIO interface support"
>         help
>           Select to enable support for registering switches configured
>           through MDIO.
>
>  config NET_DSA_REALTEK_SMI
> -       tristate "Realtek SMI interface driver"
> -       depends on OF
> -       depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
> -       depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
> -       depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
> +       bool "Realtek SMI interface support"
>         help
>           Select to enable support for registering switches connected
>           through SMI.
>
>  config NET_DSA_REALTEK_RTL8365MB
>         tristate "Realtek RTL8365MB switch subdriver"
> -       imply NET_DSA_REALTEK_SMI
> -       imply NET_DSA_REALTEK_MDIO
> +       select NET_DSA_REALTEK_INTERFACE
>         select NET_DSA_TAG_RTL8_4
> +       depends on OF
>         help
>           Select to enable support for Realtek RTL8365MB-VC and RTL8367S.
>
>  config NET_DSA_REALTEK_RTL8366RB
>         tristate "Realtek RTL8366RB switch subdriver"
> -       imply NET_DSA_REALTEK_SMI
> -       imply NET_DSA_REALTEK_MDIO
> +       select NET_DSA_REALTEK_INTERFACE
>         select NET_DSA_TAG_RTL4_A
> +       depends on OF
>         help
>           Select to enable support for Realtek RTL8366RB.
>
> diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
> index 0aab57252a7c..35b7734c0ad0 100644
> --- a/drivers/net/dsa/realtek/Makefile
> +++ b/drivers/net/dsa/realtek/Makefile
> @@ -1,6 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_NET_DSA_REALTEK_MDIO)     += realtek-mdio.o
> -obj-$(CONFIG_NET_DSA_REALTEK_SMI)      += realtek-smi.o
> +
> +obj-$(CONFIG_NET_DSA_REALTEK_INTERFACE) := realtek-interface.o
> +
> +realtek-interface-objs                 := realtek-interface-common.o
> +ifdef CONFIG_NET_DSA_REALTEK_MDIO
> +realtek-interface-objs                 += realtek-mdio.o
> +endif
> +ifdef CONFIG_NET_DSA_REALTEK_SMI
> +realtek-interface-objs                 += realtek-smi.o
> +endif
> +
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
>  rtl8366-objs                           := rtl8366-core.o rtl8366rb.o
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
> diff --git a/drivers/net/dsa/realtek/realtek-interface-common.c b/drivers/net/dsa/realtek/realtek-interface-common.c
> new file mode 100644
> index 000000000000..bb7c77cdb9e2
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/realtek-interface-common.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/module.h>
> +
> +#include "realtek-mdio.h"
> +#include "realtek-smi.h"
> +
> +static int __init realtek_interface_init(void)
> +{
> +       int err;
> +
> +       err = realtek_mdio_init();
> +       if (err)
> +               return err;
> +
> +       err = realtek_smi_init();
> +       if (err) {
> +               realtek_smi_exit();
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +module_init(realtek_interface_init);
> +
> +static void __exit realtek_interface_exit(void)
> +{
> +       realtek_smi_exit();
> +       realtek_mdio_exit();
> +}
> +module_exit(realtek_interface_exit);
> +
> +MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
> +MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> +MODULE_DESCRIPTION("Driver for interfacing with Realtek switches via MDIO or SMI");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index 292e6d087e8b..6997dec14de2 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
> -/* Realtek MDIO interface driver
> +/* Realtek MDIO interface support
>   *
>   * ASICs we intend to support with this driver:
>   *
> @@ -19,12 +19,12 @@
>   * Copyright (C) 2009-2010 Gabor Juhos <juhosg@openwrt.org>
>   */
>
> -#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/overflow.h>
>  #include <linux/regmap.h>
>
>  #include "realtek.h"
> +#include "realtek-mdio.h"
>
>  /* Read/write via mdiobus */
>  #define REALTEK_MDIO_CTRL0_REG         31
> @@ -283,8 +283,12 @@ static struct mdio_driver realtek_mdio_driver = {
>         .shutdown = realtek_mdio_shutdown,
>  };
>
> -mdio_module_driver(realtek_mdio_driver);
> +int realtek_mdio_init(void)
> +{
> +       return mdio_driver_register(&realtek_mdio_driver);
> +}
>
> -MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
> -MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
> -MODULE_LICENSE("GPL");
> +void realtek_mdio_exit(void)
> +{
> +       mdio_driver_unregister(&realtek_mdio_driver);
> +}
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.h b/drivers/net/dsa/realtek/realtek-mdio.h
> new file mode 100644
> index 000000000000..941b4ef9d531
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/realtek-mdio.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _REALTEK_MDIO_H
> +#define _REALTEK_MDIO_H
> +
> +#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_MDIO)
> +
> +int realtek_mdio_init(void);
> +void realtek_mdio_exit(void);
> +
> +#else
> +
> +static inline int realtek_mdio_init(void)
> +{
> +       return 0;
> +}
> +
> +static inline void realtek_mdio_exit(void)
> +{
> +}
> +
> +#endif
> +
> +#endif
> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> index 755546ed8db6..4c282bfc884d 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
> -/* Realtek Simple Management Interface (SMI) driver
> +/* Realtek Simple Management Interface (SMI) interface
>   * It can be discussed how "simple" this interface is.
>   *
>   * The SMI protocol piggy-backs the MDIO MDC and MDIO signals levels
> @@ -26,7 +26,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/spinlock.h>
>  #include <linux/skbuff.h>
> @@ -40,6 +39,7 @@
>  #include <linux/if_bridge.h>
>
>  #include "realtek.h"
> +#include "realtek-smi.h"
>
>  #define REALTEK_SMI_ACK_RETRY_COUNT            5
>
> @@ -560,8 +560,13 @@ static struct platform_driver realtek_smi_driver = {
>         .remove_new = realtek_smi_remove,
>         .shutdown = realtek_smi_shutdown,
>  };
> -module_platform_driver(realtek_smi_driver);
>
> -MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> -MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
> -MODULE_LICENSE("GPL");
> +int realtek_smi_init(void)
> +{
> +       return platform_driver_register(&realtek_smi_driver);
> +}
> +
> +void realtek_smi_exit(void)
> +{
> +       platform_driver_unregister(&realtek_smi_driver);
> +}
> diff --git a/drivers/net/dsa/realtek/realtek-smi.h b/drivers/net/dsa/realtek/realtek-smi.h
> new file mode 100644
> index 000000000000..9a4838321f94
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/realtek-smi.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _REALTEK_SMI_H
> +#define _REALTEK_SMI_H
> +
> +#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_SMI)
> +
> +int realtek_smi_init(void);
> +void realtek_smi_exit(void);
> +
> +#else
> +
> +static inline int realtek_smi_init(void)
> +{
> +       return 0;
> +}
> +
> +static inline void realtek_smi_exit(void)
> +{
> +}
> +
> +#endif
> +
> +#endif
> --
> 2.34.1
>
>
> It looks pretty reasonable to me. More stuff could go into
> realtek-interface-common.c, that could be called directly from
> realtek-smi.c and realtek-mdio.c without exporting anything.
>
> I've eliminated the possibility for the SMI and MDIO options to be
> anything other than y or n, because only a single interface module
> (the common one) exists, and the y/n/m quality of that is
> implied/selected by the drivers which depend on it. I hope I wasn't too
> trigger-happy with this.

Vladimir, you did all the work ;-) Thanks!

I implemented this code (with the fixes), and this is the result:

 30272 drivers/net/dsa/realtek/realtek-mdio.ko
 42176 drivers/net/dsa/realtek/realtek-smi.ko
114544 drivers/net/dsa/realtek/rtl8365mb.ko
115080 drivers/net/dsa/realtek/rtl8366.ko

 87264 drivers/net/dsa/realtek/realtek-interface.ko
114544 drivers/net/dsa/realtek/rtl8365mb.ko
115080 drivers/net/dsa/realtek/rtl8366.ko

It is still strange why merging both modules into a single
realtek-interface.ko results in a slightly larger file. Anyway, the
difference is not that significant. I still think that some systems
will miss that extra 30kb or 40kb for the interface code they don't
need.

Your proposed Kconfig does not attempt to avoid a realtek-interface
without both interfaces or without support for both switch families.
Is it possible in Kconfig to force it to, at least, select one of the
interfaces and one of the switches? Is it okay to leave it
unconstrained?

If merging the modules is the accepted solution, it makes me wonder if
rtl8365mb.ko and rtl8366.ko should get merged as well into a single
realtek-switch.ko. They are a hard dependency for realtek-interface.ko
(previously on each interface module). If the kernel is custom-built,
it would still be possible to exclude one switch family at build time.

I'll use these modules in OpenWrt, which builds a single kernel for a
bunch of devices. Is there a way to weakly depend on a module,
allowing the system to load only a single subdriver? Is it worth it?

Regards,

Luiz

