Return-Path: <netdev+bounces-254238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DehC6//eWm71QEAu9opvQ
	(envelope-from <netdev+bounces-254238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:23:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72355A128A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A0E5302263D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F02E8B98;
	Wed, 28 Jan 2026 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qzi+YIXH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6CF2F60CB
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602811; cv=none; b=YxlvLcZ55SBfMTPOMS6HbtjUufVvkY8/E98IH7dHkpSOjSIwKbNqUhiK8VZisq7zuJFbsj3Up39ZWDrRge2GToktKt6zr3TrnGOHe9Kvan7KQMVsEx+282/7J9G7xRplsUWND8yPBBOjYd12ABVIRmOHEanW6i24ZVJNkZSGoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602811; c=relaxed/simple;
	bh=FWxaYVTB0KpBOKsNtP1n3kIxFkvHH8CTcgSRc43DxLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTkuKiF3GsBR01gNf4gQ5rpld5pkh9Qrk2/uSEJ8qt7/O4mC6inDt2UzE+3TQ4v/BTcy6PeVMNUT/6ICXmvVgHrTVANx6/Zp/jc7Vn2AC92lpJ7zBNWXiRsoOfBDvNBHGxmLsnsXf72JvnlV45GIe+Fujgi3jqd1ZgNzcREOnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qzi+YIXH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ISotn7edf+IUTj82nvFY2R7E+1j0WbBkqwZTBvRb3ws=; b=Qzi+YIXHL/nhOP7tltKeGwXgJm
	TDhTlh2TPDZxXVdv5t87t7vOJ8E4/MaWXYHiS3vl0HG23k3aakBDz6HFBXxIvKGrR4WDE1jFgF5e5
	t09PWIRt76FZjpVYVe+bi6M32aA+UjIgGmzOO4wbHYUHTB1dcSgRkEdDjgGamVIVfGfxN973Z4BIZ
	00yUAVQ48RWmURUaDLH8Wjkcu+8ZStYGULzBdOn8+AlwytvuLrmPYgTs6ywykk+O2ZFVpXoUEvGyN
	1HWJpcMJxB8wD/nUk5PFF9scmXJwRH3P2Y7Cu3DkQZfsLvXIXci9UP6mTJwFfKwdInatD5diUFl4P
	knpPGadA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55194)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vl4We-000000007Lo-18uM;
	Wed, 28 Jan 2026 12:20:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vl4Wa-000000006xo-3rF9;
	Wed, 28 Jan 2026 12:19:56 +0000
Date: Wed, 28 Jan 2026 12:19:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: rk: fix missing
 reset_control_put()
Message-ID: <aXn-7LWRk5cZjno8@shell.armlinux.org.uk>
References: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
 <E1vl3Fv-00000006v3L-215v@rmk-PC.armlinux.org.uk>
 <c8a10b5355b750cfc83a7f746347175ab40b64d7.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a10b5355b750cfc83a7f746347175ab40b64d7.camel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254238-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,armlinux.org.uk:email,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 72355A128A
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:04:21PM +0100, Philipp Zabel wrote:
> On Mi, 2026-01-28 at 10:58 +0000, Russell King (Oracle) wrote:
> > rk_gmac_setup() delves into the PHY's DT node to retrieve its reset
> > control using of_reset_control_get(). However, it never releases it
> > when the driver is removed. Add reset_control_put() to rk_gmac_exit()
> > to clean this up.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 5f8d2031b97c..bc69cbb5a7d4 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > @@ -1784,6 +1784,8 @@ static void rk_gmac_exit(struct device *dev, void *bsp_priv_)
> >  
> >  	if (priv->plat->phy_node && bsp_priv->integrated_phy)
> >  		clk_put(bsp_priv->clk_phy);
> > +
> > +	reset_control_put(bsp_priv->phy_reset);
> >  }
> >  
> >  static int rk_gmac_probe(struct platform_device *pdev)
> 
> This is fine because the driver sets plat_dat->suspend, and so
> rk_gmac_exit() is never called via stmmac_pltfr_exit() during suspend.
> 
> It does look a bit sketchy to release resources in the rk_gmac_exit()
> counterpart to rk_gmac_init(), which never requested the resources,
> though. Maybe use devm_add_action_or_reset() to register the release of
> the reset during remove?

Thanks, but I think a sense of proportion is required here. This
patch is the result of introducing the ->init() method, and AI
noticing that there was no cleanup of this resource. This was the
simplest way to implement that cleanup.

However, your review commit also applies to bsp_priv->clk_phy which
has the same problem - this also isn't obtained in rk_gmac_init(),
but in rk_gmac_clk_init().

Given that, and the fact that this entire series is already
considerably big (it was 21 patches, then 22, now 23, and with this
it's going to become 24 patches) I'm going to say that this issue
can be addressed at a later time.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

