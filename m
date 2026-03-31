Return-Path: <netdev+bounces-273665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOHmF+Hgy2n0MAYAu9opvQ
	(envelope-from <netdev+bounces-273665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:57:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7B36B428
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 682EE302A873
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBA13FE666;
	Tue, 31 Mar 2026 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nFexOjuO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1135B63B;
	Tue, 31 Mar 2026 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969053; cv=none; b=h7rtIKyhKgUIlF5qFbwuRfBR5uUBkNHREcHHBsiKdfPpNBv073hhOWi1n9txkVxbk57Txxw+UyivcV42fQ43VVQwzir5V87QUD8NuPzwHu0fD/ktnj94fDMlu6v+cjg0XMdgMg6hgSxGbaPUV6L3CG5/MKi5WU8pCOBsx403AUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969053; c=relaxed/simple;
	bh=zIySdAinjeS2Dxmykke2pYIKupT7GydAWT77fFib0go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMDR0E229KaukeA2JT8hVB+xgcEPmZ4w9whyPeueQZXpyEsxkqpwxf1yDoZ6mqt8IfEyFlvI11ZpIWxN2FuJmouHQO/ZPqUPfI1c5ZoLSR78+qVEsnaHx74WIrhhTCDjvoSfQMHelBLVS80EwpXXmdwgfTORmdCu6ybtSF8vGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nFexOjuO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OlC+AbUuT/K+NGvf11dGDQJ07qdXjlhXrgN+pdY1jv8=; b=nFexOjuOC9sWoupGZwEeesh2FQ
	tKkjt4JUMmaQYYJgAiJGUonj1SkgAVvA55JMWIujszCn7MmMNRZGSiq/MH843dPiAA8rLMeHU5UfA
	LI7Vh7yTyDFouYgffn6ouM7RaDT5vwOcCDxu7bQwMbjqu/rcpM82f3XyPgkI2kuO5I//O6P89njYT
	WorpX28WCGunAa/NCAVr54mwtRoUIwiDfQHCU21CsNk/RvH6oQBTojNMzqXCzKw7ByfcH0J5WXiUy
	yEmUqtca0bQrsG2hRoK86gdrUPLh+4IV+tEPZ1+klhhrPCq2u3c/E5NuZ/+PS+hjmn6RdmbdWp+G1
	00h3GqRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40984)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7aX3-000000001yf-0MNy;
	Tue, 31 Mar 2026 15:57:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7aX1-000000003oh-0m6l;
	Tue, 31 Mar 2026 15:57:27 +0100
Date: Tue, 31 Mar 2026 15:57:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Charles Perry <charles.perry@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: mdio: add a driver for
 PIC64-HPSC/HX MDIO controller
Message-ID: <acvg11voyHoRgQsX@shell.armlinux.org.uk>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
 <20260331123858.1912449-3-charles.perry@microchip.com>
 <acvEpk1grDFAahzd@shell.armlinux.org.uk>
 <acvPKuuikqvfXauy@bby-cbu-swbuild03.eng.microchip.com>
 <acvUqDgepCIScs8M@shell.armlinux.org.uk>
 <88d652b9-ed4f-4bf4-b0ab-8703c15ce58b@lunn.ch>
 <acvdkBF4ZjZaCHwd@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvdkBF4ZjZaCHwd@bby-cbu-swbuild03.eng.microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,bootlin.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273665-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.433];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 00E7B36B428
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 07:43:28AM -0700, Charles Perry wrote:
> On Tue, Mar 31, 2026 at 04:20:55PM +0200, Andrew Lunn wrote:
> > On Tue, Mar 31, 2026 at 03:05:28PM +0100, Russell King (Oracle) wrote:
> > > On Tue, Mar 31, 2026 at 06:42:02AM -0700, Charles Perry wrote:
> > > > I don't know if there's any value in waiting for write completion here as
> > > > write completion doesn't mean that the effects of the write are available
> > > > right now. I also didn't run into any issues in my testing. Let me know if
> > > > you know of a use case where this wouldn't work.
> > > > 
> > > > I can add a wait for transaction completion if that's expected by phylib.
> > > 
> > > Consider a PHY using a shared interrupt line, and the interrupt being
> > > disabled in at the PHY before being torn down... wouldn't we want the
> > > write to the register which enables interrupts to complete before we
> > > unregister the interrupt handler for the particular PHY?
> > > 
> > > I do notice that other MDIO drivers don't wait. Some PHY drivers don't
> > > access the PHY after the write to disable interrupts either. So, maybe
> > > phy_free_interrupt() should read-back from the PHY before calling
> > > free_irq() to guarantee that the write has completed?
> > > 
> > > Andrew?
> > 
> > The general pattern is to not wait on write.
> 
> Ok, then it's status quo for this.

Except someone needs to add that read-back - don't look at me, I
generate too many patches for netdev, so have no capacity for yet
more patches.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

