Return-Path: <netdev+bounces-234430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51370C209AA
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A736E34F5A4
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E30272803;
	Thu, 30 Oct 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NWBCJeQK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341B37A3C2;
	Thu, 30 Oct 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834755; cv=none; b=PuPi8iHtQjFDPOYl7r6DPMLuH4aE6ZHzGxTvaqjjs7UtLrPTnR9VIWELuymDRv/O9c46WnCIan/UHDfAQdqG56kgHKfhOEKE3pIM9O1iLG6QTC/Y8uLi6Y+j3ktyh51qN2vOvs3YUSNd9gyz2cz6wx/XU3m9znw5vt5G5sYebCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834755; c=relaxed/simple;
	bh=gkH2lxMFOGTlkMaVDMgra9ZABBZcWcp6GHDGbzzQ2gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b2J3UrJ0eYtoisTfscj5NlEvOUjR1ixbh7JgRwUgEF105g8vQGoD+LkgLKkSOmXMPXDzGPk40sojYVZTFeIOYQT2o/AuYB6WQlB7FEXwl7656dHdZT4WrCf2mrFtYjlS7RtMHB9PAkRK/6mULiuIUDFHZL/1Pdkfa4gjrp+gpQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NWBCJeQK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761834753; x=1793370753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gkH2lxMFOGTlkMaVDMgra9ZABBZcWcp6GHDGbzzQ2gI=;
  b=NWBCJeQKgG1LnmZeRKK0uEnKaYr3mDTrbbbQZigB1gGxaWgDzkd1Ut+9
   bzCtAAF6j7eMzCMoc/QzD196PlTLlE+0BawhEfwK/VmlP/aCiq5g5ERri
   fKDuxr1LMjhNNwTE7S4MnqcGtJHMw5mPhL64nSULeEuM/xc12Xj9z0Skv
   FVzeDoxmiTGn5t35PccI9d2o7MrHn1BpEPr1e5aDE8TWOT4LAtcrFMttQ
   ThZBUd57Bvorrfiw5vgc4dp7mrHh/+f4A/ykod4GrYYUntyNJhUabW9zV
   WB8+UMAU1mH/QjQXm/5YgNdr2xfkgbpRzyMZ8/L4XCbWfVvw+aFvXkE8u
   g==;
X-CSE-ConnectionGUID: KJy2Pai7RkKq6Xlk05XjEA==
X-CSE-MsgGUID: 8m4Z3GghSJ2ziABezsM1ww==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="47837768"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:32:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 30 Oct 2025 07:32:01 -0700
Received: from [10.171.248.18] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Oct 2025 07:31:56 -0700
Message-ID: <ea7ad70a-73d4-48a5-92cb-9cb73e9be325@microchip.com>
Date: Thu, 30 Oct 2025 15:31:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net: macb: match skb_reserve(skb,
 NET_IP_ALIGN) with HW alignment
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
	<vladimir.kondratiev@mobileye.com>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-2-af509422c204@bootlin.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20251023-macb-eyeq5-v3-2-af509422c204@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/2025 at 18:22, Théo Lebrun wrote:
> If HW is RSC capable, it cannot add dummy bytes at the start of IP
> packets. Alignment (ie number of dummy bytes) is configured using the
> RBOF field inside the NCFGR register.
> 
> On the software side, the skb_reserve(skb, NET_IP_ALIGN) call must only
> be done if those dummy bytes are added by the hardware; notice the
> skb_reserve() is done AFTER writing the address to the device.
> 
> We cannot do the skb_reserve() call BEFORE writing the address because
> the address field ignores the low 2/3 bits. Conclusion: in some cases,
> we risk not being able to respect the NET_IP_ALIGN value (which is
> picked based on unaligned CPU access performance).
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

For the record:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Théo! Regards,
   Nicolas

> ---
>   drivers/net/ethernet/cadence/macb.h      |  3 +++
>   drivers/net/ethernet/cadence/macb_main.c | 23 ++++++++++++++++++++---
>   2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 5b7d4cdb204d..93e8dd092313 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -537,6 +537,8 @@
>   /* Bitfields in DCFG6. */
>   #define GEM_PBUF_LSO_OFFSET                    27
>   #define GEM_PBUF_LSO_SIZE                      1
> +#define GEM_PBUF_RSC_OFFSET                    26
> +#define GEM_PBUF_RSC_SIZE                      1
>   #define GEM_PBUF_CUTTHRU_OFFSET                        25
>   #define GEM_PBUF_CUTTHRU_SIZE                  1
>   #define GEM_DAW64_OFFSET                       23
> @@ -775,6 +777,7 @@
>   #define MACB_CAPS_MACB_IS_GEM                  BIT(20)
>   #define MACB_CAPS_DMA_64B                      BIT(21)
>   #define MACB_CAPS_DMA_PTP                      BIT(22)
> +#define MACB_CAPS_RSC                          BIT(23)
> 
>   /* LSO settings */
>   #define MACB_LSO_UFO_ENABLE                    0x01
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 39673f5c3337..be3d0c2313a1 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1300,8 +1300,19 @@ static void gem_rx_refill(struct macb_queue *queue)
>                          dma_wmb();
>                          macb_set_addr(bp, desc, paddr);
> 
> -                       /* properly align Ethernet header */
> -                       skb_reserve(skb, NET_IP_ALIGN);
> +                       /* Properly align Ethernet header.
> +                        *
> +                        * Hardware can add dummy bytes if asked using the RBOF
> +                        * field inside the NCFGR register. That feature isn't
> +                        * available if hardware is RSC capable.
> +                        *
> +                        * We cannot fallback to doing the 2-byte shift before
> +                        * DMA mapping because the address field does not allow
> +                        * setting the low 2/3 bits.
> +                        * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
> +                        */
> +                       if (!(bp->caps & MACB_CAPS_RSC))
> +                               skb_reserve(skb, NET_IP_ALIGN);
>                  } else {
>                          desc->ctrl = 0;
>                          dma_wmb();
> @@ -2773,7 +2784,11 @@ static void macb_init_hw(struct macb *bp)
>          macb_set_hwaddr(bp);
> 
>          config = macb_mdc_clk_div(bp);
> -       config |= MACB_BF(RBOF, NET_IP_ALIGN);  /* Make eth data aligned */
> +       /* Make eth data aligned.
> +        * If RSC capable, that offset is ignored by HW.
> +        */
> +       if (!(bp->caps & MACB_CAPS_RSC))
> +               config |= MACB_BF(RBOF, NET_IP_ALIGN);
>          config |= MACB_BIT(DRFCS);              /* Discard Rx FCS */
>          if (bp->caps & MACB_CAPS_JUMBO)
>                  config |= MACB_BIT(JFRAME);     /* Enable jumbo frames */
> @@ -4321,6 +4336,8 @@ static void macb_configure_caps(struct macb *bp,
>                  dcfg = gem_readl(bp, DCFG2);
>                  if ((dcfg & (GEM_BIT(RX_PKT_BUFF) | GEM_BIT(TX_PKT_BUFF))) == 0)
>                          bp->caps |= MACB_CAPS_FIFO_MODE;
> +               if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6)))
> +                       bp->caps |= MACB_CAPS_RSC;
>                  if (gem_has_ptp(bp)) {
>                          if (!GEM_BFEXT(TSU, gem_readl(bp, DCFG5)))
>                                  dev_err(&bp->pdev->dev,
> 
> --
> 2.51.1
> 


