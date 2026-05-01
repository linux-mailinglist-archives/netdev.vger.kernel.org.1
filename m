Return-Path: <netdev+bounces-283067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE8cMV0E9GnR9gEAu9opvQ
	(envelope-from <netdev+bounces-283067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:39:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C31414A9A73
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44ED9300A640
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D992D7398;
	Fri,  1 May 2026 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLTjKOK3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9B23C39A;
	Fri,  1 May 2026 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599575; cv=none; b=esh4oUIeh0c+MxswyL/FqrfSfrbxdmcvDfFGY7WaDSzCkVDhFPLhDA/SEcrrVONNeFVXl1RVIXGEba7O9Q0P1DCVfTeYC32BhNqrMEuutTgylFdP8iMyc6bjoraGn8kqurBqosJr/dqwiGQh8FXEpAXr6t/z0aOW+VIq69Ba+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599575; c=relaxed/simple;
	bh=QVVmfKBuYjK1KtBzZ+SBGhTexOP7jIj1vRGIDd19OrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH0BOrBdXLPXajhcu+z11EmZJWN+f1Y70SL/kJGKWmxE69rlVxk46eXg2DsTlb6Mxw3G1Y+CT3IHaVPscFojxueAsmdPVN+g3wWnNNLddwdIFDsrPdX2zm4mQN3pI39waeXxEgrwqDg6j7KwyWqVwUhu9ac56MN9DvcBiMlu2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLTjKOK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5536C2BCB3;
	Fri,  1 May 2026 01:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777599575;
	bh=QVVmfKBuYjK1KtBzZ+SBGhTexOP7jIj1vRGIDd19OrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLTjKOK3/Wo09wGrdAJ7Dc1wUl3ssr3LQ0j0Ab4GKyxj/xMm8kzsOyfDPk4Az8QNG
	 Tl/WCx32St1mPloNKLHCg0t8Y0nTzeDpAbe/1o4uQWexRlZXXIsqp0Z9XzGQKFsABW
	 8T4N5b8YLIVweYm9MJPzNo6BYoyMTSjhOusr621u66W33L70nsqshq/kbrA3+jamnA
	 d6KZs9UlDgbB+JPza8CoVLa8MjLvXYtzWD9F7UX4+JgBmPI9J9MADVIjxdTeYoR1TN
	 v+BJkHWEJOgvuX8hX2TWNvCT2voSStxsjH5osGIDaineaXZbhFL94MHT1B+sIXLcny
	 rLT9s/A2vYEww==
From: Jakub Kicinski <kuba@kernel.org>
To: nb@tipi-net.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	justin.chen@broadcom.com,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	rajashekar.hudumula@broadcom.com,
	vikas.gupta@broadcom.com,
	bhargava.marreddy@broadcom.com,
	sashal@kernel.org,
	ebiggers@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/7] net: bcmgenet: convert RX path to page_pool
Date: Thu, 30 Apr 2026 18:37:25 -0700
Message-ID: <20260501013724.3164844-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428205846.2625550-2-nb@tipi-net.de>
References: <20260428205846.2625550-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C31414A9A73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-283067-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: bcmgenet: convert RX path to page_pool

This patch replaces the per-packet __netdev_alloc_skb() + dma_map_single()
in the bcmgenet RX path with page_pool, adding a page_pool per RX ring and
building SKBs from pages via napi_build_skb() with skb_mark_for_recycle().
A few questions on the changes below.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 54f71b1e85fc..d013a3df9048 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -52,6 +52,13 @@
>  #define RX_BUF_LENGTH		2048
>  #define SKB_ALIGNMENT		32
>  
> +/* Page pool RX buffer layout:
> + * XDP_PACKET_HEADROOM | RSB(64) + pad(2) | frame data | skb_shared_info
> + * The HW writes the 64B RSB + 2B alignment padding before the frame.
> + */
> +#define GENET_RSB_PAD		(sizeof(struct status_64) + 2)
> +#define GENET_RX_HEADROOM	(XDP_PACKET_HEADROOM + GENET_RSB_PAD)

Is GENET_RX_HEADROOM used anywhere?  A grep of the tree after this patch
shows no references to it; all call sites use XDP_PACKET_HEADROOM and
GENET_RSB_PAD separately.  Can this macro be dropped?

Jakub: false positive

Also, XDP_PACKET_HEADROOM is referenced here and in three other places in
bcmgenet.c (bcmgenet_rx_refill, bcmgenet_desc_rx, and
bcmgenet_rx_ring_create_pool), but the only new include added by the
patch is <net/page_pool/helpers.h> in bcmgenet.h.  XDP_PACKET_HEADROOM is
defined in include/uapi/linux/bpf.h, and the helpers.h/types.h chain does
not include it.  Would it be worth adding an explicit #include
<linux/bpf.h> to bcmgenet.c so this does not rely on transitive inclusion
(other drivers using this macro, e.g. bnxt, include it explicitly)?

