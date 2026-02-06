Return-Path: <netdev+bounces-257529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAGgG8nNhWn0GgQAu9opvQ
	(envelope-from <netdev+bounces-257529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 12:17:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4702FD1A5
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 12:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA4D301F9A1
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 11:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D838B9AB;
	Fri,  6 Feb 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Bu6mxPBG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140CA3064BA;
	Fri,  6 Feb 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376543; cv=none; b=K6zuT3p7b17LEOQX691d4qBG6k0/0vFXMm/wuSJypHRHnCddTtNZKG5w/+vojWwMv94GSUDQ3Bb+FVuk60VAzrN/mF42h8NSGOiqIDG2/GWZGJiQXwM4eGRFlZmx2u7IXBz2sjNQn6hQwdnRVdLIMOUVqb3jg0hYRRyJ6lZMcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376543; c=relaxed/simple;
	bh=nm47jSBddajOPE6uU/VQ/mMAKK3P02gBv5GjatQMqpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gv4ZfGCwol7wqbmtP+zL+PNMIg+Gz+Tx/Cqrqh9LLYWCiyUcSyGRTCvDbJIj/TC36Rs6Mdroy69znMkx4SWsgbBCJXbV34KqVqOCUs2TyBGykliDmJML0BRxoXYfW6thmMbTb1VOzDtePULJzRkX4sen84zvfT2leP0oMAwKTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Bu6mxPBG; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6167CIgT076786;
	Fri, 6 Feb 2026 03:15:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
	PItX5notp9uh72gb6/VBSCYsTp3Te3hz2iHO+EPsLE=; b=Bu6mxPBGzd6+ML8sQ
	NY4eea0T6kdvUR6Z3zmWjOK0EN4fg2wPt1BsCBW9G7+7Ht1aEFL38yyqQsfm1qG5
	YwWqySefuH/WjQIK5dwMT+m1QHyAAx05ygEFoLDRWkeLJYyOHSrxQkn0U+Xfxgfg
	7IzNm7TcIDX47/OhRXNNoRCiCGnwl5KG+ltWUEtYeGtBc5Mexrfi6Pr4MwDaY+cP
	mgesLzCl/MsQzHK7WYpfBm3KC+quZW9nHN06MzAhCJOJlp+L+s4mqNPbU9G0t3JB
	cu9tU94DNr0a0uUAYlDR61wA3bxKr8l3DN0DOVLdEye7lnXC6LtLLulXM46Rt6HQ
	cr+bw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c45e4xc3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 03:15:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Feb 2026 03:15:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 6 Feb 2026 03:15:36 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id AEC713F7080;
	Fri,  6 Feb 2026 03:15:19 -0800 (PST)
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
        "Paolo Abeni" <pabeni@redhat.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: [PATCH net v4 1/3] octeon_ep: disable per ring interrupts
Date: Fri, 6 Feb 2026 11:15:06 +0000
Message-ID: <20260206111510.1045092-2-vimleshk@marvell.com>
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
X-Proofpoint-GUID: jAJInlJ59T7x9dQFAQDPZYmbBPOisNMy
X-Proofpoint-ORIG-GUID: jAJInlJ59T7x9dQFAQDPZYmbBPOisNMy
X-Authority-Analysis: v=2.4 cv=COonnBrD c=1 sm=1 tr=0 ts=6985cd49 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=BjJIY8cOur314jIlsncA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA3NyBTYWx0ZWRfX83ehs0UXSVK4
 8O3jt/o0/3gPjDdDCF9X1WOtWaSce0/FYwgfczDlWSOCBAdGHgTzikhrsxsgcAiZnH5QBIhNOCT
 zorfxvN4Ii8PpSMCbP8UPYb4PvYIv0NR5UDVjg4om9tdgMKOKf1Oi+25Svi7TcbbuECgcpTxpVw
 d8hFbE7Z9vzsz1iWphw8xl3DzhZGiV0Wm+IeV9OahDhtrahbB0wLtU463Zfl7UJHhaQa4MQQR0V
 7njEm7mmRNWkyhYxMRRrY+XCApZHn4PfHLcboK8PV52h8GaevEuk8K4yTwBBfdMbfa2SwwsJzu6
 J7p6qL7EcGqUlL7ML13vw6HXJak8xLZ9Vw10NRL0FsCmSelP2p9NHGk5rEvhU4xPB8+lRtsQQ3g
 DvYU7UEYeul6H69+bF83L2+wT/jp/wvS09d7KwOrvO8NcXHFQzTJW1IeV4kJwcJ/6c/aX8ryI0+
 Zr7vNXyCN5MGZNJfk3g==
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
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257529-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C4702FD1A5
X-Rspamd-Action: no action

Disable the MSI-X per ring interrupt for every PF ring when PF
netdev goes down.

Fixes: 1f2c2d0cee023 ("octeon_ep: add hardware configuration APIs")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
V4:
- Remove unnecessary brackets.

V3:
- No change

V2: https://lore.kernel.org/all/20251219100751.3063135-2-vimleshk@marvell.com/

V1: https://lore.kernel.org/all/20251212122304.2562229-2-vimleshk@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_cn9k_pf.c | 18 +++++++++++++++---
 .../ethernet/marvell/octeon_ep/octep_cnxk_pf.c | 18 +++++++++++++++---
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h     |  1 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h     |  1 +
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index b5805969404f..f0bcb5f3c147 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -696,14 +696,26 @@ static void octep_enable_interrupts_cn93_pf(struct octep_device *oct)
 /* Disable all interrupts */
 static void octep_disable_interrupts_cn93_pf(struct octep_device *oct)
 {
-	u64 intr_mask = 0ULL;
+	u64 reg_val, intr_mask = 0ULL;
 	int srn, num_rings, i;
 
 	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
 	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
 
-	for (i = 0; i < num_rings; i++)
-		intr_mask |= (0x1ULL << (srn + i));
+	for (i = 0; i < num_rings; i++) {
+		intr_mask |= BIT_ULL(srn + i);
+		reg_val = octep_read_csr64(oct,
+					   CN93_SDP_R_IN_INT_LEVELS(srn + i));
+		reg_val &= ~CN93_INT_ENA_BIT;
+		octep_write_csr64(oct,
+				  CN93_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct,
+					   CN93_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= ~CN93_INT_ENA_BIT;
+		octep_write_csr64(oct,
+				  CN93_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CN93_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 5de0b5ecbc5f..07e00887c694 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -720,14 +720,26 @@ static void octep_enable_interrupts_cnxk_pf(struct octep_device *oct)
 /* Disable all interrupts */
 static void octep_disable_interrupts_cnxk_pf(struct octep_device *oct)
 {
-	u64 intr_mask = 0ULL;
+	u64 reg_val, intr_mask = 0ULL;
 	int srn, num_rings, i;
 
 	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
 	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
 
-	for (i = 0; i < num_rings; i++)
-		intr_mask |= (0x1ULL << (srn + i));
+	for (i = 0; i < num_rings; i++) {
+		intr_mask |= BIT_ULL(srn + i);
+		reg_val = octep_read_csr64(oct,
+					   CNXK_SDP_R_IN_INT_LEVELS(srn + i));
+		reg_val &= ~CNXK_INT_ENA_BIT;
+		octep_write_csr64(oct,
+				  CNXK_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct,
+					   CNXK_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= ~CNXK_INT_ENA_BIT;
+		octep_write_csr64(oct,
+				  CNXK_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CNXK_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CNXK_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
index ca473502d7a0..95f1dfff90cc 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -386,5 +386,6 @@
 #define CN93_PEM_BAR4_INDEX            7
 #define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
 #define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)
+#define CN93_INT_ENA_BIT	BIT_ULL(62)
 
 #endif /* _OCTEP_REGS_CN9K_PF_H_ */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
index e637d7c8224d..4d172a552f80 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
@@ -412,5 +412,6 @@
 #define CNXK_PEM_BAR4_INDEX		7
 #define CNXK_PEM_BAR4_INDEX_SIZE	0x400000ULL
 #define CNXK_PEM_BAR4_INDEX_OFFSET	(CNXK_PEM_BAR4_INDEX * CNXK_PEM_BAR4_INDEX_SIZE)
+#define CNXK_INT_ENA_BIT	BIT_ULL(62)
 
 #endif /* _OCTEP_REGS_CNXK_PF_H_ */
-- 
2.47.0


