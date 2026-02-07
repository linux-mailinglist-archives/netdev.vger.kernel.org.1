Return-Path: <netdev+bounces-257764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB4qEXhOh2mjWAQAu9opvQ
	(envelope-from <netdev+bounces-257764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 15:38:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AAF106356
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 15:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9E13301C91D
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DA3502A7;
	Sat,  7 Feb 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="GvqwWWmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6C34F476;
	Sat,  7 Feb 2026 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770474922; cv=none; b=sV1QtLukgyBKw6TNsvaEZ51tT0p6h8V+VWvAyBXcBNl0HbMvwhBoi356HIDXWctV+8Sw1b38PTVa3ix+gGJNCBQ01QsxAIGeSCMhhmE4AWwn9nnzleX5hncVLF1las4K0MbhvLUM15bE1kokXqsFyDORySwYTi4h4AueibQslT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770474922; c=relaxed/simple;
	bh=IF+whSWHEyl63o5dNlnAmREIs1w6LwjIMd7WB+fF4eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IEVDOvSONjEQ5ipoHCFGW/MoL73/gH0eau49j9g/Tc2AgOaCJXKQRLLtHrvE0T88qRFzomY5OVJ2kZRM1KWanm2/gTWp9nUiDLUUL8yJnAPNZihnTbdkBW6d8n5FODT9RAY3FxO6db5YiIvlTO4XBAsAvMkSRhQYulKS7CkgFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=GvqwWWmZ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vojOv-00Ah2l-6k; Sat, 07 Feb 2026 15:35:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=iiwqZmvHpK4U5djj6CwxOagEF++9Cz/mSVLs8FweoX0=; b=GvqwWWmZw4B8dmUjAsMS3ucBHk
	BmE24LozWYNS/3sbzTpAz1annsr4uMV+MBt2OgxOmV0CRjrxCUqqDCYAVKQrRNA87gQOOqp/wPrQc
	A1ILLfDz+Adrnf5F05OCTsGyXbe1UelTk/VPQCwwx3CiBtI6lHqapV9tWPk42VHlgqxdd0U+ZbG3U
	tL/i2mVebPNwlQxTJwuU0BfP6tlsgQ/cUk9h9mLopDKf4x1TCB+yC2ejvNHgzuFsXDI6Ks/rAkfkN
	/+J1wCQApexGT0QwQX8IPyYYXI2v2mGtfIVjeeYnlnMhqWp0WaR5PFFB1oQbJBBhKiy/j0QabtBJx
	YE7bbl+w==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vojOu-0007TN-Nh; Sat, 07 Feb 2026 15:35:08 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vojOs-006OQ1-B0; Sat, 07 Feb 2026 15:35:06 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Feb 2026 15:34:55 +0100
Subject: [PATCH bpf v2 2/4] bpf, sockmap: Use
 sock_map_sk_{acquire,release}() where open-coded
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260207-unix-proto-update-null-ptr-deref-v2-2-9f091330e7cd@rbox.co>
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
	TAGGED_FROM(0.00)[bounces-257764-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email,rbox.co:dkim,rbox.co:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04AAF106356
X-Rspamd-Action: no action

Instead of repeating the same (un)locking pattern, reuse
sock_map_sk_{acquire,release}(). This centralizes the code and makes it
easier to adapt sockmap to af_unix-specific locking.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index d4f15b846ad4..b6586d9590b7 100644
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


