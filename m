Return-Path: <netdev+bounces-203106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0968AF0850
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997F94235F7
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989AB192D6B;
	Wed,  2 Jul 2025 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqcYeDqD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668CC1553AA;
	Wed,  2 Jul 2025 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751422201; cv=none; b=nnmcJa6tRvK4UTWf5GvgFA8bfPVCpwGTD/GMMa/RJCqwp4A//Zz/U4FDD+kFm45ArV8Mk7jr3Ft77KiMWZdXvkKXuGrPaDTD6sT6UfHXGfRfgByDrQ6hhiXknbmkSDdYitIxjH84p7iTDf+98TFVJn9UPNu6JTA75I1IVYhhX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751422201; c=relaxed/simple;
	bh=u+eeCAa/SMbfFXGIhPFmHKU00HmZAfkLNYG9xaYS1bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev9fAiF8s1biksOey+LTCdDrJO/UCbQg0zID8v2NXkLmBVqR8p/jyy08kA/WJOBa/BRLljYr/DDym4bfjUWfqn6CHdDqlYkjo3SWD6TgKa+WmpGoFGiImCJYa2AhWirTRIJADIPeOjRfzri/bORYnHzqGCUFplv+GtHDP8GY5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqcYeDqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE713C4CEF2;
	Wed,  2 Jul 2025 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751422201;
	bh=u+eeCAa/SMbfFXGIhPFmHKU00HmZAfkLNYG9xaYS1bc=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=KqcYeDqDW1mitkomoKfjt8FI7qT9C95jCYcj2ZASJbWl+skMq45qv+qjiwgZmq/Ee
	 +TWtIiLXjpMhl8V+UQVGDCRYY181ruZsYbkF+DSOah6NGxRxbe0YIUsJoXchSBw9tW
	 NBeFDh4V/gkG1WfJUAxwxFSbzXOQt9B90bd/mZHbtYofEFF3eZ7m4EtE65r7qJrA/O
	 hC19xQ43uZkeU/etnY7sRyXX83dBu1UuW6F5bzaXGMTaFBn7NlSWcsueAw5MGdQhr9
	 2juRNQBbf8vA5siWinRaNPA+H7JJLHEWt9eE2VzGyLK58/7PSpZaoSa/EF7V4FrOXM
	 xfT8H1fSENxrQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-555163cd09aso3147378e87.3;
        Tue, 01 Jul 2025 19:10:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8fKyG8/FsQA0qQrIbjFa74EPMrEuI9bNXA662sCFznEmUzMLcoT6viNI4kyhl07/FbXoji8xFsoKr@vger.kernel.org, AJvYcCWEgP/ASjbZm3RsN7R/wmPwxOp9tUFdtjLpLnr3CbfCfvjPilovhMgh00IRD2XZf2x94LzRSFij@vger.kernel.org, AJvYcCWKLBH3Rzc2KSfzjCBuc576l401wPixRpIBBqjI82NLoX1iTtcX34YOmN1OAuRG7X3jGSieemDvRCuvDJJ3@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWlJEcCNMW/mQPi8iCqCeBo4hb6IHUOxXVZsVhNm76SEaSVLL
	RAhF8krdVBRtgmShJXs5I+17kU8CSj0JlMIT+JjACO11tUKYhELIy5VZ80ei4+s7qkRZh7eiJ/f
	W8aM1ND4f/Zl9jPlTwS7ovi1XXXNEXlQ=
X-Google-Smtp-Source: AGHT+IExQsqR+GkLIkcYZVnIhwtqeUxgvDRyCT2rsQLCgxbz7hvEKkOqilsUyV4/3BGqleecD5hg31pOgPJo1qEuhHQ=
X-Received: by 2002:ac2:4bcb:0:b0:553:5148:5b69 with SMTP id
 2adb3069b0e04-5562832ebd7mr288411e87.36.1751422199297; Tue, 01 Jul 2025
 19:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701165756.258356-1-wens@kernel.org> <20250701165756.258356-3-wens@kernel.org>
 <15ba0933-b0c1-40eb-9d3c-d8837d6ee12a@linux.dev>
