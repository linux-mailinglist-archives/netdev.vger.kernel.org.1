Return-Path: <netdev+bounces-256840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNcaG93Hg2k/uQMAu9opvQ
	(envelope-from <netdev+bounces-256840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:27:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C630BECFCB
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CB6A300F9EC
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD65B36997D;
	Wed,  4 Feb 2026 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cNkCVy31"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBA35F8AE
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244058; cv=none; b=g4dYcIKVZ1e6Ww3o1FfkRa7/108KXuqaHh+OdzPPObjbE7GLc/ooWFvsmJYnwsjWGnK//9FLimTqLNLYh7gj6prdu25CCBquZy2tmvsumqSpLOHyyhxCono9HUx40m1M+umRgf8tfeykzhmLNcfwOrDihwygDjfHwU6yan+vfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244058; c=relaxed/simple;
	bh=wZZ/SeQyb+jbaasVwUURB5k+BXkw3yx4fwjfmMYXfzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyJbM3qsbcrZI+offG1ZQUB2KVRY8BphoMJYdnVtkugccytNrIIzBXoySES8/7gcckgsTkwl21zY43obl19wQDS3+C0wZVXCjsNorjHXcbjSlk2KwgdaPYSkY1tLiWpVHwzBVrm96FkpzaCVleEtX/MrxJVmgI34eDEUwMy+bjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cNkCVy31; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <917eadc0-9341-48d5-a795-8a7d5318886c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770244046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpHQHK9ByhXjOMLtKt5IA11owJ/tFaX0XM7vmCRxYqk=;
	b=cNkCVy31xTsJNCh2BvARgaCcHZ+Vj23CgpcBd321pKayWHu/qZAQDj5lVGQ8o9yhzQgIxN
	mOO4I4MZ5LylIA/8wcRV/i+NAq4WlqzBSnoHP2Cmej5wwwEXNu8xamtbc33Ptcugi0SIxq
	xbRKyBO9BfISXwf7FLEums4kmzAC+lE=
Date: Wed, 4 Feb 2026 14:27:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_tcp_sock() helper in XDP
To: afabre@cloudflare.com
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, wferguson@cloudflare.com, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev, bot+bpf-ci@kernel.org
References: <20260204-afabre-bpf_tcp_sock-v1-1-a22b40c630c0@cloudflare.com>
 <167a8f4235973cd42372884aa66182a10fd17e50c70626b1fa0e659933e82b4e@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <167a8f4235973cd42372884aa66182a10fd17e50c70626b1fa0e659933e82b4e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,google.com,davemloft.net,redhat.com,vger.kernel.org,cloudflare.com,meta.com];
	TAGGED_FROM(0.00)[bounces-256840-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C630BECFCB
X-Rspamd-Action: no action



On 2/4/26 5:04 AM, bot+bpf-ci@kernel.org wrote:
>>      But the TCP TIME-WAIT state needs special handling for this: packets
>>      received for a TIME-WAIT socket can either belong to the current
>>      incarnation of the connection, or a new incarnation. The only way to
>>      determine this is to compare the sequence numbers.
>>
>>      Add the bpf_tcp_sock() helper in XDP to allow the socket sequence
>>      numbers to be read.
> 
> Can this approach work for TIME-WAIT sockets? Looking at bpf_tcp_sock() in
> net/core/filter.c:
> 
>      if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
>          return (unsigned long)sk;
>      return (unsigned long)NULL;
> 
> And sk_fullsock() in include/net/sock.h:
> 
>      static inline bool sk_fullsock(const struct sock *sk)
>      {
>          return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
>      }
> 
> TIME-WAIT sockets are explicitly excluded by sk_fullsock(), so bpf_tcp_sock()
> returns NULL for them. The sequence numbers stored in TIME-WAIT sockets
> (skc_tw_rcv_nxt and skc_tw_snd_nxt in sock_common) would not be accessible
> through this helper.
> 
> The change itself is useful for accessing tcp_sock fields from established
> connections in XDP, but the commit message implies this solves the TIME-WAIT
> sequence number problem described, which doesn't appear to be the case.

or use "tp = bpf_core_cast(sk, struct tcp_sock /* or tcp_timewait_sock 
*/);". The bpf prog can also read all members of the kernel struct 
instead of a subset defined in bpf_tcp_sock.

pw-bot: cr

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21671977729
> 
> AI-authorship-score: low
> AI-authorship-explanation: The commit message style is consistent with human-written kernel patches, with natural technical language and standard formatting; the technical error is more likely human oversight than AI hallucination.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: The issue is a misleading commit message that claims the change enables TIME-WAIT socket sequence number reading, but the bpf_tcp_sock() helper explicitly returns NULL for TIME-WAIT sockets.


