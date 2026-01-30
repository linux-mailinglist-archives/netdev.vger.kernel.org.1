Return-Path: <netdev+bounces-255174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMQOCgjUfGlbOwIAu9opvQ
	(envelope-from <netdev+bounces-255174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:53:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F3CBC42F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 379D33012B3E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2DC33C1BB;
	Fri, 30 Jan 2026 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aS+ac/s2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB233A9D3;
	Fri, 30 Jan 2026 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788385; cv=none; b=OXaFME9rqdfzoR7QZogNuGGZ/Itk9kY/nVS8f3kqNAou+G+txmb/ZnLvxVJ3kRVZ5g+1G2aPvAeHFhghyU6QVSJW683fP2zY6BLp5TNz+zfVAtB3nWwODmhyZktRGozMyOShCV5w/9StnmUERewUUg8crJb1RnRQsHy3KbFARNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788385; c=relaxed/simple;
	bh=4OXwYLN7R1JMxi+9RY657IiKw7LXuYp7oSREeO84t7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohMHuyY6EQ18nUjDXJEIPoy6NcSVdctQNZihbf1dxBNuVYBcTD6nQNcbcHQD6Ne7bAgaQM5SuzqDgLLJW4VIt7tWzutkNz62alL80/Bi8+YlxE6wGT3KHGnsYw3v2rLEU+3PhrYtAJm7oJKgJB3YMCw33gLFXVZFVYZ73bDeqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aS+ac/s2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HXe//ENorTTfM0niimm1e9yrY55w/0fMrZ/qt/A7EwM=; b=aS+ac/s20VY5WOMnOTrrKTXkqw
	CvUccuNW8erl31P/A6aO0RTRQyLv9VkiYGK0m6u5zBmV5IGGnas6fK1PiuUMqhkUiFn72vVs+igMx
	xwSPo1it4HcrWcdKwA5gPvudx5huDaj0jFHempG5JHTFClIelb5fWTlgXb4/b0yC+EKGOZVzfurK5
	q/ocekDnstsspNsC+ZRwBg6LMMu5lSaCp+ifYdpEwxVhOFwbEPKScaDUTp5xfiPfKaUWos/tLpPXE
	UnDVNlFvJNhhae9c26rIO/ItRBMJQ9ASIMNaYrFECF/CamkXwyvk8uSGl9oVu+kqqAgGkkVSappfI
	40fVGUlw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55186)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlqnq-000000001Fc-0kyn;
	Fri, 30 Jan 2026 15:52:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlqnl-000000000dd-2qfp;
	Fri, 30 Jan 2026 15:52:53 +0000
Date: Fri, 30 Jan 2026 15:52:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	kernel@dh-electronics.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,PATCH] net: stmmac: stm32: Do not suspend downed
 interface
Message-ID: <aXzT1UCpG4kN-dQv@shell.armlinux.org.uk>
References: <20260114081809.12758-1-marex@nabladev.com>
 <aWfEXX1iMHy3V5sK@shell.armlinux.org.uk>
 <aWfOYf_YmJFUakvP@shell.armlinux.org.uk>
 <6c9cadc2-67b7-4bfe-9cf7-2b102a0a3c21@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c9cadc2-67b7-4bfe-9cf7-2b102a0a3c21@nabladev.com>
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
	TAGGED_FROM(0.00)[bounces-255174-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,foss.st.com,lunn.ch,st.com,google.com,kernel.org,gmail.com,redhat.com,dh-electronics.com,lists.infradead.org,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 46F3CBC42F
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 12:27:05AM +0100, Marek Vasut wrote:
> On 1/14/26 6:12 PM, Russell King (Oracle) wrote:
> > I think I'm going to start over, trying to figure out what happened.
> > 
> > c7308b2f3d0d net: stmmac: stm32: convert to suspend()/resume() methods
> > 
> > Did the conversion, and it always called stm32_dwmac_clk_disable() and
> > where it exists, dwmac->ops->suspend() on suspend, provided
> > stmmac_suspend() returns zero (which it will do, even if the interface
> > is down. On resume, it always calls dwmac->ops->resume() and
> > stm32_dwmac_init() before calling stmmac_resume().
> > 
> > The conversion added hooks into ny new ->suspend() and ->resume()
> > methods to handle the stm32_dwmac_clk_disable(), dwmac->ops->suspend(),
> > dwmac->ops->resume() and stm32_dwmac_init() steps.
> > 
> > However, in 07bbbfe7addf I failed to realise that, in order to keep
> > things compatible with how stuff works, we need to call
> > priv->plat->suspend() even if the interface is down. This is where
> > the bug is, not in your glue driver.
> > 
> > Please try this:
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index a8a78fe7d01f..2acbb0107cd3 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -8066,7 +8066,7 @@ int stmmac_suspend(struct device *dev)
> >   	u32 chan;
> >   	if (!ndev || !netif_running(ndev))
> > -		return 0;
> > +		goto suspend_bsp;
> >   	mutex_lock(&priv->lock);
> > @@ -8106,6 +8106,7 @@ int stmmac_suspend(struct device *dev)
> >   	if (stmmac_fpe_supported(priv))
> >   		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
> > +suspend_bsp:
> >   	if (priv->plat->suspend)
> >   		return priv->plat->suspend(dev, priv->plat->bsp_priv);
> This works too, thank you.
> 
> Will you send this fix ?

Sorry, I appear to have dropped this patch on the floor, and just
tripped over it. I'm just build testing it and will send it later
today.

This problem affects every user of the platform ->suspend/resume()
stuff, so is not just a stm32 issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

