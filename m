Return-Path: <netdev+bounces-18269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C5375629D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D028A1C209D0
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94767AD49;
	Mon, 17 Jul 2023 12:22:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89591AD47
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:22:48 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F37D8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cG6nG/b4bazlNJIdWGfk34tKBziyItdNCj+VKW4ia44=; b=ePql7BmSg7lQn2BFKmg/h7xG9l
	Sk99BC9HAAmgnPA1o1nxFfWcHyem7mEB0OFjujGpYYWZ11fvAvdCkkZfP+/YiyAB9P8rG0BL//JWj
	ZSH19s/OWIGdRD+gC10wkYuGB9KJkxu1XCMYDoT8Yx+Ymm2wYRKyMUcvuU+BXpQwoO0Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLNFD-001Xjx-5P; Mon, 17 Jul 2023 14:22:27 +0200
Date: Mon, 17 Jul 2023 14:22:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
	dongbiao@loongson.cn, loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [RFC PATCH 01/10] net: phy: Add driver for Loongson PHY
Message-ID: <9568c4ad-e10f-4b76-8766-ec621f788c40@lunn.ch>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
 <9e0b3466-10e1-4267-ab9b-d9f8149b6b6b@lunn.ch>
 <CACWXhKkX-syR01opOky=t-b8C3nhV5f_WNfCQ-kOE+4o0xh4tA@mail.gmail.com>
 <3cff46b0-5621-4881-8e70-362bb7a70ed1@lunn.ch>
 <CACWXhKk23muXROj6OrmeFna88ViJHA_7QpQZoWiFgzEPb4pLWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACWXhKk23muXROj6OrmeFna88ViJHA_7QpQZoWiFgzEPb4pLWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > > > +#define PHY_ID_LS7A2000              0x00061ce0
> > > >
> > > > What is Loongson OUI?
> > > >
> > >
> > > Currently, we do not have an OUI for Loongson, but we are in the
> > > process of applying for one.
> >
> > Is the value 0x00061ce0 baked into the silicon? Or can it be changed
> > once you have an OUI?
> >
> 
> Hi, Andrew,
> 
> The value is baked into the silicon.

O.K. Thanks. Do you have an idea how long it will take to get an OUI?

Does the PCI ID uniquely identify the MAC+PHY combination? 

> > > The PHY itself supports half-duplex, but there are issues with the
> > > controller used in the 7A2000 chip. Moreover, the controller only
> > > supports auto-negotiation for gigabit speeds.
> >
> > So you can force 10/100/1000, but auto neg only succeeds for 1G?
> >
> > Are the LP autoneg values available for genphy_read_lpa() to read? If
> > the LP values are available, maybe the PHY driver can resolve the
> > autoneg for 10 an 100.
> >
> 
> I apologize for the confusion caused by my previous description. To
> clarify, the PHY supports auto-negotiation and non-auto-negotiation
> for 10/100, but non-auto-negotiation for 1000 does not work correctly.

So you can force 10/100, but auto-neg 10/100/1000.

So i would suggest .get_features() indicates normal 10/100/1000
operation. Have your .config_aneg function which is used for both
auto-neg and forced configuration check for phydev->autoneg ==
AUTONEG_DISABLE and phydev->speed == SPEED_1000 and return
-EOPNOTSUPP. Otherwise call genphy_config_aneg().

> > So what does genphy_read_abilities() return?
> >
> > Nobody else going to use PHY_LOONGSON_FEATURES, so i would prefer not
> > to add it to the core. If your PHY is designed correctly,
> > genphy_read_abilities() should determine what the PHY can do from its
> > registers. If the registers are wrong, it is better to add a
> > .get_features function.
> >
> 
> genphy_read_abilities() returns 0, and it seems to be working fine.
> The registers are incorrect, so I will use the .get_features function
> to clear some of the half-duplex bits.

You said above that the PHY supports half duplex, the MAC has problems
with half duplex. So it should be the MAC which indicates it does not
unsupported half duplex link modes.

So you need to modify phylink_config.mac_capabilities before
phylink_create() is called. There is already

        /* Half-Duplex can only work with single queue */
	if (priv->plat->tx_queues_to_use > 1)
                priv->phylink_config.mac_capabilities &=
                        ~(MAC_10HD | MAC_100HD | MAC_1000HD);

so you just need to add a quirk for your broken hardware.

	Andrew


