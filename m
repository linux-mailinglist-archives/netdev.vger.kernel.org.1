Return-Path: <netdev+bounces-247736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA1CFDF00
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20F9F30DD8BB
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4BE329C7D;
	Wed,  7 Jan 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="d0XN3gIi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD2329392;
	Wed,  7 Jan 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791965; cv=none; b=OEBVXQW8VJPerqhjiI1m+dXfmv/w+jfYv99/7aROdpu4LLx84kpizJwnFqYQ+AKgqKlXTdLluCbKCM1S9rzC4wAutbBJ8KNNiBZhqzxUsF0yu0/33AlukYtr1EaeV1/BS+VacOByeuLnykwOcPAsWFAUvfqw/68bdiCzonjtTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791965; c=relaxed/simple;
	bh=/1RWOwQSFGC89wVNbP16ojfzQ7Ov7ITW0M/8qiDhigU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOF2oSnb6s0DFaAYfUwOgfYR8bDHz2/h/EHwOt+dFL7Kk4PEmcHeOiAF8F25W/d/8v1AWWT9u3Z/XaEanX4VQnqYDioSWc/uNIB7hk5vqRXpW6QYO+vTSDevDaOb9CGDapySaWwvkLCvr+Pe/yDIsmzzsiaILW84nEjVKMqL0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d0XN3gIi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607BjkvU2113136;
	Wed, 7 Jan 2026 05:19:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
	Zx/GFkNmbM70gRkZhy2WGwJTDybAOkuL3R5q7taMXw=; b=d0XN3gIi8P0sm+ALe
	a/AUoKUuiZDUrTcWCCtaDpicMSWrGa0vI8WIB8Yaj/z2aOGWIeIoJ9l3TsFRGE5c
	WgJWB6LBt+3m1AkpT6xWOA0GPNguSj1ZElTfz2lrMByFMshzfnkApiyuw2ZeRkFz
	7wZEwz9hpNdLU3LH2cemqXVjIT8TtdqewcV5ikcLXeQInIvp+CUpD038NeOGslYB
	o0tzThCATIq2IPeBto8PcMigAGHUIL7lxbuDMkIQeN+H2tSX2PK+Ul88W73Mo3k0
	RyqFkmweee+vM4jDDEcsNsGn+yLfLKTZWKU44VK59ayYuEmkWax1uPrK2HCMQ0Ut
	TU7IA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhc3n1bd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:19:15 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:19:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:19:13 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 84D783F704A;
	Wed,  7 Jan 2026 05:19:13 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>
Subject: [PATCH net v3 2/3] octeon_ep: ensure dbell BADDR updation
Date: Wed, 7 Jan 2026 13:18:55 +0000
Message-ID: <20260107131857.3434352-3-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107131857.3434352-1-vimleshk@marvell.com>
References: <20260107131857.3434352-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Lbylz-FJUTwfXSJwtUiDdtbH7IDaieXu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX3T/ibImXZpT2
 bEwMWuJK6h28yA4kgMvYWDoCRKm8/reJZeh7105ekZcm7mXOjtnSGgzohMfj2Q08Th5FXQ1pOnD
 XAtPhH0jD59jWcFiO4ULwG2ZPTd5DJ2TWCMrj9b6HJSeoXXr+N+y1yIE0VZRv7THaDNtoGt4bdl
 29GBi42bFgchuD2yDUmq3Ia3VtdT6hE68rb+d362aJIVUsmwMR5HV9GNk1K6bdL10+esNHHJ/d7
 yOzlaijGecu1P7kxYR8yxyV+N//m8f/Ylrlb+l9fJPQbVkp204uDaAKtyOdKVC+3qXDvcHjQ+5Z
 wqEw/+BoLXlGfSIG8odZ62InV3NRUcKixdVh9vcQHsZUmq8+KRZsufOWOGe2psL3TQrQTTlxSem
 fhnbC+hoz4hgsFi6k+NT0JYp/+TviB3+hXAW7C6ynqZd9XGhk5uTXVMrj0RU7R/jXZ+qPO8EWMz
 IzX/WEk5Boy0oQ128vg==
X-Authority-Analysis: v=2.4 cv=EOILElZC c=1 sm=1 tr=0 ts=695e5d53 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=HhD5TD71VMN5Ao0PvCkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Lbylz-FJUTwfXSJwtUiDdtbH7IDaieXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

Make sure the OUT DBELL base address reflects the
latest values written to it.

Fix:
Add a wait until the OUT DBELL base address register
is updated with the DMA ring descriptor address,
and modify the setup_oq function to properly
handle failures.

Fixes: 0807dc76f3bf5 ("octeon_ep: support Octeon CN10K devices")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
V3:
- Use reverse christmas tree order variable declaration.
- Return error if timeout happens during setup oq.
 
V2: https://lore.kernel.org/all/20251219100751.3063135-3-vimleshk@marvell.com/

