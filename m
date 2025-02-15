Return-Path: <netdev+bounces-166641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A804EA36BBC
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 04:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B673B2D16
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 03:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42EF1624EF;
	Sat, 15 Feb 2025 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl9tbhww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09515852E;
	Sat, 15 Feb 2025 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591133; cv=none; b=nFnlyBX9qZUDbejTAwPlsz4K11dKliyuccaXP0uJ2U9ui5gYIO85UZFb4N+ZDmFA14y3h77YBx+ZXAg3nKQTu7FCimZvhEemrYFEqVOdrJoaHjJ5Nsu3i84p1O7mDsWWnGfXqQoIP8h+xYx3lanD2736ff4h3O9lccMhVv9sl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591133; c=relaxed/simple;
	bh=tIL0LT7dFqfmVwthslEUsLmqHfP7k/0EsTG3goocaPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQIuuyteDGAiXUQXQWpUTae3dWXIs/LdqujWYRWLg4oNZtKNLTAyOSNNBAM+STR9BkZY+b03w5aBlkJpmbRNwycRoGH6A+U0EOQtuQsNprkjJNeNknB2nHwXKbxVYtqdj/M/VwSq+vORrUUFksinMeLzyB8iVINUqREASyfBqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl9tbhww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE590C4CEE4;
	Sat, 15 Feb 2025 03:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739591133;
	bh=tIL0LT7dFqfmVwthslEUsLmqHfP7k/0EsTG3goocaPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pl9tbhwwjeSUIjc0TgKxDuUz6dVX5GE/HkujzxESlxozp0q8QK647dlJ4yjfmOiT8
	 f9ErdmmakayomSpEBdjtJ8AN1XCqVvYk+vHNJRzuz80pjRY7on8Hodq/Za79l8/+fd
	 iGYJE84wLf/IABivqgFH5WUZM8MBXz3+UJRu0Jfr9+iCj0BUTcPeVKEsbIDoy7qZyO
	 QtZwmRzDpa/V6UzvfPS/ACT3MLj5bd0HivmdFOCoRCLRXukk57clwdE8BTKtBuflJ1
	 JW4+ZI50Rx8dNKiyqwURLF94/1Kfa8oQ4yqwGpZOZ7sxH1O57p+iyYXjLWOxG0ljaA
	 fLX44K4UlT7Hw==
Date: Fri, 14 Feb 2025 19:45:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next v2 2/2] net: mctp: Add MCTP USB transport
 driver
Message-ID: <20250214194531.5ddded19@kernel.org>
In-Reply-To: <20250212-dev-mctp-usb-v2-2-76e67025d764@codeconstruct.com.au>
References: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
	<20250212-dev-mctp-usb-v2-2-76e67025d764@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 10:46:51 +0800 Jeremy Kerr wrote:
> +	__u8 ep_in;
> +	__u8 ep_out;

same nit about u8 as on the header

> +	struct urb *tx_urb;
> +	struct urb *rx_urb;
> +};
> +
> +static void mctp_usb_stat_tx_dropped(struct net_device *dev)
> +{
> +	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
> +
> +	u64_stats_update_begin(&dstats->syncp);
> +	u64_stats_inc(&dstats->tx_drops);
> +	u64_stats_update_end(&dstats->syncp);
> +}

Letter for letter dev_dstats_tx_dropped() ?

> +static void mctp_usb_stat_tx_done(struct net_device *dev, unsigned int len)
> +{
> +	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
> +
> +	u64_stats_update_begin(&dstats->syncp);
> +	u64_stats_inc(&dstats->tx_packets);
> +	u64_stats_add(&dstats->tx_bytes, len);
> +	u64_stats_update_end(&dstats->syncp);
> +}

And this dev_dstats_tx_add() ?

> +static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	struct mctp_usb *mctp_usb = netdev_priv(dev);
> +	struct mctp_usb_hdr *hdr;
> +	unsigned int plen;
> +	struct urb *urb;
> +	int rc;
> +
> +	plen = skb->len;
> +
> +	if (plen + sizeof(*hdr) > MCTP_USB_XFER_SIZE)
> +		goto err_drop;
> +
> +	hdr = skb_push(skb, sizeof(*hdr));

Hm, I guess MCTP may have its own rules but technically you should
call skb_cow_head() before you start writing to the header buffer.

> +	if (!hdr)
> +		goto err_drop;
> +
> +	hdr->id = cpu_to_be16(MCTP_USB_DMTF_ID);
> +	hdr->rsvd = 0;
> +	hdr->len = plen + sizeof(*hdr);

> +static void mctp_usb_in_complete(struct urb *urb)
> +{
> +	struct sk_buff *skb = urb->context;
> +	struct net_device *netdev = skb->dev;
> +	struct pcpu_dstats *dstats = this_cpu_ptr(netdev->dstats);
> +	struct mctp_usb *mctp_usb = netdev_priv(netdev);
> +	struct mctp_skb_cb *cb;
> +	unsigned int len;
> +	int status;
> +

> +		u64_stats_update_begin(&dstats->syncp);
> +		u64_stats_inc(&dstats->rx_packets);
> +		u64_stats_add(&dstats->rx_bytes, skb->len);
> +		u64_stats_update_end(&dstats->syncp);

dev_dstats_rx_add()

> +		skb->protocol = htons(ETH_P_MCTP);
> +		skb_reset_network_header(skb);
> +		cb = __mctp_cb(skb);
> +		cb->halen = 0;
> +		netif_rx(skb);
> +
> +		skb = skb2;
> +	}
> +
> +	if (skb)
> +		kfree_skb(skb);
> +
> +	mctp_usb_rx_queue(mctp_usb, GFP_ATOMIC);

What if we fail to allocate an skb ?
Admittedly the buffers are relatively small but if the allocation
fails we'd get stuck, no more packets will ever be received, right?
May be safer to allocate the skb first, and if it fails reuse the
skb that just completed (effectively discarding the incoming packets
until a replacement buffer can be allocated).

> +}

> +	dev->hard_header_len = sizeof(struct mctp_usb_hdr);
> +	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
> +	dev->addr_len = 0;
> +	dev->flags = IFF_NOARP;
> +	dev->netdev_ops = &mctp_usb_netdev_ops;
> +	dev->needs_free_netdev = false;

Is there a reason to set this to false?
dev memory is guaranteed to be zero'ed out.

> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> +}
-- 
pw-bot: cr


