Return-Path: <netdev+bounces-231680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580D4BFC88B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85465188977A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CBB34C822;
	Wed, 22 Oct 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmgWdvyy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5434B676;
	Wed, 22 Oct 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143029; cv=none; b=rNT1oLPTpzepMhmiCOEU84nn+WxL19oBYrP5ziWntrgVdpLCafyj/tGcc40JNrcXXdDmkF8h3lhj1vHbEsac+HXRClT4lUwyu5aySAZFLf3TgUfIj5BDybllAlhyWmGlzqNf43uhWuEp7U1ZM2zTCpq1M9EpnAX8xo/H2zpi7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143029; c=relaxed/simple;
	bh=g14dVRL9UcLqQAhoiCkffLwKcVRFh+iUcW6+TqdtP84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeQcTjePIrnSc5QKVda79xZX1jv2EzpftqmhT5eBE+45qzKdj/+NXqrNObGW9MML1UVmlBMOPk0VwtTDBAtRDLy8MJI732IPZEIHunXt1lSR+vjZHw66tYFt1P16nWf1zwpdv5GLF/spm7uheRQ6Svp1jq0QksA+zsteiCbHm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmgWdvyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC60C4CEE7;
	Wed, 22 Oct 2025 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143027;
	bh=g14dVRL9UcLqQAhoiCkffLwKcVRFh+iUcW6+TqdtP84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmgWdvyy8ZHjgsEAHal9RzTXMCtnVEshZ//9G8h2uqN385QCnzxl4jAPCarM4jfFM
	 iJ0iHPkgTkGApl/LGbHSn3/2XNDN6SH1tldpeo+VqV2q/JxLpuvMgFYy6N1tKWfWdj
	 4xlqTG7yIPqocYfjdbkpFjrIpIsBdDJ4jYnpPypvnpQ0Z4AZGrsyVVtkEpqYS+zSne
	 34juKfVb9eMUx0gqIE1rfO1F3qdnIo9SPSm+qIT3iG1h+RkmjzlFFPL3bNT04fFOvf
	 ZYSPgWBNd8rujqwNY9jDFqMBtcIL2KP6bILvt+Ne30jkT9AL1eBH0lF0zNITMowY8d
	 6VQgWOEukQjQA==
Date: Wed, 22 Oct 2025 15:23:43 +0100
From: Simon Horman <horms@kernel.org>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrey.bokhanko@huawei.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 1/8] ipvlan: Implement learnable L2-bridge
Message-ID: <aPjo76T8c8SbOB04@horms.kernel.org>
References: <20251021144410.257905-1-skorodumov.dmitry@huawei.com>
 <20251021144410.257905-2-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021144410.257905-2-skorodumov.dmitry@huawei.com>

On Tue, Oct 21, 2025 at 05:44:03PM +0300, Dmitry Skorodumov wrote:
> Now it is possible to create link in L2E mode: learnable
> bridge. The IPs will be learned from TX-packets of child interfaces.

Is there a standard for this approach - where does the L2E name come from?

> 
> Also, dev_add_pack() protocol is attached to the main port
> to support communication from main to child interfaces.
> 
> This mode is intended for the desktop virtual machines, for
> bridging to Wireless interfaces.
> 
> The mode should be specified while creating first child interface.
> It is not possible to change it after this.
> 
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>

...

> diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h

...

It is still preferred in networking code to linewrap lines
so that they are not wider than 80 columns, where than can be done without
reducing readability. Which appears to be the case here.

Flagged by checkpatch.pl --max-line-length=80

...
> diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c

...

> @@ -414,6 +426,77 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
>  	return addr;
>  }
>  
> +static inline bool is_ipv4_usable(__be32 addr)
> +{
> +	return !ipv4_is_lbcast(addr) && !ipv4_is_multicast(addr) &&
> +	       !ipv4_is_zeronet(addr);
> +}
> +
> +static inline bool is_ipv6_usable(const struct in6_addr *addr)
> +{
> +	return !ipv6_addr_is_multicast(addr) && !ipv6_addr_loopback(addr) &&
> +	       !ipv6_addr_any(addr);
> +}

