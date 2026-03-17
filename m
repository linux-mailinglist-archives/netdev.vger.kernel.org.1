Return-Path: <netdev+bounces-268681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAjRIFaBuWmxHAIAu9opvQ
	(envelope-from <netdev+bounces-268681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:29:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC32ADF84
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48CBF309E7F2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7B30FF3C;
	Tue, 17 Mar 2026 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqhRzX1b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666230FC30;
	Tue, 17 Mar 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764380; cv=none; b=bnDtZHYqw2DBHhWdEWuRJ4X7CCO40Fi8xL4PmROOfIWOhhlxUsPhbgbxdoo/ocwimx+3Yap0MH534HDrPUFPGfv3O45l8bMLuM2N5kZ8QBdW8Ty5U5MWJRij54o+aoLWu7nW+j9VSh95S8k54liebyB6A9BBZ71ZyM4dAeQTyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764380; c=relaxed/simple;
	bh=uh/Y+uh/UZQi80vVK131ehjTzcA57hfTsEhbK174g4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkBHFzFPoPjqXYCLzKVe39r3KYLQW4TlNpJaRdw7sSIPDvWRjd6GV4iX7PdfAR4TTpIp/379XmvY1vwzQ2SapLplcQIHawYRwv/OpxDzOFlIuHA3VCkmmlR8HNuD1QeXg9ZL/8V1OaS3zL4oLl61nfOCoelJZpVZmiQKZAHE1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqhRzX1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8C6C19424;
	Tue, 17 Mar 2026 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764380;
	bh=uh/Y+uh/UZQi80vVK131ehjTzcA57hfTsEhbK174g4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqhRzX1bH181/59/+W0DB/lE03mZhUjO0FzyO4L7yR4MNs1X2Sn6LhlgvwK2BQq6i
	 lUUxkKjKqoxLuR5By25SNEJ0DJQqTvwhw2Jj+fW2AKmTn1F4aWHRJHZsh8JPFtymap
	 y8Z/ceH1N3taq+D/Djl8LxiMwwmemDgrerPOjuQ2Diu7Lj9Gg3Osfc+nOjPrv9KkJk
	 wfFe8ceatDCjxwEgjr7K1I1SXlnadhSPw3eOMqsRCsZ/BQkjE5LxDY0Jys7dv7Fntj
	 PzeRtCAerl7sxOpeb1enXJbtZ3y8UjjJrHMV/JCLhqynDPDA7/lIu0gsg2r/qT9w27
	 UWY1hYxNem8IQ==
From: Simon Horman <horms@kernel.org>
To: nb@tipi-net.de
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	mbloch@rooftopnetworks.de,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	vikas.gupta@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	opendmb@gmail.com,
	bhargava.marreddy@broadcom.com,
	netdev@vger.kernel.org,
	ebiggers@kernel.org,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	florian.fainelli@broadcom.com,
	kuba@kernel.org,
	arnd@arndb.de,
	bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com
Subject: Re: [net-next,v2,3/6] net: bcmgenet: add basic XDP support (PASS/DROP)
Date: Tue, 17 Mar 2026 16:19:06 +0000
Message-ID: <20260317161906.1758581-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315214914.1555777-4-nb@tipi-net.de>
References: <20260315214914.1555777-4-nb@tipi-net.de>
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
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,rooftopnetworks.de,google.com,vger.kernel.org,broadcom.com,gmail.com,lunn.ch,arndb.de,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-268681-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0CC32ADF84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: bcmgenet: add basic XDP support (PASS/DROP)

This commit adds XDP program attachment via ndo_bpf and executes XDP
programs in the RX path. XDP_PASS builds an SKB from the xdp_buff
(handling xdp_adjust_head/tail), and XDP_DROP returns the page to
page_pool without SKB allocation.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 6e610e73e12f..f6a2567af7cb 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2274,6 +2276,53 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
>  	return 0;
>  }
>
> +static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
> +					      struct xdp_buff *xdp,
> +					      struct page *rx_page)
> +{
> +	unsigned int metasize;
> +	struct sk_buff *skb;
> +
> +	skb = napi_build_skb(xdp->data_hard_start, PAGE_SIZE);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	skb_mark_for_recycle(skb);
> +
> +	metasize = xdp->data - xdp->data_meta;
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	__skb_put(skb, xdp->data_end - xdp->data);
> +
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
                          ^^^^

Can this corrupt memory? Looking at bcmgenet_desc_rx(), the xdp_buff is
initialized with meta_valid=false:

	xdp_prepare_buff(&xdp, page_address(rx_page),
			 GENET_RX_HEADROOM, pkt_len, false);

When meta_valid is false, xdp_prepare_buff() sets xdp->data_meta to
xdp->data + 1 as a sentinel value to indicate no metadata is present.

In bcmgenet_xdp_build_skb(), the metasize calculation becomes:

	metasize = xdp->data - xdp->data_meta
	         = xdp->data - (xdp->data + 1)
	         = (ptrdiff_t)-1

When assigned to 'unsigned int metasize', this wraps to UINT_MAX. The
'if (metasize)' check passes since UINT_MAX != 0, and
skb_metadata_set(skb, metasize) truncates UINT_MAX to u8, setting
skb_shinfo(skb)->meta_len = 255.

This incorrect meta_len of 255 can cause downstream SKB consumers (TC BPF
programs, skb_data_move) to read or write 255 bytes before
skb_mac_header(skb) when accessing the metadata region.

Other XDP drivers that use skb_metadata_set() (bnxt, mvneta, ixgbe,
i40e, virtio_net) all pass meta_valid=true to xdp_prepare_buff(), which
sets data_meta=data, giving metasize=0 and correctly skipping
skb_metadata_set().

Should xdp_prepare_buff() be called with meta_valid=true instead of
false, since bcmgenet_xdp_build_skb() handles XDP metadata?

> +
> +	return skb;
> +}

