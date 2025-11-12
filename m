Return-Path: <netdev+bounces-237889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A81C513AD
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D64E4F6E08
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D992FD680;
	Wed, 12 Nov 2025 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OiWs0GN9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E12FD7B4
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937621; cv=none; b=Cw9rbfmwGR83BqYFaEnq249Jcbp7GYjNDG9x+T4X5alTbgMMWjqp2Ms39iAltRIfhOt3Op5/673KEjtaWpSWdl5uiTxFZodziNA/PcfLRWsqh7LPsa7qHAdivoDXKBLq5k4yjUixA06QeTNmQ/cPEk3LQbOIaBKfo+OekD57o9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937621; c=relaxed/simple;
	bh=YrID8xgom0oeLwXTd8gUy9iNAW09Ehe680L1mi2dhSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5Dmw7xR/h2ouc5E8NYwSdUfEIx+bCfXUHchTfEnN/0Icn8v7mNCg+Ry/56hloTO957oMnBZUrfvPvgO34nNjM5Y0WkALb6Kz3BoawEv4SIeaRucaaR4CyF7H38NZPDcYGWMXce+lXWpZ2f7w5vKgaQupQKWKjtJyVBIFgyuBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OiWs0GN9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 79A6A4E41664;
	Wed, 12 Nov 2025 08:53:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4DE366070B;
	Wed, 12 Nov 2025 08:53:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B229103717C1;
	Wed, 12 Nov 2025 09:53:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762937615; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3RctqkjWwYDn/e1i2YI8kBYKvwlm+AX0rudk05BCUko=;
	b=OiWs0GN9nSDRW3sLIHBv0EgA+oG1Ldegpv+eBIIdvRwxHUSWSC5kuH2E6y6qKdREVjEWyF
	i3OCs6109YXv4KtttHG2TI28Zrm/ue71aQZhJUXb3Ox44c9PBG4PjpFXUxwPxMSboL5kHU
	4vRhW2TyA5ttSwQsD4Dej+hPs4DugkrguSpJQ5Jeq6VZJ7cieF7b2E/cLJhXCwEwbhQkti
	9uZTK2Xm+V/nSvok5/3zrQ01XlkRlBKiWdxY1laYyBVgdHKSEusxS14kvJqYyUTU+taKCg
	ItGZM5gMaW/Ia/F4rHXuoF+8eiP9D71xnL4IFuiOe6RZAfgYrB8L53pDE7JMXA==
Message-ID: <20523422-7328-4803-940c-9ef1031f05fc@bootlin.com>
Date: Wed, 12 Nov 2025 09:53:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 02/10] net: phy: Rename MDIO_CTRL1_SPEED for
 2.5G and 5G to reflect PMA values
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
References: <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
 <176279047080.2130772.6017646787024578804.stgit@ahduyck-xeon-server.home.arpa>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <176279047080.2130772.6017646787024578804.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexander,

On 10/11/2025 17:01, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The 2.5G and 5G values are not consistent between the PCS CTRL1 and PMA
> CTRL1 values. In order to avoid confusion between the two I am updating the
> values to include "PMA" in the name similar to values used in similar
> places.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  drivers/net/phy/phy-c45.c |    8 ++++----
>  include/uapi/linux/mdio.h |    4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 1d747fbaa10c..d161fe3fee75 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -148,12 +148,12 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
>  		ctrl2 |= MDIO_PMA_CTRL2_1000BT;
>  		break;
>  	case SPEED_2500:
> -		ctrl1 |= MDIO_CTRL1_SPEED2_5G;
> +		ctrl1 |= MDIO_PMA_CTRL1_SPEED2_5G;
>  		/* Assume 2.5Gbase-T */
>  		ctrl2 |= MDIO_PMA_CTRL2_2_5GBT;
>  		break;
>  	case SPEED_5000:
> -		ctrl1 |= MDIO_CTRL1_SPEED5G;
> +		ctrl1 |= MDIO_PMA_CTRL1_SPEED5G;
>  		/* Assume 5Gbase-T */
>  		ctrl2 |= MDIO_PMA_CTRL2_5GBT;
>  		break;
> @@ -618,10 +618,10 @@ int genphy_c45_read_pma(struct phy_device *phydev)
>  	case MDIO_PMA_CTRL1_SPEED1000:
>  		phydev->speed = SPEED_1000;
>  		break;
> -	case MDIO_CTRL1_SPEED2_5G:
> +	case MDIO_PMA_CTRL1_SPEED2_5G:
>  		phydev->speed = SPEED_2500;
>  		break;
> -	case MDIO_CTRL1_SPEED5G:
> +	case MDIO_PMA_CTRL1_SPEED5G:
>  		phydev->speed = SPEED_5000;
>  		break;
>  	case MDIO_CTRL1_SPEED10G:
> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 75ed41fc46c6..c33aa864ef66 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h
> @@ -123,9 +123,9 @@
>  /* 50 Gb/s */
>  #define MDIO_PMA_CTRL1_SPEED50G		(MDIO_CTRL1_SPEEDSELEXT | 0x14)
>  /* 2.5 Gb/s */
> -#define MDIO_CTRL1_SPEED2_5G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
> +#define MDIO_PMA_CTRL1_SPEED2_5G	(MDIO_CTRL1_SPEEDSELEXT | 0x18)
>  /* 5 Gb/s */
> -#define MDIO_CTRL1_SPEED5G		(MDIO_CTRL1_SPEEDSELEXT | 0x1c)
> +#define MDIO_PMA_CTRL1_SPEED5G		(MDIO_CTRL1_SPEEDSELEXT | 0x1c)
>  
>  /* Status register 1. */
>  #define MDIO_STAT1_LPOWERABLE		0x0002	/* Low-power ability */

This is UAPI, I guess it's too late to rename that :(

Maxime
> 
> 
> 


