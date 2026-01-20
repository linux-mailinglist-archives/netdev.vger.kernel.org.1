Return-Path: <netdev+bounces-251497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGUFMKkucGniWwAAu9opvQ
	(envelope-from <netdev+bounces-251497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:40:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6CD4F3A6
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D62F8E3A9A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EF543C043;
	Tue, 20 Jan 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkmkwOdY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D342883A
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917749; cv=none; b=jpD7IYrMtEQmCyyVqZPkyTMvC6fWQPImd3wjKkYd8cZMi/AXxEdqDf6zCW25C4fKdY6DMsxlhN6ibh90xBTZhpNFwz68xmkKxEWJ8AuiD7QDnX/rDT4YX5j9kj5wFIu7wln8Hk9RpbzGbgJWweOO8I1eOsdghO9YMAjKg4tTmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917749; c=relaxed/simple;
	bh=RQtxxTx0BaYQbBXGPsoMwvYiTSzOJ7lvWIteby4+xQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6obl6Srl4Gapd52lnn2PBB3JDk05RG4fnucs2ohaKhF6+dNlNJECu+nhqDngBy69ntKiFOugIbH3uFOjxWy1C2G18L8HJRejjruxUjNRcf4sBzxC1KWXXvVMdRJUsSCSCBdu8lU2D8ghns8X9GC5A2XPvaOu8nS1FoVkWW2idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkmkwOdY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917748; x=1800453748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RQtxxTx0BaYQbBXGPsoMwvYiTSzOJ7lvWIteby4+xQM=;
  b=lkmkwOdYpmy+FjIwTlDhexZ6SKuf4/vII+0UPX6zSp0NBt1rdkgCoZse
   e5A/u8QHvRJd7cAwVKuZScX685k1uZbJgY3z7bzpOeUgt3HdRSBuJP4Ek
   3OFShbdOQd9cCUxzBwKTwUdnLzshuQWJtqzKQQ1xsaqr+uU8NpFa/gtow
   q/EHDyQ+JfCQ9kPT8oRgRFd7mMtoYEhNm+Auv3d93RorW0bXudbHk7/ix
   ROa0nKp3fclmLa6KFAGbMzzC0g8CXsTg01ae+UfSFg0UOBtIqDjoXfl2h
   csQk2yg4+Ohfjfe7nDxrua03AhA4J4qIrqdy0H10JVuUY9eNNqv2UHkE7
   Q==;
X-CSE-ConnectionGUID: 8ULEVx6OQOGjHgkBNNJhQw==
X-CSE-MsgGUID: K2q1DRx1TIKvj9hW/t6jvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72711751"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="72711751"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:02:27 -0800
X-CSE-ConnectionGUID: AN43iOWwRte1kfUYFsOXng==
X-CSE-MsgGUID: uEb2u9GbQEOvAvbU7iyuug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210978890"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 06:02:26 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 1/6] ixgbe: E610: add discovering EEE capability
Date: Tue, 20 Jan 2026 14:44:29 +0100
Message-Id: <20260120134434.1931602-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
References: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251497-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5F6CD4F3A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add detecting and parsing EEE device capability.

Recently EEE functionality support has been introduced to E610 FW.
Currently ixgbe driver has no possibility to detect whether NVM
loaded on given adapter supports EEE.

There's dedicated device capability element reflecting FW support
for given EEE link speed.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 7 +++++++
 include/linux/intel/libie/adminq.h                 | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index c2f8189a0738..9ae1e3620ee1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -628,6 +628,9 @@ static bool ixgbe_parse_e610_caps(struct ixgbe_hw *hw,
 			(phys_id & IXGBE_EXT_TOPO_DEV_IMG_PROG_EN) != 0;
 		break;
 	}
+	case LIBIE_AQC_CAPS_EEE:
+		caps->eee_support = (u8)number;
+		break;
 	default:
 		/* Not one of the recognized common capabilities */
 		return false;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index cde148eec38d..11dc7fc71b71 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -892,6 +892,7 @@ struct ixgbe_hw_caps {
 	u8 apm_wol_support;
 	u8 acpi_prog_mthd;
 	u8 proxy_support;
+	u8 eee_support;
 	bool nvm_update_pending_nvm;
 	bool nvm_update_pending_orom;
 	bool nvm_update_pending_netlist;
@@ -927,6 +928,12 @@ struct ixgbe_hw_caps {
 
 #define IXGBE_OROM_CIV_SIGNATURE	"$CIV"
 
+#define IXGBE_EEE_SUPPORT_100BASE_TX	BIT(0)
+#define IXGBE_EEE_SUPPORT_1000BASE_T	BIT(1)
+#define IXGBE_EEE_SUPPORT_10GBASE_T	BIT(2)
+#define IXGBE_EEE_SUPPORT_5GBASE_T	BIT(3)
+#define IXGBE_EEE_SUPPORT_2_5GBASE_T	BIT(4)
+
 struct ixgbe_orom_civd_info {
 	u8 signature[4];	/* Must match ASCII '$CIV' characters */
 	u8 checksum;		/* Simple modulo 256 sum of all structure bytes must equal 0 */
diff --git a/include/linux/intel/libie/adminq.h b/include/linux/intel/libie/adminq.h
index ab13bd777a28..839114d8975a 100644
--- a/include/linux/intel/libie/adminq.h
+++ b/include/linux/intel/libie/adminq.h
@@ -196,6 +196,7 @@ LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_list_caps);
 #define LIBIE_AQC_BIT_ROCEV2_LAG			BIT(0)
 #define LIBIE_AQC_BIT_SRIOV_LAG				BIT(1)
 #define LIBIE_AQC_BIT_SRIOV_AA_LAG			BIT(2)
+#define LIBIE_AQC_CAPS_EEE				0x009B
 #define LIBIE_AQC_CAPS_FLEX10				0x00F1
 #define LIBIE_AQC_CAPS_CEM				0x00F2
 
-- 
2.31.1


