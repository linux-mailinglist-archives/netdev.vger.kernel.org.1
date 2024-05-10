Return-Path: <netdev+bounces-95587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313518C2B3B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73A91F25BF5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 20:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34153482FE;
	Fri, 10 May 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0l9o2tlp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99797288D1
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373486; cv=none; b=BJ8Hh6lmiQbmKbeU1oYAzY+sUQ8150H7QgWwHAF6eHIrC0mDQ1JWHPhAlGMt3Rogc+9vzuvFeeImoOzB405/oOYZeUzaY4OTenY+1po3TSmW90/NW+497q+wdCCQb7+vRcpYNGu5gs7uhuY6+LJfkG3aVM469LOFyobGSSIM42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373486; c=relaxed/simple;
	bh=Gav7mEC0W3lAe2LFSa8b9Mnyh1uHn54Sdxvb9atfogk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS1Wj5YDq86NWw4yImZsDRhivuGw5cxZ5clkshiGc62I/PSnAcSVyJwkiF6z2xZ31s2X8B5Nr59cPxC/LeM5Aicz6UF5A8iTZX8J+reUGrZXk8Z4AIkQa0sDNFPKMjxEJ1XGWacajkNf5iIGnLjb7E9YucKzt96geH6BkPgwfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0l9o2tlp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WKt0LYmtv2vR+tDj7SEqbOiU2hvfIVFZ7m79y7brpA8=; b=0l9o2tlpLSojDgt3AP9l1wYhcU
	pcPD5PyNQB3xJhrgWmg1mrXrmc4RuYfmvMFa2M6h7HBNTxol1GinWcEZPcnjNdxUrucil+adP/7ss
	P9wADlb4QdiyLa6tpLnn41gKXXYDCTXPpvHMsyFwQe3iBkvtHGPgqXHCBKIG1Uqhul/U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5X0B-00FA8t-OB; Fri, 10 May 2024 22:37:59 +0200
Date: Fri, 10 May 2024 22:37:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Dutton <james.dutton@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: SFP and SFP+
Message-ID: <d1cd49e5-c2e4-4457-ad47-eb10e7044284@lunn.ch>
References: <CAAMvbhHpj+HzmxnGfj_dKFq6nmnAr2C9v__1Ptkd19bnPCxd1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhHpj+HzmxnGfj_dKFq6nmnAr2C9v__1Ptkd19bnPCxd1w@mail.gmail.com>

On Fri, May 10, 2024 at 03:10:06PM +0100, James Dutton wrote:
> Hi,
> 
> Linux kernel handling of SFP and SFP+ Ethernet transceivers does not
> seem to be very reliable.
> I.e. Very few SFP / SFP+ transceivers actually work in Linux, even if
> they work in a COTS network switch.
> For example, there are more and more Wireless access points appearing
> with SFP/SFP+ ports and run the Linux kernel.
> I think the main stumbling point is that the SFP/SFP+ quirks are based
> on the Name fields of the transceiver.
> I have seen two different SFP+ transceivers with exactly the same
> name, one supporting ROLLBALL and C46 and one supporting neither.
> Maybe it would be more reliable if one first assumed that the SFP does
> not do negotiation, C22, C46, ROLLBALL protocols and instead only
> reports link up / link down. One then implements methods to detect
> whether the transceiver does anything more feature rich, such as
> support for C22, C46 or ROLLBALL and if so, then uses those also.
> It seems like a majority of the problem ones are the ones that have
> one rate for the SERDES and another rate for the Link itself, with the
> transceiver doing rate adaption. This is most common for the RJ45
> SFP/SFP+ transceivers in the 10/100/1000/10000 speed range.
> It might also be helpful to report with ethtool the PHY Link rate as
> well as the SERDES rate and also report the link status of the PHY
> Link and SERDES link separately.
> 
> What is the view of people more expert than me on this list?

First step would be to Cc: the SFP Maintainer:

SFF/SFP/SFP+ MODULE SUPPORT
M:      Russell King <linux@armlinux.org.uk>
L:      netdev@vger.kernel.org
S:      Maintained
F:      Documentation/devicetree/bindings/net/sff,sfp.yaml
F:      drivers/net/phy/phylink.c
F:      drivers/net/phy/sfp*
F:      include/linux/mdio/mdio-i2c.h
F:      include/linux/phylink.h
F:      include/linux/sfp.h
K:      phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)

Also, do you mean C45 instead of C46?

One part of the problem is that BaseT is simply not defined for
SFPs. Hence OEMs are doing whatever they want when it comes to
allowing access to the PHYs, and trying to make it as hard as possible
for interoperability, since they want vendor lock-in. So maybe you
should also be reaching out the people who write the multi-source
agreement and ask them to write a document about this?

	Andrew

