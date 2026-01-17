Return-Path: <netdev+bounces-250707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0050D38ED4
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 14:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A0773004E2A
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF402AD32;
	Sat, 17 Jan 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WKcU6Nrv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D42CA4E
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768657972; cv=none; b=EhvkSVOndLKLf8JPsO5B8M1XzMWrzSXu9dd+M9EXoyXHH/kPnDDLYWyGVV9Y4ZyvdEBtdBIIuBER7iycTe60qEeGghEDGR4Vhzl2cvYxqLK0X6Yk7q7nS9a9ICFAQZW0o1FCOt4V25IQrf0iUwDQyDoMPW75G7L8tSJhA7mRHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768657972; c=relaxed/simple;
	bh=DAq/8+7BHq9lcx4kKJkzMEmv0oJAF4D/Gyr7ASaRlKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcTsdx8zfQm86+NJI/rOlzKvQ92M7EZ9NfSa9kO3Q3E69/Fj9CJkbWkN84TeGlUj3CAzP2u1UwX5Ze4CAj5DxaRD5Yh2Y/1F/EMsXE+Kdl7s87n/zh2SAUBbhNfAsGfQu/rmBhrcV9tuH467IvoKNwB0Qm8dSadCfxz3Ijifd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WKcU6Nrv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8005F1A28EA;
	Sat, 17 Jan 2026 13:52:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40F5B60708;
	Sat, 17 Jan 2026 13:52:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 892EF10B69083;
	Sat, 17 Jan 2026 14:52:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768657966; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=5gDixT1C1g9aXGEdjl/pZkav3MxrZ1blNqQfJLK1BvE=;
	b=WKcU6NrvukifFmQkh8Va7m7KICHp61NXtJxizqM8LdcErwoE6rzE6E54u19h1ifDeJPIxI
	4mqKwlC3c0cA+f6Qj6CGlzfvbLaRWhgzLGLjkIE1OT70IQBYXzMzbzzNYGsPmuDrfAXdba
	rAHuSNuxHb3pNuARUDSg2t+VTtm4RwQt4yNc0/cMjTvJA0QgFwLYRRD6EqFtwYacSPXK6M
	02Bbkt09P7mNAA+lKnonX9NqJKinXZzdd6VJyBl3daHersl+UcO3yoTyp5rqI2+ssqU7iF
	KrsYy34nmQRZvReF0srgsRxMadFk9pXF4o7+q9Qkl/FdfmrCfYSn/Hh8iEahsg==
Message-ID: <194679cb-f8e0-4195-b85b-8726b9f5b4f6@bootlin.com>
Date: Sat, 17 Jan 2026 14:52:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: stmmac: enable RPS and RBU interrupts
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 17/01/2026 00:25, Russell King (Oracle) wrote:
> Enable receive process stopped and receive buffer unavailable
> interrupts, so that the statistic counters can be updated.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> 
> Maxime,
> 
> You may find this patch useful, as it makes the "rx_buf_unav_irq"
> and "rx_process_stopped_irq" ethtool statistic counters functional.
> This means that the lack of receive descriptors can still be detected
> even if the receive side doesn't actually stall.

Nice ! I'll give a test and take a deeper look after the weekend :)

Thanks,

Maxime

> 
> I'm not sure why we publish these statistic counters if we don't
> enable the interrupts to allow them to ever be non-zero.
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> index 9d9077a4ac9f..d7f86b398abe 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> @@ -99,6 +99,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>  #define DMA_CHAN_INTR_ENA_NIE_4_10	BIT(15)
>  #define DMA_CHAN_INTR_ENA_AIE_4_10	BIT(14)
>  #define DMA_CHAN_INTR_ENA_FBE		BIT(12)
> +#define DMA_CHAN_INTR_ENA_RPS		BIT(8)
> +#define DMA_CHAN_INTR_ENA_RBU		BIT(7)
>  #define DMA_CHAN_INTR_ENA_RIE		BIT(6)
>  #define DMA_CHAN_INTR_ENA_TIE		BIT(0)
>  
> @@ -107,6 +109,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>  					 DMA_CHAN_INTR_ENA_TIE)
>  
>  #define DMA_CHAN_INTR_ABNORMAL		(DMA_CHAN_INTR_ENA_AIE | \
> +					 DMA_CHAN_INTR_ENA_RPS | \
> +					 DMA_CHAN_INTR_ENA_RBU | \
>  					 DMA_CHAN_INTR_ENA_FBE)
>  /* DMA default interrupt mask for 4.00 */
>  #define DMA_CHAN_INTR_DEFAULT_MASK	(DMA_CHAN_INTR_NORMAL | \
> @@ -119,6 +123,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>  					 DMA_CHAN_INTR_ENA_TIE)
>  
>  #define DMA_CHAN_INTR_ABNORMAL_4_10	(DMA_CHAN_INTR_ENA_AIE_4_10 | \
> +					 DMA_CHAN_INTR_ENA_RPS | \
> +					 DMA_CHAN_INTR_ENA_RBU | \
>  					 DMA_CHAN_INTR_ENA_FBE)
>  /* DMA default interrupt mask for 4.10a */
>  #define DMA_CHAN_INTR_DEFAULT_MASK_4_10	(DMA_CHAN_INTR_NORMAL_4_10 | \


