Return-Path: <netdev+bounces-303462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sBU0B7mfRGpuyAoAu9opvQ
	(envelope-from <netdev+bounces-303462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:03:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A98C76E9C45
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:03:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=K9pGLR0V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303462-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303462-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE73E3020E89
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 05:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3C2E9729;
	Wed,  1 Jul 2026 05:03:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44C3597B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 05:03:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882229; cv=none; b=OFDqdrm+lKIJXkX3vJsWtknPFVvAvLCUZzcAkkXeGPT6RC5KB8oMK7JP7nSEkM0hSnGPaEsWZr6AsbIVHcII73OczqxW8mo4YAW8qfDR2dugKKmjvaikYXpCzHNtUxvXPtfHfoDb14DMVf3OVxko55qrcqmTtTG4FCRs0LYtq9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882229; c=relaxed/simple;
	bh=oxbMbODushhC7pgEE9L6PR2gFzNlyiACUXcfsuicEIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCZj8PPFFGLS97CcAxBbdvuK+q7wNpA0wtql3VC28aIQANEyg7TXT6fbe+1mqTdavuFJJgcSUkb3plPpvvziXrkpYNHLNYKSCkQg5qfn/usBxzcB/vOdpM985UpUyqkYb6UWcbU4CcMoW5zF78zR4xIlcMztSlmTpEDb0H1Ah4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K9pGLR0V; arc=none smtp.client-ip=95.215.58.172
Message-ID: <b24d5fa0-81c0-4690-b9a7-f29b79740272@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782882216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icl4iM8H8kjQY8I0E4w6SCKCBCCsjMFSCKrymXKcac8=;
	b=K9pGLR0VqRXVIaZtsgJfO00PbLThrU3L1kVvL3dD2Pw4mqEHie36a5V+LK7kwZNv4P5DKt
	m7pYZ0FFkhDQP8frdwKpKMBA9lPUrAvgaOmQ37kJ5Er/XLliB/A3B4wcqfSoxxuSmFcFMi
	0gcVmdXm6rxJAdanEqceqRiZ9NBpYow=
Date: Wed, 1 Jul 2026 13:03:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 0/3] bpf, sockmap: reject a packet-modifying
 SK_SKB stream parser
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman
 <bobby.eshleman@bytedance.com>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
 <e3a91acd-2b4d-4e93-a3bb-a0e9ee5ede0f@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <e3a91acd-2b4d-4e93-a3bb-a0e9ee5ede0f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ihor.solodrai@linux.dev,m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:eddyz87@gmail.com,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:memxor@gmail.com,m:horms@kernel.org,m:shuah@kernel.org,m:bobby.eshleman@bytedance.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303462-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,kernel.org,iogearbox.net,cloudflare.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,redhat.com,davemloft.net,kernel.org,linux.dev,gmail.com,bytedance.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A98C76E9C45


On 7/1/26 12:48 PM, Ihor Solodrai wrote:
> On 2026-06-19 7:44 p.m., Sechang Lim wrote:
>> A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
>> which can chain skbs through frag_list. A parser that resizes the skb
>> frees the frag_list segments that strparser still tracks through
>> skb_nextp, leading to a use-after-free.
>>
>> A stream parser is only meant to measure the next message, not to modify
>> the packet, so reject a packet-modifying parser at attach time.
>>
>> v5:
>>   - target bpf-next instead of bpf
>>   - add Reviewed-by tag (Jiayuan Chen)
>>
>> v4:
>>   - 
>> https://lore.kernel.org/all/20260619062959.3277612-1-rhkrqnwk98@gmail.com/
>>
>> v3:
>>   - 
>> https://lore.kernel.org/all/20260618102718.2331468-1-rhkrqnwk98@gmail.com/
>>
>> v2:
>>   - 
>> https://lore.kernel.org/all/20260612123553.2724240-1-rhkrqnwk98@gmail.com/
>>
>> v1:
>>   - 
>> https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/
>>
>> Sechang Lim (3):
>>    selftests/bpf: don't modify the skb in the strparser parser prog
>>    bpf, sockmap: reject a packet-modifying SK_SKB stream parser
>>    selftests/bpf: test rejection of a packet-modifying SK_SKB stream
>>      parser
>
>
> Hi Sechang, all,
>
> This series broke test_maps (test_sockmap subtest) on the bpf
> tree. Currently on BPF CI the test fails on bpf, but passes on
> bpf-next (it doesn't have the series yet).
>
> test_maps fails with:
>
>     + taskset 0xF ./test_maps
>     [    8.352378] clocksource: Watchdog remote CPU 2 read timed out
>     Failed sockmap unexpected timeout
>
> See test_maps.c:995 in test_sockmap(): the 30s select() times out and
> test_maps exits 1. Note there is no "Failed stream parser bpf prog
> attach" message, the parser attaches fine.
>
> The series was merged into bpf on 2026-06-26 00:42 UTC
>
> CI runs:
>   last good (pre-merge, 06-25): 
> https://github.com/kernel-patches/bpf/actions/runs/28158326456
>   first bad (post-merge, 06-26): 
> https://github.com/kernel-patches/bpf/actions/runs/28210181858
>   recent bad (06-30): 
> https://github.com/kernel-patches/bpf/actions/runs/28475936023
>
> Confirmed locally reverting the 3 commits and rebuilding makes
> test_sockmap pass again.
>
> Could you please help investigate?

I'll work on this.



