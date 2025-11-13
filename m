Return-Path: <netdev+bounces-238329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E46C57528
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9053A638F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B50B33DEC0;
	Thu, 13 Nov 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bCbUGeBC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775233892C
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035341; cv=none; b=PKzQMQhlmAKlA2WGlTNn80DCO4US2/CUdFOXgi8bPbqzzC+G1YafbHvjxw9j689uvSMjGmt6gXVUw6+8J0X9AV5ljiB1wncJnUXvRVYFgkvwix7vckKsLDl0x8lWxq9RnGSDlnWhwBbrYZCTgImWRU5m8x72rH2hHm807Dgg2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035341; c=relaxed/simple;
	bh=1TOjL58t8hJOIqAlBTbaX+TY2ysKOnw7ZyjZxvsciz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFCjIlu+0/iRg4tJV144mQi/NnF1goj03GgFZrAv3dtG1tHkuoCcbocjtul4qIEOCn8zMrwoszJXQuT+6m1iaqmIXTTJ6TLpUpeDt5JoRovWvu1zikFJyeThkqbMiKcnNbAmJFwyqzgLQmndRtwJCNCmznsiAPvvLk5Ic+cjhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bCbUGeBC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JkDpTFVjjlbMNbEZbH9LlFnd8jd193zd4r9dnypXFHw=; b=bCbUGeBCxZkI2xtXBSXiwD/t/4
	OWz2rl9R9MoscBqm92x9wMGsYMRaeLa0xqsPl8H6dswCjq6TbPFUOR9sLkDRavJOmqqKDs9QcBU0O
	zl3vAhoTlXMwuC4LiQ640FNzH9zDHJQikOa8IQOX8eG0aPYh3evnvjWdIWjMsaXJ3RUpTc5gnY8sQ
	NXY72Q4xU9ph76l+8FjuATBiWKv6Uaz75RHv4RjHEWWNswMcuj2acCYezxHfZfPnxlYF/vPDUjWza
	J+q40OQp9P+IUSIl1W7K95Ax3WHHAbrk6C9Tg6pzWCRHKzzus3ORiGmHCbH/w7HGu3/qtTzwZMZkJ
	YuMCbNqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41954)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJW1d-000000005PU-1sFc;
	Thu, 13 Nov 2025 12:02:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJW1Z-000000004px-3wi9;
	Thu, 13 Nov 2025 12:02:01 +0000
Date: Thu, 13 Nov 2025 12:02:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
Message-ID: <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 13, 2025 at 11:32:00AM +0000, Vadim Fedorenko wrote:
> PHY devices had lack of hwtstamp_get callback even though most of them
> are tracking configuration info. Introduce new call back to
> mii_timestamper.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

As part of my Marvell PTP work, I have a similar patch, but it's
way simpler. Is this not sufficient?

__phy_hwtstamp_get() is called via phylib_stubs struct and
phy_hwtstamp_get(), dev_get_hwtstamp_phylib(), dev_get_hwtstamp(),
and dev_ifsioc().

Using the phylib ioctl handler means we're implementing a path that
is already marked as legacy - see dev_get_hwtstamp():

        if (!ops->ndo_hwtstamp_get)
                return dev_eth_ioctl(dev, ifr, SIOCGHWTSTAMP); /* legacy */

So, I think the below would be the preferred implementation.

8<===
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: phy: add hwtstamp_get() method for mii
 timestampers

Add the missing hwtstamp_get() method for mii timestampers so PHYs can
report their configuration back to userspace.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c           | 3 +++
 include/linux/mii_timestamper.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 02da4a203ddd..b6fae9299b36 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -476,6 +476,9 @@ int __phy_hwtstamp_get(struct phy_device *phydev,
 	if (!phydev)
 		return -ENODEV;
 
+	if (phydev->mii_ts && phydev->mii_ts->hwtstamp_get)
+		return phydev->mii_ts->hwtstamp_get(phydev->mii_ts, config);
+
 	return -EOPNOTSUPP;
 }
 
diff --git a/include/linux/mii_timestamper.h b/include/linux/mii_timestamper.h
index 995db62570f9..b6485f602eb9 100644
--- a/include/linux/mii_timestamper.h
+++ b/include/linux/mii_timestamper.h
@@ -29,6 +29,8 @@ struct phy_device;
  *
  * @hwtstamp:	Handles SIOCSHWTSTAMP ioctl for hardware time stamping.
  *
+ * @hwtstamp_get: Handles SIOCGHWTSTAMP ioctl for hardware time stamping.
+ *
  * @link_state: Allows the device to respond to changes in the link
  *		state.  The caller invokes this function while holding
  *		the phy_device mutex.
@@ -55,6 +57,9 @@ struct mii_timestamper {
 			 struct kernel_hwtstamp_config *kernel_config,
 			 struct netlink_ext_ack *extack);
 
+	int  (*hwtstamp_get)(struct mii_timestamper *mii_ts,
+			     struct kernel_hwtstamp_config *kernel_config);
+
 	void (*link_state)(struct mii_timestamper *mii_ts,
 			   struct phy_device *phydev);
 
-- 
2.47.3

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

