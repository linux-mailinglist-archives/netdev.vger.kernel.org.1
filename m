Return-Path: <netdev+bounces-21097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B774076273F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF361C20F5A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6191026B9F;
	Tue, 25 Jul 2023 23:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260598BE1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785B0C433C7;
	Tue, 25 Jul 2023 23:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690327265;
	bh=LZ7f7GGnJEuxXTJj4VRU0pKI0QuHD+hGcdFmbT/XK3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bp2J09HufHjxWgwWvGLOQmlUXM/XzdEt4c/qN+FFl1roeWvqsBK2d/badfSMl+CFN
	 S7dW6TCcj0oq48gNHVXWWuqWMxvOs41OFBOmxgQtDTiFy6t7yGwoE11eClSZNB9deE
	 jakcXT5bAHKvF+dlAJlARph0Uo7Mz9MqNN0IFzqYaALanMeshcTFfwYAvlwd1HQpXx
	 BSND5cilObnPvDB4CeBpFtmgCeT3OeZhlw7hNQx01ACipwF7F/FgqvtCD96ns63eup
	 jzaDVtUXKQsaE4GBFo/YFsB99KMAw8ZAviOs8ky/avRZ6TLxhT8D+t8EudNIKeGXwb
	 hptmkm8888tKQ==
Message-ID: <c3f90818-3991-4b76-6f3a-9e9aed976dea@kernel.org>
Date: Tue, 25 Jul 2023 17:21:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] net: move comment in ndisc_router_discovery
Content-Language: en-US
To: Patrick Rohr <prohr@google.com>, "David S . Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>
References: <20230725185151.37310-1-prohr@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230725185151.37310-1-prohr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/23 12:51 PM, Patrick Rohr wrote:
> Move setting the received flag comment to the appropriate section.
> 
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  net/ipv6/ndisc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index eeb60888187f..0a29a4626194 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1266,10 +1266,6 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
>  	}
>  #endif
>  
> -	/*
> -	 *	set the RA_RECV flag in the interface
> -	 */
> -
>  	in6_dev = __in6_dev_get(skb->dev);
>  	if (!in6_dev) {
>  		ND_PRINTK(0, err, "RA: can't find inet6 device for %s\n",
> @@ -1297,6 +1293,10 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
>  	}
>  #endif
>  
> +	/*
> +	 *	set the RA_RECV flag in the interface
> +	 */
> +
>  	if (in6_dev->if_flags & IF_RS_SENT) {
>  		/*
>  		 *	flag that an RA was received after an RS was sent

There is already a comment here, so just delete the previous one.

