Return-Path: <netdev+bounces-295009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id poBAN9rZIGrl8QAAu9opvQ
	(envelope-from <netdev+bounces-295009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9CA63C466
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Rwvn2McC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295009-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295009-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA2683027707
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43083282F18;
	Thu,  4 Jun 2026 01:49:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFA6280035
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 01:49:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537797; cv=none; b=CbWeek+qnEJqYNqIVNPEZosAJoI9r/EMV5bl1vsIGYoJWsrd4s2Haqtkpw1Dsyowfv9pNSFafplweHEiRWzae0Egt4LK3iRMjjqGDKd9P7yB0s96BAxKnjxUBn8VK6WLc4oEuAIa0nDQfL4Jkqu28I8N6UR1/FrzcaxDGNYctOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537797; c=relaxed/simple;
	bh=OX4o3VwOCHAm8jFp1kQNUQIxFVl9dHNR7Zh2V2xqjOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4kxG4dUkvhnHlADXU26OZnq2acoR2xv441RugOV1CRRaowQzGaPucuv8485FinaLRYaQ0UrsgtgRVIwdIvVsZQt8xc8QKcDn8IsUkGccebvS1uwB24RFTyAeJXQ/lrf+txkevYX4kpqhyaNqWVVRSfkyGijX15PVaqvU9g5x5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rwvn2McC; arc=none smtp.client-ip=95.215.58.182
Message-ID: <b5d4d726-c32f-45e4-9ea7-28f7b6a1f8d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780537783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vqCvh2xw2aQFNQtW/09BhvWce5f0QABhvDIVT33PA8=;
	b=Rwvn2McCO4NKxMfzFd7tpQBFtHMeAedHt/yS9QQNkmviLphWwQf0FGrREacTiTRHwqeLn6
	uqCLAF3CY403FaSZShF2ysPWqIrVVqtIGUy1I2tSJWLL1vc5mgEeJdZ/RxQ/KBXWyqNq7n
	CufzrTzb5nYHYM6oWEbWMMHXS0qsT0M=
Date: Thu, 4 Jun 2026 09:49:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] udp: clear skb->dev before running a sockmap
 verdict
To: Sechang Lim <rhkrqnwk98@gmail.com>, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 jakub@cloudflare.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260603162737.697215-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260603162737.697215-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:aleksander.lobakin@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295009-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,cloudflare.com,intel.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F9CA63C466


On 6/4/26 12:27 AM, Sechang Lim wrote:
> On the UDP receive path skb->dev is repurposed as dev_scratch (the
> truesize/state cache set by udp_set_dev_scratch()), through the
> union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff.
>
> When a UDP socket is in a sockmap, sk_data_ready is
> sk_psock_verdict_data_ready(), which calls udp_read_skb() -> recv_actor()
> (sk_psock_verdict_recv) to run the attached SK_SKB verdict program in softirq.
> If that program calls a socket-lookup helper (bpf_sk_lookup_tcp/udp,
> bpf_skc_lookup_tcp), bpf_skc_lookup() does:
>
> 	if (skb->dev)
> 		caller_net = dev_net(skb->dev);
>
> skb->dev still holds the dev_scratch value (a non-NULL integer), so dev_net()
> dereferences it as a struct net_device * and the kernel takes a general
> protection fault on a non-canonical address in softirq:
>
>    Oops: general protection fault, probably for non-canonical address 0x1010000800004a0
>    CPU: 1 UID: 0 PID: 1406 Comm: syz.2.19 Not tainted 7.1.0-rc6 #1 PREEMPT(full)
>    RIP: 0010:bpf_skc_lookup net/core/filter.c:7033 [inline]
>    RIP: 0010:bpf_sk_lookup+0x45/0x160 net/core/filter.c:7047
>    Call Trace:
>     <IRQ>
>     bpf_prog_4675cb904b7071f8+0x12e/0x14e
>     bpf_prog_run_pin_on_cpu+0xc6/0x1f0
>     sk_psock_verdict_recv+0x1ba/0x350
>     udp_read_skb+0x31a/0x370
>     sk_psock_verdict_data_ready+0x2e3/0x600
>     __udp_enqueue_schedule_skb+0x4c8/0x650
>     udpv6_queue_rcv_one_skb+0x3ec/0x740
>     udp6_unicast_rcv_skb+0x11d/0x140
>     ip6_protocol_deliver_rcu+0x61e/0x950
>     ip6_input_finish+0xa9/0x150
>     NF_HOOK+0x286/0x2f0
>     ip6_input+0x117/0x220
>     NF_HOOK+0x286/0x2f0
>     __netif_receive_skb+0x85/0x200
>     process_backlog+0x374/0x9a0
>     __napi_poll+0x4f/0x1c0
>     net_rx_action+0x3b0/0x770
>     handle_softirqs+0x15a/0x460
>     do_softirq+0x57/0x80
>     </IRQ>
>
> The rmem charge that dev_scratch accounted for is released by skb_recv_udp() on
> dequeue, just above, so the scratch is dead by the time recv_actor() runs. Clear
> skb->dev so bpf_skc_lookup() falls back to sock_net(skb->sk), which
> skb_set_owner_sk_safe() set just above.
>
> Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


