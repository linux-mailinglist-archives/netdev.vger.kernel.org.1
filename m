Return-Path: <netdev+bounces-150198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9ED9E9682
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C2D283A81
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA11ACEC9;
	Mon,  9 Dec 2024 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OkT4p3Zm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65D233126;
	Mon,  9 Dec 2024 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750240; cv=none; b=FHP/bjEbS4K8nV9dcz3vmA/+Du4w8aBgxv9eQ7m2YFvBRWODYKcmIBiXHCNT1trqC6DW+20JzEe4qIqWQ8UT0OHG5AyMzGoSj5lDgSJQ1/is6xE5dTWl8ErwxTX+I2hNWPiSmWnTQhjcqZNMwTgSf9XRsAqsBBHxHX/pAdR7+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750240; c=relaxed/simple;
	bh=GKJhHjDf9U7/zbeK+J4EKmPqyRYVBJdPoU3fNhpiUDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjrr/v2+JzOSNx1v8rpHDj/stQFINPVidwEGMhpK/yQJXEjs2vrkowYb+oOv2hDIrFh/9ZUlBE4c1b9XwhpoZGjjDPTgaCELhQ1wYrhmi8WF01TjOT625+pI8rM0d21TEOmW4uihRpMPbM14mIvAdmnobybBmk583U0qBm5ijNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OkT4p3Zm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a4aNZwKhoEpSgrOUmeaC/mbjjsWaCSSTRiNd1hwQtlU=; b=OkT4p3ZmfazAtxY0zHiUil2mce
	bVgOGW3Vffzh6CC7+X7tYBmDKZUtgAe+eCURF78RtEdSR7Z8VSthtd0FD8nbpueHZ81igEFvz03nA
	+EkK5DxQ/dqqboUdOC0U8Hr7PqvIlOm2PrszMDcalcyVHc2j9+OrR+NFqxWopql8xh+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKddI-00FfZp-CA; Mon, 09 Dec 2024 14:17:04 +0100
Date: Mon, 9 Dec 2024 14:17:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: dp83822: Add support for GPIO2
 clock output
Message-ID: <bcef90db-ca9d-4c52-9dc5-2f59ae858824@lunn.ch>
References: <20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com>
 <20241209-dp83822-gpio2-clk-out-v1-2-fd3c8af59ff5@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-dp83822-gpio2-clk-out-v1-2-fd3c8af59ff5@liebherr.com>

>  #define MII_DP83822_RCSR	0x17
>  #define MII_DP83822_RESET_CTRL	0x1f
>  #define MII_DP83822_GENCFG	0x465
> +#define MII_DP83822_IOCTRL2	0x463
>  #define MII_DP83822_SOR1	0x467

These are sorted, so the MII_DP83822_IOCTRL2 should go before
MII_DP83822_GENCFG.

> +	if (dp83822->set_gpio2_clk_out)
> +		phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83822_IOCTRL2,

I would of preferred MDIO_MMD_VEND2 rather than DP83822_DEVADDR, but
having just this one instance correct would look a bit odd.

> +	ret = of_property_read_u32(dev->of_node, "ti,gpio2-clk-out",
> +				   &dp83822->gpio2_clk_out);
> +	if (!ret) {
> +		dp83822->set_gpio2_clk_out = true;
> +		switch (dp83822->gpio2_clk_out) {
> +		case DP83822_CLK_SRC_MAC_IF:
> +			break;
> +		case DP83822_CLK_SRC_XI:
> +			break;
> +		case DP83822_CLK_SRC_INT_REF:
> +			break;
> +		case DP83822_CLK_SRC_RMII_MASTER_MODE_REF:
> +			break;
> +		case DP83822_CLK_SRC_FREE_RUNNING:
> +			break;
> +		case DP83822_CLK_SRC_RECOVERED:
> +			break;

You can list multiple case statements together, and have one break at
the end.

I would personally also only have:

> +		dp83822->set_gpio2_clk_out = true;

if validation passes, not that it really matters because:


> +		default:
> +			phydev_err(phydev, "ti,gpio2-clk-out value %u not valid\n",
> +				   dp83822->gpio2_clk_out);
> +			return -EINVAL;
> +		}
> +	}


    Andrew

---
pw-bot: cr

