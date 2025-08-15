Return-Path: <netdev+bounces-213951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E9B27727
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E022A1C86770
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8877A1E7C34;
	Fri, 15 Aug 2025 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oFoweUYT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467D14A8B
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229910; cv=none; b=oZcLYxzpSfnQbl89QqxfMtP1ONAAK9v9N0mItBEmE62kz4DN7SLyaCaimbC8Rq6vv5krN0s+KGxo/1MQThZfSyI5IQhngESd4IdgEtJJCOYy17uiREHo3c0xZ5CKkkf4JAuK/AQAknlDQfTD8Fz7Q30tdZeYpHc6fzE8U7KwINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229910; c=relaxed/simple;
	bh=lCyGlVKmCOjk7f56pqxqPVgg0jnQiMWkmN6E48qTXp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP35nlFMN1HHMmiKn6r3UdtUS0YWPvhTJxBN0Wmv0k9aeuEKn+B6RFJBcQmp/FKKxtEIeOJVPaseCUAvwHcqGrDednkWYQC80UrjaNLxaX3hLEUVUUH90Zb+87tnNaX5A86S+CyC/A3vXNqGVqnB9s4PY/E1J3Etz0l+VbvKDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oFoweUYT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tOPtYXWMWRS5zdDxhWYlBxMaTsZl0GBGGnftC1GYGFo=; b=oFoweUYT0oT7MUTZPbtPcP4C93
	SCSyeurjHo9q0q9PI/OR95Y1GqcI3nQQlxBiJukmkpcwyzUocpzF0kRDPACwVowBS/CFiEgbYYFpd
	9ZXx6D0BmzCpeFCwfzj+z6KfC5LPWKNHDiyOLyCbZYpwYmEeNvc5sDFGfxJskp2ESZG0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umlTh-004mcA-OJ; Fri, 15 Aug 2025 05:51:41 +0200
Date: Fri, 15 Aug 2025 05:51:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [RFC] mdio demux multiplexer driver
Message-ID: <5e3c5d70-f4fd-46db-90a1-e8be0ae5f750@lunn.ch>
References: <aJvjHrDM1U5_r1gq@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJvjHrDM1U5_r1gq@xhacker>

On Wed, Aug 13, 2025 at 08:58:06AM +0800, Jisheng Zhang wrote:
> Hi,
> 
> Assume we have the following implementation:
>           ----------
>           |mmio reg|
> 	  ----------
>              |
>  --------    |      -------
>  | MAC0 |--MDIO-----| PHY |
>  -------- |     |   -------
>           |     |
>  -------- |     |   -------
>  | MAC1 |--     ----| PHY |
>  --------           -------
> 
> Both MAC0 and MAC1 have MDIO bus masters, and tie together to
> a single set of clock and data lines, which go to some PHYs. While
> there's a mmio reg to control which MAC mdio master can operate
> the single mdio clock and data lines, so only one MAC can operate
> the mdio clock and data lines.

Where is the SoC boundary? Are the PHYs all external? So there is a
single MDIO bus connected to the outside word? And all the PHYs are on
that external MDIO bus?

> We also need to fully support three use cases: only MAC0 + PHY is used
> on board; only MAC1 + PHY is used on board; MAC0 + MAC1 + PHYs are
> all used.

Linux does not care where a PHY is connected. A PHY is on "some" MDIO
bus. It could be one associated to the MAC, it could be on the MDIO
bus of some other MAC, it could be a GPIO bit banging MDIO bus. It
could be an MDIO bus on its own, not associated to anything. The MAC
DT node has phy-handle pointing to wherever the PHY is.

So, why not KISS. Hard code the MMIO reg so MAC0 is connected to the
PHYs, and MAC1 just uses a phy-handle pointing to the PHYs on MAC0s
MDIO bus.

	Andrew

