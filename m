Return-Path: <netdev+bounces-303770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 57dsGAtCRWoa9goAu9opvQ
	(envelope-from <netdev+bounces-303770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:36:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF446EFDA2
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:36:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=cFjXXlOc;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=MhTy3XKh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303770-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303770-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F8203067AD5
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239E377EB8;
	Wed,  1 Jul 2026 16:36:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1548376497;
	Wed,  1 Jul 2026 16:36:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923768; cv=none; b=O6+P5DCPgR/rc+KT3ZhYZ5bsM7AACHC0Dbwi0S6Az1YRZPiMTFmNN1mo/Ij0PCefY7jwIaDGfqt5Iz/vSJpzdXmCpGlzsZaoXNaH0GMft8DaSRD0wVfMHGTdziCY/kxJBMxBy/GlLn0zsTAji3IkZ996rNSi7j5PSZxdKnLqr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923768; c=relaxed/simple;
	bh=LtZorQCC1Q1RYWrb7kd+YV0ztZUF6kqN7X9u7clnLB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1DdMKuSONr5ZPXWISwLh5tupkDSkS7FyUGnYx6wW8SS+4BTyCtHbYdFqZU5L6Rv6TKJIHLDEbo9bKjHkSOYj15O6YvHrslye0+y/A8LyGZ8PufN/XJ+YBSm0wVvU6VRy/8j4mxQ2ydGsZOB/l0zvqnxO+q117Zb1kfbdExwywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFjXXlOc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MhTy3XKh; arc=none smtp.client-ip=193.142.43.55
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782923763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpPxfHjNVp/v6IB8DNtSUfTsO1JBv2zEZ0/vIk7YYIw=;
	b=cFjXXlOcbo1GW/Y8p350NcjyVVnKNBjCpGjd4nH2n4yVsh0y/9/PUQgmrsqleYV+XQhwVO
	4TVqLerTf6ywqnYsdwMg/D6toYyiXFojLMqJ2MyYnnGqqNHjJtS71ET6BErxtA08t9Ec1J
	WXLNhBrxlYWeVWGs4y0z0QRvAtjqhh9mhDceINe/ARAsBibXTYJSoEjt6jOFAVHNOWzJlV
	SVtdXYEqlr3DABe9CmEOe7oEKiJFFqrveIAPIX0y/KfkAgkneSw0GeikW/L2/WPkTf2krF
	3cu5RRKHj9HFrhf6SGt8kIgq+sin7MOr+6dlrlxplS5oe2T1t+BjvAgWvSBs8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782923763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpPxfHjNVp/v6IB8DNtSUfTsO1JBv2zEZ0/vIk7YYIw=;
	b=MhTy3XKhl0H3mGsbdJveUCLYj4N7WIA0lYI20FEMq3hmrh7nlyCBuIUSQ/wFKyOO6QASBo
	mzHxHrufYIy35dBw==
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/2] af_unix: Clean up unix_schedule_gc()
Date: Wed,  1 Jul 2026 18:35:54 +0200
Message-ID: <8e1eda7344d490498839bf99b906968b66512de9.1782922354.git.namcao@linutronix.de>
In-Reply-To: <cover.1782922354.git.namcao@linutronix.de>
References: <cover.1782922354.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303770-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[namcao@linutronix.de,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:namcao@linutronix.de,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECF446EFDA2

The only caller of unix_schedule_gc() passes NULL as an argument. Therefore
simplify by deleting the parameter.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 net/unix/af_unix.c |  2 +-
 net/unix/af_unix.h |  2 +-
 net/unix/garbage.c | 14 +-------------
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..759db734a866 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -733,7 +733,7 @@ static void unix_release_sock(struct sock *sk, int embr=
ion)
=20
 	/* ---- Socket is dead now and most probably destroyed ---- */
=20
-	unix_schedule_gc(NULL);
+	unix_schedule_gc();
 }
=20
 struct unix_peercred {
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index 8119dbeef3a3..600d56fdcde4 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -30,7 +30,7 @@ void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_peek_fpl(struct scm_fp_list *fpl);
-void unix_schedule_gc(struct user_struct *user);
+void unix_schedule_gc(void);
=20
 /* SOCK_DIAG */
 long unix_inq_len(struct sock *sk);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index f180c59b3da9..d46aeb9d2051 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -635,23 +635,11 @@ static void unix_gc(struct work_struct *work)
=20
 static DECLARE_WORK(unix_gc_work, unix_gc);
=20
-#define UNIX_INFLIGHT_SANE_USER		(SCM_MAX_FD * 8)
-
-void unix_schedule_gc(struct user_struct *user)
+void unix_schedule_gc(void)
 {
 	if (READ_ONCE(unix_graph_state) =3D=3D UNIX_GRAPH_NOT_CYCLIC)
 		return;
=20
-	/* Penalise users who want to send AF_UNIX sockets
-	 * but whose sockets have not been received yet.
-	 */
-	if (user &&
-	    READ_ONCE(user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
-		return;
-
 	if (!READ_ONCE(gc_in_progress))
 		queue_work(system_dfl_wq, &unix_gc_work);
-
-	if (user && READ_ONCE(unix_graph_cyclic_sccs))
-		flush_work(&unix_gc_work);
 }
--=20
2.47.3


