Return-Path: <netdev+bounces-189255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D53AAB1582
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E8350133C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674829208B;
	Fri,  9 May 2025 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBSgibhr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79C2918E3;
	Fri,  9 May 2025 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798218; cv=none; b=fClyDBgvefeXKCCU7w6MTii6LRw6LgMos/7izUnp6vwTmlQ3XSv/A4eFQIbdEgKQewHaM5LmMOzwf9AZnXDte5twCzb1wyoX4H8Ku0wsmXKuG3EcdjY4yGW/wu+FfWeO7y7PWT/CpC2gCalMKy4PHxuK9kQ59jYHkjlJ2gb31x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798218; c=relaxed/simple;
	bh=YWrwT34lNBt9HzcyO1+bEGI22OP9O3x6KK9NspwJAj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPsBuOMxM+QS5nfkEdRbzUeO9wSv37qelAV9v3qEJJMO4U6KYI4L2U4z0MP8KOS94kP03N9TRnEpy4tSczuL4DSaY3JfhQa4y5gGlMQIJTQ3iu8vLioO9NncJwafihHkvF2FCxzviwMDvGNL2jUMG9T5J43lNyzOp1UEowkO234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBSgibhr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746798216; x=1778334216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YWrwT34lNBt9HzcyO1+bEGI22OP9O3x6KK9NspwJAj0=;
  b=SBSgibhrqFRu965ZzRSulCHn3QZSHL2hrr1nHGSWtXTOQHs8F59yKvac
   pSDjqF7z3PX82vAZzbnbyv1oEgd37LWCIIcyGaHLaCMruap6QOCBDyY2f
   Rv6/wKH39gKtFJgVrrhgs31kPo9eM4Yb4AbTlbBaMtEcItVl1RUTBUUHB
   80Uf5Qyet0k/If2huOlQNH3MzR2+aQV4xsWtMQJz0kH92eceZAATQf5zZ
   sHzDUTNdIpPyrtOdW4O9ZbXW2iVa7+wegguc/aH7Ac2cshDZ1eosdV4Lv
   gPuMYrFRsS0puS7Pje8qCBVpeOc7+Rc9DOrYBLjunvk/Xa9rS/boTeRRI
   g==;
X-CSE-ConnectionGUID: 56BgAvpQTamD/WYYM23Fdg==
X-CSE-MsgGUID: wQXH7IxJTumKPJAQDrAl8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48532804"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48532804"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 06:43:35 -0700
X-CSE-ConnectionGUID: kOOKgiVOQSimntR2KuSmEQ==
X-CSE-MsgGUID: yYf0eNCiT3GonaNrPp19fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136323164"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2025 06:43:24 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1ADF03430D;
	Fri,  9 May 2025 14:43:22 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: [PATCH iwl-next v3 01/15] virtchnl: create 'include/linux/intel' and move necessary header files
Date: Fri,  9 May 2025 15:42:58 +0200
Message-ID: <20250509134319.66631-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250509134319.66631-1-larysa.zaremba@intel.com>
References: <20250509134319.66631-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Raj <victor.raj@intel.com>

include/linux/net houses a single folder "intel", meanwhile
include/linux/intel is vacant. On top of that, it would be useful to place
all iavf headers together with other intel networking headers.

