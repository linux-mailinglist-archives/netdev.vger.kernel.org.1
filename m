Return-Path: <netdev+bounces-274351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ/3JEDizWlVigYAu9opvQ
	(envelope-from <netdev+bounces-274351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:28:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803E383221
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CBB8300D1FE
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6482135A385;
	Thu,  2 Apr 2026 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRIXxVbK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB4A3328FA;
	Thu,  2 Apr 2026 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100424; cv=none; b=AMUuKu/xT35uqixbaz0CMjLsPvvF9lf4VZtyDVID8MH3jf7PHIsuOmp1bM79/TkUmeNbMwoyY1W1c5Y02e9sRFpfxiEEh8RJsrEZtxqK+2wxEgxDAHKP/vb6kW1WdaHFv3otBTAPA/Od9+K3yPhFj1MSLQJ9T5ZXErZ159+Qjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100424; c=relaxed/simple;
	bh=n1vZZJvZqq3JdYP5BL+bojHsEVzNPc6zMLMGtvBaWPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy2y73YDtRLbuNw7hdjGqDunWQKMNKxivm0fhCwd39PNIQqFIUjxdvgTkgvTd8K9tpakxVCJIvYRqm5dWOwnXaXfvg53Pw86I4Hpg9JMomRaq/m0bX1A/mcWFqCe2VbfvEh1RgBqJUZoE0oEed+KuVeg/jbTXetZq4qIpZd5m9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRIXxVbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF87C4CEF7;
	Thu,  2 Apr 2026 03:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775100423;
	bh=n1vZZJvZqq3JdYP5BL+bojHsEVzNPc6zMLMGtvBaWPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jRIXxVbKqqLbzP0ZQ88rmJJPWvn+GfPH6lNTatA0XCymVmvgE8tShVOTv4cvcEAnU
	 GHf6+ji3N88+SsnAzFYtdtmzCOCqML6mM2KyckVsybhi8Qbt5Q1ugDHO8FG/ciUl8i
	 k4Mfdj9x6dEFyu2sGuI01dO4mqmDeRyIynG0gZRYeAJcyF7kJD9pNGXy8g+kb0p6SQ
	 MtVqORwyrG0TdZf/84z+41DysbrZkRqpz5A/ijotp4gzDfc/iLh0AH9VeQo9MedJcs
	 mZN9tkAx9rXpgY5dqYS/TDYZ+Qej2GxJxYbnXYulda1hLbYRMOjc0cy2BlDsz+rJJ+
	 VPP7Fo/Q7+CsQ==
Date: Wed, 1 Apr 2026 20:27:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, Simon
 Horman <horms@kernel.org>, Doug Berger <opendmb@gmail.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
Message-ID: <20260401202702.0b0b6dec@kernel.org>
In-Reply-To: <20260328230513.415790-4-nb@tipi-net.de>
References: <20260328230513.415790-1-nb@tipi-net.de>
	<20260328230513.415790-4-nb@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274351-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3803E383221
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 00:05:06 +0100 Nicolai Buchwitz wrote:
> @@ -2403,26 +2456,52 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
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
> +					 GENET_RX_HEADROOM, pkt_len, true);
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

The large branches here are quite unusual, normally drivers fully
prepare the xdp_buff and if there's no xdp prog attached act as
if there was one and it returned XDP_PASS. Saves LoC and therefore bugs.

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
>  
>  		/* Set up checksum offload */

AI points out that :

  The status_64 structure is located at the start of the page
  before the frame data. Since this resides inside the XDP headroom, if an XDP
  program expands the header backwards (e.g., via bpf_xdp_adjust_head() or
  metadata via bpf_xdp_adjust_meta()), could it physically overwrite
  status->rx_csum?

  Since the driver reads status->rx_csum after executing the XDP program, it
  could risk reading garbage data if the headroom was used. Should the driver
  skip setting CHECKSUM_COMPLETE when an XDP program is loaded?

> @@ -3745,6 +3824,39 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
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
> +		NL_SET_ERR_MSG_MOD(xdp->extack,
> +				   "MTU too large for single-page XDP buffer");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	old_prog = xchg(&priv->xdp_prog, prog);
> +	if (old_prog) {
> +		synchronize_net();

Why? BPF prog gets freed after a RCU grace period I think?

> +		bpf_prog_put(old_prog);

