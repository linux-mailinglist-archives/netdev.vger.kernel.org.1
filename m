Return-Path: <netdev+bounces-234432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C813C209F2
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A6DF4EE523
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368F2749C9;
	Thu, 30 Oct 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c0frDGXY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919AE1F0E39;
	Thu, 30 Oct 2025 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834777; cv=none; b=bA1AGyG2bX8q3SFU9387F7GBOnaYYciMPbyUqYR0cqTMgQmSkrBFCR+ruNeOOwuRS2APoFKe4SaUJsm6c4Z70oc/JokQYFmBvDOTsE2aFDTmY9E0OjA8PDcZYTrrWGhVNq2JDRE6/T+pM4BJQhp1uGiiXs3g8qyPd6h0oMeSi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834777; c=relaxed/simple;
	bh=D62bdTPTtRN3AVB5FJdx5lqUZgowJjCwSpNZ7p2tbBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oq08BJ30RFZwEgRXsiqQO5YuJf+CSPrdLsNmNGJAxcyldB+/yieLRu4RBwCZ8itIctevxiqgo9I8/HMhGswXfrnUda3sPZ62M2le3b1w3UmVKTp+zq4ChLPZeL6VuYw0wyuahY3ElBSrZJtOPlGAy4XeivbgZSMTUcxi0QCd2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c0frDGXY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761834776; x=1793370776;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D62bdTPTtRN3AVB5FJdx5lqUZgowJjCwSpNZ7p2tbBQ=;
  b=c0frDGXY4mr5bp5ucbHh5rxAMnnNH1fGGCo7N/yNDewjJyryHfC9ZTZp
   99CqSw+1dSPpDByl/YjEmdVCHXD6M4C7skDjNGiUriHMBaKs9I8jU+nny
   MYjvkZyTwOU6yXEULPgnhPbiM6Atg3T6IfCZRwom8GCaojJtSYzJmvTet
   nAyQ2imByPY8ETjrdR1bW4oBoz2SMomesk0v2f+12qrTKHt0cwK9gl16f
   35hR/CEdEoXURyemCcJ5x1yOTCtjrNWhvPqwz81TJsIhJ6Cb02GXxsfKO
   S1lzHq3M3NWmEn6ahHvzK5Xnuq5kmFCoTwtJUwgGaQ6LH8Q0nYnklw9lA
   g==;
X-CSE-ConnectionGUID: dL1EgsYfRVKQ49uqN4PuEg==
X-CSE-MsgGUID: LcgAnV1xSRm3PROQENaW/Q==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="48976230"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:32:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 30 Oct 2025 07:32:41 -0700
Received: from [10.171.248.18] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Oct 2025 07:32:36 -0700
Message-ID: <f777c7d5-346d-42d3-b328-45320b22aacc@microchip.com>
Date: Thu, 30 Oct 2025 15:32:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net: macb: add no LSO capability
 (MACB_CAPS_NO_LSO)
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
	<benoit.monin@bootlin.com>, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
	<gregory.clement@bootlin.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>, Andrew Lunn <andrew@lunn.ch>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-3-af509422c204@bootlin.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20251023-macb-eyeq5-v3-3-af509422c204@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/2025 at 18:22, Théo Lebrun wrote:
> LSO is runtime-detected using the PBUF_LSO field inside register DCFG6.
> Allow disabling that feature if it is broken by using bp->caps coming
> from match data.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Even if already applied:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/ethernet/cadence/macb.h      | 1 +
>   drivers/net/ethernet/cadence/macb_main.c | 7 +++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 93e8dd092313..05bfa9bd4782 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -778,6 +778,7 @@
>   #define MACB_CAPS_DMA_64B                      BIT(21)
>   #define MACB_CAPS_DMA_PTP                      BIT(22)
>   #define MACB_CAPS_RSC                          BIT(23)
> +#define MACB_CAPS_NO_LSO                       BIT(24)
> 
>   /* LSO settings */
>   #define MACB_LSO_UFO_ENABLE                    0x01
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index be3d0c2313a1..8b688a6cb2f9 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4564,8 +4564,11 @@ static int macb_init(struct platform_device *pdev)
>          /* Set features */
>          dev->hw_features = NETIF_F_SG;
> 
> -       /* Check LSO capability */
> -       if (GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
> +       /* Check LSO capability; runtime detection can be overridden by a cap
> +        * flag if the hardware is known to be buggy
> +        */
> +       if (!(bp->caps & MACB_CAPS_NO_LSO) &&
> +           GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
>                  dev->hw_features |= MACB_NETIF_LSO;
> 
>          /* Checksum offload is only available on gem with packet buffer */
> 
> --
> 2.51.1
> 


