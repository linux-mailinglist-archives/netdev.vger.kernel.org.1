Return-Path: <netdev+bounces-18856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41436758E21
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BACD281655
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C498F50;
	Wed, 19 Jul 2023 06:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882F3D8C
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:51:17 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F105B1FC4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FMwWRkM1/XjZq+zyUUm3yKUq0t9DDi45K1JVEA6trWg=; b=MCBOCTu3K4CbdyQbH5L8CJoq8J
	UIy5rwixM3SDCs0ZF4jc2FFjY5Hq/36dAt3jnd8X0LyPeknpQhY3MBstxOitDL2zjclux3m6kA937
	/guyTBbUNqVKzP9J2OKACRyxgytlgz93QSE065LU/vbhqhKn5uio42kgBnw/r17cDnghqqqTesIaQ
	VMf6JiI11J2x4W5Z8RDHKcY1t5jiyE30+GLScRN1lt/kATlc+7PCQSi/wCRWD90vE4HQ1YETVzB+1
	2g9O6qQk+TwX0tnfRmUXL6ORIqEHM0uoQ+CzwLLUoZJr1wt/+w/F2rkb8tKqFm4Bmg8Yzs3DnlT6L
	Npykdy6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51588)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qM11X-0006tx-0O;
	Wed, 19 Jul 2023 07:50:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qM11P-0003rC-Pl; Wed, 19 Jul 2023 07:50:51 +0100
Date: Wed, 19 Jul 2023 07:50:51 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Simon Horman' <simon.horman@corigine.com>, kabel@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZLeHyzsRqxAj4ZGO@shell.armlinux.org.uk>
References: <043401d9b57d$66441e60$32cc5b20$@trustnetic.com>
 <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk>
 <043501d9b580$31798870$946c9950$@trustnetic.com>
 <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com>
 <ZLUymspsQlJL1k8n@shell.armlinux.org.uk>
 <013701d9b957$fc66f740$f534e5c0$@trustnetic.com>
 <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk>
 <013e01d9b95e$66c10350$344309f0$@trustnetic.com>
 <ZLZ70F74dPKCIdtK@shell.armlinux.org.uk>
 <017401d9b9e8$ddd1dd90$997598b0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017401d9b9e8$ddd1dd90$997598b0$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 10:29:38AM +0800, Jiawen Wu wrote:
> [59697.591809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=6, val=c000
> [59697.592811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=5, val=9a
> [59697.593814] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=2, val=2b
> [59697.594817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=3, val=9ab
> [59697.595811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=2, val=2b
> [59697.596811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=3, val=9ab
> [59697.597811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=4, regnum=2, val=141
> [59697.598809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=4, regnum=3, val=dab
> [59697.599809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=2, val=2b
> [59697.600810] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=3, val=9ab
> [59697.601815] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1e, regnum=8, val=0
> [59697.602930] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=8, val=fffe
> [59697.608811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=d00d, val=680b
> [59697.609823] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=c050, val=7e
> [59697.610814] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=c011, val=2
> [59697.611817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=c012, val=200
> [59697.611820] mv88x3310 txgbe-400:00: Firmware version 0.2.2.0
> [59697.612817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f001, val=803

So here we can see the PHY is already in low-power mode, so presumably
it's configured to do that from power-up?

> [59697.612820] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=1f, regnum=f08c, val=9600
> [59697.613819] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f08a, val=cd9a
> [59697.613822] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=1f, regnum=f08a, val=d9a
> [59697.614818] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=1, val=9ab
> [59697.615816] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=8, val=9701
> [59697.616817] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=b, val=1a4
> [59697.617814] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=3, regnum=14, val=e
> [59697.618809] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1, regnum=15, val=3
> [59697.619811] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=7, regnum=3c, val=0
> [59697.619831] mv88x3310 txgbe-400:00: attached PHY driver (mii_bus:phy_addr=txgbe-400:00, irq=POLL)

The following is where we attempt to power up the PHY:

> [59697.830169] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f001, val=803
> [59697.830179] txgbe 0000:04:00.0: [W]phy_addr=0, devnum=1f, regnum=f001, val=3

The above is our attempt to clear the low power bit.

> [59697.830926] txgbe 0000:04:00.0: [R]phy_addr=0, devnum=1f, regnum=f001, val=803

According to this read though (which is in get_mactype), the write
didn't take effect.

If you place a delay of 1ms after phy_clear_bits_mmd() in
mv3310_power_up(), does it then work?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

