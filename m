Return-Path: <netdev+bounces-105320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADCB91070C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B48282DB1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533301B143B;
	Thu, 20 Jun 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9ArPdIw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891841B1424;
	Thu, 20 Jun 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891813; cv=none; b=NjuV99Ve2cqFML9/kYptJA4kYTVcqwHwgT7JIIkaNzr1iH0oMWuhYLic/FRWmD107ablbyz1koQHvAYV4g6+GXGS8yCy0Yef/FCdvmCSQsRLwEG7u/tukGMeSkydlqbxAvQhyZ6bKMcXauwj5h1GOs2e394mWHKr322iTqClbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891813; c=relaxed/simple;
	bh=aPeC1+bpMVMGP8un7rd+LULhCkAArDcaztGiqdxkqpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gcv6kdzzP8YE44LogORrVHr/jv3ZBAtJIiqQ65R/j4UqGiOC26KCmfLdHHp7RuYHLvEkuzAFDP11UdGbpqyesPY4DILtN2j9eWAP+RCdzoOS+TgMSM3OeYuSUVCP6EA9l/PrM9VEQYFtGoqOINJH4i6b5ofT9PVSydaEh/A/iAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9ArPdIw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718891812; x=1750427812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aPeC1+bpMVMGP8un7rd+LULhCkAArDcaztGiqdxkqpc=;
  b=V9ArPdIwN78w8OpWfgx5Nq9IiK4UHaM2AP6xjgfhuB4O02gBvK6/lj5J
   UF88yiFCRLE+8JSkGNBG7r/dEHzTVBSyXJ2bQb7Vlx0bCr04zN4dUWaq+
   OywAV6M0tZQHplBwV5Qm0tcuwFhaN+an0UE37lU6JxEp8WVvnCRsRwxwb
   hlFD91o6BN86JAmam34h8pXzKXkJTkoj/T1am2PCHGekmcYtbPaue/0Cu
   dX7Nb0sqSfg+zfVMV0AZXP8/W9X5pEgHhB1cVDeICp3BlfiyXnDgN8yRw
   4GHX09+6PJeS8Dl6LuijfTCd6uN0SYTEQ/dqaWg1G23QvHdqa6pj7OCTZ
   Q==;
X-CSE-ConnectionGUID: NK/1hFLETuCqxTFcYx3jLg==
X-CSE-MsgGUID: el9fcmipRv6R/KlK1bd87g==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15987884"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15987884"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:56:52 -0700
X-CSE-ConnectionGUID: 1Q6+O7oST36QjJLIEQlYfg==
X-CSE-MsgGUID: yxRh90eJQ0y1Dcvlwc/tdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46772132"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jun 2024 06:56:48 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 09/14] idpf: compile singleq code only under default-n CONFIG_IDPF_SINGLEQ
Date: Thu, 20 Jun 2024 15:53:42 +0200
Message-ID: <20240620135347.3006818-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
References: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, all HW supporting idpf supports the singleq model, but none
of it advertises it by default, as splitq is supported and preferred
for multiple reasons. Still, this almost dead code often times adds
hotpath branches and redundant cacheline accesses.
While it can't currently be removed, add CONFIG_IDPF_SINGLEQ and build
the singleq code only when it's enabled manually. This corresponds to
-10 Kb of object code size and a good bunch of hotpath checks.
idpf_is_queue_model_split() works as a gate and compiles out to `true`
when the config option is disabled.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            | 13 +--------
 drivers/net/ethernet/intel/idpf/Kconfig       | 27 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/Makefile      |  3 ++-
 drivers/net/ethernet/intel/idpf/idpf.h        |  3 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 15 ++++++++---
 6 files changed, 44 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/Kconfig

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index e0287fbd501d..0375c7448a57 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -384,17 +384,6 @@ config IGC_LEDS
 	  Optional support for controlling the NIC LED's with the netdev
 	  LED trigger.
 
-config IDPF
-	tristate "Intel(R) Infrastructure Data Path Function Support"
-	depends on PCI_MSI
-	select DIMLIB
-	select PAGE_POOL
-	select PAGE_POOL_STATS
-	help
-	  This driver supports Intel(R) Infrastructure Data Path Function
-	  devices.
-
-	  To compile this driver as a module, choose M here. The module
-	  will be called idpf.
+source "drivers/net/ethernet/intel/idpf/Kconfig"
 
 endif # NET_VENDOR_INTEL
diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
new file mode 100644
index 000000000000..9082c16edb7e
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2024 Intel Corporation
+
+config IDPF
+	tristate "Intel(R) Infrastructure Data Path Function Support"
+	depends on PCI_MSI
+	select DIMLIB
+	select PAGE_POOL
+	select PAGE_POOL_STATS
+	help
+	  This driver supports Intel(R) Infrastructure Data Path Function
+	  devices.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called idpf.
+
+if IDPF
+
+config IDPF_SINGLEQ
+	bool "idpf singleq support"
+	help
+	  This option enables support for legacy single Rx/Tx queues w/no
+	  completion and fill queues. Only enable if you have hardware which
+	  wants to work in this mode as it increases the driver size and adds
+	  runtme checks on hotpath.
+
+endif # IDPF
diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 6844ead2f3ac..2ce01a0b5898 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -12,7 +12,8 @@ idpf-y := \
 	idpf_ethtool.o		\
 	idpf_lib.o		\
 	idpf_main.o		\
-	idpf_singleq_txrx.o	\
 	idpf_txrx.o		\
 	idpf_virtchnl.o 	\
 	idpf_vf_dev.o
+
+idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f9e43d171f17..5d9529f5b41b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -599,7 +599,8 @@ struct idpf_adapter {
  */
 static inline int idpf_is_queue_model_split(u16 q_model)
 {
-	return q_model == VIRTCHNL2_QUEUE_MODEL_SPLIT;
+	return !IS_ENABLED(CONFIG_IDPF_SINGLEQ) ||
+	       q_model == VIRTCHNL2_QUEUE_MODEL_SPLIT;
 }
 
 #define idpf_is_cap_ena(adapter, field, flag) \
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 5dd1b1a9e624..e79a8f9dfc40 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1309,7 +1309,7 @@ static void idpf_vport_calc_numq_per_grp(struct idpf_vport *vport,
 static void idpf_rxq_set_descids(const struct idpf_vport *vport,
 				 struct idpf_rx_queue *q)
 {
-	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
+	if (idpf_is_queue_model_split(vport->rxq_model)) {
 		q->rxdids = VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M;
 	} else {
 		if (vport->base_rxd)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 44602b87cd41..1aa4770dfe18 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1256,12 +1256,12 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 	vport_msg->vport_type = cpu_to_le16(VIRTCHNL2_VPORT_TYPE_DEFAULT);
 	vport_msg->vport_index = cpu_to_le16(idx);
 
-	if (adapter->req_tx_splitq)
+	if (adapter->req_tx_splitq || !IS_ENABLED(CONFIG_IDPF_SINGLEQ))
 		vport_msg->txq_model = cpu_to_le16(VIRTCHNL2_QUEUE_MODEL_SPLIT);
 	else
 		vport_msg->txq_model = cpu_to_le16(VIRTCHNL2_QUEUE_MODEL_SINGLE);
 
-	if (adapter->req_rx_splitq)
+	if (adapter->req_rx_splitq || !IS_ENABLED(CONFIG_IDPF_SINGLEQ))
 		vport_msg->rxq_model = cpu_to_le16(VIRTCHNL2_QUEUE_MODEL_SPLIT);
 	else
 		vport_msg->rxq_model = cpu_to_le16(VIRTCHNL2_QUEUE_MODEL_SINGLE);
@@ -1323,10 +1323,17 @@ int idpf_check_supported_desc_ids(struct idpf_vport *vport)
 
 	vport_msg = adapter->vport_params_recvd[vport->idx];
 
+	if (!IS_ENABLED(CONFIG_IDPF_SINGLEQ) &&
+	    (vport_msg->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE ||
+	     vport_msg->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)) {
+		pci_err(adapter->pdev, "singleq mode requested, but not compiled-in\n");
+		return -EOPNOTSUPP;
+	}
+
 	rx_desc_ids = le64_to_cpu(vport_msg->rx_desc_ids);
 	tx_desc_ids = le64_to_cpu(vport_msg->tx_desc_ids);
 
-	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
+	if (idpf_is_queue_model_split(vport->rxq_model)) {
 		if (!(rx_desc_ids & VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M)) {
 			dev_info(&adapter->pdev->dev, "Minimum RX descriptor support not provided, using the default\n");
 			vport_msg->rx_desc_ids = cpu_to_le64(VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M);
@@ -1336,7 +1343,7 @@ int idpf_check_supported_desc_ids(struct idpf_vport *vport)
 			vport->base_rxd = true;
 	}
 
-	if (vport->txq_model != VIRTCHNL2_QUEUE_MODEL_SPLIT)
+	if (!idpf_is_queue_model_split(vport->txq_model))
 		return 0;
 
 	if ((tx_desc_ids & MIN_SUPPORT_TXDID) != MIN_SUPPORT_TXDID) {
-- 
2.45.2


