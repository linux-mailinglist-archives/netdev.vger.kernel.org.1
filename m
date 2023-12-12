Return-Path: <netdev+bounces-56560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D080F601
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D1E1F215D6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13398004D;
	Tue, 12 Dec 2023 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vMLMHfKu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3491;
	Tue, 12 Dec 2023 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WDyfD09PAON4LZuIakiggNErHuklPdxdPhsExRCINO0=; b=vMLMHfKuWjpOeCgqj+OLSIbKsG
	WCGncmPzax+s7ErnI8PlwoAcxDgi7JafMKVhEz++U+ZVQ0XP+ohiULCrVXD/1dsSQSk5yjcm0zHBK
	XJSYcF2axTnD1zNtKD5UhlW9zlwLRjW3JYr1H0mjXegUeu0pkeLE3MwLfePZ5fVAWlL23Am0I3PL5
	NT+gIKBnCPzCh8jjkzWC4o0487W4InM+Or5UWQfd6BDMvNIV9pIIIE1jc+pWQizWWt+hHLFeDOT09
	rdDi0N33mI6WDlJ+FmCYpG7ErF4HC1LSmRNgAAZM97w65nNqWkVz7kUwz5Y9zFE6ftvqJdadzd2vK
	vwdMQbbQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35082)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rD85g-0007Hq-0s;
	Tue, 12 Dec 2023 19:06:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rD85e-0000gA-UH; Tue, 12 Dec 2023 19:06:46 +0000
Date: Tue, 12 Dec 2023 19:06:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <ZXivRofyIpvmfOyR@shell.armlinux.org.uk>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <ZW8pxM3RvyHJTwqH@shell.armlinux.org.uk>
 <ZW85iBGAAf5RAsN1@shell.armlinux.org.uk>
 <kagwzutwnbpiyc7mmtq7ka3vhffw4fejuti5vepnla74rocruh@tryn6lxhwbjz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kagwzutwnbpiyc7mmtq7ka3vhffw4fejuti5vepnla74rocruh@tryn6lxhwbjz>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 12, 2023 at 06:26:16PM +0300, Serge Semin wrote:
> I would have used in the first place if it was externally visible, but
> it's defined as static. Do you suggest to make it global or ...

That would be one option - I didn't make it visible when I introduced it
beacuse there were no users for it.

> > At some point, we should implement
> > mdiobus_get_mdiodev() which also deals with the refcount.
> 
> ... create mdiobus_get_mdiodev() instead?
> 
> * Note in the commit message I mentioned that having a getter would be
> * better than directly touching the mii_bus instance guts.

What I'm thinking is:

/**
 * mdiobus_get_mdiodev() - get a mdiodev for the specified bus
 * @bus: mii_bus to get mdio device from
 * @addr: mdio address of mdio device
 *
 * Return the struct mdio_device attached to the MII bus @bus at MDIO
 * address @addr. On success, the refcount on the device will be
 * increased, which must be dropped using mdio_device_put(), and the
 * mdio device returned. Otherwise, returns NULL.
 */
struct mdio_device *mdiobus_get_mdiodev(struct mii_bus *bus, int addr)
{
	struct mdio_device *mdiodev;

	mdiodev = mdiobus_find_device(bus, addr);
	if (mdiodev)
		get_device(&mdiodev->dev);
	return mdiodev;
}
EXPORT_SYMBOL(mdiobus_get_mdiodev);

should do it, and will hold a reference on the mdiodev structure (which
won't be freed) and also on the mii_bus (since this device is a child
of the bus device, the parent can't be released until the child has
been, so struct mii_bus should at least stay around.)

What would help the "the bus driver has been unbound" situation is if
we took the mdio_lock on the bus, and then set the {read,write}{,_c45}
functions to dummy stubs when the bus is being unregistered which then
return e.g. -ENXIO. That will probably make unbinding/unloading all
MDIO bus drivers safe from kernel oops, although phylib will spit out
a non-useful backtrace if it tries an access. I don't think there's
much which can be done about that - I did propose a patch to change
that behaviour but apparently folk like having it!

It isn't perfect - it's racy, but then accessing mdio_map[] is
inherently racy due to no locking with mdiobus_.*register_device().
At least if we have everyone using a proper getter function rather
than directly fiddling with bus->mdio_map[]. We only have one driver
that accesses it directly at the moment (mscc_ptp):

                dev = phydev->mdio.bus->mdio_map[vsc8531->ts_base_addr];
                phydev = container_of(dev, struct phy_device, mdio);

                return phydev->priv;

and that should really be using mdiobus_get_phy().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

