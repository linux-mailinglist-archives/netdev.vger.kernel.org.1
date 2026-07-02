Return-Path: <netdev+bounces-304064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eTYvFG81Rmo4LwsAu9opvQ
	(envelope-from <netdev+bounces-304064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:54:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5856F58C8
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:54:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=VclNwVRe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304064-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304064-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B322E3071C6E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061B3C98BA;
	Thu,  2 Jul 2026 09:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8829DB6C
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:29:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984546; cv=none; b=SlKxlGMs1Dnp9LYTihgyPFfy+0V94jpvqx6BpJFvQYcsjw6uX3y0ctnnPXoLw3QnWr7vWu0p2us4gEF1c/6qKYHgYHLD3h151P+6DJ5tk2sXcqlOETGQViRDmuZrwGLM39yfgyou9fDXe+Me79E9+bjkgsqwiXD7OkxnJ+24mf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984546; c=relaxed/simple;
	bh=g2JGcsvTpCJMJgNsUTLaudqGC2irrPOJSUpEnU1OlH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKuQ4ghCX8XQsGb35PiZGDliaxvTNDh1HPnuzbb1RtRCrJ0lSYqjVLl8aIU+7qfFxIyhiFleM3Dyz5Opz5voQfUE2Sy8F9OQbUkqtO81VKcZaxv7hWKL5AaaFHmGtUQM/AW4ZPaLi6uf4XozUFsk6vC7Nl8QyMflP6YH3zdCtGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VclNwVRe; arc=none smtp.client-ip=54.243.244.52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782984540;
	bh=9hud+z/rqT5EPqOkzbr9cKYjLTytFosyJwVm+/Rw28Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VclNwVRefVYzFoAIGkJ4a0i152FZdpmPyQHWR3KRf8/qzkvJtdMxBKSToxvG0lyCG
	 N5TtZp+DjNosaKz7iXdkCygwZF9KIY3fEqBqBppPkDTU98sONIfjavDUcfjbqiMwzf
	 3P/thC4x2gEs/LnKKHp8r3/L4EwumrUax0UN28Xc=
X-QQ-mid: zesmtpsz9t1782984525t31846d2e
X-QQ-Originating-IP: H3NcJhtQY/gVDip0LSrsl/K1hTejMt5soO711HJQd1o=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jul 2026 17:28:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15249623040615672031
EX-QQ-RecipientCnt: 12
From: ZhaoJinming <zhaojinming@uniontech.com>
To: pabeni@redhat.com
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	sean.anderson@linux.dev,
	zhaojinming@uniontech.com
Subject: [PATCH v2 1/2] net: fman: move IRQ registration after init to prevent NULL deref and UAF
Date: Thu,  2 Jul 2026 17:28:15 +0800
Message-Id: <20260702092815.1206704-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260702092815.1206704-1-zhaojinming@uniontech.com>
References: <e1f8aec9-751b-4a51-ab09-ca3c37522e30@redhat.com>
 <20260702092815.1206704-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OKlHfcJpO2gszIstMrVXrdxIJgm0owUyNLZU3X/0U2oPQA0GmhF8RDQR
	lNMEuz7Gbj/jWxFinpp4g3iDS2mZxbNEtwOQepP3o83dQj9hf+IbGdN7wTOlR1hmvr73+VV
	EHdFxYDTWutOjR+7TvhJ2Ut5Y0t45NoRVFZI8cJ1c4lzio1P52GgNpVWVKPJnqdpEi4EOoD
	uCX1k8FEBEpNVOqVFra4OZh2SYzoziGcS2uOkl88pjmLaLRY2YshSNlALf36QBOgp0qlghG
	SYaHPeuUJkpT3HFV1BFTw2CCVgMshfI2Q8OE2lOXu2IergGn3AjAKAWXHmWGwGoKWNVmWyk
	KDiwaKCN6p96zZDzDpdJR7MecCQGPzukyptZsmdq779mt5se4lGWABYgArOJraH/iYeKMB/
	njFffpc2EjRv/KdrasJiLXt/XC/RuQ3StQw7R7Za5e2tuKushAwLwRgdcOZ6znAct4p6daH
	hKdCZcnHs+3Q6RnnuhwO0hh7xr2XPNpKSLoWEnOUcuGwSbNsz3qJZ/bMBuDcIl1ZHl7dVL7
	0XpBOJDGXrmLD39Oe0/PYPmJ8keNewKbzA+LfVy6VaMebAphqCTE1a0szOqNe7Ti4PDGv31
	m9EA8xiSGc6wHKCGYM3rj7ieUg3lEKUCpd+OHp17k1Wa8u6ePZRpxQCalrohzuALHSMcnZ9
	lx++nMpViAdLxJ24UGQxOx1xHPS+rbHcDoGJZcjH9FHHfB8GBX0OjWSSy2hK743lyVPzFeX
	cErbJFBXbRRniNbLZT++DpkDpFknQaHxRyxnEr1uZKThOOvSg7CnF4dKXGtlIvLj3vAI2tK
	m4VEpcqr0jTTdngUr24MHYuZR/T9G37IqSur2ltxFxZnsELBR8kU+NE4LWxMXEX7nWU05Um
	YQFVRAiRYtSGnGEHYi6Mc/pTJLdUcVC6l7I3/GghcGlAQ4sAjryQ9jNRJRgf+fDdoMhp3nd
	cPCtpSHFgnpnYY54ZoXN0kNH3lLgAtzhuSM0HpFGD1R+KsqRewTj8BtfdtTXaPikTEa2Yod
	ksYVeI/q7e9SuADahs6D0vw9HqRkPlplXaqpRi4wpHFUCYJIwVXt+M7EDeWhCNANeKcAacR
	g==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304064-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:sean.anderson@linux.dev,m:zhaojinming@uniontech.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B5856F58C8

read_dts_node() registers shared interrupt handlers via
devm_request_irq() with fman as dev_id. Two bugs exist in the
current code:

1) Pre-init NULL dereference: at registration time fman is only
partially initialized -- kzalloc_obj() zero-initializes all fields,
so fman->cfg and fman->fpm_regs are NULL. The handlers check
is_init_done(fman->cfg) to guard against incomplete init, but
is_init_done(NULL) returns true (intended to mean cfg was freed
after successful init), so the guard is bypassed and fpm_regs is
dereferenced. If another device on the same shared IRQ line fires
during the window between devm_request_irq() and fman_init(), the
handler accesses NULL fpm_regs via ioread32be(), causing a crash.

