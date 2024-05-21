Return-Path: <netdev+bounces-97382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E48CB2DA
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 19:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072AA1F25433
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A0148FF8;
	Tue, 21 May 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AKHJbxhM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2B148FF1;
	Tue, 21 May 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716312025; cv=none; b=IKvZP9B8f+wpAVI6/7MYCbdi7qfobx9HxjvvkxES3/bdcTPupJF4eeNRwI9USrsvRX9AZnSNf6LjlZzsMtrlqxcXH+4Kc5oG3gOz3Oz99qnyverfkde6TW1G5DpB5/zWKkJIRYhrCcDq/Wgawmwdn3Zhf9YtnGmf6BxRrgIIHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716312025; c=relaxed/simple;
	bh=sLZewRsrmNpaJP7tTnB+1/BI0Dnn4A+0e+vApcxPRK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnQ6XsooZYActmRj5DqKq4KamkfGQuZqPgo/RcsOu5IxOobFP95FwCm/v8o7IVsZCOf5w0Cwb2vCcBS3RqvCrvF8hOjrkRQZk0uYRb5LKvsonVfBQfz+NVwfxtipfOG34UPmDLAQB4DHJyhEfpNMNFVqtBUceG7wAtPove5fL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AKHJbxhM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RJd+jLDj+nE6uz28VeZVLjgHVLytLup2I3KEv0uM3ZI=; b=AKHJbxhM8E812pfN+rbN0A7Ynb
	lb5RZeWMAMx0mSYA/q4bjkMOiudDWCg4Sse12fhYsvum5aFfc7jwBbEFdaOaJDWNZFO1PM2QyEoEb
	+MY3XeYM8qtLfBKxEwNwsDo9LLpoDjqIqbrYS03jPvAnTmZzR8qRXxoROLSaUXYGm8rY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9T9k-00Fm5g-V6; Tue, 21 May 2024 19:20:08 +0200
Date: Tue, 21 May 2024 19:20:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <5b437ed2-1404-47f8-a320-f44dee98dfee@lunn.ch>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
 <20240520113456.21675-6-SkyLake.Huang@mediatek.com>
 <62b19955-23b8-4cd1-b09c-68546f612b44@lunn.ch>
 <f7bc69930796b3797dc0e31237267e045a86f823.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bc69930796b3797dc0e31237267e045a86f823.camel@mediatek.com>

>     That is to say, for safety, we need to load firmware again right
> atfer booting into Linux kernel. Actually, this takes just about 11ms.

Since this is only 11ms, its not a big deal. If this was going over
MDIO it would be much slower and then it does become significant.

> > > +/* Setup LED */
> > > +phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
> > > + MTK_PHY_LED_ON_POLARITY | MTK_PHY_LED_ON_LINK10 |
> > > + MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK1000 |
> > > + MTK_PHY_LED_ON_LINK2500);
> > > +phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_ON_CTRL,
> > > + MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX);
> > > +
> > > +pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "i2p5gbe-
> > led");
> > 
> > Calls to devm_pinctrl_get_select() is pretty unusual in drivers:
> > 
> > 
> https://elixir.bootlin.com/linux/latest/C/ident/devm_pinctrl_get_select
> > 
> > Why is this needed? Generally, the DT file should describe the needed
> > pinmux setting, without needed anything additionally.
> > 
> This is needed because we need to switch to i2p5gbe-led pinmux group
> after we set correct polarity. Or LED may blink unexpectedly.

Since this is unusual, you should add a comment. Also, does the device
tree binding explain this? I expect most DT authors are used to
listing all the needed pins in the default pinmux node, and so will do
that, unless there is a comment in the binding advising against it.

