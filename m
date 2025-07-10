Return-Path: <netdev+bounces-205630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C286AFF6EB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA33B3EB3
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830827F18C;
	Thu, 10 Jul 2025 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnIcmjWa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33325BF14;
	Thu, 10 Jul 2025 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115241; cv=none; b=UOX210H6CqJubMINaF3lJaW6hqIK2lqGZR6CcaNpye1Zdq4Lg+8JpXZ+jIMeHGaRiacF2Iltd/0XiuoR3Y02YmmfHhCtwE8v2T554s1nvrYn7evchhfr9rIOwEUFCHE3W1fxQoF/h43FPX9aMITxOrI4IO9uvkRVfpqFQ6bOC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115241; c=relaxed/simple;
	bh=SbXUiYCtMWlpHCV2pzP17uIzAf874pHFFFrd6zNJLHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXt/i44F/Z55xE+nW1TZWbps0fE11ltXlyvVC8oARJ3PoZBqxIReOneflXjF4RM+YyRISkxszsuUq8UyUQcfDNqXHJCVHhTJGVpqGCph9UR6S1I9IX+ndX5fgPSN7cHYd55/y1rSw2wwLjVKJ8XAQ5k0jJ/blRS8HbQ22oBDvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnIcmjWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE1EC4CEEF;
	Thu, 10 Jul 2025 02:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115240;
	bh=SbXUiYCtMWlpHCV2pzP17uIzAf874pHFFFrd6zNJLHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CnIcmjWawEkECd7KPbCiN3OQ+p6HKq5Wuwb9+DVcJimaUCswv5Z+DOMJZljVYEMAY
	 OkdDIKp0YK7Rpomq40HYzMOEJkzAyjtrrzbhxARSN0wP4Qi2JlnvRpL8W8KmZThEBb
	 PVS402BTTrfkypwv+71HT7rk1OWsMSqvmt8erBGhaqvARDyh6tkvU8zyp+D5/l08z0
	 YdRInM7ZjgaYIXP4p4ielp1yFTSi2b7K7nWeX2tO2xugvr01AHLcY37MT18ItbJwEW
	 U5K/1R2+dnpICaSC0oDy1pRqvSD9rpTq2YsXH7+WWI+7HZ6kpXby4ewHKjf5ekercL
	 /G3zNYAvYG7HA==
Date: Wed, 9 Jul 2025 19:40:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 1/1] net: selftests: add PHY-loopback test
 for bad TCP checksums
Message-ID: <20250709194039.72202043@kernel.org>
In-Reply-To: <20250708122823.2435505-1-o.rempel@pengutronix.de>
References: <20250708122823.2435505-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 14:28:23 +0200 Oleksij Rempel wrote:
>  	if (attr->tcp) {
>  		int l4len = skb->len - skb_transport_offset(skb);
>  
> -		thdr->check = ~tcp_v4_check(l4len, ihdr->saddr, ihdr->daddr, 0);
> -		skb->csum_start = skb_transport_header(skb) - skb->head;
> -		skb->csum_offset = offsetof(struct tcphdr, check);
> +		if (attr->bad_csum) {
> +			__sum16 good_csum;
> +			u16 bad_csum;
> +
> +			skb->ip_summed = CHECKSUM_NONE;
> +			thdr->check = 0;
> +			skb->csum = skb_checksum(skb, skb_transport_offset(skb),
> +						 l4len, 0);
> +			good_csum = csum_tcpudp_magic(ihdr->saddr, ihdr->daddr,
> +						      l4len, IPPROTO_TCP,
> +						      skb->csum);
> +
> +			/* Flip the least-significant bit.  This is fast,
> +			 * deterministic, and cannot accidentally turn the
> +			 * checksum back into a value the stack treats as valid
> +			 * (0 or 0xFFFF).
> +			 */
> +			bad_csum = (__force u16)good_csum ^ 0x0001;
> +			if (bad_csum == 0 || bad_csum == 0xFFFF) {
> +				/* If the checksum is 0 or 0xFFFF, flip another
> +				 * bit to ensure it is not valid.
> +				 */
> +				bad_csum ^= 0x0002;
> +			}
> +
> +			thdr->check = (__force __sum16)bad_csum;
> +		} else {
> +			skb->csum = 0;
> +			skb->ip_summed = CHECKSUM_PARTIAL;
> +			thdr->check = ~tcp_v4_check(l4len, ihdr->saddr,
> +						    ihdr->daddr, 0);
> +			skb->csum_start = skb_transport_header(skb) - skb->head;
> +			skb->csum_offset = offsetof(struct tcphdr, check);
> +		}
>  	} else {
> +		skb->csum = 0;
> +		skb->ip_summed = CHECKSUM_PARTIAL;
>  		udp4_hwcsum(skb, ihdr->saddr, ihdr->daddr);
>  	}

I think it'd be simpler if - after setting up CHECKSUM_PARTIAL
we called skb_checksum_help() to get the correct checksum filled in
and then did the bad checksum mangling.

BTW mangling like this should be idiomatic enough to avoid the comment:

	thdr->check = thdr->check ^ 1 ?: CSUM_MANGLED_0;
-- 
pw-bot: cr