V1: https://lore.kernel.org/all/20251212122304.2562229-3-vimleshk@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         |  3 +-
 .../marvell/octeon_ep/octep_cnxk_pf.c         | 46 +++++++++++++++----
 .../ethernet/marvell/octeon_ep/octep_main.h   |  2 +-
 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  4 +-
 4 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index 2574a6061e3d..2a5cebbf1ff8 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -307,7 +307,7 @@ static void octep_setup_iq_regs_cn93_pf(struct octep_device *oct, int iq_no)
 }
 
 /* Setup registers for a hardware Rx Queue  */
-static void octep_setup_oq_regs_cn93_pf(struct octep_device *oct, int oq_no)
+static int octep_setup_oq_regs_cn93_pf(struct octep_device *oct, int oq_no)
 {
 	u64 reg_val;
 	u64 oq_ctl = 0ULL;
@@ -355,6 +355,7 @@ static void octep_setup_oq_regs_cn93_pf(struct octep_device *oct, int oq_no)
 	reg_val = ((u64)time_threshold << 32) |
 		  CFG_GET_OQ_INTR_PKT(oct->conf);
 	octep_write_csr64(oct, CN93_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a PF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 73cd0ca758f0..8d17ff71507f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/jiffies.h>
 
 #include "octep_config.h"
 #include "octep_main.h"
@@ -327,12 +328,14 @@ static void octep_setup_iq_regs_cnxk_pf(struct octep_device *oct, int iq_no)
 }
 
 /* Setup registers for a hardware Rx Queue  */
-static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
+static int octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 {
-	u64 reg_val;
-	u64 oq_ctl = 0ULL;
-	u32 time_threshold = 0;
 	struct octep_oq *oq = oct->oq[oq_no];
+	unsigned long t_out_jiffies;
+	u32 time_threshold = 0;
+	u64 oq_ctl = 0ULL;
+	u64 reg_ba_val;
+	u64 reg_val;
 
 	oq_no += CFG_GET_PORTS_PF_SRN(oct->conf);
 	reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
@@ -343,6 +346,36 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 			reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
 		} while (!(reg_val & CNXK_R_OUT_CTL_IDLE));
 	}
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no),  oq->max_count);
+	/* Wait for WMARK to get applied */
+	usleep_range(10, 15);
+
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
+			  oq->desc_ring_dma);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
+			  oq->max_count);
+	reg_ba_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
+
+	if (reg_ba_val != oq->desc_ring_dma) {
+		t_out_jiffies = jiffies + 10 * HZ;
+		do {
+			if (reg_ba_val == ULLONG_MAX)
+				return -EFAULT;
+			octep_write_csr64(oct,
+					  CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
+					  oq->desc_ring_dma);
+			octep_write_csr64(oct,
+					  CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
+					  oq->max_count);
+			reg_ba_val =
+			octep_read_csr64(oct,
+					 CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
+		} while ((reg_ba_val != oq->desc_ring_dma) &&
+			  time_before(jiffies, t_out_jiffies));
+
+		if (reg_ba_val != oq->desc_ring_dma)
+			return -EAGAIN;
+	}
 
 	reg_val &= ~(CNXK_R_OUT_CTL_IMODE);
 	reg_val &= ~(CNXK_R_OUT_CTL_ROR_P);
@@ -356,10 +389,6 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 	reg_val |= (CNXK_R_OUT_CTL_ES_P);
 
 	octep_write_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no), reg_val);
-	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
-			  oq->desc_ring_dma);
-	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
-			  oq->max_count);
 
 	oq_ctl = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
 
@@ -385,6 +414,7 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 	reg_val &= ~0xFFFFFFFFULL;
 	reg_val |= CFG_GET_OQ_WMARK(oct->conf);
 	octep_write_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a PF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index 81ac4267811c..35d0ff289a70 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -77,7 +77,7 @@ struct octep_pci_win_regs {
 
 struct octep_hw_ops {
 	void (*setup_iq_regs)(struct octep_device *oct, int q);
-	void (*setup_oq_regs)(struct octep_device *oct, int q);
+	int (*setup_oq_regs)(struct octep_device *oct, int q);
 	void (*setup_mbox_regs)(struct octep_device *oct, int mbox);
 
 	irqreturn_t (*mbox_intr_handler)(void *ioq_vector);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 82b6b19e76b4..1581cc468d74 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -170,7 +170,9 @@ static int octep_setup_oq(struct octep_device *oct, int q_no)
 		goto oq_fill_buff_err;
 
 	octep_oq_reset_indices(oq);
-	oct->hw_ops.setup_oq_regs(oct, q_no);
+	if (oct->hw_ops.setup_oq_regs(oct, q_no))
+		goto oq_fill_buff_err;
+
 	oct->num_oqs++;
 
 	return 0;
-- 
2.47.0


