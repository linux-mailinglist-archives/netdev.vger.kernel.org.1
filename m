Return-Path: <netdev+bounces-214263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D2B28AB9
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED741C8079D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215C1EB5FE;
	Sat, 16 Aug 2025 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJpYCbTn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97E1EA7E9
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755323012; cv=none; b=rO4hIKPzA4hjav7B3pAuzHC5UAf+aFL8cNqFpIF5vrzRi4Xs5AqyVxel6Jf8gAQu6DKiu/TVz0230hTSexWkB1tNIz4fxNMVCB+wle9xhFiLuh1qT04Qd66bZc7V4VYVnyyBRcfayjUB3dPJfiwnfOHXzcI1GvihvlY13vf7Vq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755323012; c=relaxed/simple;
	bh=QRkMRV40ctikF8zGxJ4/06a4E3tGkISOfutLAj9R/PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9pFQaUChTLjpT8adwqNsOU1ReZozdZhryA8YO3vQGaIj8+I36nwByBDb+GeuGa5Ny/ijBsMUrZzgk5ymllY+SyItERanAEQABvN5m7r7eZWhOwT0sN+uwQILAovDIEPtvdB8JMAhWmt9sY0jW5ZQZ82/Brls0V56+FfrIChVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJpYCbTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EF7C4CEEF;
	Sat, 16 Aug 2025 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755323011;
	bh=QRkMRV40ctikF8zGxJ4/06a4E3tGkISOfutLAj9R/PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJpYCbTn7Hi2BXawjP+giHBqPXjCncNHbpsjpQnhQEa0v3wsSxrediXMUHeORauTa
	 CUvvvcKIApUayitLwqU41Y4Iolmu6doffzqP4e2t+pYyrlnSoo7lkg4VA4efLgFFvr
	 PeweAvCsgEQEEPzal8Wi/Ry54h2p76V4ucC6+TxrfE5VvuMrlvlj5CoBQTm+06jccj
	 7q2/hmdMQszLALG9uFwXzS8NRbj6baL1N1iEqmemBz8jUwuDNALOcHEp59yjdxC/vn
	 WJwhgybUG2utpal/IunHSMqiudllB5Ef+d5RumCDYERi0OJC7AdZ2aV9g2AnQwAbYf
	 1ce9mMwZY7QCg==
Date: Sat, 16 Aug 2025 13:26:19 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [RFC] mdio demux multiplexer driver
Message-ID: <aKAWe27bDtjBIkp-@xhacker>
References: <aJvjHrDM1U5_r1gq@xhacker>
 <5e3c5d70-f4fd-46db-90a1-e8be0ae5f750@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e3c5d70-f4fd-46db-90a1-e8be0ae5f750@lunn.ch>

On Fri, Aug 15, 2025 at 05:51:41AM +0200, Andrew Lunn wrote:
> On Wed, Aug 13, 2025 at 08:58:06AM +0800, Jisheng Zhang wrote:
> > Hi,
> > 
> > Assume we have the following implementation:
> >           ----------
> >           |mmio reg|
> > 	  ----------
> >              |
> >  --------    |      -------
> >  | MAC0 |--MDIO-----| PHY |
> >  -------- |     |   -------
> >           |     |
> >  -------- |     |   -------
> >  | MAC1 |--     ----| PHY |
> >  --------           -------
> > 
> > Both MAC0 and MAC1 have MDIO bus masters, and tie together to
> > a single set of clock and data lines, which go to some PHYs. While
> > there's a mmio reg to control which MAC mdio master can operate
> > the single mdio clock and data lines, so only one MAC can operate
> > the mdio clock and data lines.
> 
> Where is the SoC boundary? Are the PHYs all external? So there is a
> single MDIO bus connected to the outside word? And all the PHYs are on
> that external MDIO bus?

Hi Andrew,

Thank you very much for the comments.

Yep, only one single MDIO bus connected to outside world, all the PHYs
are external and soldered on the board.

> 
> > We also need to fully support three use cases: only MAC0 + PHY is used
> > on board; only MAC1 + PHY is used on board; MAC0 + MAC1 + PHYs are
> > all used.
> 
> Linux does not care where a PHY is connected. A PHY is on "some" MDIO
> bus. It could be one associated to the MAC, it could be on the MDIO
> bus of some other MAC, it could be a GPIO bit banging MDIO bus. It
> could be an MDIO bus on its own, not associated to anything. The MAC
> DT node has phy-handle pointing to wherever the PHY is.
> 
> So, why not KISS. Hard code the MMIO reg so MAC0 is connected to the
> PHYs, and MAC1 just uses a phy-handle pointing to the PHYs on MAC0s
> MDIO bus.

Previously, I went with this solution. But then I met an issue -- who
does the harcoding? bootloader or linux kernel?

Bootloader? Bootloader guys says bootloader only needs to setup linux
bootenv such as DDR, necessary plls/clks, then read kernel Image from
external storage to memory and jump to it. mdio demux setting? No,
it's OS responsibility to setup it.

Linux? This is what this email thread ask for comment -- How does
linux model this?

Another issue is: the hardcoding maybe different on different boards.
E.g If only MAC1 is used, we need to hardcode the MMIO reg to let
MAC1 MDIO master own the single MDIO DATA and CLK line.

Thanks

