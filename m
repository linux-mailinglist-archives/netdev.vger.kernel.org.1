Return-Path: <netdev+bounces-228457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E8DBCB40B
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 02:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A5918914F6
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217F211499;
	Fri, 10 Oct 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IX4fFBUp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE118A6CF;
	Fri, 10 Oct 2025 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054657; cv=none; b=JLXFs4N3n21Jk7auL3MIg+vTZng8+fUt+wUFgDWZMYrCXRhp1O1FV2o9D6Rb8FfDtelyYm6V8hn6MSrM8FbkFZdOHvT6mBu/EripWWuqB7zt4sBE6g2mMPszWCsKap2IFDQsnee8EZI34fMZEOoV13brG+c1R+ymV/GOBXetShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054657; c=relaxed/simple;
	bh=eduPU7wWCs8zAVaitAd4sKGnjYvi8D+VzudXvzq2Sqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcRr3RFKpbKA5xL0p3ISmh/vwUDm+mjifo3GKQvn1+dEDpRMtu2nBvpF6yYp7Pvr7Sa/Mx++GgoJ2aSNbVgvXrAyMBFBx4vKKpL3BuHfzGKlOqpJB7tBLitkw2qDXeaEbpAQygMPUDnZBg1eMWME28eeQVBYy4XoZn/yL91VRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IX4fFBUp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760054655; x=1791590655;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eduPU7wWCs8zAVaitAd4sKGnjYvi8D+VzudXvzq2Sqo=;
  b=IX4fFBUp3CGYMpTiR/LE2mGcrf6cUJxUg921N3DOfBALnea1nEbBYEej
   iH4DlZEZCivagMwKFh+EUa+t7GAVacp2ib6AIxGCnP57xq9vL5ZaFG24k
   JrK8nlAs4nb1FpGPe4/0bjluUCOdOY1bmHVV4U3Tptk5GqtqfqJ8urAdB
   B42/1EmnS9KxE/IicLCMUA2CLpCDGK7cFpZo15k74XQzhyWlxmYi88c2a
   lZrc8Unrm+AT7aL8ybJXHzYiBRdtDmmUH25Hg8Lz2iOggXB8adVQfmV0U
   yGdvxbEoPM+8ziQq1exbltMyK0Wy1nUsNelGxCQY6GEhMIsLOAp9PPyrx
   Q==;
X-CSE-ConnectionGUID: Q9O0+MNRR/yb1b0FPacUWA==
X-CSE-MsgGUID: pgF3mu4MTbK9P3w/k7/Skw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62316100"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="62316100"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:10 -0700
X-CSE-ConnectionGUID: uzG1v20hTvCOAyvQrxYmGQ==
X-CSE-MsgGUID: wt7zEQV7RXyd69AHFuoAVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180858281"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 09 Oct 2025 17:03:50 -0700
Subject: [PATCH net v3 5/6] ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox
 cmd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-jk-iwl-net-2025-10-01-v3-5-ef32a425b92a@intel.com>
References: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
In-Reply-To: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.15-dev-89294
X-Developer-Signature: v=1; a=openpgp-sha256; l=5967;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=PdICJJfpUzWF+GQ6nT06zC3A3sdlZO5ik1Z2bGsX5dg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowXvuVzbu+tWcIymemXascSlq7vH5WUnse+yzVfvSZBv
 cfp7zTLjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACbCIczwP3izBdueuTc86+Zr
 nXS/3NTDcrW6yMKhf6ows6acZUi5KCPDDb7WyYb2sqmHrLKTJA35HwTOnM30vq3a9ctChre17CL
 sAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Send to VF information about features supported by the PF driver.

Increase API version to 1.7.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   | 10 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 37 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index f7256a339c99..0334ed4b8fa3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -52,6 +52,7 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
 	ixgbe_mbox_api_16,	/* API version 1.6, linux/freebsd VF driver */
+	ixgbe_mbox_api_17,	/* API version 1.7, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -91,6 +92,9 @@ enum ixgbe_pfvf_api_rev {
 /* mailbox API, version 1.6 VF requests */
 #define IXGBE_VF_GET_PF_LINK_STATE	0x11 /* request PF to send link info */
 
