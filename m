Return-Path: <netdev+bounces-264584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALbnDCUVqmnFKgEAu9opvQ
	(envelope-from <netdev+bounces-264584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:43:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C60219704
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5328C312CB91
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961BC368277;
	Thu,  5 Mar 2026 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="YJQvhVm9"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BF36827D;
	Thu,  5 Mar 2026 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753730; cv=none; b=Ge4foNrEjljbZLu81sEtB6D7BhA7HbgW9vGyQGOzA0Da8AJcQDpW9j8nS5t+GaHP9ciCpcKD1FVNvStrXxIpVOTQ5FJr7vam5FTDqy0n79MY8YnW8a56tu+DPhG9iH+F1haBmk9Todhrc+j3iYgA1QE0+gthq1YqYebd1bWAwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753730; c=relaxed/simple;
	bh=XGCp/gbBgvkSyAtCgxgVwVbQsCEaGunpuJSjPaIh8lc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N58okb81zGxEuUrv4KgE4EDoekgQImAv/wN3UdABsbjYmgJTqx1ZEs3n8OQAlstpxcVcdEzvPIaAhD2KKIRPH+ni0W+xnOniDkstMijejWKA9p26Jw5vmxKIxYndueNCv5VzK4QHfv2q1/TOh4jmmErHyW+YF+cQDzPbLoeSe8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=YJQvhVm9; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vyIDu-00EVC8-N0; Fri, 06 Mar 2026 00:35:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=dCbpzFqSx3F9rEHb6ZJLGJQOxr68Qnt0aViVYMiwJhM=; b=YJQvhVm9GfSyt5rWCW5xnzIQ22
	ceQVRRSm229Dbqy0h+1MLiulH/WFrpn+ePtiBgvjRmgLy1961A4jfo4gUM45WGIavaLejRfwBsZWj
	o4GRIFgYryGUo1//BCXFS2O21g6yzXb1R5VC03bbn6sZEZewr2emWzSyrUdf1LHYUXJ+n5jhU3PkZ
	1ViaHbbGWM5OTr3PajefPJrJRi0zV2CovX9x8Vnxuc2hHTOL5tAUaPcCXv8VVb5J0sV7iogr92Q6G
	SvC5ygse3ZdQoD7U2nZkd+Jjnd3FTl1A4upT4nwVVzW8yOFfI22WmJJ5QXonVO+iHvZBt+TRfEuZF
	hYIkaW4g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vyIDp-0004Ol-8s; Fri, 06 Mar 2026 00:35:13 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIDi-0014Px-3p; Fri, 06 Mar 2026 00:35:06 +0100
Message-ID: <835cea23-d141-4c7a-944d-9861be59fecd@rbox.co>
Date: Fri, 6 Mar 2026 00:35:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific
 lock
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemb@google.com>, Cong Wang <cong.wang@bytedance.com>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
 <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
 <CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com>
 <c4eaead1-ad69-42f0-9699-5f2d555a7693@rbox.co>
 <a2f2c260-38e8-4ba3-8655-cffbee046259@linux.dev>
 <b75bbc3f-85fd-4209-9ce1-3bf685ba62ff@rbox.co>
 <d122ed8b-ebfb-4d59-96ce-10c361e76676@linux.dev>
 <1022fcaf-ca38-43d2-84cb-f66a504335e1@rbox.co>
 <f38608e1-4e85-4bc4-8872-c9ecf38e5d7e@linux.dev>
Content-Language: pl-PL, en-GB
In-Reply-To: <f38608e1-4e85-4bc4-8872-c9ecf38e5d7e@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 52C60219704
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,cloudflare.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,bytedance.com,fb.com,linux.dev,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264584-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rbox.co:dkim,rbox.co:mid]
X-Rspamd-Action: no action

On 3/3/26 02:51, Martin KaFai Lau wrote:
> On 2/24/26 7:28 AM, Michal Luczaj wrote:
>> On 2/23/26 22:43, Martin KaFai Lau wrote:
>>>
>>> On 2/11/26 2:02 AM, Michal Luczaj wrote:
>>>>> It should also be helpful to be consistent with tcp/udp iter and use
>>>>> lock_sock() instead of lock_sock_fast() in bpf_iter_unix_seq_show().
>>>> OK, I'll tweak that in v3.
>>>
>>> Hi, Michal. Are you planning to send v3 soon? I don't think the
>>> sock_owned_by_user for the non-tracing prog needs to be addressed in the
>>> same set.
>>
>> Yes, I'm working on it. Sorry for the delay, I'm taking my sweet time to
>> come up with a selftest.
>>
>> I think I can neatly fit the sock_owned_by_user()-related stuff in this
>> series, but let me know if you'd rather have it separately. Whichever way,
>> I don't mind.
> 
> I think sock_owned_by_user() is not related to the AF_UNIX's sockmap 
> fix. If it is not, it's better to separate it. I think one thing at a 
> time is easier to review.

All right, sending out v3 to reduce the scope:
https://lore.kernel.org/bpf/20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co/

> If they are related somewhat or it's easier to review them together, see 
> if it makes sense to structure them in a way such that the AF_UNIX's 
> sockmap-related fixes and tests are at the beginning of the patch set so 
> that they can be applied first if others need more discussion.

I'd say those changes are related, but things are getting unclear for me, I
won't insist on keeping them together.

So. Simply dropping BH locks and introducing sock_owned_by_user() in
sock_map_update_elem() is not enough. For example, sock_map_seq_show() and
sock_hash_seq_show() must be adapted before taking the sock lock (as they
currently run under RCU).

But there's a deeper problem: bpf iters let the bpf code call sockmap
update when sk's file descriptor is halfway through sock_map_close(). This
breaks the sockmap contract as the update can happen after
sock_map_remove_links(), but before saved_close(). sockmap ends up with a
closed sk that normally would be removed.

For sockmap/sockhash iters this condition can be handled: before running
the bpf tracer prog, check if sk is still linked to map. Since those are
sockmap/sockhash iters, if there's no link, it means sk should be skipped.

But I'm not sure about other iters. Plus the case you've mentioned of bpf
tc progs that can call sockmap update with sk unowned. Hence I stop here
worried this may be a doomed approach :)

Long story short: feels like taking the spinlocks (without unconditionally
checking sock_owned_by_user()) in sock_map_update_elem() is the best
approach. Just as it is currently implemented (+the af_unix special
casing). Some sks will come owned, some won't. What needs to be added after
taking the spinlock(s) is a sort of is-sk-being-closed check. Or am I
missing something?

> Regarding the "Keeping sparse annotations in 
> sock_map_sk_{acquire,release}() required some
> hackery...". Maybe just remove the annotations?
> [ btw, from commit 5b63d0ae94cc, the sparse support is removed and it
>    depends solely on clang now (?). If it is the case, what does clang do
>    on the "sock_or_unix_lock"? ]

Oh, I haven't seen that one, thanks. Will take a look. For now, I've just
dropped the annotations.

