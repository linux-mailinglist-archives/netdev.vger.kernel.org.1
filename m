Return-Path: <netdev+bounces-46619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A227E56FD
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 14:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF87B20E8D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 13:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D81179BA;
	Wed,  8 Nov 2023 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVsQ8P2d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B21182A2;
	Wed,  8 Nov 2023 13:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32BFC433C7;
	Wed,  8 Nov 2023 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699448446;
	bh=AsWQYHzG9sipb7sEr1JLntaPFi93f1pC9EyAKGQfMYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IVsQ8P2dntVCqOp290JiIjSeAiJc+VMO2pw8M5wXect2MBBRk+jOoldL7GU96ZMeA
	 HuTE9Cemzwdgusy0jqMNAGrkZljxwDe/bga3g2m7k9eEuDPGq3KBsmaI6dmPkl/wlE
	 2sJ8x5zpsds68NNoBAImql8aGu/sRESukQSJx2yQtofDYlD6qoDUcqJIsRbgMEAgD5
	 pBWkZwSHNGyEjrYKkBLIDiDk/X/C6tnjuGAPAvyQxIP+Clu91AntgrZdhbNIFgmOBm
	 NDqic6B3ehDAmy+JcPX7W+ZFcv2EJF1l6Qv/grGtIBAqxH+1Q7icIKEapV1+6GP4HA
	 hAP9sw3MNsZDA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geoff Levand <geoff@infradead.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Helge Deller <deller@gmx.de>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Timur Tabi <timur@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	David Woodhouse <dwmw2@infradead.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-bcachefs@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 07/22] [RESEND] sched: fair: move unused stub functions to header
Date: Wed,  8 Nov 2023 13:58:28 +0100
Message-Id: <20231108125843.3806765-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108125843.3806765-1-arnd@kernel.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

These four functions have a normal definition for CONFIG_FAIR_GROUP_SCHED,
and empty one that is only referenced when FAIR_GROUP_SCHED is disabled
but CGROUP_SCHED is still enabled. If both are turned off, the functions
are still defined but the misisng prototype causes a W=1 warning:

kernel/sched/fair.c:12544:6: error: no previous prototype for 'free_fair_sched_group'
kernel/sched/fair.c:12546:5: error: no previous prototype for 'alloc_fair_sched_group'
kernel/sched/fair.c:12553:6: error: no previous prototype for 'online_fair_sched_group'
kernel/sched/fair.c:12555:6: error: no previous prototype for 'unregister_fair_sched_group'

Move the alternatives into the header as static inline functions with
the correct combination of #ifdef checks to avoid the warning without
adding even more complexity.

[A different patch with the same description got applied by accident
 and was later reverted, but the original patch is still missing]

Fixes: 7aa55f2a5902 ("sched/fair: Move unused stub functions to header")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
A patch with the same commit log has
---
 kernel/sched/fair.c  | 13 -------------
 kernel/sched/sched.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2048138ce54b..82b82fa1d81b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12927,19 +12927,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	return 0;
 }
 
-#else /* CONFIG_FAIR_GROUP_SCHED */
-
-void free_fair_sched_group(struct task_group *tg) { }
-
-int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
-{
-	return 1;
-}
-
-void online_fair_sched_group(struct task_group *tg) { }
-
-void unregister_fair_sched_group(struct task_group *tg) { }
-
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..8f5df5250b8d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -436,10 +436,21 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 
 extern int tg_nop(struct task_group *tg, void *data);
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
 extern void free_fair_sched_group(struct task_group *tg);
 extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
 extern void online_fair_sched_group(struct task_group *tg);
 extern void unregister_fair_sched_group(struct task_group *tg);
+#else
+static inline void free_fair_sched_group(struct task_group *tg) { }
+static inline int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
+{
+       return 1;
+}
+static inline void online_fair_sched_group(struct task_group *tg) { }
+static inline void unregister_fair_sched_group(struct task_group *tg) { }
+#endif
+
 extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *se, int cpu,
 			struct sched_entity *parent);
-- 
2.39.2


