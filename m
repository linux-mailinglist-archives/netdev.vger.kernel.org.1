Return-Path: <netdev+bounces-214307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F70B28EA9
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 16:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9515C5D32
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE72E2F0C64;
	Sat, 16 Aug 2025 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vQNOlyhe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF012F0691
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355957; cv=none; b=n/P1gam5UnmPPbSI+kc5/XGxMKrR8M6To8tDgoFaALv9ziz8C93Yyq1QjEjcGd/XH5QMFHi/QD2qV3dadU2byy0fCGFc3fmmfc0lmHzoJMivnWc4/3CladYOL0GITNr8CQtP4LY4xS20eCnKRhNRB/Go1yNb256j5oedugRTkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355957; c=relaxed/simple;
	bh=jYj5bB1YB8QwQuBjxQLgyaZaUJf9eNPSqWNbPatPG7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcoDEJ+PIqF425i+en7RdxBokyn7lUTiLM1fH6f3aILfctdqss/ejZCkvipY+LakVnC/7SXYHLSvnealnHeJbKIU6C68Q14vZ6mTka2oDFH1M2Fkt8UtvbLDtz5gdl5T3urhlR2hXnN+/CzMp7moIVtTJQ6xsq0bKi+T+8LC0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vQNOlyhe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z4uDRaYeQE40utPhu+9ME02DrjIdxi1EacK2YfZFaRg=; b=vQNOlyhefXt1jn9dphWOkuCEaw
	P/K1NkhcgYJOcyOBGQAaGvFX9pS7zKfgWLCQuOpBolQhoqoT5r06PYQDilP6+Ff1UdmpMIlIr/soW
	zPW/rVWHyt5p29OTQwsnp5ogqz6fQlsGiS0fKFEB6FwEnNQC84d5r5tprEJyYeb4pN98=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unIGf-004uOh-4C; Sat, 16 Aug 2025 16:52:25 +0200
Date: Sat, 16 Aug 2025 16:52:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [RFC] mdio demux multiplexer driver
Message-ID: <2391ae0e-bfb2-4370-aac3-563fc5e70cf9@lunn.ch>
References: <aJvjHrDM1U5_r1gq@xhacker>
 <5e3c5d70-f4fd-46db-90a1-e8be0ae5f750@lunn.ch>
 <aKAWe27bDtjBIkp-@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKAWe27bDtjBIkp-@xhacker>

> > So, why not KISS. Hard code the MMIO reg so MAC0 is connected to the
> > PHYs, and MAC1 just uses a phy-handle pointing to the PHYs on MAC0s
> > MDIO bus.
> 
> Previously, I went with this solution. But then I met an issue -- who
> does the harcoding? bootloader or linux kernel?

Linux. The bootloader can do it as well, e.g. for TFTP booting, but
Linux should not rely on the bootloader.

> Linux? This is what this email thread ask for comment -- How does
> linux model this?
> 
> Another issue is: the hardcoding maybe different on different boards.
> E.g If only MAC1 is used, we need to hardcode the MMIO reg to let
> MAC1 MDIO master own the single MDIO DATA and CLK line.

Both Ethernet and MDIO hardware exists, even if it is not used. I
would separate the drivers. Have a MAC driver and an MDIO driver. List
them as separate entities in DT. Always probe the MDIO0 driver. It can
set the MUX registers. Don't probe MDIO1 driver. Even if it does
probe, you know MDIO0 is one to be used, so MDIO1 can still set the
MUX to point to MDIO0.

How messy is the address space? Are the MDIO registers in the middle
of the MAC registers? Is this a standard, off the shelf MAC/MDIO IP?
stmmac? Or something currently without a driver? If you are dealing
with a driver which already exists, it gets a bit messy.

	Andrew

