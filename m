Return-Path: <netdev+bounces-264156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wONSOwbxqGkwzAAAu9opvQ
	(envelope-from <netdev+bounces-264156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:57:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 519A420A5E8
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 542BA301BC39
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AA5270575;
	Thu,  5 Mar 2026 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orbhr3Nw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369F5477E;
	Thu,  5 Mar 2026 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679426; cv=none; b=gPsYxkDUBYeAsAjtt3Y/sikbTbgifsnDtHLzA6rolD6x3sitaS/i8VVZwDzipb8RBGZaco8P8e0cVEtfxyVNXw04M8Jaij+R24sQo0rsb/FyEbeHWzg3852r24I7g7jgMBGjxPpKcwwbtYdJ9Yag3x8M3frMNee7XxdhfjczXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679426; c=relaxed/simple;
	bh=f2O35ftXwIOl4C8//sQWNz2JrsSHsbTVOvnsi6RFJjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoLWvWBJt1KrAUTkgp+bP4/NG3GWH/DwVE+a2t5PpKdOfHq3fMqeB3XVwE8BoNGwOD92KfK6sTMQkVluo+IXFJ6FZBschEJEp/CXjlCe67dpGwa/Q2cVd2JzXWgmC04RXmORGLeCp74f+dYfaePWTEwEYd/l3PhK3lRLWs3tqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orbhr3Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42254C4CEF7;
	Thu,  5 Mar 2026 02:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679426;
	bh=f2O35ftXwIOl4C8//sQWNz2JrsSHsbTVOvnsi6RFJjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orbhr3Nw/lq4rGh0nCgUCtzH8tBCuNcHIX0Nz8JNu2Nq+BZmfIVlEAjGIah6CRzf2
	 qw7QR9PZbbMxpPOhaVhjME+u20xc4xIvoLC3EB7F8q1+dagbU6RGTwMKo0uzdVv5+P
	 x+OQGoid1GgNry9A7f/DYPRlUax7WClh0ikOSesaOK4zAbPxwIHZB8oJC7R+dPeD+2
	 V+RXhgoHdcHHH3njFXDm9h/u84zCqAxX1s4NREsfC///QOAiE5BrYV8BDy2PzB8kJj
	 eR8ijSSpqKw8Bxa7DJiROQ0gAopUnCDOKDcuR7JwJn8Rv+FT/Yu+XVMgdRNjoLxgI4
	 PoPi2tOmwi/Ow==
From: Jakub Kicinski <kuba@kernel.org>
To: carges@cloudflare.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	pavan.chebbi@broadcom.com,
	pabeni@redhat.com,
	joe@dama.to,
	linux-kernel@vger.kernel.org,
	hawk@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	sdf@fomichev.me,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	michael.chan@broadcom.com,
	john.fastabend@gmail.com,
	ast@kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [net-next,v2,2/4] bnxt_en: Implement XDP RSS hash metadata extraction
Date: Wed,  4 Mar 2026 18:57:03 -0800
Message-ID: <20260305025704.3619593-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303024510.644962-3-carges@cloudflare.com>
References: <20260303024510.644962-3-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 519A420A5E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,redhat.com,dama.to,fomichev.me,davemloft.net,lunn.ch,google.com,iogearbox.net,gmail.com,cloudflare.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-264156-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bnxt_en: Implement XDP RSS hash metadata extraction

This commit adds support for extracting RSS hash values and hash types from
hardware completion descriptors in XDP programs for the bnxt_en driver.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 85cbeb35681c..1ab3d9f9b3ac 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c

[ ... ]

> @@ -472,3 +472,50 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
>  				  xdp_buff_get_skb_flags(xdp));
>  	return skb;
>  }
> +
> +int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> +		     enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct bnxt_xdp_buff *xdp = (void *)ctx;
> +	const struct rx_cmp *rxcmp = xdp->rxcmp;
> +	const struct rx_cmp_ext *rxcmp1 = xdp->rxcmp1;
> +	enum xdp_rss_hash_type hash_type = 0;
> +	u32 itypes;
> +
> +	if (!rxcmp || !RX_CMP_HASH_VALID(rxcmp))
> +		return -ENODATA;
> +
> +	*hash = le32_to_cpu(rxcmp->rx_cmp_rss_hash);
> +
> +	if (!rxcmp1) {
> +		*rss_type = XDP_RSS_TYPE_L2;
> +		return 0;
> +	}
> +
> +	if (xdp->cmp_type == CMP_TYPE_RX_L2_CMP) {
> +		itypes = RX_CMP_ITYPES(rxcmp);
> +		if (rxcmp1->rx_cmp_flags2 &
> +		    cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE)) {
> +			hash_type |= XDP_RSS_TYPE_L3_IPV6;
> +		} else {
> +			hash_type |= XDP_RSS_TYPE_L3_IPV4;
> +		}
> +
> +		switch (itypes) {
> +		case RX_CMP_FLAGS_ITYPE_TCP:
> +			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_TCP;
> +			break;
> +		case RX_CMP_FLAGS_ITYPE_UDP:
> +			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_UDP;
> +			break;
> +		case RX_CMP_FLAGS_ITYPE_ICMP:
> +			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_ICMP;
> +			break;
> +		default:
> +			break;
> +		}
> +	}

What happens when xdp->cmp_type is CMP_TYPE_RX_L2_V3_CMP instead of
CMP_TYPE_RX_L2_CMP? Looking at bnxt_rx_pkt() in bnxt.c, when XDP is attached,
the cmp_type field can be set to CMP_TYPE_RX_L2_V3_CMP on P5+ hardware:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_rx_pkt() {
    ...
    cmp_type = RX_CMP_TYPE(rxcmp);
    ...
    if (bp->xdp_prog) {
        ...
        bnxt_xdp.cmp_type = cmp_type;
        ...
    }
}

In the V3 case, this function returns success with *hash set correctly but
leaves *rss_type as 0 (XDP_RSS_TYPE_L2/XDP_RSS_TYPE_NONE) because the type
classification logic is skipped.

The existing SKB path handles V3 completions differently:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_rx_pkt() {
    ...
    if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
        bnxt_rss_ext_op(bp, rxcmp1, skb);
    } else {
        skb_set_hash(skb, ...);
    }
}

Where bnxt_rss_ext_op() uses RX_CMP_V3_HASH_TYPE() for proper L3/L4
classification.

Should bnxt_xdp_rx_hash() handle CMP_TYPE_RX_L2_V3_CMP completions with
equivalent V3 hash type decoding, or return -ENODATA for V3 completions to
avoid returning success with misleading type information?

> +
> +	*rss_type = hash_type;
> +	return 0;
> +}
-- 
pw-bot: cr

