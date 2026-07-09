Return-Path: <netdev+bounces-306319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sx8vDYvWT2oEpAIAu9opvQ
	(envelope-from <netdev+bounces-306319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:12:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B8D733BCF
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:12:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fgWaem9Z;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306319-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306319-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72D41308B967
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5A42E8DD;
	Thu,  9 Jul 2026 17:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C242E007
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 17:02:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616531; cv=none; b=VMV8h2VR5x74VzvaFSObBK7U0fCuL2eG3kNq1uNgrKoGeyKKWepATP8A0qtAMShg9NN608CDpfRZDYvR955rYCpTWdxUFyoakVQmztmb9MYRzGGj4fydLnjRQFCBS9972nUkh4LfdsetO3x3aK/gs0H4A5Y+2ZSajRF6cJ1i0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616531; c=relaxed/simple;
	bh=NLtlHWeoKP9QYEoGIB5A84uT4lkBvR3qTJBsrqK0GAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skd+av4AhS92b1mI3y0bKaWE1Uj54uhHoAPR6URyZ8HXae4HNB9aY+uS7GgPbxsF3vheKhyvl3lFQ8khC3dhaKdjKQJypDi/1Y8skx8vFSa2Yqn0eaJShIUdO8AGgyXtvXkvKL6+m5cJKNIPSrcS/fliktoyN06zaJFhxM/2Nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgWaem9Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522921F000E9;
	Thu,  9 Jul 2026 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783616529;
	bh=YyzztrhBkLk5q7XGX9wemKW1UJM1QHqv8xfqULQK0gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fgWaem9Z5zTFk1NW6URT+5jhLdae/zu5N+lmuQGgsj0lXaM0xAsrCEa/+5RYAoRIf
	 pC4vF/rbj2wpASXi97qetrAedBwtASOXa8nRQTf8rda4iJHt4wjcAYRejxQsZiW5Qc
	 JED3pPx/zBl6WWo+Oy/utKxStp6Pisc1df0bDVNZ3FgxHz9z0QyfilQ/HhJAdrO3FQ
	 CYbeAa0jlTrkz8XtdGa/Tl5r54qWVZQTvSEG1l6pW8VHJYLEnrT7M08+BmDEOBHZXB
	 9HBv/DkYNC9aRnnuaKQuPIxTkV1sMBVWaEqJvtZA61LGFzhMEcR1f/66YM9rZLViAf
	 i5QBybQLQzA4g==
From: Simon Horman <horms@kernel.org>
To: atharvapotdar07@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	romieu@fr.zoreil.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4] r8169: migrate Rx path to page_pool, prepare for XDP
Date: Thu,  9 Jul 2026 18:01:30 +0100
Message-ID: <20260709170151.1577992-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704080653.33740-1-atharvapotdar07@gmail.com>
References: <20260704080653.33740-1-atharvapotdar07@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306319-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:atharvapotdar07@gmail.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:romieu@fr.zoreil.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,fr.zoreil.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27B8D733BCF

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
r8169: migrate Rx path to page_pool, prepare for XDP

This commit migrates the Rx path to page_pool on MACs newer than
RTL_GIGA_MAC_VER_06, reserves XDP_PACKET_HEADROOM in each buffer, and
decouples the Rx consumption loop (cur_rx) from a new refill loop
(dirty_rx) that reallocates only after napi_build_skb() takes
ownership of a page.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21f..5b13880c7ed8 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -4161,21 +4169,14 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
>  static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  					  struct RxDesc *desc)
>  {
> -	struct device *d = tp_to_dev(tp);
> -	int node = dev_to_node(d);
>  	dma_addr_t mapping;
>  	struct page *data;
>  
> -	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
> +	data = page_pool_dev_alloc_pages(tp->rx_pool);
>  	if (!data)
>  		return NULL;
>  
> -	mapping = dma_map_page(d, data, 0, R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
> -	if (unlikely(dma_mapping_error(d, mapping))) {
> -		netdev_err(tp->dev, "Failed to map RX DMA!\n");
> -		__free_pages(data, get_order(R8169_RX_BUF_SIZE));
> -		return NULL;
> -	}
> +	mapping = page_pool_get_dma_addr(data) + tp->rx_headroom;
>  
>  	desc->addr = cpu_to_le64(mapping);
>  	rtl8169_mark_to_asic(desc);

[Critical]
Can the NIC DMA past the end of the allocated page here?  The
descriptor's addr is offset by tp->rx_headroom (XDP_PACKET_HEADROOM,
256) inside a page whose backing allocation is order-2 (16384 bytes,
since R8169_RX_BUF_SIZE is SZ_16K - 1 = 16383):

	mapping = page_pool_get_dma_addr(data) + tp->rx_headroom;

but rtl8169_mark_to_asic() still programs the full R8169_RX_BUF_SIZE
into the descriptor's writable-size field:

	WRITE_ONCE(desc->opts1,
		   cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));

