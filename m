Return-Path: <netdev+bounces-224210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4842B823D6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9071C215B1
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D02FFDF7;
	Wed, 17 Sep 2025 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk/no6qr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610CC9478;
	Wed, 17 Sep 2025 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150566; cv=none; b=Ae6J8aW1FKKmk5zMNyt2DlYFZz5caDbh4ngpUdmxW7vsclMEKPdD31bsYCc1EsGM38NsJhxBIRdeqdIk6s2csz2OusaU4sFlx2yVjbrsmSisjKinX6aeL3TC/qk70smmYJR2m+WZxrIU3y7M/QwZIUqIkcaY3BG2iAMltCert+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150566; c=relaxed/simple;
	bh=zerxvYyolAtyuL1Q6v9wDtGesjVJpCy3HB084omosFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmeGuIZM2LoU6pNhaAYE+IlD03johdPxPi3TP/ezsPK1P92QZ7GvH03OPZh5PoBxMgTXTJcgKLq2+es/CBDy8G8WLaps4gmsux/5ttx/l5acahVcXmol1uV7BX32RxXJSD1w0PO6FLUNtNCzralsbwpk6VgHiItv2zBjx8BJPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk/no6qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A289C4CEE7;
	Wed, 17 Sep 2025 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758150565;
	bh=zerxvYyolAtyuL1Q6v9wDtGesjVJpCy3HB084omosFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vk/no6qrNhvzYahg8Sj0oWF0cOLVQFr4Hx4n6lLM9+8V2OSNw9L2ug6GVUXGFqG1E
	 s4+iHSOsv7w99CkY8wWELpODeOpvINCj9ns5bGRbVnprpDLqWH7UW7tIrjchFeDzxv
	 AjgrjENTEvTtwxFy0mxMxdvp5rgyYGhfGYcZpaNlSWbi+jfjnqQvAgkqh12eg2GwhL
	 VDcVzaMtbQQeMl2nqTwYhBb54WOuyIRQoGJR3GvnC5BtSG9YhXXjT+LKrbQrbySD2R
	 8ProUHCoTi37aHA4zr6KDHu/tjvfo6mK+LgyIy4R6lMC2t/yxRzMESwSwI32NRIRA/
	 PZHnhf19kxhQA==
Date: Wed, 17 Sep 2025 16:09:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: dlink: handle copy_thresh allocation
 failure
Message-ID: <20250917160924.6c2a5f47@kernel.org>
In-Reply-To: <20250916183305.2808-3-yyyynoom@gmail.com>
References: <20250916183305.2808-1-yyyynoom@gmail.com>
	<20250916183305.2808-3-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 03:33:05 +0900 Yeounsu Moon wrote:
> @@ -965,14 +965,11 @@ receive_packet (struct net_device *dev)
>  			struct sk_buff *skb;
>  
>  			/* Small skbuffs for short packets */
> -			if (pkt_len > copy_thresh) {
> -				dma_unmap_single(&np->pdev->dev,
> -						 desc_to_dma(desc),
> -						 np->rx_buf_sz,
> -						 DMA_FROM_DEVICE);
> -				skb_put(skb = np->rx_skbuff[entry], pkt_len);
> -				np->rx_skbuff[entry] = NULL;
> -			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
> +			if (pkt_len <= copy_thresh) {
> +				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
> +				if (!skb)
> +					goto fallback_to_normal_path;

The goto looks pretty awkward.

	skb = NULL;
	if (pkt_len <= copy_thresh)
		skb = netdev_alloc_skb_ip_align(dev, pkt_len);
	if (!skb) {
		// existing non-copy path
	} else {
		// existing copybreak path
	}

