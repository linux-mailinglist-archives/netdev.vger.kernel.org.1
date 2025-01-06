Return-Path: <netdev+bounces-155619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC29A0329F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F8C3A53AF
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC01E3DEA;
	Mon,  6 Jan 2025 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMLdf5As"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E21E32B6;
	Mon,  6 Jan 2025 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201988; cv=none; b=B5jBV52CFowLKXDgWA3X8s2yy06vKUT0rvY9OZfPBrzsJRvP4JXfq9jO7p8Kq8Z+14AHRfw0vBi+yLDA3XFceC6Oidfj+1E1ttMQfJTJTF8oXyY8QFOqBOMACvbHorMOAue2SDajJl2lusysYRvGQIT7x110RdIi32SHe3ImGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201988; c=relaxed/simple;
	bh=lUcZy6aZWFAulKbcwerGMfQviHmgOeiIBkdIZAajK78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRL9cgwgKnkZ3U2MdcE/UzfLRYY15ppkvwcRC/sEt7FlN6XQPaWLT5RjNZg2IjlRvYauwVH/bIMGVsHhl9nUGDqaMg+ELp4xBK0xSfDlIOXPoytBJ/sZEAPQCev57o2faImubGpD1AjyUazY4Q7CzsHsa42VRnTIgWnnNMDzN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMLdf5As; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201985; x=1767737985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUcZy6aZWFAulKbcwerGMfQviHmgOeiIBkdIZAajK78=;
  b=OMLdf5Asx8XLOSwhhOF7Humf3D5PXxViGbQfT9VbysUTx8bUmR+6eEuC
   cgQb0usUMPvycwSijKuNbKNCru1EVElQkyhoDabXBIKas5c6YlKL/NSft
   2MSti8P1CtmlnQbpCCQbMl9J7qfKFtujjkppgkr2ML+qXvyVLYo4T8R+k
   rkfZDVIBJXY14Q3fBp+gO45o4c0bMh+afScIedBbU5lBftoR2iViCheXy
   vBplABZ/18bijVR35SPcFM4AhYGVUdhE0DQrJipSRbWccIoBQ4zo/5uya
   BufhdflRWuDZSls2+UZg2WPhIDq4SPRAdSWaialNOpzGMTf4lGkFY81Uk
   w==;
X-CSE-ConnectionGUID: /Kr50FzeRNy19INcPlXTdQ==
X-CSE-MsgGUID: v+sFE5sRQOmdfnj+T6a0Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858763"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858763"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:41 -0800
X-CSE-ConnectionGUID: VlwNk8LGSPStQntTytfXgQ==
X-CSE-MsgGUID: BLIiJ7hDQoOJw+lUxd0F/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368487"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:41 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Padraig J Connolly <padraig.j.connolly@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 12/15] i40e: add ability to reset VF for Tx and Rx MDD events
Date: Mon,  6 Jan 2025 14:19:20 -0800
Message-ID: <20250106221929.956999-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Implement "mdd-auto-reset-vf" priv-flag to handle Tx and Rx MDD events for VFs.
This flag is also used in other network adapters like ICE.

Usage:
- "on"  - The problematic VF will be automatically reset
	  if a malformed descriptor is detected.
- "off" - The problematic VF will be disabled.

In cases where a VF sends malformed packets classified as malicious, it can
cause the Tx queue to freeze, rendering it unusable for several minutes. When
an MDD event occurs, this new implementation allows for a graceful VF reset to
quickly restore operational state.

Currently, VF queues are disabled if an MDD event occurs. This patch adds the
ability to reset the VF if a Tx or Rx MDD event occurs. It also includes MDD
event logging throttling to avoid dmesg pollution and unifies the format of
Tx and Rx MDD messages.

Note: Standard message rate limiting functions like dev_info_ratelimited()
do not meet our requirements. Custom rate limiting is implemented,
please see the code for details.

Co-developed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Co-developed-by: Padraig J Connolly <padraig.j.connolly@intel.com>
Signed-off-by: Padraig J Connolly <padraig.j.connolly@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../device_drivers/ethernet/intel/i40e.rst    |  12 ++
 drivers/net/ethernet/intel/i40e/i40e.h        |   4 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |   2 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 107 +++++++++++++++---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  11 +-
 7 files changed, 123 insertions(+), 17 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
