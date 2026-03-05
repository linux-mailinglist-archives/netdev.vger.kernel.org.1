Return-Path: <netdev+bounces-264493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMfHJgG9qWnNDQEAu9opvQ
	(envelope-from <netdev+bounces-264493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:27:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E232162EC
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AA86304F7CE
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE73E51C9;
	Thu,  5 Mar 2026 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZAczgTKE"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627673E1229;
	Thu,  5 Mar 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731227; cv=none; b=EzGIqk1WEWg0QGu3QcQZ3S39xfWMhmds0fFna8Ob5bV+mqUWXB9bY8TpAXM4SCNxFnz6O24R3QXKbBYdZ/ebcEj1IKFf5M/svi3vwXRDShMrloSagaUwT+G35Wbkf/WHQoTeEGaDcuVjmCL5umTjP4H4vNPktaVqZ/AXwo8RMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731227; c=relaxed/simple;
	bh=2dTXoYhrV2YK0qtw/2RCKpyPcXm725MMAg62YLiR80A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yk3hDBgUR/zAOFDT1tb8LQ+XpVgvwV6fNBEfE+G24DSP1J0UGtCnAcdsQFbOJKP/nkrjZEAkKDl6D6dl1XIFnF+VnSAMspSMC9B3R6Rw6lNnbn9v1mkj+kXe3TGYxxGc4SARJUO8i2j3bzSkuMLJv5Bktc3mTe6oGiJ6AfdOnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZAczgTKE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 235221A2CF0;
	Thu,  5 Mar 2026 17:20:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE7475FF89;
	Thu,  5 Mar 2026 17:20:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7AA910369916;
	Thu,  5 Mar 2026 18:20:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772731224; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x2VfJxb72EZoykvFVlXPayZoQ9XFY5PY0nYpCjhvV1Q=;
	b=ZAczgTKExavh6ls3N9c0+/JlyDHpMeQlryxk0cYc3wh2nz/wp/NxYr711E4PI5BEt5cWQw
	uYML4hdrJ8qQT8vQl/vTsR5A4XI4SRgE3vTX5da9dxDci6CZpVCye0cgN7k9TussyascDv
	Il9WyCVUVnUrs/2nTWMBvEgJTM81DdM+GGc5RK4QXswuMUCMJ9KtWPtasdyEyPA5CJbToP
	BUPmcd+natJMaPJ0ndTRVCeLixdYdjyQ05nPOp/9u4ToUI0RdF6FwtdbeaA+i+84CvFd1g
	U0ZpsjNFstBlL8KYmDVYA6YGPTHrCxbaVUugC1eGBtfwX/pL6X4W+L0GlfyN7Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 05 Mar 2026 18:20:15 +0100
Subject: [PATCH net-next 2/2] net: macb: distribute evenly Tx SRAM segments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-macb-set-channels-v1-2-28e3a96a3dc3@bootlin.com>
References: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
In-Reply-To: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paolo Valerio <pvalerio@redhat.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A7E232162EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264493-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

GEM has registers to configure the Tx SRAM segments distribution across
queues. The reset value is apprioriate (even spread) but we need to
care if/when number of active queues is modified (or if we inherited
unevenly initialised hardware from bootloader).

To distribute segments, we take as input the number of queues
(bp->num_queues) and the number of segments (found inside DCFG6).
Its output is a number of segments for each queue, formatted as
powers-of-two (eg 2 for queue 0 means it has 2^2=4 segments).

As the distribution logic is quite complex (at least its initial
versions had bugs), it is kunit-tested and those tests live at the end
of macb_main.c. To test:

⟩ env --unset=CROSS_COMPILE make ARCH=um mrproper
⟩ env --unset=CROSS_COMPILE ./tools/testing/kunit/kunit.py run \
        --kconfig_add CONFIG_NET=y \
        --kconfig_add CONFIG_COMMON_CLK=y \
        --kconfig_add CONFIG_MACB=y 'macb*'

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/Kconfig     |   6 ++
 drivers/net/ethernet/cadence/macb.h      |   5 ++
 drivers/net/ethernet/cadence/macb_main.c | 135 +++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 5b2a461dfd28..3ae7123352f5 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -51,4 +51,10 @@ config MACB_PCI
 	  To compile this driver as a module, choose M here: the module
 	  will be called macb_pci.
 
+config MACB_KUNIT_TEST
+	bool "KUnit test for MACB" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on MACB
+	default KUNIT_ALL_TESTS
+
 endif # NET_VENDOR_CADENCE
diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 30fa65e2bdf2..81fdd17b34db 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -193,6 +193,9 @@
 #define GEM_TXBDCTRL	0x04cc /* TX Buffer Descriptor control register */
 #define GEM_RXBDCTRL	0x04d0 /* RX Buffer Descriptor control register */
 
+#define GEM_TXQSEGALLOC_LOWER	0x05A0 /* Tx queue segment allocation (low) */
+#define GEM_TXQSEGALLOC_UPPER	0x05A4 /* Tx queue segment allocation (high) */
+
 /* Screener Type 2 match registers */
 #define GEM_SCRT2		0x540
 
@@ -543,6 +546,8 @@
 #define GEM_PBUF_CUTTHRU_SIZE			1
 #define GEM_DAW64_OFFSET			23
 #define GEM_DAW64_SIZE				1
+#define GEM_SEGMENTS_BIT_SIZE_OFFSET		16
+#define GEM_SEGMENTS_BIT_SIZE_SIZE		3
 
 /* Bitfields in DCFG8. */
 #define GEM_T1SCR_OFFSET			24
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index bac83a2b4c4d..022577756eab 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2751,6 +2751,59 @@ static u32 macb_dbw(struct macb *bp)
 	}
 }
 
