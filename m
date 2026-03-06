Return-Path: <netdev+bounces-264813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNvcLhXjqmkjYAEAu9opvQ
	(envelope-from <netdev+bounces-264813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:22:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264D2228BA
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C132931FFCD0
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1AF3AE71E;
	Fri,  6 Mar 2026 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="qMoQza7G"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6793A9014;
	Fri,  6 Mar 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806197; cv=none; b=PQR22wnfaMBS0ZDX1aJX/9fiLK8QF+WkUHAOyX721vSE74d1cYhsH33Ww658Fw37VRYSNhzikXqx8RsYDKKAGJiTGfPiBa3XoxExHCMTEmv3sgMPV6PzMz26GJUly9N8GTsP5QyyrWqthrTxaL0sMuJ0CmYFRUceIpsnwVkpqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806197; c=relaxed/simple;
	bh=l13+VO1c6e8huzQ2fEnZAu/99Udip4rioN8YwXhZY/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxFKkWpEsTLHszT87dkNxMyuz5luYsPK9KFG5wiv6z79E6x8UEt9UfhwTaOQf9MmkzoenZUoNt+ywnWH8ont/CLro9ZXQ1Pzrsl5EWdv2kU787eI1NbyB3+kcofP6bwe8k+nuiOm6kEz4BsVWOMAJp1t/Sa0MTAVKt3d1MNviFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=qMoQza7G; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vyVs6-002bd3-7e; Fri, 06 Mar 2026 15:09:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=7i0wGoq7Rjjw97jeqTUuq5pBMplSk95w+QPZxcdYj4w=; b=qMoQza7G/7qXIhXmQJ+RzKPJoq
	wiH2w6tTzp0BjXfjJeLXU8VtcrDDHGPDEIneHADtutlkJPYaw8hQ/VaOlGu+wRRlPobzrgv2Q8CXi
	+iE1z5CWroMdJsQmAypF02+/VNDG0SI3LV/sW+MiyN3Ogory0c1K8L1nR+63WY0jB9PjInuKv8kcN
	O1k+4/QaNLNp6QFi/bCSz9/WNV4zjwLV3VbuMu2V5YO+xEszCUCAWaEE0J1bAhxA8u6eOvRVa8lOb
	XB5/2UI5bc13UtgTzn1ioVj13gFomaQR17zbBNVCADoLTP8TI/LWgcafiQxBGToA5Wmc64jjBuDWn
	eHKK0xBA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vyVs5-0001wi-Gs; Fri, 06 Mar 2026 15:09:41 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyVs4-0008as-07; Fri, 06 Mar 2026 15:09:40 +0100
Message-ID: <b9a956dd-ebb2-47ca-8b49-ccbba6ff9b26@rbox.co>
Date: Fri, 6 Mar 2026 15:09:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
To: Jiayuan Chen <mrpre@163.com>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
 <2192e9ef-894f-4826-b296-4f90e973a31b@163.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <2192e9ef-894f-4826-b296-4f90e973a31b@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6264D2228BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264813-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.9.9.74:received,185.226.149.37:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,rbox.co:dkim,rbox.co:email,rbox.co:mid]
X-Rspamd-Action: no action

