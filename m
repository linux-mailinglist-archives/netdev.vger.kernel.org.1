Return-Path: <netdev+bounces-286866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CIVDR9oAmr5sQEAu9opvQ
	(envelope-from <netdev+bounces-286866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:37:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD2517554
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50E4B300A5BD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66086361666;
	Mon, 11 May 2026 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9F4oswK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315733F5BA;
	Mon, 11 May 2026 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778542611; cv=none; b=oHnfl8pYhfMhl/M1qPgj17rxtgudEOca8tsvqnhYdUNvrdqwSvCOTxgUZrcPjHm9Xb/2ezf4OVWNllJTNremKA/L5AofLcSUpIcJAGpDLzaV+swZAxir/Jgf42GzD2j6Ev9Kvy137JiZr3XNMofhjgOZE98ZI/lPd0J0sY0P0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778542611; c=relaxed/simple;
	bh=P2R7vfz8WYZ4fAYXUxxzrAdwp9Hhn5Mm6Xn5w29IN2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzXmJyiERzQtJoBpgWvgA8SvnKOl7NI+CWS/Pnx2tDKgNNiWHnlysW7qikMGLILu1F5s7qOCFS5bEo96tc9BS6zHXB2RryjIACzbBbQTVUfVj2qIKXDs/tN5J/TpHNZsyeY7tXWXSOtdhMn6oDT7u8p8Xy+Z3SxuOtsjrevGVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9F4oswK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778542609; x=1810078609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2R7vfz8WYZ4fAYXUxxzrAdwp9Hhn5Mm6Xn5w29IN2Q=;
  b=c9F4oswK0N3cUAxW9jpTTGCwN3tc/E3qshT0czfprwuaqWpZHINf7WUD
   IWIxOmhidX7UJzkQNafCIuueqlC0YesS65y6SBWouhAMqJuYVBgksnyUr
   xUzYHpNtBTyNGkXt5eCVd8mcSbM8h0INKLx+FB4cllKyHPfIX0z5xY3LQ
   0BQ3olc+6LhuvRTTAz/iVCQ9y3mWzbPHC4pnMrD41fixZvyxZY0CiGJGa
   fEZLzi0WfjVAcdnOBBcW5NZBOJEPzDOS6tMFuRZZ1d7IoFyuuLXBEdAj3
   l+9VbpQtlA5VAAQrL7/nxdNSL6tqnSJReklmC/kzs8GcLVl/MKN+Y/bZn
   w==;
X-CSE-ConnectionGUID: n0wm1C/VQcCAyAlGdc467Q==
X-CSE-MsgGUID: pmAXvgDUR8udtO8A+jCGDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90027417"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90027417"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:36:49 -0700
X-CSE-ConnectionGUID: yv4A2IHcQB+VndXT04MzaQ==
X-CSE-MsgGUID: NNpPN8OAR1eGXWrlaIHTAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237687297"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa009.jf.intel.com with ESMTP; 11 May 2026 16:36:43 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v8 net-next 5/8] ice: introduce TXC DPLL device and TX ref clock pin framework for E825
Date: Tue, 12 May 2026 01:31:56 +0200
Message-Id: <20260511233159.2558165-6-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260511233159.2558165-1-grzegorz.nitka@intel.com>
References: <20260511233159.2558165-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37CD2517554
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286866-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

E825 devices provide a dedicated TX clock (TXC) domain which may be
driven by multiple reference clock sources, including external board
references and port-derived SyncE. To support future TX clock control
and observability through the Linux DPLL subsystem, introduce a
separate TXC DPLL device (of DPLL_TYPE_GENERIC) and a framework for
representing TX reference clock inputs.

This change adds a new internal DPLL pin type (TXCLK) and registers
TX reference clock pins for E825-based devices:
- EXT_EREF0: a board-level external electrical reference
- SYNCE: a port-derived SyncE reference described via firmware nodes

The TXC DPLL device is created and managed alongside the existing
PPS and EEC DPLL instances. TXCLK pins are registered directly or
deferred via a notifier when backed by fwnode-described pins.
A per-pin attribute encodes the TX reference source associated with
each TXCLK pin.

At this stage, TXCLK pin state callbacks and TXC DPLL lock status
reporting are implemented as placeholders. Pin state getters always
return DISCONNECTED, and the TXC DPLL is initialized in the UNLOCKED
state. No hardware configuration or TX reference switching is
performed yet.

This patch establishes the structural groundwork required for
hardware-backed TX reference selection, verification, and
synchronization status reporting, which will be implemented in
subsequent patches.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 320 ++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h   |   6 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   7 +
 3 files changed, 308 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index a00da99dd19f..d3b9e34b48d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -19,6 +19,11 @@
 #define ICE_DPLL_SW_PIN_INPUT_BASE_QSFP		6
 #define ICE_DPLL_SW_PIN_OUTPUT_BASE		0
 
+#define E825_EXT_EREF_PIN_IDX			0
+#define E825_EXT_SYNCE_PIN_IDX			1
+#define E825_RCLK_PARENT_0_PIN_IDX		0
+#define E825_RCLK_PARENT_1_PIN_IDX		1
+
 #define ICE_DPLL_PIN_SW_INPUT_ABS(in_idx) \
 	(ICE_DPLL_SW_PIN_INPUT_BASE_SFP + (in_idx))
 
@@ -57,6 +62,7 @@
  * @ICE_DPLL_PIN_TYPE_OUTPUT: output pin
  * @ICE_DPLL_PIN_TYPE_RCLK_INPUT: recovery clock input pin
  * @ICE_DPLL_PIN_TYPE_SOFTWARE: software controlled SMA/U.FL pins
+ * @ICE_DPLL_PIN_TYPE_TXCLK: transmit clock reference input pin
  */
 enum ice_dpll_pin_type {
 	ICE_DPLL_PIN_INVALID,
@@ -64,6 +70,7 @@ enum ice_dpll_pin_type {
 	ICE_DPLL_PIN_TYPE_OUTPUT,
 	ICE_DPLL_PIN_TYPE_RCLK_INPUT,
 	ICE_DPLL_PIN_TYPE_SOFTWARE,
+	ICE_DPLL_PIN_TYPE_TXCLK,
 };
 
 static const char * const pin_type_name[] = {
@@ -71,10 +78,13 @@ static const char * const pin_type_name[] = {
 	[ICE_DPLL_PIN_TYPE_OUTPUT] = "output",
 	[ICE_DPLL_PIN_TYPE_RCLK_INPUT] = "rclk-input",
 	[ICE_DPLL_PIN_TYPE_SOFTWARE] = "software",
+	[ICE_DPLL_PIN_TYPE_TXCLK] = "txclk-input",
 };
 
 static const char * const ice_dpll_sw_pin_sma[] = { "SMA1", "SMA2" };
 static const char * const ice_dpll_sw_pin_ufl[] = { "U.FL1", "U.FL2" };
+static const char * const ice_dpll_ext_eref_pin = "EXT_EREF0";
+static const char * const ice_dpll_fwnode_ext_synce = "clk_ref_synce";
 
 static const struct dpll_pin_frequency ice_esync_range[] = {
 	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
@@ -2600,12 +2610,75 @@ ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
 	return ret;
 }
 
+/**
+ * ice_dpll_txclk_state_on_dpll_set - set a state on TX clk pin
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @state: state to be set on pin
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback, set a state of a Tx reference clock pin
+ *
+ * Return:
+ * * negative - failure
+ */
+static int
+ice_dpll_txclk_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
+				 const struct dpll_device *dpll,
+				 void *dpll_priv, enum dpll_pin_state state,
+				 struct netlink_ext_ack *extack)
+{
+	/*
+	 * TODO: set HW accordingly to selected TX reference clock.
+	 * To be added in the follow up patches.
+	 */
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ice_dpll_txclk_state_on_dpll_get - get a state of Tx clk reference pin
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @state: on success holds pin state on parent pin
+ * @extack: error reporting
+ *
+ * dpll subsystem callback, get a state of a TX clock reference pin.
+ *
+ * Return:
+ * * 0 - success
+ */
+static int
+ice_dpll_txclk_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
+				 const struct dpll_device *dpll,
+				 void *dpll_priv,
+				 enum dpll_pin_state *state,
+				 struct netlink_ext_ack *extack)
+{
+	/*
+	 * TODO: query HW status to determine if the TX reference is selected.
+	 * To be added in the follow up patches.
+	 */
+	*state = DPLL_PIN_STATE_DISCONNECTED;
+
+	return 0;
+}
+
 static const struct dpll_pin_ops ice_dpll_rclk_ops = {
 	.state_on_pin_set = ice_dpll_rclk_state_on_pin_set,
 	.state_on_pin_get = ice_dpll_rclk_state_on_pin_get,
 	.direction_get = ice_dpll_input_direction,
 };
 
+static const struct dpll_pin_ops ice_dpll_txclk_ops = {
+	.state_on_dpll_set = ice_dpll_txclk_state_on_dpll_set,
+	.state_on_dpll_get = ice_dpll_txclk_state_on_dpll_get,
+	.direction_get = ice_dpll_input_direction,
+};
+
 static const struct dpll_pin_ops ice_dpll_pin_sma_ops = {
 	.state_on_dpll_set = ice_dpll_sma_pin_state_set,
 	.state_on_dpll_get = ice_dpll_sw_pin_state_get,
@@ -3128,9 +3201,13 @@ ice_dpll_unregister_pins(struct dpll_device *dpll, struct ice_dpll_pin *pins,
 {
 	int i;
 
-	for (i = 0; i < count; i++)
-		if (!pins[i].hidden)
-			dpll_pin_unregister(dpll, pins[i].pin, ops, &pins[i]);
+	for (i = 0; i < count; i++) {
+		if (pins[i].hidden)
+			continue;
+		if (IS_ERR_OR_NULL(pins[i].pin))
+			continue;
+		dpll_pin_unregister(dpll, pins[i].pin, ops, &pins[i]);
+	}
 }
 
 /**
@@ -3304,19 +3381,40 @@ static bool ice_dpll_is_fwnode_pin(struct ice_dpll_pin *pin)
 	return !IS_ERR_OR_NULL(pin->fwnode);
 }
 
+static bool ice_dpll_fwnode_eq(const struct fwnode_handle *a,
+			       const struct fwnode_handle *b)
+{
+	return a && a == b;
+}
+
 static void ice_dpll_pin_notify_work(struct work_struct *work)
 {
 	struct ice_dpll_pin_work *w = container_of(work,
 						   struct ice_dpll_pin_work,
 						   work);
 	struct ice_dpll_pin *pin, *parent = w->pin;
+	bool is_tx_synce_parent = false;
 	struct ice_pf *pf = parent->pf;
+	bool is_rclk_parent = false;
 	int ret;
 
 	wait_for_completion(&pf->dplls.dpll_init);
 	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
 		goto out; /* DPLL initialization failed */
 
+	/* Decide which parent we are handling, defensively checking FWNs */
+	is_rclk_parent =
+		ice_dpll_fwnode_eq(parent->fwnode,
+				   pf->dplls.inputs[E825_RCLK_PARENT_0_PIN_IDX].fwnode) ||
+		ice_dpll_fwnode_eq(parent->fwnode,
+				   pf->dplls.inputs[E825_RCLK_PARENT_1_PIN_IDX].fwnode);
+
+	is_tx_synce_parent =
+		ice_dpll_fwnode_eq(parent->fwnode,
+				   pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX].fwnode);
+	if (!is_rclk_parent && !is_tx_synce_parent)
+		goto out;
+
 	switch (w->action) {
 	case DPLL_PIN_CREATED:
 		if (!IS_ERR_OR_NULL(parent->pin)) {
@@ -3333,16 +3431,28 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 			goto out;
 		}
 
-		/* Register rclk pin */
-		pin = &pf->dplls.rclk;
-		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
-					       &ice_dpll_rclk_ops, pin);
-		if (ret) {
-			dev_err(ice_pf_to_dev(pf),
-				"Failed to register pin: %pe\n", ERR_PTR(ret));
-			dpll_pin_put(parent->pin, &parent->tracker);
-			parent->pin = NULL;
-			goto out;
+		if (is_rclk_parent) {
+			/* Register rclk pin via on-pin relationship */
+			pin = &pf->dplls.rclk;
+			ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
+						       &ice_dpll_rclk_ops, pin);
+			if (ret) {
+				dev_err(ice_pf_to_dev(pf),
+					"RCLK pin register failed: %pe\n",
+					ERR_PTR(ret));
+				goto drop_parent_ref;
+			}
+		} else if (is_tx_synce_parent) {
+			/* Register TX-CLK SYNCE pin directly to TXC DPLL */
+			pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
+			ret = dpll_pin_register(pf->dplls.txc.dpll, pin->pin,
+						&ice_dpll_txclk_ops, pin);
+			if (ret) {
+				dev_err(ice_pf_to_dev(pf),
+					"TX SYNCE pin register failed: %pe\n",
+					ERR_PTR(ret));
+				goto drop_parent_ref;
+			}
 		}
 		break;
 	case DPLL_PIN_DELETED:
@@ -3351,11 +3461,18 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 			goto out;
 		}
 
-		/* Unregister rclk pin */
-		pin = &pf->dplls.rclk;
-		dpll_pin_on_pin_unregister(parent->pin, pin->pin,
-					   &ice_dpll_rclk_ops, pin);
-
+		if (is_rclk_parent) {
+			/* Unregister rclk pin */
+			pin = &pf->dplls.rclk;
+			dpll_pin_on_pin_unregister(parent->pin, pin->pin,
+						   &ice_dpll_rclk_ops, pin);
+		} else if (is_tx_synce_parent) {
+			/* Unregister TX-CLK SYNCE pin from TXC DPLL */
+			pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
+			dpll_pin_unregister(pf->dplls.txc.dpll, pin->pin,
+					    &ice_dpll_txclk_ops, pin);
+		}
+drop_parent_ref:
 		/* Drop fwnode pin reference */
 		dpll_pin_put(parent->pin, &parent->tracker);
 		parent->pin = NULL;
@@ -3381,6 +3498,12 @@ static int ice_dpll_pin_notify(struct notifier_block *nb, unsigned long action,
 	if (pin->fwnode != info->fwnode)
 		return NOTIFY_DONE; /* Not this pin */
 
+	/* Ignore notification which are the outcome of internal pin
+	 * registration/unregistration calls - synce pin case.
+	 */
+	if (info->src_clock_id == pin->pf->dplls.clock_id)
+		return NOTIFY_DONE;
+
 	work = kzalloc_obj(*work);
 	if (!work)
 		return NOTIFY_DONE;
@@ -3483,10 +3606,16 @@ ice_dpll_init_rclk_pin(struct ice_pf *pf, int start_idx,
 }
 
 static void
-ice_dpll_deinit_fwnode_pin(struct ice_dpll_pin *pin)
+ice_dpll_stop_fwnode_pin_activity(struct ice_dpll_pin *pin, bool flush)
 {
 	unregister_dpll_notifier(&pin->nb);
-	flush_workqueue(pin->pf->dplls.wq);
+	if (flush)
+		flush_workqueue(pin->pf->dplls.wq);
+}
+
+static void
+ice_dpll_release_fwnode_pin(struct ice_dpll_pin *pin)
+{
 	if (!IS_ERR_OR_NULL(pin->pin)) {
 		dpll_pin_put(pin->pin, &pin->tracker);
 		pin->pin = NULL;
@@ -3495,6 +3624,13 @@ ice_dpll_deinit_fwnode_pin(struct ice_dpll_pin *pin)
 	pin->fwnode = NULL;
 }
 
+static void
+ice_dpll_deinit_fwnode_pin(struct ice_dpll_pin *pin)
+{
+	ice_dpll_stop_fwnode_pin_activity(pin, true);
+	ice_dpll_release_fwnode_pin(pin);
+}
+
 static void
 ice_dpll_deinit_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 			    int start_idx)
@@ -3506,6 +3642,20 @@ ice_dpll_deinit_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 	destroy_workqueue(pf->dplls.wq);
 }
 
+static int ice_dpll_deinit_txclk_pins(struct ice_pf *pf)
+{
+	struct ice_dpll_pin *synce_pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
+	struct ice_dpll *dt = &pf->dplls.txc;
+
+	ice_dpll_stop_fwnode_pin_activity(synce_pin, true);
+	ice_dpll_unregister_pins(dt->dpll, pf->dplls.txclks,
+				 &ice_dpll_txclk_ops,
+				 ARRAY_SIZE(pf->dplls.txclks));
+	ice_dpll_release_pins(&pf->dplls.txclks[E825_EXT_EREF_PIN_IDX], 1);
+	ice_dpll_release_fwnode_pin(synce_pin);
+	return 0;
+}
+
 /**
  * ice_dpll_deinit_pins - deinitialize direct pins
  * @pf: board private structure
@@ -3525,8 +3675,10 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 	struct ice_dpll *dp = &d->pps;
 
 	ice_dpll_deinit_rclk_pin(pf);
-	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
+	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
+		ice_dpll_deinit_txclk_pins(pf);
 		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
+	}
 	if (cgu) {
 		ice_dpll_unregister_pins(dp->dpll, inputs, &ice_dpll_input_ops,
 					 num_inputs);
@@ -3657,6 +3809,64 @@ ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 	return ret;
 }
 
+static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
+{
+	struct ice_dpll_pin *ref_pin = pf->dplls.txclks;
+	struct ice_dpll *txc = &pf->dplls.txc;
+	int ret;
+
+	/* Configure EXT_EREF0 pin */
+	ret = ice_dpll_get_pins(pf, ref_pin, start_idx, 1, pf->dplls.clock_id);
+	if (ret)
+		return ret;
+	ret = dpll_pin_register(txc->dpll, ref_pin->pin, &ice_dpll_txclk_ops,
+				ref_pin);
+	if (ret)
+		goto err_release_ext_eref;
+
+	/*
+	 * Configure EXT_SYNCE pin (fwnode-backed).
+	 * The pin may not yet be available; in that case registration
+	 * will be deferred via the notifier path.
+	 */
+	ref_pin++;
+	ret = ice_dpll_init_fwnode_pin(ref_pin, ice_dpll_fwnode_ext_synce);
+	if (ret)
+		goto err_unregister_ext_eref;
+
+	if (IS_ERR_OR_NULL(ref_pin->pin)) {
+		dev_dbg(ice_pf_to_dev(pf),
+			"Tx-clk SYNCE pin not registered yet\n");
+		return 0;
+	}
+
+	ret = dpll_pin_register(txc->dpll, ref_pin->pin, &ice_dpll_txclk_ops,
+				ref_pin);
+	if (ret)
+		goto err_deinit_synce;
+
+	return 0;
+
+err_deinit_synce:
+	/*
+	 * Avoid deadlock against notifier workers blocked on dpll_init.
+	 * The outer init error path will complete dpll_init and flush the
+	 * shared workqueue before destroying it.
+	 */
+	ice_dpll_stop_fwnode_pin_activity(ref_pin, false);
+	ice_dpll_release_fwnode_pin(ref_pin);
+err_unregister_ext_eref:
+	dpll_pin_unregister(txc->dpll,
+			    pf->dplls.txclks[E825_EXT_EREF_PIN_IDX].pin,
+			    &ice_dpll_txclk_ops,
+			    &pf->dplls.txclks[E825_EXT_EREF_PIN_IDX]);
+
+err_release_ext_eref:
+	ice_dpll_release_pins(&pf->dplls.txclks[E825_EXT_EREF_PIN_IDX], 1);
+
+	return ret;
+}
+
 /**
  * ice_dpll_init_pins_e825 - init pins and register pins with a dplls
  * @pf: board private structure
@@ -3679,6 +3889,15 @@ static int ice_dpll_init_pins_e825(struct ice_pf *pf)
 
 	ret = ice_dpll_init_rclk_pin(pf, DPLL_PIN_IDX_UNSPEC,
 				     &ice_dpll_rclk_ops);
+
+	if (ret)
+		goto unregister_pins;
+
+	ret = ice_dpll_init_txclk_pins(pf, 0);
+	if (ret)
+		ice_dpll_deinit_rclk_pin(pf);
+
+unregister_pins:
 	if (ret) {
 		/* Inform DPLL notifier works that DPLL init was finished
 		 * unsuccessfully (ICE_DPLL_FLAG not set).
@@ -3797,7 +4016,7 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
 static void
 ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
 {
-	if (cgu)
+	if (cgu || pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
 		dpll_device_unregister(d->dpll, d->ops, d);
 	dpll_device_put(d->dpll, &d->tracker);
 }
@@ -3832,12 +4051,13 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 		return ret;
 	}
 	d->pf = pf;
-	if (cgu) {
+	if (cgu || pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
 		const struct dpll_device_ops *ops = &ice_dpll_ops;
 
 		if (type == DPLL_TYPE_PPS && ice_dpll_is_pps_phase_monitor(pf))
 			ops =  &ice_dpll_pom_ops;
-		ice_dpll_update_state(pf, d, true);
+		if (cgu)
+			ice_dpll_update_state(pf, d, true);
 		ret = dpll_device_register(d->dpll, type, ops, d);
 		if (ret) {
 			dpll_device_put(d->dpll, &d->tracker);
@@ -4203,6 +4423,36 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 	return 0;
 }
 
+/**
+ * ice_dpll_init_info_txclk_pins_e825c - initializes tx-clk pins information
+ * @pf: board private structure
+ *
+ * Init information for tx-clks pin, cache them in pf->dplls.txclks
+ *
+ * Return:
+ * * 0 - success
+ */
+static int ice_dpll_init_info_txclk_pins_e825c(struct ice_pf *pf)
+{
+	struct ice_dpll_pin *tx_pin;
+
+	for (int i = 0; i < ICE_DPLL_TXCLK_NUM_MAX; i++) {
+		tx_pin = &pf->dplls.txclks[i];
+		tx_pin->prop.type = DPLL_PIN_TYPE_EXT;
+		tx_pin->prop.capabilities |=
+				 DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+		tx_pin->pf = pf;
+		if (i == E825_EXT_EREF_PIN_IDX) {
+			tx_pin->prop.board_label = ice_dpll_ext_eref_pin;
+			tx_pin->tx_ref_src = ICE_REF_CLK_EREF0;
+		} else if (i == E825_EXT_SYNCE_PIN_IDX) {
+			tx_pin->tx_ref_src = ICE_REF_CLK_SYNCE;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_dpll_init_pins_info - init pins info wrapper
  * @pf: board private structure
@@ -4228,6 +4478,9 @@ ice_dpll_init_pins_info(struct ice_pf *pf, enum ice_dpll_pin_type pin_type)
 			return ice_dpll_init_info_rclk_pin(pf);
 	case ICE_DPLL_PIN_TYPE_SOFTWARE:
 		return ice_dpll_init_info_sw_pins(pf);
+
+	case ICE_DPLL_PIN_TYPE_TXCLK:
+		return ice_dpll_init_info_txclk_pins_e825c(pf);
 	default:
 		return -EINVAL;
 	}
@@ -4261,11 +4514,15 @@ static void ice_dpll_deinit_info(struct ice_pf *pf)
 static int ice_dpll_init_info_e825c(struct ice_pf *pf)
 {
 	struct ice_dplls *d = &pf->dplls;
+	struct ice_dpll *dt = &d->txc;
 	int ret = 0;
 	int i;
 
 	d->clock_id = ice_generate_clock_id(pf);
 	d->num_inputs = ICE_SYNCE_CLK_NUM;
+	dt->dpll_state = DPLL_LOCK_STATUS_UNLOCKED;
+	dt->mode = DPLL_MODE_MANUAL;
+	dt->dpll_idx = pf->ptp.port.port_num;
 
 	d->inputs = kzalloc_objs(*d->inputs, d->num_inputs);
 	if (!d->inputs)
@@ -4282,6 +4539,11 @@ static int ice_dpll_init_info_e825c(struct ice_pf *pf)
 	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_RCLK_INPUT);
 	if (ret)
 		goto deinit_info;
+
+	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_TXCLK);
+	if (ret)
+		goto deinit_info;
+
 	dev_dbg(ice_pf_to_dev(pf),
 		"%s - success, inputs: %u, outputs: %u, rclk-parents: %u\n",
 		 __func__, d->num_inputs, d->num_outputs, d->rclk.num_parents);
@@ -4414,6 +4676,9 @@ void ice_dpll_deinit(struct ice_pf *pf)
 		ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
 	if (!IS_ERR_OR_NULL(pf->dplls.eec.dpll))
 		ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
+	if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll))
+		ice_dpll_deinit_dpll(pf, &pf->dplls.txc, false);
+
 	ice_dpll_deinit_info(pf);
 	mutex_destroy(&pf->dplls.lock);
 }
