Return-Path: <netdev+bounces-264580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LuZN7gUqmnFKgEAu9opvQ
	(envelope-from <netdev+bounces-264580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:41:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CDA2196CE
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E60D31A7AC5
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 23:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9136997A;
	Thu,  5 Mar 2026 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="vRFIZhJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671D36920F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753527; cv=none; b=WvLSxWWA+nQ5O3EvIkVC5GTjhrfD+7LxPCev1wI2UKjGDtRlnd69doOrwtDGfDaOczWAlS8N5SkyW2Syn7NDMpnN0mVKEzgLhvvyv1YbjeOQvoGZoG2LlbBDolxQvqVWhLD1hxaEjzqfqDG0A872mhDBDuyKphuqaUrki++RQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753527; c=relaxed/simple;
	bh=ZQr+WTwSnte7ugmiliHwL9asahOJBYvUnHt5xYlz2Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmyh517kNz2T/IxSuLyNT81mHqxV6YQwzlVKKADiBH4eLriUCzW2YNzFSzUGPhKQOntsD/z5rzbvfcgT4wkA+QdPwjzVrhG92ZswFpsLJ8r8GeRuFtULqlmNYej8dFIm79xGr5NbXf80kTwy5VqEBXGmommf3QlSVVdHVwzKBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=vRFIZhJJ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vyIAg-00EUer-Tt; Fri, 06 Mar 2026 00:31:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=sSLGc2cwazj/BaeN56d1lulum1UQWYpoeFSBe7HE8yA=; b=vRFIZhJJcAGnOJWZcaWpLMUK3U
	s7g9UQCDGwOLLGkT1dnmH0FT7D7mFULlJ3yOf6Aa7NgkQWetTYzR+r3abBqx3lAJILtcQaaXg1u3z
	kYj0X9ooz8MLrgo29U9M3MsKVISHyjRYm9tJV5+YuAQVuGEHx9M/SCKuUq3jiVuLGfjKFI93ogi+6
	7zjjjSavw8dZvTVvJduKT5NS8uqQ1cjZr6aENxdEDFP/zT56ZOEXmzaYfg/GFFLEXT1244EGOXoRU
	3GfvUCLQSr9bR2vbvOGYoXb1mREQxvsXpfp3qRI3V8fVeZgpB1Cm19wl/ndCsOSU2TCbjaiAb14bp
	AyDWWEyw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vyIAg-00024o-AK; Fri, 06 Mar 2026 00:31:58 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIAJ-00141B-1j; Fri, 06 Mar 2026 00:31:35 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 06 Mar 2026 00:30:56 +0100
Subject: [PATCH bpf v3 2/5] bpf, sockmap: Use
 sock_map_sk_{acquire,release}() where open-coded
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
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
X-Rspamd-Queue-Id: 89CDA2196CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264580-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rbox.co:dkim,rbox.co:email,rbox.co:mid]
X-Rspamd-Action: no action

Instead of repeating the same (un)locking pattern, reuse
sock_map_sk_{acquire,release}(). This centralizes the code and makes it
easier to adapt sockmap to af_unix-specific locking.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 02a68be3002a..7ba6a7f24ccd 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -353,11 +353,9 @@ static void sock_map_free(struct bpf_map *map)
 		sk = xchg(psk, NULL);
 		if (sk) {
 			sock_hold(sk);
-			lock_sock(sk);
-			rcu_read_lock();
+			sock_map_sk_acquire(sk);
 			sock_map_unref(sk, psk);
-			rcu_read_unlock();
-			release_sock(sk);
+			sock_map_sk_release(sk);
 			sock_put(sk);
 		}
 	}
@@ -1176,11 +1174,9 @@ static void sock_hash_free(struct bpf_map *map)
 		 */
 		hlist_for_each_entry_safe(elem, node, &unlink_list, node) {
 			hlist_del(&elem->node);
-			lock_sock(elem->sk);
-			rcu_read_lock();
+			sock_map_sk_acquire(elem->sk);
 			sock_map_unref(elem->sk, elem);
-			rcu_read_unlock();
-			release_sock(elem->sk);
+			sock_map_sk_release(elem->sk);
 			sock_put(elem->sk);
 			sock_hash_free_elem(htab, elem);
 		}
@@ -1676,8 +1672,7 @@ void sock_map_close(struct sock *sk, long timeout)
 	void (*saved_close)(struct sock *sk, long timeout);
 	struct sk_psock *psock;
 
-	lock_sock(sk);
-	rcu_read_lock();
+	sock_map_sk_acquire(sk);
 	psock = sk_psock(sk);
 	if (likely(psock)) {
 		saved_close = psock->saved_close;
@@ -1685,16 +1680,14 @@ void sock_map_close(struct sock *sk, long timeout)
 		psock = sk_psock_get(sk);
 		if (unlikely(!psock))
 			goto no_psock;
-		rcu_read_unlock();
 		sk_psock_stop(psock);
-		release_sock(sk);
+		sock_map_sk_release(sk);
 		cancel_delayed_work_sync(&psock->work);
 		sk_psock_put(sk, psock);
 	} else {
 		saved_close = READ_ONCE(sk->sk_prot)->close;
 no_psock:
-		rcu_read_unlock();
-		release_sock(sk);
+		sock_map_sk_release(sk);
 	}
 
 	/* Make sure we do not recurse. This is a bug.

-- 
2.52.0


