Return-Path: <netdev+bounces-110639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9792DA19
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0564C1F24392
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C6C198825;
	Wed, 10 Jul 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OshQdGl2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90D198A35
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643449; cv=none; b=YXrixhciW4xkEq7r4jIod/tk42C7O7LWMxvS6IniLWychURK9XrzQVtLQl9ORoR5qrRhJl1NMW8O1oKNgY8nWxia6W2JYYM2Of8J0CJsM/N4pDrkhtxtx9/L0zzakPWUD7Zgw05jgtU9eLar2T49ewYz/8Bn15ezSxMl6br1pJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643449; c=relaxed/simple;
	bh=wCGvkgHbuySqHFCtn/sHoQrWA28O5S8TsiYpjHMvoOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHdFv22BzbItSAEW8QWYrrkFdPI/0ePrVabytsD6IAj3eouqVzdSNZjbyCTvHusWVySJ3YaYkqGjCOUFAf3k09iqnGn94boBgbOKzUM8OkoDIpt3vkIsSrdC1A+JLwnWDi+H0JLkYezElAmoUkNo/Gy45n8/Obx7gnBO/ntAQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OshQdGl2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720643448; x=1752179448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wCGvkgHbuySqHFCtn/sHoQrWA28O5S8TsiYpjHMvoOk=;
  b=OshQdGl21/LkkcrGEhckF9m1A+uJyF2+HvcbllOGoOfjX9s+vR2xg2mV
   Z/qlIMyUhgBWFSPCx29R5vZZjVrE3WvZ6KVvTgFUBoa3ORdS2+/uHevAr
   y6JAH6dEBLFLg9dy2hQ11twfeX19ujGGzckSMrjxJKjPKjrDLRF6zA7Su
   7eghHXBjxobjQIJkcwY3122YfFGe6ixrYfzNjYviKshn/wxeZVWZMIz3F
   V9pWZh3FGo/H3nT4XZXsnHz3mSNuJooeky2FRcdn2xLJTOJ2o2rX/y//O
   fQ4V7ISsf1812MZwe5KK0k2pPdSI9Fy1uWKVou7nCi0JYqMD02I5JkGB9
   A==;
X-CSE-ConnectionGUID: n2goynvzR/+8Yfit3ZbWKQ==
X-CSE-MsgGUID: De+CEAA3Sjao+xyOlXAA7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="12483778"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="12483778"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:30:43 -0700
X-CSE-ConnectionGUID: e42LsdMLRQiEKFS0+mpMlQ==
X-CSE-MsgGUID: 3urBpcRTSvqFslk+O6ZAkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48223882"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 10 Jul 2024 13:30:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	lihong.yang@intel.com,
	willemb@google.com,
	almasrymina@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 09/14] idpf: compile singleq code only under default-n CONFIG_IDPF_SINGLEQ
Date: Wed, 10 Jul 2024 13:30:25 -0700
Message-ID: <20240710203031.188081-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
References: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.41.0


