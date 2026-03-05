Return-Path: <netdev+bounces-264583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI8mLhAUqmnFKgEAu9opvQ
	(envelope-from <netdev+bounces-264583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:38:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA6219654
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD8503106B68
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DFE36BCD8;
	Thu,  5 Mar 2026 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="tH/LCiLS"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA536B067;
	Thu,  5 Mar 2026 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753551; cv=none; b=OdHfk+rimrZoqvgPM9MukJEjki1zP6WPcH5KXViYoqq80ZP1AhCnggKlHcsPgQ5gpht07qXgziyyiTJa4m5zRFYk8qR1mS8eOv6E4AJVsNHl+lXT2HOC73wf1h5rT9GVLoH2RVej5wwCf2+mCZYwvkjX4VCfXTFrGDPZL+VIISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753551; c=relaxed/simple;
	bh=bDzbc3ZHCvPBc/hlIDrPvFqAxratovDgZTWCGUKaMcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omfOlkoFiINIBz6iX7D3c+bBd7e0BT4iE07ZWwGld9UQvDg2EYVMOSeaL8OQjLuBlrHV4SDH7o5XXzTNiBw7/qvHZ2Bqz32w3C2JO+5O1Pl1ncA5BzqLhgbYPV7g81LPZjNu7Qvu1yBHPOU/SnErYvmSDWS/bL+FzIO65b3v3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=tH/LCiLS; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vyIB6-00EUkk-AT; Fri, 06 Mar 2026 00:32:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=h3U/vn8cMJy7gTz7S1npXP10+eZWzW20H3DtLHiAKc0=; b=tH/LCiLSZnMna8l28wQy45gYGx
	heYq9n4eqSxv+Hp0y2W2r/r43siFTAT8ZxVnEl9LmxYWl99pDZPqnJXNhBik6PVvszMzJsSbHVYA6
	0Tx4Yv5g1CgrRq7bdOlzIoi30H+jw41KfRkgwq5i7t0umrZmKtKa1Lma5YO00A5XBnWoR+olv5lY4
	4qIDC5KcApNPNdqzGL4Bxime8Ds6d7a/Ya58akhH+moH7gxI5+SW8K8CwltCz0Bjt6N35nA6p6BWN
	ts4+jTmeHzgRV7axQ1S9pH6clP9PnEdOdYwdRnurOjMAHfisiGtMrpp6SBHbXeN8s5tboMfnm3TcR
	ac/Nf6hw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vyIB5-0004DY-VA; Fri, 06 Mar 2026 00:32:24 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIAN-00141B-96; Fri, 06 Mar 2026 00:31:39 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 06 Mar 2026 00:30:59 +0100
Subject: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: C3AA6219654
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
	TAGGED_FROM(0.00)[bounces-264583-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,rbox.co:dkim,rbox.co:email,rbox.co:mid]
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
lock. Or, more specifically, an insufficient lock[4].

Thus, teach sockmap about the af_unix-specific locking: af_unix protects
critical sections under unix_state_lock() operating on unix_sock::lock.

[1]: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co/
[2]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/
[3]: https://lore.kernel.org/netdev/7603c0e6-cd5b-452b-b710-73b64bd9de26@linux.dev/
[4]: https://lore.kernel.org/netdev/CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com/

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 7ba6a7f24ccd..6109fbe6f99c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/jhash.h>
 #include <linux/sock_diag.h>
+#include <net/af_unix.h>
 #include <net/udp.h>
 
 struct bpf_stab {
@@ -115,19 +116,43 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
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
 
+static inline void sock_map_sk_acquire_fast(struct sock *sk)
+{
+	local_bh_disable();
+	bh_lock_sock(sk);
+
+	if (sk_is_unix(sk))
+		unix_state_lock(sk);
+}
+
+static inline void sock_map_sk_release_fast(struct sock *sk)
+{
+	if (sk_is_unix(sk))
+		unix_state_unlock(sk);
+
+	bh_unlock_sock(sk);
+	local_bh_enable();
+}
+
 static void sock_map_add_link(struct sk_psock *psock,
 			      struct sk_psock_link *link,
 			      struct bpf_map *map, void *link_raw)
@@ -604,16 +629,14 @@ static long sock_map_update_elem(struct bpf_map *map, void *key,
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


