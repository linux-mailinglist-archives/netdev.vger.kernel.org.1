Return-Path: <netdev+bounces-122531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F8961969
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00326284E50
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771541D3641;
	Tue, 27 Aug 2024 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HC9rXyD4"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628C13B293
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795413; cv=none; b=rzn/pyR0kgR7duOCZgD18i0DmuyFVSdbvwOO69K1TYm7Mc6XJz1nHRUXBgwiEgbfQatjhu5lN00UMSOraUXZ33vWGGQ7F7qQ4kevsR+a0jJ2j4qYvpaO6bF/Bm5OTYjkbCgNQGwNL1G2DkW8tLWDhwmnW23qv/J3AGo4McdBfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795413; c=relaxed/simple;
	bh=tTKMCtqcRQnlf/R1QbtO4jJc4MOD7HlcnhfsMdD+RX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5bCA5Y+JS0h5nm5PSwGd+8IgmJwMQKdHZok9Rks8LjtoaB/eAYMR3uyHbu2Adrrbzf1kIQ52Er6mHrYtwAgSNrGieLqjVwOTjRdRSVJJmQGcGVsZ9R3zcrpBEImY/XXpN2GhnUC+fL3WD144+RCYPW5x1XUftmS69BpCygURDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HC9rXyD4; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <92e329ec-b504-48fa-9ef8-83efa7e5ba6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724795408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W05anCFasN/rlTR1bYlC+7NpJpgRKnC+hsl8vBTHAyA=;
	b=HC9rXyD4D2mP7V8B+HDDJ+pi7ZI3Kp5tegOPBSQl2W5Ih6i5ffeLUBMlj3KBgJUmwFicy+
	4W6GMXHB6UHcxXnXtuX0oCPQOHhkgK+7NRIVpnwQ3rBbPZONAUgQdBLpoddKgHt6f7C7AU
	ujIw+tr1OjIyPf9Ero4IbbC80kPjmaY=
Date: Tue, 27 Aug 2024 14:50:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch net-next] tcp_bpf: remove an unused parameter for
 bpf_tcp_ingress()
To: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 Yaxin Chen <yaxin.chen1@bytedance.com>, netdev@vger.kernel.org
References: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/23/24 3:48 PM, Yaxin Chen wrote:
> Parameter flags is not used in bpf_tcp_ingress().
> 
> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Yaxin Chen <yaxin.chen1@bytedance.com>
> ---
>   net/ipv4/tcp_bpf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 53b0d62fd2c2..57a1614c55f9 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -30,7 +30,7 @@ void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
>   }
>   
>   static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
> -			   struct sk_msg *msg, u32 apply_bytes, int flags)
> +			   struct sk_msg *msg, u32 apply_bytes)
>   {
>   	bool apply = apply_bytes;
>   	struct scatterlist *sge;
> @@ -167,7 +167,7 @@ int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
>   	if (unlikely(!psock))
>   		return -EPIPE;
>   
> -	ret = ingress ? bpf_tcp_ingress(sk, psock, msg, bytes, flags) :
> +	ret = ingress ? bpf_tcp_ingress(sk, psock, msg, bytes) :

lgtm also. John and Jakub Sitnicki, please help to take a look and Ack if this 
looks good to you also.

>   			tcp_bpf_push_locked(sk, msg, bytes, flags, false);
>   	sk_psock_put(sk, psock);
>   	return ret;


