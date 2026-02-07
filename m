Return-Path: <netdev+bounces-257765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLdoJiZOh2mjWAQAu9opvQ
	(envelope-from <netdev+bounces-257765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 15:37:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629C106322
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 15:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88CC8304EA6A
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA2352929;
	Sat,  7 Feb 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lIwpbTYL"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75A350D77;
	Sat,  7 Feb 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770474932; cv=none; b=Y/OEYjwZhcqmhzGyqtWJqTEiLa+uTBwjJNz8Q261kFpkyhtUoWg/4tr1f9BLNhNqYaZfC7gzXP3Cc1c1dTeZm0cOZs6gqhd5RbCwKmcQH6DppREHhzac1GXpJqCBKzLWWE951DGhY4btBfx381z7g1BfbtYsBRACUp80Rf/1uns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770474932; c=relaxed/simple;
	bh=qlrHDBtba3vTO/Bn5PxIN6BjuWLrUyUbnIk8fyr4qVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hR3bxq4oRXVhNEmOxRlNpnY1oWKCu1YIbwi8DpSth1vxufMkbtGy9afKuSaXpTKY8jV2Dkc5GAx3ycrJUYE+1rGzh2/pOZkhBOpnjjTG2eTGieEnRYZwgycBWSK7HtSjLLyqiaaBQatAYhdYHi59VsoJjEUCNTtZt50Nf5UFfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lIwpbTYL; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vojPD-00Aj4H-00; Sat, 07 Feb 2026 15:35:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=DX8BCBW2MTYLYee6mM+3hgNqEdhj4yKdeAJaLf3biuc=; b=lIwpbTYLXGC+Wthoc+yHKFo44V
	jC4rVC337/M8TjscPMl4qXimLclxqCxnYnJCfl0ebv3c9jbedjAlKPawhAdXrqKv1tXfhi4HizayM
	850bnokkpLH21fPhMO5WkvjWzRtCGF/Lo8RepcWHHRkB4+DCshqDlZdVjfThdIcyUnQqNEdua3rl8
	5c8VFAYK5RlREiKscmMhJPrIzKFIxsaqET9vhNoxAG+H8xvAEHxAcHR7AQXL+mXudMNGSRwPVBwSs
	Pb+sxzZ07Yk5l/vP6tioaeDt6qWQXJjp1Kb0jet2QJoeetobwzzXTNaXQRXS/5DEVnMBMJ3krBzMj
	FtM+0WJA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vojPC-0005bg-KY; Sat, 07 Feb 2026 15:35:26 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vojOt-006OQ1-Ks; Sat, 07 Feb 2026 15:35:07 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Feb 2026 15:34:56 +0100
Subject: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific
 lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
References: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
In-Reply-To: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Willem de Bruijn <willemb@google.com>, Cong Wang <cong.wang@bytedance.com>, 
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257765-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,bytedance.com,fb.com,linux.dev,fomichev.me];
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
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email,rbox.co:dkim,rbox.co:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 1629C106322
X-Rspamd-Action: no action

unix_stream_connect() sets sk_state (`WRITE_ONCE(sk->sk_state,
TCP_ESTABLISHED)`) _before_ it assigns a peer (`unix_peer(sk) = newsk`).
sk_state == TCP_ESTABLISHED makes sock_map_sk_state_allowed() believe that
socket is properly set up, which would include having a defined peer. IOW,
there's a window when unix_stream_bpf_update_proto() can be called on
socket which still has unix_peer(sk) == NULL.

          T0 bpf                            T1 connect
          ------                            ----------

                                WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
sock_map_sk_state_allowed(sk)
...
sk_pair = unix_peer(sk)
sock_hold(sk_pair)
                                sock_hold(newsk)
                                smp_mb__after_atomic()
                                unix_peer(sk) = newsk

BUG: kernel NULL pointer dereference, address: 0000000000000080
RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
Call Trace:
  sock_map_link+0x564/0x8b0
  sock_map_update_common+0x6e/0x340
  sock_map_update_elem_sys+0x17d/0x240
  __sys_bpf+0x26db/0x3250
  __x64_sys_bpf+0x21/0x30
  do_syscall_64+0x6b/0x3a0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Initial idea was to move peer assignment _before_ the sk_state update[1],
