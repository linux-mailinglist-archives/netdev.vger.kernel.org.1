Return-Path: <netdev+bounces-157743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24688A0B82B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D01F165BF3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4822E3EB;
	Mon, 13 Jan 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HFH9nN3q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515CE22CF1F;
	Mon, 13 Jan 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774992; cv=none; b=QC7OG+l6GRLtWOZ8MtNLognqx2h1XISH1caoF/GRiljBJMD1D915GW2cJ+7H4fJNok6q5Gtv6wjGWRbExmnWV9nwVJ0L7MFUoD848sRCt+uo15nD8y5jf/HFyuyLyycsPGH/bB1cEKbNBp+edqPcrW68jWMqPV+3wOoFRts7vAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774992; c=relaxed/simple;
	bh=HOQM72KCwGsN10dMOn1YjcbMhjJcraFOF4/d7eBSc38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlCPxhRGNt6wiQrJix9zzXM0/9XKargcclcDasvikijVnXXASrAYDHWOiDOYuSsvQKbdkGXKBVmQkTQPgrnf5acePgoj5wiYLiKmlQs09orla0HAIvEmxjgc/cJe6uiUnBhMQkh3lbKfGxi4lXmDBn+tKixHkxZORd0pc8Lnzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HFH9nN3q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HZfEuvkT5fgmBeukjbKg/NiYaE1Lo5diluqA8WkDeKM=; b=HFH9nN3qvTc0jUJRXkquMMCoZ2
	MYIo9A65Nb2DJej9ifobmilrj4I6Lp4S+gn2JMEuZ+tGCg+0td9r8F3WUYDJJjHMitGd4O3Rcmv2p
	dW1fd4izUkdp2HVZO+pqrgwxEycFcVhpAd51+5tulJzcwNIg+OrY3hegQxfvs5NkclQ5eROsc397M
	uvkW27ReFXyLb9U0c/yKuju0Pl6NQelrejo5sf6TZCz5zEK+gXpE6LD+p0wYiWjxFjZRHx9WDQDcT
	abTTGtasE4dkkYveD9dYdqUP9plR+jC4cJBBEbTSlFfnjmtJhbYC8kTsuDwe2WbeUtZj44M8GKduT
	s6Pt8jAA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40646)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXKVg-0006ff-0o;
	Mon, 13 Jan 2025 13:29:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXKVd-00047C-1H;
	Mon, 13 Jan 2025 13:29:37 +0000
Date: Mon, 13 Jan 2025 13:29:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4UVQRHqk8ND984c@shell.armlinux.org.uk>
References: <20250108121341.2689130-8-o.rempel@pengutronix.de>
 <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
 <Z36KacKBd2WaOxfW@pengutronix.de>
 <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
 <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
 <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
 <Z4UKHp0RopBT5gpI@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4UKHp0RopBT5gpI@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 13, 2025 at 01:42:06PM +0100, Oleksij Rempel wrote:
> On Thu, Jan 09, 2025 at 08:33:07PM +0100, Andrew Lunn wrote:
> > > Andrew had a large patch set, which added the phylib core code, and
> > > fixed up many drivers. This was taken by someone else, and only
> > > Andrew's core phylib code was merged along with the code for their
> > > driver, thus breaking a heck of a lot of other drivers.
> > 
> > As Russell says, i did convert all existing drivers over the new
> > internal API, and removed some ugly parts of the old EEE core code.
> > I'm not too happy we only got part way with my patches. Having this in
> > between state makes the internal APIs much harder to deal with, and as
> > Russell says, we broke a few MAC drivers because the rest did not get
> > merged.
> > 
> > Before we think about extensions to the kAPI, we first need to finish
> > the refactor. Get all MAC drivers over to the newer internal API and
> > remove phy_init_eee() which really does need to die. My patches have
> > probably bit rotted a bit, but i doubt they are unusable. So i would
> > like to see them merged. I would however leave phylink drivers to
> > Russell. He went a slight different way than i did, and he should get
> > to decide how phylink should support this.
> 
> Hi Andrew,
> 
> Ok. If I see it correctly, all patches from the
> v6.4-rc6-net-next-ethtool-eee-v7 branch, which I was working on, have been
> merged by now. The missing parts are patches from the
> v6.3-rc3-net-next-ethtool-eee-v5 branch.
> 
> More precisely, the following non-phylink drivers still need to be addressed:
> drivers/net/ethernet/broadcom/asp2
> drivers/net/ethernet/broadcom/genet
> drivers/net/ethernet/samsung/sxgbe
> drivers/net/usb/lan78xx - this one is in progress
> 
> Unfortunately, I won’t be able to accomplish this before the merge window, as I
> am currently on sick leave. However, I promise to take care of it as soon as
> possible.

Does any of this include mvneta?

static int mvneta_ethtool_get_eee(struct net_device *dev,
                                  struct ethtool_keee *eee)
{
        struct mvneta_port *pp = netdev_priv(dev);
        u32 lpi_ctl0;

        lpi_ctl0 = mvreg_read(pp, MVNETA_LPI_CTRL_0);

        eee->eee_enabled = pp->eee_enabled;
        eee->eee_active = pp->eee_active;
        eee->tx_lpi_enabled = pp->tx_lpi_enabled;
        eee->tx_lpi_timer = (lpi_ctl0) >> 8; // * scale;

        return phylink_ethtool_get_eee(pp->phylink, eee);
}

Any driver that writes any members of struct ethtool_keee before
calling phylink_ethtool_get_eee() or phy_ethtool_get_eee() was
broken by the merging of phylib-managed EEE. I've been submitting
patches to fix these over time, such as my recently merged DSA
patches that remove the now useless get_mac_eee() method.

The biggest problem is that phylib overwrites eee->tx_lpi_timer,
which broke a lot of drivers. For example, I've fixed FEC:

3fa2540d93d8 net: fec: use phydev->eee_cfg.tx_lpi_timer

Anyway, I'm going to re-post a cut-down version of my phylink-
managed EEE support once Herner's EEE patch set has been merged.
This will convert mvneta, lan743x and stmmac, and add support for
mvpp2, thus resolving the breakage in at last some of those drivers..

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

