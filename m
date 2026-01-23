Return-Path: <netdev+bounces-252725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHjZDTY+c2kztgAAu9opvQ
	(envelope-from <netdev+bounces-252725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:24:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AA9733A6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7416F3002D2A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDAC3385AB;
	Fri, 23 Jan 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XPSvDxTu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249FC23BD02
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160184; cv=none; b=AzawUul+pmFdjkozF2Z6B0MYAneDvKcoGDL5ZEXdiIcGE1iY/2JaVYs+ZxLuAdMqoeNUApAJQ5lVo+v4rH4F362cWv6Zcmzkov+RweUuTCf/KnuuLn0BvbsStPfTVSHwS7q/qaMwDcUN63JeMYX/k/S+3rlQEj/b65j4IRpv1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160184; c=relaxed/simple;
	bh=SFuj7UPcIBvbQbc0W8dyiHCo45ikyzlOEDjAkKhZt58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMlO37VLrTtqlMJeL0DRNTd6+k8JoR3jFmMv9yPrXlXbzY2odA9kZQDsbaVKIOmlDgkQ4dbxFeL/T0haoRTQJvbNvIZ1dPi4ccAqoN5BstltbCzNn+4HWFq719FO9OOoMeJlvAaAsIMuanGDgsEIXTVxmbpqiHsE8Jr4eKmaLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XPSvDxTu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iylHYQC7bypzUMsUMKe8ERFGYjxfve+NR6YW7zkm7W4=; b=XPSvDxTuNyXc1gSKQwWzz4qNIa
	NAvfOLOxY1DGQgwHOwLLh5b78qlm/Aufd7/PvX52FUVf2LmBMUla32Ztvf9Xr5LynyAPt0f8AIaBl
	rwn46EL6+yHp0+RAyXpYcGnjKuNTA7ryJK198GAX6BaGykyE8omeSPPX3vwBC+HAahjtbuNwEALUE
	NWcBOulen0dW5Xx7fBDxcablmqMEYz8/A2jkHUa8f7LUiuC7wJ6BKDL+lSQarfdBX1H4YtUAkGIP8
	+MRh8bAI+kSPO1MFO481KMPYpBJJy9h9klMGZPLydrB+SnDMHmJGhu0/2Tj2clmQbBnov4mQTODMn
	oZUW2sQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38210)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vjDNV-000000001X1-1xng;
	Fri, 23 Jan 2026 09:22:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vjDNQ-000000001yI-1Qye;
	Fri, 23 Jan 2026 09:22:48 +0000
Date: Fri, 23 Jan 2026 09:22:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: make PHY fixup support always built-in
Message-ID: <aXM96CNzkiSIPukf@shell.armlinux.org.uk>
References: <800595c6-496a-443e-92e3-37251195e610@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800595c6-496a-443e-92e3-37251195e610@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252725-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59AA9733A6
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 07:50:20AM +0100, Heiner Kallweit wrote:
> PHY fixup registration is used from platform code in init phase only.
> Let's move the PHY fixup code from the modular part of phylib to the
> always built-in part of phylib. This allows to annotate the fixup
> registration as __init.
> 
> phy_needs_fixup() and phy_scan_fixups() wouldn't have to be moved to
> the built-in part of phylib. But doing so allows to fully factor out
> fixup support into its own source code file, and make struct
> phy_fixup and phy_fixup_list strictly private to phy_fixup.c.
> 
> phy_scan_fixups() is used after init phase only, then phy_fixup_list
> is read-only. So we don't need the mutex when accessing the list.
> Also when registering PHY fixups the mutex isn't needed, because
> fixup registration is done sequentially from platform init code.
> Actually there is only one platform with more than one fixup.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

What is broken today that needs this change, and why haven't we had
reports of breakage?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

