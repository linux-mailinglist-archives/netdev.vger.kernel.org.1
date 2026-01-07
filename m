Return-Path: <netdev+bounces-247737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AF9CFDF27
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 689D53091F42
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EAE328608;
	Wed,  7 Jan 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BgEOvD49"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747F32824D;
	Wed,  7 Jan 2026 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791973; cv=none; b=MjPbKLuD2N3fvZE4rhv5Ucv5YrCz3lotkggPnAVCQmCRyIWRoVdJQtvGtyq5GyHEusT+YuxPGZT4+CS98UZqZBs5FvvAX99HD0PXR28SAYB4sZVnXezrmMqKzi0aYt7zvG7d4VAT7PBJWK0H1z1rqFyIa9gwVRIaQdb5PnUgp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791973; c=relaxed/simple;
	bh=XZgEfBRlm8Icq/d1lLQH/pTfgxm8Gb4CfGRr76LU9iY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+oO6nagxt1y7wRIGw9vF4qz+gUuiUmkAso8EbjXxAQhpzGjb5ECb8HvJuceiDvtnii7/Ay7VZMjE8oKp5Es61vGGqWMno9UQYOaFLsV37I0QJV3s3LpKzM7EABKnXBtPGisintIq6DdzkJd1RrLIwYc30EgKBoD/ETfWdRhX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BgEOvD49; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6071Ldir2795726;
	Wed, 7 Jan 2026 05:19:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
	X8qP0tdIHTcwnkxPdknFT4VQWL38/oIaz5svLxCnlE=; b=BgEOvD49XKQarwQcv
	YI6K/8CZpvcBVIfbpBIVsTyv+CTSA0ExSVemdQgkdOSr/Qm/HmUTYh6cJ5doB5qE
	6ICttJXxpGonYjuy4Pa87owJM/VgFsdZYeKV3lqjyP8OMeZvr4wNJRdmTpe964CH
	LRDansUTfPL8mhx9jwYQ9XeluyHA6nxSAaJQge6hQiolOubQa3ZQdsdq0vsB9mnH
	yzKky5hog7VyXR1MWpbITEKggQvrpkSm/DCN1DnGrZgAEOtfMaQsTtEu5XGM+AYA
	f6QcqCi20icLZlgzQnqxNpxx4gpb8nEZKiPwUfuitcMtrfSWtVrouB4mQcNEQ8QU
	3nWLw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bgf3fw1hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:19:18 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:19:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:19:31 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 9E2443F704A;
	Wed,  7 Jan 2026 05:19:16 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net v3 3/3] octeon_ep_vf: ensure dbell BADDR updation
Date: Wed, 7 Jan 2026 13:18:56 +0000
Message-ID: <20260107131857.3434352-4-vimleshk@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=PLgCOPqC c=1 sm=1 tr=0 ts=695e5d56 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=9s7rcsES4n5jIWhP9eIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX1RRc3EyiXZCj
 4wyhtuPJ93ny+jfRKsMu+4gfqfOXLSIEoFVKWxUeLjFjcZ8+J52KdX0JrsImM8rKnuGJmHiQEbh
 zLPshSiPyzIUWidKM/AhzblbCGlToXxvy7dBygh/Bn2UzcwgPwzMMnNLnTBT+eodCR8Ms3ae7eQ
 GrCTrDju2a6sufiWrOJRBFE+xFOvnIIi9d3NcegoaWO/Snr3hLMBb51M2c5UdmQvK+4cz9hVD3X
 LHqYOCslbCt5/vRXljUbsVSxjztIjUV4xB/MMONDvI1dInkwz9W6M/yGEjqWE9YMchKuUqvrWnF
 XxA4+fXMIby45rMYvSFfYGMmAzge5SKGmvCGcO+/5VKD83OBD2OejTDeDnhOq/C28gktMAAT4Pf
 0Dah08c9XVYrcgrgDj/xMIJr5H1liPY53RgVsj7Sw8L6SHbAQSc4NOoz8kql8npQ7uBaWNfqMAv
 oGRXhXss89hZMHchBow==
X-Proofpoint-GUID: Mg6Uzxfj6zxL_9a35aaU4KMeI3aZbU6S
X-Proofpoint-ORIG-GUID: Mg6Uzxfj6zxL_9a35aaU4KMeI3aZbU6S
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

Fixes: 2c0c32c72be29 ("octeon_ep_vf: add hardware configuration APIs")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
V3:
- Use reverse christmas tree order variable declaration.
- Return error if timeout happens during setup oq.

V2: https://lore.kernel.org/all/20251219100751.3063135-4-vimleshk@marvell.com/

