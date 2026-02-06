Return-Path: <netdev+bounces-257531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UISECwzOhWn0GgQAu9opvQ
	(envelope-from <netdev+bounces-257531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 12:18:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C105FD1D3
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 12:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1949308B43B
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243943A0B33;
	Fri,  6 Feb 2026 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JI9bXTkY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0E396B71;
	Fri,  6 Feb 2026 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376546; cv=none; b=ClO7i3i6AAfZ7GHsJTFEnq+48gHoxPP4MraLQi/TFb4mMxfkDm0hXAwyb2XQqxNE9gNONu/13IwN76eToMYwr7UATZygsudqMXmBYjVdgJp4f+feYlcOzzm67g4uSSDt2e7fl6/zQ3KAp83yMYFdSC/CMSG5e/7qxN9/d3LgyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376546; c=relaxed/simple;
	bh=BwoRp8f+w0LWco/dObx/ll6VLJIn+K5jjO5sDQkIxkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jb97+Y04FF6A2dIJFR3PHaqFzZzOYtFJa6+HxvtqgKTKgibl33uEvKrFyWHLKo004PSIkXQAHQmt13UHdIGfH0ti0Imw1BrPZ0hgcAQjKDVCZYoJ0957ee9+yBbg+N7LdhEMAF6rjWLgUPlDaKRiWUNJOaZo9okSPEJP2kY7seY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JI9bXTkY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6161WwCe3183252;
	Fri, 6 Feb 2026 03:15:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
	qQ+DCP1aHDfgK/9M6tGzZ9m7jAP+vvTq7V4n0R6liE=; b=JI9bXTkYaBKbrtZ7M
	GCq6Lk9McPX9jITUFd5yWWJdjlHiMkdlGebQy8EP8qTdp+RzLBBie+wV5Urmq5k1
	V+Crf/VJh5uRS00bwH2LbTxU/3KU4O9Q4BC6OcpuSKcpW6DWvrxcIEWq0f65jhuX
	hGrVYu+jGBPrFBsluTDxmuKWDXGrolbW3GWcgffb2QLbD9POdH4s2nDviyVgKHzI
	1yUSutzi7Qy/7XQxgkCDEVLkI3DotS3J0pF0mnY6iV2/9UUweSuIBmHBVutYSBgy
	9l21oL/VSldAF6G9oBr5qMZ/VHieirlgn9TPJYVZSyfHArg+axgp7lBS6rj9wA5N
	MFSdw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c4fv3cjr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 03:15:26 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Feb 2026 03:15:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 6 Feb 2026 03:15:41 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id B96FB3F7080;
	Fri,  6 Feb 2026 03:15:24 -0800 (PST)
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
Subject: [PATCH net v4 2/3] octeon_ep: ensure dbell BADDR updation
Date: Fri, 6 Feb 2026 11:15:07 +0000
Message-ID: <20260206111510.1045092-3-vimleshk@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=FIUWBuos c=1 sm=1 tr=0 ts=6985cd4e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=HhD5TD71VMN5Ao0PvCkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SjuWEzNhwSDNx64E-tVFa5JPCohCZccZ
X-Proofpoint-GUID: SjuWEzNhwSDNx64E-tVFa5JPCohCZccZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA3NyBTYWx0ZWRfXyFSXieAU/wDL
 xU5pSeHLj0VL+TQsGavVhLJfrQK6xBQcgVlPMtoUEYxxZ/ok7bR+z2Sb6D0mYFjGne0Qtq9WcRH
 6eykYsdjHBzEPJCN+JE3lxWMatD62vGL+7NXoWPM0oWsh/Z2YrtxtsQE99S7hL/pfBRq1YjRagw
 kz5Xx2edw3J0iUZjKtKBen2IPnvs7ejhug1JaBkZQZvSRGeDDmaZt2G/db8doTDvM29qmNtXDJO
 JwfQLwf0mT6zueXkXPTeUVcVPGRWIuU15GqSJOPZWyX8zbr1u1a9imzMbJmoDW/r2oV7XACmojy
 6/sxVAdrMGCn5NIp6zIFWwA/6/PNz7zZog0i/8HVV8d1J9moWKihza+7/bsryktG5Dj8ROKstOB
 vZCgH3Kd5WFuVutgXbUIatD5CTm9xrKBu2DGq8NsYCkg+Mhyao6FwYyg6e3NyjbllGaALbEro3e
 kz/c+0Tfr1hTgy7GD/w==
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
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257531-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7C105FD1D3
X-Rspamd-Action: no action

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
V4:
- Add a new label to handle oq setup error case properly.

V3:
- Use reverse christmas tree order variable declaration.
- Return error if timeout happens during setup oq.
 
V2: https://lore.kernel.org/all/20251219100751.3063135-3-vimleshk@marvell.com/

V1: https://lore.kernel.org/all/20251212122304.2562229-3-vimleshk@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         |  3 +-
 .../marvell/octeon_ep/octep_cnxk_pf.c         | 46 +++++++++++++++----
 .../ethernet/marvell/octeon_ep/octep_main.h   |  2 +-
 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  8 +++-
 4 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index f0bcb5f3c147..01e82d0b6b2c 100644
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
index 07e00887c694..09a3f1d0645b 100644
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
index 82b6b19e76b4..f2a7c6a76c74 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -12,6 +12,8 @@
 #include "octep_config.h"
 #include "octep_main.h"
 
+static void octep_oq_free_ring_buffers(struct octep_oq *oq);
+
 static void octep_oq_reset_indices(struct octep_oq *oq)
 {
 	oq->host_read_idx = 0;
@@ -170,11 +172,15 @@ static int octep_setup_oq(struct octep_device *oct, int q_no)
 		goto oq_fill_buff_err;
 
 	octep_oq_reset_indices(oq);
-	oct->hw_ops.setup_oq_regs(oct, q_no);
+	if (oct->hw_ops.setup_oq_regs(oct, q_no))
+		goto oq_setup_err;
+
 	oct->num_oqs++;
 
 	return 0;
 
+oq_setup_err:
+	octep_oq_free_ring_buffers(oq);
 oq_fill_buff_err:
 	vfree(oq->buff_info);
 	oq->buff_info = NULL;
-- 
2.47.0


