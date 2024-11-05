Return-Path: <netdev+bounces-142118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579589BD87D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FBA2844D4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECCD216E06;
	Tue,  5 Nov 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhgbIALP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63006216A39
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845448; cv=none; b=TolalbNXPax3VfFX34zGUJQF7i3mfBuMPoF4LCub4XwwbuMuVC6RCKgn0qX2eZNGSuwRO4ADNg/4Poo27ibpLnOSHSoxEYs18SQVyCYgtDap7hZT6ugXhObTalqUXJaSZh3XVH8vbqZxBisXCj55qB7dcCmi0g5VH3+0PmqLDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845448; c=relaxed/simple;
	bh=zQ0iotFVz+YV9+SneoYSpAEeQ2v22cN1qtJoss8Sduc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJfYhSE0+xHKKQ85UhbmqoV7m9RI8kV9Vamf99rvmEq5AOfYp+/1Pfi7TsDjSg+HoflspLFodEJ28nt/2Yxpo+bANMwknhhvmy/EToW5+JfOW6iqMsY0mVN+nKoyh7fw34g5Zffm3YzCq/mzQ9bB+9AceuW3rGqGlkoco6f/6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhgbIALP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845446; x=1762381446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQ0iotFVz+YV9+SneoYSpAEeQ2v22cN1qtJoss8Sduc=;
  b=bhgbIALPEoyKEefZJ+pjb+2jZE4UaegbmwRhPMA6G7rDFpK8DthCQvAB
   6AX1Nv1LSzsa+n8rJx0sG6nfFzZjEFTGPts0GNWMfZreDq1YDjZCKv+fv
   V5d735Tvl2LD28wVr1RjFJtCOs7zrsqEri1SfQqI6dAKyUTgStZytciRj
   RDBV0kww+N2RGg4tHpQ0AGp0x88vlgcTjD8l3Na6DWIaUjSv1/wZaorsE
   ahnAT+OrSevOo8Jtd+Gt6BGOOp97VHuP17S7OuTwwpZ25Ctvw3L3T3HO2
   vu3tHmSXy7CBltVR2+JJNI9fMBpsLSHrMfWL8MC66LQUcqdokEuIJL6d9
   g==;
X-CSE-ConnectionGUID: /3qOeh3rRmCb8oyOCQ1cGw==
X-CSE-MsgGUID: pIsRKeb1TuCgaCJedoirgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314314"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314314"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:02 -0800
X-CSE-ConnectionGUID: gLtdISxtRNejfcwAOCI0WA==
X-CSE-MsgGUID: WkKdw/5BRtaaebUhxwVPWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322467"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:24:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Diomidis Spinellis <dds@aueb.gr>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 11/15] ixgbe: Break include dependency cycle
Date: Tue,  5 Nov 2024 14:23:45 -0800
Message-ID: <20241105222351.3320587-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diomidis Spinellis <dds@aueb.gr>

Header ixgbe_type.h includes ixgbe_mbx.h.  Also, header
ixgbe_mbx.h included ixgbe_type.h, thus introducing a circular
dependency.

- Remove ixgbe_mbx.h inclusion from ixgbe_type.h.

- ixgbe_mbx.h requires the definition of struct ixgbe_mbx_operations
  so move its definition there. While at it, add missing argument
  identifier names.

- Add required forward structure declarations.

- Include ixgbe_mbx.h in the .c files that need it, for the
  following reasons:

  ixgbe_sriov.c uses ixgbe_check_for_msg
  ixgbe_main.c uses ixgbe_init_mbx_params_pf
  ixgbe_82599.c uses mbx_ops_generic
  ixgbe_x540.c uses mbx_ops_generic
  ixgbe_x550.c uses mbx_ops_generic

Signed-off-by: Diomidis Spinellis <dds@aueb.gr>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   | 16 +++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  | 15 ++-------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c  |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c  |  1 +
 7 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 283a23150a4d..4aaaea3b5f8f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 
 #include "ixgbe.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
 
 #define IXGBE_82598_MAX_TX_QUEUES 32
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8b8404d8c946..c229a26fbbb7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -43,6 +43,7 @@
 #include "ixgbe.h"
 #include "ixgbe_common.h"
 #include "ixgbe_dcb_82599.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
 #include "ixgbe_sriov.h"
 #include "ixgbe_model.h"
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index bd205306934b..bf65e82b4c61 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -4,7 +4,7 @@
 #ifndef _IXGBE_MBX_H_
 #define _IXGBE_MBX_H_
 
