Return-Path: <netdev+bounces-115353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34612945F21
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0E128441A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D216D1E3CB8;
	Fri,  2 Aug 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="flc1ttft"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE01EEF9;
	Fri,  2 Aug 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607765; cv=none; b=JOjqXV7IUcXxKZ0eKDsk3rlhJAEm1Ff/OKqvZ5g46e0WL0Ze98jYIHcGfdpxnGLQwe5HC9fkXG6TivwlhvyML30Z/zTTO9Jh5VHsYc/kIC9ufBth4Y6nz9Yqt210n67Hsrrshiw0LSf9NZ9uIIU1AmddA6ySmNAkIFL3j1ixrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607765; c=relaxed/simple;
	bh=8aPj2nIntgmfW19Mn0CoHG78RbeTKwJCAKokFBJ3vFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAAFsZH4fqOf+cAQbFpYC+/PmZTM2iiELi2Ku/cYzNWf1eWZcfMgbLeH81kIY7HCwTqZck4JJ3gI4odOkkJskwHB22aneqpMf7s6cbyN65Indsh+OFuHhG6oKDflsPXn4TU5Rh8SaAil5h3q74KlajTAbnaqnd/OyDeWBqo6fks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=flc1ttft; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ZsRVs1261jeEBZsRVs9mZU; Fri, 02 Aug 2024 15:35:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722605739;
	bh=bUGQWQ6HeX/0on+n88StgC2Xu31/KnbENv/BO2RPW38=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=flc1ttftNWKukhI3mogmvoyWlsRr8+1q8QhfP0zHSXxFdudDWO7mTH3h8fNMi5YSg
	 E7EV+VLHI/0Kap4WSmbtoaIdzHLmIwijibFuriPEHEqBh68SaOBmL5BfZyohpX1upu
	 ZvxowL/UjQmdyJ/S1Wm6orM9WvFxnwdw2/idRvTShCpJRPQ+rcrQj8YrK1gNhVerBi
	 6EENmZ4T0RZ5mW6RywYq/gvmRmDaaMq1xRkeP6KQJ4QUi/eMfnx9Z/6f18bnFIxhK7
	 BEJAlDyS/Db2zRZeDci7H3WKRC5/CWOBY1/EWvU7vRjnaBojlVwpE2xFjbdgxp0ze9
	 hF6L0XUMMq/QQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 02 Aug 2024 15:35:39 +0200
X-ME-IP: 90.11.132.44
Message-ID: <e792d1b6-b9b5-4e90-801d-ad10893defc1@wanadoo.fr>
Date: Fri, 2 Aug 2024 15:35:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: use ip_hdrlen() instead of bit shift
To: Moon Yeounsu <yyyynoom@gmail.com>, cooldavid@cooldavid.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240802054421.5428-1-yyyynoom@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240802054421.5428-1-yyyynoom@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/08/2024 à 07:44, Moon Yeounsu a écrit :
> `ip_hdr(skb)->ihl << 2` are the same as `ip_hdrlen(skb)`
> Therefore, we should use a well-defined function not a bit shift
> to find the header length.
> 
> It also compress two lines at a single line.
> 
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> ---
>   drivers/net/ethernet/jme.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 

Hi,

> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index b06e24562973..83b185c995df 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
>   	if (skb->protocol != htons(ETH_P_IP))
>   		return csum;
>   	skb_set_network_header(skb, ETH_HLEN);
> +
>   	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
> -	    (skb->len < (ETH_HLEN +
> -			(ip_hdr(skb)->ihl << 2) +
> -			sizeof(struct udphdr)))) {
> +	    (skb->len < (ETH_HLEN + (ip_hdrlen(skb)) + sizeof(struct udphdr)))) {

The extra () around "ip_hdrlen(skb)" can be remove.
Also maybe the ones around "ETH_HLEN + ip_hdrlen(skb)" could also be 
removed.

>   		skb_reset_network_header(skb);
>   		return csum;
>   	}
> -	skb_set_transport_header(skb,
> -			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
> +	skb_set_transport_header(skb, ETH_HLEN + (ip_hdrlen(skb)));

Same here, the extra () around "ip_hdrlen(skb)" can be remove.

CJ

>   	csum = udp_hdr(skb)->check;
>   	skb_reset_transport_header(skb);
>   	skb_reset_network_header(skb);