In-Reply-To: <15ba0933-b0c1-40eb-9d3c-d8837d6ee12a@linux.dev>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 2 Jul 2025 10:09:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v646pxuT-nrwtDD-wvrA0eoxaee6sq2-mb0WoqUCPzpRjg@mail.gmail.com>
X-Gm-Features: Ac12FXycPpmF1Db6tRvOloPbMgcZjGtgFpDdr0Kf5ejzMWZ9PKuxrVUm___NGNc
Message-ID: <CAGb2v646pxuT-nrwtDD-wvrA0eoxaee6sq2-mb0WoqUCPzpRjg@mail.gmail.com>
Subject: Re: [PATCH RFT net-next 02/10] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 10:00=E2=80=AFAM Yanteng Si <si.yanteng@linux.dev> w=
rote:
>
> =E5=9C=A8 7/2/25 12:57 AM, Chen-Yu Tsai =E5=86=99=E9=81=93:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The Allwinner A523 SoC family has a second Ethernet controller, called
> > the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> > numbering. This controller, according to BSP sources, is fully
> > compatible with a slightly newer version of the Synopsys DWMAC core.
> > The glue layer around the controller is the same as found around older
> > DWMAC cores on Allwinner SoCs. The only slight difference is that since
> > this is the second controller on the SoC, the register for the clock
> > delay controls is at a different offset. Last, the integration includes
> > a dedicated clock gate for the memory bus and the whole thing is put in
> > a separately controllable power domain.
> >
> > Add a new driver for this hardware supporting the integration layer.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
> >   drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> >   .../ethernet/stmicro/stmmac/dwmac-sun55i.c    | 161 +++++++++++++++++=
+
> >   3 files changed, 174 insertions(+)
> >   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/=
ethernet/stmicro/stmmac/Kconfig
> > index 67fa879b1e52..38ce9a0cfb5b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -263,6 +263,18 @@ config DWMAC_SUN8I
> >         stmmac device driver. This driver is used for H3/A83T/A64
> >         EMAC ethernet controller.
> >
> > +config DWMAC_SUN55I
> > +     tristate "Allwinner sun55i GMAC200 support"
> > +     default ARCH_SUNXI
> > +     depends on OF && (ARCH_SUNXI || COMPILE_TEST)
> > +     select MDIO_BUS_MUX
> > +     help
> > +       Support for Allwinner A523/T527 GMAC200 ethernet controllers.
> > +
> > +       This selects Allwinner SoC glue layer support for the
> > +       stmmac device driver. This driver is used for A523/T527
> > +       GMAC200 ethernet controller.
> > +
> >   config DWMAC_THEAD
> >       tristate "T-HEAD dwmac support"
> >       depends on OF && (ARCH_THEAD || COMPILE_TEST)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net=
/ethernet/stmicro/stmmac/Makefile
> > index b591d93f8503..51e068e26ce4 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > @@ -31,6 +31,7 @@ obj-$(CONFIG_DWMAC_STI)             +=3D dwmac-sti.o
> >   obj-$(CONFIG_DWMAC_STM32)   +=3D dwmac-stm32.o
> >   obj-$(CONFIG_DWMAC_SUNXI)   +=3D dwmac-sunxi.o
> >   obj-$(CONFIG_DWMAC_SUN8I)   +=3D dwmac-sun8i.o
> > +obj-$(CONFIG_DWMAC_SUN55I)   +=3D dwmac-sun55i.o
> >   obj-$(CONFIG_DWMAC_THEAD)   +=3D dwmac-thead.o
> >   obj-$(CONFIG_DWMAC_DWC_QOS_ETH)     +=3D dwmac-dwc-qos-eth.o
> >   obj-$(CONFIG_DWMAC_INTEL_PLAT)      +=3D dwmac-intel-plat.o
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
> > new file mode 100644
> > index 000000000000..7fadb90e3098
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
> > @@ -0,0 +1,161 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * dwmac-sun55i.c - Allwinner sun55i GMAC200 specific glue layer
> > + *
> > + * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
> > + *
> > + * syscon parts taken from dwmac-sun8i.c, which is
> > + *
> > + * Copyright (C) 2017 Corentin Labbe <clabbe.montjoie@gmail.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/stmmac.h>
> > +
> > +#include "stmmac.h"
> > +#include "stmmac_platform.h"
> > +
> > +#define SYSCON_REG           0x34
> > +
> > +/* RMII specific bits */
> > +#define SYSCON_RMII_EN               BIT(13) /* 1: enable RMII (overri=
des EPIT) */
> insert a blankline.

