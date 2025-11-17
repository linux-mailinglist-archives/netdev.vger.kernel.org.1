Return-Path: <netdev+bounces-239047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B07C62E8A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFCF0358980
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0503E31D370;
	Mon, 17 Nov 2025 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xe+AK79N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D927B32C;
	Mon, 17 Nov 2025 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368490; cv=none; b=mGS5A9EAiPx/3iDMrBO44Ljh4vd0B2ViovXnaNDno7OZkU22gsnqnF/4qXICw2QT7ZK04VmFUMC+vWR6w58uqw3/5I05yMM88BonchKQ3ZwBQH8vMFWMmDSWz1E2LrWpDSiqWY5i6Fiq2qO2dyiLIzF9gSVgDPeaChV1zU89BUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368490; c=relaxed/simple;
	bh=mBwg8jRltLqowVNBdscE8rc2KN7beSIlGMPsr71My/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifPNdLCY2auTJkh1tGgSDlBSU3LFbYjdpzv+aYgXbV//B4KgBYWk7rQmvdOQUlAb09Q1ULEWu8/u/4JfaDNIFgIszxE3E/sis+Pq6XcQTtDCNeNEktdaN8+nhTwB/LLFvk2VmlBbl8c2qPaENhWTkhBNndgPPytSu5eCp4IiOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xe+AK79N; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH1wPvo003715;
	Mon, 17 Nov 2025 08:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=qMXLl
	VhcfnUf7wi2zzvCliazJHkUmvrDl+TfQPBoScg=; b=Xe+AK79NjlRULdOMay0p6
	A13I+AF+Tq/DrJG8QHM6WdY3hEA1L3l33gtq3KRv4/DQEURRp8EAqeZBFBZ6p9VA
	tUTmaPQLZI/X81u8nFIW6z2fByDJGoAQHkV1rXz4KLpcgx/PAnp7iH+JFf8DCG3h
	Pyv3w5ktx4j1fic/sQCRXwkP+X1RPhixp+KqdEVOe/w7aD4acMMbxrmIub7h6yoC
	n7/LkLZy/SV4RSC4bV2S7xoU3BiVZEFItT2RiQFZuqmwJ2VGJ6ztq5tAJekviH9x
	RLEX98l87Zsnkq945wyBufj6oCvt8xeWX4nfio3i5jI2Al7oHiyz8Lzsukk4uQPv
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbt06r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 08:34:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH8ARWs009646;
	Mon, 17 Nov 2025 08:34:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybd1pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 08:34:37 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AH8YHL8013986;
	Mon, 17 Nov 2025 08:34:36 GMT
Received: from oracle.home (dhcp-10-154-174-115.vpn.oracle.com [10.154.174.115])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4aefybd10b-2;
	Mon, 17 Nov 2025 08:34:35 +0000
From: gregory.herrero@oracle.com
To: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory Herrero <gregory.herrero@oracle.com>
Subject: [PATCH v4 1/1] i40e: validate ring_len parameter against hardware-specific values
Date: Mon, 17 Nov 2025 09:33:26 +0100
Message-ID: <20251117083326.2784380-2-gregory.herrero@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117083326.2784380-1-gregory.herrero@oracle.com>
References: <20251117083326.2784380-1-gregory.herrero@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170071
X-Proofpoint-GUID: DJtfxHSizBoq3HiI4vSEiSggDMylumUJ
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691ade1d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=2JYSdunga3JKcJtQgaIA:9 cc=ntf awl=host:13643
X-Proofpoint-ORIG-GUID: DJtfxHSizBoq3HiI4vSEiSggDMylumUJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX1McKrI4I0F2g
 5cB2rAfOswB0Xz7m+lailJnXLv/y4Dvc97YlnyXoMQqLrviKUpesTSLYd5yqp3HjZLIqoJiQgco
 s4v6ijnTRc9z03ozYwxKINRMoxHcKe/FGbNIzTV2LgcJDVxfFAG2Q4x1k3JmWk3M5khstt4a3CH
 3UBnpnYJImYVUtO/+C9cndNVQfDiZkgNqFIubKhZG3UL+EGUoxuGEpnVuxgxYLLmM+rA+NMAbBZ
 1OnSlM1a+3XYqwVFU/S6dQIDPRI1u7AOQ7DObArOYQvWJW2WTMpP+sEVmIagi5r0RBTBPV6Qmx6
 QYMnIEWiYpGP2rtZkBwJFZ+huaupCQ/0Jp0jzqSIX9BuY2OxzWPAO30Ay4iX3ADXssLbUgPXa6l
 Q4WvULBhhvAUCp8zcvLmlgjJSwgj6QG98m4EPXyLlO5gzgtWl9w=

From: Gregory Herrero <gregory.herrero@oracle.com>

The maximum number of descriptors supported by the hardware is hardware
dependent and can be retrieved using i40e_get_max_num_descriptors().
Move this function to a shared header and use it when checking for valid
ring_len parameter rather than using hardcoded value.

By fixing an over-acceptance issue, behavior change could be seen where
ring_len could now be rejected while configuring rx and tx queues if its
size is larger than the hardware-specific maximum number of descriptors.

Fixes: 55d225670def ("i40e: add validation for ring_len param")
Signed-off-by: Gregory Herrero <gregory.herrero@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 18 ++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ------------
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 801a57a925da..5b367397ae43 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1418,4 +1418,22 @@ static inline struct i40e_veb *i40e_pf_get_main_veb(struct i40e_pf *pf)
 	return (pf->lan_veb != I40E_NO_VEB) ? pf->veb[pf->lan_veb] : NULL;
 }
 
+/**
+ * i40e_get_max_num_descriptors - get maximum number of descriptors for this
+ * hardware.
+ * @pf: pointer to a PF
+ *
+ * Return: u32 value corresponding to the maximum number of descriptors.
+ **/
+static inline u32 i40e_get_max_num_descriptors(const struct i40e_pf *pf)
+{
+	const struct i40e_hw *hw = &pf->hw;
+
+	switch (hw->mac.type) {
+	case I40E_MAC_XL710:
+		return I40E_MAX_NUM_DESCRIPTORS_XL710;
+	default:
+		return I40E_MAX_NUM_DESCRIPTORS;
+	}
+}
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
index 081a4526a2f0..cf831c649c9c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -656,7 +656,7 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* ring_len has to be multiple of 8 */
 	if (!IS_ALIGNED(info->ring_len, 8) ||
-	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+	    info->ring_len > i40e_get_max_num_descriptors(pf)) {
 		ret = -EINVAL;
 		goto error_context;
 	}
@@ -726,7 +726,7 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* ring_len has to be multiple of 32 */
 	if (!IS_ALIGNED(info->ring_len, 32) ||
-	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+	    info->ring_len > i40e_get_max_num_descriptors(pf)) {
 		ret = -EINVAL;
 		goto error_param;
 	}
-- 
2.51.0


