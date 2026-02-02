Return-Path: <netdev+bounces-255902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNwTC3fBgGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:23:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE56CE252
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6BB6304B92F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CEC3783B7;
	Mon,  2 Feb 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="YbBnNvU4"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E327AC45;
	Mon,  2 Feb 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045090; cv=none; b=pAOSRpmNHbxwoshlBoGryGHXvPZyIp4rp4CTWa3X+ZOwKMvji80voaPlGGBST6SA05GbHa6FSevgW4e8PvsGUqDVH+yZDuqAegEGPv9k5ESn4HUu7PyDTO24lfvjyba6WkDy/9QBC1xyHYr8vErVADYjft0HDPqVN5/BcHcGRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045090; c=relaxed/simple;
	bh=EuNsfQDC+GwzZgMlzlDh70cwShNvSn7Z72szG+hMKUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOwIS8evmr0rnG3NgTikRojvVtj2mJFkkkXQkS/I9ppyIwTPIMJye6Z7nMoDnO3xg5oKPeN24Jmm34vhlAAqLUdBsXNqPLyWHNvnN1oALRNxWKEgfV3GN07CwoUSWXvE4qSkorpgSo5oJYjZwUj4/ygPoa0absrm3AOZX2hbKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=YbBnNvU4; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vmva3-00C09r-Os; Mon, 02 Feb 2026 16:11:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=P36EvglWh6B36/yp8p2qXvwqnN34foHJfiKZdt7lA94=; b=YbBnNvU4foyoMtrt62cp9yGybT
	EM/Pcm8a0W0s/o0+LcZv1oU86lrBj6n8d1ixe4NtE8gSp5bfr9pX0hhxBVxU630DX6xhO48ncbOxT
	qNNxijyiv11IvNwL6TkYTBjDAjbRLH1uE4On1MSG+ARFMuwjORFfoA24IqTQaACCh20S9v5trPp+z
	eWuIkEiywLQrur1nWNkVNGKyTxOALcM1ICNgy1ncQZQ51DD9jgQNX/ZBYh/uls4A1GIbijrbELTmv
	IKA5UkNf6D4nUXnU5IsaJ7arhtYI+nWovbasLGJuAxm15BY0qnnahAhFhtnxTkrKsARHoTiuCvzSG
	9PO2X5dA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vmva2-0005wE-Oi; Mon, 02 Feb 2026 16:11:10 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vmvZp-00De8r-J4; Mon, 02 Feb 2026 16:10:58 +0100
Message-ID: <b98a40e8-1be2-47f0-8238-92dee8f5a204@rbox.co>
Date: Mon, 2 Feb 2026 16:10:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
 <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev>
 <3362017f-9c3d-46cd-b3ce-cb750b565d5b@rbox.co>
 <612a9446-252f-4b14-8605-ae1af000cc41@linux.dev>
 <CAAVpQUAc3S+Ebx2qp-Pbg9qH-Zc=yHdzVJbchCu++V_4XF3DLg@mail.gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <CAAVpQUAc3S+Ebx2qp-Pbg9qH-Zc=yHdzVJbchCu++V_4XF3DLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255902-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,rbox.co:mid,rbox.co:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AE56CE252
X-Rspamd-Action: no action

On 1/31/26 11:06, Kuniyuki Iwashima wrote:
> On Fri, Jan 30, 2026 at 1:30 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 1/30/26 3:00 AM, Michal Luczaj wrote:
>>>>> Follow-up to discussion at
>>>>> https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/.
>>>>
>>>> It is a long thread to dig. Please summarize the discussion in the
>>>> commit message.
>>>
>>> OK, there we go:
>>>
>>> The root cause of the null-ptr-deref is that unix_stream_connect() sets
>>> sk_state (`WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)`) _before_ it assigns
>>> a peer (`unix_peer(sk) = newsk`). sk_state == TCP_ESTABLISHED makes
>>> sock_map_sk_state_allowed() believe that socket is properly set up, which
>>> would include having a defined peer.
>>>
>>> In other words, there's a window when you can call
>>> unix_stream_bpf_update_proto() on socket which still has unix_peer(sk) == NULL.
>>>
>>> My initial idea was to simply move peer assignment _before_ the sk_state
>>> update, but the maintainer wasn't interested in changing the
>>> unix_stream_connect() hot path. He suggested taking care of it in the
>>> sockmap code.
> 
> Yes, we already have a memory barrier for unix_peer(sk) there
> (to save sock_hold()/sock_put() in sendmsg(), see 830a1e5c212fb)
> and another one just for sk->sk_state is not worth the unlikely
> case in sockmap by a buggy user.
> 
> 
>>>
>>> My understanding is that users are not supposed to put sockets in a sockmap
>>> when said socket is only half-way through connect() call. Hence `return
>>> -EINVAL` on a missing peer. Now, if users should be allowed to legally race
>>> connect() vs. sockmap update, then I guess we can wait for connect() to
>>> "finalize" e.g. by taking the unix_state_lock(), as discussed below.
> 
> If a user hit the issue, the user must have updated sockmap while the
> user knows connect() had not returned.  Such a user must prepare
> for failures since it could occur before sock_map_sk_state_allowed() too.
> 
> This is a subtle timing issue and I don't think the kernel should be
> friendly to such buggy users by waiting for connect() etc.
> 
> 
>>>
>>>>   From looking at this commit message, if the existing lock_sock held by
>>>> update_elem is not useful for af_unix,
>>>
>>> Right, the existing lock_sock is not useful. update's lock_sock holds
>>> sock::sk_lock, while unix_state_lock() holds unix_sock::lock.
>>
>> It sounds like lock_sock is the incorrect lock to hold for af_unix. Is
>> taking lock_sock in sock_map doing anything useful for af_unix? Should
>> sock_map hold the unix_state_lock instead of lock_sock?
> 
> If sockmap code does not sleep, unix_state_lock can be used there.
> 
> 
>>
>> Other than update_elem, do other lock_sock() usages in sock_map have a
>> similar issue for af_unix?

