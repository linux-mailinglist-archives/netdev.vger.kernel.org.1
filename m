Return-Path: <netdev+bounces-303888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CGjrGOibRWrFCwsAu9opvQ
	(envelope-from <netdev+bounces-303888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:59:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5326F2362
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:59:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SYgHKdg0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303888-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303888-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B962302F71A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B73EC2E1;
	Wed,  1 Jul 2026 22:59:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5073BBFD1
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:59:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946780; cv=none; b=F8ZrpGf7vqeUqY8alNLwr+V8eIWnsBQO9UR7hPU01GLOE5TM+Ox8TVjmyncsgK/TT0v8j4kQSAMwE3NzqGH2izVp1dflFxqfUKVvtir574jqU+cFtGRiRCyTLOQmFlfDbIERzm3ba+inh7TGX2NEfZXKkts6wt2kQOBAIXfFLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946780; c=relaxed/simple;
	bh=b7hCX9/rBhLq6D0U13TWkBKOZW1C8WElJk7v2c6wHGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTj1T7EsFicGeclTYzuBTFU47QPg5+ym1+VEqeDv0h5rM5dxiZck2ZR7O00shM1JpbSYbzEh9OkkDDqtWP2BD6xBHokwSv7p4tPBpvXv5b8oZD+Ip3jqOvX7jHEBGeRtc8/lK5eJk1Byk77G0vmGcX+8CAx4zLRc8ZFfPVLkcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYgHKdg0; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso347455a12.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946778; x=1783551578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=giEqW7q9VcfExLik9phOW3EsB4XFWvu/oaZfoJVW5+M=;
        b=SYgHKdg0agRvsDKUClXirSvqPSa/5BPj4Jj6Eks6GD/km9VzI+nGMDdddeYngntAdL
         EMIeQUSlXJjct7AwQlCMlWBGeOHuD09kFn09YOAYlcMysFbjhLTMBO+wXluTBU7rbF8Q
         /LIolGkD5Ygl3CmBCj12elvVQ6rMnJd8JJ/NHzwaNWRL72+kGzaTDypC56EhQ3N4CeiP
         Tf52tt3FgfoalUPrE5sYNQGg7l8vYoRkyWgjs2W32v09W47nhWRCsQ9u7rJ56wtU9rSt
         JgWnDvgTAxhsgucvdLaPvzxYZmkgZebIIedqQDN5Af8w+pkpVlU4BhsFghcq6a2gjLp9
         /4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946778; x=1783551578;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=giEqW7q9VcfExLik9phOW3EsB4XFWvu/oaZfoJVW5+M=;
        b=kMeycjAoncuxt+bmICGeYfAuF8CP7C2eqwYvarsEdMxcPzGPZOqfs+tBnWmPMhHx31
         8lEicbar4moiJ5rcRKGuIykyHL5DOO+zCd9czGNg9QHoxLfW9yByy+7gpwhQg2yQy4cR
         IUlOcuFQXy5xk/YtyahsXtKwem36uOjlWJHMAGnPyLmhT1C1J2vodmQBH9TN6k7byonT
         deQbJBpB0NyJ9Vee+HSrSPzvSadbvMwhTHg/EoZkB0JaajpWOZgb3oaBRCyURIQKGSUy
         2Iy/6eEzOG+nEgNl13F0r8sx7gILeNwdmGK9kZ4Gv5QRXCubXJPE2kqLu5qpVNqXMADo
         wDMA==
X-Forwarded-Encrypted: i=1; AFNElJ8rkaScRJSnUzTCe7BxznBj88JWVSZ11vFAnUM6xSeOnYtzMW1gKJqz5VN0pHaiCm2mEUFNdzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnnh4JGKL4FA0qqhvot+WG+8o65S/VLz89VKWFZrZBmhk7L+nQ
	etvleiq31hUBh3uW5zo0QBUFpGR5uTZLexX4x4bGBRM1AR+s1FZUmMM3
X-Gm-Gg: AfdE7cngSKKTy3TYFuWq8HblE8KcmnuYpjFYU8nSIcul7jAE9ZNcw/zrvw6lWHN8Wd4
	XGfwv55xQbgSp8KVTQdvJEUV6l25rqedUhvgJIyBxguEYw/75LJqGL7wVwbtwxba2vcpaRO7rVP
	+ftKGU0101hc/Jce1rk/4eN6n6qpnl5Gbaq7eg4ZJrYnJcEQCFFYRfQLr3gdFjf4baeXwv2pkr6
	mNl2VKR/EB/4X30j4Hroqh0dCfdmuqsbcUa5Xo3DuMjuPonxRdzLZUrCr8tiU6Nw25Dc/+4n6Xa
	y75xUelZnAxP8ZdcVB02oARvR1eVBW/WWcMe0kQvuMFfLjnglfYgA6Jd8E4rKYPUO4NwRN/KEQQ
	hNaSnQl2fLJ3DMC01tOLFQE7yoyPkwH0e8hzKBRChQj1hlsaWklfZ1VxXMRBfBTeOFGK/QbTv1x
	kd5snDa+onIQ==
X-Received: by 2002:a05:6a20:4310:b0:3bf:c12c:2ecf with SMTP id adf61e73a8af0-3bff430fae9mr2922510637.59.1782946777855;
        Wed, 01 Jul 2026 15:59:37 -0700 (PDT)
Received: from john-p8 ([98.97.43.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0ef50sm442748a12.6.2026.07.01.15.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:59:37 -0700 (PDT)
Date: Wed, 1 Jul 2026 15:59:35 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Michal Luczaj <mhal@rbox.co>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
Message-ID: <akWbxAwIhjJdPtjA@john-p8>
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
 <87pl1937c7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87pl1937c7.fsf@cloudflare.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303888-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:mhal@rbox.co,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[rbox.co,google.com,redhat.com,linux.dev,davemloft.net,kernel.org,bytedance.com,iogearbox.net,gmail.com,etsalapatis.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email,john-p8:mid,cloudflare.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE5326F2362

On Mon, Jun 29, 2026 at 01:38:00PM +0200, Jakub Sitnicki wrote:
>On Fri, Jun 26, 2026 at 10:36 PM +02, Michal Luczaj wrote:
>> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
>> sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.
>>
>> Because sockmap accepts unbound UDP sockets, a BPF program can increment a
>> socket's refcount via lookup. If the socket is subsequently bound, the
>> transition from unbound to bound causes bpf_sk_release() to skip the
>> decrement of the refcount, causing a memory leak.
>>
>> unreferenced object 0xffff88810bc2eb40 (size 1984):
>>   comm "test_progs", pid 2451, jiffies 4295320596
>>   hex dump (first 32 bytes):
>>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
>>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>>   backtrace (crc bdee079d):
>>     kmem_cache_alloc_noprof+0x557/0x660
>>     sk_prot_alloc+0x69/0x240
>>     sk_alloc+0x30/0x460
>>     inet_create+0x2ce/0xf80
>>     __sock_create+0x25b/0x5c0
>>     __sys_socket+0x119/0x1d0
>>     __x64_sys_socket+0x72/0xd0
>>     do_syscall_64+0xa1/0x5f0
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Instead of special-casing for refcounted sockets, reject unhashed UDP
>> sockets during sockmap updates, as there is no benefit to supporting those.
>> This effectively reverts the commit under Fixes, with two exceptions:
>>
>> 1. sock_map_sk_state_allowed() maintains a fall-through `return true`.
>> 2. In the spirit of commit b8b8315e39ff ("bpf, sockmap: Remove unhash
>>    handler for BPF sockmap usage"), the proto::unhash BPF handler is not
>>    reintroduced.
>>
>> Historical note: this issue is related to commit 67312adc96b5 ("bpf: reject
>> unhashed sockets in bpf_sk_assign").
>>
>> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>
>Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

For me as well.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

