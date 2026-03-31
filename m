Return-Path: <netdev+bounces-273769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAmgBGlOzGlSSQYAu9opvQ
	(envelope-from <netdev+bounces-273769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:44:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A04023727AD
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9813D306F953
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCE0466B63;
	Tue, 31 Mar 2026 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="hLOR809C"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92C466B76;
	Tue, 31 Mar 2026 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997076; cv=none; b=GqpACaS7c2xjImeyMWUIerwwEovqCf3ifnTHNKkS0MwA/Z0+e0NRk88oJmbibbtf8WX8wcgOlX5fCJLuzvWA2r4QLcqi3SJguO2aukIt23K/as8R41fydnjNzncUsB27lc8wRnUcMTXPSG/NPjeo1Gz4B2kpfUfMQIg9kPliROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997076; c=relaxed/simple;
	bh=WDTvr4XqhlnGLS6AxOvVzEVcTQ3bpRS4XMblm2ffo6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4CjwRW+qzPKR3XSCdh1jiKPdl6t+VNTR1QmWXASR0ELAsVxWSSnb91dIEUjXB3YWNHWuM0H2XxSmXFUL75Ejj91gAuc08QW0sQp3R7GDBfOzyTQMWD7WcrpROW2c25BqRBUyj5G/P53SU62yhtzFKwh9KlXz3/Etl509lbSEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=hLOR809C; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1w7hor-005wXw-V8; Wed, 01 Apr 2026 00:44:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=KMF0foE7Qzg2zAWJ0UJ4zt4En3aEr9h7HEut73+w7cI=; b=hLOR809C9gXcoXKPKwGfwu2ZOL
	KvMZdKoosU//6LFYAxzx5XN02jhtdOMEO6B4ZJrHhdcgGEQuE+ZuQCtXVQvDxf1YOzS2UFWqLaXJY
	prZotb5s+3xa4k/RrrWNQRpkI/hXoLZDccC/TMkR+9oro6iU6njTYi4nbJJd35F2PKZaOgMWPqDJU
	Dml4weDudCl7x9spfBU1mHqM9GZUWwpYLWypMHwM/yeM7p2mPysYxDqcj/6RD5M+jxDs56TbERgVy
	iyqO9cUiqEGCokVT7bIeZhqw7qxJBm3RSAwtO7y59TsUE4wTVW3rd163NlBgaj2f6wKoT92dBaVAI
	z/fxvEsw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1w7hom-0006Xq-7g; Wed, 01 Apr 2026 00:44:16 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1w7hoW-00CmWU-IY; Wed, 01 Apr 2026 00:44:00 +0200
Message-ID: <08c824b0-cfbb-40ca-b976-9fbd41e5e855@rbox.co>
Date: Wed, 1 Apr 2026 00:43:58 +0200
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
 <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
 <ae86a1e5-769c-44d8-ad7e-ad724800e9e4@linux.dev>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <ae86a1e5-769c-44d8-ad7e-ad724800e9e4@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[163.com,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273769-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rbox.co:dkim,rbox.co:mid]
X-Rspamd-Queue-Id: A04023727AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 02:20, Martin KaFai Lau wrote:
> On 3/30/26 4:03 PM, Michal Luczaj wrote:
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
> e.g. unix_stream_connect() is taking unix_state_lock(). Can a tc's 
> ingress bpf prog call unix_state_lock()?

Ah, right, that's the problem, thanks for explaining.

But, as I've asked in the parallel thread, do we really need to take the
unix_state_lock() in sock_map_update_elem()? Taking it in
sock_map_update_elem_sys() fixes the null-ptr-deref and does not lead to a
deadlock. Taking unix_state_lock() in sock_map_update_elem() seems
unnecessary. Well, at least under the assumption progs can only access
unix_sk via the sockmap lookup.

>> ...
>> And sock_{map,hash}_seq_show() (being a part of bpf iter machinery) needs
>> to take lock_sock() just as well? Would that require a special-casing
>> (unix_state_lock()) for af_unix?
> 
> I would think so for lock_sock() considering the current bh_lock_sock 
> without !sock_owned_by_user() usage is incorrect in 
> sock_map_update_elem(). [ this probably should be a separate issue for 
> another patch ]

All right, leaving that for later.

> Some more side-tracking... from looking at the code, the bpf_iter of 
> sock_{map,hash} can do bpf_map_lookup_elem(&sock_map, ...). This 
> bpr_iter program probably will be failed to load because the 
> bpf_sk_release() is not available.

I think ability to bpf_map_lookup_elem(sockmap) was added way before bpf
iter in
https://lore.kernel.org/bpf/20200429181154.479310-2-jakub@cloudflare.com/
and iter "allows" it somewhat accidentally. Would you rather have it
explicitly dropped?

> I still don't have good idea what to do with the tc's prog calling 
> sock_map_update_elem().