On 3/6/26 06:01, Jiayuan Chen wrote:
> 
> On 3/6/26 7:30 AM, Michal Luczaj wrote:
>> unix_stream_connect() sets sk_state (`WRITE_ONCE(sk->sk_state,
>> TCP_ESTABLISHED)`) _before_ it assigns a peer (`unix_peer(sk) = newsk`).
>> sk_state == TCP_ESTABLISHED makes sock_map_sk_state_allowed() believe that
>> socket is properly set up, which would include having a defined peer. IOW,
>> there's a window when unix_stream_bpf_update_proto() can be called on
>> socket which still has unix_peer(sk) == NULL.
>>
>>            T0 bpf                            T1 connect
>>            ------                            ----------
>>
>>                                  WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
>> sock_map_sk_state_allowed(sk)
>> ...
>> sk_pair = unix_peer(sk)
>> sock_hold(sk_pair)
>>                                  sock_hold(newsk)
>>                                  smp_mb__after_atomic()
>>                                  unix_peer(sk) = newsk
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000080
>> RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
>> Call Trace:
>>    sock_map_link+0x564/0x8b0
>>    sock_map_update_common+0x6e/0x340
>>    sock_map_update_elem_sys+0x17d/0x240
>>    __sys_bpf+0x26db/0x3250
>>    __x64_sys_bpf+0x21/0x30
>>    do_syscall_64+0x6b/0x3a0
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Initial idea was to move peer assignment _before_ the sk_state update[1],
>> but that involved an additional memory barrier, and changing the hot path
>> was rejected. Then a check during proto update was considered[2], but a
>> follow-up discussion[3] concluded the root cause is sockmap taking a wrong
>> lock. Or, more specifically, an insufficient lock[4].
>>
>> Thus, teach sockmap about the af_unix-specific locking: af_unix protects
>> critical sections under unix_state_lock() operating on unix_sock::lock.
>>
>> [1]: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co/
>> [2]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/
>> [3]: https://lore.kernel.org/netdev/7603c0e6-cd5b-452b-b710-73b64bd9de26@linux.dev/
>> [4]: https://lore.kernel.org/netdev/CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com/
>>
>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
>> Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>>   net/core/sock_map.c | 35 +++++++++++++++++++++++++++++------
>>   1 file changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 7ba6a7f24ccd..6109fbe6f99c 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/list.h>
>>   #include <linux/jhash.h>
>>   #include <linux/sock_diag.h>
>> +#include <net/af_unix.h>
>>   #include <net/udp.h>
>>   
>>   struct bpf_stab {
>> @@ -115,19 +116,43 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
>>   }
>>   
>>   static void sock_map_sk_acquire(struct sock *sk)
>> -	__acquires(&sk->sk_lock.slock)
>>   {
>>   	lock_sock(sk);
>> +
>> +	if (sk_is_unix(sk))
>> +		unix_state_lock(sk);
>> +
>>   	rcu_read_lock();
>>   }
>>   
> 
> This introduces a new ordering constraint: lock_sock() before
> unix_state_lock(). Kuniyuki flagged in the v2 review that taking
> lock_sock() inside unix_state_lock() in the future would create an
> ABBA deadlock, which is exactly why the order was settled this way. However,
> the thread did not reach a conclusion on whether that constraint should be
> documented in the code.
> 
> Since there is nothing enforcing this ordering mechanically, a brief comment
> at sock_map_sk_acquire() would help future readers avoid introducing the
> inverse ordering.

Sure, will do.

>>   static void sock_map_sk_release(struct sock *sk)
>> -	__releases(&sk->sk_lock.slock)
>>   {
>>   	rcu_read_unlock();
>> +
>> +	if (sk_is_unix(sk))
>> +		unix_state_unlock(sk);
>> +
>>   	release_sock(sk);
>>   }
>>   
>> +static inline void sock_map_sk_acquire_fast(struct sock *sk)
>> +{
>> +	local_bh_disable();
>> +	bh_lock_sock(sk);
>> +
>> +	if (sk_is_unix(sk))
>> +		unix_state_lock(sk);
>> +}
>> +
> 
> 
> v2 and v3 differ here in a way that deserves a closer look. In v2, AF_UNIX
> sockets took only unix_state_lock() in the fast path, skipping
> bh_lock_sock() entirely:
> 
> /* v2 */
> if (sk_is_unix(sk))
>    unix_state_lock(sk);
> else
>    bh_lock_sock(sk);
> 
> v3 takes both for AF_UNIX sockets.
> 
> bh_lock_sock() protects sock::sk_lock.slock, whereas the state that
> actually needs protection here — sk_state and unix_peer() — lives under
> unix_sock::lock. Since unix_state_lock() is already sufficient to close
> the race against unix_stream_connect(), is bh_lock_sock() still doing
> anything useful for AF_UNIX sockets in this path?

Yeah, good point. I think I was just trying to keep the _fast variant
aligned with the sleepy one. Which I agree might be unnecessary.

In a parallel thread I've asked Kuniyuki if it might be better to
completely drop patch 2/5, which would change how we interact with
sock_map_close(). Lets see how it goes.


