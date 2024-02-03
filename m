Return-Path: <netdev+bounces-68840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51B8487BA
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 17:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF0E1C232C7
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F99755E70;
	Sat,  3 Feb 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="57mLMQyQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484255FB99
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979390; cv=none; b=j5sDG2msmePDpW5VaZUkd38bFwKYXMCr494OBUnrHioBPjp9VIcKZQpqn+Hjf5hdns7cooLPjsS4Ww87thu3YyIQEFYZve/JrALSgycgASRHl0BWGqp/8qD0HgbIgILScqiPggBdiI6RkWO5wy3PBgb2XTBvf0V/LA30CgCKLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979390; c=relaxed/simple;
	bh=SzQpbY8VLYEJty6fjARCBeVaWt0SI1T2MbHbJQ60oLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moX402+TxCVbFIM+AehM8k+7JGhUCzWXy3mvnKCMcTmUG4TuD81Kyeidmxv+VoYkiVtmhFEathKHDveuL0xgBzLN7K+ZeIVwAqGwN5AKDQ1jYGMKmrWxlr6RsOtbeTn2YBOpt01NeHQudROr08Z8Y4iSDaDTaBE4niaQgCWFEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=57mLMQyQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B78RQyEIM6heqEjaa2OQQ0G7q0W1kkXNorkRo/wMJfA=; b=57mLMQyQ45UWczHzXzOrkx57kD
	2jzJqzRn6nb9yqg5wCTGL/LhsRHyxnyE/XMzrjbb9Sf3VLz/S336+grwMkbQROlj6tRCBLy6Wix/L
	mgq1e8fbNARTzRfiAS8kDTkSKOU4pETuKhTE+b35l+mv6qJk0jPnz9eKWOGfkYrxjdjw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWJJT-006unu-6s; Sat, 03 Feb 2024 17:56:19 +0100
Date: Sat, 3 Feb 2024 17:56:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: constify phydev->drv
Message-ID: <7f4f7fc2-6bf3-4ecb-9c13-763e2d4f176f@lunn.ch>
References: <E1rVxXt-002YqY-9G@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rVxXt-002YqY-9G@rmk-PC.armlinux.org.uk>

On Fri, Feb 02, 2024 at 05:41:45PM +0000, Russell King (Oracle) wrote:
> Device driver structures are shared between all devices that they
> match, and thus nothing should never write to the device driver

nothing should never ???

I guess the never should be ever?

> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index 7fd9fe6a602b..7b1bc5fcef9b 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -22,7 +22,7 @@
>  
>  struct gmii2rgmii {
>  	struct phy_device *phy_dev;
> -	struct phy_driver *phy_drv;
> +	const struct phy_driver *phy_drv;
>  	struct phy_driver conv_phy_drv;
>  	struct mdio_device *mdio;
>  };

Did you build testing include xilinx_gmii2rgmii.c ? It does funky
things with phy_driver structures.

Thanks
	Andrew