+/* mailbox API, version 1.7 VF requests */
+#define IXGBE_VF_FEATURES_NEGOTIATE	0x12 /* get features supported by PF */
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN 4
 /* word in permanent address message with the current multicast type */
@@ -101,6 +105,12 @@ enum ixgbe_pfvf_api_rev {
 #define IXGBE_VF_MBX_INIT_TIMEOUT 2000 /* number of retries on mailbox */
 #define IXGBE_VF_MBX_INIT_DELAY   500  /* microseconds between retries */
 
+/* features negotiated between PF/VF */
+#define IXGBEVF_PF_SUP_IPSEC		BIT(0)
+#define IXGBEVF_PF_SUP_ESX_MBX		BIT(1)
+
+#define IXGBE_SUPPORTED_FEATURES	IXGBEVF_PF_SUP_IPSEC
+
 struct ixgbe_hw;
 
 int ixgbe_read_mbx(struct ixgbe_hw *, u32 *, u16, u16);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index b09271d61a4e..ee133d6749b3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -511,6 +511,7 @@ static int ixgbe_set_vf_lpe(struct ixgbe_adapter *adapter, u32 max_frame, u32 vf
 		case ixgbe_mbox_api_13:
 		case ixgbe_mbox_api_14:
 		case ixgbe_mbox_api_16:
+		case ixgbe_mbox_api_17:
 			/* Version 1.1 supports jumbo frames on VFs if PF has
 			 * jumbo frames enabled which means legacy VFs are
 			 * disabled
@@ -1048,6 +1049,7 @@ static int ixgbe_negotiate_vf_api(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		adapter->vfinfo[vf].vf_api = api;
 		return 0;
 	default:
@@ -1075,6 +1077,7 @@ static int ixgbe_get_vf_queues(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -1;
@@ -1115,6 +1118,7 @@ static int ixgbe_get_vf_reta(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 
 	/* verify the PF is supporting the correct API */
 	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_17:
 	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -1149,6 +1153,7 @@ static int ixgbe_get_vf_rss_key(struct ixgbe_adapter *adapter,
 
 	/* verify the PF is supporting the correct API */
 	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_17:
 	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -1180,6 +1185,7 @@ static int ixgbe_update_vf_xcast_mode(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1251,6 +1257,7 @@ static int ixgbe_get_vf_link_state(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1278,6 +1285,7 @@ static int ixgbe_send_vf_link_status(struct ixgbe_adapter *adapter,
 
 	switch (adapter->vfinfo[vf].vf_api) {
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		if (hw->mac.type != ixgbe_mac_e610)
 			return -EOPNOTSUPP;
 		break;
@@ -1293,6 +1301,32 @@ static int ixgbe_send_vf_link_status(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+/**
+ * ixgbe_negotiate_vf_features -  negotiate supported features with VF driver
+ * @adapter: pointer to adapter struct
+ * @msgbuf: pointer to message buffers
+ * @vf: VF identifier
+ *
+ * Return: 0 on success or -EOPNOTSUPP when operation is not supported.
+ */
+static int ixgbe_negotiate_vf_features(struct ixgbe_adapter *adapter,
+				       u32 *msgbuf, u32 vf)
+{
+	u32 features = msgbuf[1];
+
+	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_17:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	features &= IXGBE_SUPPORTED_FEATURES;
+	msgbuf[1] = features;
+
+	return 0;
+}
+
 static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 {
 	u32 mbx_size = IXGBE_VFMAILBOX_SIZE;
@@ -1370,6 +1404,9 @@ static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 	case IXGBE_VF_GET_PF_LINK_STATE:
 		retval = ixgbe_send_vf_link_status(adapter, msgbuf, vf);
 		break;
+	case IXGBE_VF_FEATURES_NEGOTIATE:
+		retval = ixgbe_negotiate_vf_features(adapter, msgbuf, vf);
+		break;
 	default:
 		e_err(drv, "Unhandled Msg %8.8x\n", msgbuf[0]);
 		retval = -EIO;

-- 
2.51.0.rc1.197.g6d975e95c9d7


