Return-Path: <netdev+bounces-273381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDjhBDoJy2kNDQYAu9opvQ
	(envelope-from <netdev+bounces-273381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:37:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F663625A8
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB34302711E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C7344024;
	Mon, 30 Mar 2026 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AcPdkwnD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF672FE079
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913661; cv=none; b=lQkf6qKSVkW0PA9vTRU5A6jOUo8iTlU4bp2pLOh6+K6KI/JHP67eAMXgj3cy4TLOwHifkoQdJI7ot2yitXQ6ISCzGuXjQEWZeefjLVpX8meHkXOZSN6HSvFSbbYjtidE08U1USIY9WXFFQuohf8GlUbMyLFXcQzPG6mMPlH6yFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913661; c=relaxed/simple;
	bh=vhtRKUjE2BO7KVfuVh1vB716JY7X3U02UFpBkkZCtrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NabmXP1m/jf/mJkCzJZdtg0+MYMD4qmpKgvSsmoUN6YgGSoTu+egD+H61s11g6jolt/abMokNn87OPpoIHfDvDHDtgOUv82NdNwqiMPPRgOBBuQDjv88TDYk3cQHmhXWu4X3Jz9Qz0wAddkIzG9DxfvdoGsIc9Z5mH0eGyAGFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AcPdkwnD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fNRYoBejmraxwzYut1mEAeSYX8XB6lFWiLyEec2VdgM=; b=AcPdkwnDhdmD3fP6iHQgEnj/iL
	01neAhwBEqBaTK6YTNMCK3AmbLu7MwDfertQhr1/U/bjd/a4QsK9S7Glt2esTQO+hXmAgCLmzClVp
	HH4dGGCiVMv/5EmBrREqAKb0Ebmk2Dm30DLaMbpDfZ34DY6+FR+4OfjivdfBXCrVLNrh69UTbIJv6
	F4KSyy58CACVauHaO/bza8NP1IOAmvkadHh/ak1uRW915+/wSlZ/df+m9CpBV8jNywCmnVW0UKHNo
	A9eezjrGSlzBN19tQJDDS5cHm5VDGPjqPJ909M1WX73yCVzRDUMV392Qj5UE6Klrn2YBg+Oe8OFT6
	htYL0XVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43936)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7M7b-00000000139-3PPQ;
	Tue, 31 Mar 2026 00:34:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7M7Z-0000000034e-1hQ8;
	Tue, 31 Mar 2026 00:34:13 +0100
Date: Tue, 31 Mar 2026 00:34:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: bcm84881: add BCM84891/BCM84892
 support
Message-ID: <acsIdUtursePX5-D@shell.armlinux.org.uk>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
 <20260324190601.1616343-1-wagner.daniel.t@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324190601.1616343-1-wagner.daniel.t@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,gmail.com,kernel.org,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273381-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.941];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 68F663625A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 07:06:01PM +0000, Daniel Wagner wrote:
> The BCM84891 and BCM84892 are 10GBASE-T PHYs in the same family as the
> BCM84881, sharing the register map and most callbacks. They add USXGMII
> as a host interface mode.
> 
> bcm8489x_config_init() is separate from bcm84881_config_init(): it
> allows only USXGMII (the only host mode available on the tested
> hardware) and clears MDIO_CTRL1_LPOWER, which is set at boot on the
> tested platform. Does not recur on ifdown/ifup, cable events, or
> link-partner advertisement changes, so config_init is sufficient.
> 
> For USXGMII, read_status() skips the 0x4011 host-mode register: it
> returns the same value regardless of negotiated copper speed (USXGMII
> symbol replication). Speed comes from phy_resolve_aneg_linkmode() via
> standard C45 AN resolution.
> 
> Tested on TRENDnet TEG-S750 (RTL9303 + 1x BCM84891 + 4x BCM84892)
> running OpenWrt, where the MDIO controller driver is currently
> OpenWrt-specific. Link verified at 100M, 1G, 2.5G, 10G.
> 
> Signed-off-by: Daniel Wagner <wagner.daniel.t@gmail.com>

When you re-post, please do not thread to the previous patch versions.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

