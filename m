Return-Path: <netdev+bounces-112104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E1934F9A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FEB1C20DB7
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B331420DF;
	Thu, 18 Jul 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="awpV3Pqq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388342A8FE;
	Thu, 18 Jul 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315054; cv=none; b=nO5WO5GzIaXR/sBm+H/T974geBB4kjGOxrrcRI/O4Ys7NgQmxll8lSRHsDMrKBypSYpjx2Csf7AWrok1MGj0/N8/A0BBDYUH1DRNYD3yiSKHiVHLLEZhWfSFU1eFMlGAUhnaZoU86DTQL/vtVGNKN2qSE6tkWBIYvLq4FMQKeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315054; c=relaxed/simple;
	bh=DKIRJ+uVyLmKItiAAdCRDUEQLKEAzYDyl8geLmBl4To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct/hUfd0PSLf3stmLhbiy0HyGEcjDyJGu0098GsDpP+SqqQU1cyOHZsJeLDohJxCGNK8iYECK0lajjFi8L/H0HwaPMS7K+aWPlVsYlgtplPorReILIBP4T6+44m58ZQK+1F4y/PE5bSIHCT0kxHfkYzZcQH1DEV2p9wYOdB9Gdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=awpV3Pqq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2a3LyJklb3hSAEAV0myCl1XCbj1OfA1wXLuXzezg57o=; b=awpV3Pqq0yz/Ou6C7ce/lOFH03
	wVyI80kOgWYixBd7VWX0aCxmvP7h42bY4J7ZX0awVlPKejEsQh0fTANYG+E8HTJCMqbJyWd/dq8HS
	ntgiEB1G70cw7dsKL8bib1mQTy9DT4GDctqJUUPr4HkSwbRa6vZLMGbS+p2iqBEbqLA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUSfq-002mzQ-Df; Thu, 18 Jul 2024 17:04:02 +0200
Date: Thu, 18 Jul 2024 17:04:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
	pabeni@redhat.com, horatiu.vultur@microchip.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net] net: phy: micrel: Fix the KSZ9131 MDI-X status issue
Message-ID: <fe873fde-7a41-4a4a-ba9f-41c2ba0ddc02@lunn.ch>
References: <20240712111648.282897-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712111648.282897-1-Raju.Lakkaraju@microchip.com>

On Fri, Jul 12, 2024 at 04:46:48PM +0530, Raju Lakkaraju wrote:
> Access information about Auto mdix completion and pair selection from the
> KSZ9131's Auto/MDI/MDI-X status register

Please explain what the broken behaviour is. How would i know i need
this patch?

You have not included a Cc: stable tag. Does that mean this does not
bother anybody and so does not need backporting?

> Fixes: b64e6a8794d9 ("net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/phy/micrel.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index ebafedde0ab7..fddc1b91ba7f 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1438,6 +1438,9 @@ static int ksz9131_config_init(struct phy_device *phydev)
>  #define MII_KSZ9131_AUTO_MDIX		0x1C
>  #define MII_KSZ9131_AUTO_MDI_SET	BIT(7)
>  #define MII_KSZ9131_AUTO_MDIX_SWAP_OFF	BIT(6)
> +#define MII_KSZ9131_DIG_AXAN_STS	0x14
> +#define MII_KSZ9131_DIG_AXAN_STS_LINK_DET	BIT(14)
> +#define MII_KSZ9131_DIG_AXAN_STS_A_SELECT	BIT(12)
>  
>  static int ksz9131_mdix_update(struct phy_device *phydev)
>  {
> @@ -1452,14 +1455,24 @@ static int ksz9131_mdix_update(struct phy_device *phydev)
>  			phydev->mdix_ctrl = ETH_TP_MDI;
>  		else
>  			phydev->mdix_ctrl = ETH_TP_MDI_X;
> +
> +		phydev->mdix = phydev->mdix_ctrl;

This seems a bit odd. phydev->mdix_ctrl is what the user wants to
happen. This is generally ETH_TP_MDI_AUTO, meaning the PHY should
figure it out. It can be ETH_TP_MDI_X, or ETH_TP_MDI which forces the
configuration. phydev->mdix is what it has ended up using.

So the code above first seems to change what the user asked for. This
is likely to replace ETH_TP_MDI_AUTO with one of the fixed modes,
which will then break when the user replaces a crossed cable with a
straight cable, and the forced mode is then wrong.

Setting mdix to mdix_ctrl then seems wrong. In most cases, you are
going to get ETH_TP_MDI_AUTO, when in fact you should be returning
what the PHY has decided on, ETH_TP_MDI_X, ETH_TP_MDI, or
ETH_TP_MDI_INVALID because the link is down.

Maybe genphy_c45_read_mdix() will help you. It simply reads a PHY
status register, sets phydev->mdix and it is done.

       Andrew

