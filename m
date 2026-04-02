Return-Path: <netdev+bounces-274421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLpdMBIozmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:25:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0E385FA4
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 980B93044B7B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D663603D1;
	Thu,  2 Apr 2026 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="TDFOXP0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404930276A;
	Thu,  2 Apr 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117997; cv=none; b=PbXP+kPgSc5eW99+ieoS4gT6TsAGVwigT3ncA5cKzkmpVKsWzl6MW8/3SEDOVeIicPHWbWMDKNobTQMOBXDjPMYK1ZV663roof6lcZKupExAuGpwDkPvtRg3/f6Jlfc/KJwOwMyIL1FXuR6lQaJUctN9E5iEeZsK1ylwmtuEdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117997; c=relaxed/simple;
	bh=cHZTSUwDXfFNbumoLgzKe705GExS6CeHXehC56/l7oE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OHr9+6bjMdhnDLbQTWHCzUUgQiOt8jYQXgDU6lkiopIx7a8X4CK/tfr1xzYhzVsjNuKKSa/bPGZjEQz9QxmYGvv+0Ppv5WXVc/EaWzlb6lFQEZSYLSPboHE3m3P0asGBbVOP/Svx8VwvDdYW9bdYAThptZF9sYR8J301+OTNnRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=TDFOXP0y; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70C46A5889;
	Thu,  2 Apr 2026 10:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775117990; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7FmUTRudoDjBs2TfT2uUEICTUomf7L/YVLbRjYx6tJI=;
	b=TDFOXP0ynnwrqV3WVem9dZiqeTilrjd/6e2EHtQ7/3LKacVF8ZZFAyYdtkBEdoQu/IFcW9
	oHvMreYaERytp6zxDmulX+TZcgFrOkn0K9xyVaYMhqqslsoufdlCcun+4z6a4aQuNGpqSf
	G4SDHEyd+shU9a7n53CfHG3YEoSLRN/7R+QO7n83/zOoStjjFWeJgZcXMG6uVOeO9i0yFO
	bSLnrUFs6F7t16wGNEA84wFFwzBZCL63UAQuUE2J40qgT12fXrCFumD+5a88Fjsqe8UboV
	Je4taX7DaZrgo9Hp8CcvjGZEFXIB1c22eGPJ4Z6UUgJfKRD1w6nBQDXMmepWmw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 10:19:46 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com, horms@kernel.org,
 opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/6] net: bcmgenet: add XDP_TX support
In-Reply-To: <20260402032722.905829-1-kuba@kernel.org>
References: <20260328230513.415790-5-nb@tipi-net.de>
 <20260402032722.905829-1-kuba@kernel.org>