OK.

> > +/* Generic system control EMAC_CLK bits */
> > +#define SYSCON_ETXDC_MASK            GENMASK(12, 10)
> > +#define SYSCON_ERXDC_MASK            GENMASK(9, 5)
> ditto.

OK.

> > +/* EMAC PHY Interface Type */
> > +#define SYSCON_EPIT                  BIT(2) /* 1: RGMII, 0: MII */
> > +#define SYSCON_ETCS_MASK             GENMASK(1, 0)
> > +#define SYSCON_ETCS_MII              0x0
> > +#define SYSCON_ETCS_EXT_GMII 0x1
> > +#define SYSCON_ETCS_INT_GMII 0x2
> > +
> > +#define MASK_TO_VAL(mask)   ((mask) >> (__builtin_ffsll(mask) - 1))
> > +
> > +static int sun55i_gmac200_set_syscon(struct device *dev,
> > +                                  struct plat_stmmacenet_data *plat)
> > +{
> > +     struct device_node *node =3D dev->of_node;
> > +     struct regmap *regmap;
> > +     u32 val, reg =3D 0;
> > +
> > +     regmap =3D syscon_regmap_lookup_by_phandle(node, "syscon");
> > +     if (IS_ERR(regmap))
> > +             return dev_err_probe(dev, PTR_ERR(regmap), "Unable to map=
 syscon\n");
> > +
> -----------
> > +     if (!of_property_read_u32(node, "allwinner,tx-delay-ps", &val)) {
> > +             if (val % 100) {
> > +                     dev_err(dev, "tx-delay must be a multiple of 100\=
n");
> > +                     return -EINVAL;
> > +             }
> > +             val /=3D 100;
> > +             dev_dbg(dev, "set tx-delay to %x\n", val);
> > +             if (val > MASK_TO_VAL(SYSCON_ETXDC_MASK))
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                                          "Invalid TX clock delay: %d\=
n",
> > +                                          val);
> > +
> > +             reg |=3D FIELD_PREP(SYSCON_ETXDC_MASK, val);
> > +     }
> > +
> > +     if (!of_property_read_u32(node, "allwinner,rx-delay-ps", &val)) {
> > +             if (val % 100) {
> > +                     dev_err(dev, "rx-delay must be a multiple of 100\=
n");
> > +                     return -EINVAL;
> > +             }
> > +             val /=3D 100;
> > +             dev_dbg(dev, "set rx-delay to %x\n", val);
> > +             if (val > MASK_TO_VAL(SYSCON_ERXDC_MASK))
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                                          "Invalid RX clock delay: %d\=
n",
> > +                                          val);
> > +
> > +             reg |=3D FIELD_PREP(SYSCON_ERXDC_MASK, val);
> > +     }
> ------------
> These two parts of the code are highly similar.
> Can you construct a separate function?

As in, have a function that sets up either TX or RX delay based on
a parameter? That also means constructing the property name on the
fly or using ternary ops. And chopping up the log messages.

I don't think this makes it easier to read. And chopping up the log
message makes it harder to grep.

> > +
> > +     switch (plat->mac_interface) {
>
> > +     case PHY_INTERFACE_MODE_MII:
> > +             /* default */
> > +             break;
> This line of comment seems a bit abrupt here.

Default as in this is the 0 value register default.

OTOH the integration doesn't support MII, so I think I should drop this cas=
e.


Thanks
ChenYu

