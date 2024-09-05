Return-Path: <netdev+bounces-125596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA2D96DD08
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAFEB21803
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AE919DFB9;
	Thu,  5 Sep 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bd8QLJc/"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71074199EA1
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548322; cv=none; b=CMWiEXLSBwP7hZd0X8OiL+v+CAjjsYpWkl/VmS9Fp6aHxVxc74O0eT6Idneul8vCPsSFA0Tj5t0pcmB/asjPiMa+uR9nuV7JLHUMcfeY/L61+uUce52OsNPe9sQ3HnVUQ77saYjZALH0StQvCJdu8UIh/piSCMHEv+ePXCl2ppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548322; c=relaxed/simple;
	bh=jpuPs/3VAq9m4kg/QjVQnwwV7wxSnZXVCl3Y5NtoJ7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isWiI+3T2bVQ8Cl6ZhbYNuM1NVLBl33mI/0FSzp2zWvtjmjAxy1wLxJM9WkoHUTR+6RlrBCauUQNJ6UML2yKnJ/nvSNm64MyAdSJaIa3PhNLukbUtCP+ZIjUApzcfsPlCVNiX7Ofo/bRNPui7UorYOpZLdok0uhrfW03yzXu0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bd8QLJc/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725548316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fi4RLUHYvTUskh8oYrBV6EbBwLBbgSFmQd7LYsGkcA=;
	b=bd8QLJc/V3MA2iYRGotQIOeLbCjyqBLgvYlOCICyeKsLFuyYEgtyUFH9ELqIqU5hLEiSNK
	XFRj/c/xeAxkyVZIeZGnazPdeg4ZNdHJzcnMK74r8Xqv9UHjoNdp93ceS9IqHmxdJB5abk
	tzsv86vscjGHpiRRrcaLBRAOBNJoWDA=
Date: Thu, 5 Sep 2024 15:58:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/4] net_tstamp: add SCM_TS_OPT_ID for TCP
 sockets
To: Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-3-vadfed@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240904113153.2196238-3-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/09/2024 12:31, Vadim Fedorenko wrote:
> TCP sockets have different flow for providing timestamp OPT_ID value.
> Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>   net/ipv4/tcp.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 8a5680b4e786..5553a8aeee80 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
>   }
>   EXPORT_SYMBOL(tcp_init_sock);
>   
> -static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>   {
>   	struct sk_buff *skb = tcp_write_queue_tail(sk);
> +	u32 tsflags = sockc->tsflags;
>   
>   	if (tsflags && skb) {
>   		struct skb_shared_info *shinfo = skb_shinfo(skb);
> @@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
>   		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
>   		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
>   			tcb->txstamp_ack = 1;
> -		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> -			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> +			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
> +				shinfo->tskey = sockc->ts_opt_id;
> +			else
> +				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +		}
>   	}
>   }
>   
> @@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   
>   out:
>   	if (copied) {
> -		tcp_tx_timestamp(sk, sockc.tsflags);
> +		tcp_tx_timestamp(sk, &sockc);
>   		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
>   	}
>   out_nopush:

Hi Willem,

Unfortunately, these changes are not enough to enable custom OPT_ID for
TCP sockets. There are some functions which rewrite shinfo->tskey in TCP
flow:

tcp_skb_collapse_tstamp()
tcp_fragment_tstamp()
tcp_gso_tstamp()

I believe the last one breaks tests, but the problem is that there is no
easy way to provide the flag of constant tskey to it. Only
shinfo::tx_flags are available at the caller side and we have already
discussed that we shouldn't use the last bit of this field.

So, how should we deal with the problem? Or is it better to postpone
support for TCP sockets in this case?

Thanks,
Vadim

