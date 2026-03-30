Return-Path: <netdev+bounces-273383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBELCCsKy2kNDQYAu9opvQ
	(envelope-from <netdev+bounces-273383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:41:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65951362619
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDC5B302C305
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7233BAD84;
	Mon, 30 Mar 2026 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="MbuYaueX"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1936AB54;
	Mon, 30 Mar 2026 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914087; cv=none; b=kqAo6gsJzdji2QIMT9Ws9oElmDI4RVPU9DaduE1Ws9w50+7c14ehE6MdmhaSiPqeFAQCDZ2Uutr70cTAH2fHpWv1cOwv/2QLJP0aMu8HvtVmFRRHTzfkSVH/0TM0DIwWMdsSmivJZROx4zWvViXNLf/VCeYQj29CYJdIT9HLS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914087; c=relaxed/simple;
	bh=Wsb68vwebu5k5GbIZ4m7HzQHX0mtcKHGVK4H/spGrgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVnx6tlXPQvo2dfbgAG6ijzehOigNmcSt8KT0qksXaVH+jx9RcfhUcj38cOYqbcT9A3WdqAyl54ioP0wXa9nc4lDTZAsNU/baJ/ecHJkzICkW+uwD0Bk2BllpmsbaIdNBh0W3SpdRtpOSp/6AdYPLbRiwMH9azTwBtn0wwXq8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=MbuYaueX; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1w7LeK-002rCb-89; Tue, 31 Mar 2026 01:04:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=SqFNvY1V+aOz8GRhxciZ/yNPa759gjISZHD7MtM/Fmg=; b=MbuYaueXdMQp3bLFmRL8FrrdFK
	YG+4GryjUIHI3irD+p5oUWptBWhztRePe4mUiF0Tlx7WPDuWnEH3BSOBI2Hcvs8mUonnf5OJkC0e1
	l4JStv8HZsIewiWqcI/kaFH7P9VDrh0tVvNiiXi8hw9ySV+yFlnf+JRTM3g7UEIdjgJ1LZaRYKHwq
	4KlLft08Jvx8tiFmg7SSNIx7I77UCKTUX47sWwP0yAhGJgTNzT5PORenOwtVzi2aUIIWmiIjZB7/J
	WWhQISfgt2cZvnDOqoptGzEWzHzaTqZtTEQO+nATgc/APm3MGVhcTJrtVxLUqzjTvTmyOKo05ZMvd
	mHc9I1Bg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1w7Le8-0006EB-KT; Tue, 31 Mar 2026 01:03:48 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1w7Ldp-007xmP-N0; Tue, 31 Mar 2026 01:03:29 +0200
Message-ID: <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
Date: Tue, 31 Mar 2026 01:03:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jiayuan Chen <mrpre@163.com>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <dd043c69-4d03-46fe-8325-8f97101435cf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[163.com,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273383-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:dkim,rbox.co:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65951362619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 07:26, Martin KaFai Lau wrote:
> On 3/15/26 4:58 PM, Michal Luczaj wrote:
>>> Beside, from looking at the may_update_sockmap(), I don't know if it is
>>> even doable (or useful) to bpf_map_update_elem(unix_sk) in
>>> tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when looking
>>> at unix_dgram_sendmsg() => sk_filter(). It was not the original use case
>>> when the bpf_map_update_elem(sockmap) support was added iirc.
>>
>> What about a situation when unix_sk is stored in a sockmap, then tc prog
>> looks it up and invokes bpf_map_update_elem(unix_sk)? I'm not sure it's
>> useful, but seems doable.
> 
> [ Sorry for the late reply ]
> 
> It is a bummer that the bpf_map_update_elem(unix_sk) path is possible 
> from tc :(
> 
> Then unix_state_lock() in its current form cannot be safely acquired in 
> sock_map_update_elem(). It is currently a spin_lock() instead of 
> spin_lock_bh().

Is there a specific deadlock you have in your mind?

>>> The only path left is bpf_iter, which I believe was the primary use case
>>> when adding bpf_map_update_elem(sockmap) support [1]. It would be nice
>>> to avoid bh_lock_sock() when calling from all bpf_iter (tcp/udp/unix)
>>> where lock_sock() has already been done. It is more for
>>> reading-correctness though. This just came to my mind.
>>> has_current_bpf_ctx() can be used to check this. sockopt_lock_sock() has
>>> been using it to conditionally take lock_sock() or not.
>>
>> [ One clarification: bh_lock_sock() is a sock_map_update_elem() thing,
>> which can only be called by a bpf prog. IOW, has_current_bpf_ctx() is
>> always `true` in sock_map_update_elem(), right? ]
> 
> For all the bpf prog types allowed by may_update_sockmap() to do 
> bpf_map_update_elem(sockmap), only BPF_TRACE_ITER should have 
> has_current_bpf_ctx() == true. The tc prog (and others allowed in 
> may_update_sockmap()) will have has_current_bpf_ctx() == false when 
> calling sock_map_update_elem().

OK, so let's take test_sockmap_update.c:copy_sock_map(). It is a tc prog
and it calls bpf_map_update_elem() -> sock_map_update_elem(), right? But
running `test_progs -t "sockmap_basic/sockmap update"` shows (pr_warn() in
sock_map_update_elem()) that has_current_bpf_ctx() == true. That's expected
and has_current_bpf_ctx() would be false if sock_map_update_elem() was ran
via a hook?

> The tc case of bpf_map_update_elem(unix_sk) is unfortunate and requires 
> going back to the drawing board. I think checking unix_peer(sk) for NULL 
> without acquiring unix_state_lock() is needed for the 
> sock_map_update_elem() path, since changing unix_state_lock() for this 
> unknown use case seems overkill.
> 
> Whether sock_map_update_elem_"sys"() needs unix_state_lock() is up for 
> debate.

All right, I'll re-spin the series reverting back to v1.

> For bpf_iter_unix_seq_show(), one thought is to add unix_state_lock() 
> there before running the bpf iter prog. iiuc, it is what Kuniyuki has in 
> mind also to allow bpf iter prog having a stable view of unix_sock. This 
> could be a followup.
> [fwiw, it was why I first thought of has_current_bpf_ctx() to avoid 
> sock_map_update_elem() taking unix_state_lock() again if 
> bpf_iter_unix_seq_show() acquires unix_state_lock() earlier. I later 
> concluded (but proved to be incorrect) that tc cannot call 
> bpf_map_update_elem(unix_sk).]
> 
>>
>> Let me know if I'm correctly rephrasing your idea: assume all bpf-context
>> callers hold the socket locked or keep it "stable" (meaning: "sk won't
>> surprise sockmap update by some breaking state change coming from another
>> thread"). As you said, most bpf iters already take the sock_lock(), and I
> 
> Right, all bpf iter (udp, tcp, unix) has acquired the lock_sock() before 
> running the bpf iter prog. afaik, the only exception is netlink bpf iter 
> but it cannot be added to sock_map afaik.

And sock_{map,hash}_seq_show() (being a part of bpf iter machinery) needs
to take lock_sock() just as well? Would that require a special-casing
(unix_state_lock()) for af_unix?

>> have a patch that fixes sock_{map,hash}_seq_show(). Then we could try
>> dropping that bh_lock_sock().
>>
>>> [ I would still keep patch 3 though. ]
>>
>> Right.
>>
>>> [1]: https://lore.kernel.org/bpf/20200821102948.21918-1-lmb@cloudflare.com/
>>>
>>>>
>>>> In a parallel thread I've asked Kuniyuki if it might be better to
>>>> completely drop patch 2/5, which would change how we interact with
>>>> sock_map_close(). Lets see how it goes.
>>>>
>>>
>>> If patch 2 is dropped, lock_sock() is always needed for unix_sk?
>>
>> For sock_map_update_elem_sys() I wanted to lock_sock()+unix_state_lock()
>> following Kuniyuki's suggestion to keep locking pattern/order (that repeats
>> when unix bpf iter prog invokes bpf_map_update_elem() ->
>> sock_map_update_elem()). For sock_map_update_elem() not, we can't sleep there.
> 


