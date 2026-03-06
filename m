Return-Path: <netdev+bounces-264810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOy5NH/fqmlqXwEAu9opvQ
	(envelope-from <netdev+bounces-264810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:06:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC66222493
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 322B7305D2BC
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652E3A6EE4;
	Fri,  6 Mar 2026 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="URk51TZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F7198A17;
	Fri,  6 Mar 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805945; cv=none; b=ONkH2qWwtrbdYyP4kPVmmM3mpGvjKvbWQLyXfl8WEvEvKAc4hZPakw6OFpWgMBGObCmmlyBKuJoLFooZ52d1GCSNM08RfZH26CyXvLG7wfbfpKIV+JXkK23+IvToQJ3osDShRx+kY13mzfJ/TvkVfsFvBZXLSeHbkuhhetReeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805945; c=relaxed/simple;
	bh=dT9zWpAVUPz39LgBehJCCTqvqlJ3C9ninrKSWmn9Yk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNBpJE2cfOpEMedW8AVpUggeh3+zVWA/gafeO23SlNCRj2r8VW1hhVm5XYvEXrcLGhlXxKVYJCHMVXDEQG60sCyreJIpnDh9mft79m4wRxVBk53IQlPN89p9NQbGMBR+xsXR5m658Lgs+yjOg6rxmbltg/6IFHXTpFqpbbC6gOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=URk51TZ9; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vyVnm-002asU-NU; Fri, 06 Mar 2026 15:05:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=qIabD9EgboJOvCt+AFbEC4Iprg7lyK19I//zHW0fAXs=; b=URk51TZ9Z1yAxlQowbKDRY7fdk
	apCDFDhO+3/qQsrahZvHgUa8GR469jEmU4OY3RXZqf+T6PbOdfrP5u1t2HmBDvNVS9SZ9WCCo/3rM
	fRfg/1zWZnX9OXYhrVHZXY5qFpMwzHxHxzp587WcdVVsRZP6DnLiVsT9lhG2jc5ErclO/AFveL1P5
	PNL2TT3to17C9tUncWN67L7Fb2RFsF4jGk+SNJb++d+jWOEsClF6ak46zkYAM1ckZZbvHXnmEZpHO
	urop+godYf1NFDYk2cJRcTr4JpB0fdEvgJpXhl4+YRa80Hu3dbudVMvuv0ASgORea3qAp1Zr7zy00
	88sL311g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vyVnl-0001b1-IT; Fri, 06 Mar 2026 15:05:13 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyVnj-001q6e-E4; Fri, 06 Mar 2026 15:05:11 +0100
Message-ID: <3bf84a79-7335-483c-b629-2437e360387d@rbox.co>
Date: Fri, 6 Mar 2026 15:05:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/5] bpf, sockmap: Use
 sock_map_sk_{acquire,release}() where open-coded
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
 <CAAVpQUCdzpwbu=fOrwCnaCFuD3U5SL73PB2nroqgUB4QdJ69og@mail.gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <CAAVpQUCdzpwbu=fOrwCnaCFuD3U5SL73PB2nroqgUB4QdJ69og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3DC66222493
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264810-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/6/26 06:44, Kuniyuki Iwashima wrote:
> On Thu, Mar 5, 2026 at 3:32 PM Michal Luczaj <mhal@rbox.co> wrote:
>>
>> Instead of repeating the same (un)locking pattern, reuse
>> sock_map_sk_{acquire,release}(). This centralizes the code and makes it
>> easier to adapt sockmap to af_unix-specific locking.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>>  net/core/sock_map.c | 21 +++++++--------------
>>  1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 02a68be3002a..7ba6a7f24ccd 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -353,11 +353,9 @@ static void sock_map_free(struct bpf_map *map)
>>                 sk = xchg(psk, NULL);
>>                 if (sk) {
>>                         sock_hold(sk);
>> -                       lock_sock(sk);
>> -                       rcu_read_lock();
>> +                       sock_map_sk_acquire(sk);
>>                         sock_map_unref(sk, psk);
>> -                       rcu_read_unlock();
>> -                       release_sock(sk);
>> +                       sock_map_sk_release(sk);
>>                         sock_put(sk);
>>                 }
>>         }
>> @@ -1176,11 +1174,9 @@ static void sock_hash_free(struct bpf_map *map)
>>                  */
>>                 hlist_for_each_entry_safe(elem, node, &unlink_list, node) {
>>                         hlist_del(&elem->node);
>> -                       lock_sock(elem->sk);
>> -                       rcu_read_lock();
>> +                       sock_map_sk_acquire(elem->sk);
>>                         sock_map_unref(elem->sk, elem);
>> -                       rcu_read_unlock();
>> -                       release_sock(elem->sk);
>> +                       sock_map_sk_release(elem->sk);
>>                         sock_put(elem->sk);
>>                         sock_hash_free_elem(htab, elem);
>>                 }
>> @@ -1676,8 +1672,7 @@ void sock_map_close(struct sock *sk, long timeout)
>>         void (*saved_close)(struct sock *sk, long timeout);
>>         struct sk_psock *psock;
>>
>> -       lock_sock(sk);
>> -       rcu_read_lock();
>> +       sock_map_sk_acquire(sk);
>>         psock = sk_psock(sk);
>>         if (likely(psock)) {
>>                 saved_close = psock->saved_close;
>> @@ -1685,16 +1680,14 @@ void sock_map_close(struct sock *sk, long timeout)
>>                 psock = sk_psock_get(sk);
>>                 if (unlikely(!psock))
>>                         goto no_psock;
>> -               rcu_read_unlock();
>>                 sk_psock_stop(psock);
>> -               release_sock(sk);
>> +               sock_map_sk_release(sk);
> 
> I think sk_psock_stop() was intentionally put outside
> of rcu_read_lock() to not extend the grace period
> unnecessarily. e.g. while + __sk_msg_free().
> 
> Maybe add __sock_map_sk_release() without
> rcu_read_unlock() ?

How about dropping this patch completely? The more I stare at it, I see no
reason why af_unix state lock would matter in any of these places.


