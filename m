Return-Path: <netdev+bounces-181985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE80BA873F8
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 23:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0D33AAC2E
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A81E5711;
	Sun, 13 Apr 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oSfh+knY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C727466
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744578585; cv=none; b=S/I/AFt374pW8Oo2zZbMWumZ+0T9pA4Ngii5IBM0oTIvgJ9hSxJY31MlchnAltaf5Vria7F/r80u1XdktyPKus7bryuRFoITsnykXKcSFVRH1yk47JT7iJhvZ8Hl5hBqEpHmQm84KTk9exkSMKgctGnIqu9h0MRGOPhh22EW4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744578585; c=relaxed/simple;
	bh=ct6oQgiEi4kuRjZiPFUcCJ9HtEqIt6FbPPWtsObiYgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfZiouVGtstg+JxkKTaX+gDBzEzKvOFCljbbQJV9BeUFEgeRrC8IK8YwnmsDlUpu0rsn2bLHKyGtFRCwYpYZ4/j6RUVZ616Diji+C1YkPdP3m6SxDpRnHABZkdNSBh6eR+5Q1QFkeL95idQmyGtWc1OSHkJTLxNGCKu5y4rRaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oSfh+knY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UfX9FuNz/xoujw3pgB2m7ZmTW064Rlef0hhXLoTluGo=; b=oSfh+knYqeFyoNjFEmu20gUUvP
	S6iIN9hcNRD58S4Zokevy47Hvuo33kNtH6IxEZWR65neVd5VDFisTm/Q1lFhocIdv2Fs8iYVWcISq
	TmrA+6slPl/PgBoBYw4xdZnlM+uFdZ9RqBRbpRb8W0Z4errNL3LkGfPLBqlLxA8GcCJA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u44a2-0096Lr-8v; Sun, 13 Apr 2025 23:09:30 +0200
Date: Sun, 13 Apr 2025 23:09:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/4] net: stmmac: anarion: clean up interface
 parsing
Message-ID: <a5d370d0-2f21-4f7c-92a3-922e17fe81ff@lunn.ch>
References: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
 <E1u3bfK-000Elr-Fa@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u3bfK-000Elr-Fa@rmk-PC.armlinux.org.uk>

On Sat, Apr 12, 2025 at 03:17:02PM +0100, Russell King (Oracle) wrote:
> anarion_config_dt() used a switch statement to check for the RGMII
> modes, complete with an unnecessary "fallthrough", and also printed
> the numerical value of the PHY interface mode on error. Clean this
> up using the phy_interface_mode_is_rgmii() helper, and print the
> English version of the PHY interface mode on error.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

