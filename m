Return-Path: <netdev+bounces-261120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHPDDpOpn2mddAQAu9opvQ
	(envelope-from <netdev+bounces-261120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:01:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E29719FFC1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A07D3015886
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDD1315D52;
	Thu, 26 Feb 2026 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXCaShYM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B63717A2EA
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071312; cv=none; b=LD5LBE2VQT6y2PAbMpB+CU2c0WZ8M8A5BU4tIJvkKV+DWPkh3xa4L3PSx0pridf+/jX4XSbKnBvbxaKwG7Gfg2rK0matSzLXsrw2LwdWBlLVKzhUkl3R9y7HGWQ75+jnhWlrKv/EQhXoV5OtwjMZj0zPTfD51B7dfP0y0w9Wx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071312; c=relaxed/simple;
	bh=995qzGAbSDd5Oa7taQE/busdFj6zZijHL/Z90Q+xmAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrwNAqmOcPfRQafFZXtUm7rKa81VkyhaQoV7m5fIl1ACLBrFqQwA9wLiywEu8cRhxkljtfzlIg+Cv9B7/zYK0FkWjIF256hG2x37qE240/wNf2ejV3ez7aGV40XtVAz5/rkvVh1f2Ogb1xxgYiwHH5uzJsWcSknhAwx7I+jgpOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXCaShYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757F7C19423;
	Thu, 26 Feb 2026 02:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772071311;
	bh=995qzGAbSDd5Oa7taQE/busdFj6zZijHL/Z90Q+xmAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hXCaShYM+A7bcWG845+/Pn7U4TI6yZ/h9MM3lK4oJ/rmuX4TZCYnLYwPZWKT5hxys
	 4pxVhhN7inDc/zv+zxWgoIIpN+rbav8ZgKUTr+IU9q9b10hv0kBWVJLiNpkafIJtag
	 rD0Vqhz90RnWyjJmjTmhgwioHAahVvlsVDsucy4lsTuHS82MGVPnZ0OQgjyPLwss9P
	 sty9DnrrB0t15KuJRGg424VVROaixw+SK2wVU+CFq6QCV+M3uN5QYLth/wujLzHixb
	 gxFxC6k5L+wqMtxySIGSjyS0dDzYiMjlqUoncf4zg0EkfT6P/9hvN4sQDYnplgdBo0
	 z461K26a4sZiw==
Date: Wed, 25 Feb 2026 18:01:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v3 net-next 2/3] netdevsim: Implement basic ptp support
Message-ID: <20260225180150.7eccfb08@kernel.org>
In-Reply-To: <20260225153858.29486-3-maciek@machnikowski.net>
References: <20260225153858.29486-1-maciek@machnikowski.net>
	<20260225153858.29486-3-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-261120-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E29719FFC1
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 16:38:57 +0100 Maciek Machnikowski wrote:
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 6285fbefe..b1161c1ca 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -30,6 +30,8 @@
>  #include <net/rtnetlink.h>
>  #include <net/udp_tunnel.h>
>  #include <net/busy_poll.h>
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/timecounter.h>

Alphabetical sort please

>  	struct netdevsim *peer_ns;
>  	struct netdev_config *cfg;
> +	bool gen_tx_tstamp = false;
>  	struct nsim_rq *rq;

reverse xmas tree

> +	gen_tx_tstamp = skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
> +	if (gen_tx_tstamp) {
> +		ptp_info = mock_phc_get_ptp_info(ns->phc);
> +
> +		/* Create a copy of tx skb to keep the tx reference */
> +		skb_orig = skb;
> +		skb = skb_copy(skb_orig, GFP_ATOMIC);
> +		skb_shinfo(skb_orig)->tx_flags |= SKBTX_IN_PROGRESS;
> +
> +		/* Timestamp as late as possible */
> +		if (ptp_info)
> +			ptp_info->gettime64(ptp_info, &tx_ts);
> +	}

Do we have to copy the packet? We can't deliver the timestamp before 
we run Rx, on the original skb?

>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>  				      skb, rq, psp_ext) == NET_RX_DROP))
>  		goto out_drop_cnt;

'Cause I think this leaks skb_orig now.

> +	/* Generate Rx tstamp based on the peer clock */
> +	ptp_info = mock_phc_get_ptp_info(peer_ns->phc);
> +	if (ptp_info) {

we can still gate this on whether timestamps are enabled, no?

> +		ptp_info->gettime64(ptp_info, &rx_ts);
> +		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);