2) Use-after-free on probe failure: fman is allocated with
kzalloc_obj() (not devm), so on error paths in read_dts_node()
(ioremap failure, of_platform_populate failure) and fman_config(),
kfree(fman) is called while the devm IRQ handlers remain
registered. The driver core's subsequent devres_release_all() frees
the IRQ handlers, but during the window between kfree(fman) and
devm_free_irq(), a shared-IRQ spurious firing will dereference
the already-freed fman.

A previous attempt to fix issue #1 with an irq_ready flag protected
by READ_ONCE()/WRITE_ONCE() is insufficient on weakly-ordered
architectures. READ_ONCE()/WRITE_ONCE() only prevent compiler
optimization; they do not provide the memory ordering guarantees
(e.g., smp_store_release/smp_load_acquire) needed to ensure that
writes to register pointers are visible to the IRQ handler before
it observes the flag as true.

Fix both issues by moving devm_request_irq() out of read_dts_node()
and into fman_probe(), after both fman_config() and fman_init()
have completed. This eliminates both race windows: by the time the
handlers are registered, all register pointers are initialized
(preventing the NULL dereference), and since fman is never freed
after this point, the use-after-free cannot occur either.

Add an 'irq' field to struct fman_dts_params so that the primary IRQ
number parsed in read_dts_node() is available to fman_probe().

