Return-Path: <netdev+bounces-145006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79AC9C9188
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AAFB381E6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60918C028;
	Thu, 14 Nov 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="peRnfjav"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F5262A3;
	Thu, 14 Nov 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605899; cv=none; b=ofkYYb1JLhnAC2jEYeVy9TGs5+UJ5RN+4aeRL2g2j91MVybXX4y9wWj0Pwjnes0sR+KvpYVQ/PIGTRkp9Hb457l8ErKaKW4IEp+ZEQsqwHLIy2dblQ9/D0y5Gzldm+RjayACluSECY2QIZziJjnjHfMkCZ/HSVi3/Wjo3MpJHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605899; c=relaxed/simple;
	bh=wA6LYqVMtGvZCJ0h1057yxja1cF9UPo/rVFctUswHaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCB4fUw9xhNBLU3qZ4ArwJPH5NlPHDxdmI9+BrImL+2K1+K9t0G5UdoZ3eIMUst8cGaPU5e5Nsx2r3apr0ZhQhKl0Paa/7Gm6ENPVc2OiEzeG/PSREHXDlyUc2b4HrcvVf/EKQjLUsUeLdhz58wBZXwY8U51s6ioMugxUYRoQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=peRnfjav; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CasxijWNS3J9QS+VuXQjZR02baqSbw5G8OFqE7xIXEc=; b=peRnfjav3IOzH3EBahcEA3x01k
	qBfwOZfp0OC/pgbW2WVwJdTC9TN7/ybHi5BmFw2ouH7AREoLKYLaQfCHPvuIqt+LLG81eFz1O5/sd
	7jYUU5NwPU1TXhyPqB32bK4jwn2RL0LR3IoNle9NqhiygVdtq9+PJCwEAGDy9Zo5lcP4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBdnJ-00DKNj-K0; Thu, 14 Nov 2024 18:38:13 +0100
Date: Thu, 14 Nov 2024 18:38:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: Re: [PATCH net-next] net: phylink: improve phylink_sfp_config_phy()
 error message with empty supported
Message-ID: <54332f43-7811-426a-a756-61d63b54c725@lunn.ch>
References: <20241114165348.2445021-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114165348.2445021-1-vladimir.oltean@nxp.com>

> [   64.738270] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 (id 0x01410cc2) supports no link modes. Maybe its specific PHY driver not loaded?
> [   64.769731] sfp sfp: sfp_add_phy failed: -EINVAL
> 
> Of course, there may be other reasons due to which phydev->supported is
> empty, thus the use of the word "maybe", but I think the lack of a
> driver would be the most common.

I think this is useful.

I only have a minor nitpick, maybe in the commit message mention which
PHY drivers are typically used by SFPs, to point somebody who gets
this message in the right direction. The Marvell driver is one. at803x
i think is also used. Are then any others?

	Andrew


