Return-Path: <netdev+bounces-256157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JptIJiVgWl/HAMAu9opvQ
	(envelope-from <netdev+bounces-256157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:28:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F29B2D53B4
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69715304D1F1
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CCB3793D0;
	Tue,  3 Feb 2026 06:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E0378D8B;
	Tue,  3 Feb 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100046; cv=none; b=LK1jEl0BpYJsrfOG0OxDtJvpiMBd1qLxWIFhztDlIe7kMDl+XgyBnSTcY78MIPSaOCypimHVvLI5C633i1J3iIVZXPmXGm3NGblt8Zsz+ni4z3m7Jf2+ydpWwhT0OvAnfYwv8o8g0rVfafoD5t3WfKBErOnqw/Ew7gIqc3dUVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100046; c=relaxed/simple;
	bh=3N44thLOsJl4A26r2xtzAdcrImAJJC27UdtQIWp8wUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjGrCw/3gr5igLJ/BtJQSWhodtkPvVec0pWMhk8B/bfpHXwzOH0cGWdLbsWtBnpg1LYM3rWMu7s1evu+l0THTUeQ3KNPrFg7QD9grW/lLKDifjipZsrIcaMbxg+92TJ2EiePIehKHhgn31iJsCaFxEyc8ymrm5sBv7BzRuM0IpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8BxVcFJlYFp+0QPAA--.2503S3;
	Tue, 03 Feb 2026 14:27:21 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJDxhcA8lYFpau4+AA--.18085S2;
	Tue, 03 Feb 2026 14:27:14 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yanteng Si <si.yanteng@linux.dev>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 net-next] net: stmmac: Fix typo from clk_scr_i to clk_csr_i
Date: Tue,  3 Feb 2026 14:26:58 +0800
Message-ID: <20260203062658.2156653-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxhcA8lYFpau4+AA--.18085S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF13Ww1fJr4fAF4kWry3Awc_yoW8WFW3pr
	sFqr90kw4YkFWxKws7tryrtr13Gayqk3Wqqws0qw4qvF4qyr40qF1j9r98JFyDWaySyryS
	vr1qgr4ayF97GrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256157-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[loongson.cn];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.dev,foss.st.com,synopsys.com,gmail.com,lists.linux.dev,vger.kernel.org,loongson.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:mid,loongson.cn:email]
X-Rspamd-Queue-Id: F29B2D53B4
X-Rspamd-Action: no action

In include/linux/stmmac.h clk_csr_i is spelled as clk_scr_i by mistake,
so correct the typo.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Update subject line and remove "Cc stable".

 include/linux/stmmac.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index f1054b9c2d8a..1ba583ef6e03 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -28,14 +28,14 @@
  * This could also be configured at run time using CPU freq framework. */
 
 /* MDC Clock Selection define*/
-#define	STMMAC_CSR_60_100M	0x0	/* MDC = clk_scr_i/42 */
-#define	STMMAC_CSR_100_150M	0x1	/* MDC = clk_scr_i/62 */
-#define	STMMAC_CSR_20_35M	0x2	/* MDC = clk_scr_i/16 */
-#define	STMMAC_CSR_35_60M	0x3	/* MDC = clk_scr_i/26 */
-#define	STMMAC_CSR_150_250M	0x4	/* MDC = clk_scr_i/102 */
-#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_scr_i/124 */
-#define	STMMAC_CSR_300_500M	0x6	/* MDC = clk_scr_i/204 */
-#define	STMMAC_CSR_500_800M	0x7	/* MDC = clk_scr_i/324 */
+#define	STMMAC_CSR_60_100M	0x0	/* MDC = clk_csr_i/42 */
+#define	STMMAC_CSR_100_150M	0x1	/* MDC = clk_csr_i/62 */
+#define	STMMAC_CSR_20_35M	0x2	/* MDC = clk_csr_i/16 */
+#define	STMMAC_CSR_35_60M	0x3	/* MDC = clk_csr_i/26 */
+#define	STMMAC_CSR_150_250M	0x4	/* MDC = clk_csr_i/102 */
+#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_csr_i/124 */
+#define	STMMAC_CSR_300_500M	0x6	/* MDC = clk_csr_i/204 */
+#define	STMMAC_CSR_500_800M	0x7	/* MDC = clk_csr_i/324 */
 
 /* MTL algorithms identifiers */
 #define MTL_TX_ALGORITHM_WRR	0x0
-- 
2.47.3


