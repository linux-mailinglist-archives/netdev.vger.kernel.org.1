Return-Path: <netdev+bounces-217078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC8B374B8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33157C5DB6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 22:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674C15B54A;
	Tue, 26 Aug 2025 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PcAj6z4j"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578D30CD82
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245765; cv=none; b=MFIZA5GlO6ppvexB5zwjE6DdJglrVetuDmcUQ94xq6+ukNBe0ET1KT3yLcYXapQF+rIEqDsR2Gid23d8dyRPIefisiSTdhTy4Nv9I3eP1zVkJVufDIuPox00NkYfXjbELyHk0pjYu9WbTVBzTg3BYAdkiYdzgqsxCWDFEn3kL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245765; c=relaxed/simple;
	bh=+KwDV7b6EsPfkJZTkDc5E4T4AwdADzlM+v8wz5XgT/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKhlpeAbVyMgkrmSBQVqbFRoOY3PCZZ9X3TZgmrvHukdg7+jce4jtkgwPGa42QCeDuA7dqgQr3t6qsKwf92N3vJdJPirCyGiuWDuJ1iEzekSaDBKUa7kAA46bIQ2H9DCzNbAOTDmpY09fxzeXnXDrnS2sgf/hQMmmYZXoYCiPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PcAj6z4j; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <93ddc9c9-e087-4a8d-a76c-8a081cf3f1ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756245751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyR7Fx9k/OFHMVed0VLWfOvbDgr4pC+RHedjDcgSdcA=;
	b=PcAj6z4j2IXTgrEpPiGnR5e/7R9OCLu5zm+b69oA7X476sUgzY0NtaFuRuKvTxPwXT46qb
	CPZgvrIY0ySCFOtsHwq6k3fZXB4AO/azqjG6wAbDtEuSO4v5rUrTbrN3iCODxgE6OEFJ19
	XMJdI44rwuUIf8RrRHR53eU9OPefSLQ=
Date: Tue, 26 Aug 2025 15:02:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in
 __inet_accept().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: almasrymina@google.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, hannes@cmpxchg.org, john.fastabend@gmail.com,
 kuba@kernel.org, kuni1840@gmail.com, mhocko@kernel.org,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
 roman.gushchin@linux.dev, sdf@fomichev.me, shakeel.butt@linux.dev,
 willemb@google.com
References: <a8ebb0c6-5f67-411a-8513-a82c083abd8c@linux.dev>
 <20250826002410.2608702-1-kuniyu@google.com>
 <2bac5d14-6927-4915-b1a8-e6301603e663@linux.dev>
 <CAAVpQUC-5r+nbB=Uhio0WOEDV7dMcuUM-tF=auAV_rvAWH5s0g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUC-5r+nbB=Uhio0WOEDV7dMcuUM-tF=auAV_rvAWH5s0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/26/25 2:08 PM, Kuniyuki Iwashima wrote:
>> ... need a way to disallow this SK_BPF_MEMCG_SOCK_ISOLATED bit being changed
>> once the socket fd is visible to the user. The current approach is to use the
>> observation in the owned_by_user and sk->sk_socket in the create and accept
>> hook. [ unrelated, I am not sure about the owned_by_user check considering
>> sol_socket_sockopt can be called from bh ].
> 
> [ my expectation was bh checks sock_owned_by_user() before
>    processing packets and entering where bpf_setsockopt() can
>    be called ]

hmm... so if a bpf prog is run in bh, owned_by_user should be false and the bh 
bpf prog can continue to do the bpf_setsockopt(SK_BPF_MEMCG_FLAGS). I was 
looking at this comment in v1 and v2, "Don't allow once sk has been published to 
userspace.". Regardless, it seems that v3 allows other bpf hooks to do the 
bpf_setsockopt(SK_BPF_MEMCG_FLAGS)?, so not sure if this point is still relevant.

> 
>>
>> If it is needed, there are other ways to stop the SK_BPF_MEMCG_SOCK_ISOLATED
>> being changed again once the fd is visible to user. e.g. there are still bits
>> left in the sk_memcg pointer to freeze it at runtime. If doing it statically
>> (i.e. at prog load time), it can probably return a different setsockopt_proto
>> that can understand the SK_BPF_MEMCG_FLAGS.
> 
> I was thinking a kind of the latter, passing caller info to general
> __bpf_setsockopt(), and gave up as it was ugly, but wrapping it
> as different setsockopt_proto sounds good.
> 
> Then, we don't need to care about how to limit the caller context.
passing caller info is doable in helper but it is not pretty for helper and 
needs verifier changes (kfunc would be easier), so I wouldn't go there also. fyi 
only, take a look at bpf_timer_set_callback. However, all five args in 
bpf_setsockopt is used, so the same way won't work.

Right, wrapping it into a different setsockopt_proto is an option but admittedly 
not pretty also but should work. Lets not go there first. It seems the v3 design 
has changed a bit. Lets discuss and explore there.