This replaces the previous approach (irq_ready flag with READ_ONCE)
and also supersedes the separate UAF fix patch ("fsl_fman: fix
use-after-free on IRQF_SHARED handler after probe failure" v3),
as moving IRQ registration after init resolves both issues
in a single change.

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Link: https://lore.kernel.org/netdev/20260626162323.GE1310988@horms.kernel.org/
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 52 +++++++++++++---------
 drivers/net/ethernet/freescale/fman/fman.h |  1 +
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..a33c9c26f99c 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2693,7 +2693,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	void __iomem *base_addr;
 	struct resource *res;
 	u32 val, range[2];
-	int err, irq;
+	int err;
 	struct clk *clk;
 	u32 clk_rate;
 
@@ -2715,7 +2715,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	err = platform_get_irq(of_dev, 0);
 	if (err < 0)
 		goto fman_node_put;
-	irq = err;
+	fman->dts_params.irq = err;
 
 	/* Get the FM error interrupt */
 	err = platform_get_irq(of_dev, 1);
@@ -2771,25 +2771,6 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 
 	of_node_put(muram_node);
 
-	err = devm_request_irq(&of_dev->dev, irq, fman_irq, IRQF_SHARED,
-			       "fman", fman);
-	if (err < 0) {
-		dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
-			__func__, irq, err);
-		goto fman_free;
-	}
-
-	if (fman->dts_params.err_irq != 0) {
-		err = devm_request_irq(&of_dev->dev, fman->dts_params.err_irq,
-				       fman_err_irq, IRQF_SHARED,
-				       "fman-err", fman);
-		if (err < 0) {
-			dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
-				__func__, fman->dts_params.err_irq, err);
-			goto fman_free;
-		}
-	}
-
 	base_addr = devm_platform_get_and_ioremap_resource(of_dev, 0, &res);
 	if (IS_ERR(base_addr)) {
 		err = PTR_ERR(base_addr);
@@ -2846,6 +2827,35 @@ static int fman_probe(struct platform_device *of_dev)
 		return -EINVAL;
 	}
 
