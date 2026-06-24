Return-Path: <netdev+bounces-301776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /mnvGX1LPGowmQgAu9opvQ
	(envelope-from <netdev+bounces-301776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:26:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B875F6C176D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:26:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b=CzuhPbXU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301776-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301776-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rbox.co;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C8813048ADA
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD63E6386;
	Wed, 24 Jun 2026 21:26:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9083E6382;
	Wed, 24 Jun 2026 21:26:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336362; cv=none; b=jrEhcYIDQ3qssfLT4OQU+k24b+xQcqrhO1fiRqLrRcbLEz+UX08FHhjT6OR4lS5sdyqDw7635nzFqKk5OFhYavJV41uFJGMWGlIC88OYWiik1ehG1BM+DV5OsIuyk/zn2rK7oeKSedk/VzdVLR7PCOCg/sclMVwXkT2mHRHFx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336362; c=relaxed/simple;
	bh=o2xaITaiQ1bKKkChYwoOc/FiEIEzhF89yHsKKA2O8I8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aycJTw9kZaFCRZqp43b/9opwl2qVhgBN/UxBu8IlVCN2Hn6Z5aHsj5+xh0s2hWv1r4crZ5Fl7pwUwgPXPK/sWUe+/0NnLSHx0N0/Ch1WsMiaMsAnhzWmXoztUiTWTxYpdjM339SsBZlHzdEPTrPoQw3DbdzN1JUnl+vcmKHX0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=CzuhPbXU; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wcV6V-00720D-FY; Wed, 24 Jun 2026 23:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=RbYgWi/4B1pqMMSsoMVZcSd3jaEB0ax+94m9IQnAXRY=; b=CzuhPbXUftj55W/AJJJ57Gl6Ih
	Xh2301MkUUZ0J847mWjkX1iWZd7YMjSm9E/941sKdL8CszW4F/5iVe6097pONB0YF4i8k0Vj75tLJ
	e9bu8aLN6jSvTvjmBYRQ6hN4xEZGtWB5gRkDhersrgXFcja2uFjnjj1VCxoelHkXX1uJRTz1m909T
	sj1H5rQtusYe7JqWzCftAoVHCALVXLRgaWC4RqIOYDOO9S0Omc1A5gzcfILa7d7vVyvmXahFWhsGc
	fHtzWr+lo4WdkaS5llBYwKAY8OihR+phxUTJMN/utw9Zd7CpbcVT7eRQPgkNpBAhKnoiPzjiV3Rtv
	sBhU4Sog==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wcV6V-0000oZ-6i; Wed, 24 Jun 2026 23:25:51 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wcV6P-00399n-Rk;
	Wed, 24 Jun 2026 23:25:45 +0200
Message-ID: <dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
Date: Wed, 24 Jun 2026 23:25:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kuniyu@google.com
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
 <87wlvoxdq1.fsf@cloudflare.com>
 <willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301776-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kuniyu@google.com,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rbox.co:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,rbox.co:dkim,rbox.co:email,rbox.co:mid,rbox.co:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B875F6C176D

On 6/24/26 22:01, Willem de Bruijn wrote:
> Jakub Sitnicki wrote:
>> On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
>>> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
>>> sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.
>>>
>>> Because sockmap accepts unbound UDP sockets, a BPF program can increment a
>>> socket's refcount via lookup. If the socket is subsequently bound, the
>>> transition from unbound to bound causes bpf_sk_release() to skip the
>>> decrement of the refcount, causing a memory leak.
>>>
>>> unreferenced object 0xffff88810bc2eb40 (size 1984):
>>>   comm "test_progs", pid 2451, jiffies 4295320596
>>>   hex dump (first 32 bytes):
>>>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
>>>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>>>   backtrace (crc bdee079d):
>>>     kmem_cache_alloc_noprof+0x557/0x660
>>>     sk_prot_alloc+0x69/0x240
>>>     sk_alloc+0x30/0x460
>>>     inet_create+0x2ce/0xf80
>>>     __sock_create+0x25b/0x5c0
>>>     __sys_socket+0x119/0x1d0
>>>     __x64_sys_socket+0x72/0xd0
>>>     do_syscall_64+0xa1/0x5f0
>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> Maintain balanced refcounts across sk lookup/release: (re-)set
>>> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
>>> unbound) as not requiring a refcount increment on (a RCU protected) lookup.
>>>
>>> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> Note: this issue is related to commit 67312adc96b5 ("bpf: reject unhashed
>>> sockets in bpf_sk_assign").
>>> ---
>>>  net/ipv4/udp_bpf.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
>>> index ad57c4c9eaab..970327b59582 100644
>>> --- a/net/ipv4/udp_bpf.c
>>> +++ b/net/ipv4/udp_bpf.c
>>> @@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>>>  	if (sk->sk_family == AF_INET6)
>>>  		udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
>>>  
>>> +	/* Treat all sockets as non-refcounted, regardless of binding state. */
>>> +	sock_set_flag(sk, SOCK_RCU_FREE);
>>> +
>>>  	sock_replace_proto(sk, &udp_bpf_prots[family]);
>>>  	return 0;
>>>  }
>>
>> There is a side effect that an unhashed (unbound) UDP socket can now be
>> selected in sk_lookup with bpf_sk_assign.
> 
> The commit does mention a related fix, beneath the ---, commit
> 67312adc96b5 ("bpf: reject unhashed sockets in bpf_sk_assign").
> That fixes a similar issue by exactly disallowing this:
> 
>     Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
>     This matches the behaviour of __inet_lookup_skb which is ultimately
>     the goal of bpf_sk_assign().
> 
> So ..
> 
>> Though perhaps that's for the
>> better because TC bpf_sk_assign doesn't reject non-refcounted UDP
>> sockets either, so we would have both socket dispatch sites behave the
>> same way.
> 
> .. there are two conflicting types of consistency here? Consistent with
> __inet_lookup_skb or the TC bpf hook. Of those the first is the more
> canonical.
> 
>> Also, with this patch, if we insert & remove an unhashed UDP socket
>> into/from a sockmap, we end up with an unhashed non-refcounted UDP
>> socket. Not entirely sure if that is actually a problem or not.
>>
>> Willem, what is your take on having unhashed non-refcoted UDP sockets?
> 
> I don't immediately see a problem, but I'm not an expert on SOCK_RCU_FREE.

Perhaps it's worth mentioning that unhashed non-refcounted UDP socket is
already possible: first auto-bind via connect(AF_INET) (which also sets
SOCK_RCU_FREE), then unhash via connect(AF_UNSPEC).

