Return-Path: <netdev+bounces-278501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CmcKGtb3mkyCQAAu9opvQ
	(envelope-from <netdev+bounces-278501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:21:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93FF3FBAEA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90594307AA47
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604F3E958D;
	Tue, 14 Apr 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="I6KproVw"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE31DF73A;
	Tue, 14 Apr 2026 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179914; cv=none; b=MIIbgrLqXTijieedkqkkBBaL9HOkG+2buZsxQA0zYz7PgMUIP0nI5aayUwzKX1l6hQlKoLT14Zlow8aTGhrjkcaBdVq7r+KITLZj08FN3j/nBqqLsK6r4t0PWjuFPkwlOsQ/3/G5lnAEYtBcmKwf8Dy/qsoYZ017cTHhKW/oW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179914; c=relaxed/simple;
	bh=p8Zy4nEBkR+9ygIdN12Yw4cEGuBqrwNG0zv+nsgBx1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWp4e0FetAaQfZilveUxga7Xt1IVL+ixOBNi6926kcS68qqn/wi42b244PfUFzop7T5Zu+yaMecAmdXXaond2lUbMzxb2NeHeMmdAWK3NBiGZXuhQBULH8SOLxDgXn2Mfe/eNi2sVlqeELn0+h7PWWj0Y/B5pOwKAu9/TMkXp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=I6KproVw; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWJ-00Fdpt-Nn; Tue, 14 Apr 2026 16:13:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=X2qj25w98WiHnwStskIYNOIACWJIKBz1Po4lV2H/JLA=; b=I6KproVwiOhp3VkHnpZ4puOYjM
	jKpsGVpJbMxuZqvrxuHCMXyXTQfaKrPISdyNIQRYV9QMuHwyJ6Ghdg6G8a1akSCYg1+ufMdLCZp2Z
	UIilcls5V1RJJ4R+B79hmzYUk9uZxU/Xb1uvuuWqSDmOjWPmZEfDUYgrf8aKzn3pXLevKjmnXvc3B
	dLIYQU1/ExoUVMtumBvM/yeMVU5SmJoosBwO5ZYXjqZYncQwBfHuBDVxTQLggP8pkOk0mSC7JQtlN
	CPLJPm5Nusx1R+o0y4n3z5IFzbyvGi/KFHkTYRlyg6P2c1037Nx4I+e8KXQVUo86ZLVCiDNeVnDdn
	9bg+S5jQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWI-0001rb-Ku; Tue, 14 Apr 2026 16:13:38 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wCeWE-00DhbX-8g; Tue, 14 Apr 2026 16:13:34 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 14 Apr 2026 16:13:18 +0200
Subject: [PATCH bpf v4 4/5] bpf, sockmap: Fix af_unix null-ptr-deref in
 proto update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260414-unix-proto-update-null-ptr-deref-v4-4-2af6fe97918e@rbox.co>
References: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
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
 Michal Luczaj <mhal@rbox.co>, 
 =?utf-8?q?=E9=92=B1=E4=B8=80=E9=93=AD?= <yimingqian591@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278501-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,rbox.co,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rbox.co:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email,rbox.co:dkim,rbox.co:mid,linux.dev:email]
X-Rspamd-Queue-Id: E93FF3FBAEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

unix_stream_connect() sets sk_state (`WRITE_ONCE(sk->sk_state,
TCP_ESTABLISHED)`) _before_ it assigns a peer (`unix_peer(sk) = newsk`).
sk_state == TCP_ESTABLISHED makes sock_map_sk_state_allowed() believe that
socket is properly set up, which would include having a defined peer. IOW,
there's a window when unix_stream_bpf_update_proto() can be called on
socket which still has unix_peer(sk) == NULL.

         CPU0 bpf                            CPU1 connect
         --------                            ------------

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
was rejected.
Then a NULL check during proto update in unix_stream_bpf_update_proto() was
considered[2], but the follow-up discussion[3] focused on the root cause,
i.e. sockmap update taking a wrong lock. Or, more specifically, missing
unix_state_lock()[4].
In the end it was concluded that teaching sockmap about the af_unix locking
would be unnecessarily complex[5].
Complexity aside, since BPF_PROG_TYPE_SCHED_CLS and BPF_PROG_TYPE_SCHED_ACT
are allowed to update sockmaps, sock_map_update_elem() taking the unix
lock, as it is currently implemented in unix_state_lock():
spin_lock(&unix_sk(s)->lock), would be problematic. unix_state_lock() taken
in a process context, followed by a softirq-context TC BPF program
attempting to take the same spinlock -- deadlock[6].
This way we circled back to the peer check idea[2].

[1]: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co/
[2]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/
[3]: https://lore.kernel.org/netdev/7603c0e6-cd5b-452b-b710-73b64bd9de26@linux.dev/
[4]: https://lore.kernel.org/netdev/CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com/
[5]: https://lore.kernel.org/bpf/CAAVpQUAHijOMext28Gi10dSLuMzGYh+jK61Ujn+fZ-wvcODR2A@mail.gmail.com/
[6]: https://lore.kernel.org/bpf/dd043c69-4d03-46fe-8325-8f97101435cf@linux.dev/

