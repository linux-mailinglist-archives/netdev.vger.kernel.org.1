Return-Path: <netdev+bounces-240355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE96C73BE1
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02D5435FB16
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1303330B2D;
	Thu, 20 Nov 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DLMfXmxB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3F307AE0;
	Thu, 20 Nov 2025 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637856; cv=none; b=VqRAkjPE+nZ5JLh1wxIwg+EzgRDtn7ef/ZqAqOqfb9gj3Tdh4ZOlZZ8JEZ2f6SOAcmCloy8Zri3/xBayISozgPjRqPRTOGaOy6yMUXQ8ip7JajKUf2zmomz5tJ81ZyHFh7ngTj981F3VE69KwP42m13QvwRpgMFbeQn7aAXRBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637856; c=relaxed/simple;
	bh=8RonGxCcyBG+3rJi4gkKN8VNOtXn9I1rr1bwBki2m4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZxH7/Nwr36H4Ni9oalgcj9sNcs9+QJ/GbV5OyvtZA0nhOLkswsAKOp155jzluLZOih60yBeba+G2T9gV2WgcxNRwZbzDM+BN/5PcARrZnNflp2gbn19u6KAUWBr0hoi2n/hutXI1Nyp6xJ2fxjx6jLFUMMQSjCMA7J+ubcCZuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DLMfXmxB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK26i6H1205474;
	Thu, 20 Nov 2025 03:23:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
	ozDvoyXszF5BQuweIrxROZxJvUT6nOcR3H66smJK6Y=; b=DLMfXmxBw4CxZElJs
	4oZ/7xAn7JI/AU4Tt7ylqhZclEIKxUbOvL4xCgNzWnUsKg2jrD9zqS2z/dEkIYO0
	uGKbhjwuScjCWCbZuQBmm46d6B7J3tklatu/PpzCpPjlk+ZHb63KKMnmCjsVqHux
	TuaJPa5A6ksNvoSPj6yq0dABVsHM/rGOtPO5dJw9brCB4+Y8uPrt2aUCQYZDgrVU
	QbZiaeVwZe4tniwZmevwA/F17+/kiy6AAoMa20n0wNlxETokaew+BC8kN4UsqX+t
	oG5ESwKR+JTpql0Wgz/r/z/AkryoNu+X/c4BPjiIgEU2bFbw4+TomehRlD6m7beZ
	lOZMQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ahswnh6vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 03:23:58 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 20 Nov 2025 03:23:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 20 Nov 2025 03:23:57 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 6E7B63F70D2;
	Thu, 20 Nov 2025 03:23:57 -0800 (PST)
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
Subject: [PATCH net-next v1 1/1] octeon_ep: reset firmware ready status
Date: Thu, 20 Nov 2025 11:23:44 +0000
Message-ID: <20251120112345.649021-2-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120112345.649021-1-vimleshk@marvell.com>
References: <20251120112345.649021-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kUkmHHCYCyr1ZlSjl_MkYP0LBlew2knk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA3MSBTYWx0ZWRfX+qzxy0/xMiD1
 QPFiUSkfC4RmczDg8A9qwpDfj+DncoLho4cAtHsqc24goGAH2qYInpyEOmiFhiCKz/Cmx+hXV1E
 vUDZijSICkPkNfCaOOhHres0WQ6NsX/8hpxXw0/a0tc9JUnTrMgvWERI7g3GN54J6U1EBJKE3dR
 FZaTNC+K5GtILzqNIRrOUjzDZiq1F3msDFj1DfVAeZmmj9vUusrMh4kVbBYXvZm98JxDPF7hegH
 Ha9ocGwnLC0Clf0OuMwMiWJqvrXzBTvIYBPZolFFyjtHHZBeNutbixIiCpInOmgJ38AYzPqBumz
 BkaaS6KBRFxaBy901ILC/l550J0yIp47sRJUPQ3XXOcTPFfsoGsLwVV0VmB1NvF4vvlUL5UCzAr
 pCaVKux/lB35z5Nja5cFpDoOGmA6+w==
X-Authority-Analysis: v=2.4 cv=IuYTsb/g c=1 sm=1 tr=0 ts=691efa4e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=v39aYAeCPeV2KakbcL8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: kUkmHHCYCyr1ZlSjl_MkYP0LBlew2knk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_04,2025-11-20_01,2025-10-01_01