index 4fbaa1a2d674..53d9d5829d69 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
@@ -299,6 +299,18 @@ Use ethtool to view and set link-down-on-close, as follows::
   ethtool --show-priv-flags ethX
   ethtool --set-priv-flags ethX link-down-on-close [on|off]
 
+Setting the mdd-auto-reset-vf Private Flag
+------------------------------------------
+
+When the mdd-auto-reset-vf private flag is set to "on", the problematic VF will
+be automatically reset if a malformed descriptor is detected. If the flag is
+set to "off", the problematic VF will be disabled.
+
+Use ethtool to view and set mdd-auto-reset-vf, as follows::
+
+  ethtool --show-priv-flags ethX
+  ethtool --set-priv-flags ethX mdd-auto-reset-vf [on|off]
+
 Viewing Link Messages
 ---------------------
 Link messages will not be displayed to the console if the distribution is
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d4255c2706fa..e537ce3cf2a2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -88,6 +88,7 @@ enum i40e_state {
 	__I40E_SERVICE_SCHED,
 	__I40E_ADMINQ_EVENT_PENDING,
 	__I40E_MDD_EVENT_PENDING,
+	__I40E_MDD_VF_PRINT_PENDING,
 	__I40E_VFLR_EVENT_PENDING,
 	__I40E_RESET_RECOVERY_PENDING,
 	__I40E_TIMEOUT_RECOVERY_PENDING,
@@ -191,6 +192,7 @@ enum i40e_pf_flags {
 	 */
 	I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA,
 	I40E_FLAG_VF_VLAN_PRUNING_ENA,
+	I40E_FLAG_MDD_AUTO_RESET_VF,
 	I40E_PF_FLAGS_NBITS,		/* must be last */
 };
 
@@ -572,7 +574,7 @@ struct i40e_pf {
 	int num_alloc_vfs;	/* actual number of VFs allocated */
 	u32 vf_aq_requests;
 	u32 arq_overflows;	/* Not fatal, possibly indicative of problems */
-
+	struct ratelimit_state mdd_message_rate_limit;
 	/* DCBx/DCBNL capability for PF that indicates
 	 * whether DCBx is managed by firmware or host
 	 * based agent (LLDPAD). Also, indicates what
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 208c2f0857b6..6cd9da662ae1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -722,7 +722,7 @@ static void i40e_dbg_dump_vf(struct i40e_pf *pf, int vf_id)
 		dev_info(&pf->pdev->dev, "vf %2d: VSI id=%d, seid=%d, qps=%d\n",
 			 vf_id, vf->lan_vsi_id, vsi->seid, vf->num_queue_pairs);
 		dev_info(&pf->pdev->dev, "       num MDD=%lld\n",
-			 vf->num_mdd_events);
+			 vf->mdd_tx_events.count + vf->mdd_rx_events.count);
 	} else {
 		dev_info(&pf->pdev->dev, "invalid VF id %d\n", vf_id);
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index bce5b76f1e7a..8a7a83f83ee5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -459,6 +459,8 @@ static const struct i40e_priv_flags i40e_gstrings_priv_flags[] = {
 	I40E_PRIV_FLAG("base-r-fec", I40E_FLAG_BASE_R_FEC, 0),
 	I40E_PRIV_FLAG("vf-vlan-pruning",
 		       I40E_FLAG_VF_VLAN_PRUNING_ENA, 0),
+	I40E_PRIV_FLAG("mdd-auto-reset-vf",
+		       I40E_FLAG_MDD_AUTO_RESET_VF, 0),
 };
 
 #define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gstrings_priv_flags)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0e1d9e2fbf38..ce6d1b5cb632 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11216,6 +11216,67 @@ static void i40e_handle_reset_warning(struct i40e_pf *pf, bool lock_acquired)
 	i40e_reset_and_rebuild(pf, false, lock_acquired);
 }
 
+/**
+ * i40e_print_vf_mdd_event - print VF Tx/Rx malicious driver detect event
+ * @pf: board private structure
+ * @vf: pointer to the VF structure
+ * @is_tx: true - for Tx event, false - for  Rx
+ */
+static void i40e_print_vf_mdd_event(struct i40e_pf *pf, struct i40e_vf *vf,
+				    bool is_tx)
+{
+	dev_err(&pf->pdev->dev, is_tx ?
+		"%lld Tx Malicious Driver Detection events detected on PF %d VF %d MAC %pm. mdd-auto-reset-vfs=%s\n" :
+		"%lld Rx Malicious Driver Detection events detected on PF %d VF %d MAC %pm. mdd-auto-reset-vfs=%s\n",
+		is_tx ? vf->mdd_tx_events.count : vf->mdd_rx_events.count,
+		pf->hw.pf_id,
+		vf->vf_id,
+		vf->default_lan_addr.addr,
+		str_on_off(test_bit(I40E_FLAG_MDD_AUTO_RESET_VF, pf->flags)));
+}
+
+/**
+ * i40e_print_vfs_mdd_events - print VFs malicious driver detect event
+ * @pf: pointer to the PF structure
+ *
+ * Called from i40e_handle_mdd_event to rate limit and print VFs MDD events.
+ */
+static void i40e_print_vfs_mdd_events(struct i40e_pf *pf)
+{
+	unsigned int i;
+
+	/* check that there are pending MDD events to print */
+	if (!test_and_clear_bit(__I40E_MDD_VF_PRINT_PENDING, pf->state))
+		return;
+
+	if (!__ratelimit(&pf->mdd_message_rate_limit))
+		return;
+
+	for (i = 0; i < pf->num_alloc_vfs; i++) {
+		struct i40e_vf *vf = &pf->vf[i];
+		bool is_printed = false;
+
+		/* only print Rx MDD event message if there are new events */
+		if (vf->mdd_rx_events.count != vf->mdd_rx_events.last_printed) {
+			vf->mdd_rx_events.last_printed = vf->mdd_rx_events.count;
+			i40e_print_vf_mdd_event(pf, vf, false);
+			is_printed = true;
+		}
+
+		/* only print Tx MDD event message if there are new events */
+		if (vf->mdd_tx_events.count != vf->mdd_tx_events.last_printed) {
+			vf->mdd_tx_events.last_printed = vf->mdd_tx_events.count;
+			i40e_print_vf_mdd_event(pf, vf, true);
+			is_printed = true;
+		}
+
+		if (is_printed && !test_bit(I40E_FLAG_MDD_AUTO_RESET_VF, pf->flags))
+			dev_info(&pf->pdev->dev,
+				 "Use PF Control I/F to re-enable the VF #%d\n",
+				 i);
+	}
+}
+
 /**
  * i40e_handle_mdd_event
  * @pf: pointer to the PF structure
@@ -11230,8 +11291,13 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 	u32 reg;
 	int i;
 
-	if (!test_bit(__I40E_MDD_EVENT_PENDING, pf->state))
+	if (!test_and_clear_bit(__I40E_MDD_EVENT_PENDING, pf->state)) {
+		/* Since the VF MDD event logging is rate limited, check if
+		 * there are pending MDD events.
+		 */
+		i40e_print_vfs_mdd_events(pf);
 		return;
+	}
 
 	/* find what triggered the MDD event */
 	reg = rd32(hw, I40E_GL_MDET_TX);
@@ -11275,36 +11341,48 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 
 	/* see if one of the VFs needs its hand slapped */
 	for (i = 0; i < pf->num_alloc_vfs && mdd_detected; i++) {
+		bool is_mdd_on_tx = false;
+		bool is_mdd_on_rx = false;
+
 		vf = &(pf->vf[i]);
 		reg = rd32(hw, I40E_VP_MDET_TX(i));
 		if (reg & I40E_VP_MDET_TX_VALID_MASK) {
+			set_bit(__I40E_MDD_VF_PRINT_PENDING, pf->state);
 			wr32(hw, I40E_VP_MDET_TX(i), 0xFFFF);
-			vf->num_mdd_events++;
-			dev_info(&pf->pdev->dev, "TX driver issue detected on VF %d\n",
-				 i);
-			dev_info(&pf->pdev->dev,
-				 "Use PF Control I/F to re-enable the VF\n");
+			vf->mdd_tx_events.count++;
 			set_bit(I40E_VF_STATE_DISABLED, &vf->vf_states);
+			is_mdd_on_tx = true;
 		}
 
 		reg = rd32(hw, I40E_VP_MDET_RX(i));
 		if (reg & I40E_VP_MDET_RX_VALID_MASK) {
+			set_bit(__I40E_MDD_VF_PRINT_PENDING, pf->state);
 			wr32(hw, I40E_VP_MDET_RX(i), 0xFFFF);
-			vf->num_mdd_events++;
-			dev_info(&pf->pdev->dev, "RX driver issue detected on VF %d\n",
-				 i);
-			dev_info(&pf->pdev->dev,
-				 "Use PF Control I/F to re-enable the VF\n");
+			vf->mdd_rx_events.count++;
 			set_bit(I40E_VF_STATE_DISABLED, &vf->vf_states);
+			is_mdd_on_rx = true;
+		}
+
+		if ((is_mdd_on_tx || is_mdd_on_rx) &&
+		    test_bit(I40E_FLAG_MDD_AUTO_RESET_VF, pf->flags)) {
+			/* VF MDD event counters will be cleared by
+			 * reset, so print the event prior to reset.
+			 */
+			if (is_mdd_on_rx)
+				i40e_print_vf_mdd_event(pf, vf, false);
+			if (is_mdd_on_tx)
+				i40e_print_vf_mdd_event(pf, vf, true);
+
+			i40e_vc_reset_vf(vf, true);
 		}
 	}
 
-	/* re-enable mdd interrupt cause */
-	clear_bit(__I40E_MDD_EVENT_PENDING, pf->state);
 	reg = rd32(hw, I40E_PFINT_ICR0_ENA);
 	reg |=  I40E_PFINT_ICR0_ENA_MAL_DETECT_MASK;
 	wr32(hw, I40E_PFINT_ICR0_ENA, reg);
 	i40e_flush(hw);
+
+	i40e_print_vfs_mdd_events(pf);
 }
 
 /**
@@ -15998,6 +16076,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			 ERR_PTR(err),
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
+	/* VF MDD event logs are rate limited to one second intervals */
+	ratelimit_state_init(&pf->mdd_message_rate_limit, 1 * HZ, 1);
+
 	/* Reconfigure hardware for allowing smaller MSS in the case
 	 * of TSO, so that we avoid the MDD being fired and causing
 	 * a reset in the case of small MSS+TSO.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index dfa785e39458..1120f8e4bb67 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -216,7 +216,7 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
  * @notify_vf: notify vf about reset or not
  * Reset VF handler.
  **/
