Return-Path: <netdev+bounces-214691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D666BB2AE1D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7458816550E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212D631B101;
	Mon, 18 Aug 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vMSZ++Ep"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D423376BA
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534464; cv=none; b=nkcrcOzGNaImUVpmvuu5W8zz+JhyYVSFFy+XMYoXZ11J6ZQ8OnjOHySvtRwsBzoTHE3ctPO+PZJunagh2CQMWmscfOTn2qkK6ZH1KQgrRdM/nITA8JE6j8E15ROPxHf97jZx1al8sDDjYUNwWaFrHOVBrPZNUCzzvPemBajSiGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534464; c=relaxed/simple;
	bh=LFf6NxPjamoOT2maObygLAoOuIhst/mH41mOFrkGW0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/mAqFuU9AOyhxgj8P26ZgHXHYzyvYT5muCLfqDfdqU5er6ZdalTHnJZ6UjERbRWW3CXW4v20IOnRz+p2yp6scReYykrBAc0WYP/mEdHAhFDFVucmsS5nQTR8V/08NtOoliq18SU7T62VTs08+NfP/P40y2vxjlvZwcYYDtOiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vMSZ++Ep; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nmdhPt0x8H+50/xtsuGWicFyWYQNbACI5trBmFIysys=; b=vMSZ++Ep2759GwiP6pI7lFTwWq
	b9DUA7b5yfHlbi+cWWdfkViYmsQXxyRGAznQ1X98bjFbvxBk6v0t+jymxfwEYDGoLTONdnsbtFHfU
	zA9P5CKVfoSdmOxF/EAGgcKhOa+ZFNNS8McZm045fnS5EJyujWx/fTgEZyOZvIN8mdwo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uo2hp-005564-Hu; Mon, 18 Aug 2025 18:27:33 +0200
Date: Mon, 18 Aug 2025 18:27:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [RFC] mdio demux multiplexer driver
Message-ID: <c40dd405-9549-40c9-8cfd-88dd0b1342da@lunn.ch>
References: <aJvjHrDM1U5_r1gq@xhacker>
 <5e3c5d70-f4fd-46db-90a1-e8be0ae5f750@lunn.ch>
 <aKAWe27bDtjBIkp-@xhacker>
 <2391ae0e-bfb2-4370-aac3-563fc5e70cf9@lunn.ch>
 <aKNJN4sBfi_YAjrF@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKNJN4sBfi_YAjrF@xhacker>

> > Both Ethernet and MDIO hardware exists, even if it is not used. I
> > would separate the drivers. Have a MAC driver and an MDIO driver. List
> > them as separate entities in DT. Always probe the MDIO0 driver. It can
> > set the MUX registers. Don't probe MDIO1 driver. Even if it does
> > probe, you know MDIO0 is one to be used, so MDIO1 can still set the
> > MUX to point to MDIO0.
> > 
> > How messy is the address space? Are the MDIO registers in the middle
> > of the MAC registers? Is this a standard, off the shelf MAC/MDIO IP?
> > stmmac? Or something currently without a driver? If you are dealing
> 
> stmmac :(  And the MMIO reg doesn't sit together with MAC IP's.
> As can be seen, the stmmac mdio registers sit in the middle of the
> MAC regs. And current stmmac still tries to register a mdio driver for
> the MDIO bus master. And to be honest, it's not the stmmac make things
> messy, but the two MDIO masters sharing the single clk and data lines
> makes the mess. Modeling the mmio as a demux seems a just so so but
> not perfect solution.

So you only really have problems when MAC0 is not used. Are there any
boards actually designed that way? If there are no such boards at the
moment, you can delay handling that until later.

When later arrives, i would probably look at refactoring the stmmac
MDIO code into a library. The stmmac driver can use the library, and
you can add a new MDIO only driver around the library for when MAC0 is
not used, but you need the MDIO bus.

For the moment, you can add setting the MUX register in the stmmac
glue driver.

	Andrew

