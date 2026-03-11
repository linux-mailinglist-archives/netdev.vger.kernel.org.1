Return-Path: <netdev+bounces-266679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHW0HmKLsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:33:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E66342669C4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60DFD30B9911
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDE23DEFF2;
	Wed, 11 Mar 2026 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r3nbTnfv"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793893DF006
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242930; cv=none; b=qnFmKLyXfhalRxGJcG5+9Di9xh4/OImX7vUh0ALs3zY8bjX+xzXwMaiYxl5zkkQr6CEqTaUCKavli57EP7hb2DWLbCkZHHw17q1znM1Pv+ptQtYslsmQRiCtQRPGavlVoNROEkmuO6+dq/7tnhKfuN9tstLbUI4bm79MxOm/mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242930; c=relaxed/simple;
	bh=+5hrHOV/ERFdnBxOF7WQZdPn3U6g+cadS9EuqCb2VLs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWDvBEayKEjj12+/bQ2dQ/qlXBZzy7ZuTpZdLP8+aVWiaJq8jFj7IIPYLek84kb6gwsrw1sMU84fOXtoJ5WqaGqQ6doq2zbalYQvi8stch5GEflFFWvzXWa1+1LqE4+0OxB5hOwC0hfjKeT3UjWM6eMuh18L/1uHD97u/5lZCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r3nbTnfv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773242929; x=1804778929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+5hrHOV/ERFdnBxOF7WQZdPn3U6g+cadS9EuqCb2VLs=;
  b=r3nbTnfvuuSZ7omZJEhnFMbuXpK8O49DSvPE95qBP/Ta6nWw5zgHY7wO
   uxht3f21iVzM2zRE2HF+XTB0kLjYDqavCWV922jS2QsWv4hVOFaxHuI9x
   zrnm+Zor/mb823ThWFZ2DQC3qywiezsevJ7kC7EgQUNq2VAmY68R+j7ep
   jgl9wpUzNp9NTzLnZjCPBXM8dJfMpirxRb87eWHfFOJ4/bOzPd3aDPj6i
   bqn2CZ+hzqlni7TNCjD52haHS8d952ZXJafmyoC3Do2M45O1Y1hWIdSIM
   NeDBEApDVjuzfEemeiySMoydY+pV3qsQLBJHc3xBOznqRMu6Opg2bveqz
   A==;
X-CSE-ConnectionGUID: fS9bibfyS/+0az2oXJhB4A==
X-CSE-MsgGUID: 3JG50Uk6T9C5pTdHlaKeTw==
X-IronPort-AV: E=Sophos;i="6.23,113,1770620400"; 
   d="scan'208";a="221791544"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 08:28:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 11 Mar 2026 08:28:19 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 11 Mar 2026 08:28:18 -0700
Date: Wed, 11 Mar 2026 08:28:17 -0700
From: Charles Perry <charles.perry@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, <andrew@lunn.ch>,
	<conor@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<charles.perry@microchip.com>
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and
 configuration
Message-ID: <abGKEfPmxjyiNWer@bby-cbu-swbuild03.eng.microchip.com>
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
 <20260311140135.937544-1-geert+renesas@glider.be>
 <abF7g9kZk5-9YN5_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abF7g9kZk5-9YN5_@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266679-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,armlinux.org.uk:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:dkim,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: E66342669C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 02:26:11PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 11, 2026 at 03:01:35PM +0100, Geert Uytterhoeven wrote:
> > 	Hi Russell,
> > 
> > On Wed, 11 Mar 2026 at 01:07, Russell King <rmk@armlinux.org.uk> wrote:
> > > Add support for VSC8662 reporting its inband capabilities, and also
> > > hook to configure the PHY's inband mode.
> > >
> > > This fixes a regression in the macb driver caused by commit
> > > 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> > 
> > Fixes: 1338cfef1ff1b958 ("net: macb: fix SGMII with inband aneg disabled")
> > 
> > > Reported-by: Conor Dooley <conor@kernel.org>
> > > Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud
> > 
> > s/Link/Closes/
> 
> I avoided it because any other PHY used with macb that is also connected
> via SGMII will run into this same issue. It just happens that adding
> this support fixes the above commit.
> 
> Conversely, we have stmmac, which unconditionally enables SGMII inband
> at the MAC end no matter what phylink says to do, and should this
> PHY be used with this patch in a stmmac system, it will cause that to
> break, because we end up with either end misconfigured.
> 

macb also unconditionally activated inband aneg before I added the
->pcs_config() callback.

One of the way I think we could fix macb is by adding:

        if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
                bp->phylink_config.poll_fixed_state = true;
                bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
+               bp->phylink_config.default_an_inband = true;
        }

in macb_mii_probe(). This would force phylink into using inband aneg
every time, unless there's a fixed link or the PHY explicitly doesn't
support in-band. This would make it compatible with legacy system that were
setup with in-band aneg activated. It would fix MPFS without the need for
this patch or device-tree modifications ('managed = "in-band-status"').

Thanks,
Charles

> Also, if this commit is applied without the macb change, you'll
> probably also find that macb breaks (please test that.) 
> 
> So, while this is a solution and a step forward, I'd rather not suggest
> that it is an official fix to the macb issue - it's merely filling in
> a missing piece of the jigsaw.
> 
> Sadly, this is a fundamental issue with SGMII implementations today:
> whether SGMII inband is used/required is completely random both at the
> MAC/PCS end but also at the PHY end. If one ends up with a mismatch,
> then things stop working.
> 
> As I say, the problem with fixing the PHY end of the link is that
> it could cause a different network driver to regress.
> 
> So yes, this is a solution to the macb problem, but I regard it as
> high risk.
> 
> That said, given the SGMII mess, there is no easy way forward.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