+/*
+ * Distribute evenly available segments across queues. The computation is
+ * complex because (1) segments are counted in powers of two and (2) a queue
+ * can only use up to 8 segments. There are four types of cases:
+ *  - Sharing all segments equally is doable. Take num_queues=4 and
+ *    num_segments=16. Each queue will get 2^2=4 segments.
+ *  - Sharing all segments is doable. Take num_queues=5 and num_segments=16.
+ *    Three queues will get 2^2=4 segments and two will get 2^1=2 segments.
+ *  - Sharing all segments is not doable because not enough queues are
+ *    available. Take num_queues=1 and num_segments=16; queue 0 can only have 8
+ *    segments.
+ *  - Sharing all segments is not doable because not enough segments are
+ *    available. Take num_queues=4 and num_segments=2.
+ *
+ * We start by computing the power each queue will have. For num_queues=5 and
+ * num_segments=16, each queue will have at least 2^1 segments. That leaves us
+ * with remaining_segments=6. If we increase the power for a queue, we get a
+ * delta of 2 (2^2-2^1). The first three queues will therefore be advantaged
+ * and each have 2^2 segments. The remaining 2 queues will only have 2^1
+ * segments.
+ */
+static u64 gem_sram_distribute_segments(unsigned int num_queues,
+					unsigned int num_segments)
+{
+	unsigned int pow, remaining_segments, i;
+	unsigned int num_advantaged_queues = 0;
+	u64 val = 0;
+
+	/* pow=0 for all queues. ilog2(0) is dangerous. */
+	if (num_queues >= num_segments)
+		return 0;
+
+	pow = min(ilog2(num_segments / num_queues), 3);
+	remaining_segments = num_segments - num_queues * (1U << pow);
+
+	/*
+	 * We can only distribute remaining segments if (1) there are remaining
+	 * segments and (2) we did not reach the max segments per queue (2^3).
+	 */
+	if (remaining_segments != 0 && pow != 3) {
+		unsigned int delta = (1U << (pow + 1)) - (1U << pow);
+
+		num_advantaged_queues = remaining_segments / delta;
+	}
+
+	for (i = 0; i < num_advantaged_queues; i++)
+		val |= ((pow + 1) & 0b11) << (i * 4);
+	for (i = num_advantaged_queues; i < num_queues; i++)
+		val |= (pow & 0b11) << (i * 4);
+
+	return val;
+}
+
 /* Configure the receive DMA engine
  * - use the correct receive buffer size
  * - set best burst length for DMA operations
@@ -2832,6 +2885,19 @@ static void macb_init_hw(struct macb *bp)
 	if (bp->caps & MACB_CAPS_JUMBO)
 		bp->rx_frm_len_mask = MACB_RX_JFRMLEN_MASK;
 
+	/*
+	 * Distribute Tx SRAM segments evenly based on active number of queues.
+	 */
+	if (macb_is_gem(bp)) {
+		unsigned int num_segments;
+		u64 val;
+
+		num_segments = 1U << GEM_BFEXT(SEGMENTS_BIT_SIZE, gem_readl(bp, DCFG6));
+		val = gem_sram_distribute_segments(bp->num_queues, num_segments);
+		gem_writel(bp, TXQSEGALLOC_LOWER, val);
+		gem_writel(bp, TXQSEGALLOC_UPPER, val >> 32);
+	}
+
 	macb_configure_dma(bp);
 
 	/* Enable RX partial store and forward and set watermark */
