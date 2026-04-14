Return-Path: <netdev+bounces-278494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEjYLVJc3mlACQAAu9opvQ
	(envelope-from <netdev+bounces-278494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:25:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7A3FBC25
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F03453063A20
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302513E92A1;
	Tue, 14 Apr 2026 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="evp0a+zh"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E66256C61;
	Tue, 14 Apr 2026 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179505; cv=none; b=RauuJlunW/cJdGDrcS5HQjVm7of0ZHjjTi8qc4W/CYk/rNhpm1t4MlVoG7NawnQUUkG6pSHuwYMstErRZvFxqIPlWyLaMC95nTD73D6zn+4h1XDANjTuyQvMorRDTvfsq8xbYn9RSFNalK75+ZCSrR3PzWQx3Xhk7yF3xwN/3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179505; c=relaxed/simple;
	bh=tp2zXVzdAJ5XOEiTCsRkb3jbGLsEwShzGi5kuermpAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gIXO1vhtEZziqhJZBb1wurncAixIbtsSEE4mXLpAlYlR/FhCZ+aT39gYXUVKBgVLfeTD5QD3oYDDeMbWLkrylHNKLo3HHBcP96/gDuzBfCS/ye+vmFEpi7MomNz+qs8f7fvSyzZhW1NHi8eL7Jd0kaYR/T0xSZekndX2iQXFFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=evp0a+zh; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWL-00FB5b-Nm; Tue, 14 Apr 2026 16:13:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=mJIuV1hFcG0AqFmXjuVmJdTq5oqD37Hr+RkhyPIT/fw=; b=evp0a+zhKZ19/tsYUtmJ1rGgiq
	i0W3zfkwG/OaN3LhGGjEC4UXYU4KDsxr9TrXWuP6GuLHX36a4GwBGeb4xusowreSSKEvqZWt9KofG
	D5I+ZPzmEzU3n6XWZo1ZLaW4TcC8IwLcCzCkxOYsbUB9TwM9Jg8Nuw5Jz1QiavTCuYELdwwG98sCs
	QJ1mQCVpJEmZWT+Dg4X7VnOobXBI6YYJPcDIQ0bmbgoiwBAnPAuw5kc83nXfQW4YYLWRfj87AYNNg
	A6JboP87w8dYhJHKqf0DsyQS5BD0Abs/P6MllJ7qFjzVwLrJhPJWHdjLe2rdy2cjx4RxKxIHmIe4T
	Sd4d7rrg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWL-0000Ul-FU; Tue, 14 Apr 2026 16:13:41 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wCeWB-00DhbX-F5; Tue, 14 Apr 2026 16:13:31 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 14 Apr 2026 16:13:16 +0200
Subject: [PATCH bpf v4 2/5] bpf, sockmap: Fix af_unix iter deadlock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-unix-proto-update-null-ptr-deref-v4-2-2af6fe97918e@rbox.co>
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
 Michal Luczaj <mhal@rbox.co>, Jiayuan Chen <jiayuan.chen@linux.dev>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278494-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rbox.co:email,rbox.co:dkim,rbox.co:mid,linux.dev:email]
X-Rspamd-Queue-Id: 32A7A3FBC25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bpf_iter_unix_seq_show() may deadlock when lock_sock_fast() takes the fast
path and the iter prog attempts to update a sockmap. Which ends up spinning
at sock_map_update_elem()'s bh_lock_sock():

WARNING: possible recursive locking detected
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
Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domain socket.")
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/unix/af_unix.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b23c33df8b46..590a30d3b2f7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3731,15 +3731,14 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 	struct bpf_prog *prog;
 	struct sock *sk = v;
 	uid_t uid;
-	bool slow;
 	int ret;
 
 	if (v == SEQ_START_TOKEN)
 		return 0;
 
-	slow = lock_sock_fast(sk);
+	lock_sock(sk);
 
-	if (unlikely(sk_unhashed(sk))) {
+	if (unlikely(sock_flag(sk, SOCK_DEAD))) {
 		ret = SEQ_SKIP;
 		goto unlock;
 	}
@@ -3749,7 +3748,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 	prog = bpf_iter_get_info(&meta, false);
 	ret = unix_prog_seq_show(prog, &meta, v, uid);
 unlock:
-	unlock_sock_fast(sk, slow);
+	release_sock(sk);
 	return ret;
 }
 

-- 
2.53.0


