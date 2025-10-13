Return-Path: <netdev+bounces-228697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5254BD267F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96DCB4EFF64
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD562FE568;
	Mon, 13 Oct 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7RzKICS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB382FE057;
	Mon, 13 Oct 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349477; cv=none; b=sI6jgONn/zyjbp2KJisQB+v0fdUjgPnyfTcRNsj3I/4/LaDqZcr+8OHImga8KUjXXdY4twV3ghKiBUOrt7F+Or1jmBhbVsf0VQ6Y4KHvceB2kbPXKqDuuINWFiUTRqO8RKPbxDadzz2MN9vHdpGVrF5QDbsihofxEgx5iivb3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349477; c=relaxed/simple;
	bh=cG98byYrGX9rPpewaMCzlz+Uar8I0vW2qQjwEuS4DPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJbWlUOJa5gzohLMKnicTYE1hm1jfROYbv4kFgiL1DeWt2qTfxHFHEy8IYoCjC3PCTAo85mhJ1vpHf5jBhFGodMKeUkCcpVdJCGsIFy74RtPF1BUFa6Zls2YU/c62rSB9Jkdpi+gTXwVMyyEcAB7JJdFkSGT/hVPx6b4my/F91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7RzKICS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85C2C116D0;
	Mon, 13 Oct 2025 09:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760349476;
	bh=cG98byYrGX9rPpewaMCzlz+Uar8I0vW2qQjwEuS4DPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7RzKICSYz+X+posoS/nfMrtQwCKqt6GrHl3rH3i0bo3u9Qs5zcx6rQ9FN+vjMeTu
	 FKYv8jvKfp0xSsYDFixjEJtlf3TE7rhu3imoFF/8woGVQ1tJpMRDRnER2bL5iLSUku
	 tkBWJ/OBCVRbmLbYIa1yGJyeJP8+uclg6omOh1zqmgHLHj3rJOC92fg9UPjmL6Q247
	 XBDAtRY9hcqingbzAr4DAPBIe5s9k8ESkz41n9+tA1d7ZIiZ8jLWB1l+kuBOCMz0wW
	 NbklagtkrFLFn2WdM5R2OmHSY0czWLeF4S3sWFmq6vYVeRkSVAeOdsAK42F/IP+3qH
	 Ti3aqDUr6RTxQ==
Date: Mon, 13 Oct 2025 10:57:51 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: rtl8150: Fix frame padding
Message-ID: <aOzNH0OQZYJYS1IT@horms.kernel.org>
References: <20251012220042.4ca776b1.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012220042.4ca776b1.michal.pecio@gmail.com>

On Sun, Oct 12, 2025 at 10:00:42PM +0200, Michal Pecio wrote:
> TX frames aren't padded and unknown memory is sent into the ether.
> 
> Theoretically, it isn't even guaranteed that the extra memory exists
> and can be sent out, which could cause further problems. In practice,
> I found that plenty of tailroom exists in the skb itself (in my test
> with ping at least) and skb_padto() easily succeeds, so use it here.
> 
> In the event of -ENOMEM drop the frame like other drivers do.
> 
> The use of one more padding byte instead of a USB zero-length packet
> is retained to avoid regression. I have a dodgy Etron xHCI controller
> which doesn't seem to support sending ZLPs at all.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> ---
>  drivers/net/usb/rtl8150.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 92add3daadbb..d6dce8babae0 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -685,9 +685,14 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
>  	rtl8150_t *dev = netdev_priv(netdev);
>  	int count, res;
>  
> +	/* pad the frame and ensure terminating USB packet, datasheet 9.2.3 */
> +	count = max(skb->len, ETH_ZLEN);
> +	if (count % 64 == 0)
> +		count++;
> +	if (skb_padto(skb, count))
> +

Hi Michal,

I think this should also increment a dropped counter.
As this driver already uses dev->netdev->stats [*]
I think that would be:

		dev->netdev->stats.tx_dropped++;

[*] I specifically mention this, for the record because,
    new users are discouraged. But this driver is an existing user
    so I think we are ok.

> +		return NETDEV_TX_OK;
>  	netif_stop_queue(netdev);
> -	count = (skb->len < 60) ? 60 : skb->len;
> -	count = (count & 0x3f) ? count : count + 1;
>  	dev->tx_skb = skb;
>  	usb_fill_bulk_urb(dev->tx_urb, dev->udev, usb_sndbulkpipe(dev->udev, 2),
>  		      skb->data, count, write_bulk_callback, dev);
> -- 
> 2.48.1
> 

