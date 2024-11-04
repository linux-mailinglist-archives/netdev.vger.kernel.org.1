Return-Path: <netdev+bounces-141570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A979BB710
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 15:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4101F237B5
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248321419A9;
	Mon,  4 Nov 2024 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gmfDpAFP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2313D53B;
	Mon,  4 Nov 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729053; cv=none; b=gam/Hj2Uv+0v1tG/RumS3MTuKiP4m4hJUNCGm4VffO/qV+Vs3oYJuKqHHzAYXdlQIKAeRYZ8c3cn5VEwquoj/2OWzSfIoXgZzJDaf8ChUhFjS79rHqLECfs/NCpx78mvMgdJuw1cOiwhh03YBbGW3A2wmiSEnCwB+nujVropY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729053; c=relaxed/simple;
	bh=LyMFx2QKI0twBLmeqWtpdBmRiO9HVWv9pkWWBjxTsGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWXsk61YxPYUxf37j036NsbXBNmqkXxZMtqzvndMeypT7NC+OHeQInvEXfZVlyH2kuzwEHP4b9dkF5Os6nmYp6cIbFJr0UfNXp1BCjqD7/oZxTLCc4NGJkumvVMoNH6FDPE8L6q7EW/jE/DR9Nz3IvipWVQLprDLl6ay7JqFUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gmfDpAFP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3lIsEGZ1nidjl2PfS5R09QT9r8royoyR/R2u635wXKs=; b=gmfDpAFP8UwJrfs8/+DO4LrWcv
	U4x6uQ22ZzJA6asWTdukM8dDp2PfelScuy4soFxslRGDvXfo7f+Lkr5ehwtayYz0KgEF+Yod/aTSL
	1LmBEuD9uCFrgVlxafsTV4FDiA8DA8g2+6IFHGSAxy2cU8VntTtceh4lybQwt03AeiKo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7xgY-00C6t8-3p; Mon, 04 Nov 2024 15:04:02 +0100
Date: Mon, 4 Nov 2024 15:04:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com
Subject: Re: [PATCH net-next 5/5] net: phy: microchip_t1 : Add initialization
 of ptp for lan887x
Message-ID: <8c585168-20b0-4abe-b4f2-0d0949627bfe@lunn.ch>
References: <20241104090750.12942-1-divya.koppera@microchip.com>
 <20241104090750.12942-6-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104090750.12942-6-divya.koppera@microchip.com>

>  static int lan937x_dsp_workaround(struct phy_device *phydev, u16 ereg, u8 bank)
> @@ -1472,6 +1478,12 @@ static int lan887x_probe(struct phy_device *phydev)
>  
>  	phydev->priv = priv;
>  
> +	priv->clock = mchp_ptp_probe(phydev, MDIO_MMD_VEND1,
> +				     MCHP_PTP_LTC_BASE_ADDR,
> +				     MCHP_PTP_PORT_BASE_ADDR);

In general, PHY interrupts are optional, since phylib will poll the
PHY once per second for changes in link etc. Does mchp_ptp_probe() do
the right thing if the PHY does not have an interrupt?

	Andrew

