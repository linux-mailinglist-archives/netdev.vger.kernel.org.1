Return-Path: <netdev+bounces-38323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EE37BA670
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 103AE281B77
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D9273C3;
	Thu,  5 Oct 2023 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4HuD1O7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79330CE8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:34:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8A7D59
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523610; x=1728059610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+eMVMTy4cjrbRGcCxYjKTQXGldS424oylJwCWX6lsrE=;
  b=e4HuD1O73HbMaUJVPhmHfS9a7SMzMXX8TfYs85Ydey6Re/B8JCEOOFa6
   I3eA0OwRuUFooHZhYUvVzauO519wA7FqLiw8TB0OfsRMjw1LwyVQOSsjy
   zz/8ITCHmUML3UpYmBiAJGb5Yi0CVxFpj0SETiWDSScuDFSd4sPKqummY
   e5H40aTDlkN7r34/7CKuYXZt5BwV/xF2+vAOIxutCj2IUjqpFPXWth0fJ
   O05/U/cXLvtQ8mLFbbgAHTQt2PYqql5MXa3iUkntEUy6dgsdfVLaxTqcz
   65eCDmDyCopEV6F0eSUMEAioiQvIexwNVPbmGEMLFAle0hGCHpCiG9RQN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2152683"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2152683"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875607756"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875607756"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2023 09:29:55 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 7/9] i40e: Split i40e_osdep.h
Date: Thu,  5 Oct 2023 09:28:48 -0700
Message-Id: <20231005162850.3218594-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
References: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ivan Vecera <ivecera@redhat.com>

Header i40e_osdep.h contains only IO primitives and couple of debug
printing macros. Split this header file to i40e_io.h and i40e_debug.h
and move i40e_debug_mask enum to i40e_debug.h

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_debug.h  | 47 +++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    |  1 -
 drivers/net/ethernet/intel/i40e/i40e_io.h     | 16 +++++++
 .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  1 -
 drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 40 ----------------
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  1 +
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 31 ++----------
 8 files changed, 68 insertions(+), 71 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_debug.h
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_io.h
 delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_osdep.h

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 1c3d2bc5c3f7..80125bea80a2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -4,8 +4,8 @@
 #ifndef _I40E_ADMINQ_H_
 #define _I40E_ADMINQ_H_
 
+#include <linux/mutex.h>
 #include "i40e_alloc.h"