-static void i40e_vc_reset_vf(struct i40e_vf *vf, bool notify_vf)
+void i40e_vc_reset_vf(struct i40e_vf *vf, bool notify_vf)
 {
 	struct i40e_pf *pf = vf->pf;
 	int i;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 66f95e2f3146..5cf74f16f433 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -64,6 +64,12 @@ struct i40evf_channel {
 	u64 max_tx_rate; /* bandwidth rate allocation for VSIs */
 };
 
+struct i40e_mdd_vf_events {
+	u64 count;      /* total count of Rx|Tx events */
+	/* count number of the last printed event */
+	u64 last_printed;
+};
+
 /* VF information structure */
 struct i40e_vf {
 	struct i40e_pf *pf;
@@ -92,7 +98,9 @@ struct i40e_vf {
 
 	u8 num_queue_pairs;	/* num of qps assigned to VF vsis */
 	u8 num_req_queues;	/* num of requested qps */
-	u64 num_mdd_events;	/* num of mdd events detected */
+	/* num of mdd tx and rx events detected */
+	struct i40e_mdd_vf_events mdd_rx_events;
+	struct i40e_mdd_vf_events mdd_tx_events;
 
 	unsigned long vf_caps;	/* vf's adv. capabilities */
 	unsigned long vf_states;	/* vf's runtime states */
@@ -120,6 +128,7 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs);
 int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 			   u32 v_retval, u8 *msg, u16 msglen);
 int i40e_vc_process_vflr_event(struct i40e_pf *pf);
+void i40e_vc_reset_vf(struct i40e_vf *vf, bool notify_vf);
 bool i40e_reset_vf(struct i40e_vf *vf, bool flr);
 bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr);
 void i40e_vc_notify_vf_reset(struct i40e_vf *vf);
-- 
2.47.1


