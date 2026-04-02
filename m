Return-Path: <netdev+bounces-274352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJENBGPjzWlVigYAu9opvQ
	(envelope-from <netdev+bounces-274352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:32:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3593832EE
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAB17303F1FD
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 03:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4035A93C;
	Thu,  2 Apr 2026 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5apt1OP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9E287263;
	Thu,  2 Apr 2026 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100445; cv=none; b=BV3vUCDqE2PDr8Z/hMHKgzXr1tLl6CswCnBzvVnZrMTUOKxXlclgw98vUaV/4W6bbFW3mY4dyrRDH8ua1VLZwfCiQEtkb+IP9X23W7xCbwGjLAoSxYAH5ZAonbDolj5GofaT+07eDaxpwbM+zQPm7f7C/NnO6j0qW8sAyRDA11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100445; c=relaxed/simple;
	bh=qJWv9KrDea6c7T2o8i+rQnp2JrBZDqEJPBpIfIVHAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlMMrLsPHDCZAAmdTVmBsHMhdy2U1JCo0VAAh8OyIwiEmEM8ldWWAlsTLGjHwS7E6mLV4+VwkeLEOcYVMlkxYCxXOSv2h75aYEwsyLipcH/yv1YG6YXf3eiymiYUP9AEZImE4g0tShd7Zbggs7/cTGpAHqwJrnt3/woVyXL5bBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5apt1OP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E7AC4CEF7;
	Thu,  2 Apr 2026 03:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775100444;
	bh=qJWv9KrDea6c7T2o8i+rQnp2JrBZDqEJPBpIfIVHAPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5apt1OPKa8bvJxPAu8pcm3t/hwRWm7kwWiMfPD9QX0Dt31WvoNpFpAa3cnGtUuOu
	 N/w5493gsKLkl+IdBbeRV6InHpv3r4ac5EUQpiuu5zOp85Jpvm9DkuDHtqhOTne+Q5
	 GCcc2QWGPni3pNinxzjk9sRx36iJWLDjN6kC8DK1WWOd71jiRUFhrFy0HQs4kdElYc
	 6LzqgvnhCE1lCjWg5cwd5g6HdxJKbj5VCBhEJR4kfoC2YMsDKtUkRWpLCB4lNPRpTE
	 L2GqUpDcLieq4goxgsnCuA2kRCEV2ZQWSiLwCRNt+L2KLZHJT4KNikaOPpplYcPjZy
	 D2pCgraMmpQRA==
From: Jakub Kicinski <kuba@kernel.org>
To: nb@tipi-net.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	justin.chen@broadcom.com,
	horms@kernel.org,
	opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/6] net: bcmgenet: add XDP_TX support
Date: Wed,  1 Apr 2026 20:27:22 -0700
Message-ID: <20260402032722.905829-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328230513.415790-5-nb@tipi-net.de>
References: <20260328230513.415790-5-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-274352-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C3593832EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: bcmgenet: add XDP_TX support

This commit implements XDP_TX using ring 16, which is dedicated to XDP TX
for isolation from SKB TX queues. It also changes the page_pool DMA
direction to bidirectional to allow TX reuse of the existing DMA mapping.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index b45ba2c2857e..687c3b12d44f 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
[ ... ]
> @@ -2299,11 +2328,96 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
>  	return skb;
>  }
>  
> +static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
> +				     struct xdp_frame *xdpf, bool dma_map)
> +{
[ ... ]
> +	} else {
> +		struct page *page = virt_to_page(xdpf->data);
> +
> +		/* For local XDP_TX the caller already prepended the TSB
> +		 * into xdpf->data/len, so dma_len == xdpf->len.
> +		 */
> +		dma_len = xdpf->len;
> +		mapping = page_pool_get_dma_addr(page) +
> +			  sizeof(*xdpf) + xdpf->headroom;

When the RX page pool is created in bcmgenet_rx_ring_create_pool(), it is
initialized with .offset = GENET_XDP_HEADROOM. Does the DMA address
calculation here need to include this GENET_XDP_HEADROOM offset? Without it,
it appears the hardware might be given a DMA address that is 256 bytes
before the actual packet data, transmitting uninitialized memory.

[ ... ]
> @@ -2311,14 +2425,42 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
>  	switch (act) {
>  	case XDP_PASS:
>  		return XDP_PASS;
> +	case XDP_TX:
> +		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
> +		 * MAC has TBUF_64B_EN set globally, so hardware expects every
> +		 * TX buffer to begin with a 64-byte struct status_64.  Back
> +		 * up xdp->data into the RSB area (which is no longer needed
> +		 * after the BPF program ran) and zero it.
> +		 */
> +		if (xdp->data - xdp->data_hard_start <
> +		    sizeof(struct status_64)) {
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}
> +		xdp->data -= sizeof(struct status_64);
> +		xdp->data_meta -= sizeof(struct status_64);
> +		memset(xdp->data, 0, sizeof(struct status_64));
> +
> +		xdpf = xdp_convert_buff_to_frame(xdp);

Does this headroom check account for the additional sizeof(struct xdp_frame)
required by xdp_convert_buff_to_frame()? 

If metadata is present, xdp->data_meta could potentially underflow 
xdp->data_hard_start. If the remaining headroom minus metasize becomes
negative in xdp_convert_buff_to_frame(), could it undergo integer promotion
to a large unsigned value and bypass the internal safety check? This might
cause the struct xdp_frame to overwrite the newly zeroed status_64 block.

[ ... ]
> @@ -2556,9 +2698,15 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
>  {
>  	struct bcmgenet_rx_ring *ring = container_of(napi,
>  			struct bcmgenet_rx_ring, napi);
> +	struct bcmgenet_priv *priv = ring->priv;
>  	struct dim_sample dim_sample = {};
>  	unsigned int work_done;
>  
> +	/* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
> +	if (priv->xdp_prog)
> +		bcmgenet_tx_reclaim(priv->dev,
> +				    &priv->xdp_tx_ring, false);
> +

What happens to in-flight frames if the XDP program is detached at runtime
and priv->xdp_prog becomes NULL? Will this permanently lose track of the
page pool buffers and DMA mappings since the NAPI poll stops reclaiming
them?

Additionally, if the interface is the target of an XDP_REDIRECT from another
device, a local XDP program is not required and priv->xdp_prog could be
NULL. Does this mean the transmitted frames for redirected traffic will
never be reclaimed, eventually filling the TX ring?
-- 
pw-bot: cr