-#include "i40e_osdep.h"
 #include "i40e_adminq_cmd.h"
 
 #define I40E_ADMINQ_DESC(R, i)   \
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h b/drivers/net/ethernet/intel/i40e/i40e_debug.h
new file mode 100644
index 000000000000..27ebc72d8bfe
--- /dev/null
+++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2023 Intel Corporation. */
+
+#ifndef _I40E_DEBUG_H_
+#define _I40E_DEBUG_H_
+
+#include <linux/dev_printk.h>
+
+/* debug masks - set these bits in hw->debug_mask to control output */
+enum i40e_debug_mask {
+	I40E_DEBUG_INIT			= 0x00000001,
+	I40E_DEBUG_RELEASE		= 0x00000002,
+
+	I40E_DEBUG_LINK			= 0x00000010,
+	I40E_DEBUG_PHY			= 0x00000020,
+	I40E_DEBUG_HMC			= 0x00000040,
+	I40E_DEBUG_NVM			= 0x00000080,
+	I40E_DEBUG_LAN			= 0x00000100,
+	I40E_DEBUG_FLOW			= 0x00000200,
+	I40E_DEBUG_DCB			= 0x00000400,
+	I40E_DEBUG_DIAG			= 0x00000800,
+	I40E_DEBUG_FD			= 0x00001000,
+	I40E_DEBUG_PACKAGE		= 0x00002000,
+	I40E_DEBUG_IWARP		= 0x00F00000,
+	I40E_DEBUG_AQ_MESSAGE		= 0x01000000,
+	I40E_DEBUG_AQ_DESCRIPTOR	= 0x02000000,
+	I40E_DEBUG_AQ_DESC_BUFFER	= 0x04000000,
+	I40E_DEBUG_AQ_COMMAND		= 0x06000000,
+	I40E_DEBUG_AQ			= 0x0F000000,
+
+	I40E_DEBUG_USER			= 0xF0000000,
+
+	I40E_DEBUG_ALL			= 0xFFFFFFFF
+};
+
+struct i40e_hw;
+struct device *i40e_hw_to_dev(struct i40e_hw *hw);
+
+#define hw_dbg(hw, S, A...) dev_dbg(i40e_hw_to_dev(hw), S, ##A)
+
+#define i40e_debug(h, m, s, ...)				\
+do {								\
+	if (((m) & (h)->debug_mask))				\
+		dev_info(i40e_hw_to_dev(hw), s, ##__VA_ARGS__);	\
+} while (0)
+
+#endif /* _I40E_DEBUG_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index 7451d346ae83..b383aea652f3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -2,7 +2,6 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include "i40e.h"
-#include "i40e_osdep.h"
 #include "i40e_register.h"
 #include "i40e_alloc.h"
 #include "i40e_hmc.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_io.h b/drivers/net/ethernet/intel/i40e/i40e_io.h
new file mode 100644
index 000000000000..2a2ed9a1d476
--- /dev/null
+++ b/drivers/net/ethernet/intel/i40e/i40e_io.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2023 Intel Corporation. */
+
+#ifndef _I40E_IO_H_
+#define _I40E_IO_H_
+
+/* get readq/writeq support for 32 bit kernels, use the low-first version */
+#include <linux/io-64-nonatomic-lo-hi.h>
+
+#define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
+#define rd32(a, reg)		readl((a)->hw_addr + (reg))
+
+#define rd64(a, reg)		readq((a)->hw_addr + (reg))
+#define i40e_flush(a)		readl((a)->hw_addr + I40E_GLGEN_STAT)
+
+#endif /* _I40E_IO_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
index 474365bf0648..830f1de254ef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
@@ -2,7 +2,6 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include "i40e.h"
-#include "i40e_osdep.h"
 #include "i40e_register.h"
 #include "i40e_type.h"
 #include "i40e_hmc.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
deleted file mode 100644
index fd18895cfb56..000000000000
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2013 - 2018 Intel Corporation. */
-
-#ifndef _I40E_OSDEP_H_
-#define _I40E_OSDEP_H_
-
-#include <linux/types.h>
-#include <linux/if_ether.h>
-#include <linux/if_vlan.h>
-#include <linux/tcp.h>
-#include <linux/pci.h>
-#include <linux/highuid.h>
-
-/* get readq/writeq support for 32 bit kernels, use the low-first version */
-#include <linux/io-64-nonatomic-lo-hi.h>
-
-/* File to be the magic between shared code and
- * actual OS primitives
- */
-
-struct i40e_hw;
-struct device *i40e_hw_to_dev(struct i40e_hw *hw);
-
-#define hw_dbg(hw, S, A...) dev_dbg(i40e_hw_to_dev(hw), S, ##A)
-
-#define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
-#define rd32(a, reg)		readl((a)->hw_addr + (reg))
-
-#define rd64(a, reg)		readq((a)->hw_addr + (reg))
-#define i40e_flush(a)		readl((a)->hw_addr + I40E_GLGEN_STAT)
-
-#define i40e_debug(h, m, s, ...)				\
-do {								\
-	if (((m) & (h)->debug_mask))				\
-		pr_info("i40e %02x:%02x.%x " s,			\
-			(h)->bus.bus_id, (h)->bus.device,	\
-			(h)->bus.func, ##__VA_ARGS__);		\
-} while (0)
-
-#endif /* _I40E_OSDEP_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 3eeee224f1fb..9c9234c0706f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -6,6 +6,7 @@
 
 #include "i40e_type.h"
 #include "i40e_alloc.h"
+#include "i40e_debug.h"
 #include <linux/avf/virtchnl.h>
 
 /* Prototypes for shared code functions that are not in
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 63cbf7669827..b3980b5b6919 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -4,7 +4,9 @@
 #ifndef _I40E_TYPE_H_
 #define _I40E_TYPE_H_
 
-#include "i40e_osdep.h"
+#include <linux/delay.h>
+#include <linux/if_ether.h>
+#include "i40e_io.h"
 #include "i40e_register.h"
 #include "i40e_adminq.h"
 #include "i40e_hmc.h"
@@ -40,33 +42,6 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
 #define I40E_QTX_CTL_VM_QUEUE	0x1
 #define I40E_QTX_CTL_PF_QUEUE	0x2
 
-/* debug masks - set these bits in hw->debug_mask to control output */
-enum i40e_debug_mask {
-	I40E_DEBUG_INIT			= 0x00000001,
-	I40E_DEBUG_RELEASE		= 0x00000002,
-
-	I40E_DEBUG_LINK			= 0x00000010,
-	I40E_DEBUG_PHY			= 0x00000020,
-	I40E_DEBUG_HMC			= 0x00000040,
-	I40E_DEBUG_NVM			= 0x00000080,
-	I40E_DEBUG_LAN			= 0x00000100,
-	I40E_DEBUG_FLOW			= 0x00000200,
-	I40E_DEBUG_DCB			= 0x00000400,
-	I40E_DEBUG_DIAG			= 0x00000800,
-	I40E_DEBUG_FD			= 0x00001000,
-	I40E_DEBUG_PACKAGE		= 0x00002000,
-	I40E_DEBUG_IWARP		= 0x00F00000,
-	I40E_DEBUG_AQ_MESSAGE		= 0x01000000,
-	I40E_DEBUG_AQ_DESCRIPTOR	= 0x02000000,
-	I40E_DEBUG_AQ_DESC_BUFFER	= 0x04000000,
-	I40E_DEBUG_AQ_COMMAND		= 0x06000000,
-	I40E_DEBUG_AQ			= 0x0F000000,
-
-	I40E_DEBUG_USER			= 0xF0000000,
-
-	I40E_DEBUG_ALL			= 0xFFFFFFFF
-};
-
 #define I40E_MDIO_CLAUSE22_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK
 #define I40E_MDIO_CLAUSE22_OPCODE_WRITE_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(1)
 #define I40E_MDIO_CLAUSE22_OPCODE_READ_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(2)
-- 
2.38.1


