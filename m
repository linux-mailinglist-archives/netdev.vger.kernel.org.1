Return-Path: <netdev+bounces-142788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE059C05F4
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E02B21C6C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D6A20EA28;
	Thu,  7 Nov 2024 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R9HyUJpL"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8045F20C474;
	Thu,  7 Nov 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983104; cv=none; b=Ko0fl20lUZ3gAXY7suwdThc0745RjTK7/9MhDKko+e3GYe8z9E4B/SPcaapdAcXPsidBeUV4K0eYg/eXD8At4uuvDUeEagWIc7M2KDxpxX0KJ5aNP4M4eRoEEdDswVRM3x2mkRHIomU92Uja7xQjBD8EkvK/r0oa4umXK3/r62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983104; c=relaxed/simple;
	bh=vFiERqnygHn3dr9TR3qxLRfo6JZ2UddHPaEnWrTKUfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbs3WgXCa1k4bBLR6z68lv3U9afFN8Vxf9B3Y/Uun+4eST2+vpbSVosDmUbdjddmvYP4yR5ZkbhlqUTfhd9Pzly40vMOrhUJGpykesNhcYT17a1oPbU/DcJ8/gCBSwAJgyHFmbX6JG2kqhPA/W40VYvmFYnVtpp4wnFOTqXjZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R9HyUJpL; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46DEA24000C;
	Thu,  7 Nov 2024 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730983093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tyx5a0QDkKjhE4rESQdw3bFYGMukiTeG8k9jhLmbkS8=;
	b=R9HyUJpLWhc1mwO9J/AUA9d2qLiwIC3vp7jozhc3KUsJ/8YpKDLC+L9Afk5bG7CO83Oz2Y
	P+ti95xNATjZ0+7tIL1Y3aHaYT0bavvMvg4WvYHkYjISbl0K5iQENtzyHdbdSR8F4ZrmJ+
	a5hwXpFz5XNcSNOfrAfPtb47k3liaadkbC4aswhhUVmoov0w9f7ZQVsPTvz8SpOVo2IYia
	ka3zUBot18dhUbV4IzX1Zvdrr6MtlvHybwIkc6w6Km5QrR1zsfOJW4W8PGzh1Rlt/iWZUr
	ZOY9m7/LxmN8uRwQ3n+9yVk6iI3XYCju+0Hlme+QDoa0wsmJw8tJQ9KZvZm8fg==
Date: Thu, 7 Nov 2024 13:38:11 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
 <ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net-next 3/3] net: ftgmac100: Support for AST2700
Message-ID: <20241107133811.3109d98a@fedora.home>
In-Reply-To: <20241107111500.4066517-4-jacky_chou@aspeedtech.com>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
	<20241107111500.4066517-4-jacky_chou@aspeedtech.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Thu, 7 Nov 2024 19:15:00 +0800
Jacky Chou <jacky_chou@aspeedtech.com> wrote:

> The AST2700 is the 7th generation SoC from Aspeed, featuring three GPIO
> controllers that are support 64-bit DMA capability.
> Adding features is shown in the following list.
> 1.Support 64-bit DMA
>   Add the high address (63:32) registers for description address and the
>   description field for packet buffer with high address part.
>   These registers and fields in legacy Aspeed SoC are reserved.
>   This 64-bit DMA changing has verified on legacy Aspeed Soc, like
>   AST2600.

Maybe each of these features should be in a dedicated patch ?

> 2.Set RMII pin strap in AST2700 compitable
				  compatible

>   Use bit 20 of MAC 0x50 to represent the pin strap of AST2700 RMII and
>   RGMII. Set to 1 is RMII pin, otherwise is RGMII.
>   This bis is also reserved in legacy Aspeed SoC.
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

[...]

> @@ -349,6 +354,10 @@ static void ftgmac100_start_hw(struct ftgmac100 *priv)
>  	if (priv->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
>  		maccr |= FTGMAC100_MACCR_RM_VLAN;
>  
> +	if (of_device_is_compatible(priv->dev->of_node, "aspeed,ast2700-mac") &&
> +	    priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII)
> +		maccr |= FTGMAC100_MACCR_RMII_ENABLE;

The driver code takes the assumption that netdev->phydev might be NULL,
I think you should therefore add an extra check here as well before
getting the interface mode.

Thanks,

Maxime

