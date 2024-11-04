Return-Path: <netdev+bounces-141602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A0E9BBB03
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F3A280ED4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3D11CC8A6;
	Mon,  4 Nov 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eSC1O7hP"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B11C6F66;
	Mon,  4 Nov 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739783; cv=none; b=kd0c2a1Yk3Wtwtq1oU1eL8oJMYOooAwfbU/+DomtfVHCp3/GsgelTtZedh0UNmnQheTZsGH3Z295+2aQ+SFKI51NLXLe8xJEVxORu/nJhKxr2xtrUTJWdafbVgi6U5hw/eEV+1IBOzD2ZnocXH2eLw8/Sve2g7RXC7GCEYM7KBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739783; c=relaxed/simple;
	bh=y7ooFwKM+HxJO0eNvOnu1Kq9KYaF4jfFiCs096MOoKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMm19lHtwYwt39E1Xlyv/xzGnq7YL4ooh6fMHZ/Sq0QS8PvuDu5DZ6f4HGDTUtpdIkcuHR8R8hek6ZFW3dGILnD1C0nDZeH2sYELy7a56rBKQk0KYwOo4vy1NM7JFF7mE92ATSqOvMsG7+mFaI37BB4xV8ceQ7ThjQO5Qxn62eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eSC1O7hP; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40BD46000C;
	Mon,  4 Nov 2024 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730739780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9I/jlRO0WchcgVErrYdjy3RxOS1Ge52ZVB9HE9s8lw=;
	b=eSC1O7hP+InxX1J3egif3HK7xuxs3tmmsW0iDMUzzh7MxjPUXdQzBhKKGsUKyS1MOy0hHe
	RmM2gB175SUKXGmuYINgshs5Uf2tl99Nq6Cj0rVz9vpcG201Fp3a+GsjWnsGrtscgAekOV
	vsvTJedmq7VlluY4XBhcLPfpoWQOFQyTXJA1y02t1n6pyK0nAIpdMkreUYpMUoVhMcwzWu
	ItJ0jBnNVe2e3RbWkJhX9L9uO7XL97KqLWxhVy7VaGaN1jQhZ+9rC+ddBO2EvXlASBFS8l
	K4q5hclyNULmelBcrhqPgMd8oTGl7XrcrJDHDmLJc32/nrivISV1MaTIInW5JQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/9] net: stmmac: Introduce dwmac1000 timestamping operations
Date: Mon,  4 Nov 2024 18:02:45 +0100
Message-ID: <20241104170251.2202270-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
References: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

In GMAC3_X, the timestamping configuration differs from GMAC4 in the
layout of the registers accessed to grab the number of snapshots in FIFO
as well as the register offset to grab the aux snapshot timestamp.

Introduce dedicated ops to configure timestamping on dwmac100 and
dwmac1000. The latency correction doesn't seem to exist on GMAC3, so its
corresponding operation isn't populated.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Read the timestamping status from ptpaddr instead of ioaddr

 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   |  7 ++++
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 40 +++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  4 +-
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 11 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  4 ++
 6 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 6f68a6b298c9..1367fa5c9b8e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -549,6 +549,7 @@ extern const struct stmmac_desc_ops ndesc_ops;
 struct mac_device_info;
 
 extern const struct stmmac_hwtimestamp stmmac_ptp;
+extern const struct stmmac_hwtimestamp dwmac1000_ptp;
 extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
 
 extern const struct ptp_clock_info stmmac_ptp_clock_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 01eafeb1272f..600fea8f712f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -331,8 +331,15 @@ enum rtc_control {
 
 /* PTP and timestamping registers */
 
+#define GMAC3_X_ATSNS       GENMASK(19, 16)
+#define GMAC3_X_ATSNS_SHIFT 16
+
 #define GMAC_PTP_TCR_ATSFC	BIT(24)
 #define GMAC_PTP_TCR_ATSEN0	BIT(25)
 
+#define GMAC3_X_TIMESTAMP_STATUS	0x28
+#define GMAC_PTP_ATNR	0x30
+#define GMAC_PTP_ATSR	0x34
+
 extern const struct stmmac_dma_ops dwmac1000_dma_ops;
 #endif /* __DWMAC1000_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index b6930009ea06..dbbd834f9fc8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -553,6 +553,46 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	return 0;
 }
 
