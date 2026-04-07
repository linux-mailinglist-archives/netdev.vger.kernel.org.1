Return-Path: <netdev+bounces-276125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI/RDyNG1Wk44AcAu9opvQ
	(envelope-from <netdev+bounces-276125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:00:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C160E3B2A86
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D8FA300E167
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 18:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A969343D72;
	Tue,  7 Apr 2026 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TRaTPTn4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83363347BBD;
	Tue,  7 Apr 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584799; cv=none; b=eW9f4PGz34edL6BiSvEfNzYB3JNrNg74f10R3yIEz6dpNy9eFKi3Q1cOPr2rstTR/Zho+nIySkGVTuWmZ3kjLMFO0PVEmbZW65kVPLlcVtmK+/CmqnPgWqF+YE4q0OwVX9Dj/OKlgUZXI45Ee9SNayVMZmYrX0N+oiV892A5vsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584799; c=relaxed/simple;
	bh=I3DWkvWTSyzivtILM813NsRqXMtQdf8oBooGXOb8BHg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t26EZpPPZ87EHZftjVWh0CVNETo8rsnQN/y7DIsTCmt+pTfHzhyjw0PsgdX8UFfJreUk2QHl1oBzI23nYhQdte4zO4tdF+iR4TabbXNwy0F6KdTYkkAEReCIayKj79v1Ge7KLdcmp41QFTnPsON8FhVS+9pVHn20gczIzk8mmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TRaTPTn4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775584798; x=1807120798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I3DWkvWTSyzivtILM813NsRqXMtQdf8oBooGXOb8BHg=;
  b=TRaTPTn415G3+m/9rSi5RjCS2qgo9lpkAW1uhIz/GhSlwJMR5CPuqZr2
   MakwvjZY7hdXhJ0v2OACf7VRbZwGbypKKoaagssruQ1t/7aNfQoKPxa1h
   oK6pld9wtVC2/B9UxQK6hpuA4KMiGwPrY+z/9oEDuqoVylHyCkbxVmrdw
   8YICaWeyKYuH2WiM6bNEIwJ6GoxuBpFOaNvf6YWySCAr40i8FdonymZ1a
   B/6vORMYw7DKkmoN55hT9LTwzy8TO9n0q4AbudclyG4ihI7yfPZOZNYi9
   GLnt58KNExA/H/MD9a5HM2YkWpMS/XsJ0Sd6f1mEJ7q2navJZtMr9CcIE
   Q==;
X-CSE-ConnectionGUID: VZljJUNSSvKME2czGYfkRQ==
X-CSE-MsgGUID: wbS1b32BQfiWxVsMLPMS5w==
X-IronPort-AV: E=Sophos;i="6.23,166,1770620400"; 
   d="scan'208";a="223041780"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 10:59:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 7 Apr 2026 10:59:27 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 7 Apr 2026 10:59:26 -0700
Date: Tue, 7 Apr 2026 10:59:24 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Charles Perry <charles.perry@microchip.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: phy: add a PHY write barrier when
 disabling interrupts
Message-ID: <adVF/MG4xzqByv2o@bby-cbu-swbuild03.eng.microchip.com>
References: <20260402131229.319599-1-charles.perry@microchip.com>
 <20260402131229.319599-4-charles.perry@microchip.com>
 <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
 <ac6vfhsW2ThF8i2_@shell.armlinux.org.uk>
 <b40dfafe-7e8f-4686-a743-31b097c84954@lunn.ch>
 <adUupYuD6tM3ahaR@bby-cbu-swbuild03.eng.microchip.com>
 <b63c401b-bea9-4a2d-a43e-cd20c3013f53@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b63c401b-bea9-4a2d-a43e-cd20c3013f53@lunn.ch>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FREEMAIL_CC(0.00)[microchip.com,armlinux.org.uk,vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276125-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C160E3B2A86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 06:59:00PM +0200, Andrew Lunn wrote:
> > static void phy_write_barrier(struct phy_device *phydev)
> > {
> >        int err;
> >  
> >        err = mdiobus_read(phydev->mdio.bus, phydev->mdio.addr, MII_PHYSID1);
> >        if (err == -EOPNOTSUPP)
> >                mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
> >                                 __ffs(phydev->c45_ids.mmds_present),
> >                                 MII_PHYSID1);
> > }
> 
> Using __ffs() is maybe more complex than needed.
> 
> All you are trying to do is ensure the last write happened, by doing a
> read. Any read should work, even if the device does not respond. We
> just need to be careful not to read a register which might clear on
> read, such as an interrupt status register, or the link status, which
> latches. MII_PHYID1 is safe. Since we throw away the value, we don't
> care if the MMD is not present, the read will still flush the previous
> write. So i would replace the _ffs() with a hard coded value. KISS.

Ok, I'll use device 1 (MDIO_MMD_PMAPMD).

Thanks for the explanations.

> 
> > Do you think there's any way I can test this on my VSC8574 or VSC8541? It
> > supports some C45 registers for EEE but not the device discovery part.
> 
> It is not so easy to do. You need to hack the C22 read so that is
> returns EOPNOTSUPP, but you also need the first few reads to return a
> valid value otherwise the probe will fail.
> 
> I think this is one of the cases that if the reviewers thinks its
> looks O.K, we can accept it without extensive testing.
> 

Ok

Thanks,
Charles



