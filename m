Return-Path: <netdev+bounces-255537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHdsIxCQfmniagIAu9opvQ
	(envelope-from <netdev+bounces-255537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:28:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4230C4551
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E62D300C5A5
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1A33DEFC;
	Sat, 31 Jan 2026 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SnP/VPBu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CD15B0EC
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769902092; cv=none; b=c6Zybbim4ZJJRsfy+1x3tYAuvPwvzlW+/kqLegr0lvpKdRjk17cc2V2kIwYYOlZir8nbALNKDx6QqafgvjkojJyzPzSewYxIAI/u66qUssHIRCv/pD+xHEUopUXoXJPvFGIaPQNtl9eICAhDGnByisqAxRPbFw994A/oVgF4e5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769902092; c=relaxed/simple;
	bh=SVnsVFIjjrl1ziY7Q9Q5pBmlCfdAoPDhVQM6QIxWBVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMOmFBduBzpPK3DBIA/65Hggv3pbq2ZxzRKgpiN5AWPa+raFvXvZdxp8d5gi8CRFg4T3AlpUk3TMKuPlwtccTDyxxoArw16Z/PTDvOxluKkk0MqrYHAaUR8fgPhvOfiG0Cv88MobMZ3E6d0kLYGdH/BOkcLxqXhXGjsQ9Ox6uUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SnP/VPBu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kIes9y28tS53Qgsq8mlA/hmeh5zQSe+vuQTcGCaQLH4=; b=SnP/VPBuH22KxGVfdB2UJKAixc
	XVM2hHoezwF+JSBRIjcXee6VRY+f2A2Dt8SxHuoKhtphXFXjaLuHEqKGOmAlW/LGPuas7yAWsp0Jv
	+q112L2P5WjDSye8Mkp2L6t+G6inKJkalVVwZ74B6RKQkUb5AvfLngK0Ml7yFtERFVPgNhxWIKQdy
	Bn6PBryzaRjkQ+NZDn0lTUQTo/xfRl5SUmchU/R2jQqCdkRGsuOCXhSNKhJu432u4NrePBebZNL2k
	qd8fHOJ6Bl025nTCABmPilcoTvfFB1h3eR/tOP1xHq14+tUNIiMBeNtu2p9w4c7cQpMxrL4yMMsel
	rfFTFUlQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55010)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vmKNe-000000002aH-2I5S;
	Sat, 31 Jan 2026 23:27:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vmKNY-000000001sG-1Jn3;
	Sat, 31 Jan 2026 23:27:48 +0000
Date: Sat, 31 Jan 2026 23:27:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: stmmac: rk: convert to mask-based
 interface mode configuration
Message-ID: <aX6P9D99Xi4PnI2J@shell.armlinux.org.uk>
References: <aXyPK9rlMt8h_fze@shell.armlinux.org.uk>
 <E1vlmEY-00000006znn-0N0Q@rmk-PC.armlinux.org.uk>
 <20260131140850.3c35f95a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131140850.3c35f95a@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255537-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4230C4551
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 02:08:50PM -0800, Jakub Kicinski wrote:
> On Fri, 30 Jan 2026 11:00:14 +0000 Russell King (Oracle) wrote:
> > +	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	intf = ret;
> > +
> >  	ret = gmac_clk_enable(bsp_priv, true);
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (bsp_priv->gmac_phy_intf_sel_mask ||
> > +	    bsp_priv->gmac_rmii_mode_mask) {
> > +		/* If defined, encode the phy_intf_sel value */
> > +		val = rk_encode_wm16(intf, bsp_priv->gmac_phy_intf_sel_mask);
> > +
> > +		/* If defined, encode the RMII mode mask setting. */
> > +		val |= rk_encode_wm16(intf == PHY_INTF_SEL_RMII,
> > +				      bsp_priv->gmac_rmii_mode_mask);
> > +
> > +		ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
> > +		if (ret < 0)
> 
> missing
> 	gmac_clk_enable(bsp_priv, false);
> here?

Opinions vary on whether errors from regmap_write() should be handled.
See the recent thread:

https://lore.kernel.org/r/aXh9lcfw6D6KouI_@stanley.mountain

Seems that if regmap_write() fails, it's "buy a new computer" realms.
If that's case, is it worth cleaning up resources, or even checking the
return code from regmap_write() ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

