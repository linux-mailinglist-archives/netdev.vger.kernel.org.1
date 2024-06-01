Return-Path: <netdev+bounces-99930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 910BE8D714E
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 19:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AF71F20EDC
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61E14E2EF;
	Sat,  1 Jun 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teB2s87u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993C154BE0
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717262024; cv=none; b=jRW2ApKSJvEyya0iPyWeraw1rvzM4L38q3zfdn6+Hnc/ikLt+3KanDd6OBfLK/TT7VeU+GQ+47qySYl26gB3fZ8SAevKie/hoEZ9UVWp2bXVqrBR45JC/LI63W1qLkBWT0tTkvo5sLw0Wyz+hhrD2hykUw9Pz/t6kpVNFjJzai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717262024; c=relaxed/simple;
	bh=BlCQjN7aCC7ApXk6CHX8Xo21y/KF9FSa9t9pebBMVLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNZug/GY1N88GAl6GWT9OjoQAiYAJLR/GEjpHxbN3ZhhsLSQNKbN5+4RlHCxzdIcmW2KNhaj1P3knztXI/kYml4me3DIFpDnQUs4u5ntkMWE/sTynWvX5/sqEW4nNwSaPCalPhSWAwkrvKYZEFX76nKgbXVYNsKsSeAQ694boDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teB2s87u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8A2C116B1;
	Sat,  1 Jun 2024 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717262024;
	bh=BlCQjN7aCC7ApXk6CHX8Xo21y/KF9FSa9t9pebBMVLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teB2s87uDmkzy/Iv0r5d4vc2YGb1EVnJm9kpNi4du2+wXrXl8zr1qA7mPgrr5G993
	 njp90fQ4G03EljOaL/iMcBMtw3z/yDsDUkLJIRZ8yhihtKvXpYTGZ9zRwQ5l4u1sDO
	 9b50VIxq2eMYeWSbP7ABc+ViT6fEdL1yoGTpTHk1M72bbsb8kgsWMyYdiCt+7A+p5u
	 MnkLoX4v9hL0pCyoxf4FxvbvECPUM1LFOFQqFhBe/sBirOF95Px1lZwbl50cMzon/4
	 DEEG8bZGv8CSkllX+qEoNk+6QIzpPt9un9krxldYPpdG4SCxj55gLPjsMdXWm7p2Q8
	 d5TiPQ9Bxw7qQ==
Date: Sat, 1 Jun 2024 18:13:40 +0100
From: Simon Horman <horms@kernel.org>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v4 1/5] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
Message-ID: <20240601171340.GU491852@kernel.org>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531142430.678198-2-enguerrand.de-ribaucourt@savoirfairelinux.com>

On Fri, May 31, 2024 at 02:24:26PM +0000, Enguerrand de Ribaucourt wrote:
> There is a DSA driver for microchip,ksz9897 which can be controlled
> through SPI or I2C. This patch adds support for it's CPU ports PHYs to
> also allow network access to the switch's CPU port.
> 
> The CPU ports PHYs of the KSZ9897 are not documented in the datasheet.
> They weirdly use the same PHY ID as the KSZ8081, which is a different
> PHY and that driver isn't compatible with KSZ9897. Before this patch,
> the KSZ8081 driver was used for the CPU ports of the KSZ9897 but the
> link would never come up.
> 
> A new driver for the KSZ9897 is added, based on the compatible KSZ87XX.
> I could not test if Gigabit Ethernet works, but the link comes up and
> can successfully allow packets to be sent and received with DSA tags.
> 
> To resolve the KSZ8081/KSZ9897 phy_id conflicts, I could not find any
> stable register to distinguish them. Instead of a match_phy_device() ,
> I've declared a virtual phy_id with the highest value in Microchip's OUI
> range.
> 
> Example usage in the device tree:
> 	compatible = "ethernet-phy-id0022.17ff";
> 
> A discussion to find better alternatives had been opened with the
> Microchip team, with no response yet.
> 
> See https://lore.kernel.org/all/20220207174532.362781-1-enguerrand.de-ribaucourt@savoirfairelinux.com/
> 
> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>

...

> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c

...

> @@ -5495,6 +5495,17 @@ static struct phy_driver ksphy_driver[] = {
>  	.suspend	= genphy_suspend,
>  	.resume		= genphy_resume,
>  	.get_features	= ksz9477_get_features,
> +}, {
> +	.phy_id		= PHY_ID_KSZ9897,
> +	.phy_id_mask	= MICREL_PHY_ID_MASK,
> +	.name		= "Microchip KSZ9897 Switch",
> +	/* PHY_BASIC_FEATURES */
> +	.config_init	= kszphy_config_init,
> +	.config_aneg	= ksz8873mll_config_aneg,
> +	.read_status	= ksz8873mll_read_status,
> +	/* No suspend/resume callbacks because of errata DS00002330D:
> +	 * Toggling PHY Powerdown can cause errors or link failures in adjacent PHYs
> +	 */

It looks like there will be another version of this patchset.
If so, please line-wrap the comment above so it is 80 columns wide or less,
as is preferred for Networking code.

Likewise in the following patch.

Flagged by checkpatch.pl --max-line-length=80

>  } };
>  
>  module_phy_driver(ksphy_driver);

...

