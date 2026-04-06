Return-Path: <netdev+bounces-275726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAZEMyYY1GksqwcAu9opvQ
	(envelope-from <netdev+bounces-275726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E63A73A8
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8CA3300F10D
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DDE30EF95;
	Mon,  6 Apr 2026 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="becA8Wyr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B62F9985;
	Mon,  6 Apr 2026 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507326; cv=none; b=SJXcdFF+JQ0o+YLdcbqr0gO6jvy05AvqhAUw0sT3+CPVXgmfkxugy6ndKS9lE93fE+Q4Yuhwok1qD6gHM+yTiNMRUjVpkpw00lqDRAoiGT2uMa3AMCHhnByqmQMS302HhgL25HjuqzokQCQ5ZfkWkyU1szG6sRugN1M9XQ+Dlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507326; c=relaxed/simple;
	bh=1qWiuIRqe9AwC/241z7aSGJ9QiVuvILUv6zjUxFv4JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmTQ6yTAyeDkQUA+m17NDNOD+tbFpQB34MDlgHmXIzACoddtlHcIoRlfwzLhd5RqDSUyq9KUzXPmVh/57wxAo0sY7NcaPG8UCVQmMs9FUPhRY/MQMs9JgzDnsw+rXoZ8BhAskH4YQ3okAsBxxRiwo6OGKHa/WbgFTeMg7EqevSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=becA8Wyr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y33qY31aVGgomLecXEmItVy3lGhm7wL+Aw51Mknl+8g=; b=becA8Wyrj+YD+0bEQWcCIvcBuG
	MUtFupMvdhtV1Y+RIpuwKI2AmCiZdFvMsnKmAk/q29aDbve+FRXk8LFRMAXPq7/XLo9/fYt6SMfL4
	4cWTFMjeaMvEDQKbn7kcokS6IHsFY5T4F+WDuA92kCG0yYAP6CA36nufpAfj5/Q95cjGkC5fubIEM
	e90AnQ6Xb59U9G3lz5ILWMTNjWwrs+Z4aWRDGFzgUXp/TtwG48zH2W7EGLV61OBsmiUjFOHWAIHa2
	pM02yB7Vm/K1RguysAnSjNtwTYUQP+Kej+Uq7IMGwMjG2y4+9d7vuvaHfQNqf0YESDPPT4rmC3l5N
	jhHJt7wA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50788)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w9qYk-000000008VL-3tyh;
	Mon, 06 Apr 2026 21:28:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w9qYh-000000001bI-3HHI;
	Mon, 06 Apr 2026 21:28:31 +0100
Date: Mon, 6 Apr 2026 21:28:31 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
Message-ID: <adQXbyzRsLgXRdIL@shell.armlinux.org.uk>
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
 <a1cf8f6a-b338-4dd7-aced-7e19e4d0fdb7@lunn.ch>
 <9272c5dd653039b3def8caaea3e631c5@tipi-net.de>
 <5298959c-12de-4992-a896-3d1371cba111@lunn.ch>
 <cdef227e-9dfe-4860-aca3-5ce1f60cb838@broadcom.com>
 <adPo-o9DtxIZGDvg@shell.armlinux.org.uk>
 <faf651039d98fb9c1ffb40dbd98bb16b@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf651039d98fb9c1ffb40dbd98bb16b@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275726-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.851];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 312E63A73A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 08:29:38PM +0200, Nicolai Buchwitz wrote:
> On 6.4.2026 19:10, Russell King (Oracle) wrote:
> > On Mon, Apr 06, 2026 at 09:43:55AM -0700, Florian Fainelli wrote:
> > > That is almost a guarantee given, there will be a broken MAC
> > 
> > Well, it already exists. modern i.MX platforms use stmmac, and some
> > bright spark wired lpi_intr_o together with the main stmmac interrupt
> > which causes interrupt storms when the receive path exits LPI. This
> > makes stmmac LPI unusable on this platform.
> > 
> > So, if i.MX is paired with a PHY that can do its own EEE, then we
> > have this exact scenaro.
> 
> For DT-based platforms (like the broken i.MX), this could be addressed
> similar to what we already have with eee-broken-* properties. For
> platforms without DT it's getting more complicated and I can't see a
> way without ethtool.

No. It's not that EEE itself is broken, it's that the integration of
the stmmac IP into the SoC is broken. We already have a solution to
disable LPI at stmmac (the STMMAC_FLAG_EEE_DISABLE flag).

That tells stmmac that the MAC doesn't support LPI signalling for an
speed and any interface mode, and will result in phy_disable_eee()
being called, which clears the EEE advertisement, disables LPI, EEE
enables, and fills phydev->eee_disabled_modes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

