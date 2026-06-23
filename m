Return-Path: <netdev+bounces-301348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HNU0GP9rOmrB8gcAu9opvQ
	(envelope-from <netdev+bounces-301348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:20:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9F6B6A73
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:20:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=T3K4jyEw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301348-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301348-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B6A4303CEC9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E50D3C769F;
	Tue, 23 Jun 2026 11:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82568298CAF
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 11:20:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213626; cv=none; b=S7SlkQhOcaGKfhoZo8CAjnTwYeBK8EpDu1ifbomZtVr5QCl3e7e2kFG6chpoKVxXZpfLxvAtcBhJlI8Bp4OBLM4W3ymFFgJyLzMIQe/r5nfDDAV1Pt7fZg73aNmo+rqGB30Q3xjf35LN8sCpP5qoM3rk5fWDSt9zNPxWWfwwi3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213626; c=relaxed/simple;
	bh=WpUspO+Gz3+m31nHLT5NVtXRWZab4kvM0luKnWbl/Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eelUxWMEKwBUZO/9AvVkvq8UN83O0sQJx25PLlV3PBcLuwVtRwIQdLRj4i4owi7W6gz+gSSH2V/QSEHjrExHk4XB3NXna3MJPsAjMOjY+1M1W7s3J0tERV5zO9jf4dhHIGRNuSx2cFO9Y/GzjPRbGaaQBdtgaTjNqT4Ud5C/DQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T3K4jyEw; arc=none smtp.client-ip=209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c0efc7ef797so313693666b.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782213623; x=1782818423; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elaSjIGfSwH+Wak0Gp5qRHdd7cauBRR9ppc4J3/+sDI=;
        b=T3K4jyEwW4oa51y28Sbb6tBMcMT7v6VIIdTSepFcgpuaiyWy1swERl6KFQFCHzhyZM
         B76KODWyQLS30ZKWAGDegAI2Pnu+Q2ANPPYtxK/J42+wTLsR0MNlgBRSj7e/TJ4Qi8iL
         3H/3o1TKygR7CXYo3RrD9FFx1hSyrTeRhbcC3+COTqUPJDyLeb4wrllr/ICoZGXuPJ3L
         FKboSsW345HfgFBN8sWcA9mWYREVSxEg/XN7iONa9XkAsEAWDbkAld3fjABVBeBWYC1y
         xnqXroTlV4bW/q6VMrhHV8S82xiEiwKOe9gkPNHGUtYrtqogjAhjd4hQzHW0CgiZTZ4w
         OpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213623; x=1782818423;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elaSjIGfSwH+Wak0Gp5qRHdd7cauBRR9ppc4J3/+sDI=;
        b=pP+Zb/G5OP0tlWOD3eEPuCFX+8xW3LVsqntKtczwGYP9k3R5oSS/EIzsDk/QyK1mJK
         bLqGKaBZiAingFwMfUTjwz8Cbkc4LcfX5RGcEpeoV0VFQnnaCsybPN/VmPC0Pyvu3iMa
         HXmixuFITSrJHd5rndZhdBRWcSCnZutlF4R8w3M0Dd8udIyJX9texqhkLIkiRJwLrX7N
         IoVRfZ1JF2QfeCQG56M0FUlud7oOYPsBNt8mEVOP4TBi/TR7H0I1g+pvBtDrP3QHCEiv
         l2fTTHZSzWjTWruWeXu8Zgr0JhY+n9ooYXBV6nWgxxW4Pt2Br9isdWhJGb84LTzwNSA2
         V4Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+SL6m/UUqVrlvtfuDTw/ENEWwP6pMlhcSQFLxGGrqoygPy+qnKdjWWlKnM7isjaIq60cMym5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTQXNEYujPBoFO8UHR35JVXgTTqGhvt2rGJN0S6jmY6Xs0UHy
	K0CUb7XTqSxu7TD7YsKGpk/u9R/1HFiEnqd1imTgiXJNjCQ2r2BO5nAmxJj3IJx9jEINBcsXQLJ
	EGpDW
X-Gm-Gg: AfdE7cmXKrYNEvuhNX/rKSeaE57CHUD9zhAyaomOOFp0ch2u1p//6jfaaMtK42hs4X6
	Ua/b84EeuIcBrx9YZuuDRywxDZKaJ8bpNFzT/7PFbrBDcHhVPmjTeEzxvFJw0sI5qoEwmh4I8Jd
	m1Qnjg1E8KGnIwksVe6fAkCjVnHYUk2AdNu+t2pqJzeI+VYPUFJU4s+QjAl9MSI7dUJ/QEtxepX
	wLfYfTEOqD8uQwyYhrhl0AxE4kaMoojNWRdlF7G0SQoY+ZVkXz19/EjlCran9L2dBpyRsvOlugl
	4Aiky72WsSA5DbMMTB7fBpurWPrrH8ioS22oWv8Z73Bya04z6rGxA1S5V472DxLOZ+LTOPtbYy+
	f9X9IDip4kahRxmQ5eqYfO6mxi3U8kjVHmgxdIpWH6oZ4zKEo0k1MSYWCX1HqJ2faJXMS/ncbA9
	ydRAIAr+sVi04tKLSM
X-Received: by 2002:a17:907:c085:b0:c0d:9172:c8bc with SMTP id a640c23a62f3a-c10902d21afmr125473866b.42.1782213622896;
        Tue, 23 Jun 2026 04:20:22 -0700 (PDT)
Received: from cloudflare.com ([81.15.226.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ac9e77sm490232666b.37.2026.06.23.04.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:20:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 23 Jun 2026 13:20:18 +0200
Subject: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAPFrOmoC/4WOQQ6CMBREr0L+2pq2EjCuvIchhrYfqEJL+gvBE
 O5uwQO4nMy8mVmBMFgkuGUrBJwtWe+SkKcMdFe7Fpk1SYPksuCFlEyNDaP3c6CW0djbyCZnF2Z
 KkRuOPL9qBYkdAzZ2OXofsCMOlwjVz6FJvVDHvXbPdpaiD5/jwiwO4s/aLJhIk8i1KpXiF3XXv
 Z9M09cBz9oPUG3b9gVOTc8G2wAAAA==
X-Change-ID: 20260622-bpf-sk_msg-split-unix-d714d0e048cb
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,google.com,vger.kernel.org,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-301348-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4C9F6B6A73

Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
completed all code paths related to sockmap-based redirects should be
guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
disabling NET_SOCK_MSG. The implementation of sockmap as a container for
socket references would remain under BPF_SYSCALL.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Handle prot->recvmsg being NULL (Sashiko)
- Elaborate on the end goal in description
- Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com
---
 net/unix/af_unix.c  | 4 ++--
 net/unix/unix_bpf.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..84c11c60c75f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg, size_t si
 #ifdef CONFIG_BPF_SYSCALL
 	const struct proto *prot = READ_ONCE(sk->sk_prot);
 
-	if (prot != &unix_dgram_proto)
+	if (prot->recvmsg)
 		return prot->recvmsg(sk, msg, size, flags);
 #endif
 	return __unix_dgram_recvmsg(sk, msg, size, flags);
@@ -3152,7 +3152,7 @@ static int unix_stream_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk = sock->sk;
 	const struct proto *prot = READ_ONCE(sk->sk_prot);
 
-	if (prot != &unix_stream_proto)
+	if (prot->recvmsg)
 		return prot->recvmsg(sk, msg, size, flags);
 #endif
 	return unix_stream_read_generic(&state, true);
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index f86ff19e9764..5289a04b4993 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -7,6 +7,7 @@
 
 #include "af_unix.h"
 
+#ifdef CONFIG_NET_SOCK_MSG
 #define unix_sk_has_data(__sk, __psock)					\
 		({	!skb_queue_empty(&__sk->sk_receive_queue) ||	\
 			!skb_queue_empty(&__psock->ingress_skb) ||	\
@@ -94,6 +95,7 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	sk_psock_put(sk, psock);
 	return copied;
 }
+#endif /* CONFIG_NET_SOCK_MSG */
 
 static struct proto *unix_dgram_prot_saved __read_mostly;
 static DEFINE_SPINLOCK(unix_dgram_prot_lock);
@@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct proto *prot, const struct proto
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+#ifdef CONFIG_NET_SOCK_MSG
 	prot->recvmsg = unix_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
+#endif
 }
 
 static void unix_stream_bpf_rebuild_protos(struct proto *prot,
@@ -116,8 +120,10 @@ static void unix_stream_bpf_rebuild_protos(struct proto *prot,
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+#ifdef CONFIG_NET_SOCK_MSG
 	prot->recvmsg = unix_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
+#endif
 	prot->unhash  = sock_map_unhash;
 }
 