but that involved an additional memory barrier, and changing the hot path
was rejected. Then a check during proto update was considered[2], but a
follow-up discussion[3] concluded the root cause is sockmap taking a wrong
lock.

Thus, teach sockmap about the af_unix-specific locking: instead of the
usual lock_sock() involving sock::sk_lock, af_unix protects critical
sections under unix_state_lock() operating on unix_sock::lock.

[1]: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co/
[2]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/
[3]: https://lore.kernel.org/netdev/7603c0e6-cd5b-452b-b710-73b64bd9de26@linux.dev/

This patch also happens to fix a deadlock that may occur when
bpf_iter_unix_seq_show()'s lock_sock_fast() takes the fast path and the
iter prog attempts to update a sockmap. Which ends up spinning at
sock_map_update_elem()'s bh_lock_sock():

WARNING: possible recursive locking detected
--------------------------------------------
test_progs/1393 is trying to acquire lock:
ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: sock_map_update_elem+0xdb/0x1f0

but task is already holding lock:
ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0x37/0xe0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(slock-AF_UNIX);
  lock(slock-AF_UNIX);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by test_progs/1393:
 #0: ffff88814b59c790 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x59/0x10d0
 #1: ffff88811ec25fd8 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: bpf_seq_read+0x42c/0x10d0
 #2: ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0x37/0xe0
 #3: ffffffff85a6a7c0 (rcu_read_lock){....}-{1:3}, at: bpf_iter_run_prog+0x51d/0xb00

Call Trace:
 dump_stack_lvl+0x5d/0x80
 print_deadlock_bug.cold+0xc0/0xce
 __lock_acquire+0x130f/0x2590
 lock_acquire+0x14e/0x2b0
 _raw_spin_lock+0x30/0x40
 sock_map_update_elem+0xdb/0x1f0
 bpf_prog_2d0075e5d9b721cd_dump_unix+0x55/0x4f4
 bpf_iter_run_prog+0x5b9/0xb00
 bpf_iter_unix_seq_show+0x1f7/0x2e0
 bpf_seq_read+0x42c/0x10d0
 vfs_read+0x171/0xb20
 ksys_read+0xff/0x200
 do_syscall_64+0x6b/0x3a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domain socket.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Keeping sparse annotations in sock_map_sk_{acquire,release}() required some
hackery I'm not proud of. Is there a better way?
---
 net/core/sock_map.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index b6586d9590b7..0c638b1f363a 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/jhash.h>
 #include <linux/sock_diag.h>
+#include <net/af_unix.h>
 #include <net/udp.h>
 
 struct bpf_stab {
@@ -115,17 +116,49 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
 }
 
 static void sock_map_sk_acquire(struct sock *sk)
-	__acquires(&sk->sk_lock.slock)
+	__acquires(sock_or_unix_lock)
 {
-	lock_sock(sk);
+	if (sk_is_unix(sk)) {
+		unix_state_lock(sk);
+		__release(sk); /* Silence sparse. */
+	} else {
+		lock_sock(sk);
+	}
+
 	rcu_read_lock();
 }
 
 static void sock_map_sk_release(struct sock *sk)
-	__releases(&sk->sk_lock.slock)
+	__releases(sock_or_unix_lock)
 {
 	rcu_read_unlock();
-	release_sock(sk);
+
+	if (sk_is_unix(sk)) {
+		unix_state_unlock(sk);
+		__acquire(sk); /* Silence sparse. */
+	} else {
+		release_sock(sk);
+	}
+}
+
+static inline void sock_map_sk_acquire_fast(struct sock *sk)
+{
+	local_bh_disable();
+
+	if (sk_is_unix(sk))
+		unix_state_lock(sk);
+	else
+		bh_lock_sock(sk);
+}
+
+static inline void sock_map_sk_release_fast(struct sock *sk)
+{
+	if (sk_is_unix(sk))
+		unix_state_unlock(sk);
+	else
+		bh_unlock_sock(sk);
+
+	local_bh_enable();
 }
 
 static void sock_map_add_link(struct sk_psock *psock,
@@ -604,16 +637,14 @@ static long sock_map_update_elem(struct bpf_map *map, void *key,
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
 

-- 
2.52.0


