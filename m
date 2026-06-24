Return-Path: <netdev+bounces-301775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EwuAixLPGoamQgAu9opvQ
	(envelope-from <netdev+bounces-301775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:25:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8A6C1748
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:24:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b="LgP5Xp/i";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301775-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301775-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rbox.co;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 281D9300EAA1
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263953E5EF5;
	Wed, 24 Jun 2026 21:24:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060A3E5EEB;
	Wed, 24 Jun 2026 21:24:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336285; cv=none; b=EKfI74Lxgb4ZtwLr2hDZ1JMyXsONvCNN40dLDfIU/D7NCR9cFsmvSfOioe8WfztxFH/b/lqQcT3iXxKqIKRewJ3MXdds/Wp2zaNn+jJWhmfN4pApWjHFwHM0rRmllZ+pZk+vbQGat8mqFNioacj+6+X0q7tQ6PimA3StQ4SfO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336285; c=relaxed/simple;
	bh=kHZtBaqOvCugjTHQj0B1OaA+osE8CuIzs3E7zkbVM5g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fD9OAurqTK8q4Pihd59c5fGDlu/2J4L6Mtgft2urdguPHRozNMl9IiygyVOikoKMxEjpscZcwlT6xGGoK0kM0yqj1hGIVaGOSSrixJwyX2U6WOs+MsBFA7UtJkShj1nGZg1+OReM3wxkvFvght+L4CBLQT2MLsmjYKWUVqUSn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LgP5Xp/i; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wcV5E-0071jo-45; Wed, 24 Jun 2026 23:24:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=lyDPYtl2CSdhmwVeND7ks61hyybAjQmYm0gRw1OUEcc=; b=LgP5Xp/iVGQmTWyYUs3GITJh3B
	JH4Rvf6dCYVFWaOsiMWtRhSQtdiAEV5UFe69bpsnD5twwaZnRQwoaSjV8ehK3ctxefHh7xunAnnZu
	qXW628YRi1v5MhbtBMcmFKmOG5mqreXvROThz6/EhBiTfzIYDJzPj70BZ4Rb2IILBKU7Se2zyy76H
	BO8rIhrFaJq8BQm7FODMmbVPXjO1hOtlypPPALGHBj2u5eIuSGBnI7z6yZZHUEFLWMAg8Rjg7CjBO
	3PR3RaJqPDtkyhcFaqXSMN9MAYNHPPhKOV6TJBawOZrKRcvtz/L5eZBxPGLkeGT60V26Sl4DLdsIt
	/EGsMQWQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wcV5D-00062X-6L; Wed, 24 Jun 2026 23:24:31 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wcV52-0038uQ-MK;
	Wed, 24 Jun 2026 23:24:20 +0200
Message-ID: <e34d8743-58c3-4f50-8c0b-5e779cc53bdd@rbox.co>
Date: Wed, 24 Jun 2026 23:24:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for UDP sock leak on
 sockmap lookup-bind-release
To: bot+bpf-ci@kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 cong.wang@bytedance.com, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
 <bd4abd3f584c38f1fc512a9d3ae1f90c2a374588fa23529b32b7f1aed6ab2ead@mail.kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <bd4abd3f584c38f1fc512a9d3ae1f90c2a374588fa23529b32b7f1aed6ab2ead@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301775-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,cloudflare.com,linux.dev,davemloft.net,google.com,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:dkim,rbox.co:email,rbox.co:mid,rbox.co:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55A8A6C1748

On 6/23/26 21:32, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release
>>
>>     Setup and join a cgroup, then attach a cgroup/connect4 program that runs
>>
>>        sk = bpf_map_lookup_elem(sockmap, 0)
>>        bpf_bind(ctx, sa, sizeof(sa))
>>        bpf_sk_release(sk)
>>
>>     Unpatched kernel leaks the socket.
>>
>>     Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> This test reproduces a UDP socket leak across sockmap lookup-bind-release,
> but there is no Fixes: tag.
> 
> The sibling fix commit a2510dc351c5 ("bpf, sockmap: Don't leak UDP socks on
> lookup-bind-release") carries a Fixes: tag pointing at the commit that lifted
> the socket-state restriction allowing unbound UDP sockets into sockmap.
> 
> Should this test carry the same tag so it stays backportable alongside the
> fix?
> 
>   Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")

I am skipping this suggestion as the test itself does not address any bugs
and requires no backporting.

Michal

