Return-Path: <netdev+bounces-253640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CUtCkQMeGl3ngEAu9opvQ
	(envelope-from <netdev+bounces-253640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:52:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBF98E8E4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 698C63037F0E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83321772A;
	Tue, 27 Jan 2026 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YQuMdsQm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3181F4181
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475118; cv=none; b=m9zuHENKs4WzZ/zoncIMXh2tQH3pDV09t1c6D0DcHwTF1Ef0qkqf2abgmrsJStmXM+lruLacZKssetPbIFMV62Cff1tjkBsz9vwJNTxqoflyJq28BeWG8uuCCK0Z4+7fWGdhq57fZPPHPXx5/s0ju/pNIKnG9+nlfpjGgbouqDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475118; c=relaxed/simple;
	bh=ijRpgg1X1dZPNDrqNIK+6BgEKZD6cA8CPWtLWtOvgXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0X/1nIpzaV69M9ca7HycOH+d1PBfvrONnOAazViqgKPRRxhzKXLaoE0ZCzs12f1J2Y+SCNiFanQo99MkpUcHMvnQ9C2qFmhSbLzla/gGMdcmmgLd9Jn5tBG8L9yopxJFyCq17kJAkRZnINXqtsiqN2qOsGx+TvwmzjOvAQbBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YQuMdsQm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lAKtYQX1yhUOTYTT+KrvEzmr1r3DGvrlLn2eFe2kClM=; b=YQuMdsQmWhFWCsvXOk019tdRV1
	Vv3+Aklj81pMlkJ+7628vFXjhbFdBJpUuLIcaW91Bkw6t8a7dDVVzn6RBhNJEDMe6aKMUbbCfXWZ1
	rWK1rD5noI/ihtOy4qBWtEMqSfhr2ZwEm5bIvvnoO6lBbj8TAize2zQHcTzvnnUz8N1u4UjymjaXw
	ALks6JR/wK5X6OX4NkTvGLmHhAgqMz1wsoVb2TlJfhXbDQ10VDJMilMQKmF0BZhCWk8vPZCk3A88E
	SJvfcxeIkjT7Bk+OpFxdRqiKkokRx5t6JfV289YmsKmO/ZwXQA6jJ/mgJGdXuFZvFIHebpU0H2OPs
	cZExwdOw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45058)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkXJ7-000000005TL-3vGm;
	Tue, 27 Jan 2026 00:51:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkXJ3-000000005QX-3JgR;
	Tue, 27 Jan 2026 00:51:45 +0000
Date: Tue, 27 Jan 2026 00:51:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-stm32@st-md-mailman.stormreply.com, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	pabeni@redhat.com, linux-rockchip@lists.infradead.org,
	heiko@sntech.de, alexandre.torgue@foss.st.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [net-next,v2,06/22] net: stmmac: rk: add SoC specific ->init()
 method
Message-ID: <aXgMIYPiL9JK-c_K@shell.armlinux.org.uk>
References: <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
 <20260127004020.3785641-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127004020.3785641-1-kuba@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253640-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: ABBF98E8E4
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 04:40:20PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: stmmac: rk: add SoC specific ->init() method
> 
> This commit adds infrastructure for SoC-specific initialization by adding
> an init callback to rk_gmac_ops and calling it from rk_gmac_setup().
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 7f8ffd1549bc..4117f6863ff0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> 
> [ ... ]
> 
> > @@ -1618,6 +1619,14 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
> >
> >  	bsp_priv->dev = dev;
> >
> > +	if (ops->init) {
> > +		ret = ops->init(bsp_priv);
> > +		if (ret) {
> > +			dev_err_probe(dev, ret, "failed to init BSP\n");
> > +			return ERR_PTR(ret);
>                         ^^^^^^^^^^^^^^^
> 
> If ops->init() fails here, does bsp_priv->phy_reset need to be released?
> 
> Earlier in rk_gmac_setup(), at line 1610, the code calls:
> 
>     bsp_priv->phy_reset = of_reset_control_get(plat->phy_node, NULL);
> 
> of_reset_control_get() is not a devm-managed function, so the reset control
> would need to be explicitly released with reset_control_put() on error paths.
> 
> This new error return happens after phy_reset could have been acquired (when
> the device has an integrated PHY), but before the function successfully
> returns. If this path is taken, it appears the reset control would be leaked.
> 
> Currently no SoC sets ops->init so this path cannot trigger, but when a
> future SoC implements this callback, the leak would occur on init failure
> for devices with integrated PHYs.

However, the driver does not release this resource when cleaning up, so
that's already a bug as the driver currently stands. I think this could
be converted to devm_reset_control_get(), which would resolve both
leakages, but not sure.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

