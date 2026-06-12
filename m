Return-Path: <netdev+bounces-298617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z88tK3LyK2pIIQQAu9opvQ
	(envelope-from <netdev+bounces-298617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:50:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EB36791B6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:50:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=jdlIT+LS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298617-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298617-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15AF431D8274
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EC3E9C07;
	Fri, 12 Jun 2026 11:45:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15D3BD63A;
	Fri, 12 Jun 2026 11:45:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264726; cv=none; b=EjQ+OQVe/CWqAj5OM/IgC3aP8MRiUaOAeiUpiFcOMUDqrXnFProb/JJPJuZcgLTSk4gDR6sPquvnb13WjlsKrInLxGb27Dgg1j3oKhARzcR/KQCXgrOz65j41uDWXAsntrhUbcZ4oQcD15jsy9iPuJNXg0FGjrkDYEt3vRfFwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264726; c=relaxed/simple;
	bh=rOO5nVUN1UMVzgBqFni0wZlC4ufTnZkisE4OtQZWR34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eRV5YLilBpZPabyGUcEBFG9NqzcQBj2mmnXtK0+X3UaJQOPCwu6VjqlPQLxrDda3VyNq7OxDLJn5rJAobC8pWAMATuCxVKMl6Zuys2h0SbbPiXnFhJAFb/32eIrP2AC6rqZhcfjFG110zaEIdfEpoZXx6sN9FZF8HPClJ5ai0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jdlIT+LS; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=NMlK2MbJHsWq9OxxnYl7DyWce94PpLQZGBajWQcLfDY=; b=jdlIT+LSoTFvuqD+38Tu6P2O5h
	lWaAzAq9qDYEIK0ThVo3eO+rMOca2vodjBxLHQ8g8Is3RObqBd4sKkg+NtEiWYKaFuWUe/jeTRs/y
	o0GCmlRoYveqG+rO93V3qZnvAHzqI3U054OxznhwWyiJ95TpEZ3ybUitf8t/JcW7B+aVJ4Lyei4gA
	lyBJDD+zVVpHWmjN/3vZqzxZwuYNlIHs+LyZPjs7qSP+I/vHPNqQTTM7wzSjNkR9zOwaKo1GZWiht
	nff9UHsOUZvC4s+uEArSWid65os265Vum+u2spcNVf4MPIKPDlUyiaxCJ8MzvpbF0ZAhZepR/4V1d
	J99XFZqQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wY0KA-00Ai6e-0d;
	Fri, 12 Jun 2026 11:45:22 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Jun 2026 04:45:05 -0700
Subject: [PATCH net-next 1/2] net: add sockopt_init_user() for getsockopt
 conversion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260612-getsockopt_phase2-v1-1-7b01f1f5d106@debian.org>
References: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
In-Reply-To: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=leitao@debian.org;
 h=from:subject:message-id; bh=rOO5nVUN1UMVzgBqFni0wZlC4ufTnZkisE4OtQZWR34=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqK/FJCEkQsbYpa/zoweNsCTEAhavfERkMJ1YIZ
 Xn/justXL+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaivxSQAKCRA1o5Of/Hh3
 bYLID/9R0fQdN+VDXD0YlsYbd+h6/397iut95vAfUrZAX/TWk9XOOP0JPB6P75WbKA3me2gk2dt
 n1YKkQvHH9Vu2W8NCWV4486k+eYXsyerPlnbYEPFnX1Yn3hBA7jx/c/oLKStdoJGR0rIN9Va7P9
 9trtge+vpQ9b8lE5KUVHjnBH+FXa69alTsez5dNhqlnwyghajffT9SHxgVXznDcmwjLVYBD27PB
 k6wL69rPxOzC3M1rg+Ix6MpSXU4Jse81sY7cuZ7qUgP61rezsUYO2wEbmdSbrD4VE5fG1LTjnuO
 IC+np+A4E0bnO3Ii5AmECZMgjDHKAbTy/n2mVqhEy9hL2g/P3UfMc3gFfA6/WEk+JLwMMe/xyAs
 zcdzpVSSUORavCDJNKf2PaIO/pGefxdjcBytZe2EhgWTm6KXenaKDgCf6Q7mjf4Ac4orz7MXIpc
 clT7mYrZlBSzlG0+5wy0QkDU84KVYJyxFdhW0EfZEYcT81bcLwsDZW8Ag7XMceSaMwIIl8lhbk+
 Nl4gLBjl2slXpwhlI8zmPujOL58P2ilE6H/T3ABA3B7+57kcWwu5nLGIb7OLo8cGorX2XFwSfhZ
 KT33Kzoo9LhSDtome3KAM2KLxo0TGCttoWgl1lgLeWIox7aBt9kAkHhDOFA3XBw8m32RrFZmmFz
 uJNms/zYkSc23NA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298617-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23EB36791B6

Add a helper that initializes a user-backed sockopt_t from the
(optval, optlen) __user pair passed to a getsockopt() callback.

It is used by transitional __user getsockopt wrappers while the
proto-layer getsockopt callbacks are converted to take a sockopt_t, and
is removed once the conversion is complete.

The goal is to help to convert leafs. Example:

 sock_common_getsockopt(... char __user *optval, int __user *optlen)
      → udp_getsockopt(sk, level, optname, optval__user, optlen__user)
               → udp_lib_getsockopt(sk, level, optname, &opt)   /* needs a sockopt_t */

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/net.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index f268f395ce473..277188a40c72e 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -47,6 +47,29 @@ typedef struct sockopt {
 	int optlen;
 } sockopt_t;
 
+/*
+ * Initialize a user-backed sockopt_t from the (optval, optlen) __user pair of
+ * a getsockopt() callback. Used by transitional __user getsockopt wrappers
+ * while the proto-layer callbacks are converted to take a sockopt_t; the
+ * caller writes opt->optlen back to the user optlen after the callback.
+ */
+static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
+				    int __user *optlen)
+{
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+	if (len < 0)
+		return -EINVAL;
+
+	iov_iter_ubuf(&opt->iter_out, ITER_DEST, optval, len);
+	iov_iter_ubuf(&opt->iter_in, ITER_SOURCE, optval, len);
+	opt->optlen = len;
+
+	return 0;
+}
+
 struct poll_table_struct;
 struct pipe_inode_info;
 struct inode;

-- 
2.53.0-Meta


