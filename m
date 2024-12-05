Return-Path: <netdev+bounces-149495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B289E5C9C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226ED281ED1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5912224AFA;
	Thu,  5 Dec 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTNF6XXq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB9221475;
	Thu,  5 Dec 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418728; cv=none; b=UlZprN4BJigP2fPG6QYiW0h9gRhbtM/owMy6R2O/N7lJNAD51pgdZXA8l3awZESKAFVBMGV5qdgfOEMDbmi1LDeUJCQGptsAcpCxitCeDHdxzn0up7wkC47isfXYTVU8BULW7HPrjOBT7m+ffu26YjVcmt17mNMkyNDGNDvVICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418728; c=relaxed/simple;
	bh=rRwtsTd/2jg22s9kHbgwGu+T4KqT1qXWp/uJhMpyJOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6dkyEiMDuwBZxcDQmDAyzs0lswOBNdREa3KLLvyTGOZa+e89jIO7w4vN0sESaOzYwxQQRcKYBLfq6YN7GIatBOrQgnIsu/2OXnvfWanbK1rK1pqHNdISRICya3SHuHphl810zZqD+hzOpWqfKvDo1LXIiJBxp7kpmjt4YSrirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTNF6XXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B62C4CED1;
	Thu,  5 Dec 2024 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733418728;
	bh=rRwtsTd/2jg22s9kHbgwGu+T4KqT1qXWp/uJhMpyJOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTNF6XXqqUDGU2L+aNI9XdWv+RDALoORwOEuvBeBtHsXaVLP7Gi6XqpTpSo7gxfmy
	 rLH/pKjYwhiN0+U7SF/UQt5+Fv7Kdr6q5TWxTYBc+WbOhieg6piRJgANNM1817TdHY
	 Vof7/U+StobxDLexPTL4QUtiiafomgEmzX7xHkp56msSf8Gm0ziNuwHkbnDo0yMfTM
	 8f19/14POLm6i6fPoDFVxnHDY530J5jTPWtHC7iaBgZmKjk+xMbF42IwqJc5kOPMHg
	 mw2IsdPuoFG1/nEEhi+megqjHDxybdn6sQBOeH8Xz+GSi/FJpSMm76DS09Msxjd17E
	 VLYYFuyU2W5gw==
Date: Thu, 5 Dec 2024 17:12:03 +0000
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 02/21] net: usb: lan78xx: Remove KSZ9031 PHY
 fixup
Message-ID: <20241205171203.GE2581@kernel.org>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-3-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:35AM +0100, Oleksij Rempel wrote:
> Remove the KSZ9031RNX PHY fixup from the lan78xx driver. The fixup applied
> specific RGMII pad skew configurations globally, but these settings violate the
> RGMII specification and cause more harm than benefit.
> 
> Key issues with the fixup:
> 1. **Non-Compliant Timing**: The fixup's delay settings fall outside the RGMII
>    specification requirements of 1.5 ns to 2.0 ns:
>    - RX Path: Total delay of **2.16 ns** (PHY internal delay of 1.2 ns + 0.96
>      ns skew).
>    - TX Path: Total delay of **0.96 ns**, significantly below the RGMII minimum
>      of 1.5 ns.
> 
> 2. **Redundant or Incorrect Configurations**:
>    - The RGMII skew registers written by the fixup do not meaningfully alter
>      the PHY's default behavior and fail to account for its internal delays.
>    - The TX_DATA pad skew was not configured, relying on power-on defaults
>      that are insufficient for RGMII compliance.
> 
> 3. **Micrel Driver Support**: By setting `PHY_INTERFACE_MODE_RGMII_ID`, the
>    Micrel driver can calculate and assign appropriate skew values for the
>    KSZ9031 PHY.  This ensures better timing configurations without relying on
>    external fixups.
> 
> 4. **System Interference**: The fixup applied globally, reconfiguring all
>    KSZ9031 PHYs in the system, even those unrelated to the LAN78xx adapter.
>    This could lead to unintended and harmful behavior on unrelated interfaces.
> 
> While the fixup is removed, a better mechanism is still needed to dynamically
> determine the optimal combination of PHY and MAC delays to fully meet RGMII
> requirements without relying on Device Tree or global fixups. This would allow
> for robust operation across different hardware configurations.
> 
> The Micrel driver is capable of using the interface mode value to calculate and
> apply better skew values, providing a configuration much closer to the RGMII
> specification than the fixup. Removing the fixup ensures better default
> behavior and prevents harm to other system interfaces.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/usb/lan78xx.c | 38 +++++---------------------------------
>  1 file changed, 5 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c

...

> @@ -2283,14 +2263,11 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
>  			netdev_err(dev->net, "no PHY driver found\n");
>  			return NULL;
>  		}
> -		dev->interface = PHY_INTERFACE_MODE_RGMII;
> -		/* external PHY fixup for KSZ9031RNX */
> -		ret = phy_register_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0,
> -						 ksz9031rnx_fixup);
> -		if (ret < 0) {
> -			netdev_err(dev->net, "Failed to register fixup for PHY_KSZ9031RNX\n");
> -			return NULL;
> -		}
> +		dev->interface = PHY_INTERFACE_MODE_RGMII_ID;
> +		/* The PHY driver is responsible to configure proper RGMII
> +		 * interface delays. Disable RGMII delays on MAC side.
> +		 */
> +		lan78xx_write_reg(dev, MAC_RGMII_ID, 0);
>  
>  		phydev->is_internal = false;
>  	}

nit: With this change ret is now set but otherwise unused in this function.

     I would suggest a new patch, prior to this one, that drops the
     other places where it is set. They seem to have no effect.
     And then remove ret from this function in this patch.

> @@ -2349,9 +2326,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  			if (phy_is_pseudo_fixed_link(phydev)) {
>  				fixed_phy_unregister(phydev);
>  				phy_device_free(phydev);
> -			} else {
> -				phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
> -							     0xfffffff0);
>  			}
>  		}
>  		return -EIO;

...