As for the sockmap, I think that would be it.

In related news, looks like bpf_iter_unix_seq_show() is missing
unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). E.g.
bpf iterator can grab unix_sock::peer as it is being released.

>>>> it is not clear why a new test
>>>> "!sk_pair" on top of the existing WRITE_ONCE(sk->sk_state...) is a fix.
>>>
>>> "On top"? Just to make sure we're looking at the same thing: above I was
>>> trying to show two parallel flows with unix_peer() fetch in thread-0 and
>>> WRITE_ONCE(sk->sk_state...) and `unix_peer(sk) = newsk` in thread-1.
>>>
>>> It fixes the problem because now update_proto won't call sock_hold(NULL).
>>>
>>>> A minor thing is sock_map_sk_state_allowed doesn't have
>>>> READ_ONCE(sk->sk_state) for sk_is_stream_unix also.
>>>
>>> Ok, I'll add this as a separate patch in v2. Along with the !tcp case of
>>> sock_map_redirect_allowed()?
>>
>> sgtm. thanks.
>>
>>>
>>>> If unix_stream_connect does not hold lock_sock, can unix_state_lock be
>>>> used here? lock_sock has already been taken, update_elem should not be
>>>> the hot path.
>>>
>>> Yes, it can be used, it was proposed in the old thread. In fact, critical
>>> section can be empty; only used to wait for unix_stream_connect() to
>>> release the lock, which would guarantee unix_peer(sk) != NULL by then.
>>>
>>>          if (!psock->sk_pair) {
>>> +               unix_state_lock(sk);
>>> +               unix_state_unlock(sk);
> 
> I don't like this... we had a similar one in recvmsg(MSG_PEEK) path
> for GC with a biiiiiig comment, which I removed in 118f457da9ed .
> 
> 
>>>                  sk_pair = unix_peer(sk);
>>>                  sock_hold(sk_pair);
>>
>> I don't have a strong opinion on waiting or checking NULL. imo, both are
>> not easy to understand. One is sk_state had already been checked earlier
>> under a lock_sock but still needs to check NULL on unix_peer(). Another
>> one is an empty unix_state_[un]lock(). If taking unix_state_lock, may as
>> well just use the existing unix_peer_get(sk).
> 
> Yes, unix_peer_get() can be safely used there (with extra sock_put()).
> 
> 
>> If its return value cannot
>> (?) be NULL, WARN_ON_ONCE() instead of having a special empty
> 
> I suggested WARN_ON_ONCE() because Michal reproduced it with
> mdelay() and I did not think it could occur in real life, but considering
> PREEMPT_RT, it could be real.  So, the current form in this patch looks
> good to me.

FWIW, it reproduces on CONFIG_PREEMPT_RT=n without mdelay().
Please see
https://lore.kernel.org/bpf/20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co/

>> lock/unlock pattern here. If the correct lock (unix_state_lock) was held
>> earlier in update_elem, all these would go away.
>>
>> Also, it is not immediately clear why a non-NULL unix_peer(sk) is safe
>> here. From looking around af_unix.c, is it because the sk refcnt is held
>> earlier in update_elem? For unix_stream, unix_peer(sk) will stay valid
>> until unix_release_sock(sk). Am I reading it correctly?
> 
> unix_stream_connect() holds the peer's refcnt, and once unix_peer(sk)
> is set, it and refcnt are not cleared until close()d.  So unix_peer_get() is
> a bit redundant for sane users.


