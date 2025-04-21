Return-Path: <netdev+bounces-184318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C042CA94AA8
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 04:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40C416EFCC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E3A253B76;
	Mon, 21 Apr 2025 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G2ht85LP"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9274C8F
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745201381; cv=none; b=hdFoQCvmdjUSmxHpjx7UUtNkldSdaru9drTljVgendLcmXQLzi1nkqiFqZpfjR+oHkSMRcKkJttxJ8+LgZb7J5lYkziYtAMe8G1qsEkiMJWIms+rhmoADhzDzI/txsBJ97ROXu2HD9NMbxMJb7pk80T5C/89nnlIWwcL4x5VcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745201381; c=relaxed/simple;
	bh=vQwPL41UhXSWhazxVBZ9yhLnlauIudYDFz+u76RyH7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivDoH3hBOrqsELdoU8itgHTPgr68RogohdN5tcyVZV6KZp3RJxn4wKgNqCSzZ2kUKgxrxdgIIOXDbFGxBF/Cg3tPkLplAQ/fh9CRNywQeYV8oLPdhU3nynzy8zAfZjd+rVncfflLlYS7QkdV2kmvejKhhZV+sNlEuKOujKpX6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G2ht85LP; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba5bb0ed-54e6-4655-ac52-0594acc3d9ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745201367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkvpI/QNH8sX2vc89J73S1BGYLDtEYPlsj2xsRPRVmc=;
	b=G2ht85LPDq7ZDR6eziLKyEU9SpDkF7/mxdwUPBkHPi9fnliu01mm+LEGpICIR3qyR6tCeV
	KCuomqISg7G8ZD939n16VGAQHIaDEofbqGpGlTw4WfVBISU+it6vQ9h2y8YXv1r8wTMe7m
	YEveVruvceFOMuXF9V8shPCOYwzyhXE=
Date: Mon, 21 Apr 2025 10:09:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next V2 3/3] net: stmmac: dwmac-loongson: Add new
 GMAC's PCI device ID support
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Feiyang Chen <chris.chenfeiyang@gmail.com>, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Henry Chen <chenx97@aosc.io>,
 Biao Dong <dongbiao@loongson.cn>, Baoqi Zhang <zhangbaoqi@loongson.cn>
References: <20250416144132.3857990-1-chenhuacai@loongson.cn>
 <20250416144132.3857990-4-chenhuacai@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250416144132.3857990-4-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 4/16/25 10:41 PM, Huacai Chen 写道:
> Add a new GMAC's PCI device ID (0x7a23) support which is used in
> Loongson-2K3000/Loongson-3B6000M. The new GMAC device use external PHY,
> so it reuses loongson_gmac_data() as the old GMAC device (0x7a03), and
> the new GMAC device still doesn't support flow control now.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Henry Chen <chenx97@aosc.io>
> Tested-by: Biao Dong <dongbiao@loongson.cn>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 57917f26ab4d..e1591e6217d4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -66,7 +66,8 @@
>   					 DMA_STATUS_TPS | DMA_STATUS_TI  | \
>   					 DMA_STATUS_MSK_COMMON_LOONGSON)
>   
> -#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> +#define PCI_DEVICE_ID_LOONGSON_GMAC1	0x7a03
> +#define PCI_DEVICE_ID_LOONGSON_GMAC2	0x7a23
>   #define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
>   #define DWMAC_CORE_MULTICHAN_V1	0x10	/* Loongson custom ID 0x10 */
>   #define DWMAC_CORE_MULTICHAN_V2	0x12	/* Loongson custom ID 0x12 */
> @@ -371,7 +372,7 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>   	/* Loongson GMAC doesn't support the flow control. Loongson GNET
>   	 * without multi-channel doesn't support the half-duplex link mode.
>   	 */
> -	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
> +	if (pdev->device != PCI_DEVICE_ID_LOONGSON_GNET) {
>   		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
>   	} else {
>   		if (ld->multichan)
> @@ -659,7 +660,8 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>   			 loongson_dwmac_resume);
>   
>   static const struct pci_device_id loongson_dwmac_id_table[] = {
> -	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC1, &loongson_gmac_pci_info) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC2, &loongson_gmac_pci_info) },
>   	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
>   	{}
>   };

