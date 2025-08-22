Return-Path: <netdev+bounces-215991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE25B3144E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A081D23169
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B222F28EF;
	Fri, 22 Aug 2025 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AfOr5IcM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DFA2356B9;
	Fri, 22 Aug 2025 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855784; cv=none; b=BkGyartRJYr9wGQKhgC/Zu+Qd8TxZ8r6Vch2TF0cn6qJBMThzzJ4vTXn5pLJvwWmpH7ZUn0Z05pX734dD6YHOg4W23gjkonVI46ggdrFULOR/Rq9+G757+w2cxSCvxccm45BFhBZk2qxWW10s5CfFQRGr5XWBo5wPFgO7eKmjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855784; c=relaxed/simple;
	bh=6lka0/62rfqpl6YPbKf8gI40GE/XAI9LCAAMWUiUkQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUCMgm0wwhU8+vJAcU9g3BlpTU0f/0NRSQ/xbc4089WMgCQ+pTcUA60LmOgS5Xfu7IJs7JUPJKowraDbE4bybXFc3WJjSQhgi1AehK/CrAclqGwWJ3RN8EG4jbKoQJnmjl4PIKc+o4ifWHUwlzk2gh7ecMPhu+FzW3L59rmnQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AfOr5IcM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IjUHb499RjZ87+IojyVt03OIRq/VU75xCa/jogdbmr4=; b=AfOr5IcMFlxzDrDJ51yRa8rSqL
	6pdNeSgO9ess+gjUV5vQXuAfJcohDN8kCRClgEROg5DhfGM2JyHYZLRW76p3hzC6SInrJlUgnBdxO
	BJVRlGcI0yA02lpwSmi53Bkjz8Ei3BuDXMJcVFkc7On0yj+fh25YhJ3Ywq6WJdnX3+e9XHs/0KUj+
	pvQ9rLdvI3KE9+vK097gt2ivhgdamA/S8LxIKHnxa6NMF5hLLTwV7gl0XJrgL7qKaBeucbops+gzg
	T4PiskbsMlag1fCFFV0tgN/69suvFXIcyIrB3FfbYPJAfKGHvp5pvQSllzOjPVrrkIMzygosIR9AA
	Ist3leGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48842)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1upOIR-000000002JK-15Ug;
	Fri, 22 Aug 2025 10:42:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1upOIP-000000001ze-2mlq;
	Fri, 22 Aug 2025 10:42:53 +0100
Date: Fri, 22 Aug 2025 10:42:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: phy: Clear link-specific data on
 link down
Message-ID: <aKg7nf8YczCT6N0O@shell.armlinux.org.uk>
References: <20250822090947.2870441-1-o.rempel@pengutronix.de>
 <aKg2HHIBAR8t2CQW@shell.armlinux.org.uk>
 <aKg4XcM0vAIS4C-8@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKg4XcM0vAIS4C-8@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 22, 2025 at 11:29:01AM +0200, Oleksij Rempel wrote:
> On Fri, Aug 22, 2025 at 10:19:24AM +0100, Russell King (Oracle) wrote:
> > On Fri, Aug 22, 2025 at 11:09:47AM +0200, Oleksij Rempel wrote:
> > > When a network interface is brought down, the associated PHY is stopped.
> > > However, several link-specific parameters within the phy_device struct
> > > are not cleared. This leads to userspace tools like ethtool reporting
> > > stale information from the last active connection, which is misleading
> > > as the link is no longer active.
> > 
> > This is not a good idea. Consider the case where the PHY has been
> > configured with autoneg disabled, and phydev->speed etc specifies
> > the desired speed.
> > 
> > When the link goes down, all that state gets cleared, and we lose
> > the user's settings.
> > 
> > So no, I don't think this is appropriate.
> > 
> > I think it is appropriate to clear some of the state, but anything that
> > the user can configure (such as ->speed and ->duplex) must not be
> > cleared.
> 
> Hm... should it be cleared conditionally? If autoneg is used, clear the
> speed and duplex?

Actually no, you can't do any of this here.

Look at phy_ethtool_set_eee_noneg(). If the LPI configuration changes,
it needs to inform the MAC of the change, and it does that by
_simulating_ a brief loss of link by calling phy_link_down() followed
by phy_link_up() - expecting all state to be preserved except that
which needs to be modified.

Maybe we should do something in the PHY_HALTED state in
_phy_state_machine() ?

Note that in the usual case of link down, it is the responsibility of
phy_read_status() to update most of what you're clearing, the
exception is phydev->eee_active and phydev->enable_tx_lpi which are
managed by phylib itself.

I think that both the PHY_HALTED and PHY_ERROR states should be
clearing phydev->eee_active and phydev->enable_tx_lpi, so that
should be in the existing if().

I'm not sure we want to clear out the remainder of the state on
PHY_ERROR, as this would aid debugging when something goes wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

