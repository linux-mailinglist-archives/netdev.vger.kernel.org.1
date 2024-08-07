Return-Path: <netdev+bounces-116460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64E894A7AD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75A31C2192E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F10B1E4F18;
	Wed,  7 Aug 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Z4vW7fBv"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61CC1C57BE;
	Wed,  7 Aug 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033698; cv=none; b=i19/Zz9RMX2ow/PvdWRBcwlHFy8PPciIqOvOXCfhe0uTLwFzz3U0AM63pyNuc2SS3xBK01n3dzlh8v8VOw3UcQE9e4ou0Pd/A3nqWrzJTxs/owuo43On3swgrJEo60wE52hILvK+ZuMi+E0qOGBZrLRNofO6UjD8vUbKweNToDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033698; c=relaxed/simple;
	bh=SqMOCythxzQqCY+lWdjHygqsO5tL4QYBop/gjmsZfiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzGEsvlV7poQtLGllkt7S6cjl1FbZU9dvJ2vLWsBvNxv06K7oCQ2AV36LKs7/PERWQuPrpp4Oez0RzRtwaNL49uYr+Gqr+UMh76XXuVEJ1XTjA7yqMb1O1JLABPVvNX/TGzj0btFctceu0ZC7ciUhIzvMW9qwQENxxWn9BVJU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Z4vW7fBv; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bflusC0EbxIArbflusddu3; Wed, 07 Aug 2024 14:28:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723033688;
	bh=2vfZY3nddFhtxMjpMQJnJki0lc7IKZ7yCee76VY1+lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Z4vW7fBv9P6cCalwXwfo0IZdQsh3aTjSlixk50mEaEfD6x0Uz9q0jAJ9uvhirQgjt
	 uyjwtw4Wp56pjt29vfmQJjO+coX3AL1ZdAKEcyg6Juqrpg/XfrdehdqHWSnqo6fLyk
	 tG6Fh99+Ue/Wx3jjfFlhaA3i2yozPpB8xqx9DE8ieb/edMvTIAUiYuKm3Bd/OCJXNF
	 i6epJxHeBjeWfkyebIQMJrJlqb9MT4CwXMGKXlyFr0WFnYyisvlTBD8VSOzO/wufqY
	 k2x/Utnbqd6fsN67zKzkZCnPhg5dI0Bn++iL0ze+LjKRzVyfPiezmAF0MuuVEqp+S8
	 Mk2gqosrYeW7A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 07 Aug 2024 14:28:08 +0200
X-ME-IP: 90.11.132.44
Message-ID: <4850b81e-d426-4abd-87f8-2712cd0b5de4@wanadoo.fr>
Date: Wed, 7 Aug 2024 14:28:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: ethernet: use ip_hdrlen() instead of bit shift
To: Moon Yeounsu <yyyynoom@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240807100721.101498-1-yyyynoom@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240807100721.101498-1-yyyynoom@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/08/2024 à 12:07, Moon Yeounsu a écrit :
> `ip_hdr(skb)->ihl << 2` is the same as `ip_hdrlen(skb)`
> Therefore, we should use a well-defined function not a bit shift
> to find the header length.
> 
> It also compresses two lines to a single line.
> 
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

> ---
> v1: use ip_hdrlen() instead of bit shift
> Reference: https://lore.kernel.org/all/20240802054421.5428-1-yyyynoom@gmail.com/
> 
> v2: remove unnecessary parentheses
> - Remove extra () [Christophe Jaillet, Simon Horman]
> - Break long lines [Simon Horman]
> Reference: https://lore.kernel.org/all/20240803022949.28229-1-yyyynoom@gmail.com/
> 
> v3: create a standalone patch
> - Start with a new thread
> - Include the change logs,
> - Create a standalone patch [Christophe Jaillet]
> 
>   drivers/net/ethernet/jme.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index b06e24562973..d8be0e4dcb07 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
>   	if (skb->protocol != htons(ETH_P_IP))
>   		return csum;
>   	skb_set_network_header(skb, ETH_HLEN);
> -	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
> -	    (skb->len < (ETH_HLEN +
> -			(ip_hdr(skb)->ihl << 2) +
> -			sizeof(struct udphdr)))) {
> +
> +	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
> +	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
>   		skb_reset_network_header(skb);
>   		return csum;
>   	}
> -	skb_set_transport_header(skb,
> -			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
> +	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
>   	csum = udp_hdr(skb)->check;
>   	skb_reset_transport_header(skb);
>   	skb_reset_network_header(skb);


