Return-Path: <netdev+bounces-102804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5303E904D52
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075051F25AF4
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 08:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD1E16C6B4;
	Wed, 12 Jun 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+0chLGp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542FF1369AF;
	Wed, 12 Jun 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179190; cv=none; b=EnoRSZPQCKlX5Tq6OsAPZdSQRxavdN7FCeYurrSxXAGcRee+dHy68uXayj6KZC9hAjT5KWYmHu3LtImfdYFhXezNPFh15MaTekriMb/1c8F8B3lo3aaSZ/mrBMBjCDMO9MmdRp5eG1cZhtL5b6Jp/0RbcGqmUhcVYPunuYZvUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179190; c=relaxed/simple;
	bh=IawdLXVTxFLymI92USdaxv8s69/d7KuTRBgkwNJFy2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuM0v4US9jDFEoz8vKAEPSoUUlCaSu0rGZ/gGULYDmuL2ZU69FvV5F1CVKH2mRXsYo9dDgWn6QmzfD6SwZYAf3GMGAIxML6tRXtMF5/Lf46134o36++aph8J9ULK8zbff9grU0Vi3jfU48IpR/DneZBI8Cqps64pXlySqaG7cgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+0chLGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71D1C3277B;
	Wed, 12 Jun 2024 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718179189;
	bh=IawdLXVTxFLymI92USdaxv8s69/d7KuTRBgkwNJFy2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G+0chLGp54wyAGi7A+apGyUAiZTuwSavDO88Ajal/9KxsXKtOrjdlGa51lzpMht+W
	 RuLzab0qTJ27Nja9lxde7lE3OVtpfjp/8Bbaf19V5VJlFWYLC9CNNryX6BSKjQUl8P
	 DPVcgtZVkzSoYjrNy/0Qp9YCLlj58a7G0dC3CyjkzQR+fmMEoHPJfSA+c+t6Ji4zfL
	 aIBpNjMFqRRAkRIJQiazQfYZyTMLCUP/jJlEk5swEv04BZS+SL1HdDlcGbRXx2kJp3
	 xLX1qhDsJr9yhe6dKd/g7tdkI6gRK0jlisyHbllH0rU8FqP7X8xzJ2xRLDWBfnewFK
	 s6GdSehruh2jQ==
Message-ID: <fed7b2ca-5180-417f-a676-fb126157dff3@kernel.org>
Date: Wed, 12 Jun 2024 09:59:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 1/7] net: add rx_sk to trace_kfree_skb
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Neil Horman <nhorman@tuxdriver.com>, linux-trace-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <cover.1718136376.git.yan@cloudflare.com>
 <dcfa5db9be2d29b68fe7c87b3f017e98e5ec83b4.1718136376.git.yan@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <dcfa5db9be2d29b68fe7c87b3f017e98e5ec83b4.1718136376.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2024 22.11, Yan Zhai wrote:
> skb does not include enough information to find out receiving
> sockets/services and netns/containers on packet drops. In theory
> skb->dev tells about netns, but it can get cleared/reused, e.g. by TCP
> stack for OOO packet lookup. Similarly, skb->sk often identifies a local
> sender, and tells nothing about a receiver.
> 
> Allow passing an extra receiving socket to the tracepoint to improve
> the visibility on receiving drops.
> 
> Signed-off-by: Yan Zhai<yan@cloudflare.com>
> ---
> v3->v4: adjusted the TP_STRUCT field order to be consistent
> v2->v3: fixed drop_monitor function prototype
> ---
>   include/trace/events/skb.h | 11 +++++++----
>   net/core/dev.c             |  2 +-
>   net/core/drop_monitor.c    |  9 ++++++---
>   net/core/skbuff.c          |  2 +-
>   4 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> index 07e0715628ec..3e9ea1cca6f2 100644
> --- a/include/trace/events/skb.h
> +++ b/include/trace/events/skb.h
> @@ -24,13 +24,14 @@ DEFINE_DROP_REASON(FN, FN)
>   TRACE_EVENT(kfree_skb,
>   
>   	TP_PROTO(struct sk_buff *skb, void *location,
> -		 enum skb_drop_reason reason),
> +		 enum skb_drop_reason reason, struct sock *rx_sk),
>   
> -	TP_ARGS(skb, location, reason),
> +	TP_ARGS(skb, location, reason, rx_sk),
>   
>   	TP_STRUCT__entry(
>   		__field(void *,		skbaddr)
>   		__field(void *,		location)
> +		__field(void *,		rx_skaddr)

Is there any reason for appending the "addr" part to "rx_sk" ?
It makes it harder to read this is the sk (socket).

AFAICR the skbaddr naming is a legacy thing.

>   		__field(unsigned short,	protocol)
>   		__field(enum skb_drop_reason,	reason)
>   	),
> @@ -38,12 +39,14 @@ TRACE_EVENT(kfree_skb,
>   	TP_fast_assign(
>   		__entry->skbaddr = skb;
>   		__entry->location = location;
> +		__entry->rx_skaddr = rx_sk;
>   		__entry->protocol = ntohs(skb->protocol);
>   		__entry->reason = reason;
>   	),
>   
> -	TP_printk("skbaddr=%p protocol=%u location=%pS reason: %s",
> -		  __entry->skbaddr, __entry->protocol, __entry->location,
> +	TP_printk("skbaddr=%p rx_skaddr=%p protocol=%u location=%pS reason: %s",
                               ^^^^^^^^^
I find it hard to visually tell skbaddr and rx_skaddr apart.
And especially noticing the "skb" vs "sk" part of the string.


> +		  __entry->skbaddr, __entry->rx_skaddr, __entry->protocol,
> +		  __entry->location,
>   		  __print_symbolic(__entry->reason,
>   				   DEFINE_DROP_REASON(FN, FNe)))
>   );


--Jesper

