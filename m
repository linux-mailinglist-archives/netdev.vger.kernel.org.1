Return-Path: <netdev+bounces-17741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE7752F45
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932651C214C2
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450B809;
	Fri, 14 Jul 2023 02:15:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC26806
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:15:43 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776FD26BA
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:15:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b74209fb60so20852141fa.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689300940; x=1691892940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvLsHbiV1m3ahEGSt2agvJr5YDwUu2gET6Rpx6KCX04=;
        b=dmqjWzza1wAwFTCJ33XVDfIRamgYGV+vd0l2GlZbK/m2XPHBAuubZwNOIOGsub5/17
         fPvPtA+EO6dQLPhIkl1EJ4Ujb8EZXW3sZCYCzTarExLPiYv68SjDJViYQKkEMkAU1E4L
         NY8RX4r/EnS6ud9CgXTaHBoLgZL1m6R9hiDBPaJ+lxHvySVsVtDKNfbbV7zJPDNjCQMw
         dvrbigI2hT7voB9Jn6V5fknejMZjhZrSLVYRgMMAXw2H4UcvqwBE6n3sKNU7DXY40NB4
         PuzNIWZ3ItGx53D+HyV7/BuWlCUWsUT82HNcomdV2kOZXfYFr7hiXtJ1vqeFjQCUjVFM
         9pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689300940; x=1691892940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvLsHbiV1m3ahEGSt2agvJr5YDwUu2gET6Rpx6KCX04=;
        b=O56urZL3eZt9JFr6XiBFPKQw+07V1cmx9agFLk55Err6DRuB45NlOZ49nuF1pYCax6
         tyYAWZVZ64L1ZbowgCdK3nE8wUOfSrAxvV5AL5a8OTsWRghJTYyO5y1a/XqbZQss2fL6
         yoD6WT0hnWT8q6h4DSrn+4+gIWajfaI1AOAraSBYULIHEwhFX2CK6URBsw5bC98Na07K
         VoOFxxKQDQksgExjdR65eljUeZi+9Zzaa1gSbLdf/mgBlVaCCuafwwXOXCqRuTaJ/S+v
         9gWPGvsnpWzA330dCOT5zAwqYbok0TJQt7Aq0D1GEIN2acbnXqcG2pnxXlUYJs5G4SLg
         Xj1w==
X-Gm-Message-State: ABy/qLbPpkxG/ju/RURXiYzcm8+kDoe21zy1tVEzBtiRyzV3PAHnJmIM
	td7l1zWljQK4UgwMqfLAwhPAZUbOpypu87f/0hw=
X-Google-Smtp-Source: APBJJlGjMamGsT7Sh1MrmaXBEdtJb+aNAcDl1ChNizFCfRZe36iePDaAGAYQK43pKb6GQMAIp/hty54XbLwRkqrgbsc=
X-Received: by 2002:a2e:8082:0:b0:2b3:47b3:3c39 with SMTP id
 i2-20020a2e8082000000b002b347b33c39mr3034279ljg.23.1689300939288; Thu, 13 Jul
 2023 19:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
 <9e0b3466-10e1-4267-ab9b-d9f8149b6b6b@lunn.ch>
In-Reply-To: <9e0b3466-10e1-4267-ab9b-d9f8149b6b6b@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 14 Jul 2023 10:15:27 +0800
Message-ID: <CACWXhKkX-syR01opOky=t-b8C3nhV5f_WNfCQ-kOE+4o0xh4tA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] net: phy: Add driver for Loongson PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, chenhuacai@loongson.cn, 
	linux@armlinux.org.uk, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 12:00=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Thu, Jul 13, 2023 at 10:46:53AM +0800, Feiyang Chen wrote:
> > Add support for the Loongson PHY.
> >
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > ---
> >  drivers/net/phy/Kconfig        |  5 +++
> >  drivers/net/phy/Makefile       |  1 +
> >  drivers/net/phy/loongson-phy.c | 69 ++++++++++++++++++++++++++++++++++
>
> Please drop -phy from the filename. No other phy driver does this.
>

Hi, Andrew,

OK.

