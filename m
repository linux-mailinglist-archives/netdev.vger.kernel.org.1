Return-Path: <netdev+bounces-301388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YicZLgiYOmo5BAgAu9opvQ
	(envelope-from <netdev+bounces-301388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:28:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711F06B7E00
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:28:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=fJNcvDgK;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=S923S6Pr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301388-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301388-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99ABF303024C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC90D385D99;
	Tue, 23 Jun 2026 14:27:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27532B11E;
	Tue, 23 Jun 2026 14:27:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224827; cv=none; b=nL6aTiG3mc9RCduwZZg+UiPAw5v8986Yp48oGZvEot5GdmsRDAVXlVLlY4XFLXsrRlo9NPAM+oSgtYs+pnUvsE0S8MBhziLy2HE8BDmcTNDPu/AT0O00PYQi0PH1FCwoWhq2pb2jd4u0DDBM4wDcN+jrpie7W/OKllbSzvSdNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224827; c=relaxed/simple;
	bh=ey+bZZQJp1LPnLeShhdGyynLcTAcYrBePcWy90OtJ+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru7PEdCTC5/5n6XBTqrpQsmSjlNqYgfSn4CQB+g95MTtY0nW7PNSU2wEybElduoIy3xsnGONwvCrkbwYmvSxSKDEz30j6pFx8r8btkytRnLxkJkmcKuXquPHX2QB/PntejKiahyqJ69ghi1wqXthlGQqYwGkL/a9H32A06kwZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fJNcvDgK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S923S6Pr; arc=none smtp.client-ip=193.142.43.55
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782224824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqFi9Rvvs1tNEUFIO8PSUCUNoZLiDxxwBuBVFdBFL+k=;
	b=fJNcvDgKfgCA42sQVvl1QKI1X2XbXouIt9e5sLRPaNgid0AFEbc6/twvv/ReLgdg9SR5Zi
	qZ8pA/pe2qZ3e94DyOsz17+YPCsGMlGxxrN3bYNLnW9MyHdE1ky1Pt415QZJvsT5m7F1dR
	dJy4NGZdEX2+Fi9IPotciudRy7Pioa2NOwhRHhDu99O4TdzqgRu4k7vmxrqB+1L7d9/YCg
	RkFcvGeM+pUm8PDqVB99JOs1meHYEPNk++ZX/nUTuKUsU13s/ALSPP54d6Eu0jzL6fNTcU
	nHQA/3CCpmP8roGM10rWHpu3USUp6lxbRY/9bTXbP3iAPMM92cqsSX/71+9LFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782224824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqFi9Rvvs1tNEUFIO8PSUCUNoZLiDxxwBuBVFdBFL+k=;
	b=S923S6Pr9FVH+bCq1hSDF+gjMGjqMpt+yVGtvR51lcHMtxi/6rG+BEFmhwFEttMzfLtQO2
	eaZRUEFajeZIWxDA==
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console deferred output
Date: Tue, 23 Jun 2026 16:26:49 +0200
Message-ID: <20260623142650.265721-2-bigeasy@linutronix.de>
In-Reply-To: <20260623142650.265721-1-bigeasy@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301388-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS(0.00)[m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:pabeni@redhat.com,m:peterz@infradead.org,m:pmladek@suse.com,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:bigeasy@linutronix.de,m:vladwing@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,nvidia.com,linux-foundation.org,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,amd.com,infradead.org,suse.com,chromium.org,goodmis.org,linaro.org,gmail.com];
	DKIM_TRACE(0.00)[linutronix.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 711F06B7E00

Provide a deferred version of the WARN_ON() macro. It will delay
flushing the console until a later context. It is needed in a context
where the caller holds locks which can lead to a deadlock content is
flushed to the console driver.
An example would from a warning from within the scheduler resulting in a
wake-up of a task.

Deferring the output works by using printk_deferred_enter/ exit() around
the printing output. This must be used in a context where the task can't
migrate to another CPU. This should be the case usually, since the
scheduler would acquire the rq lock whith disabled interrupts, but to be
safe preemption is disabled to guarantee this.

In order not to bloat the code on architectures which provide an
optimized __WARN_FLAGS() define BUGFLAG_DEFERRED which is handled by
__report_bug() and does not increase the code size.

Provide the DEFERRED macros based on __WARN_FLAGS and __WARN_FLAGS
macros. Extend __report_bug() to handle the deferred case.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/asm-generic/bug.h | 41 +++++++++++++++++++++++++++++++++++++++
 lib/bug.c                 | 16 +++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 09e8eccee8ed9..1e3ff00f709b8 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -14,6 +14,7 @@
 #define BUGFLAG_DONE		(1 << 2)
 #define BUGFLAG_NO_CUT_HERE	(1 << 3)	/* CUT_HERE already sent */
 #define BUGFLAG_ARGS		(1 << 4)
+#define BUGFLAG_DEFERRED	(1 << 5)
 #define BUGFLAG_TAINT(taint)	((taint) << 8)
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
@@ -115,6 +116,16 @@ extern __printf(1, 2) void __warn_printk(const char *f=
mt, ...);
 })
 #endif
