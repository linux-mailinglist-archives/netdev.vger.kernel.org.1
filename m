Return-Path: <netdev+bounces-161627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B42A22C16
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 12:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429C51889C56
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C741AF0C0;
	Thu, 30 Jan 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JpCgtFab"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD3A1A7046;
	Thu, 30 Jan 2025 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234940; cv=none; b=Ak4+J2LWdTLT8IemIEgPdrd5NxCLTNcWy75ElvkkHsryTiBfDJvFETgNGjaLJNsdw2R8EQ4F1Gm8kcsJfGAlOna60R7CZXQd+OJrQl6P3txBOxLCEKOKHcAoXtD9OOHDg8erLDP/YxjAeCGDbtQahIEv4jBClX5yBzzc5t6Kwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234940; c=relaxed/simple;
	bh=ZJ4Au8Mg9sPlCFvEnFwYT2LF41h6Pc6kSA6z0zcWBs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbt7GGN1XXpPOSEw0wE9bt8/U5zM3PDWIr+0MX6zc8znNKgMBKQ/s0ulnfDdo10pGJl6/AiabS/sqmU9VMNU5eVd3k9dPE6uDY6NQZefLCcQHb+1+UjFOda9JlEc0xapVSNavhibC88uH0HXy0kQiH/5F+L1CrFLhrbsmPTnd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JpCgtFab; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r9T7SsDgb25eRiBbyZrxPqt2XzRSnj1KTaKT0+NeJB0=; b=JpCgtFabWJwZyXwJqR5xJVgTay
	4p1ryuXp+TtjVWOJ0NY6NBry21ufA+1WGDIoaQYlK7FawWBmLwXVqFZSMnur9HwQ+XomyfhTErmjN
	VG7/HZNxnyLMWQ/mlEwOB9Fi8hf8MoX97brcL73vtR7vwz82BU3KDl/v52PtpehEqJIncF1uKnPvs
	LZ7jdNT5ifKFpdfqIzD1mGl/bjjXWKkdWKJxw2Mh6FvaKBat7STLeD3m7MpEZWbMgkZEpzIKfvtnO
	Kw/KeCpq4DxQjvmoa5Fxfn1iZw4N7f/BtDmFcOyPyNW3mWVLZI6+uTDByzF2JRBdnUqR8Lv/1l9ne
	V084bXGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36634)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tdSJA-0003wU-1U;
	Thu, 30 Jan 2025 11:02:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tdSJ6-0004h9-31;
	Thu, 30 Jan 2025 11:02:00 +0000
Date: Thu, 30 Jan 2025 11:02:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Tristram.Ha@microchip.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Message-ID: <Z5tcKFLRPcBkaw58@shell.armlinux.org.uk>
References: <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250130100227.isffoveezoqk5jpw@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130100227.isffoveezoqk5jpw@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 30, 2025 at 12:02:27PM +0200, Vladimir Oltean wrote:
> On Thu, Jan 30, 2025 at 04:50:18AM +0000, Tristram.Ha@microchip.com wrote:
> > This behavior only occurs in KSZ9477 with old IP and so may not reflect
> > in current specs.  If neg_mode can be set in certain way that disables
> > auto-negotiation in 1000BASEX mode but enables auto-negotiation in SGMII
> > mode then this setting is not required.
> 
> I see that the KSZ9477 documentation specifies that these bits "must be
> set to 1 when operating in SerDes mode", but gives no explanation whatsoever,
> and gives the description of the bits that matches what I see in the
> XPCS data book (which suggests they would not be needed for 1000Base-X,
> just for SGMII PHY role).

Hi Jose,

Can you help resolve this please?

Essentially, the KSZ9477 integration of the XPCS hardware used an old
version of XPCS (we don't know how old). The KSZ9477 documentation
states that in the AN control register (0x1f8001), buts 4 and 3 must
be set when operating in "SerDes" mode (aka 1000base-X).

See page 223 of
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/KSZ9477S-Data-Sheet-DS00002392C.pdf

Is this something which the older XPCS hardware version requires?

Would it be safe to set these two bits with newer XPCS hardware when
programming it for 1000base-X mode, even though documentation e.g.
for SJA1105 suggests that these bits do not apply when operating in
1000base-X mode?

Many thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

