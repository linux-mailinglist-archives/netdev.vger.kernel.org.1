Return-Path: <netdev+bounces-273788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOnXLkdczGlmSgYAu9opvQ
	(envelope-from <netdev+bounces-273788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:44:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DCD372E65
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDE173036EDE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CAC3B5842;
	Tue, 31 Mar 2026 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="cQMr98VX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95E38F92F
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000606; cv=none; b=fug8H//aYqfhQs7FNa8SLkeYvDqzK0ho4Fn92BWC0bR0feuVTmKn4JOZ9lAkLBZR91W8aa+/iProAew6ee8M5uBNd7g9MncrzbDaYowkB8rHyEkGOjLk6gMnZMD+u20cYYvF2nOIUACMrOs6xAOw068AOaN2mqOof8j33NEVhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000606; c=relaxed/simple;
	bh=3g2a38R67MBCRSp7Vsl58EBejHN/y3woO8+/KWmyCxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erhMyxXB6ufHIQddQYSl7dy9oFijZETpWu9XLaejURdAMU7K4F+mm1CMvRYi6QifO0hHMNsAj3vmrz2F+rRbhUeFOCK0hkGBzCCZ0r08b+w+dQ+s75uIu2LGYyQjP8PCW98DJfvvwBsA+Uiz2qMMBatgvUtvg67fDELtVaQDbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=cQMr98VX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so13526425ad.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775000603; x=1775605403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns9AQ9mj0Un6sqyHivwFXkOMubqhHvzCLjhPKqBz+Qw=;
        b=cQMr98VXSFIctOrdmn2TEHVYj2h/bnBvkKmLH+ac4y/C1qxCP2uE0LiZa+yO7RqiGT
         m1X5hCHDuFOOg1Q9M+2ruU4aQ0X4/7dn1W/IfRM60NZ08ZtIFbS/z6cvElIKSzTQUkn6
         ULAWmVKl6vGKGuovHGF2phwyLBM3jEcXjOIQyzonrTVZ5oIrVKJ+Y+0JZkL3pj9BYPNm
         Ten9QtWVXJp6KQ7sJZj9MuOvm087cmvCon/qX5+VUF9hy1t54024ZW1Ucd5on+Ug32zo
         yjPnYhY0LiCnrQjMfFSg4YwSMqES/GTUKzrRp34+D9YpDggn3bJBbF3jlI/iOk5bJCcl
         3kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775000603; x=1775605403;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns9AQ9mj0Un6sqyHivwFXkOMubqhHvzCLjhPKqBz+Qw=;
        b=G4HQ9KV2fUSNVVA6oHmuevxZYoRxw+jAS1gKnZbEmUCl9R29OgD7TWyGxzECXp5svj
         f1v7uI2JGktF/0IiBxL8V+rqvkmAVoeINsejLeAYWAW1GO21IH/hK3mxBpJhCyV6r9eu
         O7BfPujhZbj+3U86VnAGleErpHN8xzU9/8sM6SsxH9qA5PppQNd9TaSfWH7DIk/Ob1ij
         0S0hkE6guwa+SmzYe+qnjNT3C2U7gRV5rFZrUijEnYyUH/d8Y2oScKj0xPOFhLGovK0Z
         MnZjklqlvwf9eRvz62GQEdRW6Fg4yWIlDTLLhPaDt5UP076V3m/l0bn2ANB0PGIZRSTn
         qeIg==
X-Forwarded-Encrypted: i=1; AJvYcCUyf5UbmsP2SIrTvckKElrYGlG9puZlwnFMURO2fP9XI7BTwe4bqN80Sdd0ub6rmMn5trL8C0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7N6Ocle2Mtz+vIqTymwV2cqSWpH6rcYlClqfVkuInF7QMJr6
	sj2rB0JT9jUlhiajJUiKbESO2rh5oQ5nC8rNwo57gMKkv7sPu7knyme5M9SXEMFZ9+s=
X-Gm-Gg: ATEYQzyfTuBa3J3xPfQghcSYyLgYYqWwlfyvxxbCjVy+OXrEPpU8eSuHEdJ5pnGKs/A
	OWlz82Byn9gmu7EyLOSKym8biUFrplnY+lnSjjJWP6aPF0VDsIDkb0jrg+ed/6zHlOaBdAXQEVh
	wUwI2G58J51L9UAoXYVQbokONqNbUAqwE3AZd4hBUB3EJm3hR88cdlPuhVAWT/gyuIstYIHMkTK
	C51+FEPM8vOU+LyOVUf/ZS4tc+u278WHQ/Hzeh1hiyfmF266xO0Yw8+CUaZix6goL6hQJVymqX0
	6/GuQz1P4EhPnfYQ5y6Or+guCfkSjYahDRrD3bpyi2qF3LasizMg4h8LkdNnXIgw0tiea+br6wg
	95EXGftC7+WPh2hJQHCZ/SHG8TR5xunYA2QNEyB+1rx7/RuMUyO1JFFG0Rn5dx60C1Zd18cdvws
	sL1fzS
X-Received: by 2002:a17:903:2d2:b0:2b0:beb4:3bb with SMTP id d9443c01a7336-2b269a805cdmr9425095ad.10.1775000603562;
        Tue, 31 Mar 2026 16:43:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266e487sm123072225ad.24.2026.03.31.16.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:43:23 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:43:22 -0700
From: Joe Damato <joe@dama.to>
To: Wang Jun <1742789905@qq.com>
Cc: Jes Sorensen <jes@trained-monkey.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-acenic@sunsite.dk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: alteon: Add missing DMA mapping error checks in
 ace_start_xmit
Message-ID: <acxcGhzbNsHdK49W@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Wang Jun <1742789905@qq.com>,
	Jes Sorensen <jes@trained-monkey.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-acenic@sunsite.dk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn,
	stable@vger.kernel.org
References: <tencent_FAB2A00E105488F503DCC787B8060F881E06@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_FAB2A00E105488F503DCC787B8060F881E06@qq.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-273788-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 55DCD372E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 09:48:41AM +0800, Wang Jun wrote:
> The ace_start_xmit function does not check the return value of
> dma_map_page (via ace_map_tx_skb) and skb_frag_dma_map when building
> transmit descriptors. If mapping fails, an invalid DMA address is
> written to the descriptor, which may cause hardware to access
> illegal memory, leading to system instability or crashes.
> 
> Add proper dma_mapping_error() checks for all mapping calls. When
> mapping fails, free the skb, increment the dropped packet counter,
> and return NETDEV_TX_OK.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Is this fixing a bug you've seen in the wild? If not, I'd probably drop the
fixes tag and send this to net-next instead.

> Cc: stable@vger.kernel.org
> Signed-off-by: Wang Jun <1742789905@qq.com>
> ---
>  drivers/net/ethernet/alteon/acenic.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
> index 455ee8930824..acabede53663 100644
> --- a/drivers/net/ethernet/alteon/acenic.c
> +++ b/drivers/net/ethernet/alteon/acenic.c
> @@ -2417,6 +2417,11 @@ static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
>  		u32 vlan_tag = 0;
>  
>  		mapping = ace_map_tx_skb(ap, skb, skb, idx);
> +		if (dma_mapping_error(&ap->pdev->dev, mapping)) {
> +			dev_kfree_skb(skb);
> +			dev->stats.tx_dropped++;
> +			return NETDEV_TX_OK;
> +		}
>  		flagsize = (skb->len << 16) | (BD_FLG_END);
>  		if (skb->ip_summed == CHECKSUM_PARTIAL)
>  			flagsize |= BD_FLG_TCP_UDP_SUM;
> @@ -2438,6 +2443,11 @@ static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
>  		int i;
>  
>  		mapping = ace_map_tx_skb(ap, skb, NULL, idx);
> +		if (dma_mapping_error(&ap->pdev->dev, mapping)) {
> +			dev_kfree_skb(skb);
> +			dev->stats.tx_dropped++;
> +			return NETDEV_TX_OK;
> +		}


I am not sure about this. The function ace_map_tx_skb seems to modify a
tx_ring_info entry, possibly writing invalid state to it if the dma_map_page
fails?

Maybe a better fix would be to refactor ace_map_tx_skb and do the
dma_mapping_error check there and change the return type of the function and
the code flow?

Then you wouldn't need to duplicate the error path handling code.

