Return-Path: <netdev+bounces-214241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFAFB289A4
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64ECB5A1B2B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8961369B4;
	Sat, 16 Aug 2025 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTpMemuT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF326290;
	Sat, 16 Aug 2025 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755308041; cv=none; b=JYMBH6UwXMqftMpufr28tBdZUUGe+ttItnUmOFLd3xhowotDUWUS+5wMmpIWN/qwyr4tFla4vbX0jKkN5opzZilP4k9wYgx8yLmrGueQH/k6rv6JbH2ukrC2chxBZMCqQiTx01H0v/6cyPS4yNZev/pkZympA73tG6o8fuR0t98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755308041; c=relaxed/simple;
	bh=QAU67ghT7uJFx7o0i6RFgiTCA5x0lDgncw00VvbV1wE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNNW3nXOcWqWvIsQ/yUXmMz0x95JfG8Io5V62unwk9JdB7dC6alIzhGUMqU6hBokSGwYiSzx1sbN6LKYh+J2F58EYXyGDQRU8Z+OpjVTI7wXW5CAyM1ZtAZ0bp8c1xUcUQasc9hsCELPSB2HWo7wbDrrxVA4+C1cx+h6Sa5c+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTpMemuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC64FC4CEEB;
	Sat, 16 Aug 2025 01:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755308040;
	bh=QAU67ghT7uJFx7o0i6RFgiTCA5x0lDgncw00VvbV1wE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iTpMemuTse99V3Ddi/QFoLd7riwysF0dE0pOZPaMpZdDhuP/IWagkgtbjkiOoUCmt
	 1ILIFUJGphVjvIwAfjTfK4V1lTkYRlFpYSuLe7htGRazss0dBeVtsAUZ3GDm0QfCmD
	 BkvrBs/yEeDIxh81jESYEEJYjmNPi7ENJJ4vXsmm9SNls79hUEo/aWOpLFcsQbUoMR
	 2ACHvrbLIYRGP9+XgCOog1olZujzz+BD6VcRb7tLVg3Ijoj4rK9923gTmkJgPwOCrl
	 ywmkSHvfwBqGiZU/zQXJmpLgVRGv7hzhrX1UVBttpNg/ejMqYYxaFjWsYdFLnV72DG
	 zUJg9Do1WGv2A==
Date: Fri, 15 Aug 2025 18:33:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v18 5/7] net: mtip: Add mtip_switch_{rx|tx} functions
 to the L2 switch driver
Message-ID: <20250815183359.352a0ecb@kernel.org>
In-Reply-To: <20250813070755.1523898-6-lukasz.majewski@mailbox.org>
References: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
	<20250813070755.1523898-6-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 09:07:53 +0200 Lukasz Majewski wrote:
> +		page = fep->page[bdp - fep->rx_bd_base];
> +		/* Process the incoming frame */
> +		pkt_len = bdp->cbd_datlen;
> +
> +		dma_sync_single_for_cpu(&fep->pdev->dev, bdp->cbd_bufaddr,
> +					pkt_len, DMA_FROM_DEVICE);
> +		net_prefetch(page_address(page));
> +		data = page_address(page);
> +
> +		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +			swap_buffer(data, pkt_len);
> +
> +		eth_hdr = (struct ethhdr *)data;
> +		mtip_atable_get_entry_port_number(fep, eth_hdr->h_source,
> +						  &rx_port);
> +		if (rx_port == MTIP_PORT_FORWARDING_INIT)
> +			mtip_atable_dynamicms_learn_migration(fep,
> +							      mtip_get_time(),
> +							      eth_hdr->h_source,
> +							      &rx_port);
> +
> +		if ((rx_port == 1 || rx_port == 2) && fep->ndev[rx_port - 1])
> +			pndev = fep->ndev[rx_port - 1];
> +		else
> +			pndev = dev;
> +
> +		*port = rx_port;
> +
> +		/* This does 16 byte alignment, exactly what we need.
> +		 * The packet length includes FCS, but we don't want to
> +		 * include that when passing upstream as it messes up
> +		 * bridging applications.
> +		 */
> +		skb = netdev_alloc_skb(pndev, pkt_len + NET_IP_ALIGN);
> +		if (unlikely(!skb)) {
> +			dev_dbg(&fep->pdev->dev,
> +				"%s: Memory squeeze, dropping packet.\n",
> +				pndev->name);
> +			page_pool_recycle_direct(fep->page_pool, page);
> +			pndev->stats.rx_dropped++;
> +			return -ENOMEM;
> +		}
> +
> +		skb_reserve(skb, NET_IP_ALIGN);
> +		skb_put(skb, pkt_len);      /* Make room */
> +		skb_copy_to_linear_data(skb, data, pkt_len);
> +		skb->protocol = eth_type_trans(skb, pndev);
> +		skb->offload_fwd_mark = fep->br_offload;
> +		napi_gro_receive(&fep->napi, skb);

The rx buffer circulation is very odd. You seem to pre-allocate buffers
for the full ring from a page_pool. And then copy the data out of those
pages. The normal process is that after packet is received a new page is
allocated to give to HW, and old is attached to an skb, and sent up the
stack.

Also you are releasing the page to be recycled without clearing it from
the ring. I think you'd free it again on shutdown, so it's a
double-free.
-- 
pw-bot: cr