> @@ -2250,46 +2249,30 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
> -static struct sk_buff *bcmgenet_rx_refill(struct bcmgenet_priv *priv,
> -					  struct enet_cb *cb)
> +static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
> +			      struct enet_cb *cb)
>  {
[ ... ]
> -	/* Allocate a new Rx skb */
> -	skb = __netdev_alloc_skb(priv->dev, priv->rx_buf_len + SKB_ALIGNMENT,
> -				 GFP_ATOMIC | __GFP_NOWARN);

After this conversion, priv->rx_buf_len no longer has any readers; the
old dma_map_single/dma_unmap paths that consumed it are gone, and the new
code uses RX_BUF_LENGTH directly in pp_params.max_len and
page_pool_dma_sync_for_cpu().  bcmgenet_init() still writes the field.
Should priv->rx_buf_len be removed as part of this cleanup?

[ ... ]

> @@ -2341,25 +2324,28 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  	while ((rxpktprocessed < rxpkttoprocess) &&
>  	       (rxpktprocessed < budget)) {
>  		struct status_64 *status;
> +		struct page *rx_page;
> +		unsigned int rx_off;
>  		__be16 rx_csum;
> +		void *hard_start;
>  
>  		cb = &priv->rx_cbs[ring->read_ptr];
[ ... ]
> +		page_pool_dma_sync_for_cpu(ring->page_pool, rx_page, 0,
> +					   RX_BUF_LENGTH);

page_pool_dma_sync_for_cpu() is called unconditionally with a fixed size
of RX_BUF_LENGTH (2048) even when the actual received frame is much
smaller.  The received length is available in the descriptor status word
once it is read.  On the non-cache-coherent SoCs this driver targets
(for example BCM2711), is there a reason not to sync only the number of
bytes that were actually received?

[ ... ]

> @@ -2375,7 +2361,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  		if (unlikely(len > RX_BUF_LENGTH)) {
>  			netif_err(priv, rx_status, dev, "oversized packet\n");
>  			BCMGENET_STATS64_INC(stats, length_errors);
[ ... ]

> @@ -2411,24 +2399,47 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
[ ... ]
> -		skb_put(skb, len);
> +		/* Build SKB from the page - data starts at hard_start,
> +		 * frame begins after RSB(64) + pad(2) = 66 bytes.
> +		 */
> +		skb = napi_build_skb(hard_start, PAGE_SIZE - XDP_PACKET_HEADROOM);
> +		if (unlikely(!skb)) {
> +			BCMGENET_STATS64_INC(stats, dropped);
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			goto next;
> +		}
>  
> -		/* remove RSB and hardware 2bytes added for IP alignment */
> -		skb_pull(skb, 66);
> -		len -= 66;
> +		skb_mark_for_recycle(skb);
> +
> +		/* Reserve the RSB + pad, then set the data length */
> +		skb_reserve(skb, GENET_RSB_PAD);
> +		__skb_put(skb, len - GENET_RSB_PAD);

Can len here be smaller than GENET_RSB_PAD (66)?  len is taken from
status->length_status >> DMA_BUFLENGTH_SHIFT and the only bound checked
above is the upper bound against RX_BUF_LENGTH:

    if (unlikely(len > RX_BUF_LENGTH)) {
        ...
    }

If HW ever reports a runt length below 66 (for example after a reset or
due to an errata path), len - GENET_RSB_PAD underflows as an unsigned
value.  __skb_put() is the unchecked variant:

    static inline void *__skb_put(struct sk_buff *skb, unsigned int len)
    {
        void *tmp = skb_tail_pointer(skb);
        SKB_LINEAR_ASSERT(skb);
        skb->tail += len;
        skb->len  += len;
        return tmp;
    }

so it will not trip skb_over_panic(); instead skb->tail/skb->len advance
past skb->end into the page.  Since napi_build_skb() was given
frag_size = PAGE_SIZE - XDP_PACKET_HEADROOM, skb->end sits inside the
same page_pool-backed page and the SKB would then expose recycled
page_pool memory up the stack via napi_gro_receive().

The previous code used skb_put(skb, len) followed by skb_pull(skb, 66),
both of which are bounds-checked.  Would it make sense to add an
explicit guard such as:

    if (unlikely(len < GENET_RSB_PAD)) {
        BCMGENET_STATS64_INC(stats, length_errors);
        page_pool_put_full_page(ring->page_pool, rx_page, true);
        goto next;
    }

before the __skb_put() call?

Jakub: I suppose.. IDK if protecting against bad HW is required, up to you

>  		if (priv->crc_fwd_en) {
> -			skb_trim(skb, len - ETH_FCS_LEN);
> -			len -= ETH_FCS_LEN;
> +			skb_trim(skb, skb->len - ETH_FCS_LEN);
>  		}

The same underflow concern applies here: if skb->len is less than
ETH_FCS_LEN, skb->len - ETH_FCS_LEN wraps to a very large unsigned
value, and skb_trim() does:

    void skb_trim(struct sk_buff *skb, unsigned int len)
    {
        if (skb->len > len)
            __skb_trim(skb, len);
    }

so the trim is silently skipped and the FCS stays attached.  Should this
path also validate skb->len before subtracting ETH_FCS_LEN?

[ ... ]
-- 
pw-bot: cr

