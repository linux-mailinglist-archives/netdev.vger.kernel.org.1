Return-Path: <netdev+bounces-228455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBC3BCB405
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 02:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F21C04EA9D1
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 00:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B31B3930;
	Fri, 10 Oct 2025 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hClJU5iM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F686347;
	Fri, 10 Oct 2025 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054655; cv=none; b=XSuujzGbqNZ+XvMIi64ePN4saqfmJQ69Flm9+gIsKeV7NaNu6vQ27WI9VXAm/EldBfu/fiX4lOhAulFhda+cj716MKL2/sM3t+mBgU2wfmHY2/+x3uvybMMVHMn7H3rQ+y68tnUanQFEcedHmpAX1+Yv7cMHmdapPsYIuiRl4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054655; c=relaxed/simple;
	bh=+V5lrywCj3i8hHmaCLmJst2BSMbLJiNvxdIn69lTYRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piyL8vjCuMhqE+sJtV+Z2sldgEqNX1kxyLImPYvcO/XthU/N/5os10JSgEmtUN9mj6Qjh1+Et5+il83NxMERvbOF3YK6bbo5PriuyeaZYN+Uj4e/umGa2OnOY/1ekmGAgvIOzNROrwbWk6aoZfmyU4d1fDDtWu08u4posoe+Jg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hClJU5iM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760054654; x=1791590654;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+V5lrywCj3i8hHmaCLmJst2BSMbLJiNvxdIn69lTYRc=;
  b=hClJU5iMvnmDdL87JJPS0imJN8e3nbbCzsmiMFQ3tTWyfbMzIe5iFmz+
   x+dkXp8LPcpOWZC7sK8mkUCD2woHtgSUhJ6B079BdA57radX5KbIUsgdQ
   C3JexP6E47ui8SDZ7gYEZijbjvGSgQ41o08CEh1IqCIO9odDFt2oBMUzb
   +h531+oRus6X5V7ZcVZIYbkL0bwfUFEwbD4/zCAUK6LERzByU9xUhOJ9h
   4qw1lPoPuFvEPVBYWKULrcxIv/u58XWG9R2xm4kG8dK54+u5mAqit1a7z
   ACXLuu4JXEOd6oTPZl76ctj+G1bLksO54yYqHU7w3n0zMPFaQX0lKzOXo
   w==;
X-CSE-ConnectionGUID: ffKL9uqoS3OhcFE/xMFGtA==
X-CSE-MsgGUID: ODB15Y73Qku8fcJDmL6ipA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62316088"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="62316088"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:09 -0700
X-CSE-ConnectionGUID: /SnLVndsSwSTGSaz+zf/fQ==
X-CSE-MsgGUID: hXN7t4AOQiO/aepIlnz05w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180858275"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 09 Oct 2025 17:03:48 -0700
Subject: [PATCH net v3 3/6] ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE
 mailbox operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-jk-iwl-net-2025-10-01-v3-3-ef32a425b92a@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5618;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=WveGSDHApHh1gyC1vDVAz7ivD6vjeZ/2lXnfVNk+0nM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowXvuXuaqcL9TO3S6R5c9U1b2+53f7zdq/0K9GH9j/cV
 /FlVGh0lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJHUPob/VXIWO7PFllXMPX9l
 muP0e5ar1un/se+5F230YVtRxMZtzYwMEzWzilt3nTXeMIGBMcymmrVS85RZoJjoX/4fcR0OC9f
 xAAA=
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
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
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