Summary of scenarios where af_unix/stream connect() may race a sockmap
update:

1. connect() vs. bpf(BPF_MAP_UPDATE_ELEM), i.e. sock_map_update_elem_sys()

   Implemented NULL check is sufficient. Once assigned, socket peer won't
   be released until socket fd is released. And that's not an issue because
   sock_map_update_elem_sys() bumps fd refcnf.

2. connect() vs BPF program doing update

   Update restricted per verifier.c:may_update_sockmap() to

      BPF_PROG_TYPE_TRACING/BPF_TRACE_ITER
      BPF_PROG_TYPE_SOCK_OPS (bpf_sock_map_update() only)
      BPF_PROG_TYPE_SOCKET_FILTER
      BPF_PROG_TYPE_SCHED_CLS
      BPF_PROG_TYPE_SCHED_ACT
      BPF_PROG_TYPE_XDP
      BPF_PROG_TYPE_SK_REUSEPORT
      BPF_PROG_TYPE_FLOW_DISSECTOR
      BPF_PROG_TYPE_SK_LOOKUP

   Plus one more race to consider:

            CPU0 bpf                            CPU1 connect
            --------                            ------------

                                   WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
   sock_map_sk_state_allowed(sk)
                                   sock_hold(newsk)
                                   smp_mb__after_atomic()
                                   unix_peer(sk) = newsk
   sk_pair = unix_peer(sk)
   if (unlikely(!sk_pair))
      return -EINVAL;

                                                 CPU1 close
                                                 ----------

                                   skpair = unix_peer(sk);
                                   unix_peer(sk) = NULL;
                                   sock_put(skpair)
   // use after free?
   sock_hold(sk_pair)

   2.1 BPF program invoking helper function bpf_sock_map_update() ->
       BPF_CALL_4(bpf_sock_map_update(), ...)

       Helper limited to BPF_PROG_TYPE_SOCK_OPS. Nevertheless, a unix sock
       might be accessible via bpf_map_lookup_elem(). Which implies sk
       already having psock, which in turn implies sk already having
       sk_pair. Since sk_psock_destroy() is queued as RCU work, sk_pair
       won't go away while BPF executes the update.

   2.2 BPF program invoking helper function bpf_map_update_elem() ->
       sock_map_update_elem()

       2.2.1 Unix sock accessible to BPF prog only via sockmap lookup in
             BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_SCHED_CLS,
             BPF_PROG_TYPE_SCHED_ACT, BPF_PROG_TYPE_XDP,
             BPF_PROG_TYPE_SK_REUSEPORT, BPF_PROG_TYPE_FLOW_DISSECTOR,
             BPF_PROG_TYPE_SK_LOOKUP.

             Pretty much the same as case 2.1.

       2.2.2 Unix sock accessible to BPF program directly:
             BPF_PROG_TYPE_TRACING, narrowed down to BPF_TRACE_ITER.

             Sockmap iterator (sock_map_seq_ops) is safe: unix sock
             residing in a sockmap means that the sock already went through
             the proto update step.

             Unix sock iterator (bpf_iter_unix_seq_ops), on the other hand,
             gives access to socks that may still be unconnected. Which
             means iterator prog can race sockmap/proto update against
             connect().

             BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x253/0x4d0
             Write of size 4 at addr 0000000000000080 by task test_progs/3140
             Call Trace:
              dump_stack_lvl+0x5d/0x80
              kasan_report+0xe4/0x1c0
              kasan_check_range+0x125/0x200
              unix_stream_bpf_update_proto+0x253/0x4d0
              sock_map_link+0x71c/0xec0
              sock_map_update_common+0xbc/0x600
              sock_map_update_elem+0x19a/0x1f0
              bpf_prog_bbbf56096cdd4f01_selective_dump_unix+0x20c/0x217
              bpf_iter_run_prog+0x21e/0xae0
              bpf_iter_unix_seq_show+0x1e0/0x2a0
              bpf_seq_read+0x42c/0x10d0
              vfs_read+0x171/0xb20
              ksys_read+0xff/0x200
              do_syscall_64+0xf7/0x5e0
              entry_SYSCALL_64_after_hwframe+0x76/0x7e

             While the introduced NULL check prevents null-ptr-deref in the
             BPF program path as well, it is insufficient to guard against
             a poorly timed close() leading to a use-after-free. This will
             be addressed in a subsequent patch.

Reported-by: Michal Luczaj <mhal@rbox.co>
Closes: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co/
Reported-by: 钱一铭 <yimingqian591@gmail.com>
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/unix/unix_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index e0d30d6d22ac..57f3124c9d8d 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -185,6 +185,9 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
 	 */
 	if (!psock->sk_pair) {
 		sk_pair = unix_peer(sk);
+		if (unlikely(!sk_pair))
+			return -EINVAL;
+
 		sock_hold(sk_pair);
 		psock->sk_pair = sk_pair;
 	}

-- 
2.53.0


