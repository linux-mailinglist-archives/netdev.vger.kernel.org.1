Return-Path: <netdev+bounces-257530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCsbHtzNhWn0GgQAu9opvQ
	(envelope-from <netdev+bounces-257530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 12:17:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C298FD1BB
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 12:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88DCF3075F93
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE539B486;
	Fri,  6 Feb 2026 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JnQKDK29"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB95B399032;
	Fri,  6 Feb 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376544; cv=none; b=qVwKmfQMoF4W3RYccWkraBRsrdIYCC72eFVxvnE2R6Bm2WJUy3bjA5qpBxAJQ0w0PNC2QZmuNjIWGPR7ukzd5I8nsMs4irEvhdJGiJYH3ldL8txcg+w0iSrz4z47VMBXUm7MQiBm0IaNJ7ZYmesoJaRrW/DgiD3aLRxjtQek+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376544; c=relaxed/simple;
	bh=2RQne5gSCjbojQ1Xri2wXVrbdOocfQbdtNtiW1Qlrpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxuOjYZ7YAuInKB5YYwJUsgzbp90ivY9kq7AaX3doHKNUxOH1S8EvjcJpj2t1AN6MHWf6GJ5kGrGPPRTkt+EYSP6vfIGpilf6d5ltQ/TIsM8qPR0zhJ2KFnjn3e6digAE6KT7VE0rGhBFzoMDeQx4MGt4j1xb538oteDxqgS+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JnQKDK29; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JrmEA258820;
	Fri, 6 Feb 2026 03:15:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	cNut/x6Ns4ih77e2HsHwvS8FBMRhnBy0jK+Bywxl/0=; b=JnQKDK29ISQqg1o7D
	y9lc9kSzl+Gq/Iqc28EmBgPxviUDJ9jPBOOrr/BB+PSCKzKdsn5BxhBxfxIhSu57
	APDJf2ZKByYhAg5SCh/Pt/uQMwwJuj9h5tJbJ7wPCzgo4GYhiZ2EmZLw4x6BHq/3
	jOSSZPYbvNDNHn0ZOo33Zshkj3IFwPFRQjOKGYRpOqBqmskPbFEndvm3LcRBBFhe
	iVS4te5lddb1eWYKlTeN9DyCZJqOSDjgcd/vHPPFiA39MmcrLWRZ56ftjFEsDXrG
	95oX0XyPxwEPOC2QpGKYgGHtBYXdbKO3fRemN0pv/KVKp5AplN17IGxFv4UlvK5Q
	SF2fw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c45e4xc3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 03:15:30 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Feb 2026 03:15:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 6 Feb 2026 03:15:46 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 1FBBF3F7080;
	Fri,  6 Feb 2026 03:15:29 -0800 (PST)
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
Subject: [PATCH net v4 3/3] octeon_ep_vf: ensure dbell BADDR updation
Date: Fri, 6 Feb 2026 11:15:08 +0000
Message-ID: <20260206111510.1045092-4-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206111510.1045092-1-vimleshk@marvell.com>
References: <20260206111510.1045092-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GKFh913UnAhc0i_eqZ5S0x99Zu88EfcO
X-Proofpoint-ORIG-GUID: GKFh913UnAhc0i_eqZ5S0x99Zu88EfcO
X-Authority-Analysis: v=2.4 cv=COonnBrD c=1 sm=1 tr=0 ts=6985cd52 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=9s7rcsES4n5jIWhP9eIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA3NyBTYWx0ZWRfX8qdECtHaPGZW
 xyzYORYgcsbhINjwP3OQOocWh3fq+yms/eh+/e6iGZ4qxTVns0PY8fNl/m1jquF8zUMLLuvlz6+
 NJP08jBbkUu/owHZDVMydBkbI2ZsFd9m6K5ORV3hVT3GHdjfO9l3oeg4BXHxs/ffxlp46WhhuHE
 y1Jy8/t93WxMkbs6n7pSH1IRBnOPW+jm+3jD4LmMU4N3HzvVsRKNX37VQLkZVCWv9xZx/rDlFSu
 vkVymkMlerAQHzMxfisvL+vIsz7emWkwWkyhgFC7pHc/tjkKxl03mpPZJT1ME3sLX/7v7XJIRPl
 H4WAbP2Xsjg6sDyifsi3MXJWqCHBZI4yCgxacUMcCG8qQ/7XR5C/Jxlk4LGki2FqODidhY/Pyd6
 YEmsyRJ4MH63/8LxPDr23N+GfMGCtdMjR9o+sv+jYR8XVojVQEVf00ahbJGa0IeyqkDmrywfBFd
 lJ8eK66mkhSRMl5sLvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257530-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.989];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1C298FD1BB
X-Rspamd-Action: no action

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
V4:
- Add a new label to handle oq setup error case properly.

V3:
- Use reverse christmas tree order variable declaration.
- Return error if timeout happens during setup oq.

V2: https://lore.kernel.org/all/20251219100751.3063135-4-vimleshk@marvell.com/

V1: https://lore.kernel.org/all/20251212122304.2562229-4-vimleshk@marvell.com/

 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  3 +-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 39 +++++++++++++++++--
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  8 +++-
 4 files changed, 46 insertions(+), 6 deletions(-)

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
index d70c8be3cfc4..6f865dbbba6c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -12,6 +12,8 @@
 #include "octep_vf_config.h"
 #include "octep_vf_main.h"
 
+static void octep_vf_oq_free_ring_buffers(struct octep_vf_oq *oq);
+
 static void octep_vf_oq_reset_indices(struct octep_vf_oq *oq)
 {
 	oq->host_read_idx = 0;
@@ -171,11 +173,15 @@ static int octep_vf_setup_oq(struct octep_vf_device *oct, int q_no)
 		goto oq_fill_buff_err;
 
 	octep_vf_oq_reset_indices(oq);
-	oct->hw_ops.setup_oq_regs(oct, q_no);
+	if (oct->hw_ops.setup_oq_regs(oct, q_no))
+		goto oq_setup_err;
+
 	oct->num_oqs++;
 
 	return 0;
 
+oq_setup_err:
+	octep_vf_oq_free_ring_buffers(oq);
 oq_fill_buff_err:
 	vfree(oq->buff_info);
 	oq->buff_info = NULL;
-- 
2.47.0