V1: https://lore.kernel.org/all/20251212122304.2562229-4-vimleshk@marvell.com/

 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  3 +-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 39 +++++++++++++++++--
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  4 +-
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
index 88937fce75f1..4c769b27c278 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
@@ -196,7 +196,7 @@ static void octep_vf_setup_iq_regs_cn93(struct octep_vf_device *oct, int iq_no)
 }
 
 /* Setup registers for a hardware Rx Queue  */
-static void octep_vf_setup_oq_regs_cn93(struct octep_vf_device *oct, int oq_no)
+static int octep_vf_setup_oq_regs_cn93(struct octep_vf_device *oct, int oq_no)
 {
 	struct octep_vf_oq *oq = oct->oq[oq_no];
 	u32 time_threshold = 0;
@@ -239,6 +239,7 @@ static void octep_vf_setup_oq_regs_cn93(struct octep_vf_device *oct, int oq_no)
 	time_threshold = CFG_GET_OQ_INTR_TIME(oct->conf);
 	reg_val = ((u64)time_threshold << 32) | CFG_GET_OQ_INTR_PKT(oct->conf);
 	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a VF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
index 1f79dfad42c6..a968b93a6794 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
@@ -199,11 +199,13 @@ static void octep_vf_setup_iq_regs_cnxk(struct octep_vf_device *oct, int iq_no)
 }
 
 /* Setup registers for a hardware Rx Queue  */
-static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
+static int octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 {
 	struct octep_vf_oq *oq = oct->oq[oq_no];
+	unsigned long t_out_jiffies;
 	u32 time_threshold = 0;
 	u64 oq_ctl = ULL(0);
+	u64 reg_ba_val;
 	u64 reg_val;
 
 	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
@@ -214,6 +216,38 @@ static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 			reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
 		} while (!(reg_val & CNXK_VF_R_OUT_CTL_IDLE));
 	}
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_no),
+			     oq->max_count);
+	/* Wait for WMARK to get applied */
+	usleep_range(10, 15);
+
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no),
+			     oq->desc_ring_dma);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(oq_no),
+			     oq->max_count);
+	reg_ba_val = octep_vf_read_csr64(oct,
+					 CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no));
+	if (reg_ba_val != oq->desc_ring_dma) {
+		t_out_jiffies = jiffies + 10 * HZ;
+		do {
+			if (reg_ba_val == ULLONG_MAX)
+				return -EFAULT;
+			octep_vf_write_csr64(oct,
+					     CNXK_VF_SDP_R_OUT_SLIST_BADDR
+					     (oq_no), oq->desc_ring_dma);
+			octep_vf_write_csr64(oct,
+					     CNXK_VF_SDP_R_OUT_SLIST_RSIZE
+					     (oq_no), oq->max_count);
+			reg_ba_val =
+			octep_vf_read_csr64(oct,
+					    CNXK_VF_SDP_R_OUT_SLIST_BADDR
+					    (oq_no));
+		} while ((reg_ba_val != oq->desc_ring_dma) &&
+			  time_before(jiffies, t_out_jiffies));
+
+		if (reg_ba_val != oq->desc_ring_dma)
+			return -EAGAIN;
+	}
 
 	reg_val &= ~(CNXK_VF_R_OUT_CTL_IMODE);
 	reg_val &= ~(CNXK_VF_R_OUT_CTL_ROR_P);
@@ -227,8 +261,6 @@ static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 	reg_val |= (CNXK_VF_R_OUT_CTL_ES_P);
 
 	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no), reg_val);
-	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no), oq->desc_ring_dma);
-	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
 
 	oq_ctl = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
 	/* Clear the ISIZE and BSIZE (22-0) */
@@ -250,6 +282,7 @@ static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 	reg_val &= ~GENMASK_ULL(31, 0);
 	reg_val |= CFG_GET_OQ_WMARK(oct->conf);
 	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a VF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
index b9f13506f462..c74cd2369e90 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
@@ -55,7 +55,7 @@ struct octep_vf_mmio {
 
 struct octep_vf_hw_ops {
 	void (*setup_iq_regs)(struct octep_vf_device *oct, int q);
-	void (*setup_oq_regs)(struct octep_vf_device *oct, int q);
+	int (*setup_oq_regs)(struct octep_vf_device *oct, int q);
 	void (*setup_mbox_regs)(struct octep_vf_device *oct, int mbox);
 
 	irqreturn_t (*non_ioq_intr_handler)(void *ioq_vector);
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index d70c8be3cfc4..6446f6bf0b90 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -171,7 +171,9 @@ static int octep_vf_setup_oq(struct octep_vf_device *oct, int q_no)
 		goto oq_fill_buff_err;
 
 	octep_vf_oq_reset_indices(oq);
-	oct->hw_ops.setup_oq_regs(oct, q_no);
+	if (oct->hw_ops.setup_oq_regs(oct, q_no))
+		goto oq_fill_buff_err;
+
 	oct->num_oqs++;
 
 	return 0;
-- 
2.47.0


