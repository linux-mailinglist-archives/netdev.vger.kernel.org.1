Return-Path: <netdev+bounces-51653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8107FB989
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6961C21265
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD74F605;
	Tue, 28 Nov 2023 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="ZOKFVZLJ"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 03:40:26 PST
Received: from mail.codelabs.ch (mail.codelabs.ch [IPv6:2a02:168:860f:1::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E4A1B5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:40:25 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id EBCA15A0002;
	Tue, 28 Nov 2023 12:33:38 +0100 (CET)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FyRnkDlzjwQi; Tue, 28 Nov 2023 12:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1701171217;
	bh=ijlBdevSwPl9qZWXfAAZ8Uk5B+Sp7Ldz+HBo7ZWOGjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZOKFVZLJG2w8OqB06h7zY7Q+ulLY6b9143qiuNOlYSlkf4YD8/cVoLJpTty0GN4SD
	 B8+/jR8t4WcmW8+oQsBQXAMSagUMwKNyLlj+rf4SNF8gqrqQjAKj9oOwyn73L24ld4
	 K2KiF7cqJ5NyCT2B/4Ol8yKkfhSn5yPsCmWlK9KnJqbjHuxlNp5BtgK33bLgTzZYdw
	 TciZ66z2i4TtNOFoXFHPnY1x6irH7XKDRCE0cQYsrXacfwEdKGTY+fz08qq2VzKIPj
	 ZU2poRFGflm8/T/OXIDK6WZNADKi4TQqp/h1NETKZZa2lkodIlSrirZONwlGzHfd3c
	 JGU56fHYvULjQ==
Received: from [IPV6:2a01:8b81:5400:f500:cd44:2474:7fd5:2eb2] (unknown [IPv6:2a01:8b81:5400:f500:cd44:2474:7fd5:2eb2])
	by mail.codelabs.ch (Postfix) with ESMTPSA id 58EF45A0001;
	Tue, 28 Nov 2023 12:33:37 +0100 (CET)
Message-ID: <bfda402b-c745-4e17-8abe-8b2171605326@strongswan.org>
Date: Tue, 28 Nov 2023 12:33:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xfrm: Remove inner/outer modes from output path
To: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20230419075300.452227-1-steffen.klassert@secunet.com>
 <20230419075300.452227-3-steffen.klassert@secunet.com>
Content-Language: en-US, de-CH-frami
From: Tobias Brunner <tobias@strongswan.org>
Autocrypt: addr=tobias@strongswan.org; keydata=
 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
 tvkh7XWO2ycrW1UlzUzM4KV3SDLIhfOU
In-Reply-To: <20230419075300.452227-3-steffen.klassert@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steffen, Herbert,

> @@ -875,21 +875,10 @@ static int xfrm6_extract_output(struct xfrm_state *x, struct sk_buff *skb)
>  
>  static int xfrm_inner_extract_output(struct xfrm_state *x, struct sk_buff *skb)
>  {
> -	const struct xfrm_mode *inner_mode;
> -
> -	if (x->sel.family == AF_UNSPEC)
> -		inner_mode = xfrm_ip2inner_mode(x,
> -				xfrm_af2proto(skb_dst(skb)->ops->family));
> -	else
> -		inner_mode = &x->inner_mode;
> -
> -	if (inner_mode == NULL)
> -		return -EAFNOSUPPORT;
> -
> -	switch (inner_mode->family) {
> -	case AF_INET:
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
>  		return xfrm4_extract_output(x, skb);
> -	case AF_INET6:
> +	case htons(ETH_P_IPV6):
>  		return xfrm6_extract_output(x, skb);
>  	}

The changes in this function indirectly break tunneling IPv4 packets
sent from RAW sockets.  Such packets currently don't have
skb->protocol set, so this results in EAFNOSUPPORT.  For IPv6, this
isn't a problem because the protocol is set since v3.11, or more
specifically 9c9c9ad5fae7 ("ipv6: set skb->protocol on tcp, raw and
ip6_append_data genereated skbs").  For IPv4, that's not the case.  I
wonder why this hasn't been an issue so far (e.g. with MTU calculation
as mentioned in that commit for IPv6).

To fix this, we basically need the patch below.  The question is how
it should be marked with regards to a Fixes: tag.  Should it actually
reference this xfrm-specific commit?  Or should it even get backported
further (e.g. reference the ipv6 commit above)?  (The question then
would be if this change could have unintended side-effects.)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 27da9d7294c0..696e1e734729 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -350,6 +350,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 		goto error;
 	skb_reserve(skb, hlen);
 
+	skb->protocol = htons(ETH_P_IP);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;

Regards,
Tobias


