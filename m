Return-Path: <netdev+bounces-249045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AD9D13185
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA774303B784
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4022825B663;
	Mon, 12 Jan 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONjW9O7Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE284244675
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227520; cv=none; b=OqnAFxLi3zNDSCoaxsVm5FYuMvbtuvyE95OBhaVNfN6phzjg0mFZqm237IGoJ2YTOc8qpSpad5ef+d18W3PT7Df570epg/l4KKSQpgsPMsiKnEnuNwdHCrzojzHKi31sB0sFJpmj+z28NXorEzU7xgf1h7NsTUbjAGHZ0M5cVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227520; c=relaxed/simple;
	bh=dx8tADSm7t+2dxNqjDCdBuCNg+zbopcy4tyxlCoUwjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQDNbXQFbqsjUBbXlN8ZDNG7tHLvQFxJBhQl7c7+pQAWOc3JhoFW8w0D/jj9+UCwXBhBiE/HegmqBQ3aMEvunAY/tGASln6G/kVUyZwuEQK1yjYuN8BM8oh+JuuWU29FvtFbyDdCi7nysxM/cP/LygFaU/uHg7z2zUxfc8w7dJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONjW9O7Y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768227519; x=1799763519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dx8tADSm7t+2dxNqjDCdBuCNg+zbopcy4tyxlCoUwjw=;
  b=ONjW9O7Y3T2hj9WmeSqKlKEDCd+iOoqbNgSCiubkXku43vGPOYOk//e9
   a8TQ4OrDAIJQx+uWsaJ7hvQL9mVjDOiZDnuE5K/O4CKT0jPllqlPpNvAW
   ysiYpaMW3VamMqsIPBvP80kw4x05v9heBH9JupK/OGKIhteNF7ZEjehAT
   /eZ/yYsp0hN4mbEyvwuVlBEha3crTgJLJglSh4iw4RjwojxbAjL+G+v+c
   88ynJuVjv2HbelqjtRD25GHvGGq1g1gFzAIlOeD/j0cUmuZghY+Lrqokj
   6uMTJDDl7NeTBINUECk+wgPA3NVjyrAHaztfJRJ52cgdzkq1Mt5BC337K
   g==;
X-CSE-ConnectionGUID: UAVhO496SkenepaMEGPBjw==
X-CSE-MsgGUID: KkVLG3yzQZ2pVOARJ0AFFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73352281"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73352281"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 06:18:38 -0800
X-CSE-ConnectionGUID: d4PZ95SpSl+f2pfzIHCSKg==
X-CSE-MsgGUID: 9KNmZpm5Q1+MZkm5GhF44A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="227355625"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jan 2026 06:18:37 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 1/7] ixgbe: E610: add discovering EEE capability
Date: Mon, 12 Jan 2026 15:01:02 +0100
Message-Id: <20260112140108.1173835-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 include/linux/net/intel/libie/adminq.h             | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index b202639b92c7..98982d3d87c7 100644
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
index 75383b2a1fe9..767d04a3f106 100644
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
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 1dd5d5924aee..4359cbbe6eb7 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -192,6 +192,7 @@ LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_list_caps);
 #define LIBIE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE		0x0085
 #define LIBIE_AQC_CAPS_NAC_TOPOLOGY			0x0087
 #define LIBIE_AQC_CAPS_FW_LAG_SUPPORT			0x0092
+#define LIBIE_AQC_CAPS_EEE				0x009B
 #define LIBIE_AQC_CAPS_FLEX10				0x00F1
 #define LIBIE_AQC_CAPS_CEM				0x00F2
 #define LIBIE_AQC_BIT_ROCEV2_LAG			BIT(0)
-- 
2.31.1


