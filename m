Return-Path: <netdev+bounces-278475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECJQGeZO3mndqAkAu9opvQ
	(envelope-from <netdev+bounces-278475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:27:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF41F3FB303
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840513055420
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875D3E6DFF;
	Tue, 14 Apr 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="G2hnTda/"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EF3E5EF8;
	Tue, 14 Apr 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176419; cv=none; b=L/i68q58Ib0Ayrm0r32lWXN62tVDFG5MDZUurmp8ft857WcpfCBTKwGhG+EHKKzU5jSOEanCD8bf1O/kbSXgDxaGXaqvv1W+WyXv2+Ye7vz0breRfWdENtS3f7FBredWFfn5oq0Po9smlvW5hqdnLDT6vDjWgO29TlPC2hgfPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176419; c=relaxed/simple;
	bh=L8h8ncj1xlogJQEUDHS5GItbXkq0sblifQ1BGwMeHJ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ciJCFyf2G9vmsAzxMoNSUYbHlHnEU3qfJ95PlkzQWC+o/vLdlkPSeC5UpvDrNZp2eU65KLzeCHMDlYn4grjsP0R24OwqdfLXIyN0YD4LC/d+5wfVb+xVdfIQuJVXwSLFeHUVBIXdUnKdLlsk5I1l15SNt51NE/JxgR+oe3o++3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=G2hnTda/; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wCecS-00FBt1-Gn; Tue, 14 Apr 2026 16:20:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=/SY+gHDpWMFn5J7DtwXLF7yg5El1T/4gAkeMvZeGiow=; b=G2hnTda/hO4AAjCnS4C+cObxam
	ho6HXvp70qD8xJI3VHQG1xAdJPHyGpZ6Ftz6XYY7ktORAHE81YX5Fo+EDuwDVveOaQ7FJ18ehP+vA
	BiMiQ2aMfMvl5urmxOSfamjoocJbsC2izLS8Qz0j/SHn/LlzfVmUchTNA5m8EoXnhyQT4Zz+PLoMU
	JWfP00I98A0Fi0EoEsBel3xso8sU9J0d1M0iqChqwBmOcA3LovrLZ3ap0L85+OCpIquVvXW4valVk
	CCf9XRkppSTqsH9WnqpVp6ig7qMvOYL5cY+cilhP+waOvCrOn5gn9MxvYwDhggi4g0Cym6pOShBEE
	8vcpPHMw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wCecR-000126-3k; Tue, 14 Apr 2026 16:19:59 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wCec9-00DiJt-Oi; Tue, 14 Apr 2026 16:19:41 +0200
Message-ID: <fa2456d0-51fe-4569-9940-085404cda70f@rbox.co>
Date: Tue, 14 Apr 2026 16:19:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
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
 <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
 <ae86a1e5-769c-44d8-ad7e-ad724800e9e4@linux.dev>
 <08c824b0-cfbb-40ca-b976-9fbd41e5e855@rbox.co>
 <ac2z6IqYyIxSZFPS@devbig1721.ftw5.facebook.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <ac2z6IqYyIxSZFPS@devbig1721.ftw5.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[163.com,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278475-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rbox.co:dkim,rbox.co:mid]
X-Rspamd-Queue-Id: AF41F3FB303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 03:34, Martin KaFai Lau wrote:
> On Wed, 01 Apr 2026 00:43:58 +0200, Michal Luczaj wrote:
>> On 3/31/26 02:20, Martin KaFai Lau wrote:
>>> On 3/30/26 4:03 PM, Michal Luczaj wrote:
>>>> On 3/26/26 07:26, Martin KaFai Lau wrote:
>>>>> On 3/15/26 4:58 PM, Michal Luczaj wrote:
>>>>>>> Beside, from looking at the may_update_sockmap(), I don't know if it is
>>>>>>> even doable (or useful) to bpf_map_update_elem(unix_sk) in
>>>>>>> tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when looking
>>>>>>> at unix_dgram_sendmsg() => sk_filter(). It was not the original use case
>>>>>>> when the bpf_map_update_elem(sockmap) support was added iirc.
>>>>>>
>>>>>> What about a situation when unix_sk is stored in a sockmap, then tc prog
>>>>>> looks it up and invokes bpf_map_update_elem(unix_sk)? I'm not sure it's
>>>>>> useful, but seems doable.
>>>>>
>>>>> [ Sorry for the late reply ]
>>>>>
>>>>> It is a bummer that the bpf_map_update_elem(unix_sk) path is possible
>>>>> from tc :(
>>>>>
>>>>> Then unix_state_lock() in its current form cannot be safely acquired in
>>>>> sock_map_update_elem(). It is currently a spin_lock() instead of
>>>>> spin_lock_bh().
>>>>
>>>> Is there a specific deadlock you have in your mind?
>>>
>>> e.g. unix_stream_connect() is taking unix_state_lock(). Can a tc's 
>>> ingress bpf prog call unix_state_lock()?
>>
>> Ah, right, that's the problem, thanks for explaining.
>>
>> But, as I've asked in the parallel thread, do we really need to take the
>> unix_state_lock() in sock_map_update_elem()? Taking it in
>> sock_map_update_elem_sys() fixes the null-ptr-deref and does not lead to a
>> deadlock. Taking unix_state_lock() in sock_map_update_elem() seems
>> unnecessary. Well, at least under the assumption progs can only access
>> unix_sk via the sockmap lookup.
> 
> right, sock_map_update_elem_sys() should be safe to take
> unix_state_lock().
> 
> If it is fixed by testing unix_peer(), is the TCPF_ESTABLISHED test
> in sock_map_sk_state_allowed() still useful and needed?

I don't think it's necessary. Although removing it may slightly mask the
fact that we're interested in TCP_ESTABLISHED sockets (we watch the sock's
life cycle and invoke sock_map_close() as it transitions to TCP_CLOSE).
Removing this check will also mean listening socks will be rejected not
early in sock_map_sk_state_allowed(), but deeper in
unix_stream_bpf_update_proto() (and with a different error code?).

> Also,
> please explain in detail in the commit message why testing for NULL
> without unix_state_lock() is enough.

OK, will do.

> For example, for the BPF iterator on
> sock_map, my understanding is that unix_release_sock() can still happen
> while the BPF iterator is iterating over a unix_sock. I guess a future
> unix_state_lock() in the iterator's seq_show() should be useful.

That's right. That's also why, I think, Kuniyuki was asking for
"lock_sock() + unix_state_lock() + SOCK_DEAD check" in a parallel thread.

> It will also be useful to mention what was discovered about TC + lookup
> + update_elem(&sock_map, ...) and why it is not safe to take
> unix_state_lock() in that path. Thanks.

The softirq vs. process context? Sure, I'll mention that.

Took a while (sorry), but here's v4:
https://lore.kernel.org/netdev/20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co/


