Return-Path: <netdev+bounces-190801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CCAAB8E31
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3343B2AC8
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EC8256C9C;
	Thu, 15 May 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R+kuwNEm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53731F0E4B;
	Thu, 15 May 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331664; cv=none; b=W6IKZEFu08uQ6W+kVCnJ+YElh++EIokp50DuLedKrZ5fYk1MyTofr308kxRapO5IA+CHxPXdLgBTz8PIkVNQ2L3s+b9lHWxH9NTpzdGMzHItacvYtVeDFFg9+QQGZ+xJoHZLHt2O9I8RyL5QBrbZdWp0xLk++S3UDaW6LJ/fujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331664; c=relaxed/simple;
	bh=JLxg1oheMn051dMKnaAnZ83gN3e5c07HHF1K/TwVfFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slJoHgH1POCuaSO3ORti4W/6shOiVsLpjGq7BXNfT6/vvoSGpshV4WkBB1OE0wb9xpMw0jt9VP6H5wKagnVhjBgzKS/wHVLTk/2faxbqXw0FrxW4wsEfhweSRrAlVVmymEA+oFU7A4EgJ2z68zPdHHOxYkcRYIXaNg2xbA81204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R+kuwNEm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+rtEL9ES9E/vaBtQVIRks4g8yUpYEnjeXDkfQGUAcrQ=; b=R+kuwNEmMe5d+6jnjjotCXTn7T
	rMx2Od8O4jeKgt/IIUYBqM4UBDJ78FtSXx2cMLFh1W7uokrysvl+pK6X+VT9tpxcVHsFb+anhxgIH
	W8FWdcDY+HVLs98m2T2Ehye5dGdMIxv3gG0W5XtfAPP60YWWORKPDj9Ok9/W4PEYEmQg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFcmg-00Cgpd-QP; Thu, 15 May 2025 19:54:18 +0200
Date: Thu, 15 May 2025 19:54:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: Re: [PATCH] net: phy: add driver for MaxLinear MxL86110 PHY
Message-ID: <4a6a692f-c6dc-4736-b4b6-b329715d5b96@lunn.ch>
References: <20250515152432.77835-1-stefano.radaelli21@gmail.com>
 <2b2ef0bd-6491-41a0-b2e1-81e2b83167ef@lunn.ch>
 <CAK+owogXdnvoiVNBn_6uBZgqoHrkiQmVU58ip1Wqd6v8VX5f6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+owogXdnvoiVNBn_6uBZgqoHrkiQmVU58ip1Wqd6v8VX5f6A@mail.gmail.com>

> > So does the value 1 here mean 8ns? 0 would be 2ns?
> 
> Setting RXDLY_ENABLE = 1 enables the internal fixed RX_CLK delay
> provided by the PHY, but the actual delay value depends on the
> RX clock frequency: approximately 2 ns at 125 MHz, and ~8 ns at 25 or 2.5 MHz.
> I'm not explicitly selecting 2 or 8 ns, it's applied automatically by the PHY
> based on clock rate.
> 
> Since this delay is additive with the configurable digital RX delay
> set in `CFG1_REG`, I only configure 150 ps in the digital field to
> avoid over-delaying.
> That said, if you prefer, I can disable `RXDLY_ENABLE` and set to 1950 ps
> directly in the digital delay field. Just let me know what you'd prefer here.

Setting only the explicit 1950ps is much easier to understand. Please
do that.

	Andrew

