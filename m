Return-Path: <netdev+bounces-273663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHdZGyDey2lHMAYAu9opvQ
	(envelope-from <netdev+bounces-273663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:45:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF0B36B25B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD8803022D7F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E83FE653;
	Tue, 31 Mar 2026 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="duek+YuQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9A3FE64D;
	Tue, 31 Mar 2026 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968229; cv=none; b=povYrCkgRQ+fLDwTtd3nftiCExetWAuVHl6EGC1EF52SHNDoZLZbjSygSofIC1NNHTfx6jfVvTCE+uz2+E07RMelfIgqvBzehG68KTFpDjPzOk48656YXlJHx8vi833EB1kxbx9lK9L+YNCALr+avKlArULyPUW4jA6a2/JlvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968229; c=relaxed/simple;
	bh=DUa0rgcwZDaJ0rdJ2kWsjlF8kpB93W1ipibIvJllQaI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIQS/UGBK2hqyyaiNBIYpcQXm0XMx4I+qxfCv+hpqINMOkDriKEj8iiAM8VxNnsmAaPvjPtpJD3oiDTBXr5UjjI391ZakgncNtQpCqkRSPRj/QEBrz4MSNG7dHEyQoG9lEvMSrzfE/2exgaH+7/hMtGVB7W+8NJG4iWsgWhpaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=duek+YuQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774968227; x=1806504227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DUa0rgcwZDaJ0rdJ2kWsjlF8kpB93W1ipibIvJllQaI=;
  b=duek+YuQ2JE1A55LX8wuLCGAApzAfDRqj4gxyOXBfZnQ4PaYrnjr84ug
   4zGzretUKmYVpvIJ78pSEdB7nyMzot8V0FO//V+X/caVvWEzvwMHfOmml
   Wy60dhRpc3q5cOBFRKXEQwcSvcRK8yV5avgEM4PWKlaJpPLYtzjxzE5Xf
   pRbbONA/M7IA82dtRpniH5pz1dXEI82GXY5RgNHSRsL6+jyfaKGKTrDln
   1gtpaKnJ7nASI31RrP41tdIchGj3umLTQOOheUdzbHyan5UwV5WXDxcc9
   5pVfDhCIcCjT73s/y3ob48h5O51/vR1aMMrqfjp+5Rh3Xlc1j0CJdBksk
   w==;
X-CSE-ConnectionGUID: eQMbEJKqSnqWvWuGlyZwgg==
X-CSE-MsgGUID: 26StdDJSSKmOJ95EK+Pu2w==
X-IronPort-AV: E=Sophos;i="6.23,152,1770620400"; 
   d="scan'208";a="55894668"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 07:43:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 31 Mar 2026 07:43:30 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 31 Mar 2026 07:43:29 -0700
Date: Tue, 31 Mar 2026 07:43:28 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, Charles Perry
	<charles.perry@microchip.com>, <netdev@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] net: mdio: add a driver for
 PIC64-HPSC/HX MDIO controller
Message-ID: <acvdkBF4ZjZaCHwd@bby-cbu-swbuild03.eng.microchip.com>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
 <20260331123858.1912449-3-charles.perry@microchip.com>
 <acvEpk1grDFAahzd@shell.armlinux.org.uk>
 <acvPKuuikqvfXauy@bby-cbu-swbuild03.eng.microchip.com>
 <acvUqDgepCIScs8M@shell.armlinux.org.uk>
 <88d652b9-ed4f-4bf4-b0ab-8703c15ce58b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <88d652b9-ed4f-4bf4-b0ab-8703c15ce58b@lunn.ch>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,microchip.com,vger.kernel.org,bootlin.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273663-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:dkim,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: 6EF0B36B25B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:20:55PM +0200, Andrew Lunn wrote:
> On Tue, Mar 31, 2026 at 03:05:28PM +0100, Russell King (Oracle) wrote:
> > On Tue, Mar 31, 2026 at 06:42:02AM -0700, Charles Perry wrote:
> > > I don't know if there's any value in waiting for write completion here as
> > > write completion doesn't mean that the effects of the write are available
> > > right now. I also didn't run into any issues in my testing. Let me know if
> > > you know of a use case where this wouldn't work.
> > > 
> > > I can add a wait for transaction completion if that's expected by phylib.
> > 
> > Consider a PHY using a shared interrupt line, and the interrupt being
> > disabled in at the PHY before being torn down... wouldn't we want the
> > write to the register which enables interrupts to complete before we
> > unregister the interrupt handler for the particular PHY?
> > 
> > I do notice that other MDIO drivers don't wait. Some PHY drivers don't
> > access the PHY after the write to disable interrupts either. So, maybe
> > phy_free_interrupt() should read-back from the PHY before calling
> > free_irq() to guarantee that the write has completed?
> > 
> > Andrew?
> 
> The general pattern is to not wait on write.

Ok, then it's status quo for this.

I'll send a v4 later this week for the other return issue.

Thanks,
Charles