+/* DWMAC 1000 HW Timestaming ops */
+
+void dwmac1000_get_ptptime(void __iomem *ptpaddr, u64 *ptp_time)
+{
+	u64 ns;
+
+	ns = readl(ptpaddr + GMAC_PTP_ATNR);
+	ns += readl(ptpaddr + GMAC_PTP_ATSR) * NSEC_PER_SEC;
+
+	*ptp_time = ns;
+}
+
+void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv)
+{
+	struct ptp_clock_event event;
+	u32 ts_status, num_snapshot;
+	unsigned long flags;
+	u64 ptp_time;
+	int i;
+
+	/* Clears the timestamp interrupt */
+	ts_status = readl(priv->ptpaddr + GMAC3_X_TIMESTAMP_STATUS);
+
+	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
+		return;
+
+	num_snapshot = (ts_status & GMAC3_X_ATSNS) >> GMAC3_X_ATSNS_SHIFT;
+
+	for (i = 0; i < num_snapshot; i++) {
+		read_lock_irqsave(&priv->ptp_lock, flags);
+		stmmac_get_ptptime(priv, priv->ptpaddr, &ptp_time);
+		read_unlock_irqrestore(&priv->ptp_lock, flags);
+
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = 0;
+		event.timestamp = ptp_time;
+		ptp_clock_event(priv->ptp_clock, &event);
+	}
+}
+
 /* DWMAC 1000 ptp_clock_info ops */
 
 int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index f425fe3bc22a..13c73df4fbc9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -133,7 +133,7 @@ static const struct stmmac_hwif_entry {
 		.desc = NULL,
 		.dma = &dwmac100_dma_ops,
 		.mac = &dwmac100_ops,
-		.hwtimestamp = &stmmac_ptp,
+		.hwtimestamp = &dwmac1000_ptp,
 		.ptp = &dwmac1000_ptp_clock_ops,
 		.mode = NULL,
 		.tc = NULL,
@@ -152,7 +152,7 @@ static const struct stmmac_hwif_entry {
 		.desc = NULL,
 		.dma = &dwmac1000_dma_ops,
 		.mac = &dwmac1000_ops,
-		.hwtimestamp = &stmmac_ptp,
+		.hwtimestamp = &dwmac1000_ptp,
 		.ptp = &dwmac1000_ptp_clock_ops,
 		.mode = NULL,
 		.tc = NULL,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 5ef52ef2698f..a94829ef8cfb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -269,3 +269,14 @@ const struct stmmac_hwtimestamp stmmac_ptp = {
 	.timestamp_interrupt = timestamp_interrupt,
 	.hwtstamp_correct_latency = hwtstamp_correct_latency,
 };
+
+const struct stmmac_hwtimestamp dwmac1000_ptp = {
+	.config_hw_tstamping = config_hw_tstamping,
+	.init_systime = init_systime,
+	.config_sub_second_increment = config_sub_second_increment,
+	.config_addend = config_addend,
+	.adjust_systime = adjust_systime,
+	.get_systime = get_systime,
+	.get_ptptime = dwmac1000_get_ptptime,
+	.timestamp_interrupt = dwmac1000_timestamp_interrupt,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
index fa4611855311..4cc70480ce0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -96,8 +96,12 @@ enum aux_snapshot {
 
 struct ptp_clock_info;
 struct ptp_clock_request;
+struct stmmac_priv;
 
 int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 			 struct ptp_clock_request *rq, int on);
 
+void dwmac1000_get_ptptime(void __iomem *ptpaddr, u64 *ptp_time);
+void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv);
+
 #endif	/* __STMMAC_PTP_H__ */
-- 
2.47.0


