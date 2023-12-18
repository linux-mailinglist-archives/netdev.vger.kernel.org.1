Return-Path: <netdev+bounces-58642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D92817B5C
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC591F238AF
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD4740AD;
	Mon, 18 Dec 2023 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuQbp1fK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43F72065
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702928919; x=1734464919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z8ATyJMNfj0Xu1ZmTPa+xXDer7tnJET6/+xArQwbmAQ=;
  b=CuQbp1fKg7Guthp5dAl0s85rPaoBTVfPNEAfl2I4Vhv4D/JhiAQhnCwI
   dvDmv8ceQyCNaqItk3jDZLASUE9YaOu2nGOqqkuZDjyym3Z38sdFla11X
   bTLb6fnsl++RohbLEOalPXyGqXPIlFCwFN+M6INv0HasqIUNhGNZ7JfP8
   ASHE2IoQP0yDsCih3xSo0czDxCd4zZExa10VU0HNKcA6KD82FXukVk8tB
   T3g4uLUJqQ5zcBtwnNXTwy70MVmGcpMg+OXNti9uXBu4vdsrePbrhzDF+
   WuSv2qf3yO9QUgNuR0TCNp1Yizwtatxft8IpXMfOlaD6ePpOsDX2xaOUd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394436784"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="394436784"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 11:48:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="23902078"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 18 Dec 2023 11:48:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net-next 02/15] intel: add bit macro includes where needed
Date: Mon, 18 Dec 2023 11:48:17 -0800
Message-ID: <20231218194833.3397815-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
References: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

This series is introducing the use of FIELD_GET and FIELD_PREP which
requires bitfield.h to be included. Fix all the includes in this one
change, and rearrange includes into alphabetical order to ease
readability and future maintenance.

virtchnl.h and it's usage was modified to have it's own includes as it
should. This required including bits.h for virtchnl.h.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c   |  1 +
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c   |  1 +
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  1 +
 drivers/net/ethernet/intel/iavf/iavf_common.c |  3 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  5 ++--
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   |  1 +
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  1 +
 drivers/net/ethernet/intel/igb/e1000_i210.c   |  4 +--
 drivers/net/ethernet/intel/igb/e1000_nvm.c    |  4 +--
 drivers/net/ethernet/intel/igb/e1000_phy.c    |  4 +--
 drivers/net/ethernet/intel/igbvf/netdev.c     | 28 +++++++++----------
 drivers/net/ethernet/intel/igc/igc_i225.c     |  1 +
 drivers/net/ethernet/intel/igc/igc_phy.c      |  1 +
 include/linux/avf/virtchnl.h                  |  1 +
 17 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 4542e2bc28e8..4576511c99f5 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -5,6 +5,7 @@
  * Shared functions for accessing and configuring the MAC
  */
 
+#include <linux/bitfield.h>
 #include "e1000.h"
 
 static s32 e1000_check_downshift(struct e1000_hw *hw);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index af1b0cde3670..ae700a1807c6 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2019 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include "fm10k_pf.h"
 #include "fm10k_vf.h"
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index dc8ccd378ec9..c50928ec14ff 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2019 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include "fm10k_vf.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index bd52b73cf61f..522cf2e5f365 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
 #include <linux/avf/virtchnl.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 498728e16a37..0d334036ab8b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
+#include <linux/bitfield.h>
+#include "i40e_adminq.h"
 #include "i40e_alloc.h"
 #include "i40e_dcb.h"
 #include "i40e_prototype.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 62eb34871094..157eacfdc918 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include "i40e_alloc.h"
 #include "i40e_prototype.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index 89d2bce529ae..af5cc69f26e3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/avf/virtchnl.h>
+#include <linux/bitfield.h>
 #include "iavf_type.h"
 #include "iavf_adminq.h"
 #include "iavf_prototype.h"
-#include <linux/avf/virtchnl.h>
 
 /**
  * iavf_aq_str - convert AQ err code to a string
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index cdb4849f5db4..bffb45802dab 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
+#include <linux/uaccess.h>
+
 /* ethtool support for iavf */
 #include "iavf.h"
 
-#include <linux/uaccess.h>
-
 /* ethtool statistics helpers */
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index 03e774bd2a5b..65ddcd81c993 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -3,6 +3,7 @@
 
 /* flow director ethtool support for iavf */
 
+#include <linux/bitfield.h>
 #include "iavf.h"
 
 #define GTPU_PORT	2152
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index d64c4997136b..fb7edba9c2f8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include <linux/prefetch.h>
 
 #include "iavf.h"
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index b9b9d35494d2..53b396fd194a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -5,9 +5,9 @@
  * e1000_i211
  */
 
-#include <linux/types.h>
+#include <linux/bitfield.h>
 #include <linux/if_ether.h>
-
+#include <linux/types.h>
 #include "e1000_hw.h"
 #include "e1000_i210.h"
 
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index fa136e6e9328..0da57e89593a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2018 Intel Corporation. */
 
-#include <linux/if_ether.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
-
+#include <linux/if_ether.h>
 #include "e1000_mac.h"
 #include "e1000_nvm.h"
 
diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
index a018000f7db9..3c1b562a3271 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.c
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2018 Intel Corporation. */
 
-#include <linux/if_ether.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
-
+#include <linux/if_ether.h>
 #include "e1000_mac.h"
 #include "e1000_phy.h"
 
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index fd712585af27..e6c1fbee049e 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -3,25 +3,25 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/vmalloc.h>
-#include <linux/pagemap.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/tcp.h>
-#include <linux/ipv6.h>
-#include <linux/slab.h>
-#include <net/checksum.h>
-#include <net/ip6_checksum.h>
-#include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
+#include <linux/init.h>
+#include <linux/ipv6.h>
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/pagemap.h>
+#include <linux/pci.h>
 #include <linux/prefetch.h>
 #include <linux/sctp.h>
-
+#include <linux/slab.h>
+#include <linux/tcp.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+#include <net/checksum.h>
+#include <net/ip6_checksum.h>
 #include "igbvf.h"
 
 char igbvf_driver_name[] = "igbvf";
diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 17546a035ab1..d2562c8e8015 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c)  2018 Intel Corporation */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 
 #include "igc_hw.h"
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 53b77c969c85..d0d9e7170154 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c)  2018 Intel Corporation */
 
+#include <linux/bitfield.h>
 #include "igc_phy.h"
 
 /**
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index a44d9dc7e3eb..8e177b67e82f 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -5,6 +5,7 @@
 #define _VIRTCHNL_H_
 
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/overflow.h>
 #include <uapi/linux/if_ether.h>
 
-- 
2.41.0