> >  drivers/net/phy/phy_device.c   | 16 ++++++++
> >  include/linux/phy.h            |  2 +
> >  5 files changed, 93 insertions(+)
> >  create mode 100644 drivers/net/phy/loongson-phy.c
> >
> > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > index 93b8efc79227..4f8ea32cbc68 100644
> > --- a/drivers/net/phy/Kconfig
> > +++ b/drivers/net/phy/Kconfig
> > @@ -202,6 +202,11 @@ config INTEL_XWAY_PHY
> >         PEF 7061, PEF 7071 and PEF 7072 or integrated into the Intel
> >         SoCs xRX200, xRX300, xRX330, xRX350 and xRX550.
> >
> > +config LOONGSON_PHY
> > +     tristate "Loongson PHY driver"
> > +     help
> > +       Supports the Loongson PHY.
> > +
> >  config LSI_ET1011C_PHY
> >       tristate "LSI ET1011C PHY"
> >       help
> > diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> > index f289ab16a1da..f775373e12b7 100644
> > --- a/drivers/net/phy/Makefile
> > +++ b/drivers/net/phy/Makefile
> > @@ -62,6 +62,7 @@ obj-$(CONFIG_DP83TD510_PHY) +=3D dp83td510.o
> >  obj-$(CONFIG_FIXED_PHY)              +=3D fixed_phy.o
> >  obj-$(CONFIG_ICPLUS_PHY)     +=3D icplus.o
> >  obj-$(CONFIG_INTEL_XWAY_PHY) +=3D intel-xway.o
> > +obj-$(CONFIG_LOONGSON_PHY)   +=3D loongson-phy.o
> >  obj-$(CONFIG_LSI_ET1011C_PHY)        +=3D et1011c.o
> >  obj-$(CONFIG_LXT_PHY)                +=3D lxt.o
> >  obj-$(CONFIG_MARVELL_10G_PHY)        +=3D marvell10g.o
> > diff --git a/drivers/net/phy/loongson-phy.c b/drivers/net/phy/loongson-=
phy.c
> > new file mode 100644
> > index 000000000000..d4aefa2110f8
> > --- /dev/null
> > +++ b/drivers/net/phy/loongson-phy.c
> > @@ -0,0 +1,69 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * LS7A PHY driver
> > + *
> > + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> > + *
> > + * Author: Zhang Baoqi <zhangbaoqi@loongson.cn>
> > + */
> > +
> > +#include <linux/mii.h>
> > +#include <linux/module.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/pci.h>
> > +#include <linux/phy.h>
> > +
> > +#define PHY_ID_LS7A2000              0x00061ce0
>
> What is Loongson OUI?
>

Currently, we do not have an OUI for Loongson, but we are in the
process of applying for one.

> > +#define GNET_REV_LS7A2000    0x00
> > +
> > +static int ls7a2000_config_aneg(struct phy_device *phydev)
> > +{
> > +     if (phydev->speed =3D=3D SPEED_1000)
> > +             phydev->autoneg =3D AUTONEG_ENABLE;
>
> Please explain.
>

The PHY itself supports half-duplex, but there are issues with the
controller used in the 7A2000 chip. Moreover, the controller only
supports auto-negotiation for gigabit speeds.

> > +
> > +     if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> > +         phydev->advertising) ||
> > +         linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > +         phydev->advertising) ||
> > +         linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > +         phydev->advertising))
> > +         return genphy_config_aneg(phydev);
> > +
> > +     netdev_info(phydev->attached_dev, "Parameter Setting Error\n");
>
> This also needs explaining. How can it be asked to do something it
> does not support?
>

Perhaps I missed something, but I think that if someone uses ethtool,
they can request it to perform actions or configurations that the
tool does not support.

> > +     return -1;
>
> Always use error codes. In this case EINVAL.
>

OK.

> > +}
> > +
> > +int ls7a2000_match_phy_device(struct phy_device *phydev)
> > +{
> > +     struct net_device *ndev;
> > +     struct pci_dev *pdev;
> > +
> > +     if ((phydev->phy_id & 0xfffffff0) !=3D PHY_ID_LS7A2000)
> > +             return 0;
> > +
> > +     ndev =3D phydev->mdio.bus->priv;
> > +     pdev =3D to_pci_dev(ndev->dev.parent);
> > +
> > +     return pdev->revision =3D=3D GNET_REV_LS7A2000;
>
> That is very unusual. Why is the PHY ID not sufficient?
>

To work around the controller's issues, we enable the usage of this
driver specifically for a certain version of the 7A2000 chip.

> > +}
> > +
> > +static struct phy_driver loongson_phy_driver[] =3D {
> > +     {
> > +             PHY_ID_MATCH_MODEL(PHY_ID_LS7A2000),
> > +             .name                   =3D "LS7A2000 PHY",
> > +             .features               =3D PHY_LOONGSON_FEATURES,
>
> So what are the capabilities of this PHY? You seem to have some very
> odd hacks here, and no explanation of why they are needed. If you do
> something which no other device does, you need to explain it.
>
> Does the PHY itself only support full duplex? No half duplex? Does the
> PHY support autoneg? Does it support fixed settings? What does
> genphy_read_abilities() return for this PHY?
>

As mentioned earlier, this driver is specifically designed for the PHY
on the problematic 7A2000 chip. Therefore, we assume that this PHY only
supports full- duplex mode and performs auto-negotiation exclusively for
gigabit speeds.

Thanks,
Feiyang

>         Andrew

