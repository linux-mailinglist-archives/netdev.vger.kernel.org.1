Return-Path: <netdev+bounces-28743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC9978076E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7669C282318
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E117747;
	Fri, 18 Aug 2023 08:47:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D13D7F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:47:40 +0000 (UTC)
Received: from [192.168.42.3] (194-45-78-10.static.kviknet.net [194.45.78.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 21695C433C8;
	Fri, 18 Aug 2023 08:47:37 +0000 (UTC)
Subject: [PATCH] softirq: Adjust comment for CONFIG_PREEMPT_RT in #else
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 netdev@vger.kernel.org
Date: Fri, 18 Aug 2023 10:47:35 +0200
Message-ID: <169234845563.1636130.4897344550692792117.stgit@firesoul>
User-Agent: StGit/1.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The #ifdef CONFIG_PREEMPT_RT #else statement had a comment
that made me think the code below #else statement was RT code.
After reading the code closer I realized it was not RT code.
Adjust comment to !RT to helper future readers of the code.

Fixes: 8b1c04acad08 ("softirq: Make softirq control and processing RT aware")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 kernel/softirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 807b34ccd797..b9a8384821b9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -292,7 +292,7 @@ void do_softirq_post_smp_call_flush(unsigned int was_pending)
 		invoke_softirq();
 }
 
-#else /* CONFIG_PREEMPT_RT */
+#else /* !CONFIG_PREEMPT_RT */
 
 /*
  * This one is for softirq.c-internal use, where hardirqs are disabled