Please don't use the inline keyword in .c files unless there
is a demonstrable reason to do so - usually performance.
Rather, please let the compiler inline functions as it sees fit.

> +
> +static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
> +			      int addr_type)
> +{
> +	void *addr = NULL;
> +	bool is_v6;
> +
> +	switch (addr_type) {
> +#if IS_ENABLED(CONFIG_IPV6)
> +	/* No need to handle IPVL_ICMPV6, since it never has valid src-address */
> +	case IPVL_IPV6: {
> +		struct ipv6hdr *ip6h;
> +
> +		ip6h = (struct ipv6hdr *)lyr3h;
> +		if (!is_ipv6_usable(&ip6h->saddr))

It is preferred to avoid #if / #ifdef in order to improve compile coverage
(and, I would argue, readability).

In this case I think that can be achieved by changing the line above to:

		if (!IS_ENABLED(CONFIG_IPV6) || !is_ipv6_usable(&ip6h->saddr))

I think it would be interesting to see if a similar approach can be used
to remove other #if CONFIG_IPV6 conditions in this file, and if successful
provide that as a clean-up as the opening patch in this series.

However, without that, I can see how one could argue for the approach
you have taken here on the basis of consistency.

> +			return;
> +		is_v6 = true;
> +		addr = &ip6h->saddr;
> +		break;
> +	}
> +#endif

...

> @@ -618,15 +701,56 @@ static int ipvlan_xmit_mode_l3(struct sk_buff *skb, struct net_device *dev)
>  
>  static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
>  {
> -	const struct ipvl_dev *ipvlan = netdev_priv(dev);
> -	struct ethhdr *eth = skb_eth_hdr(skb);
> -	struct ipvl_addr *addr;
>  	void *lyr3h;
> +	struct ipvl_addr *addr;
>  	int addr_type;
> +	bool same_mac_addr;
> +	struct ipvl_dev *ipvlan = netdev_priv(dev);
> +	struct ethhdr *eth = skb_eth_hdr(skb);

I realise that the convention is not followed in the existing code,
but please prefer to arrange local variables in reverse xmas tree order -
longest line to shortest.

In this case I think we can avoid moving things away
from that order like this (completely untested):

-	const struct ipvl_dev *ipvlan = netdev_priv(dev);
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ethhdr *eth = skb_eth_hdr(skb);
 	struct ipvl_addr *addr;
+	bool same_mac_addr;
 	void *lyr3h;
 	int addr_type;

Likewise elsewhere in this patch.

This too can be helpful in this area
github.com/ecree-solarflare/xmastree/commits/master/

> +
> +	if (ipvlan_is_learnable(ipvlan->port) &&
> +	    ether_addr_equal(eth->h_source, dev->dev_addr)) {
> +		/* ignore tx-packets from host */
> +		goto out_drop;
> +	}
> +
> +	same_mac_addr = ether_addr_equal(eth->h_dest, eth->h_source);
> +
> +	lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
>  
> -	if (!ipvlan_is_vepa(ipvlan->port) &&
> -	    ether_addr_equal(eth->h_dest, eth->h_source)) {
> -		lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
> +	if (ipvlan_is_learnable(ipvlan->port)) {
> +		if (lyr3h)
> +			ipvlan_addr_learn(ipvlan, lyr3h, addr_type);
> +		/* Mark SKB in advance */
> +		skb = skb_share_check(skb, GFP_ATOMIC);
> +		if (!skb)
> +			return NET_XMIT_DROP;

I think that when you drop packets a counter should be incremented.
Likewise elsewhere in this function.

> +		ipvlan_mark_skb(skb, ipvlan->phy_dev);
> +	}
> +
> +	if (is_multicast_ether_addr(eth->h_dest)) {
> +		skb_reset_mac_header(skb);
> +		ipvlan_skb_crossing_ns(skb, NULL);
> +		ipvlan_multicast_enqueue(ipvlan->port, skb, true);
> +		return NET_XMIT_SUCCESS;
> +	}
> +
> +	if (ipvlan_is_vepa(ipvlan->port))
> +		goto tx_phy_dev;
> +
> +	if (!same_mac_addr &&
> +	    ether_addr_equal(eth->h_dest, ipvlan->phy_dev->dev_addr)) {
> +		/* It is a packet from child with destination to main port.
> +		 * Pass it to main.
> +		 */
> +		skb = skb_share_check(skb, GFP_ATOMIC);
> +		if (!skb)
> +			return NET_XMIT_DROP;
> +		skb->pkt_type = PACKET_HOST;
> +		skb->dev = ipvlan->phy_dev;
> +		dev_forward_skb(ipvlan->phy_dev, skb);
> +		return NET_XMIT_SUCCESS;
> +	} else if (same_mac_addr) {
>  		if (lyr3h) {
>  			addr = ipvlan_addr_lookup(ipvlan->port, lyr3h, addr_type, true);
>  			if (addr) {
> @@ -649,16 +773,14 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
>  		 */
>  		dev_forward_skb(ipvlan->phy_dev, skb);
>  		return NET_XMIT_SUCCESS;
> -
> -	} else if (is_multicast_ether_addr(eth->h_dest)) {
> -		skb_reset_mac_header(skb);
> -		ipvlan_skb_crossing_ns(skb, NULL);
> -		ipvlan_multicast_enqueue(ipvlan->port, skb, true);
> -		return NET_XMIT_SUCCESS;
>  	}
>  
> +tx_phy_dev:
>  	skb->dev = ipvlan->phy_dev;
>  	return dev_queue_xmit(skb);
> +out_drop:
> +	consume_skb(skb);
> +	return NET_XMIT_DROP;
>  }
>  
>  int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)

...

> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c

...

> +static int ipvlan_port_receive(struct sk_buff *skb, struct net_device *wdev,
> +			       struct packet_type *pt, struct net_device *orig_wdev)
> +{
> +	struct ipvl_port *port;
> +	struct ipvl_addr *addr;
> +	struct ethhdr *eth;
> +	void *lyr3h;
> +	int addr_type;
> +
> +	port = container_of(pt, struct ipvl_port, ipvl_ptype);
> +	/* We are interested only in outgoing packets.
> +	 * rx-path is handled in rx_handler().
> +	 */
> +	if (skb->pkt_type != PACKET_OUTGOING || ipvlan_is_skb_marked(skb, port->dev))
> +		goto out;
> +
> +	skb = skb_share_check(skb, GFP_ATOMIC);
> +	if (!skb)
> +		goto no_mem;
> +
> +	/* data should point to eth-header */
> +	skb_push(skb, skb->data - skb_mac_header(skb));
> +	skb->dev = port->dev;
> +	eth = eth_hdr(skb);
> +
> +	if (is_multicast_ether_addr(eth->h_dest)) {
> +		ipvlan_skb_crossing_ns(skb, NULL);
> +		skb->protocol = eth_type_trans(skb, skb->dev);
> +		skb->pkt_type = PACKET_HOST;
> +		ipvlan_mark_skb(skb, port->dev);
> +		ipvlan_multicast_enqueue(port, skb, false);
> +		return 0;
> +	}
> +
> +	lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
> +	if (!lyr3h)
> +		goto out;
> +
> +	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
> +	if (addr) {
> +		int ret, len;
> +
> +		ipvlan_skb_crossing_ns(skb, addr->master->dev);
> +		skb->protocol = eth_type_trans(skb, skb->dev);
> +		skb->pkt_type = PACKET_HOST;
> +		ipvlan_mark_skb(skb, port->dev);
> +		len = skb->len + ETH_HLEN;
> +		ret = netif_rx(skb);
> +		ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, false);

This fails to build because ipvlan is not declared in this scope.
Perhaps something got missed due to an edit?

> +		return 0;
> +	}
> +
> +out:
> +	dev_kfree_skb(skb);
> +no_mem:
> +	return 0; // actually, ret value is ignored

Maybe, but it seems to me that the return values
should follow that of netif_receive_skb_core().

> +}

...

-- 
pw-bot: changes-requested

