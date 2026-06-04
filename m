Return-Path: <netdev+bounces-295413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7FiSKzvbIWrvPgEAu9opvQ
	(envelope-from <netdev+bounces-295413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 22:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AE864318D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 22:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=PijeqS4W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295413-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295413-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12DBC300D6A6
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 20:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B03C457F;
	Thu,  4 Jun 2026 20:05:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3A3BD22E;
	Thu,  4 Jun 2026 20:05:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603536; cv=none; b=mgHzBphQrardW08el+t/PRGpBQmmgBOwxCIqtYP42mY+qDSJn3L8prVPsKBY+XZFwZvvdndIJ7Z4YU5af8z2TEd0FDL4weshiTe0ImYGXQXQhD0i767qYfnpr1EbVvEgUMikWzW43fFoNp++RTNLdXFCnZZnKEHAYmvmWMK9uZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603536; c=relaxed/simple;
	bh=GlLYHmEGMNg6oqH8rc6t2+bsB9VTXb2eEXcfBEe0O0s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=P49Dd85mNF9Ce0h8bgC64dbDLKj84y0wOGNBvCzlWOcU5jSNIiCAXyb4kM6mlubLSzNrQH6dO3jFwL0LiBvZndQ3E272U1bs529+iZS4CJp7j+G7nF+970dHyDO2yxOZd8J7MJDUJOMilK3zifmf1ZS/z7J9o9tzwbONY7xWrsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=PijeqS4W; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4BB1A01B4;
	Thu,  4 Jun 2026 22:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780603531; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UW4gxJiL3cJlXD2vzkSBOSktwGvUlNbwdLTHRiCG9wk=;
	b=PijeqS4WdXffaPaT7dXcQTCGhy3ODG4wTA2/6toMy9JWx81h/J/TU24B0fKoKsh2pfJ46p
	w8s3FNeu15fwV4jZg5ApezPUv0qo++GqQcXSCxRCCsh8Q8I5w4IGY/vpT8p644fsf+JT+c
	Wfjy4M6QYi/lGnihV7ILZ29FEbieZqArLlitSgTDWP9bNQtcu8Vtv4xMzybca54fm4E4yW
	+4WVV2SXsNnBHCAIbG6eacqJXHIunVKXkpTJnbESYn9hglnFOi0kZvqHmEVpTLdAOWSpq2
	jtoyVTveoarhwOZvPtoyuHgKlBJfo2lpxZtXI8yIC2ke1wFYXJbQTwflWbj7JQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 22:05:29 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, bhargava.marreddy@broadcom.com,
 fmancera@suse.de, markus@blochl.de, arnd@arndb.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: convert RX path to page_pool
In-Reply-To: <20260604173205.3989025-3-horms@kernel.org>
References: <20260602094248.4130712-1-nb@tipi-net.de>
 <20260604173205.3989025-3-horms@kernel.org>
Message-ID: <e6694208872ec000c8db73dedd5931a2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:justin.chen@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:vikas.gupta@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:bhargava.marreddy@broadcom.com,m:fmancera@suse.de,m:markus@blochl.de,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-295413-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,suse.de,blochl.de,arndb.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,vger.kernel.org:from_smtp,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:from_mime,tipi-net.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01AE864318D

Hi Simon

On 4.6.2026 19:32, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> Now I have the exact diff. Let me produce the report.
> 
> commit ff8ce4b2334ded9490897cdd2cff5a25a4a0a438
> Author: Nicolai Buchwitz <nb@tipi-net.de>
> 
> net: bcmgenet: convert RX path to page_pool
> 
> This patch converts the bcmgenet RX path from per-packet
> __netdev_alloc_skb() + dma_map_single() to page_pool, builds SKBs from
> pool pages via napi_build_skb() with skb_mark_for_recycle(), and 
> removes
> the now-unused priv->rx_buf_len field and rx_dma_failed soft MIB
> counter.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

> [...]

>> @@ -1153,7 +1159,6 @@ static const struct bcmgenet_stats 
>> bcmgenet_gstrings_stats[] = {
>>  			UMAC_RBUF_ERR_CNT_V1),
>>  	STAT_GENET_MISC("mdf_err_cnt", mib.mdf_err_cnt, UMAC_MDF_ERR_CNT),
>>  	STAT_GENET_SOFT_MIB("alloc_rx_buff_failed", 
>> mib.alloc_rx_buff_failed),
>> -	STAT_GENET_SOFT_MIB("rx_dma_failed", mib.rx_dma_failed),
>>  	STAT_GENET_SOFT_MIB("tx_dma_failed", mib.tx_dma_failed),
> 
> [Medium]
> The string "rx_dma_failed" exposed via ethtool -S is user-visible: 
> monitoring
> agents (collectd, telegraf, Prometheus exporters, ad-hoc scripts) may 
> key off
> that name, and the strings list is ordered, so removing one shifts the 
> index
> of every counter that follows for tools that index by offset rather 
> than name.
> 
> Should the changelog mention this user-visible change explicitly, or 
> could
> the entry be retained reporting 0 to preserve the existing string set?

Nothing in the driver can increment rx_dma_failed after this patch. What 
would be
the point in keeping it static 0? AFAIU removing dead soft-MIB counters 
in the same
patch is not so special for page_pool conversions (e.g. ionic)?

I will mention it in the commit message of v2 though.

> 
> Worth noting that the sibling driver 
> drivers/net/ethernet/broadcom/bcmsysport.c
> still exposes rx_dma_failed, so the two drivers in the same Broadcom 
> directory
> will diverge after this patch.

bcmsysport still does per-packet dma_map_single() and not PP. The two 
drivers
diverge because they do different things now, not because removing the 
counter
here is wrong?

> [...]

> [High]
> Has a one-page-per-RX-descriptor scheme been considered against the
> platforms bcmgenet actually runs on?
> 
> The pool is created with order=0 and max_len=RX_BUF_LENGTH (2048):
> 
> 	struct page_pool_params pp_params = {
> 		.order = 0,
> 		...
> 		.max_len = RX_BUF_LENGTH,
> 	};
> 
> bcmgenet_rx_refill() always sets cb->rx_page_offset = 0, and
> bcmgenet_desc_rx() then does:
> 
> 	skb = napi_build_skb(hard_start, PAGE_SIZE - rx_off);
> 
> so each ~1.5KB frame ends up with skb->truesize == PAGE_SIZE.
> 
> bcmgenet runs on BCM2711/2712 (Raspberry Pi 4/5) and Brahma-B53 STB 
> SoCs,
> which are commonly built with 16K or 64K page sizes. With ring->size of

Pi5 uses BCM2712, but doesn't expose the genet and instead uses cadence 
macb
on it's RP1. AFAIK only pi5 uses 16k pages and Pi4 and other STB 
platforms
use 4k pages? With 4k we would end up at 1 MB per ring, which seems fine 
for
a GBit MAC?

> 256 and one full page per descriptor, that is e.g. 256 * 64K = 16MB of
> DMA-mapped memory per ring on a 64K-page kernel, for ~512KB of frame
> data. Every ~1.5KB packet also bills PAGE_SIZE bytes against sk_rcvbuf
> and per-socket memory accounting, which can drive TCP receivers into
> memory pressure on a Gigabit MAC.
> 
> The newly added struct enet_cb::rx_page_offset is set but never to a
> non-zero value:
> 
> 	cb->rx_page = page;
> 	cb->rx_page_offset = 0;
> 
> Was a fragmented allocation (page_pool_dev_alloc_frag(), or a higher
> .order) the original intent here? If so, would it make sense to either
> implement that in this patch, or drop the unused rx_page_offset field
> until it is needed?

Frag allocation is a reasonable follow-up but I'd keep this patch
focused on the page_pool conversion. rx_page_offset is an artifact from
the original XDP series. It is meant for the later XDP_PACKET_HEADROOM, 
but
I can drop it in v2 for now.

> 
>> @@ -2340,25 +2321,31 @@ static unsigned int bcmgenet_desc_rx(struct 
>> bcmgenet_rx_ring *ring,
> 
> [ ... ]
> 
>> -		if (unlikely(len > RX_BUF_LENGTH)) {
>> -			netif_err(priv, rx_status, dev, "oversized packet\n");
>> +		/* Reject obviously bogus lengths to keep the SKB build path
>> +		 * safe against runt frames.
>> +		 */
>> +		min_len = GENET_RSB_PAD + ETH_ZLEN +
>> +			  (priv->crc_fwd_en ? ETH_FCS_LEN : 0);
>> +		if (unlikely(len > RX_BUF_LENGTH || len < min_len)) {
>> +			netif_err(priv, rx_status, dev,
>> +				  "invalid packet length %d\n", len);
>>  			BCMGENET_STATS64_INC(stats, length_errors);
>> -			dev_kfree_skb_any(skb);
>> +			page_pool_put_full_page(ring->page_pool, rx_page,
>> +						true);
>>  			goto next;
>>  		}
> 
> [Low, Low]
> This combined check changes the per-counter attribution for short 
> frames.
> Previously, only len > RX_BUF_LENGTH short-circuited into 
> length_errors;
> runts that also had DMA_RX_CRC_ERROR / DMA_RX_OV / DMA_RX_NO / 
> DMA_RX_LG /
> DMA_RX_RXER set would fall through to the dma_flag-driven block and be
> counted as crc_errors / over_errors / frame_errors / errors as 
> appropriate.
> 
> After this patch any sub-min_len frame is bucketed only as 
> length_errors,
> even if dma_flag indicates a CRC or RXER condition. Is the loss of 
> finer
> attribution intentional, and could the changelog mention it?
> 
> A related question on the lower bound itself: min_len is computed as
> GENET_RSB_PAD + ETH_ZLEN (+ ETH_FCS_LEN if crc_fwd_en), so any 
> HW-reported
> frame below ETH_ZLEN on the wire is dropped. Frames below the minimum
> that the MAC nevertheless delivers (for example with promiscuous mode 
> or
> runt-pass enabled, or some PHY-side debug captures) used to reach the
> stack with DMA_RX_LG / DMA_RX_NO flagging.
> 
> The commit message describes this as "a runt cannot underflow the SKB
> build path". The actual underflow precondition for the skb_reserve() /
> __skb_put() sequence is len < GENET_RSB_PAD (= 66):
> 
> 		skb_reserve(skb, GENET_RSB_PAD);
> 		__skb_put(skb, len - GENET_RSB_PAD);
> 
> Would a tighter check of len < GENET_RSB_PAD satisfy the stated safety
> goal without filtering legitimate sub-ETH_ZLEN frames the HW chose to
> deliver?

Resonable. Will use len < GENET_RSB_PAD in v2.

Thanks,
Nicolai

