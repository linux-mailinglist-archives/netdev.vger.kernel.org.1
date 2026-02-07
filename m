Return-Path: <netdev+bounces-257789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMCCABK2h2k6cQQAu9opvQ
	(envelope-from <netdev+bounces-257789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 23:00:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD07107403
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 23:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E54033014653
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 22:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEAD30102C;
	Sat,  7 Feb 2026 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diBcCVa4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109A46BF
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770501646; cv=pass; b=b3mTnFPO7n9VHwTMC8hnpPADqilIEJfmh9SqhyvL3Gk7PueEVX9jFmE8SA3AJag0QlwdfmqzZLWoCQ2rz36OenJNdi0xiQcz4K9RYRuN4/mrh5VtNT7CUfDL1JwzWIN7IRyKsRownycwTdgyz5e0E4JSMLf8/DlHHgA6Y1Yue3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770501646; c=relaxed/simple;
	bh=JDXfqM338ohvB1O9rA0vcFQqdt+sfLaxVbYRueQmL8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnaU6n1MlM2+LC3jJuQkyp4MMqMOyhfsJ3R860RDemCobSShmkAZuRb8xjzfPtFETDnrZfDojOIIbeMwrsLQ6Ub8fvk+0a93o51Jy17OPnz3k7lSMNPQB/nzafLOvDadwV76staxLxIr6gISWl5OIc4l78H6+GMkfMnhn5zcJ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=diBcCVa4; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12713e56abdso219387c88.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 14:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770501646; cv=none;
        d=google.com; s=arc-20240605;
        b=lw1m5TmWrN4Wfhum8hQ3xDv/qhkdTYPx0iaZiZECnarOQZx1WogHOLmwehrP4Mrpru
         l+e4fbrFUIkN1FbcR8/Kav6OTpHvVcRmAibujqtY6NqNylgDwtX5PccXW3+ocqdJeXs/
         vhuaFHswkB6neyFLPHRMqfNVA6j0OYBAPkpSJVRhOBkPt98X8baE7aMAGOKHhY85Thwj
         4VAlp1dzo6s3AcG+26O1xv0DQWm2U/Z1IMYcYfn537s01ZLBYDP5F7LWZRmi+Z87R56R
         +1pwzMPDpPKhq0qs0MzfHpfxomvIUFxdMoR9i5ewqu1G0KNWI7kWBa2HiOf9lYu5ZOsu
         tuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1lbuS73M4nRAMSUMQkgHo/xlGfKNIQW3qCJPmnbJ+uc=;
        fh=rLQrMLjBeYdkEY8I1OjVTOSfm9pyhrEJdShw8Kvz6z4=;
        b=VYtFkqotWxkzXYvZ7a8sS5/D1mqbTFhwFtxKGJMF8qyvgP5BlXekcxcJjqm51jWKVE
         4cY/zvOBi8nTqk2JOXen99BvwrC5yX/OXXH7kKzPUgvMRfwBp4ycYchKwUi8k0SGXW5N
         XLJIjdzzyzPFU0tqTljsTbuMV4eTH33r5FSuazvDxTXt4CQI5Z2x682qHyqZIdpvT1S7
         yhRpusDNsZZMSXn09zRpA/KrQ5h9O7VOx0b2J11bXRiwUmJuWF3wPTZfnzfDq3rYN6dJ
         JjZdm/RB0ztlbD2WfxMhRzxZ89PBGF3st8pg1g6967dRp9tz0l0W3U4oaD4uPdoXAvGw
         Imqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770501646; x=1771106446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lbuS73M4nRAMSUMQkgHo/xlGfKNIQW3qCJPmnbJ+uc=;
        b=diBcCVa42dcqTlGFWSsbHkJ9QMaFFXxrX7rOhCie5vMTNI34f+ep0IPPwYbXS+EEFc
         xuoCrRdR8R3tCy9p/vpBWKj2matoRcNU+9acpvUKmwaHGR25U3Tpg3eRoMx9frD+tuTh
         errHgwlKwsX998yrVFV45whsLwRqitDyFeGNNlxPhCOeqPSJHiGfw5KvSqBKnvH6lp++
         HXz5kbmWxQnaBDRltiGKQjBz243n1AxwUNkLxwJM2n6R/xcem7jCuowilHH/5YO/s4OZ
         30OJTyBTASwqSEg4His8Vx9j1Bb5O3VoVyXZXx6TdVU+2v1mvVv3SixCk1T29NVHN9Wd
         onFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770501646; x=1771106446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1lbuS73M4nRAMSUMQkgHo/xlGfKNIQW3qCJPmnbJ+uc=;
        b=oZAMPf0WDMuIgLW5vMyQadpLbWFgiGDvnnzeNH4AMMBDyCB3CmMEtjrY2qU0yuVskx
         zgGsrFZuO2EF1FKtTExsFn2Ys+a16CIA4RCkjnGl1qvozLcx/dRdBVdU2UPpPJLONobV
         yWd55xLsyZy+0/uv4/4GSM+EVnj+xf04r0SwNeK2tJUjN9d21Ai/JlWeR4Y1+umscY0T
         +Q2ZFL6sIWZVaobkN66yAgaGR/V8HJ6jItIOVbQuXWA7DKvIHtwO6mGHJFyu2nF8Su0c
         jiLVxqig1TFsrgQDqwyEgt9D+lBCktTdPwzU2TjxJ6tryEgl0ParhDcLcJkWku4CwPeR
         mbGA==
X-Forwarded-Encrypted: i=1; AJvYcCVoNcIPdAyZ0SjOg5UP0PrRU7BoIRZP2w1IM71oVbym56ufnOSTH63ajbnOJkAQVlbWZjUfDa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7/8iUhx7uYzNKnoGM4cnRUs4iaPvTJ8VHSxQEhVByYZ+62fm
	oaZr3c+znLUbh2YyiOn+ThEvhRoBz5xweAX2kpn4Hqv4atqDTSjbrhByi4BuyOScxpzrav/0yNV
	/d6nUslzoBoGqM2+X9Frp+WtWRmQpgcskq8L+Gqqz
X-Gm-Gg: AZuq6aKSi3Ev0oGRtIj7p0BRZnENrT11p19DpKPAepNIxXcGF4pdhdkqGGA+HcX0qnG
	pThYXFWVvCaOSvBuoP1xsbvCTHIDgI/icVd94i+kNAJQqeS/UwbsW5Id87zIiXvIZo+/ys49sDS
	VvChNWqQl7rWSWbKqdiSD30amLntHL9Bip7nUSx4JeSAwNcn5ftjX6yQF+tlyCajos+VE4gu5Ap
	4UnOV2GDEo9MCcXHKdZhMESu9lb6iqk4k3xjs+l9328w1nDf6jUESJdpFU/SbrBAqOAnzpV1FSd
	UAxGwkITo8zjyDlzgpfWglCikXBRGy9ITJqgU085kvrrdFvJehGriGu2167y
X-Received: by 2002:a05:7022:6894:b0:119:e569:f865 with SMTP id
 a92af1059eb24-12703f17080mr3211761c88.2.1770501645337; Sat, 07 Feb 2026
 14:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
 <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
In-Reply-To: <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Feb 2026 14:00:34 -0800
X-Gm-Features: AZwV_Qhu3MPuQb3J9B5R5j7S51Pywg9lHfEECqmBAAcVo3Fs_Cs-5RFQ9cfaiIc
Message-ID: <CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific lock
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Willem de Bruijn <willemb@google.com>, 
	Cong Wang <cong.wang@bytedance.com>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257789-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,bytedance.com,fb.com,linux.dev,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4BD07107403
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 6:35=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> unix_stream_connect() sets sk_state (`WRITE_ONCE(sk->sk_state,
> TCP_ESTABLISHED)`) _before_ it assigns a peer (`unix_peer(sk) =3D newsk`)=
.
> sk_state =3D=3D TCP_ESTABLISHED makes sock_map_sk_state_allowed() believe=
 that
> socket is properly set up, which would include having a defined peer. IOW=
,
> there's a window when unix_stream_bpf_update_proto() can be called on
> socket which still has unix_peer(sk) =3D=3D NULL.
>
>           T0 bpf                            T1 connect
>           ------                            ----------
>
>                                 WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
> sock_map_sk_state_allowed(sk)
> ...
> sk_pair =3D unix_peer(sk)
> sock_hold(sk_pair)
>                                 sock_hold(newsk)
>                                 smp_mb__after_atomic()
>                                 unix_peer(sk) =3D newsk
>
> BUG: kernel NULL pointer dereference, address: 0000000000000080
> RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
> Call Trace:
>   sock_map_link+0x564/0x8b0
>   sock_map_update_common+0x6e/0x340
>   sock_map_update_elem_sys+0x17d/0x240
>   __sys_bpf+0x26db/0x3250
>   __x64_sys_bpf+0x21/0x30
>   do_syscall_64+0x6b/0x3a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Initial idea was to move peer assignment _before_ the sk_state update[1],
> but that involved an additional memory barrier, and changing the hot path
> was rejected. Then a check during proto update was considered[2], but a
> follow-up discussion[3] concluded the root cause is sockmap taking a wron=
g
> lock.
>
> Thus, teach sockmap about the af_unix-specific locking: instead of the
> usual lock_sock() involving sock::sk_lock, af_unix protects critical
> sections under unix_state_lock() operating on unix_sock::lock.
>
> [1]: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@=
rbox.co/
> [2]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.=
com/
> [3]: https://lore.kernel.org/netdev/7603c0e6-cd5b-452b-b710-73b64bd9de26@=
linux.dev/
>
> This patch also happens to fix a deadlock that may occur when
> bpf_iter_unix_seq_show()'s lock_sock_fast() takes the fast path and the
> iter prog attempts to update a sockmap. Which ends up spinning at
> sock_map_update_elem()'s bh_lock_sock():

Hmm.. this seems to be a more general problem for
bpf iter vs sockmap.  bpf_iter_{tcp,udp}_seq_show() also
hold lock_sock(),  where this patch's solution does not help.
We need to resolve this regardless of socket family.

Also, I feel lock_sock() should be outside of unix_state_lock()
since the former is usually sleepable.  If we used such locking
order in the future, it would trigger ABBA deadlock and we would
have to revisit this problem.



>
> WARNING: possible recursive locking detected
> --------------------------------------------
> test_progs/1393 is trying to acquire lock:
> ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: sock_map_update_elem+0x=
db/0x1f0
>
> but task is already holding lock:
> ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0x37/0=
xe0
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(slock-AF_UNIX);
>   lock(slock-AF_UNIX);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 4 locks held by test_progs/1393:
>  #0: ffff88814b59c790 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x59/0x10d=
0
>  #1: ffff88811ec25fd8 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: bpf_seq_read+0x4=
2c/0x10d0
>  #2: ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0=
x37/0xe0
>  #3: ffffffff85a6a7c0 (rcu_read_lock){....}-{1:3}, at: bpf_iter_run_prog+=
0x51d/0xb00
>
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_deadlock_bug.cold+0xc0/0xce
>  __lock_acquire+0x130f/0x2590
>  lock_acquire+0x14e/0x2b0
>  _raw_spin_lock+0x30/0x40
>  sock_map_update_elem+0xdb/0x1f0
>  bpf_prog_2d0075e5d9b721cd_dump_unix+0x55/0x4f4
>  bpf_iter_run_prog+0x5b9/0xb00
>  bpf_iter_unix_seq_show+0x1f7/0x2e0
>  bpf_seq_read+0x42c/0x10d0
>  vfs_read+0x171/0xb20
>  ksys_read+0xff/0x200
>  do_syscall_64+0x6b/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
> Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domai=
n socket.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Keeping sparse annotations in sock_map_sk_{acquire,release}() required so=
me
> hackery I'm not proud of. Is there a better way?
> ---
>  net/core/sock_map.c | 47 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index b6586d9590b7..0c638b1f363a 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -12,6 +12,7 @@
>  #include <linux/list.h>
>  #include <linux/jhash.h>
>  #include <linux/sock_diag.h>
> +#include <net/af_unix.h>
>  #include <net/udp.h>
>
>  struct bpf_stab {
> @@ -115,17 +116,49 @@ int sock_map_prog_detach(const union bpf_attr *attr=
, enum bpf_prog_type ptype)
>  }
>
>  static void sock_map_sk_acquire(struct sock *sk)
> -       __acquires(&sk->sk_lock.slock)
> +       __acquires(sock_or_unix_lock)
>  {
> -       lock_sock(sk);
> +       if (sk_is_unix(sk)) {
> +               unix_state_lock(sk);
> +               __release(sk); /* Silence sparse. */
> +       } else {
> +               lock_sock(sk);
> +       }
> +
>         rcu_read_lock();
>  }
>
>  static void sock_map_sk_release(struct sock *sk)
> -       __releases(&sk->sk_lock.slock)
> +       __releases(sock_or_unix_lock)
>  {
>         rcu_read_unlock();
> -       release_sock(sk);
> +
> +       if (sk_is_unix(sk)) {
> +               unix_state_unlock(sk);
> +               __acquire(sk); /* Silence sparse. */
> +       } else {
> +               release_sock(sk);
> +       }
> +}
> +
> +static inline void sock_map_sk_acquire_fast(struct sock *sk)
> +{
> +       local_bh_disable();
> +
> +       if (sk_is_unix(sk))
> +               unix_state_lock(sk);
> +       else
> +               bh_lock_sock(sk);
> +}
> +
> +static inline void sock_map_sk_release_fast(struct sock *sk)
> +{
> +       if (sk_is_unix(sk))
> +               unix_state_unlock(sk);
> +       else
> +               bh_unlock_sock(sk);
> +
> +       local_bh_enable();
>  }
>
>  static void sock_map_add_link(struct sk_psock *psock,
> @@ -604,16 +637,14 @@ static long sock_map_update_elem(struct bpf_map *ma=
p, void *key,
>         if (!sock_map_sk_is_suitable(sk))
>                 return -EOPNOTSUPP;
>
> -       local_bh_disable();
> -       bh_lock_sock(sk);
> +       sock_map_sk_acquire_fast(sk);
>         if (!sock_map_sk_state_allowed(sk))
>                 ret =3D -EOPNOTSUPP;
>         else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP)
>                 ret =3D sock_map_update_common(map, *(u32 *)key, sk, flag=
s);
>         else
>                 ret =3D sock_hash_update_common(map, key, sk, flags);
> -       bh_unlock_sock(sk);
> -       local_bh_enable();
> +       sock_map_sk_release_fast(sk);
>         return ret;
>  }
>
>
> --
> 2.52.0
>