Move abovementioned intel header files into new folder include/linux/intel.
Also, assign new folder to both intel and general networking maintainers.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Victor Raj <victor.raj@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 MAINTAINERS                                                 | 6 +++---
 drivers/infiniband/hw/irdma/i40iw_if.c                      | 2 +-
 drivers/infiniband/hw/irdma/main.h                          | 2 +-
 drivers/infiniband/hw/irdma/osdep.h                         | 2 +-
 drivers/net/ethernet/intel/i40e/i40e.h                      | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h           | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c               | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c               | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h            | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                 | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h          | 2 +-
 drivers/net/ethernet/intel/iavf/iavf.h                      | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h           | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c               | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c                 | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_prototype.h            | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c                 | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_types.h                | 4 +---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c             | 2 +-
 drivers/net/ethernet/intel/ice/ice.h                        | 2 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h             | 2 +-
 drivers/net/ethernet/intel/ice/ice_common.h                 | 2 +-
 drivers/net/ethernet/intel/ice/ice_idc_int.h                | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c               | 2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h                 | 2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h               | 2 +-
 drivers/net/ethernet/intel/idpf/idpf.h                      | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                 | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h          | 2 +-
 drivers/net/ethernet/intel/libie/adminq.c                   | 2 +-
 drivers/net/ethernet/intel/libie/rx.c                       | 2 +-
 include/linux/{net => }/intel/i40e_client.h                 | 0
 include/linux/{net => }/intel/iidc.h                        | 0
 include/linux/{net => }/intel/libie/adminq.h                | 0
 include/linux/{net => }/intel/libie/rx.h                    | 0
 include/linux/{avf => intel}/virtchnl.h                     | 0
 .../ethernet/intel/idpf => include/linux/intel}/virtchnl2.h | 0
 .../intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h | 0
 38 files changed, 34 insertions(+), 36 deletions(-)
 rename include/linux/{net => }/intel/i40e_client.h (100%)
 rename include/linux/{net => }/intel/iidc.h (100%)
 rename include/linux/{net => }/intel/libie/adminq.h (100%)
 rename include/linux/{net => }/intel/libie/rx.h (100%)
 rename include/linux/{avf => intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c31814c9687..9ef45ac0fe7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11898,8 +11898,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
 F:	Documentation/networking/device_drivers/ethernet/intel/
 F:	drivers/net/ethernet/intel/
 F:	drivers/net/ethernet/intel/*/
-F:	include/linux/avf/virtchnl.h
-F:	include/linux/net/intel/iidc.h
+F:	include/linux/intel/
 
 INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
 M:	Mustafa Ismail <mustafa.ismail@intel.com>
@@ -13548,7 +13547,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git https://github.com/alobakin/linux.git
 F:	drivers/net/ethernet/intel/libie/
-F:	include/linux/net/intel/libie/
+F:	include/linux/intel/libie/
 K:	libie
 
 LIBNVDIMM BTT: BLOCK TRANSLATION TABLE
@@ -16826,6 +16825,7 @@ F:	include/linux/fddidevice.h
 F:	include/linux/hippidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
+F:	include/linux/intel/
 F:	include/linux/ism.h
 F:	include/linux/netdev*
 F:	include/linux/platform_data/wiznet.h
diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index cc50a7070371..cfd71fe5bd79 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
 #include "i40iw_hw.h"
-#include <linux/net/intel/i40e_client.h>
+#include <linux/intel/i40e_client.h>
 
 static struct i40e_client i40iw_client;
 
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index bb0b6494ccb2..d6e446dec2be 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -29,7 +29,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #endif
 #include <linux/auxiliary_bus.h>
-#include <linux/net/intel/iidc.h>
+#include <linux/intel/iidc.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_pack.h>
diff --git a/drivers/infiniband/hw/irdma/osdep.h b/drivers/infiniband/hw/irdma/osdep.h
index 4b4f78288d12..abb10e35d33b 100644
--- a/drivers/infiniband/hw/irdma/osdep.h
+++ b/drivers/infiniband/hw/irdma/osdep.h
@@ -5,7 +5,7 @@
 
 #include <linux/pci.h>
 #include <linux/bitfield.h>
-#include <linux/net/intel/iidc.h>
+#include <linux/intel/iidc.h>
 #include <rdma/ib_verbs.h>
 
 #define STATS_TIMER_DELAY	60000
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c67963bfe14e..287ddfec5024 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -8,8 +8,8 @@
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
-#include <linux/avf/virtchnl.h>
-#include <linux/net/intel/i40e_client.h>
+#include <linux/intel/virtchnl.h>
+#include <linux/intel/i40e_client.h>
 #include <net/devlink.h>
 #include <net/pkt_cls.h>
 #include <net/udp_tunnel.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 76d872b91a38..c75b5bd680c3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -4,7 +4,7 @@
 #ifndef _I40E_ADMINQ_CMD_H_
 #define _I40E_ADMINQ_CMD_H_
 
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 #include <linux/bits.h>
 #include <linux/types.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 5f1a405cbbf8..3c9c95a87489 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -3,7 +3,7 @@
 
 #include <linux/list.h>
 #include <linux/errno.h>
-#include <linux/net/intel/i40e_client.h>
+#include <linux/intel/i40e_client.h>
 
 #include "i40e.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 270e7e8cf9cf..f36870b2e460 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index aef5de53ce3b..3872bc57e2a2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -5,7 +5,7 @@
 #define _I40E_PROTOTYPE_H_
 
 #include <linux/ethtool.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "i40e_debug.h"
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index c006f716a3bd..30df45a146da 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include <linux/bpf_trace.h>
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 #include <linux/prefetch.h>
 #include <linux/sctp.h>
 #include <net/mpls.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 5cf74f16f433..acaae2f6d00b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -4,7 +4,7 @@
 #ifndef _I40E_VIRTCHNL_PF_H_
 #define _I40E_VIRTCHNL_PF_H_
 
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/netdevice.h>
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index f7a98ff43a57..a97e8568e37e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -37,7 +37,7 @@
 #include <net/net_shaper.h>
 
 #include "iavf_type.h"
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "iavf_txrx.h"
 #include "iavf_fdir.h"
 #include "iavf_adv_rss.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h b/drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h
index 0482c9ce9b9c..12e84e1e971b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h
@@ -4,7 +4,7 @@
 #ifndef _IAVF_ADMINQ_CMD_H_
 #define _IAVF_ADMINQ_CMD_H_
 
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 /* This header file defines the iavf Admin Queue commands and is shared between
  * iavf Firmware and Software.
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index 614a886bca99..9bc8bdc339c7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/bitfield.h>
 #include "iavf_type.h"
 #include "iavf_adminq.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8162db7c06c0..13d04a966fd0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 #include <net/netdev_lock.h>
 
 #include "iavf.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index 7f9f9dbf959a..a3348b063723 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -6,7 +6,7 @@
 
 #include "iavf_type.h"
 #include "iavf_alloc.h"
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 
 /* Prototypes for shared code functions that are not in
  * the standard function pointer structures.  These are
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 35d353d38129..ae797d387c08 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include <linux/bitfield.h>
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 #include <linux/prefetch.h>
 
 #include "iavf.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_types.h b/drivers/net/ethernet/intel/iavf/iavf_types.h
index a095855122bf..270bc35f933d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_types.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_types.h
@@ -4,9 +4,7 @@
 #ifndef _IAVF_TYPES_H_
 #define _IAVF_TYPES_H_
 
-#include "iavf_types.h"
-
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/ptp_clock_kernel.h>
 
 /* structure used to queue PTP commands for processing */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 55854cf8d760..9841cc3277cb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 
 #include "iavf.h"
 #include "iavf_ptp.h"
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fe5db9c5fb55..f72de345d910 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -36,7 +36,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/auxiliary_bus.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
 #include <linux/gnss.h>
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 11e55e1d1424..8ed7a85e4676 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -4,7 +4,7 @@
 #ifndef _ICE_ADMINQ_CMD_H_
 #define _ICE_ADMINQ_CMD_H_
 
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 /* This header file defines the Admin Queue commands, error codes and
  * descriptor format. It is shared between Firmware and Software.
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 3f74570b99bf..487259786cd2 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -11,7 +11,7 @@
 #include "ice_nvm.h"
 #include "ice_flex_pipe.h"
 #include "ice_parser.h"
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "ice_switch.h"
 #include "ice_fdir.h"
 
diff --git a/drivers/net/ethernet/intel/ice/ice_idc_int.h b/drivers/net/ethernet/intel/ice/ice_idc_int.h
index 4b0c86757df9..3d35118dee90 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc_int.h
+++ b/drivers/net/ethernet/intel/ice/ice_idc_int.h
@@ -4,7 +4,7 @@
 #ifndef _ICE_IDC_INT_H_
 #define _ICE_IDC_INT_H_
 
-#include <linux/net/intel/iidc.h>
+#include <linux/intel/iidc.h>
 
 struct ice_pf;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 45cfaabc41cb..fb90916e7ef7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2019, Intel Corporation. */
 
 #include <linux/filter.h>
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 
 #include "ice_txrx_lib.h"
 #include "ice_eswitch.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 482f4285fd35..5cdc98985523 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -10,7 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <net/devlink.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "ice_type.h"
 #include "ice_flow.h"
 #include "ice_virtchnl_fdir.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
index 222990f229d5..ca3830617a51 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "ice_vf_lib.h"
 
 /* Restrict number of MAC Addr and VLAN that non-trusted VF can programmed */
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 627010dac3aa..b3758e6516b5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -20,7 +20,7 @@ struct idpf_rss_data;
 #include <linux/ethtool_netlink.h>
 #include <net/gro.h>
 
-#include "virtchnl2.h"
+#include <linux/intel/virtchnl2.h>
 #include "idpf_txrx.h"
 #include "idpf_controlq.h"
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index e52c5033b25b..fbe09413cdf6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -11,7 +11,7 @@
 #include <net/netdev_queues.h>
 
 #include "idpf_lan_txrx.h"
-#include "virtchnl2_lan_desc.h"
+#include <linux/intel/virtchnl2_lan_desc.h>
 
 #define IDPF_LARGE_MAX_Q			256
 #define IDPF_MAX_Q				16
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index d2f22d8558f8..d76334b8fbad 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -4,7 +4,7 @@
 #ifndef _IXGBE_TYPE_E610_H_
 #define _IXGBE_TYPE_E610_H_
 
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 #define BYTES_PER_DWORD	4
 
diff --git a/drivers/net/ethernet/intel/libie/adminq.c b/drivers/net/ethernet/intel/libie/adminq.c
index 55356548e3f0..35eefecec144 100644
--- a/drivers/net/ethernet/intel/libie/adminq.c
+++ b/drivers/net/ethernet/intel/libie/adminq.c
@@ -2,7 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include <linux/module.h>
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 static const char * const libie_aq_str_arr[] = {
 #define LIBIE_AQ_STR(x)					\
diff --git a/drivers/net/ethernet/intel/libie/rx.c b/drivers/net/ethernet/intel/libie/rx.c
index 66a9825fe11f..668785974727 100644
--- a/drivers/net/ethernet/intel/libie/rx.c
+++ b/drivers/net/ethernet/intel/libie/rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2024 Intel Corporation */
 
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 
 /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
  * bitfield struct.
diff --git a/include/linux/net/intel/i40e_client.h b/include/linux/intel/i40e_client.h
similarity index 100%
rename from include/linux/net/intel/i40e_client.h
rename to include/linux/intel/i40e_client.h
diff --git a/include/linux/net/intel/iidc.h b/include/linux/intel/iidc.h
similarity index 100%
rename from include/linux/net/intel/iidc.h
rename to include/linux/intel/iidc.h
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/intel/libie/adminq.h
similarity index 100%
rename from include/linux/net/intel/libie/adminq.h
rename to include/linux/intel/libie/adminq.h
diff --git a/include/linux/net/intel/libie/rx.h b/include/linux/intel/libie/rx.h
similarity index 100%
rename from include/linux/net/intel/libie/rx.h
rename to include/linux/intel/libie/rx.h
diff --git a/include/linux/avf/virtchnl.h b/include/linux/intel/virtchnl.h
similarity index 100%
rename from include/linux/avf/virtchnl.h
rename to include/linux/intel/virtchnl.h
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/include/linux/intel/virtchnl2.h
similarity index 100%
rename from drivers/net/ethernet/intel/idpf/virtchnl2.h
rename to include/linux/intel/virtchnl2.h
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h b/include/linux/intel/virtchnl2_lan_desc.h
similarity index 100%
rename from drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h
rename to include/linux/intel/virtchnl2_lan_desc.h
-- 
2.47.0


