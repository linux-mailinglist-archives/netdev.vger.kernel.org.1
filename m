Return-Path: <netdev+bounces-253641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFXTE54MeGl3ngEAu9opvQ
	(envelope-from <netdev+bounces-253641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:53:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B58E911
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F02E1300BD85
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E4A1A9F93;
	Tue, 27 Jan 2026 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AzjxNU6h"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF83B2BA
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475227; cv=none; b=oqpeJ1fiXIoYag5Tbzv0+UjVrZlg5DBE3ROpD6i0zPL64J9HKQ92eYJpPnfRGCguIwo4hJCsLy38pLaFxXsTjJ3+qxhYQbUZjl8aGpyGYfIALc8kASqCeJBVOQMkCvCKaFA2xMEkXTrmEwHr+tSX6Zdzx0GZTgXeJczpUXnEOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475227; c=relaxed/simple;
	bh=ybtPDKinHgdLfF6fRr9qQUNfd8P7VdIemhgy7AuC2fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZyk7syiMuhEIfITp4HM/29Qb+mEZUSSaJbBK2WTsCuulnnDOMmKsOG1SPpaRNe7w4lkpjfa7W0AzTxfEeL7kgCWmbViq/CBdpEom3XxYzA7jOpisnPIZHC/wlnYapk/tILVQX7A6l/bO1ILgUWM9Jh8n8GvGCATawDoSLUXgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AzjxNU6h; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gOelw5A+TDHV0v/cJbYEPVYXwn43626zGv3kYC/dxwE=; b=AzjxNU6h42QGqLhgZkUoGP5Rxq
	dyyBenXI5avgGV0jK3U+tRAL4OGup9CV04oCHWYYBVYQFlvAhg3nVFQNZgb7qiWMzgQdFqbcuyF+0
	owixY3bTixCW+Ql2jGQFP4RjWbfLXA+A+ttTm/fRbbGF4wLbEfGhmo1G5cwLTn0HEcXcUKmk3M1XJ
	YNF2P2pz31mQiWC7PcuCyL2jObC99lbG+ktJ9zqlnmbeH00LN05irT3JtbyA/mVB/lzV5wKuLwvj/
	+6nBxgacMDkB8b5LFcLrHFrQYqr1pAn9sP/2E4aVSwe674QpFgdUBq8jcLmHJhtctDp3U4uHhCE2M
	C+x9oelQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55834)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkXKv-000000005Tw-3ER2;
	Tue, 27 Jan 2026 00:53:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkXKt-000000005Qo-2p86;
	Tue, 27 Jan 2026 00:53:39 +0000
Date: Tue, 27 Jan 2026 00:53:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-stm32@st-md-mailman.stormreply.com, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	pabeni@redhat.com, linux-rockchip@lists.infradead.org,
	heiko@sntech.de, alexandre.torgue@foss.st.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [net-next,v2,07/22] net: stmmac: rk: convert to mask-based
 interface mode configuration
Message-ID: <aXgMkyo3UhuEnnjG@shell.armlinux.org.uk>
References: <E1vkL2D-00000005uso-3W6y@rmk-PC.armlinux.org.uk>
 <20260127004057.3785761-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127004057.3785761-1-kuba@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253641-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,shell.armlinux.org.uk:mid,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 979B58E911
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 04:40:57PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: stmmac: rk: convert to mask-based interface mode configuration
> 
> This commit consolidates PHY interface mode configuration into common
> infrastructure by introducing mask fields for phy_intf_sel and rmii_mode,
> moving the register writes from SoC-specific functions into the common
> rk_gmac_powerup() function.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 4117f6863ff0..35836ffdfc1d 100644
> 
> [ ... ]
> 
> > @@ -1654,7 +1685,9 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
> >  static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
> >  {
> >  	struct device *dev = bsp_priv->dev;
> > +	u32 val;
> >  	int ret;
> > +	u8 intf;
> >
> >  	ret = rk_gmac_check_ops(bsp_priv);
> >  	if (ret)
> > @@ -1664,6 +1697,26 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
> >  	if (ret)
> >  		return ret;
> >
> > +	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
> > +	if (ret < 0)
> > +		return ret;
> 
> Should this error path call gmac_clk_enable(bsp_priv, false) before
> returning? The clocks were enabled just above, and the existing error
> handling for rk_phy_powerup() later in this function disables the
> clocks on failure:
> 
>     ret = rk_phy_powerup(bsp_priv);
>     if (ret) {
>         gmac_clk_enable(bsp_priv, false);
>         return ret;
>     }

This piecemeal review by AI is like death by a thousand cuts. Can we
please either stop using it, or find some way to have _all_ the
problems discovered at once.

I fix one problem in this patch, and the bloody AI reports another.
And with the 10 sodding hour turn-around time, this is beyond a joke.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

