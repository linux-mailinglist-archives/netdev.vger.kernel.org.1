Return-Path: <netdev+bounces-295799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mM5UOyK6ImpCcwEAu9opvQ
	(envelope-from <netdev+bounces-295799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:59:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AAA647E6B
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:59:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Zl2REIDg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295799-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295799-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9A133003BC5
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF384D90D7;
	Fri,  5 Jun 2026 11:59:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05219D07A;
	Fri,  5 Jun 2026 11:59:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660765; cv=none; b=QKLwNoKkAlwv5dKM+IGF37SBr0ielQZA8+Y++rMDpsKWwGeX1FtHtyxFZj2dkO+/2I1x6WoXv7WCcpgh8Bxy0CL8IYGUrRMGbmi5uhyBUucrEDII8lCreJmhF6P34hDadVZHEBO3vtQ2Y0ofUD4X67b+itvO/SWLQORbcuNIlV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660765; c=relaxed/simple;
	bh=DM/bL3+ANjMSxQ6LXVlL3mcKvklgRPJSGe5tGajzUbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjo2v3QD29CD0WM3q0GTr99aKHjGO8akKo4wK2HHMJ/PtDwdEr7tD0BrR0lZbEgyBDqt4zE7TK+M6LTYmtEL/yU9l/wc0dY4fqQ5AV3Q/wHnNP6XKEZAb526zrZz6ILOvuElu+cLxj35IHjHruloyiShrOxmHo+lFbBHFK8ReGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl2REIDg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221391F00893;
	Fri,  5 Jun 2026 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780660764;
	bh=wiOY95bbms3ph6ntuxqrCRd7im8fwXbJxnhcBs8rZm0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zl2REIDgG5ZqGgghwyl7YWWUvU1WXXbSFjB0mqOW1AxnfPowAFppenxyPu5QZ8WQC
	 YLvFTcIaZ69LfBP38RP3NJsmOFKSwlJRwfO0axy8wEOcHPdtC1r1y/bZxAzR5wOD9n
	 FHwz+UDCB22ler3P5uVPVZ4UYD6QJ2XKQh6RazBWNDqsaKryrgSPXnB8qD5AYUksJQ
	 PCkklFXpZIQd6RpTwocpvtgO7gpYJQPf26guJ/eqc6/kj0zyHONXlKOsG6GwOEwqKk
	 A8IcgxbQKDfxJ8lL3KuYJAgI3mnbNT84sX6g6AW4CGpdvZD6lSvgiG6rHX7aVED1bd
	 9b9YM7gR1ifVQ==
Message-ID: <63ecf4a2-13a2-42d2-8990-e53e50ae9a65@kernel.org>
Date: Fri, 5 Jun 2026 13:59:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/slab: add a node-track-caller variant for kmem
 buckets allocation
Content-Language: en-US
To: Pedro Falcato <pfalcato@suse.de>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-2-pfalcato@suse.de>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260602183122.747759-2-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295799-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:harry@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,gentwo.org,google.com,kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0AAA647E6B

On 6/2/26 20:31, Pedro Falcato wrote:
> This is required by users that want to use kmem buckets, but still
> desire specifying the NUMA node.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

As the main change is in net code, probably should go in the net tree?

> ---
>  include/linux/slab.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 7b46fa499b08..685a87d8f0c5 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -1153,8 +1153,11 @@ void *kmalloc_nolock(size_t size, gfp_t gfp_flags, int node);
>  #define kmem_buckets_alloc(_b, _size, _flags)	\
>  	alloc_hooks(__kmalloc_node_noprof(PASS_KMALLOC_PARAMS(_size, _b, __kmalloc_token(_size)), _flags, NUMA_NO_NODE))
>  
> -#define kmem_buckets_alloc_track_caller(_b, _size, _flags)	\
> -	alloc_hooks(__kmalloc_node_track_caller_noprof(PASS_KMALLOC_PARAMS(_size, _b, __kmalloc_token(_size)), _flags, NUMA_NO_NODE, _RET_IP_))
> +#define kmem_buckets_alloc_node_track_caller(_b, _size, _flags, _node)	\
> +	alloc_hooks(__kmalloc_node_track_caller_noprof(PASS_KMALLOC_PARAMS(_size, _b, __kmalloc_token(_size)), _flags, _node, _RET_IP_))
> +
> +#define kmem_buckets_alloc_track_caller(_b, _size, _flags) \
> +	kmem_buckets_alloc_node_track_caller(_b, _size, _flags, NUMA_NO_NODE)
>  
>  static __always_inline __alloc_size(1) void *_kmalloc_node_noprof(size_t size, gfp_t flags, int node, kmalloc_token_t token)
>  {


