Return-Path: <netdev+bounces-200860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11E5AE71B9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B05189F755
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2691D25A2C3;
	Tue, 24 Jun 2025 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="KkLx79AJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx12lb.world4you.com (mx12lb.world4you.com [81.19.149.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87342561C2
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802006; cv=none; b=fs9evC+ml99bwphCyQUn0h5A0brXTOJ3Tv8XTP7+P7YsxxE0yOIIFmLJHwvvPgVIkGYmAJckfVhD7JHG4F80MjIqUufcXWXbza64fAHwCyck7JCBLKvNWi/3Iaqxt6SEJ8DojVBFZf79QfYUSLO28y8jnVuYUpQz6rFhLHZbtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802006; c=relaxed/simple;
	bh=vjxpQTmyH3su4oYWKiqio8CHDVXO0PUNf60dyygCXlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8+OR+9WmQobk3J0oXRrMC+wdGgIm366VVXI2TEADIUSckRB4X5bI9tZ2U9275Nrxv2KwaY2LmMrbqJUfYvn8YXLzJIDPuBmf3mP5rfSWzuiQttCqfdzCuEOGXWtyl0k8I4JEAz9W7Ri35pTx9Mc02qZz8T4f3pjmcm/fmqTWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=KkLx79AJ; arc=none smtp.client-ip=81.19.149.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y94rvac8VRSOZWnPGx0aNoGOeEIrB/kG+lHlP2yBntM=; b=KkLx79AJU1niXPZqhcxv15ICsp
	zeCzz1wxJpIh/PpcpFMd8YvA8qUafplwtO0zLNp/H0gJ1sP74uSPk6siUX/HzMH0Xn3YKHZqJT++Q
	0uvbIxzm78QvmPByxm70tXo1tUg2cH6w/5ULsvuXV4dv1pnbgEGCbtv5UvV9g6+NN1SU=;
Received: from [178.191.106.13] (helo=[10.0.0.160])
	by mx12lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1uUAeE-000000008Jd-0MhS;
	Tue, 24 Jun 2025 22:53:42 +0200
Message-ID: <c182ba60-81fc-4776-b3bb-6997e87f7749@engleder-embedded.com>
Date: Tue, 24 Jun 2025 22:53:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: selftests: fix TCP packet checksum
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 davem@davemloft.net
References: <20250624183258.3377740-1-kuba@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250624183258.3377740-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 24.06.25 20:32, Jakub Kicinski wrote:
> The length in the pseudo header should be the length of the L3 payload
> AKA the L4 header+payload. The selftest code builds the packet from
> the lower layers up, so all the headers are pushed already when it
> constructs L4. We need to subtract the lower layer headers from skb->len.
> 
> Fixes: 3e1e58d64c3d ("net: add generic selftest support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: o.rempel@pengutronix.de
> CC: gerhard@engleder-embedded.com
> 
> I changed the math from the pointers to the offsets (which is what
> udp4_hwcsum() does). Oleksij, would you be willing to retest and send
> your Reported-and-tested-by: tag?
> ---
>   net/core/selftests.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/selftests.c b/net/core/selftests.c
> index 35f807ea9952..406faf8e5f3f 100644
> --- a/net/core/selftests.c
> +++ b/net/core/selftests.c
> @@ -160,8 +160,9 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
>   	skb->csum = 0;
>   	skb->ip_summed = CHECKSUM_PARTIAL;
>   	if (attr->tcp) {
> -		thdr->check = ~tcp_v4_check(skb->len, ihdr->saddr,
> -					    ihdr->daddr, 0);
> +		int l4len = skb->len - skb_transport_offset(skb);
> +
> +		thdr->check = ~tcp_v4_check(l4len, ihdr->saddr, ihdr->daddr, 0);
>   		skb->csum_start = skb_transport_header(skb) - skb->head;
>   		skb->csum_offset = offsetof(struct tcphdr, check);
>   	} else {

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

And also tested with my selftest patches for tsnep, which did not made
it into mainline. So I'm not sure if a Tested-by is allowed.

(Tested-by: Gerhard Engleder <gerhard@engleder-embedded.com>)

gerhard

