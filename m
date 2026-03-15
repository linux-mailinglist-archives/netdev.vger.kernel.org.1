Return-Path: <netdev+bounces-267981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOhKG+FHt2lsPQEAu9opvQ
	(envelope-from <netdev+bounces-267981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 00:59:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E397E29312A
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 00:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8CA93009547
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 23:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A4C2C3757;
	Sun, 15 Mar 2026 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="iP3xSPx5"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592EB2BE65B;
	Sun, 15 Mar 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773619166; cv=none; b=pPky8h0lmadVjboZ5wPVT8pyDrYaMYb84+f49R+42g5dzAwSpO5ejXeiB/SZQIo4lswH47UMfjSOZ6CbZCfuSgx3OKE/1A+9DQ+8gh4+bCEwvKyvMpNWucWDb5svzMovIGPl5X/YmhbTwZBfdtNf9l9A9K0aMQqY1K88rTo5nQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773619166; c=relaxed/simple;
	bh=pUqvQ4L543THASTLxaotL2vpfSDTQPiKP3+I++E8IKg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DuAsw4Rn61UASo7QmbHnJB8HR9i6FN2VBURqN9JkE/dS+RntHDrxAYbq38LGhuMRGaq7ZFzNq2wvggtY7QOxnev/35I6nKAgPkwG9kBq5k8D6WoAPpDhPXxm6/YkdbkyQ8c5lLsRhGfQc5TRXtyFsRjmuTmcsFnF3a797WGagjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=iP3xSPx5; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1w1vMX-009wKv-N0; Mon, 16 Mar 2026 00:59:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=4jKTHizgmed/QxPJ5Oz1+TL9ejQhNst9sRE/CoWpmbQ=; b=iP3xSPx5T5O2cBZoYZ6/3zxpeM
	RFPO6MZskaXJ8Yp5WGfrbIa1FpB0hphIizFvCnDjBQtZ6l+J2G95r0Oh+xMkxWnI/E+y3y4pUv6CA
	u6dfAOnjuygGJQ/ctBzunNdGUKDOWE23lWirJvPxFL0wR8jyfYXKNzud/LgxKT+v4u9P720aOsY8i
	+k2lC70e22/eI/mUcI6UtqG43U2jdrClZiJFMLaFGzuwaOaUT86CVldf+z4SlcdkTNSyjWW0ouxx0
	AVMijTWw2apaHTMceZTEHdCXZAQ5Cb4TdFUDFpW84G0VI3+82jECXTrgRiq7ADTQB3jrcXJaX3Yhs
	3h+2gAbA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1w1vMX-00053c-5Y; Mon, 16 Mar 2026 00:59:13 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1w1vMF-006y37-HT; Mon, 16 Mar 2026 00:58:55 +0100
Message-ID: <b74fa713-22e1-417c-8c72-b02937dbdaaa@rbox.co>
Date: Mon, 16 Mar 2026 00:58:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
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
 <3bf84a79-7335-483c-b629-2437e360387d@rbox.co>
 <CAAVpQUB8fvyKSQ8UjBs4=FHmz0iME4SO=3CviS_dCzLNTLkjHQ@mail.gmail.com>
 <CAAVpQUADj21wNH=OkUVxW81Zf8RPd1TxLgcfU1wVbWXDY+W6Sg@mail.gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <CAAVpQUADj21wNH=OkUVxW81Zf8RPd1TxLgcfU1wVbWXDY+W6Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-267981-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E397E29312A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 05:57, Kuniyuki Iwashima wrote:
> On Tue, Mar 10, 2026 at 9:17 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>
>> On Fri, Mar 6, 2026 at 6:05 AM Michal Luczaj <mhal@rbox.co> wrote:
>>>
>>> On 3/6/26 06:44, Kuniyuki Iwashima wrote:
>>>> On Thu, Mar 5, 2026 at 3:32 PM Michal Luczaj <mhal@rbox.co> wrote:
>>>>>
>>>>> Instead of repeating the same (un)locking pattern, reuse
>>>>> sock_map_sk_{acquire,release}(). This centralizes the code and makes it
>>>>> easier to adapt sockmap to af_unix-specific locking.
>>>>>
>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>> ---
>>>>>  net/core/sock_map.c | 21 +++++++--------------
>>>>>  1 file changed, 7 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>>>>> index 02a68be3002a..7ba6a7f24ccd 100644
>>>>> --- a/net/core/sock_map.c
>>>>> +++ b/net/core/sock_map.c
>>>>> @@ -353,11 +353,9 @@ static void sock_map_free(struct bpf_map *map)
>>>>>                 sk = xchg(psk, NULL);
>>>>>                 if (sk) {
>>>>>                         sock_hold(sk);
>>>>> -                       lock_sock(sk);
>>>>> -                       rcu_read_lock();
>>>>> +                       sock_map_sk_acquire(sk);
>>>>>                         sock_map_unref(sk, psk);
>>>>> -                       rcu_read_unlock();
>>>>> -                       release_sock(sk);
>>>>> +                       sock_map_sk_release(sk);
>>>>>                         sock_put(sk);
>>>>>                 }
>>>>>         }
>>>>> @@ -1176,11 +1174,9 @@ static void sock_hash_free(struct bpf_map *map)
>>>>>                  */
>>>>>                 hlist_for_each_entry_safe(elem, node, &unlink_list, node) {
>>>>>                         hlist_del(&elem->node);
>>>>> -                       lock_sock(elem->sk);
>>>>> -                       rcu_read_lock();
>>>>> +                       sock_map_sk_acquire(elem->sk);
>>>>>                         sock_map_unref(elem->sk, elem);
>>>>> -                       rcu_read_unlock();
>>>>> -                       release_sock(elem->sk);
>>>>> +                       sock_map_sk_release(elem->sk);
>>>>>                         sock_put(elem->sk);
>>>>>                         sock_hash_free_elem(htab, elem);
>>>>>                 }
>>>>> @@ -1676,8 +1672,7 @@ void sock_map_close(struct sock *sk, long timeout)
>>>>>         void (*saved_close)(struct sock *sk, long timeout);
>>>>>         struct sk_psock *psock;
>>>>>
>>>>> -       lock_sock(sk);
>>>>> -       rcu_read_lock();
>>>>> +       sock_map_sk_acquire(sk);
>>>>>         psock = sk_psock(sk);
>>>>>         if (likely(psock)) {
>>>>>                 saved_close = psock->saved_close;
>>>>> @@ -1685,16 +1680,14 @@ void sock_map_close(struct sock *sk, long timeout)
>>>>>                 psock = sk_psock_get(sk);
>>>>>                 if (unlikely(!psock))
>>>>>                         goto no_psock;
>>>>> -               rcu_read_unlock();
>>>>>                 sk_psock_stop(psock);
>>>>> -               release_sock(sk);
>>>>> +               sock_map_sk_release(sk);
>>>>
>>>> I think sk_psock_stop() was intentionally put outside
>>>> of rcu_read_lock() to not extend the grace period
>>>> unnecessarily. e.g. while + __sk_msg_free().
>>>>
>>>> Maybe add __sock_map_sk_release() without
>>>> rcu_read_unlock() ?
>>>
>>> How about dropping this patch completely? The more I stare at it, I see no
>>> reason why af_unix state lock would matter in any of these places.
>>
>> I agree.  Actually, once it's held, it can be released right away.
>> The lock is only to ensure that peer is set after checking
>> TCP_ESTABLISHED, but it continues holding unix_state_lock()
>> unnecessarily long.
>>
>> Honestly I prefer Martin's idea, using unix_peer_get() in
>> unix_stream_bpf_update_proto().
> 
> Pondering again, I'm leaning to towards my initial approach,
> just null check for peer, which allows bpf_iter to acquire
> unix_state_lock() and make sure the socket is alive.
> (still lock_sock() is needed for bpf_setsockopt())
> 
> The check is lightweight and SOCKMAP does not need to
> hold the lock unnecessarily, and we can provide stable
> result to bpf_iter.

Right, unix_state_lock() would keep the unix sock state. But is keeping the
unix state that important in the context of bpf iter?

> IOW, if we hold unix_state_lock() in the SOCKMAP path
> (even unix_peer_get()), we cannot use unix_state_lock()
> for bpf_iter and lose stability since it will trigger dead lock.

Assuming the answer to the question above is "not really", I'd say taking
unix_state_lock() during sockmap update (both bpf and non-bpf context)
makes sense for 2 reasons:

1. Fulfil sockmap's locking expectation as Martin pointed out; once the
state lock is taken, no need to (additionally) protected against
null-ptr-deref during sock_map_update_elem_sys().

2. Slightly better handle the case of unix sock changing state unexpectedly
_while_ it is being placed in a sockmap by sock_map_update_elem(). At least
for now; in the follow up series we may be able to get rid of (or
simplify?) sock_map_sk_{acquire,release}_fast().

So, what I'm saying is: let's drop changes touching sock_map_free(),
sock_hash_free(), sock_map_close() (this patch), stick to lock_sock-only
unix iter, for non-bpf-context update take the unix state lock (in series
with lock_sock() per your suggestion) which tackles the null-ptr-deref, and
for bpf-context update let's follow what's currently happening for
non-af_unix socks: take the unix state spinlock.

This would boil down to:

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 02a68be3002a..61d782db614c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/jhash.h>
 #include <linux/sock_diag.h>
+#include <net/af_unix.h>
 #include <net/udp.h>

 struct bpf_stab {
@@ -115,19 +116,45 @@ int sock_map_prog_detach(const union bpf_attr *attr,
enum bpf_prog_type ptype)
 }

 static void sock_map_sk_acquire(struct sock *sk)
-	__acquires(&sk->sk_lock.slock)
 {
 	lock_sock(sk);
+
+	if (sk_is_unix(sk))
+		unix_state_lock(sk);
+
 	rcu_read_lock();
 }

 static void sock_map_sk_release(struct sock *sk)
-	__releases(&sk->sk_lock.slock)
 {
 	rcu_read_unlock();
+
+	if (sk_is_unix(sk))
+		unix_state_unlock(sk);
+
 	release_sock(sk);
 }

+static void sock_map_sk_acquire_fast(struct sock *sk)
+{
+	if (sk_is_unix(sk)) {
+		unix_state_lock(sk);
+	} else {
+		local_bh_disable();
+		bh_lock_sock(sk);
+	}
+}
+
+static void sock_map_sk_release_fast(struct sock *sk)
+{
+	if (sk_is_unix(sk)) {
+		unix_state_unlock(sk);
+	} else {
+		bh_unlock_sock(sk);
+		local_bh_enable();
+	}
+}
+
 static void sock_map_add_link(struct sk_psock *psock,
 			      struct sk_psock_link *link,
 			      struct bpf_map *map, void *link_raw)
@@ -606,16 +633,14 @@ static long sock_map_update_elem(struct bpf_map *map,
void *key,
 	if (!sock_map_sk_is_suitable(sk))
 		return -EOPNOTSUPP;

-	local_bh_disable();
-	bh_lock_sock(sk);
+	sock_map_sk_acquire_fast(sk);
 	if (!sock_map_sk_state_allowed(sk))
 		ret = -EOPNOTSUPP;
 	else if (map->map_type == BPF_MAP_TYPE_SOCKMAP)
 		ret = sock_map_update_common(map, *(u32 *)key, sk, flags);
 	else
 		ret = sock_hash_update_common(map, key, sk, flags);
-	bh_unlock_sock(sk);
-	local_bh_enable();
+	sock_map_sk_release_fast(sk);
 	return ret;
 }


