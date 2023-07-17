Return-Path: <netdev+bounces-18152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0AE7559B8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 04:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3830128137D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 02:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B2139B;
	Mon, 17 Jul 2023 02:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF931365
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:43:30 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B9187
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 19:43:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso6192323e87.0
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 19:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689561806; x=1692153806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/rbaFBr1o1WpkBGUX8CuyV0YuFTgeUPikyuIhf+EvE=;
        b=K3Mb/t0FO1qVOX7kd3PzPv9ouKCPOirSTurifUS3hp0XAUNv4+5SfQKPDuJuqyE/cT
         9rdeQF3bv2zPYKA9d5ROWefv2U7I7ZBMnYYBvoO5KJnoxqZ8IpG0SwNpiNryFXuqZy2M
         //c7WxNHauCj1fqbxZPjFip4EoGhWxz3yoTenbPD1xZYeZ5w/y7vXPKUW9ibWncMdU8y
         7nQ6zR/Px1GXOhWExwQymtzU8LPu5Tex3i6BnE7RoOZX+ltbGU5/12AZqONsgDkRNNqR
         xkSiqfwlw0MXih5dapPBb2XoQtEs5lh0VB/j0gqxbq7aI5kTBha/2SzwC1O30GxRHNjB
         lcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689561806; x=1692153806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/rbaFBr1o1WpkBGUX8CuyV0YuFTgeUPikyuIhf+EvE=;
        b=SAJiMTn637X7WNU8Unyk8F/oH0wzGZYwBwga6YMWlxMpMnjufZQOpbMGQ8I7n/8Uuq
         T9dutrrMxR8a09FwskjqG0NM0apVaQKJj49/ocyp5pWh2ugBmuZcbUe8/aYsh/RI39mq
         gWm296JJw5qRD4hlaL4zbRQA+/YGYbHyqdDoyfZ7D1UYeHZOJurxgP4DVFi1Eyn9hwJv
         2Lm6R9jAv6nDmNP56Q6AR0b55gWSAqjJPeNVaHa2vvdYebC4WHemCr68IYB2iwyk0aJZ
         jRWu4NQtdwoWQV/Veny1/uPtuO+Jj+aKewwbw0xARc3Flo+IhtvQPd0k6EWE4Ju4mJjJ
         aKUw==
X-Gm-Message-State: ABy/qLbDaW1vqZ+7APmhac8cSEt1R5rsnESK17P7M4Hzw8Qk7x0+Y3lN
	qZLQ/mxXnQh0rEOclg4RoxUpqVXv0IKvaVW0Rmo=
X-Google-Smtp-Source: APBJJlEZwMnaiTG95a3lbYA/EQ/ugxl+LiVHyTtkU1lBXW7IyUkjmLK0UnEdBRvoSdpmQOEjyU+lnRm60uohNtFUFi0=
X-Received: by 2002:a05:6512:2243:b0:4fb:9da2:6cec with SMTP id
 i3-20020a056512224300b004fb9da26cecmr7097000lfu.7.1689561806084; Sun, 16 Jul
 2023 19:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
 <9e0b3466-10e1-4267-ab9b-d9f8149b6b6b@lunn.ch> <CACWXhKkX-syR01opOky=t-b8C3nhV5f_WNfCQ-kOE+4o0xh4tA@mail.gmail.com>
 <3cff46b0-5621-4881-8e70-362bb7a70ed1@lunn.ch>
In-Reply-To: <3cff46b0-5621-4881-8e70-362bb7a70ed1@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Mon, 17 Jul 2023 10:43:14 +0800
Message-ID: <CACWXhKk23muXROj6OrmeFna88ViJHA_7QpQZoWiFgzEPb4pLWQ@mail.gmail.com>
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

On Fri, Jul 14, 2023 at 12:20=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > > > +#include <linux/mii.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/netdevice.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/phy.h>
> > > > +
> > > > +#define PHY_ID_LS7A2000              0x00061ce0
> > >
> > > What is Loongson OUI?
> > >
> >
> > Currently, we do not have an OUI for Loongson, but we are in the
> > process of applying for one.
>
> Is the value 0x00061ce0 baked into the silicon? Or can it be changed
> once you have an OUI?
>

Hi, Andrew,

The value is baked into the silicon.

