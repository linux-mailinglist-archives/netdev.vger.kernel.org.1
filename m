Return-Path: <netdev+bounces-254857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOlFNDOPe2mJGAIAu9opvQ
	(envelope-from <netdev+bounces-254857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:47:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA6B2667
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EA5E3011A5A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DA34165E;
	Thu, 29 Jan 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="N4CYDE5z"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD028B407;
	Thu, 29 Jan 2026 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705263; cv=none; b=C8nKD+mRnMCpGo8rgiAYoY+r1amYvZBIrCF843jhBLpdQEd8mtm0bJe/2SbhkfrtwcJLTjcFqfIy5EuYba8zmoIw15SsekqW7tZBsadKZbHTwXvNeYZ43vvJvouUEPlhMwWEyuSe+QMWrcWIFaFYHWYlaI2g/E+LvFdVOsQm2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705263; c=relaxed/simple;
	bh=WqaX2tCGZhh8yhek/zad9wg+k2ty/Ae9Zx7f2hp52Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=diFzM3Tb7mPqoOaeQ26sIJ/sGEp/w0yQCvMnY3H69dtnLxsbaVMG4jWTlux/F39zdo1x9JHqHyM3pwfpQbQzgoD1eU1DZPOVPrulOB4Tfgg9Clps4AXwhOuS5isOO+vuR8O86bag5WssYWPJGn9RJ+On5Zu8qIl0r9OeWDcL5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=N4CYDE5z; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vlVB2-00GZlB-58; Thu, 29 Jan 2026 17:47:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=ZDObvgaecqzCyFhO6/wh+GKhnNkkrQDcsMUu1fG/UKw=; b=N4CYDE5zyUoLaODRkesFSCvjPF
	7kZnqwEYKhOZkmIeraYxbwLuGmV6gLytxI53LmZFism5H6EUayFmPSmQaTZW8HqqmgDlt/lB2w24d
	wexPGHCvKLsQwag0u8utMyc7M/NWsXd95bXmONYfBF+ZRen4UqCilnom3yR8+93Jj3i6TBY81L9Os
	Xuq6Fi+m8KFAdzgLvYxUg8kRX4Re3igdIhlw/70+HLciN8abTFwkgea6ldzn53BUAJe7qYmdLcUtU
	NX51HDgJfOpPmpfAPkIq0JCYJsNPEPIbqqCRl1Y0Gy6HRxRqGGcW/nCV72ILPZgukvSvAC3f+njv6
	ft9DQ6Lg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vlVB1-0003E5-JA; Thu, 29 Jan 2026 17:47:27 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vlVAx-002SKV-4Y; Thu, 29 Jan 2026 17:47:23 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 29 Jan 2026 17:47:09 +0100
Subject: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDMBAAvyJ7dkEjWO1XiofEbNoFSZZNUgTx7
 w09zhxmLsikTBme3QVKX86cYoOx72D/2PgmZN8YzGDmYTQr1sgniqaSsIq3hTDW40Apip6UAs7
 WPKbJ7c6FBVpGmuTzv3iBkwDbff8Ag15WMHcAAAA=
X-Change-ID: 20260129-unix-proto-update-null-ptr-deref-6a2733bcbbf8
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254857-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26AA6B2667
X-Rspamd-Action: no action

BPF_MAP_UPDATE_ELEM races unix_stream_connect(): when
sock_map_sk_state_allowed() passes (sk_state == TCP_ESTABLISHED),
unix_peer(sk) in unix_stream_bpf_update_proto() may still return NULL.

	T0 bpf				T1 connect
	------				----------

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

Follow-up to discussion at
https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/.

Fixes: 8866730aed51 ("bpf, sockmap: af_unix stream sockets need to hold ref for pair sock")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Re-triggered while working on an unrelated selftest:
https://lore.kernel.org/bpf/20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co/
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

---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260129-unix-proto-update-null-ptr-deref-6a2733bcbbf8

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


