Return-Path: <netdev+bounces-304419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yPeyOaBpR2qpXwAAu9opvQ
	(envelope-from <netdev+bounces-304419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:49:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2356FFBB7
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:49:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=c1rjlkYn;
	dmarc=pass (policy=none) header.from=uniontech.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304419-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304419-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD9CA302333C
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25883546FF;
	Fri,  3 Jul 2026 07:46:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D036DA08;
	Fri,  3 Jul 2026 07:46:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064797; cv=none; b=HlXq+7IMC/iG5BkZCLK5R9K5baFUb6H1V/hoI0gD4uiwENqYqE+1pTPk9EEVeywb8xs6xUViBzjmci8G7x0MY4u2CYbnq1zK5Q1cABSqTzZ3anhwc+w8qVgzsKqn4Irt/C8YysMaL11SdKJWv3JboaludYyqcyDY4rhWVK4mX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064797; c=relaxed/simple;
	bh=wcuzXrutR1yKkosiSzqg8/qrxTaD6IuQNUeJhV2FWD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kBVnQgug3z+bCLWU+9J1IsAvo6jWvElGSVRvfpYBknzaJH1eXTnkj64PVZjF7W+9V7IOEfnngj6SDHFyRN+2U5X7rVlKTyJRrmy370JadcPkK8TXk+PRX6MLKmU+jAmlZ64PD550ZYNlRrQrmwxqWeDbUP+XoC5bybrMGyeD6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=c1rjlkYn; arc=none smtp.client-ip=54.206.34.216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783064635;
	bh=qjpBK8rQaJa09VTkZk4KSzbrMj5EsnN04kVz9p+YHVU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=c1rjlkYnF8rHOjd5RSZdmfFtErJOCzYDHQCmeYexrcFNgW/W2kt2bpbXRDjD2HX2b
	 zyRi6L1O9MFQkNQQQ23PYuG8a0PRZXurt1yNS7ImwhozoH2Sr7h8761mfp5bbdpjaq
	 JTOuEbPOVFUJKhtbUfeYlMIgzoidXLJQhR48aC4w=
X-QQ-mid: zesmtpsz5t1783064616tb83c8e2b
X-QQ-Originating-IP: pnOTIEx+1nS0UPWtePjvhT8HyKya6ICSMD2OKRR7or4=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 03 Jul 2026 15:43:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18083885935449274578
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: madalin.bucur@nxp.com,
	sean.anderson@linux.dev
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	igal.liberman@freescale.com,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH net v2 1/2] net: fman: move IRQ registration after init to prevent NULL deref and UAF
Date: Fri,  3 Jul 2026 15:43:23 +0800
Message-Id: <20260703074324.907294-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MbjVwinFRr/ec95eazuMpxpjer8n+OSDmWaAhK9x7J8XNx+XpBcZO0/r
	HZ3/znMoBwQqpSZ1OGSMhPLhiVWXducWYg0MlL95+0MuEHw4SUjqGiyb/I4RvSZKpOiXSFp
	9CtY9vJtCTHF2X0uTnsvuuYt/RkA9LkyRNiO7EP/ozIeWOGs8hF4f8FVkL4zXEUI8us3enO
	q6U/IJiRKzU0UFwOovvBVyUAnVbN/Sbv2jWVzDvaaj9RbE28p949dJGGrnGS3bv9pKbAP7t
	8agj3Es8mItPEKuRL0UoXQxdVSYFbfYPenSp5Wk4Egk+stKV8/p5jZNUwl5zLZAhKOYOu4R
	tppRdD6uQqZdRCKEKzxeRGyjYzpLQycifShyE9ZztvXnA0dgzQ+8nSTBBi35O/X6IX/+Ugz
	8B8WOt2r0Cd4DM8V4uTy1t/Yz8Ays2X/8+j3+NiZMFiIgFkZ3Hmoub+nCih7Uxym8KzTcGV
	PwMszS1roaulXTQ6NFUV05Vz5nj7v8hLwkEmfcpooiU7VSWkCAKST6roxwZd5XPLbnpwRGF
	/12DRAj8dTL+ApW3OUVJxjER8dIYrfWCgvcc1EUuyxXJTSpyk2tBwy1KZgmsyKAsjBm/y4U
	nPs8RENK6rj/O4PCzeajXAd9q38mY1/XV+kWBcF9VWXwHObPTsmdEvaz+CdnSjHrDMOSpPF
	cloG4WL1Up+Boh6FiCnDy62Dq5QLX/WY9K4t0ebPZieJQnsxvufOosW6ZEbFzGaBLOqZEAh
	OPGi3D/ccni8Z5rOPI+X86vhC6hwzLTKqEG6OhJGoN6F+RgWcaBvjWxEoB7629vpbI3Hzge
	VdobZFloDwcdfly6RAR28bJ9xIFJFBtaAUeInosVqQo1FyzWCaI83utybNBe+q36uRnUx/d
	Mic8F+7K8EOF6FYm4DkPeqeWyBQ5dnbXvalXolzsQA0c6et6e3gP5QFZZqAR7cPvQYOGXYX
	s0V6ubHaBgykWntmtdfFE/hBJThE651+iwWfCgIg1B/MjKy++5Y/2+jCwtEtragmMFzm2Km
	j06mUONPU56rdHEyGGuwWE1VzppMKLeHKzgw/NLOvMoph1ZhieOXRsmP/8Hv5+h6E4QWp6U
	zjI8Ycnen2awm4iCHjlMhixH7eyvmSZQw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304419-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:madalin.bucur@nxp.com,m:sean.anderson@linux.dev,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:igal.liberman@freescale.com,m:linux-kernel@vger.kernel.org,m:zhaojinming@uniontech.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:from_mime,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB2356FFBB7

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

v2:
- move devm_request_irq() to fman_probe() after init (replaces
  irq_ready + READ_ONCE approach from v1)
- supersede the separate UAF fix patch (v3), as this patch
  resolves both issues in a single change

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Link: https://lore.kernel.org/netdev/20260626162323.GE1310988@horms.kernel.org/
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 52 +++++++++++++---------
 drivers/net/ethernet/freescale/fman/fman.h |  1 +
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 299bab043175..6947f3bc7c87 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2695,7 +2695,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	void __iomem *base_addr;
 	struct resource *res;
 	u32 val, range[2];
-	int err, irq;
+	int err;
 	struct clk *clk;
 	u32 clk_rate;
 
@@ -2717,7 +2717,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	err = platform_get_irq(of_dev, 0);
 	if (err < 0)
 		goto fman_node_put;
-	irq = err;
+	fman->dts_params.irq = err;
 
 	/* Get the FM error interrupt */
 	err = platform_get_irq(of_dev, 1);
@@ -2773,25 +2773,6 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 
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
@@ -2848,6 +2829,35 @@ static int fman_probe(struct platform_device *of_dev)
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


