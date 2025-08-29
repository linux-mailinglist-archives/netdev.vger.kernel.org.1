Return-Path: <netdev+bounces-218130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9341B3B39A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A121C8119D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 06:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167D257431;
	Fri, 29 Aug 2025 06:47:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF71FC0F3
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450029; cv=none; b=Ia3mXPNNdbtIFJd2wyUSLnHTELwXf1wb5KwqWHonTFlK30scoJGK+HeGrcSYCxa/lZRGotY/INuSi1p4Vr+BLdIRQN6aeia17Lkl3DXVfqSboRlvyHugjK3gRfv07RYM2NhwjKPoyYYipoLbrAqf9M9Kndq/nWQL+odkfyISsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450029; c=relaxed/simple;
	bh=Y61YY9e6wF7q6SMtlAYoiUQJyjWjGVzqPi5gRvvry4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oc8J+bHKzvLdsiMJPCAH0gccACT08sxtEIaJzOntTTbeURYYX1hpPiSpnxTjLJ/C9pJWG9CfXqGMruFUZujEFzUWlo39qD9JdtTODoqXEP/u8sctVa8yvfpEMJvFsD9F+HTYykuy5THhWy3yn0WCT2Z3DTb8xkC7MuASWIR4CIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cCpdb0HQkz2VRQB;
	Fri, 29 Aug 2025 14:44:03 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 76A111A0188;
	Fri, 29 Aug 2025 14:47:03 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 14:47:02 +0800
Message-ID: <df07de96-5b35-4e64-ae9d-41fcdb73d484@huawei.com>
Date: Fri, 29 Aug 2025 14:47:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/3] inet: ping: remove ping_hash()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20250828164149.3304323-1-edumazet@google.com>
 <20250828164149.3304323-3-edumazet@google.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250828164149.3304323-3-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/29 0:41, Eric Dumazet wrote:
> There is no point in keeping ping_hash().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> ---
>  net/ipv4/ping.c | 10 ----------
>  net/ipv6/ping.c |  1 -
>  2 files changed, 11 deletions(-)
> 
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index 74a0beddfcc41d8ba17792a11a9d027c9d590bac..75e1b0f5c697653e79166fde5f312f46b471344a 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -67,7 +67,6 @@ static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
>  	pr_debug("hash(%u) = %u\n", num, res);
>  	return res;
>  }
> -EXPORT_SYMBOL_GPL(ping_hash);

The declaration should also be removed

include/net/ping.h:58:void ping_unhash(struct sock *sk);

>  
>  static inline struct hlist_head *ping_hashslot(struct ping_table *table,
>  					       struct net *net, unsigned int num)
> @@ -144,14 +143,6 @@ int ping_get_port(struct sock *sk, unsigned short ident)
>  }
>  EXPORT_SYMBOL_GPL(ping_get_port);
>  
> -int ping_hash(struct sock *sk)
> -{
> -	pr_debug("ping_hash(sk->port=%u)\n", inet_sk(sk)->inet_num);
> -	BUG(); /* "Please do not press this button again." */
> -
> -	return 0;
> -}
> -
>  void ping_unhash(struct sock *sk)
>  {
>  	struct inet_sock *isk = inet_sk(sk);
> @@ -1008,7 +999,6 @@ struct proto ping_prot = {
>  	.bind =		ping_bind,
>  	.backlog_rcv =	ping_queue_rcv_skb,
>  	.release_cb =	ip4_datagram_release_cb,
> -	.hash =		ping_hash,
>  	.unhash =	ping_unhash,
>  	.get_port =	ping_get_port,
>  	.put_port =	ping_unhash,
> diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> index 82b0492923d458213ac7a6f9316158af2191e30f..d7a2cdaa26312b44f1fe502d3d40f3e27f961fa8 100644
> --- a/net/ipv6/ping.c
> +++ b/net/ipv6/ping.c
> @@ -208,7 +208,6 @@ struct proto pingv6_prot = {
>  	.recvmsg =	ping_recvmsg,
>  	.bind =		ping_bind,
>  	.backlog_rcv =	ping_queue_rcv_skb,
> -	.hash =		ping_hash,
>  	.unhash =	ping_unhash,
>  	.get_port =	ping_get_port,
>  	.put_port =	ping_unhash,