Message-ID: <36659d94abbf4c9a078ce71f64b12bfa@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 3EC0E385FA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2.4.2026 05:27, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: bcmgenet: add XDP_TX support
> 
> This commit implements XDP_TX using ring 16, which is dedicated to XDP 
> TX
> for isolation from SKB TX queues. It also changes the page_pool DMA
> direction to bidirectional to allow TX reuse of the existing DMA 
> mapping.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index b45ba2c2857e..687c3b12d44f 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> [ ... ]
>> @@ -2299,11 +2328,96 @@ static struct sk_buff 
>> *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
>>  	return skb;
>>  }
>> 
>> +static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
>> +				     struct xdp_frame *xdpf, bool dma_map)
>> +{
> [ ... ]
>> +	} else {
>> +		struct page *page = virt_to_page(xdpf->data);
>> +
>> +		/* For local XDP_TX the caller already prepended the TSB
>> +		 * into xdpf->data/len, so dma_len == xdpf->len.
>> +		 */
>> +		dma_len = xdpf->len;
>> +		mapping = page_pool_get_dma_addr(page) +
>> +			  sizeof(*xdpf) + xdpf->headroom;
> 
> When the RX page pool is created in bcmgenet_rx_ring_create_pool(), it 
> is
> initialized with .offset = GENET_XDP_HEADROOM. Does the DMA address
> calculation here need to include this GENET_XDP_HEADROOM offset? 
> Without it,
> it appears the hardware might be given a DMA address that is 256 bytes
> before the actual packet data, transmitting uninitialized memory.

The DMA address calculation is correct. page_pool_get_dma_addr()
returns the base DMA address of the page, not offset by the pool's
.offset parameter. sizeof(*xdpf) + xdpf->headroom correctly offsets
to xdpf->data where the TSB starts.

> 
> [ ... ]
>> @@ -2311,14 +2425,42 @@ static unsigned int bcmgenet_run_xdp(struct 
>> bcmgenet_rx_ring *ring,
>>  	switch (act) {
>>  	case XDP_PASS:
>>  		return XDP_PASS;
>> +	case XDP_TX:
>> +		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
>> +		 * MAC has TBUF_64B_EN set globally, so hardware expects every
>> +		 * TX buffer to begin with a 64-byte struct status_64.  Back
>> +		 * up xdp->data into the RSB area (which is no longer needed
>> +		 * after the BPF program ran) and zero it.
>> +		 */
>> +		if (xdp->data - xdp->data_hard_start <
>> +		    sizeof(struct status_64)) {
>> +			page_pool_put_full_page(ring->page_pool, rx_page,
>> +						true);
>> +			return XDP_DROP;
>> +		}
>> +		xdp->data -= sizeof(struct status_64);
>> +		xdp->data_meta -= sizeof(struct status_64);
>> +		memset(xdp->data, 0, sizeof(struct status_64));
>> +
>> +		xdpf = xdp_convert_buff_to_frame(xdp);
> 
> Does this headroom check account for the additional sizeof(struct 
> xdp_frame)
> required by xdp_convert_buff_to_frame()?

The TSB headroom check doesn't account for sizeof(struct xdp_frame), but 
xdp_update_frame_from_buff() has its own check that returns -ENOSPC if 
headroom - metasize < sizeof(*xdp_frame). We handle the NULL return by 
dropping the frame. I'll tighten the check to include sizeof(struct 
xdp_frame) to fail early.

> 
> If metadata is present, xdp->data_meta could potentially underflow
> xdp->data_hard_start. If the remaining headroom minus metasize becomes
> negative in xdp_convert_buff_to_frame(), could it undergo integer 
> promotion
> to a large unsigned value and bypass the internal safety check? This 
> might
> cause the struct xdp_frame to overwrite the newly zeroed status_64 
> block.

xdp_update_frame_from_buff() handles this - it clamps metasize to >= 0 
and checks (headroom - metasize) < sizeof(*xdp_frame), returning NULL on 
insufficient space.

> 
> [ ... ]
>> @@ -2556,9 +2698,15 @@ static int bcmgenet_rx_poll(struct napi_struct 
>> *napi, int budget)
>>  {
>>  	struct bcmgenet_rx_ring *ring = container_of(napi,
>>  			struct bcmgenet_rx_ring, napi);
>> +	struct bcmgenet_priv *priv = ring->priv;
>>  	struct dim_sample dim_sample = {};
>>  	unsigned int work_done;
>> 
>> +	/* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
>> +	if (priv->xdp_prog)
>> +		bcmgenet_tx_reclaim(priv->dev,
>> +				    &priv->xdp_tx_ring, false);
>> +
> 
> What happens to in-flight frames if the XDP program is detached at 
> runtime
> and priv->xdp_prog becomes NULL? Will this permanently lose track of 
> the
> page pool buffers and DMA mappings since the NAPI poll stops reclaiming
> them?

Good catch. The reclaim in rx_poll is gated on priv->xdp_prog, so
in-flight frames on the TX ring would never be reclaimed after detach.
I'll change the condition to check for pending frames on the ring
instead.

> 
> Additionally, if the interface is the target of an XDP_REDIRECT from 
> another
> device, a local XDP program is not required and priv->xdp_prog could be
> NULL. Does this mean the transmitted frames for redirected traffic will
> never be reclaimed, eventually filling the TX ring?

The redirect-without-local-prog case can't happen since
xdp_features_set_redirect_target is tied to program attachment.
But the detach race is real - will fix in v6.

Thanks
Nicolai

