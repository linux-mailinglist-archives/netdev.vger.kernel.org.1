Return-Path: <netdev+bounces-221273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1297CB4FFA2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3471C2596F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8934AB18;
	Tue,  9 Sep 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OBtCrRsb"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5003435085E;
	Tue,  9 Sep 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428647; cv=none; b=ieQ6fgApUAELFUldqWok0HnDZYHUnl8rsDLSZP5SZZIyZb2ZiIolEFdR5arA6YeE3cJIYqni9lUIYQ1fmFRVpa6W1g0bhem+WncbWQ2yP6c6BjLGeuCWFmyPfFtu3F5b4Bo+3w7VjoCu+nqD4zI2M69dXcxcMYj4CkCVXUWvuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428647; c=relaxed/simple;
	bh=hImgRP5PDSJ8tahE+RtUsG3WvwJy/+Y1BnkvJrIMRfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZugd9Y+CKs1xkF5AKDCEf3FZLdjzK5xBQZjdxOHhXcS1D9ZovIqBTYBoilL9Kvhl9QEVPu6dEPSk9IUpSHV+Q0y3fnMqqrFuRC7QrQCS4pFLNbKk812eXN9RqGtHV5yyakJErtVfImP8iF9jbZGaZ3Blpfp6zZNoAHI6Vs6Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OBtCrRsb; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ec8c7f8-cf79-4701-97dc-2d0a687f0f3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757428643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joBHHo2vNOa9/tISXv4x8ETwG4JXU3LtDMt2JeCyLyM=;
	b=OBtCrRsbxfPzoj5D3rkn5kRq6++vRm4cPJxZet2JnWn0QfYPTL7nbnbOZWm5Tw3rBdC3uq
	IQJ0BUlyseKMXmdkTRZLSkawjmyuAbFXu0zZjb8Zo/VdP0anjTSxei8fqRFe84t6u9fRD4
	WcPczDipxB6bdThSvMIuiY+tTZsSQ+Y=
Date: Tue, 9 Sep 2025 15:37:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v11 5/5] net: rnpgbe: Add register_netdev
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-6-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250909120906.1781444-6-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/09/2025 13:09, Dong Yibo wrote:
> Complete the network device (netdev) registration flow for Mucse Gbe
> Ethernet chips, including:
> 1. Hardware state initialization:
>     - Send powerup notification to firmware (via echo_fw_status)
>     - Sync with firmware
>     - Reset hardware
> 2. MAC address handling:
>     - Retrieve permanent MAC from firmware (via mucse_mbx_get_macaddr)
>     - Fallback to random valid MAC (eth_random_addr) if not valid mac
>       from Fw
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

[...]

> +struct mucse_hw;

why do you need this forward declaration ...> +
> +struct mucse_hw_operations {
> +	int (*reset_hw)(struct mucse_hw *hw);
> +	int (*get_perm_mac)(struct mucse_hw *hw);
> +	int (*mbx_send_notify)(struct mucse_hw *hw, bool enable, int mode);
> +};
> +
> +enum {
> +	mucse_fw_powerup,
> +};
> +
>   struct mucse_hw {
>   	void __iomem *hw_addr;
> +	struct pci_dev *pdev;
> +	const struct mucse_hw_operations *ops;
> +	struct mucse_dma_info dma;
>   	struct mucse_mbx_info mbx;
> +	int port;
> +	u8 perm_addr[ETH_ALEN];
>   	u8 pfvfnum;
>   };

... if you can simply move mucse_hw_operations down here?

>   
> @@ -54,4 +76,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
>   #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
>   #define PCI_DEVICE_ID_N210 0x8208
>   #define PCI_DEVICE_ID_N210L 0x820a
> +
> +#define rnpgbe_dma_wr32(dma, reg, val) \
> +	writel((val), (dma)->dma_base_addr + (reg))

[...]

> @@ -48,8 +127,14 @@ static void rnpgbe_init_n210(struct mucse_hw *hw)
>    **/
>   int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
>   {
> +	struct mucse_dma_info *dma = &hw->dma;
>   	struct mucse_mbx_info *mbx = &hw->mbx;
>   
> +	hw->ops = &rnpgbe_hw_ops;
> +	hw->port = 0;
> +
> +	dma->dma_base_addr = hw->hw_addr;

not quite sure why do you need additional structure just to store the
value that already exists in mucse_hw?

> +
>   	mbx->pf2fw_mbx_ctrl = MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
>   	mbx->fwpf_mbx_mask = MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
>   