> > > > +#define GNET_REV_LS7A2000    0x00
> > > > +
> > > > +static int ls7a2000_config_aneg(struct phy_device *phydev)
> > > > +{
> > > > +     if (phydev->speed =3D=3D SPEED_1000)
> > > > +             phydev->autoneg =3D AUTONEG_ENABLE;
> > >
> > > Please explain.
> > >
> >
> > The PHY itself supports half-duplex, but there are issues with the
> > controller used in the 7A2000 chip. Moreover, the controller only
> > supports auto-negotiation for gigabit speeds.
>
> So you can force 10/100/1000, but auto neg only succeeds for 1G?
>
> Are the LP autoneg values available for genphy_read_lpa() to read? If
> the LP values are available, maybe the PHY driver can resolve the
> autoneg for 10 an 100.
>

I apologize for the confusion caused by my previous description. To
clarify, the PHY supports auto-negotiation and non-auto-negotiation
for 10/100, but non-auto-negotiation for 1000 does not work correctly.

> > > > +     if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> > > > +         phydev->advertising) ||
> > > > +         linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > > > +         phydev->advertising) ||
> > > > +         linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > > > +         phydev->advertising))
> > > > +         return genphy_config_aneg(phydev);
> > > > +
> > > > +     netdev_info(phydev->attached_dev, "Parameter Setting Error\n"=
);
> > >
> > > This also needs explaining. How can it be asked to do something it
> > > does not support?
> > >
> >
> > Perhaps I missed something, but I think that if someone uses ethtool,
> > they can request it to perform actions or configurations that the
> > tool does not support.
>
> No. The PHY should indicate what it can do, via the .get_abilities()
> etc. The MAC can also remove some of those link modes if it is more
> limited than the PHY. phylib will then not allow ksetting_set() to
> enable things which are not supported. So this should not happen.  It
> would actually be a bad design, since it would force every driver to
> do such checks, rather than implement it once in the core.
>

I see.

> > > > +int ls7a2000_match_phy_device(struct phy_device *phydev)
> > > > +{
> > > > +     struct net_device *ndev;
> > > > +     struct pci_dev *pdev;
> > > > +
> > > > +     if ((phydev->phy_id & 0xfffffff0) !=3D PHY_ID_LS7A2000)
> > > > +             return 0;
> > > > +
> > > > +     ndev =3D phydev->mdio.bus->priv;
> > > > +     pdev =3D to_pci_dev(ndev->dev.parent);
> > > > +
> > > > +     return pdev->revision =3D=3D GNET_REV_LS7A2000;
> > >
> > > That is very unusual. Why is the PHY ID not sufficient?
> > >
> >
> > To work around the controller's issues, we enable the usage of this
> > driver specifically for a certain version of the 7A2000 chip.
> >
> > > > +}
> > > > +
> > > > +static struct phy_driver loongson_phy_driver[] =3D {
> > > > +     {
> > > > +             PHY_ID_MATCH_MODEL(PHY_ID_LS7A2000),
> > > > +             .name                   =3D "LS7A2000 PHY",
> > > > +             .features               =3D PHY_LOONGSON_FEATURES,
> > >
> > > So what are the capabilities of this PHY? You seem to have some very
> > > odd hacks here, and no explanation of why they are needed. If you do
> > > something which no other device does, you need to explain it.
> > >
> > > Does the PHY itself only support full duplex? No half duplex? Does th=
e
> > > PHY support autoneg? Does it support fixed settings? What does
> > > genphy_read_abilities() return for this PHY?
> > >
> >
> > As mentioned earlier, this driver is specifically designed for the PHY
> > on the problematic 7A2000 chip. Therefore, we assume that this PHY only
> > supports full- duplex mode and performs auto-negotiation exclusively fo=
r
> > gigabit speeds.
>
> So what does genphy_read_abilities() return?
>
> Nobody else going to use PHY_LOONGSON_FEATURES, so i would prefer not
> to add it to the core. If your PHY is designed correctly,
> genphy_read_abilities() should determine what the PHY can do from its
> registers. If the registers are wrong, it is better to add a
> .get_features function.
>

genphy_read_abilities() returns 0, and it seems to be working fine.
The registers are incorrect, so I will use the .get_features function
to clear some of the half-duplex bits.

Thanks,
Feiyang

>         Andrew