> > It is a bit late doing this now. The user requested this a long time
> > ago, and it will be hard to understand why it now returns EOPNOTSUPP.
> > You should check for AUTONEG_DISABLE in config_aneg() and return the
> > error there.
> > 
> >       Andrew
> Maybe I shouldn't return EOPNOTSUPP in config_aneg directly?
> In this way, _phy_state_machine will be broken if I trigger "$ ethtool
> -s ethtool eth1 autoneg off"
> 
> [  520.781368] ------------[ cut here ]------------
> root@OpenWrt:/# [  520.785978] _phy_start_aneg+0x0/0xa4: returned: -95
> [  520.792263] WARNING: CPU: 3 PID: 423 at drivers/net/phy/phy.c:1254 _phy_state_machine+0x78/0x258
> [  520.801039] Modules linked in:
> [  520.804087] CPU: 3 PID: 423 Comm: kworker/u16:4 Tainted: G        W          6.8.0-rc7-next-20240306-bpi-r3+ #102
> [  520.814335] Hardware name: MediaTek MT7988A Reference Board (DT)
> [  520.820330] Workqueue: events_power_efficient phy_state_machine
> [  520.826240] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  520.833190] pc : _phy_state_machine+0x78/0x258
> [  520.837623] lr : _phy_state_machine+0x78/0x258
> [  520.842056] sp : ffff800084b7bd30
> [  520.845360] x29: ffff800084b7bd30 x28: 0000000000000000 x27: 0000000000000000
> [  520.852487] x26: ffff000000c56900 x25: ffff000000c56980 x24: ffff000000012ac0
> [  520.859613] x23: ffff00000001d005 x22: ffff000000fdf000 x21: 0000000000000001
> [  520.866738] x20: 0000000000000004 x19: ffff000003a90000 x18: ffffffffffffffff
> [  520.873864] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800104b7b977
> [  520.880988] x14: 0000000000000000 x13: 0000000000000183 x12: 00000000ffffffea
> [  520.888114] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff8000837222f0
> [  520.895239] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
> [  520.902365] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [  520.909490] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000004120000
> [  520.916615] Call trace:
> [  520.919052]  _phy_state_machine+0x78/0x258
> [  520.923139]  phy_state_machine+0x2c/0x80
> [  520.927051]  process_one_work+0x178/0x31c
> [  520.931054]  worker_thread+0x280/0x494
> [  520.934795]  kthread+0xe4/0xe8
> [  520.937841]  ret_from_fork+0x10/0x20
> [  520.941408] ---[ end trace 0000000000000000 ]---
> 
> Now I prefer to give a warning like this, in
> mt798x_2p5ge_phy_config_aneg():
> if (phydev->autoneg == AUTONEG_DISABLE) {
> 	dev_warn(&phydev->mdio.dev, "Once AN off is set, this phy can't
> link.\n");
> 	return genphy_c45_pma_setup_forced(phydev);
> }

That is ugly.

Ideally we should fix phylib to support a PHY which cannot do fixed
link. I suggest you first look at phy_ethtool_ksettings_set() and see
what it does if passed cmd->base.autoneg == True, but
ETHTOOL_LINK_MODE_Autoneg_BIT is not set in supported, because the PHY
does not support autoneg. Is that handled? Does it return EOPNOTSUPP?
Understanding this might help you implement the opposite.

The opposite is however not easy. There is no linkmode bit indicating
a PHY can do forced settings. The BMSR has a bit indicating the PHY is
capable of auto-neg, which is used to set
ETHTOOL_LINK_MODE_Autoneg_BIT. However there is no bit to indicate the
PHY supports forced configuration. The standard just assumes all PHYs
which are standard conforming can do forced settings. And i think this
is the first PHY we have come across which is broken like this.

So maybe we cannot fix this in phylib. In that case, the MAC drivers
ksetting_set() should check if the user is attempting to disable
autoneg, and return -EOPNOTSUPP. And i would keep the stack trace
above, which will help developers understand they need the MAC to help
out work around the broken PHY. You can probably also simplify the PHY
driver, take out any code which tries to handle forced settings.

	Andrew



