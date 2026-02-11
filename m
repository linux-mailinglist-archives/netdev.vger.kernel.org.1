Return-Path: <netdev+bounces-258247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO1kDB9UjGnblAAAu9opvQ
	(envelope-from <netdev+bounces-258247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:04:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DD123210
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D63F302A6FD
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043E5366805;
	Wed, 11 Feb 2026 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="iondu5/x"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A64331A5F;
	Wed, 11 Feb 2026 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770804182; cv=none; b=oKdObzyUu02gcNGWJMuKGxd4mV8DHb71FjiVAAxuQVLHEGdhpXs45TSs6eqD0qrONvyZR4rN880aEzKohR8QIXnovAHZaJ2A/hvO6S4CTxxewcvl2/f3emleHVhV3rZs/g/c5iBej1fbrNDH/6MiGwMyVpSBraS9nfXBSviVIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770804182; c=relaxed/simple;
	bh=jN+m9KJe/SwQ8DqClAtfykRlVVUMngHq8nXiGABhfmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKJG+lRqIG0NYXNVkkQ+gj2v6ZC6fERWqnYp4XugWSoaz11Wihv8nQXkfb0NH98vA2lMPeR8GL2prhIP1WD7dRtrYEdURKzH4DcsPXcFbvMGBu0siHm2JvqrDIr9NVxC+Zdrg47CnabVgA75rCd/5IWsXWlRPe82XNcTFDoDeBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=iondu5/x; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vq73I-009FQt-Ui; Wed, 11 Feb 2026 11:02:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=3W2hLzHXfNmIW4Z7uWIgEuhgIuj2w9wMS7oKHXEkaVA=; b=iondu5/xfOoACHyhg0GSiYpP0y
	N2BS+/XarKUo6TV7tLqtMzfvy/znawlD22jRhBBucTzrxlxFJMd1X7iyBP7y2DfHRriVUHvqI5D69
	rsk7kt68N8OY96LGZj+LrPCIRMOgsCeBfeN4778mDzOs2Znd4CSBkoL/4G25egu8MjACT76HT4r2B
	aEANzvVpzPbTspagOf/fcAcnhTswsdtjxuvVSXnVak23EfyzKjfBxsUX0pAveQG06lS3ne0nvzJRl
	XQozoqdyG9k8Ymp7Al3g+Llzb9xBp0oYLeu2u0w52WegbMrZSQih7sf73B2EYb0pwVxV0Br0HWKTD
	HrRufFTQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vq73H-0003s4-0F; Wed, 11 Feb 2026 11:02:31 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vq73F-00HJAD-Ej; Wed, 11 Feb 2026 11:02:29 +0100
Message-ID: <b75bbc3f-85fd-4209-9ce1-3bf685ba62ff@rbox.co>
Date: Wed, 11 Feb 2026 11:02:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific
 lock
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
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
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <a2f2c260-38e8-4ba3-8655-cffbee046259@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-258247-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,bytedance.com,fb.com,linux.dev,fomichev.me,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rbox.co:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:mid,rbox.co:dkim,rbox.co:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C10DD123210
X-Rspamd-Action: no action

On 2/9/26 21:17, Martin KaFai Lau wrote:
> On 2/8/26 9:14 AM, Michal Luczaj wrote:
>> On 2/7/26 23:00, Kuniyuki Iwashima wrote:
>>> On Sat, Feb 7, 2026 at 6:35 AM Michal Luczaj <mhal@rbox.co> wrote:
>>>> This patch also happens to fix a deadlock that may occur when
>>>> bpf_iter_unix_seq_show()'s lock_sock_fast() takes the fast path and the
>>>> iter prog attempts to update a sockmap. Which ends up spinning at
>>>> sock_map_update_elem()'s bh_lock_sock():
>>>
>>> Hmm.. this seems to be a more general problem for
>>> bpf iter vs sockmap.  bpf_iter_{tcp,udp}_seq_show() also
>>> hold lock_sock(),  where this patch's solution does not help.
>>> We need to resolve this regardless of socket family.
>>
>> I don't see any deadlocks there. Note that I've mentioned lock_sock_fast()
>> fast path was a problem, not lock_sock().
> 
> For the tcp/udp, I think the bpf_iter should be fine: lock_sock() in 
> seq_show and bh_lock_sock() in map_update. It seems redundant though.

I wasn't sure what exactly you suspect of being redundant, so I did some
digging:

lock_sock() in tcp/udp iter is expected (among others?) by kfunc
bpf_sock_destroy(). Relevant commit 4ddbcb886268 ("bpf: Add
bpf_sock_destroy kfunc"),
https://lore.kernel.org/all/20230519225157.760788-8-aditi.ghag@isovalent.com/
In short: lock must be taken for synchronization of proto::diag_destroy().

Reasons for bh_lock_sock() during bpf sockmap update are explained in
commit 0126240f448d ("bpf: sockmap: Allow update from BPF"),
https://lore.kernel.org/bpf/20200821102948.21918-6-lmb@cloudflare.com/
In short: socket shouldn't be allowed to change its state during the
update. BH lock because bpf can't sleep.

>  From looking at may_update_sockmap(), other bpf progs (e.g., tc) can do 
> map_update also. On those paths, I am not sure why 
> sock_map_update_elem() does not need to check "!sock_owned_by_user(sk)". 
> If it is indeed an issue, it probably needs to be addressed separately.

Since sockmap update can happen in a tracing prog, can you really expect a
socket to be always owned?

> It should also be helpful to be consistent with tcp/udp iter and use 
> lock_sock() instead of lock_sock_fast() in bpf_iter_unix_seq_show().

OK, I'll tweak that in v3.