-#include "ixgbe_type.h"
+#include <linux/types.h>
 
 #define IXGBE_VFMAILBOX_SIZE        16 /* 16 32 bit words - 64 bytes */
 
@@ -96,6 +96,8 @@ enum ixgbe_pfvf_api_rev {
 #define IXGBE_VF_MBX_INIT_TIMEOUT 2000 /* number of retries on mailbox */
 #define IXGBE_VF_MBX_INIT_DELAY   500  /* microseconds between retries */
 
+struct ixgbe_hw;
+
 int ixgbe_read_mbx(struct ixgbe_hw *, u32 *, u16, u16);
 int ixgbe_write_mbx(struct ixgbe_hw *, u32 *, u16, u16);
 int ixgbe_check_for_msg(struct ixgbe_hw *, u16);
@@ -105,6 +107,18 @@ int ixgbe_check_for_rst(struct ixgbe_hw *, u16);
 void ixgbe_init_mbx_params_pf(struct ixgbe_hw *);
 #endif /* CONFIG_PCI_IOV */
 
+struct ixgbe_mbx_operations {
+	int (*init_params)(struct ixgbe_hw *hw);
+	int (*read)(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 vf_number);
+	int (*write)(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 vf_number);
+	int (*read_posted)(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 mbx_id);
+	int (*write_posted)(struct ixgbe_hw *hw, u32 *msg, u16 size,
+			    u16 mbx_id);
+	int (*check_for_msg)(struct ixgbe_hw *hw, u16 vf_number);
+	int (*check_for_ack)(struct ixgbe_hw *hw, u16 vf_number);
+	int (*check_for_rst)(struct ixgbe_hw *hw, u16 vf_number);
+};
+
 extern const struct ixgbe_mbx_operations mbx_ops_generic;
 
 #endif /* _IXGBE_MBX_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index e71715f5da22..9631559a5aea 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -18,6 +18,7 @@
 
 #include "ixgbe.h"
 #include "ixgbe_type.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_sriov.h"
 
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 346e3d9114a8..9baccacd02a1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3601,19 +3601,6 @@ struct ixgbe_phy_info {
 	u32				nw_mng_if_sel;
 };
 
-#include "ixgbe_mbx.h"
-
-struct ixgbe_mbx_operations {
-	int (*init_params)(struct ixgbe_hw *hw);
-	int (*read)(struct ixgbe_hw *, u32 *, u16,  u16);
-	int (*write)(struct ixgbe_hw *, u32 *, u16, u16);
-	int (*read_posted)(struct ixgbe_hw *, u32 *, u16,  u16);
-	int (*write_posted)(struct ixgbe_hw *, u32 *, u16, u16);
-	int (*check_for_msg)(struct ixgbe_hw *, u16);
-	int (*check_for_ack)(struct ixgbe_hw *, u16);
-	int (*check_for_rst)(struct ixgbe_hw *, u16);
-};
-
 struct ixgbe_mbx_stats {
 	u32 msgs_tx;
 	u32 msgs_rx;
@@ -3623,6 +3610,8 @@ struct ixgbe_mbx_stats {
 	u32 rsts;
 };
 
+struct ixgbe_mbx_operations;
+
 struct ixgbe_mbx_info {
 	const struct ixgbe_mbx_operations *ops;
 	struct ixgbe_mbx_stats stats;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index f1ffa398f6df..81e1df83f136 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 
 #include "ixgbe.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
 #include "ixgbe_x540.h"
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index a5f644934445..d9a8cf018d3b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -4,6 +4,7 @@
 #include "ixgbe_x540.h"
 #include "ixgbe_type.h"
 #include "ixgbe_common.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
 
 static int ixgbe_setup_kr_speed_x550em(struct ixgbe_hw *, ixgbe_link_speed);
-- 
2.42.0


