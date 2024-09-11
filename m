Return-Path: <netdev+bounces-127381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 964D19753DF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E288B2A52E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A90199945;
	Wed, 11 Sep 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KhA4Ybsr"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA719343E
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061191; cv=none; b=s5rKanl12Kx2A9whG9EfrpjCnLciNpIK9Qi3JWhuhMNg6ewUKAzeKevlNWUUPNKQIm9HUkB4M5ljovCfzv23Zz8E7VVv01f84VgA5/hxLQHO7EABINYxOwxV8nn1AXIuJDTf4VjtNGHrePoLXsaIQI1qYpsXkGvGZr6+LEyQUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061191; c=relaxed/simple;
	bh=UBymndhtkvmC1nOMit96Cuhufbrk1X3R0y5uRZ8931k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsSLleeLkIp+Yy/drdtbBIvdChvrWwmPwpUi6WzSieKg/wCdl20TRgggO0KUMyLj+zayBnOjBNteCfAUFVDFLl6/CDpsIf/OZSu3KWVaroFeYmiJhcfoxStxfP2iWCSTx15fBPRMO08/RFQbKUQdjHvrorTJvJ+MrSo1Ok6+w24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KhA4Ybsr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5fcb385-6694-41ce-9e25-17a937c41562@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726061186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxfAApnlhY8dUokp00VAiL4zNJbkr7tLu1oj1nqwMA4=;
	b=KhA4YbsrQ5MMoU4r5dGlqG2kVrnQW/l9SryNQG3fbfpQ/m9rtQqzyKKzb/d5m23AweHvSU
	QJVe1ev1nNCBIKe6DVk34hv8TTzQR2Ak2zzOxSlG2iGFozYiq79YF9+N6qjEufAU29nRkE
	xXSzr0ERGMXkegPgoYf/qrK+pKBFHQY=
Date: Wed, 11 Sep 2024 14:26:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ethernet: ag71xx: Remove dead code
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Chris Snook <chris.snook@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>
Cc: kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240911105924.4028423-1-usama.anjum@collabora.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240911105924.4028423-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/09/2024 11:59, Muhammad Usama Anjum wrote:
> The err variable isn't being used anywhere other than getting
> initialized to 0 and then it is being checked in if condition. The
> condition can never be true. Remove the err and deadcode.

Indeed, there is no code to set err to something meaningful.

> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/net/ethernet/atheros/ag71xx.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index db2a8ade62055..a90fc6834d53e 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1619,7 +1619,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
>   		unsigned int i = ring->curr & ring_mask;
>   		struct ag71xx_desc *desc = ag71xx_ring_desc(ring, i);
>   		int pktlen;
> -		int err = 0;
>   
>   		if (ag71xx_desc_empty(desc))
>   			break;
> @@ -1649,14 +1648,9 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
>   		skb_reserve(skb, offset);
>   		skb_put(skb, pktlen);
>   
> -		if (err) {
> -			ndev->stats.rx_dropped++;

I believe it's better to move this counter to if (!skb) block, otherwise
LGTM

> -			kfree_skb(skb);
> -		} else {
> -			skb->dev = ndev;
> -			skb->ip_summed = CHECKSUM_NONE;
> -			list_add_tail(&skb->list, &rx_list);
> -		}
> +		skb->dev = ndev;
> +		skb->ip_summed = CHECKSUM_NONE;
> +		list_add_tail(&skb->list, &rx_list);
>   
>   next:
>   		ring->buf[i].rx.rx_buf = NULL;