[ ... ]

> @@ -2403,26 +2455,52 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  			goto next;
>  		} /* error packet */
>
> -		/* Build SKB from the page - data starts at hard_start,
> -		 * frame begins after RSB(64) + pad(2) = 66 bytes.
> -		 */
> -		skb = napi_build_skb(hard_start, PAGE_SIZE - GENET_XDP_HEADROOM);
> -		if (unlikely(!skb)) {
> -			BCMGENET_STATS64_INC(stats, dropped);
> -			page_pool_put_full_page(ring->page_pool, rx_page,
> -						true);
> -			goto next;
> -		}
> -
> -		skb_mark_for_recycle(skb);
> +		/* XDP: frame data starts after RSB + pad */
> +		if (xdp_prog) {
> +			struct xdp_buff xdp;
> +			unsigned int xdp_act;
> +			int pkt_len;
> +
> +			pkt_len = len - GENET_RSB_PAD;
> +			if (priv->crc_fwd_en)
> +				pkt_len -= ETH_FCS_LEN;
> +
> +			xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
> +			xdp_prepare_buff(&xdp, page_address(rx_page),
> +					 GENET_RX_HEADROOM, pkt_len, false);
> +
> +			xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp,
> +						   rx_page);
> +			if (xdp_act != XDP_PASS)
> +				goto next;
> +
> +			/* XDP_PASS: build SKB from (possibly modified) xdp */
> +			skb = bcmgenet_xdp_build_skb(ring, &xdp, rx_page);
> +			if (unlikely(!skb)) {
> +				BCMGENET_STATS64_INC(stats, dropped);
> +				page_pool_put_full_page(ring->page_pool,
> +							rx_page, true);
> +				goto next;
> +			}
> +		} else {
> +			/* Build SKB from the page - data starts at
> +			 * hard_start, frame begins after RSB(64) + pad(2).
> +			 */
> +			skb = napi_build_skb(hard_start,
> +					     PAGE_SIZE - GENET_XDP_HEADROOM);
> +			if (unlikely(!skb)) {
> +				BCMGENET_STATS64_INC(stats, dropped);
> +				page_pool_put_full_page(ring->page_pool,
> +							rx_page, true);
> +				goto next;
> +			}
>
> -		/* Reserve the RSB + pad, then set the data length */
> -		skb_reserve(skb, GENET_RSB_PAD);
> -		__skb_put(skb, len - GENET_RSB_PAD);
> +			skb_mark_for_recycle(skb);
> +			skb_reserve(skb, GENET_RSB_PAD);
> +			__skb_put(skb, len - GENET_RSB_PAD);
>
> -		if (priv->crc_fwd_en) {
> -			skb_trim(skb, skb->len - ETH_FCS_LEN);
> -			len -= ETH_FCS_LEN;
> +			if (priv->crc_fwd_en)
> +				skb_trim(skb, skb->len - ETH_FCS_LEN);
>  		}

[ ... ]

