Return-Path: <netdev+bounces-108107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB12891DDBA
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7D11F22111
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1816F13C679;
	Mon,  1 Jul 2024 11:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468EB12CDB0;
	Mon,  1 Jul 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832887; cv=none; b=m1CKUhH+e/7RULwyHl/NUUltvoVm6o42jBxPsVlpGe10jcceWVSgzpz2cYYH1qEJL9w0LAslvEvj54zyTngOM9PY6+Rgly9Ct2XsfhYpx24G4xjLoNcbXevw5PmcrJYzxmLSWlyylnuy3JsysavbwdUu77e/GPamapCYT+vB71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832887; c=relaxed/simple;
	bh=JOzJZ9bsQdjN0b6Bn+BCyZRD0ZGpRjDY8984P99UG+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+A9IrwyBl8Uezzg/s1XCP7OYKlowmz5z6IRcgERJilHAhY31Bt9uatCaYfIST51/D2J+4onW07IivsR/YFEHVYVCw4WwcN17/H2HZe+RhCT4sLSaEbPGOJAO4ceWrKPo7r5AmqQNTrUVoQf18A5C4NGgrwW+9fUJt3ihVy+NtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sOF5m-000000006YZ-0Ekn;
	Mon, 01 Jul 2024 11:21:06 +0000
Date: Mon, 1 Jul 2024 12:20:59 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v10 13/13] net: phy: mediatek: Remove
 unnecessary outer parens of "supported_triggers" var
Message-ID: <ZoKRDSVYD_JMhMqW@makrotopia.org>
References: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
 <20240701105417.19941-14-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701105417.19941-14-SkyLake.Huang@mediatek.com>

On Mon, Jul 01, 2024 at 06:54:17PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch removes unnecessary outer parens of "supported_triggers" vars
> in mtk-ge.c & mtk-ge-soc.c to improve readability.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> ---
> diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
> index 90f3990..050a4f7 100644
> --- a/drivers/net/phy/mediatek/mtk-ge.c
> +++ b/drivers/net/phy/mediatek/mtk-ge.c
> @@ -152,14 +152,14 @@ static int mt753x_phy_led_brightness_set(struct phy_device *phydev,
>  }
>  
>  static const unsigned long supported_triggers =
> -	(BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> -	 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> -	 BIT(TRIGGER_NETDEV_LINK)        |
> -	 BIT(TRIGGER_NETDEV_LINK_10)     |
> -	 BIT(TRIGGER_NETDEV_LINK_100)    |
> -	 BIT(TRIGGER_NETDEV_LINK_1000)   |
> -	 BIT(TRIGGER_NETDEV_RX)          |
> -	 BIT(TRIGGER_NETDEV_TX));
> +	BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> +	BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> +	BIT(TRIGGER_NETDEV_LINK)        |
> +	BIT(TRIGGER_NETDEV_LINK_10)     |
> +	BIT(TRIGGER_NETDEV_LINK_100)    |
> +	BIT(TRIGGER_NETDEV_LINK_1000)   |
> +	BIT(TRIGGER_NETDEV_RX)          |
> +	BIT(TRIGGER_NETDEV_TX);

Those lines are added within the same series by patch 06/13
("net: phy: mediatek: Hook LED helper functions in mtk-ge.c").
I get and like the idea of doing things one by one, but in this case
instead of editing what you have just added, better move the commit
removing the unnecessary parentheses somewhere before copying them to
the mtk-ge.c driver in patch 6/13.

All the rest looks good to me now.

