Return-Path: <netdev+bounces-260789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJpkMgyynmlxWwQAu9opvQ
	(envelope-from <netdev+bounces-260789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:25:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82419428A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C41F300917E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BD2C234A;
	Wed, 25 Feb 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kfzVf4+I"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317B1C860C
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007864; cv=none; b=OC6wTpsqMUpntAkiNlVNWg4eQROXqZjvZHWd+jPbzwX+5oANwbJRRvufAAqEIvVRkETei9N3qGx7KfRxZNtENdxSCJLla3ETSyp4jKpt/asIxicYpw2szWMCIZoasHbWUkGBjRa4R+nvYLFpa66UNPgLDUT9gzi1yiXhL0VtDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007864; c=relaxed/simple;
	bh=U1GhL7zKltKKOQKOy/cabia1ibZK6mpbc18xNtgDDhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfSTwB03V6acrHKrm9uOBeaOglLthaG+MGYYoeQYAr/Wo+sQgeLKfexBLmsjfeHSTtxAeDo0HjOa3wkVQmbvjR3U5n7D7TQlwjrZUkWPkCaRF4IQ05TAwTP8sb78RbM/fVTKntwGopqzCYTQrV1DyKMoQ1ihn9R4xqyy5WMHlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kfzVf4+I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CwTftfPLORKMn5vbTjWLfPI4meAs67WbxJlY6dwYVxc=; b=kfzVf4+IM4IiPw4cIgIYd3bERw
	+DP84XAV4/0wtN/BzlkFLseEOWDvHg5qQwgrzMP7UdzYPGcFGsl+LcyBC4dQe3XNeH6DojGmKUbjU
	lW9s5j9i0NG1gkC50JfQdFm1oESpk+TxLCAy51Ftlum7O5nHCGLZHyTlPw9p9vmuJSpoTDRNGZaJd
	c2f9aUY7+84rXRiU52Nk52OA3xS6MtK8ysgQ5Q0muYLqQSlfi9M7YNbGxZQ5AwVVtcgixmvEXTIxt
	jDuS98wXkr41ETbXxZIyRzGGJMc29PQf94MX/5VFdKZazR01lZbYYmmI1JQJ41Rqy8Vp1TYqgug/8
	OGMRSsGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35986)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvABp-000000006C7-2ZRo;
	Wed, 25 Feb 2026 08:24:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvABm-000000000mM-2Dvn;
	Wed, 25 Feb 2026 08:24:10 +0000
Date: Wed, 25 Feb 2026 08:24:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: fix .ndo_fix_features()
Message-ID: <aZ6xqig4zh_Un8R7@shell.armlinux.org.uk>
References: <E1vuU3X-0000000Ae9G-1Er8@rmk-PC.armlinux.org.uk>
 <20260224173037.7871e5ac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224173037.7871e5ac@kernel.org>
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
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260789-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.917];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A82419428A
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:30:37PM -0800, Jakub Kicinski wrote:
> On Mon, 23 Feb 2026 11:24:51 +0000 Russell King (Oracle) wrote:
> > netdev features documentation requires that .ndo_fix_features() is
> > stateless: it shouldn't modify driver state. Yet, stmmac_fix_features()
> > does exactly that, changing whether GSO frames are processed by the
> > driver.
> > 
> > Move this code to stmmac_set_features() instead, which is the correct
> > place for it. We don't need to check whether TSO is supported; this
> > is already handled via the setup of netdev->hw_features, and we are
> > guaranteed that if netdev->hw_features indicates that a feature is
> > not supported, .ndo_set_features() won't be called with it set.
> 
> No lies detected, but is this enough? The whole TSO enablement 
> looks quite wobbly (as you mentioned in another email IIRC). 
> 
> Only stmmac_hw_setup() actually calls stmmac_enable_tso(). 
> And stmmac_set_features() does not call stmmac_hw_setup().

Looking deeper, dwmac4_enable_tso() has two paths depending on the "en"
flag, both of which are commented as "enable TSO".

Then, looking at the "Enable TSO" block of code in stmmac_hw_setup(),
it looks to me like we can end up with some queues that have TSO
enabled, and others which don't (because TBS has been enabled on the
queue.) As far as I'm aware, the network layer doesn't support
per-queue TSO.

We can't call stmmac_hw_setup() from any path that we care about any
state being preserved - it issues a software reset which causes
everything, including the PTP clock, to be reset and all state then
needs to be reloaded.

Lastly, we don't need to disable the TSE bit (via stmmac_enable_tso()
when we disable TSO, because there's a bit in the descriptors that
also needs to be set for the packet to undergo TSO. However, if the
system undergoes a suspend/resume with TSO disabled by the user, we'll
call stmmac_hw_setup(), which as I note in the previous paragraph will
reset all state, including the TSE bit. stmmac_enable_tso() won't be
called, and thus the TSE bit will remain clear. If the user
subsequently re-enables TSO, then we'll queue packets for TSO but
the hardware won't have that enabled...

That's a problem today. So, while you're right to point this out (I
had missed it) it's a separate problem to the one being addressed
in this patch. In fact, I think there's two new issues that have now
been identified here.

1. The lack of setting TSE on resume if TSO is supported but but has
   been disabled by the user.
2. The interaction of TBS and TSO feature where some channels can
   support TSO and others not, which I don't think can be supported.
   So, I think if we have _any_ channel with TBS enabled, we have to
   disable TSO on the entire netdev.

I think these need to be separate patches, and this one is still
valid on its own.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