=20
+#define WARN_ON_DEFERRED(condition) ({					\
+	int __ret_warn_on =3D !!(condition);				\
+	if (unlikely(__ret_warn_on)) {					\
+		__WARN_FLAGS(#condition,				\
+			     BUGFLAG_DEFERRED |				\
+			     BUGFLAG_TAINT(TAINT_WARN));		\
+	}								\
+	unlikely(__ret_warn_on);					\
+})
+
 #ifndef WARN_ON_ONCE
 #define WARN_ON_ONCE(condition) ({					\
 	int __ret_warn_on =3D !!(condition);				\
@@ -125,6 +136,16 @@ extern __printf(1, 2) void __warn_printk(const char *f=
mt, ...);
 	unlikely(__ret_warn_on);					\
 })
 #endif
+
+#define WARN_ON_ONCE_DEFERRED(condition) ({				\
+	int __ret_warn_on =3D !!(condition);				\
+	if (unlikely(__ret_warn_on)) {					\
+		__WARN_FLAGS(#condition,				\
+			     BUGFLAG_ONCE | BUGFLAG_DEFERRED |		\
+			     BUGFLAG_TAINT(TAINT_WARN));		\
+	}								\
+	unlikely(__ret_warn_on);					\
+})
 #endif /* __WARN_FLAGS */
=20
 #if defined(__WARN_FLAGS) && !defined(__WARN_printf)
@@ -159,6 +180,19 @@ extern __printf(1, 2) void __warn_printk(const char *f=
mt, ...);
 })
 #endif
=20
+#ifndef WARN_ON_DEFERRED
+#define WARN_ON_DEFERRED(condition) ({					\
+	int __ret_warn_on =3D !!(condition);				\
+	if (unlikely(__ret_warn_on)) {					\
+		guard(preempt)();					\
+		printk_deferred_enter()					\
+		__WARN();						\
+		printk_deferred_exit()					\
+	}								\
+	unlikely(__ret_warn_on);					\
+})
+#endif
+
 #ifndef WARN
 #define WARN(condition, format...) ({					\
 	int __ret_warn_on =3D !!(condition);				\
@@ -180,6 +214,11 @@ extern __printf(1, 2) void __warn_printk(const char *f=
mt, ...);
 	DO_ONCE_LITE_IF(condition, WARN_ON, 1)
 #endif
=20
+#ifndef WARN_ON_ONCE_DEFERRED
+#define WARN_ON_ONCE_DEFERRED(condition)				\
+	DO_ONCE_LITE_IF(condition, WARN_ON_DEFERRED, 1)
+#endif
+
 #ifndef WARN_ONCE
 #define WARN_ONCE(condition, format...)				\
 	DO_ONCE_LITE_IF(condition, WARN, 1, format)
@@ -215,7 +254,9 @@ extern __printf(1, 2) void __warn_printk(const char *fm=
t, ...);
 })
 #endif
=20
+#define WARN_ON_DEFERRED(condition) WARN_ON(condition)
 #define WARN_ON_ONCE(condition) WARN_ON(condition)
+#define WARN_ON_ONCE_DEFERRED(condition) WARN_ON(condition)
 #define WARN_ONCE(condition, format...) WARN(condition, format)
 #define WARN_TAINT(condition, taint, format...) WARN(condition, format)
 #define WARN_TAINT_ONCE(condition, taint, format...) WARN(condition, forma=
t)
diff --git a/lib/bug.c b/lib/bug.c
index 224f4cfa4aa31..f5768f5d17b47 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -196,7 +196,7 @@ void __warn_printf(const char *fmt, struct pt_regs *reg=
s)
=20
 static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned lon=
g bugaddr, struct pt_regs *regs)
 {
-	bool warning, once, done, no_cut, has_args;
+	bool warning, once, done, no_cut, has_args, deferred;
 	const char *file, *fmt;
 	unsigned line;
=20
@@ -219,6 +219,7 @@ static enum bug_trap_type __report_bug(struct bug_entry=
 *bug, unsigned long buga
 	done     =3D bug->flags & BUGFLAG_DONE;
 	no_cut   =3D bug->flags & BUGFLAG_NO_CUT_HERE;
 	has_args =3D bug->flags & BUGFLAG_ARGS;
+	deferred =3D bug->flags & BUGFLAG_DEFERRED;
=20
 	if (warning && once) {
 		if (done)
@@ -229,7 +230,10 @@ static enum bug_trap_type __report_bug(struct bug_entr=
y *bug, unsigned long buga
 		 */
 		bug->flags |=3D BUGFLAG_DONE;
 	}
-
+	if (deferred) {
+		preempt_disable_notrace();
+		printk_deferred_enter();
+	}
 	/*
 	 * BUG() and WARN_ON() families don't print a custom debug message
 	 * before triggering the exception handler, so we must add the
@@ -245,6 +249,10 @@ static enum bug_trap_type __report_bug(struct bug_entr=
y *bug, unsigned long buga
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 		__warn(file, line, (void *)bugaddr, BUG_GET_TAINT(bug), regs,
 		       NULL);
+		if (deferred) {
+			printk_deferred_exit();
+			preempt_enable_notrace();
+		}
 		return BUG_TRAP_TYPE_WARN;
 	}
=20
@@ -254,6 +262,10 @@ static enum bug_trap_type __report_bug(struct bug_entr=
y *bug, unsigned long buga
 		pr_crit("kernel BUG at %pB [verbose debug info unavailable]\n",
 			(void *)bugaddr);
=20
+	if (deferred) {
+		printk_deferred_exit();
+		preempt_enable_notrace();
+	}
 	return BUG_TRAP_TYPE_BUG;
 }
=20
--=20
2.53.0


