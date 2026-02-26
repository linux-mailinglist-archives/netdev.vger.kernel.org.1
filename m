Return-Path: <netdev+bounces-261586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPv/Jf2woGnUlgQAu9opvQ
	(envelope-from <netdev+bounces-261586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:45:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA61AF469
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9857830C365F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91383115BC;
	Thu, 26 Feb 2026 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="y/AxUqks"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83B30DD25;
	Thu, 26 Feb 2026 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138711; cv=none; b=jxIw1VfnDcfCbwMrwrkTDIojEhiuPHsHduqbo5OOwd5By9Drmrxe49nbHPgN+tbT5earnfvh0QSXwqlvg7b8pYPjyxQquzCz0MItXUvJ6iqmT6mzu1JO2anYoL4BxjOGhpHwHYIzoQhm9fuGoQWKYhxldWxzznZC0+Z0CJweqW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138711; c=relaxed/simple;
	bh=mIqMdrRwANI9MqmAL5m1Ir5mAyYzwv3j8dxD7o48Dtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5uKWtnz8tYVjGfezzrjYPOAZfC7XRlh5qrY0mN2ZHbhAZZ5iDBg5PIXW5fgd23jhiXie2QbJ3sliXnOsxM3nNUV1rvnzqLxpQwlN0baVrmuZ0rszKvaFLQpkqxkQQxm71TuzxueMXGZdQx45b4KJoexOosU4xd21+EdmNLyiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=y/AxUqks; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ogPD/lXZWLTreSJKiI+SxSAF1QGabbqMCr+KWW3Nhyw=; b=y/AxUqksZk23ZyoQ20SEZ7Sszj
	bR7P9FfMvHMtPGWOjt2L33faE3nNRhxIAAlZ/oD6Kz/yS5REoXNSZyWiKUr3iJxjeiMgYnuQ/Poyc
	npBcqj/t37SvY3nHdwIwtO3wiyrBIMClh24wThYj0/SCKqzeKCWVWK1ll4m6dDD+cJfEXaTLW8SI8
	EwUF0jXHqviiwv8AZy6QHR5Qmnsje/nh9Qhzk0BPtNji+C99vEDYg+xr9TW7YcWb3by/8AfKDgb5u
	Gch3ri3t+rB2L+yS9kQYrMw3l/7fvfj5aQPRuRdcqY12NvLVBXkbQGkTRcBlkHRrxCiWJimOrKP8D
	XSMb1ekQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41126)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vviEC-000000008PR-37sB;
	Thu, 26 Feb 2026 20:44:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vviE9-000000002MW-3D5P;
	Thu, 26 Feb 2026 20:44:53 +0000
