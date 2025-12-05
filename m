Return-Path: <netdev+bounces-243765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B75BECA6ED6
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 10:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2695B3036B14
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD9C331221;
	Fri,  5 Dec 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hEdgKfur"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494B303A1C;
	Fri,  5 Dec 2025 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925874; cv=none; b=EW61V6mxA7oTBhHgsst4GaQ39FsNtqXBQmABvXPXAH5mkOOjYd9O5/Br1IdMEYIktimwEiIWVitOhqikwdZ1gZy8Bc7GfeXZEDBpEW6UQlAWEdUe9x0q66AmzHj1W/EZOJ1TjXqd914NuAAV3N7S+dJojKXedgkvd7RDItDuvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925874; c=relaxed/simple;
	bh=4HfO8ha2ESXXq9eYSiO3VhQDmPVztdIa0ywC3sxyO1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aSUQTo9+20gABcDHcWCnJfsGhcCF/K+frH5rn4Bp4AUdd8dy2zkvPBnlIzVrtJToETP/PEgXK8cj23IsUzyrmcCpaktzlFGffaoOqVjxVptdchZHvtRUEIdPlkDKTztbr7wMdQ6zO1p1F5XdjfP8R6hBBSV+ieTG9e39ngQBJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hEdgKfur; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B57tw5Z3812638;
	Fri, 5 Dec 2025 01:10:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=eE+2cpz5EYJK34sgxINwas6
	OjVjDcvCvEXZACdjk4bI=; b=hEdgKfurpoSjDLKGVGl9oLW5/bIndANn8a/gmHp
	IvFn/8my8XMGpJ9EuolzMUfVTU+a+HHku4BZFzOeqntyiLWtlg5Tlx5F+xxYB+it
	SFDA7bdBAogZZN4z+VBsjf77fpIB5rBds40zrD3DZqatII9RlZ7KP0kvfT4jLwei
	KlqACn2l1+eN47hR5qc3CGx8XdFf92UyjwXm2nau7Gb/+1s8kQ0JrEOhfKcsgyVp
	6/61DN4AJTpZa0qyeQ6vMSKMr/izlHdscRaTkpT0qBpB3ny+pORniVH4tAOoc/kR
	XtP/ZIYSlHVSJsOcmJBbThIpqGmAPvTEl2EAlWnIwwGwUDA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4auue884ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 01:10:52 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 5 Dec 2025 01:11:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 5 Dec 2025 01:11:03 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 36A8B3F705D;
	Fri,  5 Dec 2025 01:10:51 -0800 (PST)
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
Subject: [PATCH net-next v2] octeon_ep: reset firmware ready status
Date: Fri, 5 Dec 2025 09:10:44 +0000
Message-ID: <20251205091045.1655157-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: d18VczjKgggBk-T3FU9lw7uE-0q35vbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NSBTYWx0ZWRfX3uqTzBft+FYy
 3CD9gTcPlkXFsPPhegca8H1N9g3sAccgzB3rD/UcZk6wm59GS4cQ9bdVXXwvNnlUfpdw5S603M1
 qtlO3/FmQT5XMfHHT6OpeNL1KfGa7MANsl+SN0Wz1hLPb+VFgezunivRazzm0l33tDARsniTc9M
 F3+XbxK2s8lnrdgYPpYXOBXAQ/W7XiOitXVcC/hie7qZesiooiAc0I0kJAnqAf9cE2GnLiKgAg5
 L7M+a4Uqa6TwMgeeByiHVRkp8iKt94ZWAyqd/BNbhYH8R/LaBw5qb1bp7s6YGMaQsSsEg2W/Upp
 pMWEKx5zwBv+HWdzzPsi0H6c0dkAMhnUs9W5xgUlJ4xSS+uAQYzF5I5wSGT9T0E4EhLvnMFHTt1
 MR82qMcaI1OTu4riGc8DANFZJfud8Q==
X-Authority-Analysis: v=2.4 cv=OfuVzxTY c=1 sm=1 tr=0 ts=6932a19c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=v39aYAeCPeV2KakbcL8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: d18VczjKgggBk-T3FU9lw7uE-0q35vbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01

Add support to reset firmware ready status
when the driver is removed(either in unload
or unbind)

Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
V2: Use recommended bit manipulation macros.

V1: https://lore.kernel.org/all/20251120112345.649021-2-vimleshk@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         | 22 +++++++++++++++++++
 .../marvell/octeon_ep/octep_cnxk_pf.c         |  2 +-
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    | 16 ++++++++++++++
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  1 +
 4 files changed, 40 insertions(+), 1 deletion(-)

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
index ca473502d7a0..284959d97ad1 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -383,6 +383,22 @@
 /* bit 1 for firmware heartbeat interrupt */
 #define CN93_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
 
+#define FW_STATUS_DOWNING      0ULL
+#define FW_STATUS_RUNNING      2ULL
+
+#define CN9K_PEM_GENMASK BIT_ULL(36)
+#define CN9K_PF_GENMASK GENMASK_ULL(21, 18)
+#define PFX_CSX_PFCFGX_SHADOW_BIT BIT_ULL(16)
+#define CN9K_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)   ((0x8e0000008000 | (uint64_t)\
+						      FIELD_PREP(CN9K_PEM_GENMASK, pem)\
+						      | FIELD_PREP(CN9K_PF_GENMASK, pf)\
+						      | (PFX_CSX_PFCFGX_SHADOW_BIT & (offset))\
+						      | (rounddown((offset), 8)))\
+						      + ((offset) & BIT_ULL(2)))
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
2.47.0


