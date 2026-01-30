Return-Path: <netdev+bounces-255162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP+7IpK9fGlVOgIAu9opvQ
	(envelope-from <netdev+bounces-255162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:17:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E463DBB858
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A51293002B59
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74ED2EB87E;
	Fri, 30 Jan 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZbTIsvfX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC72BF3D7;
	Fri, 30 Jan 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782580; cv=none; b=C3XXrSPoqnv2vEIMye4wTjggQAnCcPf0QXYoTZFEox3FZx/p3Sj+HlrNNzPybaVDOcs775bmBfbyVTkthg1U5HL9A4pPq6TxpCz6mi9OZvUB6GUJ25o1TQvJmmI+4XHSEMau0XAFGyYudTNrG1uc5XYpb3xNQ0uz88ehamFjp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782580; c=relaxed/simple;
	bh=gsKC0zaiIawdpqHIM2SJnRUt8D2667wj6rp34hRdTaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRtQOYSI9gvUHrKlAkKh+d7F2/qum94SOGJC68wEZifvTXKZefrdmsPhFv1LtSr6Z9P3ZLW4DYgNI51euNH3/kBnpapUt1m3lg78X1Ehs+NHMSs/AFbaFK7rwAfHaxarHdH0p+BVs3bQQ2SpS9xKa0T5HmvPcwEOvo3OQqtjMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZbTIsvfX; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UB0pKa1373464;
	Fri, 30 Jan 2026 06:16:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
	A4Z9AZGj6MgXH+XaiZrFZxX4YjzVClXqMqL5rUA8j0=; b=ZbTIsvfXeYKRL3I/F
	iZ2aGVpcTMCqtKsiOdEEyn8nbtJ1M6Kj0lW8VYzeysbEJ/twpgz8frWRHbROgjKq
	pItbfsAs3iJczd5fAtUNEYZWMWAPOH+gtllRl06TerYeTq2WwkaJ4smfs2X00WaI
	+jlq6bGsBKfJfYiPIpHxKw5pMWiLJlmvnk0UFLgWfcTqQVuAEbO/Cvp1gC8dzExI
	eeuvMtfY2ogw01fGHywNINakY/rLKH+28ZenfGHAs+7fCDZFHCOK5yzidEF08xSZ
	YHLf0+mmY8wXulEFULIs41dAZ+F1ySNd9KHtzhZyI7PS+kDqi8hUpN0YEquaZtq8
	hD5Wg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c0ucx8aqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 06:16:05 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 Jan 2026 06:16:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 30 Jan 2026 06:16:19 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id F19EB3F70E3;
	Fri, 30 Jan 2026 06:16:03 -0800 (PST)
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
        Satananda Burla
	<sburla@marvell.com>,
        "Abhijit Ayarekar" <aayarekar@marvell.com>
Subject: [PATCH RESEND net v3 1/3] octeon_ep: disable per ring interrupts
Date: Fri, 30 Jan 2026 14:15:45 +0000
Message-ID: <20260130141549.827020-2-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130141549.827020-1-vimleshk@marvell.com>
References: <20260130141549.827020-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: udCVEN9CI5jZk0lNY0_zXGomgO0y732t
X-Authority-Analysis: v=2.4 cv=T92BjvKQ c=1 sm=1 tr=0 ts=697cbd25 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=BjJIY8cOur314jIlsncA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: udCVEN9CI5jZk0lNY0_zXGomgO0y732t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDExNiBTYWx0ZWRfX3ZMxcQviD2L3
 89GtXz9BNv4PbqDsei7e9bG+OuFvADCSxWid9WoEg4Re8CWNQ8S+zlYArcz286tcASHbvkCqpAf
 mBWZliF0Rt9+tM0/9RwUaa8vI0KGJhjOUojPR5aZIiX+TtwZ6wBexZ2j5DYdbD+8Mn87HFTC159
 HwUEvZ8QX9uGSvrYqDVKGjY+cv9zWEnWXqYEd2MEtvwI3rV5COH+cHf4ep2oNVVugUWcfdKCnF7
 GCK/JywqHc7qCAo3jjZmLwY8kkJWnspzM0ds2B2FtUKX3kDLmldj8EiafGcQTbVjqBTkb8ANY0F
 g4hL0ohsgle5l6IkATJ70UXCCfemmW403HWACFCMwznAYM/leiMzks5hY1psm0PrEn250u8nu0S
 koEkCqVuPw3l5BIlaSIj5Zhb4ocvtzl7mTSIKtpu1ZL05IO61eyjm8wyNfcIPFbwuubHpmH/Sw9
 h5PFk4NhHSKgKpWDttQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255162-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: E463DBB858
X-Rspamd-Action: no action

Disable the MSI-X per ring interrupt for every PF ring when PF
netdev goes down.

Fixes: 1f2c2d0cee023 ("octeon_ep: add hardware configuration APIs")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
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
index b5805969404f..2574a6061e3d 100644
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
+		intr_mask |= (BIT_ULL(srn + i));
+		reg_val = octep_read_csr64(oct,
+					   CN93_SDP_R_IN_INT_LEVELS(srn + i));
+		reg_val &= (~CN93_INT_ENA_BIT);
+		octep_write_csr64(oct,
+				  CN93_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct,
+					   CN93_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= (~CN93_INT_ENA_BIT);
+		octep_write_csr64(oct,
+				  CN93_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CN93_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 5de0b5ecbc5f..73cd0ca758f0 100644
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
+		reg_val &= (~CNXK_INT_ENA_BIT);
+		octep_write_csr64(oct,
+				  CNXK_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct,
+					   CNXK_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= (~CNXK_INT_ENA_BIT);
+		octep_write_csr64(oct,
+				  CNXK_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CNXK_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CNXK_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
index ca473502d7a0..42cb199bd085 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -386,5 +386,6 @@
 #define CN93_PEM_BAR4_INDEX            7
 #define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
 #define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)
+#define CN93_INT_ENA_BIT	(BIT_ULL(62))
 
 #endif /* _OCTEP_REGS_CN9K_PF_H_ */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
index e637d7c8224d..9eaadded9c50 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
@@ -412,5 +412,6 @@
 #define CNXK_PEM_BAR4_INDEX		7
 #define CNXK_PEM_BAR4_INDEX_SIZE	0x400000ULL
 #define CNXK_PEM_BAR4_INDEX_OFFSET	(CNXK_PEM_BAR4_INDEX * CNXK_PEM_BAR4_INDEX_SIZE)
+#define CNXK_INT_ENA_BIT	(BIT_ULL(62))
 
 #endif /* _OCTEP_REGS_CNXK_PF_H_ */
-- 
2.47.0


