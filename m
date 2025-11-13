Return-Path: <netdev+bounces-238226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9F9C5628A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F833AEA6A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A4332F763;
	Thu, 13 Nov 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JUSi+BQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE55330B15;
	Thu, 13 Nov 2025 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021151; cv=none; b=GELfZr/okZsyLBDAHASJJsuAGa72XBrVk/TWRFA3Hvp2c5JBWM8Z2Cv/f8+IAxqtvOHfUVkJafM2T9EosWy8juabJbcEbWwPApfyfrTLyGg0GPztprNVHKR9hmIncPI+bWUCZ07PWSaexAUvlwEXB5XmPaEAuDBipy259tJU3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021151; c=relaxed/simple;
	bh=zKXX9NyIy8Yg9dI6ML2pPKj7YbBPC2G80b4RqfwIcEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxksTr/DG2gh/CmNscAZsxwInwJT5mR/h5jfo4ruGDzzXWal/mAz7eLFV7Ro+0r44fSbqnsCfm/80nNdtI3Qjh//jcnySOD+2Aab+RH64LO6zOyqAj9DCJxJcwaNk9l9SwQEvP85UkaL2VtZ47DMszTYgZ6Z7j1EXYfolQI2onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JUSi+BQQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gbgI030886;
	Thu, 13 Nov 2025 08:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=EGnnu
	3yZZJmAfxouKKyousdXetQUS7YDyKqAR81Px4I=; b=JUSi+BQQmfQdXQM6EeDAn
	10CcYcsDIqu3CmpReVokWqdkpTPzFg0cLHUco9gNuohVfd/PGKrfg9fwGgvAoCFh
	FvVIoeW+ZuwBZMUFC9W0366HEz+B582kGQNkps8rOukS/EXaJbLE4F+LtBokaBTV
	rpFUPSGmqfAS2/GMVcL6vtEjkV1znrLgchwOtVh9EuxN1oB31I7SRgx68BlfU4T/
	U4zxt+2Rd82eW/21DmzCsRQUSeFhJLuJ5OmkPvzGiYsxRjO7scwQtr1iGZarwedB
	cP5/9faDizcmCEohOuNkt/PiK+FSd7rbuuX7QWaeWCJx4c3b+cjKTx2HIiP0jNX4
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyra949f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:05:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD7Tt0c010098;
	Thu, 13 Nov 2025 08:05:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacarha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:05:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AD85N4Z021139;
	Thu, 13 Nov 2025 08:05:36 GMT
Received: from oracle.home (dhcp-10-154-173-166.vpn.oracle.com [10.154.173.166])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacar3f-2;
	Thu, 13 Nov 2025 08:05:34 +0000
From: gregory.herrero@oracle.com
To: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory Herrero <gregory.herrero@oracle.com>
Subject: [PATCH v2 1/1] i40e: validate ring_len parameter against hardware-specific values.
Date: Thu, 13 Nov 2025 09:04:59 +0100
Message-ID: <20251113080459.2290580-2-gregory.herrero@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113080459.2290580-1-gregory.herrero@oracle.com>
References: <20251113080459.2290580-1-gregory.herrero@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX+lvge5ADH67G
 5H6i8P+wZ/H29XREMtvs57653QZ8ftYAKEf9cn5KOj9bUCo96nNIKEfjP5btU5xF7R9WiQLsJY2
 vifVz/A2OQHaPuLFJvNrGfTtsIlWNTt+aIT9pKF3wn/z/Bc0GMnbca+wR6lUtey9S4lbe7RDNwq
 zOEkWZTpHSqPoI3om0tZhuTIt+FBqnO8kurXC6zSpIzBzA5SzoMFafjtog7qJu28DoafhZ/kA4Q
 cRuZIEMUAOtHOY17ZEH74ONi0Fwg6u/OJiZ9JwKtoisy05X21Vt0aX45dgUEZjhQMEXf/MO71nU
 2PmJaoTfaMZQRm0Q9we6V1QwtBe6Zs3ev+MGs2UOTaeAntzIKiAOPvFB7ZM4zahRsszz+PkpBox
 2XePKF8Gh+n4TU+JKHrohac6u32kyw==
X-Proofpoint-GUID: saUpDi7pARLjMxPZpJP-4sHBYj40AQf0
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=69159151 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=9o2BAfuAlkXtMw4cUEAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: saUpDi7pARLjMxPZpJP-4sHBYj40AQf0

From: Gregory Herrero <gregory.herrero@oracle.com>

The maximum number of descriptors supported by the hardware is hardware
dependent and can be retrieved using i40e_get_max_num_descriptors().
Move this function to a shared header and use it when checking for valid
ring_len parameter rather than using hardcoded value.
Cast info->ring_len to u32 in i40e_config_vsi_tx_queue() as it's u16 in
struct virtchnl_txq_info.
Also cast it in i40e_config_vsi_rx_queue() even if it's u32 in
virtchnl_rxq_info to ease stable backport in case this changed.

By fixing an over-acceptance issue, behavior change could be seen where
ring_len would now be rejected whereas it was not before.

Fixes: 55d225670def ("i40e: add validation for ring_len param")
Signed-off-by: Gregory Herrero <gregory.herrero@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h          | 17 +++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 12 ------------
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c  |  4 ++--
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 801a57a925da..a953cce008f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1418,4 +1418,21 @@ static inline struct i40e_veb *i40e_pf_get_main_veb(struct i40e_pf *pf)
 	return (pf->lan_veb != I40E_NO_VEB) ? pf->veb[pf->lan_veb] : NULL;
 }
 
+/**
+ * i40e_get_max_num_descriptors - get maximum number of descriptors for this hardware.
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


