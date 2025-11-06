Return-Path: <netdev+bounces-236412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980DC3BF77
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9346242D7
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A554346E40;
	Thu,  6 Nov 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FP5outQi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671893446C4;
	Thu,  6 Nov 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441415; cv=none; b=DI+PwsadwYbyRQknM+O8+sFO+Lw17tg0O6LylJvrM+5GnTBhCciWT/Uqzwph/5hEAJXPDdGz4wkFgyYgXvJDlCYSQN30saglYNSjJCe5ujQR8EDay8hFeYhLzfRvLMP1E7r2c4gblkVz8uiVmWfXcBxt/PvLECfPS+KxzTIGXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441415; c=relaxed/simple;
	bh=c0J0R5lf0yRz6IhPcaWUy1ymKbmyPY9nGF9EVVnFmYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8Fksy+JVPnp2mzkEY+nAXuPAsHS/ORlBs0UVRuts7FbxgwJTts2siEYfjwIH4qYXxb6fm+uDQE8MW60X2+tv1t5SrelwnGdPtRZeYfxNzdUgwwZfNQOBP1aexRIBs8r1aZgL+EP2ms9akE89oTH1zdzorrt6JbVzjhc8KBFFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FP5outQi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CCcck002496;
	Thu, 6 Nov 2025 15:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mIu+0
	BvpPUMYahbiUlctpgUApoi9d+74Wsa3M0aMNqE=; b=FP5outQixiRpYpbZBPKjT
	5uv081FlLoeqJPvtUwjV/IID2YbueGwB1/SU2nQhukHz6POisl4NZbCq1TasZKjT
	3xOrp2OlbMeukKAMc4yRHjwMEV6Iz2XJrfzQAbVSrY57TSlNT4ganAt9p38EKkh8
	fVng/h3ImnDTS2ap9Uj2/A3Hm5r4VQnrNJH3FL1UGzV2I4NiMpFWTduKrP2JhGUI
	ofHsfCsWMp92Uj2pqsL2d6vpUkDT6yLleb8lo5zs9NAiaUsG5DHyohnxlDT/wD0c
	K9o+KJuHkIKEmkAJS9OKbtJ8GuriYOO8t91Vbns9vJ/VXQI1CLLbpKx2KCP01UFN
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqwa7rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 15:03:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6E1PvD039714;
	Thu, 6 Nov 2025 15:03:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc8mh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 15:03:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6ExlIX013458;
	Thu, 6 Nov 2025 15:03:15 GMT
Received: from oracle (dhcp-10-154-170-248.vpn.oracle.com [10.154.170.248])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58nc8m6b-2;
	Thu, 06 Nov 2025 15:03:14 +0000
From: gregory.herrero@oracle.com
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory Herrero <gregory.herrero@oracle.com>
Subject: [PATCH] i40e: validate ring_len parameter against hardware specific values.
Date: Thu,  6 Nov 2025 16:02:47 +0100
Message-ID: <20251106150248.721025-2-gregory.herrero@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106150248.721025-1-gregory.herrero@oracle.com>
References: <20251106150248.721025-1-gregory.herrero@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060119
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=690cb8b5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=2JYSdunga3JKcJtQgaIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: N0Ikuwr29JWU9Bog8HWqNJfzf0tkhQBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfXz/c8ZsJHL/u/
 iYLeJOYf9bSIYfvY4EAZwr0fpKLd90wD/8xMTHGiTsVaCvAAIx1uYXPg1jC7z8K87ItyBkX3TNt
 u/vUETCWMGYh5qNK98zfoEX2lWeDgKH3wIBvYSbgQuw+a7xCJFwwvr1+EXlKFLjkhgxiRfZTGqc
 ZlvVVVPAQqxY6TlqYSe0wa0AHwZoFfUfdudmeb00ZfwopYtDesC7YJl8vpIxdEJvdVORhbUZxnJ
 ez9NIO75MyaMmEHIXb6hXAwndSmH6k+Qk3WfCP/4ZvBVEF2ImWYnut6M0BFVjD4pFR6y54es6B8
 tnFoZxML7kexbl5FWXl5mXN0aoU+GVuCtI5UhbXMjPg3azi2P6/woMu0ubxTHBQuYGseFb0qtI1
 7HnVzOfMo4dDlwychtnIYJBnnP1kVA==
X-Proofpoint-GUID: N0Ikuwr29JWU9Bog8HWqNJfzf0tkhQBn

From: Gregory Herrero <gregory.herrero@oracle.com>

The maximum number of descriptors supported by the hardware is hardware
dependent and can be retrieved using i40e_get_max_num_descriptors().
Move this function to a shared header and use it when checking for valid
ring_len parameter rather than using hardcoded value.
Cast info->ring_len to u32 in i40e_config_vsi_tx_queue() as it's u16 in
struct virtchnl_txq_info.
Also cast it in i40e_config_vsi_rx_queue() even if it's u32 in
virtchnl_rxq_info to ease stable backport in case this changed.

Fixes: 55d225670def ("i40e: add validation for ring_len param")
Signed-off-by: Gregory Herrero <gregory.herrero@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 18 ++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ------------
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 801a57a925da..0e697375fcaf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1418,4 +1418,22 @@ static inline struct i40e_veb *i40e_pf_get_main_veb(struct i40e_pf *pf)
 	return (pf->lan_veb != I40E_NO_VEB) ? pf->veb[pf->lan_veb] : NULL;
 }
 
+/**
+ * i40e_get_max_num_descriptors - get maximum descriptors number for this hardware.
+ * @pf: pointer to a PF
+ *
+ * Return: u32 value corresponding to maximum descriptors number.
+ **/
+static inline u32 i40e_get_max_num_descriptors(struct i40e_pf *pf)
+{
+	struct i40e_hw *hw = &pf->hw;
+
+	switch (hw->mac.type) {
+	case I40E_MAC_XL710:
+		return I40E_MAX_NUM_DESCRIPTORS_XL710;
+	default:
+		return I40E_MAX_NUM_DESCRIPTORS;
+	}
+}
+
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 86c72596617a..61c39e881b00 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2013,18 +2013,6 @@ static void i40e_get_drvinfo(struct net_device *netdev,
 		drvinfo->n_priv_flags += I40E_GL_PRIV_FLAGS_STR_LEN;
 }
 
-static u32 i40e_get_max_num_descriptors(struct i40e_pf *pf)
-{
-	struct i40e_hw *hw = &pf->hw;
-
-	switch (hw->mac.type) {
-	case I40E_MAC_XL710:
-		return I40E_MAX_NUM_DESCRIPTORS_XL710;
-	default:
-		return I40E_MAX_NUM_DESCRIPTORS;
-	}
-}
-
 static void i40e_get_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *ring,
 			       struct kernel_ethtool_ringparam *kernel_ring,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 081a4526a2f0..5e058159057b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -656,7 +656,7 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* ring_len has to be multiple of 8 */
 	if (!IS_ALIGNED(info->ring_len, 8) ||
-	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+	    (u32)info->ring_len > i40e_get_max_num_descriptors(pf)) {
 		ret = -EINVAL;
 		goto error_context;
 	}
@@ -726,7 +726,7 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* ring_len has to be multiple of 32 */
 	if (!IS_ALIGNED(info->ring_len, 32) ||
-	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+	    (u32)info->ring_len > i40e_get_max_num_descriptors(pf)) {
 		ret = -EINVAL;
 		goto error_param;
 	}
-- 
2.51.0