Add support to reset firmware ready status
when the driver is removed(either in unload
or unbind)

Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
 .../marvell/octeon_ep/octep_cn9k_pf.c         | 22 +++++++++++++++++++
 .../marvell/octeon_ep/octep_cnxk_pf.c         |  2 +-
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    | 11 ++++++++++
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index b5805969404f..6f926e82c17c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -637,6 +637,17 @@ static int octep_soft_reset_cn93_pf(struct octep_device *oct)
 
 	octep_write_csr64(oct, CN93_SDP_WIN_WR_MASK_REG, 0xFF);
 
+	/* Firmware status CSR is supposed to be cleared by
+	 * core domain reset, but due to a hw bug, it is not.
+	 * Set it to RUNNING right before reset so that it is not
+	 * left in READY (1) state after a reset.  This is required
+	 * in addition to the early setting to handle the case where
+	 * the OcteonTX is unexpectedly reset, reboots, and then
+	 * the module is removed.
+	 */
+	OCTEP_PCI_WIN_WRITE(oct, CN9K_PEMX_PFX_CSX_PFCFGX(0, 0, CN9K_PCIEEP_VSECST_CTL),
+			    FW_STATUS_DOWNING);
+
 	/* Set core domain reset bit */
 	OCTEP_PCI_WIN_WRITE(oct, CN93_RST_CORE_DOMAIN_W1S, 1);
 	/* Wait for 100ms as Octeon resets. */
@@ -894,4 +905,15 @@ void octep_device_setup_cn93_pf(struct octep_device *oct)
 
 	octep_init_config_cn93_pf(oct);
 	octep_configure_ring_mapping_cn93_pf(oct);
+
+	if (oct->chip_id == OCTEP_PCI_DEVICE_ID_CN98_PF)
+		return;
+
+	/* Firmware status CSR is supposed to be cleared by
+	 * core domain reset, but due to IPBUPEM-38842, it is not.
+	 * Set it to RUNNING early in boot, so that unexpected resets
+	 * leave it in a state that is not READY (1).
+	 */
+	OCTEP_PCI_WIN_WRITE(oct, CN9K_PEMX_PFX_CSX_PFCFGX(0, 0, CN9K_PCIEEP_VSECST_CTL),
+			    FW_STATUS_RUNNING);
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 5de0b5ecbc5f..e07264b3dbf8 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -660,7 +660,7 @@ static int octep_soft_reset_cnxk_pf(struct octep_device *oct)
 	 * the module is removed.
 	 */
 	OCTEP_PCI_WIN_WRITE(oct, CNXK_PEMX_PFX_CSX_PFCFGX(0, 0, CNXK_PCIEEP_VSECST_CTL),
-			    FW_STATUS_RUNNING);
+			    FW_STATUS_DOWNING);
 
 	/* Set chip domain reset bit */
 	OCTEP_PCI_WIN_WRITE(oct, CNXK_RST_CHIP_DOMAIN_W1S, 1);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
index ca473502d7a0..d7fa5adbce98 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -383,6 +383,17 @@
 /* bit 1 for firmware heartbeat interrupt */
 #define CN93_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
 
+#define FW_STATUS_DOWNING      0ULL
+#define FW_STATUS_RUNNING      2ULL
+#define CN9K_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)      ((0x8e0000008000 | (uint64_t)(pem) << 36 \
+							| (pf) << 18 \
+							| (((offset) >> 16) & 1) << 16 \
+							| ((offset) >> 3) << 3) \
+							+ ((((offset) >> 2) & 1) << 2))
+
+/* Register defines for use with CN9K_PEMX_PFX_CSX_PFCFGX */
+#define CN9K_PCIEEP_VSECST_CTL  0x4D0
+
 #define CN93_PEM_BAR4_INDEX            7
 #define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
 #define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
index e637d7c8224d..a6b6c9f356de 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
@@ -396,6 +396,7 @@
 #define CNXK_SDP_EPF_OEI_RINT_DATA_BIT_MBOX	BIT_ULL(0)
 /* bit 1 for firmware heartbeat interrupt */
 #define CNXK_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
+#define FW_STATUS_DOWNING      0ULL
 #define FW_STATUS_RUNNING      2ULL
 #define CNXK_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)      ({ typeof(offset) _off = (offset); \
 							  ((0x8e0000008000 | \
-- 
2.34.1


