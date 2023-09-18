Return-Path: <netdev+bounces-34624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D27A4E31
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11612829CD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09D721A14;
	Mon, 18 Sep 2023 16:07:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CEE1D686
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:07:25 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA43C27
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6I9X+hMZkpIvyrmqsaCZJRKh7zGVOklLLinjoyFNsW0=; b=QoNXlYNcZfvmq83i4UgbeQxRj5
	hQtIoGTNBKTfgFgq7ztlfTzt5Fd32nkCGPB5gTjfkN+r+fKQbtCAZn03vEqKh6SdKvGJ//n9CAji5
	tidofZrWbibiWSWspWhrrTu8/U5w6MTAb52njc793CiLpRoiMlRTa2eYjR8JGVht1Z+N12xkd8boO
	ef1VmiHSsI7M3qAXhUjVQH3OiODIm28pc2hTeAn6ZHQTq9H9e5fVdoCFtMKlGYZVUVNoxQAfDHgxw
	B8QMwcuomSPVT9PvXERzBXiPQK61GUivCnlqlYvSq0CmRmBDGb1Zm1ll5fFxHi/bGjBmeLn6HF1fg
	ZBnX0ncg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60728)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qiEkz-0000Or-1v;
	Mon, 18 Sep 2023 14:57:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qiEkz-0000X2-4G; Mon, 18 Sep 2023 14:57:45 +0100
Date: Mon, 18 Sep 2023 14:57:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: fix regression with AX88772A PHY
 driver
Message-ID: <ZQhXWfKyfpNQlGew@shell.armlinux.org.uk>
References: <E1qiEFs-007g7b-Lq@rmk-PC.armlinux.org.uk>
 <eeb31d51-2b07-4b23-a844-c4112c34ef83@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb31d51-2b07-4b23-a844-c4112c34ef83@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 03:49:32PM +0200, Andrew Lunn wrote:
> On Mon, Sep 18, 2023 at 02:25:36PM +0100, Russell King (Oracle) wrote:
> > Marek reports that a deadlock occurs with the AX88772A PHY used on the
> > ASIX USB network driver:
> > 
> > asix 1-1.4:1.0 (unnamed net_device) (uninitialized): PHY [usb-001:003:10] driver [Asix Electronics AX88772A] (irq=POLL)
> > Asix Electronics AX88772A usb-001:003:10: attached PHY driver(mii_bus:phy_addr=usb-001:003:10, irq=POLL)
> > asix 1-1.4:1.0 eth0: register 'asix' at usb-12110000.usb-1.4, ASIX AX88772 USB 2.0 Ethernet, a2:99:b6:cd:11:eb
> > asix 1-1.4:1.0 eth0: configuring for phy/internal link mode
> > 
> > ============================================
> > WARNING: possible recursive locking detected
> > 6.6.0-rc1-00239-g8da77df649c4-dirty #13949 Not tainted
> > --------------------------------------------
> > kworker/3:3/71 is trying to acquire lock:
> > c6c704cc (&dev->lock){+.+.}-{3:3}, at: phy_start_aneg+0x1c/0x38
> > 
> > but task is already holding lock:
> > c6c704cc (&dev->lock){+.+.}-{3:3}, at: phy_state_machine+0x100/0x2b8
> > 
> > This is because we now consistently call phy_process_state_change()
> > while holding phydev->lock, but the AX88772A PHY driver then goes on
> > to call phy_start_aneg() which tries to grab the same lock - causing
> > deadlock.
> > 
> > Fix this by exporting the unlocked version, and use this in the PHY
> > driver instead.
> > 
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Fixes: ef113a60d0a9 ("net: phy: call phy_error_precise() while holding the lock")
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Hi Russell
> 
> Yes, this fixes the problem for stable.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> But maybe it would be better to move the hardware workaround into the
> PHY driver? Its the PHY which is broken, so why is the MAC working
> around it?

Err? Sorry, but your comment makes little sense given that my patch
only touches the PHY core (to export _phy_start_aneg()) and the PHY
driver (ax88796b.c) which is where the work-around is already located.

I'm not having to touch the MAC driver at all to fix this, because
afaics the MAC driver isn't involved in _this_ particular workaround.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