Date: Thu, 26 Feb 2026 20:44:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Conor Dooley <conor@kernel.org>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v3 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Message-ID: <aaCwxeMHMSCHk0nx@shell.armlinux.org.uk>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
 <20260226-folic-excitable-82eff83a125a@spud>
 <aaCd_zV5kY-s1RBL@shell.armlinux.org.uk>
 <20260226-perennial-sanctity-25c6adae5ec0@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226-perennial-sanctity-25c6adae5ec0@spud>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261586-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.8:email];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.914];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.3:email,0.0.0.7:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 00DA61AF469
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 08:20:41PM +0000, Conor Dooley wrote:
> On Thu, Feb 26, 2026 at 07:24:47PM +0000, Russell King (Oracle) wrote:
> > On Thu, Feb 26, 2026 at 10:46:24AM +0000, Conor Dooley wrote:
> > > On Thu, Oct 23, 2025 at 06:22:55PM +0200, Théo Lebrun wrote:
> > > > Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
> > > > compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
> > > > that must grab a generic PHY and initialise it.
> > > > 
> > > > We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
> > > > phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
> > > > the first users of bp->phy that use it in non-SGMII cases.
> > > > 
> > > > The phy_set_mode_ext() call is made unconditionally. It cannot cause
> > > > issues on platforms where !bp->phy or !bp->phy->ops->set_mode as, in
> > > > those cases, the call is a no-op (returning zero). From reading
> > > > upstream DTS, we can figure out that no platform has a bp->phy and a
> > > > PHY driver that has a .set_mode() implementation:
> > > >  - cdns,zynqmp-gem: no DTS upstream.
> > > >  - microchip,mpfs-macb: microchip/mpfs.dtsi, &mac0..1, no PHY attached.
> > > >  - xlnx,versal-gem: xilinx/versal-net.dtsi, &gem0..1, no PHY attached.
> > > >  - xlnx,zynqmp-gem: xilinx/zynqmp.dtsi, &gem0..3, PHY attached to
> > > >    drivers/phy/xilinx/phy-zynqmp.c which has no .set_mode().
> > > 
> > > Ran into this patch while looking at other stuff. Theo could you explain
> > > this analysis to someone not really au fait with phys? Looking at
> > > soc.dtsi files won't show you phys, since that's a board level decision,
> > > but you have found one for the zynqmp-gem so I guess that's just the way
> > > you presented the data?
> > > mpfs definitely has phys attached, so is you not finding one for it but
> > > finding for zynqmp, an indication that you were only looking for rgmii
> > > phys? Also, is the analysis of the connected phy driver accurate for
> > > zynmqmp?
> > > zynqmp-zc1751-xm018-dc4.dts seems to have 4 ethernet phys:
> > > 		ethernet_phy0: ethernet-phy@0 { /* Marvell 88e1512 */
> > > 			reg = <0>;
> > > 		};
> > > 		ethernet_phy7: ethernet-phy@7 { /* Vitesse VSC8211 */
> > > 			reg = <7>;
> > > 		};
> > > 		ethernet_phy3: ethernet-phy@3 { /* Realtek RTL8211DN */
> > > 			reg = <3>;
> > > 		};
> > > 		ethernet_phy8: ethernet-phy@8 { /* Vitesse VSC8211 */
> > > 			reg = <8>;
> > > 		};
> > 
> > Ethernet PHYs (drivers/net/phy/) are different from generic PHYs
> > (drivers/phy/). Ethernet PHYs are completely different beast with a
> > completely separate subsystem, which doesn't have a "set_mode" method.
> > 
> > Théo is referring to generic PHYs not Ethernet PHYs.
> 
> Right, that's pretty much what I figured and cos of that the patch
> itself seemed like it was fine to me. It is the analysis of users in
> devicetrees that I don't understand - the "no PHY attached" bits
> seemed to me like they should be saying "ethernet-only PHY attached, so
> no .set_mode()". Ultimately, I think it makes no difference to the patch
> itself, I just wanted to understand the commit message.

I think you're still thinking that ethernet PHYs and generic PHYs are
the same, but only differ in e.g. whether .set_mode() is populated.
This is completely wrong.

Ethernet PHYs are _completely_ separate from Generic PHYs. Forget the
"PHY" bit, that's totally irrelevant that they happen to be called
the same. The two classes share _no_ common infrastructure in the
kernel.

Ethernet PHYs can't have phy_set_mode_ext() called on them, because
ethernet PHYs have no "struct phy" associated with them. They also
can't have phy_power_on() either for the same reason, nor any of the
other generic PHY API calls.

Ethernet PHYs aren't a sub-class of generic PHYs. As I said,
Ethernet PHYs and generic PHYs are two entirely separate and different
subsystems with no commonality.

So... the commit message states "generic PHY". It states the generic
PHY API calls of phy_set_mode_ext() and phy_power_up(). From that we
deduce that bp->phy is a generic PHY. Thus, the commit message is
talking about generic PHYs not ethernet PHYs.

Ethernet PHYs are described in Ethernet controller DT using the
"phy-handle" property (and previously "phy" or "phy-device"

Generic PHYs are described using the "phys" property.

The presence of an ethernet-phy node in DT does not automatically
associate that device with anything - it has to be referenced by
a "phy-handle" property to connect it to an Ethernet controller.

However, as I've been trying to point out, as this commit is about
generic PHYs, Ethernet PHYs are just not relevant to this commit.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

