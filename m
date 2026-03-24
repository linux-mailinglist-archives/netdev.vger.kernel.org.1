Return-Path: <netdev+bounces-271260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEIsECPowmnnnAQAu9opvQ
	(envelope-from <netdev+bounces-271260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:38:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0631BA0C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE9B83006178
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57305303A0A;
	Tue, 24 Mar 2026 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dcC2m3A9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB22DB7BD
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380766; cv=none; b=Uppkt8aseiPUMTJvrmXN1gvmqopBCLTQlb1xXhojJPk9gKJ8Tbz4TRzKCJsCwvFiHc+tigogZCt7qP1fqLZXbf3zWCWwoNcx0moIsQLV0vGsj7SNYGgLZi78hmM2ueMRhyY8/S+1xXbsRRVNVZimvOOoHUYJh/A9cpbHgRUjzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380766; c=relaxed/simple;
	bh=w5Gh1aHtMLP0pN4YGj2boonI7PgtCSWo841DqlsRkjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be628/REfkv1ViaxWTU3lVcty4ndNmkQw5JpLWGZOyEHXRLhpi097IgiNdx+CSdRVVnr/hRn9QvYWoPbi6O9AwPtvfLHpJfzLOQgzrE5qDF7xqNt02fm7wK9krHCH/O6qp7+Nn+AH0a2GFmY8tV03ZQy9an1di0MU0h/Ea/lEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dcC2m3A9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=akpVw8GG/D7/uN8//pJi89LeOCQWsdhfC6x7h6MTWYI=; b=dcC2m3A96EFNvYQs64zn13BAav
	ev4U7xNSrJo2A2rwSaV1I7ASWLHM3uCOY6mQVCmQ49t4f9/grks2GAtvy1ySmd/1qKF1Jmq8XwS4w
	JrXFvqWB8ZL67sNwHhdXiDETDfAlMGrz3RqXox80ycoafzZG4OEy3ONW4zaYKhfOsJvT6dGbET6zO
	pgF2Q+xyA16NMeqT0VPAsixYdjxYurRKhzG0ly1FL+k1XLyeBess6bS91otPvu3XC4eoioAxCa81w
	oc9RE/ORwl1ts93aMYMpi5vhC55SzHdZkkalIWz4EN33OowoQglbBpwYYT28ufZzseB8z6HXDVjdw
	i69GZ9bg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60794)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w57UX-000000002Y5-1MF1;
	Tue, 24 Mar 2026 19:32:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w57UV-000000005Jj-2ifC;
	Tue, 24 Mar 2026 19:32:39 +0000
Date: Tue, 24 Mar 2026 19:32:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892
 support
Message-ID: <acLm1wdDAFhjJVId@shell.armlinux.org.uk>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
 <acKypS845fm_GB0o@shell.armlinux.org.uk>
 <CAMsLQxFnhPT5TLmwQS14rrgD8xmgs6ymH8Q3ee1KcSqm1XEstw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMsLQxFnhPT5TLmwQS14rrgD8xmgs6ymH8Q3ee1KcSqm1XEstw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271260-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	NEURAL_SPAM(0.00)[0.077];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 8BE0631BA0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 06:54:29PM +0000, Daniel Wagner wrote:
> Thanks both for the quick review.
> 
> On Tue, Mar 24, 2026 at 3:50 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > Is the PHY really using 10GBASE-R or is it using USXGMII. The two are
> > different.
> [...]
> > Is there a code in the 0x4011 register which indicates if it uses
> > USXGMII as opposed to 10GBASE-R ? Please clarify.
> 
> It's USXGMII with symbol replication. The MAC receives the negotiated copper
> speed, not 10G -- phylink's mac_link_up() is called with the copper speed.
> Link works at 100M/1G/2.5G with no rate_matching in the driver, which I think
> wouldn't be the case for 10GBASE-R with rate adaptation.

One would expect so.

> On 0x4011: it reads the same value (0x3107, mode=3) at 1G and at 2.5G copper,
> not tracking copper speed. There's no separate USXGMII encoding I can find --
> mode=3 appears to mean "10G SerDes line rate" regardless of protocol, but
> admittedly I don't have access to data sheets so this is inference.

Looking at the information I have for this register:
bit 0 should be link bit (0 = link down, 1 = link up)
bits 4:1 indicates the interface and speed over interface:
	3  = 10GBASE-R
	...
	9, 10, 12 and 13 indicate USXGMII at various link speeds.

So, as you're seeing 3 for this field, that makes me somewhat
suspicious whether this register is implemented the same on these
devices.

Can you confirm whether bit 0 changes depending whether the PHY has
link. I don't know whether that's media link or host-side link, so
I suggest checking both.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