@@ -6031,3 +6097,72 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cadence MACB/GEM Ethernet driver");
 MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
 MODULE_ALIAS("platform:macb");
+
+#ifdef CONFIG_MACB_KUNIT_TEST
+#include <kunit/test.h>
+
+struct macb_sram_segments_case {
+	unsigned int num_queues, num_segments;
+};
+
+static void macb_sram_segments_test(struct kunit *test)
+{
+	const struct macb_sram_segments_case *p = test->param_value;
+	u64 val = gem_sram_distribute_segments(p->num_queues, p->num_segments);
+	unsigned int i, sum_segments = 0, max_assigned_segments;
+	unsigned int num_queues = min(p->num_queues, p->num_segments);
+
+	for (i = 0; i < num_queues; i++) {
+		unsigned int q_segments = (val >> (i * 4)) & 0b11;
+
+		q_segments = 1U << q_segments;
+		sum_segments += q_segments;
+		KUNIT_ASSERT_GT_MSG(test, q_segments, 0, "queue %d, val %#llx", i, val);
+	}
+
+	for (i = num_queues; i < 16; i++) {
+		unsigned int pow = (val >> (i * 4)) & 0b11;
+
+		KUNIT_ASSERT_EQ_MSG(test, pow, 0, "queue %d, val %#llx", i, val);
+	}
+
+	max_assigned_segments = min(p->num_segments, 8 * p->num_queues);
+	KUNIT_ASSERT_EQ_MSG(test, sum_segments, max_assigned_segments, "val %#llx", val);
+}
+
+struct macb_sram_segments_case macb_sram_segments_cases[] = {
+	/* num_segments can only be powers of two. */
+	{ .num_queues = 4,  .num_segments = 2 },
+	{ .num_queues = 1,  .num_segments = 16 },
+	{ .num_queues = 4,  .num_segments = 16 },
+	{ .num_queues = 5,  .num_segments = 16 },
+	{ .num_queues = 15, .num_segments = 16 },
+	{ .num_queues = 16, .num_segments = 16 },
+};
+
+static void macb_sram_segments_case_desc(struct macb_sram_segments_case *t, char *desc)
+{
+	u64 val = gem_sram_distribute_segments(t->num_queues, t->num_segments);
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "num_queues=%d num_segments=%d TXQSEGALLOC=%#llx",
+		 t->num_queues, t->num_segments, val);
+}
+
+KUNIT_ARRAY_PARAM(macb_sram_segments,
+		  macb_sram_segments_cases,
+		  macb_sram_segments_case_desc);
+
+static struct kunit_case macb_test_cases[] = {
+	KUNIT_CASE_PARAM(macb_sram_segments_test, macb_sram_segments_gen_params),
+	{}
+};
+
+static struct kunit_suite macb_test_suite = {
+	.name = "macb",
+	.test_cases = macb_test_cases,
+};
+
+kunit_test_suite(macb_test_suite);
+
+#endif

-- 
2.53.0


