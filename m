Return-Path: <netdev+bounces-273768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHBPElROzGlSSQYAu9opvQ
	(envelope-from <netdev+bounces-273768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:44:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E162372794
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EC7A301E712
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75890466B49;
	Tue, 31 Mar 2026 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="TVqz7eiE"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACBE4611C6;
	Tue, 31 Mar 2026 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997068; cv=none; b=JDWeD/lLypfQfYKB0zYvWh476siPv3733lMFdHdlBeG0R/TbJ4cuGHzM3Lb/NyGgQHCFsIoNoUO0Hc36n1bsWISdGIwEniv0SQg0wCbOJBSJppZ5TargWbjd7EaLhzypFUkrQ8G7cit2fm9HFtQQ5EfvE/FYbGcsY0psDMqRp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997068; c=relaxed/simple;
	bh=St4cHU3bWuFU+5Jlkj/utNPywjdOMP+RdZhMfsrLM1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4yYC6AwTBXBvN5AhDo6OjELkyvfdDECbStsTJDHdbslcPRyRQLNXlRsX3lzN7m1JDYl4tFS4LPY0WyVLr4+4QWUN4kiLGg5+x+cFqNBeBK/DsoDCMX3T+9Gq5nHYdXFUqqXkkjriLrv2MVgvbPSwi8oi13i6h3pxpBJyl2ncrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=TVqz7eiE; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1w7hoV-005wSh-7w; Wed, 01 Apr 2026 00:43:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=S1+U+BnbfMCceEAbBDU0ejWzpWEUlFAjYsO7Uz8lf/o=; b=TVqz7eiErR7KPljQp11mVvNhBO
	JJBqMqeWLPo3NIRFQfwupc0SqrE4JCe45+fhBuD6VU0dTK9G9qx4S+sQoZB1MUwoP5RI6le2DmlIo
	G97Smo7II5lt7BizyWUpHBEesospl5+uxugDZYAIaAtM08jkj/Pivi0l6CRAWfwsCl5NYSaUJqldW
	7l31PxhMazoNIylVysOcsPe5zcIDJH1evixQ9p9jixs8zPclfU5IBB+c46F/PCD8+nAkGEo4fp6X3
	TC2iGxY8RrHyBjCaoylcWGClMfAdTkoPXOPNCV32ywyRflF8JIH+VLODHUSYCxAcCX8VOaPj3udU0
	EZ3h68MQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1w7hoP-0000ns-1y; Wed, 01 Apr 2026 00:43:53 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1w7hoM-00AH1Q-FZ; Wed, 01 Apr 2026 00:43:50 +0200
Message-ID: <48bad987-a130-4fb0-b4de-e39deac80ab9@rbox.co>
Date: Wed, 1 Apr 2026 00:43:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Jiayuan Chen <mrpre@163.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
 <2192e9ef-894f-4826-b296-4f90e973a31b@163.com>
 <b9a956dd-ebb2-47ca-8b49-ccbba6ff9b26@rbox.co>
 <b21fac4e-891b-481c-9734-e95290e49097@linux.dev>
 <fa818820-c0c9-48dc-8ebc-661cb3349935@rbox.co>
 <dd043c69-4d03-46fe-8325-8f97101435cf@linux.dev>
 <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
 <CAAVpQUAtF29CPDAdEUchYOP=oy8D2-B3GH3fWs2pwTmnYoTu=w@mail.gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <CAAVpQUAtF29CPDAdEUchYOP=oy8D2-B3GH3fWs2pwTmnYoTu=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,163.com,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,fomichev.me,bytedance.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273768-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:dkim,rbox.co:email,rbox.co:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E162372794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 01:27, Kuniyuki Iwashima wrote:
> On Mon, Mar 30, 2026 at 4:04 PM Michal Luczaj <mhal@rbox.co> wrote:
>> On 3/26/26 07:26, Martin KaFai Lau wrote:
>>> On 3/15/26 4:58 PM, Michal Luczaj wrote:
>>>>> Beside, from looking at the may_update_sockmap(), I don't know if it is
>>>>> even doable (or useful) to bpf_map_update_elem(unix_sk) in
>>>>> tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when looking
>>>>> at unix_dgram_sendmsg() => sk_filter(). It was not the original use case
>>>>> when the bpf_map_update_elem(sockmap) support was added iirc.
>>>>
>>>> What about a situation when unix_sk is stored in a sockmap, then tc prog
>>>> looks it up and invokes bpf_map_update_elem(unix_sk)? I'm not sure it's
>>>> useful, but seems doable.
>>>
>>> [ Sorry for the late reply ]
>>>
>>> It is a bummer that the bpf_map_update_elem(unix_sk) path is possible
>>> from tc :(
>>>
>>> Then unix_state_lock() in its current form cannot be safely acquired in
>>> sock_map_update_elem(). It is currently a spin_lock() instead of
>>> spin_lock_bh().
>>
>> Is there a specific deadlock you have in your mind?
> 
> lockdep would complain if we used the same lock from
> different contexts.
> 
> e.g.)
> Process context holding unix_state_lock() with the normal spin_lock()
> -> BH interrupt
> -> tc prog trying to hold the same lock with spin_lock(). (_bh())
> -> deadlock

OK, I get it, thanks.

So here's one more idea: the null-ptr-deref issue is connect() racing
against sock_map_update_elem_*SYS*() coming from user-space, not the
can-be-called-from-BH sock_map_update_elem() variant. So can't we assume
that for any sock_map_update_elem(unix_sk) invoked by a tc prog, unix_sk
will always be "stable", i.e. in a state that cannot lead to that
null-ptr-deref?

IOW, if for a tc prog the only way to get hold of unix_sk is look it up in
a sockmap, then (by the fact that unix_sk _is_ in the sockmap) unix_sk will
be already safe to use by sock_map_update_elem() without taking the af_unix
state lock.

Long story short: take the unix state lock in sock_map_update_elem_sys(),
don't bother in sock_map_update_elem()?

>> ...
>> And sock_{map,hash}_seq_show() (being a part of bpf iter machinery) needs
>> to take lock_sock() just as well? Would that require a special-casing
>> (unix_state_lock()) for af_unix?
> 
> Right, lock_sock() + unix_state_lock() + SOCK_DEAD check
> should be best.

OK, got it.


