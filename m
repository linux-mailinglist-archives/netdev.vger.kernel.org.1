Return-Path: <netdev+bounces-261550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oANNMsafoGlVlAQAu9opvQ
	(envelope-from <netdev+bounces-261550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:32:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED891AE5F5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75A1A30372F6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D70D364945;
	Thu, 26 Feb 2026 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fhOvzYBU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B16441045;
	Thu, 26 Feb 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133901; cv=none; b=EOLhVkDCqzGyWByuBZIstXu0oht+0l7pi+PuoVhZYxD+uHRQYMtIE0PzGhItUfQxTEJtGjdUVAlKBqiXJA4RWvIrx2uWINSEyF9bMUKvTD0XtBBhOj3577QmulVrdBSClUetGGZh3rTQAGMHSoPkAS6LZPEos+XR0t9Ysp6PvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133901; c=relaxed/simple;
	bh=At6EOPq1k0loTOHnkSiH4ces/B2b8vQCiL2Y+oLau8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiUxRRe0+lfSS+oKbZhSROL6Eqb7bFrnJB4LUZoD/waJsQqC0HEUZG2+TFMhTKwawx7NDSi+EEMxL9JTJwpz9ibNlRoQRVKW1vvNcm04PGAOxMDVq434Cmj79QvQQ1tPAGx9Yp7/aWLrj0NJxHY/ASGpBQ+n6DAaC58vvmBqWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fhOvzYBU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RnhAKvHWNvmyO5wpr0bj8ELDG7XVxHtN3iOWEruVtsk=; b=fhOvzYBU6quBigzV3qkmKbRWjI
	oLkuAz55lA11Xq6nUd8g4l0/HP49Q7ZMfCO8TPqTPmf5URl9Y3ykjhXdcZuIjkp5xEsZB431CJGS1
	HHbYgRqpB/2omWulmLYy1nkj9On/LQjlU1hqzLBCObIqSY4fFYL/ImVVUoMS/GmVhrzMZoiUidrSZ
	9hAk1lRUN+PgxGyK4XQdKzkUqhUWusZMw0sbntq9uZR/s1PSMTklC7+ZjzP9sSDP/9kzsFbuEoIqg
	/HWHTHiyUvp6uYrWxUZqqIyi9OBww3x3fR4YUjMQXfkbSCV47/byivg0IJx/1WMPVOR40fLODqeIb
	3tsZSDmg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53236)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvgyf-000000008NJ-1x4W;
	Thu, 26 Feb 2026 19:24:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvgyd-000000002Gr-3hoY;
	Thu, 26 Feb 2026 19:24:47 +0000
Date: Thu, 26 Feb 2026 19:24:47 +0000
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
Message-ID: <aaCd_zV5kY-s1RBL@shell.armlinux.org.uk>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
 <20260226-folic-excitable-82eff83a125a@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226-folic-excitable-82eff83a125a@spud>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261550-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.928];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.3:email,0.0.0.0:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.7:email,armlinux.org.uk:url,shell.armlinux.org.uk:mid,0.0.0.8:email]
X-Rspamd-Queue-Id: DED891AE5F5
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:46:24AM +0000, Conor Dooley wrote:
> On Thu, Oct 23, 2025 at 06:22:55PM +0200, Théo Lebrun wrote:
> > Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
> > compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
> > that must grab a generic PHY and initialise it.
> > 
> > We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
> > phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
> > the first users of bp->phy that use it in non-SGMII cases.
> > 
> > The phy_set_mode_ext() call is made unconditionally. It cannot cause
> > issues on platforms where !bp->phy or !bp->phy->ops->set_mode as, in
> > those cases, the call is a no-op (returning zero). From reading
> > upstream DTS, we can figure out that no platform has a bp->phy and a
> > PHY driver that has a .set_mode() implementation:
> >  - cdns,zynqmp-gem: no DTS upstream.
> >  - microchip,mpfs-macb: microchip/mpfs.dtsi, &mac0..1, no PHY attached.
> >  - xlnx,versal-gem: xilinx/versal-net.dtsi, &gem0..1, no PHY attached.
> >  - xlnx,zynqmp-gem: xilinx/zynqmp.dtsi, &gem0..3, PHY attached to
> >    drivers/phy/xilinx/phy-zynqmp.c which has no .set_mode().
> 
> Ran into this patch while looking at other stuff. Theo could you explain
> this analysis to someone not really au fait with phys? Looking at
> soc.dtsi files won't show you phys, since that's a board level decision,
> but you have found one for the zynqmp-gem so I guess that's just the way
> you presented the data?
> mpfs definitely has phys attached, so is you not finding one for it but
> finding for zynqmp, an indication that you were only looking for rgmii
> phys? Also, is the analysis of the connected phy driver accurate for
> zynmqmp?
> zynqmp-zc1751-xm018-dc4.dts seems to have 4 ethernet phys:
> 		ethernet_phy0: ethernet-phy@0 { /* Marvell 88e1512 */
> 			reg = <0>;
> 		};
> 		ethernet_phy7: ethernet-phy@7 { /* Vitesse VSC8211 */
> 			reg = <7>;
> 		};
> 		ethernet_phy3: ethernet-phy@3 { /* Realtek RTL8211DN */
> 			reg = <3>;
> 		};
> 		ethernet_phy8: ethernet-phy@8 { /* Vitesse VSC8211 */
> 			reg = <8>;
> 		};

Ethernet PHYs (drivers/net/phy/) are different from generic PHYs
(drivers/phy/). Ethernet PHYs are completely different beast with a
completely separate subsystem, which doesn't have a "set_mode" method.

Théo is referring to generic PHYs not Ethernet PHYs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

