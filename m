Return-Path: <netdev+bounces-182692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354CA89B5C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CD7172E49
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8D288C98;
	Tue, 15 Apr 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YB2LeLK5"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01661C13D;
	Tue, 15 Apr 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715039; cv=none; b=DzUdwzBtVLTMMPql9i1mZPFAeCe2wuyDt1SjKqXSKIvHJ63m9Of862NzSaZogm/OQibE+szVyNup8GKiwBlSZKa/VvyEHkkHw+8OxLyrN8UERISbrsnwlYDh59ByLGxfwwW/LNsLIRTgLNTJluBcPc8V9m/UpjTJCnBeFOFeomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715039; c=relaxed/simple;
	bh=lUToVI8Z/K9zO1OtdRIhMl49m6xry/jiX60OGbZaB2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVGbdOw8HsCx03uLHV6Bs7mcqomUkqfFOM+GqaGvJGGyFIZJiTRIlu1ooNZV6pwNpnfvx1L3/DtmDias7axcHouXpJuGkVoM6LcWBLHDiXIFixqbTPpZFNwzoCICgNsx/dNF1Xyoc4AJkv1Rxw71LNSziQFdVd/Bx8PXZkG4VUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YB2LeLK5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744715035;
	bh=lUToVI8Z/K9zO1OtdRIhMl49m6xry/jiX60OGbZaB2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YB2LeLK53zM5wnal3/5LdwZuEdiAdT6qJeQDYro80Ax9Xfju3AE5UYo53K5ZVlP1N
	 P71Z5m12GuH2SU6nOKGx1TFoiBrEPQj455/XXZd68Eo0rYAllkLu10H0a8w7d7B8AK
	 DdPcjsQQzLqfFitTp8VsYcpMA5Yzalxw5YnDeylb5koIkmblOwfvoT9BNxHXkeY8MJ
	 LRr64TSiXxaulbM6yCnRAPdzFCcbdj5yjXMpOHMqlewuBBz71K8rreuEGhUOJ3kmeg
	 GuBnBhHNKLehg+EAtoyG0hfQLNC4exwT1+hAaNMPB4Ke9ubV3ghwPWz0qN9v1hSkAi
	 Iz3JOSY8GUzWA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0FEDA17E0B2D;
	Tue, 15 Apr 2025 13:03:54 +0200 (CEST)
Message-ID: <b29cfa5e-da21-4c6a-be44-dd091e109650@collabora.com>
Date: Tue, 15 Apr 2025 13:03:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH] net: phy: mediatek: init val in
 .phy_led_polarity_set for AN7581
To: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>
References: <20250415105313.3409-1-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250415105313.3409-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/04/25 12:53, Christian Marangi ha scritto:
> Fix smatch warning for uninitialised val in .phy_led_polarity_set for
> AN7581 driver.
> 
> Correctly init to 0 to set polarity high by default.
> 
> Reported-by: Simon Horman <horms@kernel.org>
> Fixes: 6a325aed130b ("net: phy: mediatek: add Airoha PHY ID to SoC driver")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/net/phy/mediatek/mtk-ge-soc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
> index fd0e447ffce7..cd09684780a4 100644
> --- a/drivers/net/phy/mediatek/mtk-ge-soc.c
> +++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
> @@ -1432,8 +1432,8 @@ static int an7581_phy_probe(struct phy_device *phydev)
>   static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
>   				       unsigned long modes)
>   {
> +	u16 val = 0;
>   	u32 mode;
> -	u16 val;

....but that's double initialization then, so....


	u32 mode;
	u16 val;

	if (index >= MTK_PHY_MAX_LEDS)
		return -EINVAL;

	if (modes == 0)
		val = 0;

	for_each_set_bit(.....

Cheers,
Angelo


>   
>   	if (index >= MTK_PHY_MAX_LEDS)
>   		return -EINVAL;
> @@ -1444,7 +1444,6 @@ static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
>   			val = MTK_PHY_LED_ON_POLARITY;
>   			break;
>   		case PHY_LED_ACTIVE_HIGH:
> -			val = 0;
>   			break;
>   		default:
>   			return -EINVAL;


