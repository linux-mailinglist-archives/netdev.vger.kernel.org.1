Return-Path: <netdev+bounces-255218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EMvNdXzfGk5PgIAu9opvQ
	(envelope-from <netdev+bounces-255218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:09:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3CBD990
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52BBD300335C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5D36B042;
	Fri, 30 Jan 2026 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="y8g5IMvG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519836C0B1
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769796563; cv=none; b=kMKJYBQ/PUQZq0b+pYimBC8kzdVKam5A2uMkt5A2eeKrPhvfCf4FFdz9rbU/X4uE1lMOQdn3yJbvmoCBYBssHyDMW0lTUnr8HAbwmkTJSjGBCSVxYhQNYcqM69csc6OZjDw1KbegTL73Bt8n4YJrTRaEU9/H8iCc7bVeXeBGxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769796563; c=relaxed/simple;
	bh=e/Bt9m9lnx3IOS1PLwqfMdX95DKtRAdPMruzoSYKGbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBufEk2D2W9lVuEgkujRXmkMkdqz5K8dtYenvJGJSfBSrbv6pqQREQGslM4+PHfhO1+fzMcmbc5jCzUORdIVKa8EKpPYpnh1KturNBdJFJwEVbNN2rezJlVX/SyH54fjhhdSD3T5inkuLxYFfuARL8R/rg4eoCAIHTcEv295qTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=y8g5IMvG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NJGHCJHC/C1S/dc48iAgg6S72Ja9f72htrzVxmHBznY=; b=y8g5IMvGwzIvn9WkzEVPh4AHot
	IhhlsFV8sIPDLGDtax1wUOk9cjSIdE3slCsK0mabLqDgtmwGIDcfBwEi0E/4UX/Wl7s24kMfe8Tu8
	bBA6ZgW1hDAYrFBJgDCUuzEnNC3CeL/cDDlgYJB1UNz9gvduqe34eGAgsaSzMh+7xC3RcurkARW78
	V8fuuT8N+sUlCYCX82GH0yKvOzWgh5dVUK8XwQBH3W3F2qOGg/GL0fQPkF+AUJCqK9G+Gn24ZuTjc
	k1azLxitSHg3NYX4yx9lGo1ieKhr+UPiKMCEHk3v7xTN7VHl5/YV97PgUcQH6S4K+XUAQJwSsF/xI
	UyDV2bGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46880)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlsvh-000000001Km-0cQA;
	Fri, 30 Jan 2026 18:09:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlsvd-000000000it-3G8k;
	Fri, 30 Jan 2026 18:09:09 +0000
Date: Fri, 30 Jan 2026 18:09:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: clear half-duplex caps where
 unsupported
Message-ID: <aXzzxeRsbnF8-nAq@shell.armlinux.org.uk>
References: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
 <E1vlmOQ-00000006zuz-0ffN@rmk-PC.armlinux.org.uk>
 <9dfdeee0-7758-439b-a2a5-a7f243427cf4@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dfdeee0-7758-439b-a2a5-a7f243427cf4@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255218-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,armlinux.org.uk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 6BC3CBD990
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 06:29:23PM +0100, Maxime Chevallier wrote:
> Hi,
> 
> On 30/01/2026 12:10, Russell King (Oracle) wrote:
> > Where a core supports hardware features, but does not indicate support
> > for half-duplex, clear phylink's half-duplex 1G, 100M and 10M
> > capability bits to disallow half-duplex operation and advertisement of
> > these link modes.
> > 
> > This will avoid the need for special code in the PCS driver to do this
> > based on the ESTATUS register bits, as the support in the PCS is
> > dependent on the same synthesis choice as the MAC core.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Gave it a quick test on socfpga, as this impacts all variants,
> and we seem to be good so,
> 
> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

If you look at /sys/kernel/debug/stmmaceth/ethX/dma_cap, it should
say whether half duplex is supported (I guess in your case it will
be, it's probably very unlikely not to be.) However, would be worth
knowing whether the if() is taken or not!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