+	/* Register IRQ handlers only after initialization is complete.
+	 * This prevents two issues:
+	 * 1) Pre-init NULL dereference: is_init_done(NULL) returns true,
+	 *    so a shared-IRQ spurious firing before fpm_regs is set would
+	 *    dereference NULL.
+	 * 2) Use-after-free on probe failure: fman was kzalloc'd (not devm),
+	 *    so on error paths kfree(fman) ran before devm_free_irq, leaving
+	 *    a window where the handler could fire with a freed dev_id.
+	 * By registering here, both problems are eliminated.
+	 */
+	err = devm_request_irq(dev, fman->dts_params.irq, fman_irq,
+			       IRQF_SHARED, "fman", fman);
+	if (err < 0) {
+		dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
+			__func__, fman->dts_params.irq, err);
+		return err;
+	}
+
+	if (fman->dts_params.err_irq != 0) {
+		err = devm_request_irq(dev, fman->dts_params.err_irq,
+				       fman_err_irq, IRQF_SHARED,
+				       "fman-err", fman);
+		if (err < 0) {
+			dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
+				__func__, fman->dts_params.err_irq, err);
+			return err;
+		}
+	}
+
 	if (fman->dts_params.err_irq == 0) {
 		fman_set_exception(fman, FMAN_EX_DMA_BUS_ERROR, false);
 		fman_set_exception(fman, FMAN_EX_DMA_READ_ECC, false);
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 74eb62eba0d7..630d57c3144c 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -286,6 +286,7 @@ struct fman_dts_params {
 	struct resource *res;                   /* FMan memory resource */
 	u8 id;                                  /* FMan ID */
 
+	int irq;                                /* FMan IRQ */
 	int err_irq;                            /* FMan Error IRQ */
 
 	u16 clk_freq;                           /* FMan clock freq (In Mhz) */
-- 
2.20.1


From 6f2bd949c043ba7a3bb650430014ef933c698573 Mon Sep 17 00:00:00 2001
From: ZhaoJinming <zhaojinming@uniontech.com>
Date: Thu, 2 Jul 2026 16:34:06 +0800
Subject: [PATCH v2 2/2] net: fman: add error cleanup path in fman_probe

fman_init() and devm_request_irq() failure paths in fman_probe()
do not free fman and its sub-resources (keygen, muram allocations,
state, cfg), causing memory leaks on probe failure.

Add fman_muram_finish() to properly tear down a MURAM partition
(gen_pool_destroy + iounmap + kfree), complementing the existing
fman_muram_init().

Add fman_free_resources() that releases all fman sub-resources
in the correct order:
- devm_free_irq() for any already-registered IRQ handlers
- kfree(fman->keygen)
- free_init_resources() for MURAM CAM/FIFO allocations
- kfree(fman->cfg)
- fman_muram_finish(fman->muram) for the MURAM management object
- kfree(fman->state)
- kfree(fman)

Use two goto labels in fman_probe():
- err_irq: main IRQ registered but err_irq failed -- free main IRQ
  then fall through to release resources
- err_no_irq: no IRQ registered -- just release resources

The IRQ handlers must be explicitly freed before kfree(fman) to
avoid a window where a shared-IRQ spurious firing could dereference
the freed dev_id.

Note: fman_config() is not changed -- it already frees fman
internally on all its error paths, so fman_probe() must not touch
fman after fman_config() fails.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c    | 31 +++++++++++++++++--
 .../net/ethernet/freescale/fman/fman_muram.c  | 15 +++++++++
 .../net/ethernet/freescale/fman/fman_muram.h  |  2 ++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index a33c9c26f99c..a8ca0998b752 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2804,6 +2804,24 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	return ERR_PTR(err);
 }
 
+static void fman_free_resources(struct fman *fman, struct device *dev,
+				bool irq_registered)
+{
+	/* Free IRQs first while fman is still valid */
+	if (irq_registered) {
+		if (fman->dts_params.err_irq != 0)
+			devm_free_irq(dev, fman->dts_params.err_irq, fman);
+		devm_free_irq(dev, fman->dts_params.irq, fman);
+	}
+
+	kfree(fman->keygen);
+	free_init_resources(fman);
+	kfree(fman->cfg);
+	fman_muram_finish(fman->muram);
+	kfree(fman->state);
+	kfree(fman);
+}
+
 static int fman_probe(struct platform_device *of_dev)
 {
 	struct fman *fman;
@@ -2819,12 +2837,13 @@ static int fman_probe(struct platform_device *of_dev)
 	err = fman_config(fman);
 	if (err) {
 		dev_err(dev, "%s: FMan config failed\n", __func__);
+		/* fman_config() frees fman internally on all error paths */
 		return -EINVAL;
 	}
 
 	if (fman_init(fman) != 0) {
 		dev_err(dev, "%s: FMan init failed\n", __func__);
-		return -EINVAL;
+		goto err_no_irq;
 	}
 
 	/* Register IRQ handlers only after initialization is complete.
@@ -2842,7 +2861,7 @@ static int fman_probe(struct platform_device *of_dev)
 	if (err < 0) {
 		dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
 			__func__, fman->dts_params.irq, err);
-		return err;
+		goto err_no_irq;
 	}
 
 	if (fman->dts_params.err_irq != 0) {
@@ -2852,7 +2871,7 @@ static int fman_probe(struct platform_device *of_dev)
 		if (err < 0) {
 			dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
 				__func__, fman->dts_params.err_irq, err);
-			return err;
+			goto err_irq;
 		}
 	}
 
@@ -2881,6 +2900,12 @@ static int fman_probe(struct platform_device *of_dev)
 	dev_dbg(dev, "FMan%d probed\n", fman->dts_params.id);
 
 	return 0;
+
+err_irq:
+	devm_free_irq(dev, fman->dts_params.irq, fman);
+err_no_irq:
+	fman_free_resources(fman, dev, false);
+	return err ?: -EINVAL;
 }
 
 static const struct of_device_id fman_match[] = {
diff --git a/drivers/net/ethernet/freescale/fman/fman_muram.c b/drivers/net/ethernet/freescale/fman/fman_muram.c
index 6ac7c2b0cb19..6c2b4f7a02b8 100644
--- a/drivers/net/ethernet/freescale/fman/fman_muram.c
+++ b/drivers/net/ethernet/freescale/fman/fman_muram.c
@@ -129,3 +129,18 @@ void fman_muram_free_mem(struct muram_info *muram, unsigned long offset,
 
 	gen_pool_free(muram->pool, addr, size);
 }
+
+/**
+ * fman_muram_finish
+ * @muram:	FM-MURAM module pointer.
+ *
+ * Frees all resources associated with a MURAM partition.
+ */
+void fman_muram_finish(struct muram_info *muram)
+{
+	if (!muram)
+		return;
+	iounmap(muram->vbase);
+	gen_pool_destroy(muram->pool);
+	kfree(muram);
+}
diff --git a/drivers/net/ethernet/freescale/fman/fman_muram.h b/drivers/net/ethernet/freescale/fman/fman_muram.h
index 3643af61bae2..a5cb544c0f08 100644
--- a/drivers/net/ethernet/freescale/fman/fman_muram.h
+++ b/drivers/net/ethernet/freescale/fman/fman_muram.h
@@ -23,4 +23,6 @@ unsigned long fman_muram_alloc(struct muram_info *muram, size_t size);
 void fman_muram_free_mem(struct muram_info *muram, unsigned long offset,
 			 size_t size);
 
+void fman_muram_finish(struct muram_info *muram);
+
 #endif /* __FM_MURAM_EXT */
-- 
2.20.1