So the NIC's writable window becomes [page + 256, page + 16639], which
overshoots the 16384-byte allocation by up to 255 bytes.  page_pool's
own accounting has already been narrowed via params.max_len =
R8169_RX_BUF_SIZE - tp->rx_headroom, but that value never propagates
to opts1.

On RTL8125/8126, rtl_jumbo_max() returns JUMBO_16K and rtl_set_rx_max_size()
programs RxMaxSize = R8169_RX_BUF_SIZE + 1, so on-wire frames close to
16 KiB are accepted, exactly the range that drives the overrun.

The same mismatch appears on the zero-copy skb path.  napi_build_skb()
is called with frag_size = R8169_RX_BUF_SIZE:

	skb = napi_build_skb(rx_buf, R8169_RX_BUF_SIZE);
	if (likely(skb)) {
		skb_reserve(skb, tp->rx_headroom);
		skb_put(skb, pkt_size);

After skb_reserve(256), tailroom is around 16383 - 256 - overhead,
while pkt_size comes straight from the descriptor's 14-bit length
field (up to 16383, or 16379 after the ETH_FCS_LEN strip).  A large
enough pkt_size would trip skb_over_panic() inside skb_put() → BUG().

Should the descriptor size and napi_build_skb() frag_size use
R8169_RX_BUF_SIZE - tp->rx_headroom (or params.max_len) instead of
R8169_RX_BUF_SIZE?

Also, the commit message states:

    The pool is locked to order-2 (SZ_16K) allocations on all MACs,
    matching the existing R8169_RX_BUF_SIZE, so this migration
    introduces no change in per-descriptor allocation size or
    jumbo-frame behavior relative to the current tree.

Given that rx_headroom is now consuming part of that 16 KiB on newer
MACs while the descriptor size field is unchanged, is the
"no change in ... jumbo-frame behavior" claim still accurate?

> @@ -4188,14 +4189,18 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)
>  	int i;
>  
>  	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
> -		dma_unmap_page(tp_to_dev(tp),
> -			       le64_to_cpu(tp->RxDescArray[i].addr),
> -			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
> -		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
> +		page_pool_put_full_page(tp->rx_pool, tp->Rx_databuff[i], false);
>  		tp->Rx_databuff[i] = NULL;
>  		tp->RxDescArray[i].addr = 0;
>  		tp->RxDescArray[i].opts1 = 0;
>  	}
> +
> +	if (tp->rx_pool) {
> +		if (xdp_rxq_info_is_reg(&tp->xdp_rxq))
> +			xdp_rxq_info_unreg(&tp->xdp_rxq);
> +		page_pool_destroy(tp->rx_pool);
> +		tp->rx_pool = NULL;
> +	}
>  }

[High]
Can this loop leak Rx_databuff pages and orphan the page_pool?  The
loop condition terminates at the first NULL entry:

	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {

Prior to this patch, Rx_databuff[] was uniformly non-NULL between
fill and close, so early termination was safe.  With this patch, two
paths create NULL entries interspersed with live pages:

  - rl_rx() sets tp->Rx_databuff[entry] = NULL when napi_build_skb()
    succeeds and takes ownership of the page.
  - rtl8169_rx_refill() breaks on the first
    page_pool_dev_alloc_pages() failure, leaving that slot NULL while
    later slots still hold live pages.

If a close happens with any NULL entry in front of a still-populated
one, the loop exits early, page_pool_put_full_page() is never called
on the remaining pages, and page_pool_destroy() then sees non-zero
in-flight pages and schedules the deferred release worker.  With
tp->rx_pool set to NULL and the next rtl8169_init_ring() clearing
Rx_databuff via memset(), the surviving pointers are permanently
lost.

Should this iterate over all NUM_RX_DESC entries and null-check
inside the body instead of using the pointer as a loop condition?

[High]
A related concern that isn't in this diff, but is created by the new
Rx_databuff NULL semantics: rtl_reset_work() calls rtl8169_cleanup()
(which zeroes cur_rx and dirty_rx via rtl8169_init_ring_indexes())
and then unconditionally re-arms every descriptor:

drivers/net/ethernet/realtek/r8169_main.c:rtl_reset_work() {
	...
	rtl8169_cleanup(tp);

	for (i = 0; i < NUM_RX_DESC; i++)
		rtl8169_mark_to_asic(tp->RxDescArray + i);

	napi_enable(&tp->napi);
	rtl_hw_start(tp);
}

After this patch, Rx_databuff[k] can be NULL for slots whose pages
were consumed by napi_build_skb(), and the descriptor's addr for
those slots still points at a page that has been returned to the
page_pool (and may be recycled to another buffer).  Once
rtl_hw_start() re-enables the NIC, it can DMA incoming frames into
those stale addresses.

On top of that, because dirty_rx == cur_rx == 0 after the reset,
rtl8169_rx_refill() has nothing to advance over, and rl_rx's
guard fires without progressing state:

	if (unlikely(!tp->Rx_databuff[entry]))
		break;

so the NULL slots never get repopulated.

Should rtl_reset_work() refill the NULL slots (or do a full
rx_clear/rx_fill) before marking descriptors to ASIC?