@@ -4439,14 +4704,19 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
 	err = ice_dpll_init_info_e825c(pf);
 	if (err)
 		goto err_exit;
-	err = ice_dpll_init_pins_e825(pf);
+	err = ice_dpll_init_dpll(pf, &pf->dplls.txc, false, DPLL_TYPE_GENERIC);
 	if (err)
 		goto deinit_info;
+	err = ice_dpll_init_pins_e825(pf);
+	if (err)
+		goto deinit_txclk;
 	set_bit(ICE_FLAG_DPLL, pf->flags);
 	complete_all(&d->dpll_init);
 
 	return;
 
+deinit_txclk:
+	ice_dpll_deinit_dpll(pf, &pf->dplls.txc, false);
 deinit_info:
 	ice_dpll_deinit_info(pf);
 err_exit:
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index ae42cdea0ee1..23f9d4da73c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -7,6 +7,7 @@
 #include "ice.h"
 
 #define ICE_DPLL_RCLK_NUM_MAX	4
+#define ICE_DPLL_TXCLK_NUM_MAX	2
 
 /**
  * enum ice_dpll_pin_sw - enumerate ice software pin indices:
@@ -63,6 +64,7 @@ struct ice_dpll_pin {
 	u8 ref_sync;
 	bool active;
 	bool hidden;
+	enum ice_e825c_ref_clk tx_ref_src;
 };
 
 /** ice_dpll - store info required for DPLL control
@@ -111,9 +113,11 @@ struct ice_dpll {
  * @lock: locks access to configuration of a dpll
  * @eec: pointer to EEC dpll dev
  * @pps: pointer to PPS dpll dev
+ * @txc: pointer to TXC dpll dev
  * @inputs: input pins pointer
  * @outputs: output pins pointer
  * @rclk: recovered pins pointer
+ * @txclks: TX clock reference pins pointer
  * @num_inputs: number of input pins available on dpll
  * @num_outputs: number of output pins available on dpll
  * @cgu_state_acq_err_num: number of errors returned during periodic work
@@ -131,11 +135,13 @@ struct ice_dplls {
 	struct completion dpll_init;
 	struct ice_dpll eec;
 	struct ice_dpll pps;
+	struct ice_dpll txc;
 	struct ice_dpll_pin *inputs;
 	struct ice_dpll_pin *outputs;
 	struct ice_dpll_pin sma[ICE_DPLL_PIN_SW_NUM];
 	struct ice_dpll_pin ufl[ICE_DPLL_PIN_SW_NUM];
 	struct ice_dpll_pin rclk;
+	struct ice_dpll_pin txclks[ICE_DPLL_TXCLK_NUM_MAX];
 	u8 num_inputs;
 	u8 num_outputs;
 	u8 sma_data;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 1c9e77dbc770..10795d023f44 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -265,6 +265,13 @@ struct ice_cgu_pin_desc {
 	struct dpll_pin_frequency *freq_supp;
 };
 
+enum ice_e825c_ref_clk {
+	ICE_REF_CLK_ENET,
+	ICE_REF_CLK_SYNCE,
+	ICE_REF_CLK_EREF0,
+	ICE_REF_CLK_MAX,
+};
+
 #define E810C_QSFP_C827_0_HANDLE 2
 #define E810C_QSFP_C827_1_HANDLE 3
 
-- 
2.39.3


