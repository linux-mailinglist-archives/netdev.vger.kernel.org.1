Return-Path: <netdev+bounces-127797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E139768B4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16861F286DF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C885C1A302B;
	Thu, 12 Sep 2024 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajk7wXdU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE27288BD;
	Thu, 12 Sep 2024 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142815; cv=none; b=spbgFBlt1qFSmMaibINCpufqBz+7xTwFj4meVol0AtV5+oMPTNTIcLmC+Q46cpymz5lVEaa/tXlk9SX7zqzEVeEKWq/WzWgna7tkR1W+wlGhw7Zei2hWi7v2eF7I+jxZw+1FUJim1qiD4VhpTHMwOOHCduEcHHwu2j8t7TFSqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142815; c=relaxed/simple;
	bh=3gEYxdKITE9bSx6s7salL3QkKWEweio8sGwWyG+ZYvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdyrJuNIbXXnZlRhYMvzhXraBv/44b74n1GkDwMxjmWMsyYp/99scmRSuMWWBd0qaCaNEZwBMk+PsW4odck0Y7tQ/qM4s8EcoSfBhL/yoF+xh5p1hr0NTdWsCribdXdP8eVRT+4aifcOMXoM0V1+Fll9NzSq+VAHSd4Gq64MiHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajk7wXdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DCFC4CEC3;
	Thu, 12 Sep 2024 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726142815;
	bh=3gEYxdKITE9bSx6s7salL3QkKWEweio8sGwWyG+ZYvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajk7wXdUDAjpSVxvXuYLE51TI1c8VoinPIDrSCX9hMizIjOJTdLgRugxCjGnfODzg
	 qa4VbhlryM8/315NDA/q+KB0qmOaRuQ4gFpIDQlyIDPFa/vKMRlkldi9Jv9iGcPZb7
	 JLyQz246GznxS2dcVxM3fSTz0YXexmxGGdrh53R4NMJLYbsL/BWOTnWDp/thOH/q/m
	 LOEw8Q1Wehvh6ZHLLheP7Hi5kmq1oarpeeXrrDma523JHvKgngdTDs/Lx6M5K0kh/x
	 Ruca7rEeUQv0eAvHub91DvpE9zDZ+5vV4dWoluT2rKbHA59ocx4CSq7iwRbIdrSytM
	 swJ3boIm9Bovw==
Date: Thu, 12 Sep 2024 13:06:51 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net: ks8851: use %*ph to print small
 buffer
Message-ID: <20240912120651.GL572255@kernel.org>
References: <20240911193630.2884828-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911193630.2884828-1-andriy.shevchenko@linux.intel.com>

On Wed, Sep 11, 2024 at 10:36:30PM +0300, Andy Shevchenko wrote:
> Use %*ph format to print small buffer as hex string.

Hi Andy,

Perhaps it would be worth mentioning that this patch
changes the output format such that there is a space
between each byte rather than each 32-bit word.

Or at least, that is what a local hack on my side indicated
things would look like :)

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/micrel/ks8851_common.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
> index 7fa1820db9cc..a07ffc53da64 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -215,22 +215,6 @@ static void ks8851_init_mac(struct ks8851_net *ks, struct device_node *np)
>  	ks8851_write_mac_addr(dev);
>  }
>  
> -/**
> - * ks8851_dbg_dumpkkt - dump initial packet contents to debug
> - * @ks: The device state
> - * @rxpkt: The data for the received packet
> - *
> - * Dump the initial data from the packet to dev_dbg().
> - */
> -static void ks8851_dbg_dumpkkt(struct ks8851_net *ks, u8 *rxpkt)
> -{
> -	netdev_dbg(ks->netdev,
> -		   "pkt %02x%02x%02x%02x %02x%02x%02x%02x %02x%02x%02x%02x\n",
> -		   rxpkt[4], rxpkt[5], rxpkt[6], rxpkt[7],
> -		   rxpkt[8], rxpkt[9], rxpkt[10], rxpkt[11],
> -		   rxpkt[12], rxpkt[13], rxpkt[14], rxpkt[15]);
> -}
> -
>  /**
>   * ks8851_rx_pkts - receive packets from the host
>   * @ks: The device information.
> @@ -296,8 +280,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks, struct sk_buff_head *rxq)
>  
>  				ks->rdfifo(ks, rxpkt, rxalign + 8);
>  
> -				if (netif_msg_pktdata(ks))
> -					ks8851_dbg_dumpkkt(ks, rxpkt);
> +				netif_dbg(ks, pktdata, ks->netdev, "pkt %12ph\n", &rxpkt[4]);

nit: I would have line wrapped this so it is <= 80 columns wide.

>  
>  				skb->protocol = eth_type_trans(skb, ks->netdev);
>  				__skb_queue_tail(rxq, skb);
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 
> 

