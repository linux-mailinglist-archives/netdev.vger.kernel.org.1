Return-Path: <netdev+bounces-274637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG6jIheozmkgpQYAu9opvQ
	(envelope-from <netdev+bounces-274637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:32:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D92A538C8AE
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC83E300B470
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DF03AA512;
	Thu,  2 Apr 2026 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wDot2J5q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71E387585;
	Thu,  2 Apr 2026 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150819; cv=none; b=HLtnt/wB+8ZF5W1FBN5u3JCVqF2pT0b4Jh87reT/3s7kjDxSmAE7JF/mAk+j5EQU3f92RccR8e1jp+ppR29xNL9PGW4Oz45Rge2tFNtQzRpuZHcqRFiKbT/0ByAp0/M4LIFw1piGGtJcoVsyeaXPcysa0QBC1hrjItBnsOorkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150819; c=relaxed/simple;
	bh=456qpab/2Y+5583+hhZDWqU1vyjCcK0w3bOstF2nGuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBOOrSUEVVKH/hJXguKK8YLNksDvNNgvOHYX117nIeD0aJnEIPMYJz80fPjceUeUp8zgs2T/XMr+NSHXT5ugCH1UhzA2mx+WVIna4haJYd9nktzxZS7BaZyH5QhZvH0vE81U5hYQCjoSdzlKfWQY/F7FC0bw/+8S3v8ecSFX9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wDot2J5q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QUbBy1R8qutWlwjlRQhac0BmXJK/rX9BjT6Dj9HxJQQ=; b=wDot2J5qtw3A6g2m333Laq2P5Y
	CbrFxolUQ2lEuAsFpcFJekG2vVb/DEVj5HBKSawTJ1zPeSE8SkDf+RJuJ/PUfke7Cjvn8Q/dA8I0C
	MjmwpTj/TS9TfEp8lT1bWI7ONKujEpViZ6lYyf3qLUKLbmEGQvgluausuLtGS8yIOI+YjO8/XaD7r
	OAaCFspJcOMXpgqp5HGEKKiMCXmkWV7zHC/tnl0mJmIdFM4gOfIILQpok75hiywGRZ4LudorzQpiH
	ZBIZyRN0TyGBfsZrrC5x3mTVF1O2KZhb6iLgvQa+Yy9IKNLtllhNZNMSdgx0eyjVI6d+Q4nPU+bZ8
	5Hh6cvPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56110)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w8Log-000000004l2-2BYS;
	Thu, 02 Apr 2026 18:26:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w8Loe-000000005wa-28B6;
	Thu, 02 Apr 2026 18:26:48 +0100
Date: Thu, 2 Apr 2026 18:26:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] stmmac crash/stall fixes when under memory
 pressure
Message-ID: <ac6m2E6FIu4azGj0@shell.armlinux.org.uk>
References: <20260401041929.12392-1-CFSworks@gmail.com>
 <ac6kfQ98Xjt3dCGj@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6kfQ98Xjt3dCGj@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274637-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	NEURAL_SPAM(0.00)[0.540];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: D92A538C8AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 06:16:45PM +0100, Russell King (Oracle) wrote:
> On Tue, Mar 31, 2026 at 09:19:27PM -0700, Sam Edwards wrote:
> > Hi netdev,
> > 
> > This is v4 of my series containing a pair of bugfixes for the stmmac driver's
> > receive pipeline. These issues occur when stmmac_rx_refill() does not (fully)
> > succeed, which happens more frequently when free memory is low.
> > 
> > The first patch closes Bugzilla bug #221010 [1], where stmmac_rx() can circle
> > around to a still-dirty descriptor (with a NULL buffer pointer), mistake it for
> > a filled descriptor (due to OWN=0), and attempt to dereference the buffer.
> > 
> > In testing that patch, I discovered a second issue: starvation of available RX
> > buffers causes the NIC to stop sending interrupts; if the driver stops polling,
> > it will wait indefinitely for an interrupt that will never come. (Note: the
> > first patch makes this issue more prominent -- mostly because it lets the
> > system survive long enough to exhibit it -- but doesn't *cause* it.) The second
> > patch addresses that problem as well.
> > 
> > Both patches are minimal, appropriate for stable, and designated to `net`. My
> > focus is on small, obviously-correct, easy-to-explain changes: I'll follow up
> > with another patch/series (something like [2]) for `net-next` that fixes the
> > ring in a more robust way.
> > 
> > The tx and zc paths seem to have similar low-memory bugs, to be addressed in
> > separate series.
> 
> I've tested this on my Jetson Xavier platform. One of the issues I've
> had is that running iperf3 results in the receive side stalling because
> it runs out of descriptors. However, despite the receive ring
> eventually being re-filled and the hardware appropriately prodded, it
> steadfastly refuses to restart, despite the descriptors having been
> updated.

I'll make it clear: this problem exists without your patches, so it
is not a regression.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

