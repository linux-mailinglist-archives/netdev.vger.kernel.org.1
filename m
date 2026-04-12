Return-Path: <netdev+bounces-277878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBJJLxnx22niJAkAu9opvQ
	(envelope-from <netdev+bounces-277878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:23:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 326083E5B00
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B903300A63B
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98405301474;
	Sun, 12 Apr 2026 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAJi5m2U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B963D994;
	Sun, 12 Apr 2026 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021781; cv=none; b=JlPoxmqVtrQcvQx+jl+ezhrvaQUEPFTTM7G9Gf3qLMcGY/qj2NeGM8n9dgez8eiDon/NLK6uZf4lB8jT+NK5FYwLYNDiPRpFiQILMupGXHYVka1haRpfufeKcjqadZbEEeyVLa8c08sWwXLIqa0H7gsrWsrb+lYxN04wJ8fS//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021781; c=relaxed/simple;
	bh=zu0lIJQUIewV/SiTFI+WoMVAaMwpj9KsyR9cAaBeAAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5fiavCQoAt9y3G6HCU3D5GHZFse1IdtddTncjClD2vqMO920QLRbmF8+JgmbU2IZan42jCyRcfIerfxwc1DNdxXQpow8m28dBNyTPWElmhwT7kqyMdRszUM72Y77wGQlQV6sEA/dvRTNHN8mXAKUGhHnDKTWWXiDiuKSeNhp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAJi5m2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E44EC19424;
	Sun, 12 Apr 2026 19:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776021781;
	bh=zu0lIJQUIewV/SiTFI+WoMVAaMwpj9KsyR9cAaBeAAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WAJi5m2UchIYvwnd/3sOCW2Pbs1kSbs+ASTpJ4/aQjSD8yW0GZc532LonkUAQxChA
	 JvQTmIXvJTTUGPkvu5pmJ8MLM1d9j4XhPbDD7sP4HlA21PgPS3SPY2V2BjgacWANpR
	 NZ/tkq6vpw0EumfNQ+beba+1/mFT5fps4N2dD/kuLfI8o77PpiBvWuiIxAwRfAbNQN
	 pPbRK7zlczcK7J8PNjE5Ottn98LQ11JpCqmKpKINQ1cbYsXH1tBYWcy11rkFFEs+pF
	 XTWgDwmHWMMSj31IXq0+tLYeGKk+Rz63IxvaGKq9uXNOz8J+7/asVsjdi+CI47M37A
	 LeuLZevET20kA==
Date: Sun, 12 Apr 2026 12:22:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, Simon
 Horman <horms@kernel.org>, Mohsin Bashir <mohsin.bashr@gmail.com>, Doug
 Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/7] net: bcmgenet: add basic XDP support
 (PASS/DROP)
Message-ID: <20260412122258.3a7ffd87@kernel.org>
In-Reply-To: <20260406083536.839517-4-nb@tipi-net.de>
References: <20260406083536.839517-1-nb@tipi-net.de>
	<20260406083536.839517-4-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277878-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 326083E5B00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  6 Apr 2026 10:35:27 +0200 Nicolai Buchwitz wrote:
> Add XDP program attachment via ndo_bpf and execute XDP programs in the
> RX path. XDP_PASS builds an SKB from the xdp_buff (handling
> xdp_adjust_head/tail), XDP_DROP returns the page to page_pool without
> SKB allocation.
> 
> XDP_TX and XDP_REDIRECT are not yet supported and return XDP_ABORTED.
> 
> Advertise NETDEV_XDP_ACT_BASIC in xdp_features.


> -		skb_mark_for_recycle(skb);
> -
> -		/* Reserve the RSB + pad, then set the data length */
> -		skb_reserve(skb, GENET_RSB_PAD);
> -		__skb_put(skb, len - GENET_RSB_PAD);
> +		{

floating code blocks are considered poor coding style in the kernel
Why not push the variables up into the outer scope or make this 
a helper?

> +			struct xdp_buff xdp;
> +			unsigned int xdp_act;
> +			int pkt_len;
> +
> +			pkt_len = len - GENET_RSB_PAD;
> +			if (priv->crc_fwd_en)
> +				pkt_len -= ETH_FCS_LEN;
> +
> +			/* Save rx_csum before XDP runs - an XDP program
> +			 * could overwrite the RSB via bpf_xdp_adjust_head.
> +			 */
> +			if (dev->features & NETIF_F_RXCSUM)
> +				rx_csum = (__force __be16)(status->rx_csum
> +							   & 0xffff);

FWIW this could be before the block

> +			xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
> +			xdp_prepare_buff(&xdp, page_address(rx_page),
> +					 GENET_RX_HEADROOM, pkt_len, true);
> +
> +			if (xdp_prog) {
> +				xdp_act = bcmgenet_run_xdp(ring, xdp_prog,
> +							   &xdp, rx_page);

Since you pass the xdp_prog in you can save yourself the indentation by
making bcmgenet_run_xdp() return PASS when no program is set.
bcmgenet_run_xdp() has one caller, it's going to get inlined.

> +				if (xdp_act != XDP_PASS)
> +					goto next;
> +			}
>  
> -		if (priv->crc_fwd_en) {
> -			skb_trim(skb, skb->len - ETH_FCS_LEN);
> +			skb = bcmgenet_xdp_build_skb(ring, &xdp);
> +			if (unlikely(!skb)) {
> +				BCMGENET_STATS64_INC(stats, dropped);
> +				page_pool_put_full_page(ring->page_pool,
> +							rx_page, true);
> +				goto next;
> +			}
>  		}
>  
>  		/* Set up checksum offload */
>  		if (dev->features & NETIF_F_RXCSUM) {
> -			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
>  			if (rx_csum) {
>  				skb->csum = (__force __wsum)ntohs(rx_csum);
>  				skb->ip_summed = CHECKSUM_COMPLETE;
> @@ -3744,6 +3810,37 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
>  	return 0;
>  }
>  
> +static int bcmgenet_xdp_setup(struct net_device *dev,
> +			      struct netdev_bpf *xdp)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bpf_prog *old_prog;
> +	struct bpf_prog *prog = xdp->prog;
> +
> +	if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {

I'm confused by this check, it appears that the max page size this
driver can Rx in the first place is 2kB (RX_BUF_LENGTH). And max_mtu 
is 1.5kB.

If GENET_RX_HEADROOM + SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
is larger than 2kB the Rx path will break completely whether XDP was
attached or not.

This check seems to be cargo culting what other drivers do?

