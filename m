Return-Path: <netdev+bounces-255102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPb9HZ6PfGkQNwIAu9opvQ
	(envelope-from <netdev+bounces-255102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:01:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D480CB9B01
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51A9301FA7F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6786E376BDF;
	Fri, 30 Jan 2026 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="HlxXhSs+"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9ED28C2BF;
	Fri, 30 Jan 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770837; cv=none; b=VTJJMwa+9/+d4UOkJVEfOGFZ9NwJp33UbiOefr5IouM6G/+Lv1Y+3HKGSLkpH+1i1EuunB7b4vYfGKmsUeJeAfOkbAtVZWqq5TeAAgaQyPADTjZx5+21lh1PB+qg1OpE5vLRWSP+wHNQSK34t7T4LvdeZ9mcPvSf8fTditJAPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770837; c=relaxed/simple;
	bh=h98j0GiF5Q46i/BCECwqBU7tYPkSKApo0FwwUxRx2Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNE6yUoSLoZHJMnil821Zj5Egb5XD6ak7msq+U24dq4CNxQszrJLGKi7CXKuSffQ6CZuM3KP4yvH8Fu788PHkbfNd9Xg8vJBAvdPXsWii5r4zi4uWeBC1X0p4plwr4ZHauwPE2IofGxksbpnug8xpmAoCbg+dDLti6nYkBXBtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=HlxXhSs+; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vlmEX-001rVx-CS; Fri, 30 Jan 2026 12:00:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=+/P0hfZfmKtbQtXdnzfsK7ESYSfyI04sajFusIV+zlA=; b=HlxXhSs+nyhLHSZP6SGNBIbw/X
	ivrEGuc+Sic8atG+2PjP31yHS8imLh6cnnn0POsgsvJwoD391H/8NkgN5GtsZlQ9yHcnAolMRePt3
	P5TX1p8iCjxTNWqkM6p8pNOjmUMvoXfiA7gHTQyMzL9K+lvFmeuJdHUMtJ+ASGaNifay8/XRaf8n+
	f8oIuBUqR6GBpRB+7rl+zhpdYfzdEn37Ik5FaaJLtw/U9I/sSgv6vxG+DiFITIO+FG4DtdNrZustH
	RZ8HAZQEOgPN5gca20n66W2+0WNeIxlZuUUvP+IM1VUKdqXb8k4M5w8N/yRRnVPV8RCrxywhMTZaQ
	h4KP8QCA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vlmEW-0006Qe-1Y; Fri, 30 Jan 2026 12:00:12 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vlmEV-004svS-IM; Fri, 30 Jan 2026 12:00:11 +0100
Message-ID: <3362017f-9c3d-46cd-b3ce-cb750b565d5b@rbox.co>
Date: Fri, 30 Jan 2026 12:00:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
 <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255102-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D480CB9B01
X-Rspamd-Action: no action

On 1/29/26 20:41, Martin KaFai Lau wrote:
> On 1/29/26 8:47 AM, Michal Luczaj wrote:
>> BPF_MAP_UPDATE_ELEM races unix_stream_connect(): when
>> sock_map_sk_state_allowed() passes (sk_state == TCP_ESTABLISHED),
>> unix_peer(sk) in unix_stream_bpf_update_proto() may still return NULL.
>>
>> 	T0 bpf				T1 connect
>> 	------				----------
>>
>> 				WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
>> sock_map_sk_state_allowed(sk)
>> ...
>> sk_pair = unix_peer(sk)
>> sock_hold(sk_pair)
>> 				sock_hold(newsk)
>> 				smp_mb__after_atomic()
>> 				unix_peer(sk) = newsk
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000080
>> RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
>> Call Trace:
>>   sock_map_link+0x564/0x8b0
>>   sock_map_update_common+0x6e/0x340
>>   sock_map_update_elem_sys+0x17d/0x240
>>   __sys_bpf+0x26db/0x3250
>>   __x64_sys_bpf+0x21/0x30
>>   do_syscall_64+0x6b/0x3a0
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Follow-up to discussion at
>> https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/.
> 
> It is a long thread to dig. Please summarize the discussion in the 
> commit message.

OK, there we go:

The root cause of the null-ptr-deref is that unix_stream_connect() sets
sk_state (`WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)`) _before_ it assigns
a peer (`unix_peer(sk) = newsk`). sk_state == TCP_ESTABLISHED makes
sock_map_sk_state_allowed() believe that socket is properly set up, which
would include having a defined peer.

In other words, there's a window when you can call
unix_stream_bpf_update_proto() on socket which still has unix_peer(sk) == NULL.

My initial idea was to simply move peer assignment _before_ the sk_state
update, but the maintainer wasn't interested in changing the
unix_stream_connect() hot path. He suggested taking care of it in the
sockmap code.

My understanding is that users are not supposed to put sockets in a sockmap
when said socket is only half-way through connect() call. Hence `return
-EINVAL` on a missing peer. Now, if users should be allowed to legally race
connect() vs. sockmap update, then I guess we can wait for connect() to
"finalize" e.g. by taking the unix_state_lock(), as discussed below.

>  From looking at this commit message, if the existing lock_sock held by 
> update_elem is not useful for af_unix,

Right, the existing lock_sock is not useful. update's lock_sock holds
sock::sk_lock, while unix_state_lock() holds unix_sock::lock.

> it is not clear why a new test 
> "!sk_pair" on top of the existing WRITE_ONCE(sk->sk_state...) is a fix. 

"On top"? Just to make sure we're looking at the same thing: above I was
trying to show two parallel flows with unix_peer() fetch in thread-0 and
WRITE_ONCE(sk->sk_state...) and `unix_peer(sk) = newsk` in thread-1.

It fixes the problem because now update_proto won't call sock_hold(NULL).

> A minor thing is sock_map_sk_state_allowed doesn't have 
> READ_ONCE(sk->sk_state) for sk_is_stream_unix also.

Ok, I'll add this as a separate patch in v2. Along with the !tcp case of
sock_map_redirect_allowed()?

> If unix_stream_connect does not hold lock_sock, can unix_state_lock be 
> used here? lock_sock has already been taken, update_elem should not be 
> the hot path.

Yes, it can be used, it was proposed in the old thread. In fact, critical
section can be empty; only used to wait for unix_stream_connect() to
release the lock, which would guarantee unix_peer(sk) != NULL by then.

        if (!psock->sk_pair) {
+               unix_state_lock(sk);
+               unix_state_unlock(sk);
                sk_pair = unix_peer(sk);
                sock_hold(sk_pair);

>> Fixes: 8866730aed51 ("bpf, sockmap: af_unix stream sockets need to hold ref for pair sock")
>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> Re-triggered while working on an unrelated selftest:
>> https://lore.kernel.org/bpf/20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co/
>> ---
>>   net/unix/unix_bpf.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
>> index e0d30d6d22ac..57f3124c9d8d 100644
>> --- a/net/unix/unix_bpf.c
>> +++ b/net/unix/unix_bpf.c
>> @@ -185,6 +185,9 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
>>   	 */
>>   	if (!psock->sk_pair) {
>>   		sk_pair = unix_peer(sk);
>> +		if (unlikely(!sk_pair))
>> +			return -EINVAL;
>> +
>>   		sock_hold(sk_pair);
>>   		psock->sk_pair = sk_pair;
>>   	}
>>
>> ---
>> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
>> change-id: 20260129-unix-proto-update-null-ptr-deref-6a2733bcbbf8
>>
>> Best regards,
> 


