Return-Path: <netdev+bounces-227531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C9BB21FF
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 02:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8713C1A0F
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 00:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFD19309C;
	Thu,  2 Oct 2025 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0GnKEaA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46213A258;
	Thu,  2 Oct 2025 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364237; cv=none; b=B+gZOmJo7TRYh8Vic08diPFzuhrmMsfXq/BF0tktgaDNCwE2W9IfPUu4Rl6KEFEwLzNWrkibf4O50R6yx3xuBV9vhBecxj33lCtSQEkiW4bnKHLkmstTeS9zkAZboJa3Bf/r2eoeFJcMh4S8HY8j/Ffbps3DuFWhnQFixa5uKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364237; c=relaxed/simple;
	bh=2O4fzqCOyf+vUUowesCYCq4eI3n/1mw1gPvjU5HSA+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V05o050MgEsv8xINnej6JNs01ci9pPdR2l1POUSPuI2tpZOcg5PiokuqrKuwVK00B4fTCEnv9wTS7eBXVeGiDUJDnHJESHEP5Q2jGv/Ks3o8BIn3xd7exBR9nojDr2OjbbLS2VbgLdmoDHTGEYx5iS8VKhsyQPu4pTBdM0yN0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0GnKEaA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759364235; x=1790900235;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2O4fzqCOyf+vUUowesCYCq4eI3n/1mw1gPvjU5HSA+8=;
  b=i0GnKEaApP1GkEyqZtALG+MulFB8/sH6LZILmv3Wt913n3CbGeOY51dk
   7z6X4ik7OE8MAnDtqdD0GR0ho7Un00kB7Q8Hd7hRBdJUcN8YZTSmqivLW
   x/tr9bDiS94HxKn8bjTRBATZYYdDSE8KIZLu6NpRPcVCcVhm+G+qNYAE0
   o/704PtpU2Y4B7KTEJ4ndzST+AeL3XRgeG5ap85nO2c6Q+7oohLr2U/Kc
   n421CAFdkKIyEUfBBLYyVmyr5SGK5iqxrbTbjwu2WEXLqBYf+3nT7/MvB
   8jJmaN3EnMTKoqs+0wx69aVqQkKiF9J7bXVMYqaodEWNUoXoUHW7F+lKc
   g==;
X-CSE-ConnectionGUID: s4Ms9vRtRwic2iBQNZ63pg==
X-CSE-MsgGUID: UDCE5siwSC+IUzSR0sIxug==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61561623"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="61561623"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:11 -0700
X-CSE-ConnectionGUID: A4M4Su10RHWqsoJsUOjJzQ==
X-CSE-MsgGUID: 3E1TxmWUS5+z4KzLa37IEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="184105726"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 01 Oct 2025 17:14:15 -0700
Subject: [PATCH net 5/8] ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-jk-iwl-net-2025-10-01-v1-5-49fa99e86600@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
In-Reply-To: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>, 
 Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=5562;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=X1E+9tweKzHPaj5AhbzWZDHl149/GOPEqPbz8j2vPcU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoy7R1pSThX/WXkjV823MlbpV8ZLo+c3kjZuF9VNlXz16
 m7c3vjVHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzEjYPhnwGjhxjL8yllK/O/
 F8+/c+ZFtPHFtB3n27Y+7PI4eZmXKYfhv2dqtuUSyYPH7/7rf7s65Prkh6+zF1hEFXamRrP6KCW
 ocAEA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Update supported API version and provide handler for
IXGBE_VF_GET_PF_LINK_STATE cmd.
Simply put stored values of link speed and link_up from adapter context.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Link: https://lore.kernel.org/stable/20250828095227.1857066-3-jedrzej.jagielski%40intel.com
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   |  5 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 42 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index 4af149b63a39..f7256a339c99 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -50,6 +50,8 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_12,	/* API version 1.2, linux/freebsd VF driver */
 	ixgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
+	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
+	ixgbe_mbox_api_16,	/* API version 1.6, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -86,6 +88,9 @@ enum ixgbe_pfvf_api_rev {
 
 #define IXGBE_VF_GET_LINK_STATE 0x10 /* get vf link state */
 
+/* mailbox API, version 1.6 VF requests */
+#define IXGBE_VF_GET_PF_LINK_STATE	0x11 /* request PF to send link info */
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN 4
 /* word in permanent address message with the current multicast type */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 32ac1e020d91..b09271d61a4e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -510,6 +510,7 @@ static int ixgbe_set_vf_lpe(struct ixgbe_adapter *adapter, u32 max_frame, u32 vf
 		case ixgbe_mbox_api_12:
 		case ixgbe_mbox_api_13:
 		case ixgbe_mbox_api_14:
+		case ixgbe_mbox_api_16:
 			/* Version 1.1 supports jumbo frames on VFs if PF has
 			 * jumbo frames enabled which means legacy VFs are
 			 * disabled
@@ -1046,6 +1047,7 @@ static int ixgbe_negotiate_vf_api(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
+	case ixgbe_mbox_api_16:
 		adapter->vfinfo[vf].vf_api = api;
 		return 0;
 	default:
@@ -1072,6 +1074,7 @@ static int ixgbe_get_vf_queues(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
+	case ixgbe_mbox_api_16:
 		break;
 	default:
 		return -1;
@@ -1112,6 +1115,7 @@ static int ixgbe_get_vf_reta(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 
 	/* verify the PF is supporting the correct API */
 	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
@@ -1145,6 +1149,7 @@ static int ixgbe_get_vf_rss_key(struct ixgbe_adapter *adapter,
 
 	/* verify the PF is supporting the correct API */
 	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
@@ -1174,6 +1179,7 @@ static int ixgbe_update_vf_xcast_mode(struct ixgbe_adapter *adapter,
 		fallthrough;
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
+	case ixgbe_mbox_api_16:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1244,6 +1250,7 @@ static int ixgbe_get_vf_link_state(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
+	case ixgbe_mbox_api_16:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1254,6 +1261,38 @@ static int ixgbe_get_vf_link_state(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+/**
+ * ixgbe_send_vf_link_status - send link status data to VF
+ * @adapter: pointer to adapter struct
+ * @msgbuf: pointer to message buffers
+ * @vf: VF identifier
+ *
+ * Reply for IXGBE_VF_GET_PF_LINK_STATE mbox command sending link status data.
+ *
+ * Return: 0 on success or -EOPNOTSUPP when operation is not supported.
+ */
+static int ixgbe_send_vf_link_status(struct ixgbe_adapter *adapter,
+				     u32 *msgbuf, u32 vf)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_16:
+		if (hw->mac.type != ixgbe_mac_e610)
+			return -EOPNOTSUPP;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	/* Simply provide stored values as watchdog & link status events take
+	 * care of its freshness.
+	 */
+	msgbuf[1] = adapter->link_speed;
+	msgbuf[2] = adapter->link_up;
+
+	return 0;
+}
+
 static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 {
 	u32 mbx_size = IXGBE_VFMAILBOX_SIZE;
@@ -1328,6 +1367,9 @@ static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 	case IXGBE_VF_IPSEC_DEL:
 		retval = ixgbe_ipsec_vf_del_sa(adapter, msgbuf, vf);
 		break;
+	case IXGBE_VF_GET_PF_LINK_STATE:
+		retval = ixgbe_send_vf_link_status(adapter, msgbuf, vf);
+		break;
 	default:
 		e_err(drv, "Unhandled Msg %8.8x\n", msgbuf[0]);
 		retval = -EIO;

-- 
2.51.0.rc1.197.g6d975e95c9d7


