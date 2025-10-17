Return-Path: <netdev+bounces-230438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D1DBE81FA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1A36E217C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A3320A3B;
	Fri, 17 Oct 2025 10:48:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1E31AF14
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698086; cv=none; b=iyzl4d4PrYqHOlQf6jef/hf+KFaoiiXioDROHEPrEeJi0ATG58hlbgwCDEOwnJs8bSqrMyo1Y7K9MZUeDo47P59DUK2bFIuxp48Wbtv2OCXrVf/PQDUb3H/wSpWauko2YbhqoXrT2MX1naQmfpbhb4b7DR00tlVxOmlZJdcvzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698086; c=relaxed/simple;
	bh=vLnTwhxsdcK6qwzisfFZf3gvXrMNgoJwm4rJ/Aptv70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCyJ6cwDrAlFk4//Oh9Z2uakgMj0muaf6ztglEnYnIEb61kE1LT4I/Q/k0RR5EhzcZHe1MxnfAkVSdMHypgTIxb+JhZ55EgCYMbhOV3p+QCamliBwytjmcw2wAp/4+GeLbtxio6ZmJDgDK/bBy1ChRjJZmpEITBt9Bt1Prq04RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzn-0000AH-1j; Fri, 17 Oct 2025 12:47:39 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzl-0042n4-0e;
	Fri, 17 Oct 2025 12:47:37 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzl-0000000F0AJ-0Ki2;
	Fri, 17 Oct 2025 12:47:37 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>,
	Roan van Dijk <roan@protonic.nl>
Subject: [PATCH net-next v6 1/5] ethtool: introduce core UAPI and driver API for PHY MSE diagnostics
Date: Fri, 17 Oct 2025 12:47:28 +0200
Message-ID: <20251017104732.3575484-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017104732.3575484-1-o.rempel@pengutronix.de>
References: <20251017104732.3575484-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add the base infrastructure for Mean Square Error (MSE) diagnostics,
as proposed by the OPEN Alliance "Advanced diagnostic features for
100BASE-T1 automotive Ethernet PHYs" [1] specification.

The OPEN Alliance spec defines only average MSE and average peak MSE
over a fixed number of symbols. However, other PHYs, such as the
KSZ9131, additionally expose a worst-peak MSE value latched since the
last channel capture. This API accounts for such vendor extensions by
adding a distinct capability bit and snapshot field.

Channel-to-pair mapping is normally straightforward, but in some cases
(e.g. 100BASE-TX with MDI-X resolution unknown) the mapping is ambiguous.
If hardware does not expose MDI-X status, the exact pair cannot be
determined. To avoid returning misleading per-channel data in this case,
a LINK selector is defined for aggregate MSE measurements.

All investigated devices differ in MSE capabilities, such
as sample rate, number of analyzed symbols, and scaling factors.
For example, the KSZ9131 uses different scaling for MSE and pMSE.
To make this visible to userspace, scale limits and timing information
are returned via get_mse_capability().

Some PHYs sample very few symbols at high frequency (e.g. 2 us update
rate). To cover such cases and allow for future high-speed PHYs with
even shorter intervals, the refresh rate is reported as u64 in
picoseconds.

This patch defines new UAPI enums for MSE capability flags and channel
selectors in ethtool_netlink (generated from YAML), kernel-side
`struct phy_mse_capability` and `struct phy_mse_snapshot`, and new
phy_driver ops:

  - get_mse_capability(): report supported capabilities, scaling, and
    sampling parameters for the current link mode
  - get_mse_snapshot(): retrieve a correlated set of MSE values from
    the latest measurement window

These definitions form the core API; no driver implements them yet.

Standardization notes:
OPEN Alliance defines presence and interpretation of some metrics but does
not fix numeric scales or sampling internals:

- SQI (3-bit, 0..7) is mandatory; correlation to SNR/BER is informative
  (OA 100BASE-T1 v1.0 6.1.2; OA 1000BASE-T1 v2.2 6.1.2).
- MSE is optional; OA recommends 2^16 symbols and scaling to 0..511,
  with a worst-case latch since last read (OA 100BASE-T1 v1.0 6.1.1; OA
  1000BASE-T1 v2.2 6.1.1). Refresh is recommended (~0.8-2.0 ms for
  100BASE-T1; ~80-200 us for 1000BASE-T1). Exact scaling/time windows
  are vendor-specific.
- Peak MSE (pMSE) is defined only for 100BASE-T1 as optional, e.g.
  128-symbol sliding window with 8-bit range and worst-case latch (OA
  100BASE-T1 v1.0 6.1.3).

Therefore this UAPI exposes which measures and selectors a PHY supports,
and documents where behavior is standard-referenced vs vendor-specific.

[1] <https://opensig.org/wp-content/uploads/2024/01/
     Advanced_PHY_features_for_automotive_Ethernet_V1.0.pdf>

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- YAML: generate mask for phy-mse-cap-
- YAML: Reorder phy-mse-capability flags to list channels first, then measures
- YAML: Drop explicit value: 0 on phy-mse-channel’s first enumerator
- YAML: Expand/clarify docs: add a short Standardization block
- UAPI: regenerate ethtool_netlink_generated.h with the new flag ordering
- phy.h: Remove channel field from struct phy_mse_snapshot
- phy.h: Use u64 for all snapshot/capability scalar fields (average_mse,
  peak_mse, worst_peak_mse, max_*, refresh_rate_ps, num_symbols) for
  range/consistency with netlink.
- phy.h: Update kerneldoc: note values are raw, device-scaled; point to
  phy_mse_capability for interpretation; add brief OA references;
changes v5:
- clarify @channel direction in struct phy_mse_snapshot
- add per-field spec references for snapshot values
- refine YAML docstrings for phy-mse-channel and link selector
- update standardization notes (OA v1.0 and v2.2)
changes v4:
- remove -ENETDOWN as expected error value for get_mse_capability() and
  get_mse_snapshot()
- fix htmldocs builds
---
 Documentation/netlink/specs/ethtool.yaml      |  91 +++++++++++++
 include/linux/phy.h                           | 127 ++++++++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  69 ++++++++++
 3 files changed, 287 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6a0fb1974513..4c352f36d57d 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -211,6 +211,97 @@ definitions:
         name: discard
         value: 31
 
+  -
+    name: phy-mse-capability
+    doc: |
+      Bitmask flags for MSE capabilities.
+      Standardization:
+      - SQI/MSE/pMSE presence is defined by OPEN Alliance, but numeric scaling,
+        update intervals and aggregation windows are vendor-/product-specific.
+        See OA 100BASE-T1 v1.0 6.1.1-6.1.3 and OA 1000BASE-T1 v2.2 6.1.1-6.1.2.
+        (References are informative; drivers must not assume identical scales.)
+
+      These flags are used in the 'supported_caps' field of struct
+      phy_mse_capability to indicate which measurement capabilities are
+      supported by the PHY hardware.
+    type: flags
+    name-prefix: phy-mse-cap-
+    render-max: true
+    entries:
+      -
+        name: channel-a
+        doc: Diagnostics for Channel A are supported. (API selector; mapping to
+          physical pair may depend on MDI/MDI-X status.)
+      -
+        name: channel-b
+        doc: Diagnostics for Channel B are supported.
+      -
+        name: channel-c
+        doc: Diagnostics for Channel C are supported.
+      -
+        name: channel-d
+        doc: Diagnostics for Channel D are supported.
+      -
+        name: worst-channel
+        doc: |
+          Hardware or drivers can identify the single worst-performing channel
+          without needing to query each one individually.
+      -
+        name: link
+        doc: |
+          Hardware provides only a link-wide aggregate MSE or cannot map
+          the measurement to a specific channel/pair. Typical for media where
+          the MDI/MDI-X resolution or pair mapping is unknown (e.g. 100BASE-TX).
+      -
+        name: avg
+        doc: Average MSE supported (OA-referenced metric; scaling/window are
+          vendor-specific). For 100/1000BASE-T1 recommended 2^16 symbols, scaled
+          0..511; device-specific otherwise. (OA 100BASE-T1 6.1.1;
+          OA 1000BASE-T1 6.1.1)
+      -
+        name: peak
+        doc: Peak MSE supported (current peak over the last measurement window).
+          Defined as pMSE only for 100BASE-T1 in OA; other variants are vendor
+          extensions. (OA 100BASE-T1 6.1.3)
+      -
+        name: worst-peak
+        doc: Latched worst-case peak since last read (read-to-clear if
+          implemented). Optional in OA for 100BASE-T1 pMSE.
+          (OA 100BASE-T1 6.1.3)
+
+  -
+    name: phy-mse-channel
+    doc: |
+      Identifiers for the 'channel' parameter used to select which diagnostic
+      data to retrieve.
+    type: enum
+    name-prefix: phy-mse-channel-
+    entries:
+      -
+        name: a
+        doc: Request data for channel A.
+      -
+        name: b
+        doc: Request data for channel B.
+      -
+        name: c
+        doc: Request data for channel C.
+      -
+        name: d
+        doc: Request data for channel D.
+      -
+        name: worst
+        doc: |
+          Request data for the single worst-performing channel. This is a
+          convenience for PHYs or drivers that can identify the worst channel
+          in hardware.
+      -
+        name: link
+        doc: |
+          Request data for the link as a whole. Use when the PHY exposes only
+          a link-wide aggregate MSE or cannot attribute results to any single
+          channel/pair (e.g. 100BASE-TX with unknown MDI/MDI-X mapping).
+
 attribute-sets:
   -
     name: header
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3c7634482356..fe3ad28b3614 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -903,6 +903,87 @@ struct phy_led {
 
 #define to_phy_led(d) container_of(d, struct phy_led, led_cdev)
 
+/**
+ * struct phy_mse_capability - Capabilities of Mean Square Error (MSE)
+ *                             measurement interface
+ *
+ * Standardization notes:
+ * - Presence of MSE/SQI/pMSE is defined by OPEN Alliance specs, but numeric
+ *   scaling, refresh/update rate and aggregation windows are not fixed and
+ *   are vendor-/product-specific. (OA 100BASE-T1 v1.0 6.1.*;
+ *   OA 1000BASE-T1 v2.2 6.1.*)
+ * - Typical recommendations: 2^16 symbols and 0..511 scaling for MSE; pMSE only
+ *   defined for 100BASE-T1 (sliding window example), others are vendor
+ *   extensions. Drivers must report actual scale/limits here.
+ *
+ * Describes the MSE measurement capabilities for the current link mode. These
+ * properties are dynamic and may change when link settings are modified.
+ * Callers should re-query this capability after any link state change to
+ * ensure they have the most up-to-date information.
+ *
+ * Callers should only request measurements for channels and types that are
+ * indicated as supported by the @supported_caps bitmask. If @supported_caps
+ * is 0, the device provides no MSE diagnostics, and driver operations should
+ * typically return -EOPNOTSUPP.
+ *
+ * Snapshot values for average and peak MSE can be normalized to a 0..1 ratio
+ * by dividing the raw snapshot by the corresponding @max_average_mse or
+ * @max_peak_mse value.
+ *
+ * @max_average_mse: The maximum value for an average MSE snapshot. This
+ *   defines the scale for the measurement. If the PHY_MSE_CAP_AVG capability is
+ *   supported, this value MUST be greater than 0. (vendor-specific units).
+ * @max_peak_mse: The maximum value for a peak MSE snapshot. If either
+ *   PHY_MSE_CAP_PEAK or PHY_MSE_CAP_WORST_PEAK is supported, this value MUST
+ *   be greater than 0. (vendor-specific units).
+ * @refresh_rate_ps: The typical interval, in picoseconds, between hardware
+ *   updates of the MSE values. This is an estimate, and callers should not
+ *   assume synchronous sampling. (vendor-specific units).
+ * @num_symbols: The number of symbols aggregated per hardware sample to
+ *   calculate the MSE. (vendor-specific units).
+ * @supported_caps: A bitmask of PHY_MSE_CAP_* values indicating which
+ *   measurement types (e.g., average, peak) and channels
+ *   (e.g., per-pair or link-wide) are supported.
+ */
+struct phy_mse_capability {
+	u64 max_average_mse;
+	u64 max_peak_mse;
+	u64 refresh_rate_ps;
+	u64 num_symbols;
+	u32 supported_caps;
+};
+
+/**
+ * struct phy_mse_snapshot - A snapshot of Mean Square Error (MSE) diagnostics
+ *
+ * Holds a set of MSE diagnostic values that were all captured from a single
+ * measurement window.
+ *
+ * Values are raw, device-scaled and not normalized. Use struct
+ * phy_mse_capability to interpret the scale and sampling window.
+ *
+ * @average_mse: The average MSE value over the measurement window.
+ *   OPEN Alliance references MSE as a DCQ metric; recommends 2^16 symbols and
+ *   0..511 scaling. Exact scale and refresh are vendor-specific.
+ *   (100BASE-T1 v1.0 6.1.1; 1000BASE-T1 v2.2 6.1.1).
+ *
+ * @peak_mse: The peak MSE value observed within the measurement window.
+ *   For 100BASE-T1, "pMSE" is optional and may be implemented via a sliding
+ *   128-symbol window with periodic capture; not standardized for 1000BASE-T1.
+ *   (100BASE-T1 v1.0 6.1.3, Table "DCQ.peakMSE").
+ *
+ * @worst_peak_mse: A latched high-water mark of the peak MSE since last read
+ *   (read-to-clear if implemented). OPEN Alliance shows a latched "worst case
+ *   peak MSE" for 100BASE-T1 pMSE; availability/semantics outside that are
+ *   vendor-specific. (100BASE-T1 v1.0 6.1.3, DCQ.peakMSE high byte; 1000BASE-T1
+ *   treats DCQ details as vendor-specific.)
+ */
+struct phy_mse_snapshot {
+	u64 average_mse;
+	u64 peak_mse;
+	u64 worst_peak_mse;
+};
+
 /**
  * struct phy_driver - Driver structure for a particular PHY type
  *
@@ -1184,6 +1265,52 @@ struct phy_driver {
 	/** @get_sqi_max: Get the maximum signal quality indication */
 	int (*get_sqi_max)(struct phy_device *dev);
 
+	/**
+	 * @get_mse_capability: Get capabilities and scale of MSE measurement
+	 * @dev:    PHY device
+	 * @cap: Output (filled on success)
+	 *
+	 * Fill @cap with the PHY's MSE capability for the current
+	 * link mode: scale limits (max_average_mse, max_peak_mse), update
+	 * interval (refresh_rate_ps), sample length (num_symbols) and the
+	 * capability bitmask (supported_caps).
+	 *
+	 * Implementations may defer capability report until hardware has
+	 * converged; in that case they should return -EAGAIN and allow the
+	 * caller to retry later.
+	 *
+	 * Return: 0 on success. On failure, returns a negative errno code, such
+	 * as -EOPNOTSUPP if MSE measurement is not supported by the PHY or in
+	 * the current link mode, or -EAGAIN if the capability information is
+	 * not yet available.
+	 */
+	int (*get_mse_capability)(struct phy_device *dev,
+				  struct phy_mse_capability *cap);
+
+	/**
+	 * @get_mse_snapshot: Retrieve a snapshot of MSE diagnostic values
+	 * @dev:      PHY device
+	 * @channel:  Channel identifier (PHY_MSE_CHANNEL_*)
+	 * @snapshot: Output (filled on success)
+	 *
+	 * Fill @snapshot with a correlated set of MSE values from the most
+	 * recent measurement window.
+	 *
+	 * Callers must validate @channel against supported_caps returned by
+	 * get_mse_capability(). Drivers must not coerce @channel; if the
+	 * requested selector is not implemented by the device or current link
+	 * mode, the operation must fail.
+	 *
+	 * worst_peak_mse is latched and must be treated as read-to-clear.
+	 *
+	 * Return: 0 on success. On failure, returns a negative errno code, such
+	 * as -EOPNOTSUPP if MSE measurement is not supported by the PHY or in
+	 * the current link mode, or -EAGAIN if measurements are not yet
+	 * available.
+	 */
+	int (*get_mse_snapshot)(struct phy_device *dev, u32 channel,
+				struct phy_mse_snapshot *snapshot);
+
 	/* PLCA RS interface */
 	/** @get_plca_cfg: Return the current PLCA configuration */
 	int (*get_plca_cfg)(struct phy_device *dev,
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 0e8ac0d974e2..03954c324ff8 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -77,6 +77,75 @@ enum ethtool_pse_event {
 	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
 };
 
+/**
+ * enum ethtool_phy_mse_capability - Bitmask flags for MSE capabilities.
+ *   Standardization: - SQI/MSE/pMSE presence is defined by OPEN Alliance, but
+ *   numeric scaling, update intervals and aggregation windows are
+ *   vendor-/product-specific. See OA 100BASE-T1 v1.0 6.1.1-6.1.3 and OA
+ *   1000BASE-T1 v2.2 6.1.1-6.1.2. (References are informative; drivers must
+ *   not assume identical scales.) These flags are used in the 'supported_caps'
+ *   field of struct phy_mse_capability to indicate which measurement
+ *   capabilities are supported by the PHY hardware.
+ * @PHY_MSE_CAP_CHANNEL_A: Diagnostics for Channel A are supported. (API
+ *   selector; mapping to physical pair may depend on MDI/MDI-X status.)
+ * @PHY_MSE_CAP_CHANNEL_B: Diagnostics for Channel B are supported.
+ * @PHY_MSE_CAP_CHANNEL_C: Diagnostics for Channel C are supported.
+ * @PHY_MSE_CAP_CHANNEL_D: Diagnostics for Channel D are supported.
+ * @PHY_MSE_CAP_WORST_CHANNEL: Hardware or drivers can identify the single
+ *   worst-performing channel without needing to query each one individually.
+ * @PHY_MSE_CAP_LINK: Hardware provides only a link-wide aggregate MSE or
+ *   cannot map the measurement to a specific channel/pair. Typical for media
+ *   where the MDI/MDI-X resolution or pair mapping is unknown (e.g.
+ *   100BASE-TX).
+ * @PHY_MSE_CAP_AVG: Average MSE supported (OA-referenced metric;
+ *   scaling/window are vendor-specific). For 100/1000BASE-T1 recommended 2^16
+ *   symbols, scaled 0..511; device-specific otherwise. (OA 100BASE-T1 6.1.1;
+ *   OA 1000BASE-T1 6.1.1)
+ * @PHY_MSE_CAP_PEAK: Peak MSE supported (current peak over the last
+ *   measurement window). Defined as pMSE only for 100BASE-T1 in OA; other
+ *   variants are vendor extensions. (OA 100BASE-T1 6.1.3)
+ * @PHY_MSE_CAP_WORST_PEAK: Latched worst-case peak since last read
+ *   (read-to-clear if implemented). Optional in OA for 100BASE-T1 pMSE. (OA
+ *   100BASE-T1 6.1.3)
+ */
+enum ethtool_phy_mse_capability {
+	PHY_MSE_CAP_CHANNEL_A = 1,
+	PHY_MSE_CAP_CHANNEL_B = 2,
+	PHY_MSE_CAP_CHANNEL_C = 4,
+	PHY_MSE_CAP_CHANNEL_D = 8,
+	PHY_MSE_CAP_WORST_CHANNEL = 16,
+	PHY_MSE_CAP_LINK = 32,
+	PHY_MSE_CAP_AVG = 64,
+	PHY_MSE_CAP_PEAK = 128,
+	PHY_MSE_CAP_WORST_PEAK = 256,
+
+	/* private: */
+	PHY_MSE_CAP_MASK = 511,
+};
+
+/**
+ * enum ethtool_phy_mse_channel - Identifiers for the 'channel' parameter used
+ *   to select which diagnostic data to retrieve.
+ * @PHY_MSE_CHANNEL_A: Request data for channel A.
+ * @PHY_MSE_CHANNEL_B: Request data for channel B.
+ * @PHY_MSE_CHANNEL_C: Request data for channel C.
+ * @PHY_MSE_CHANNEL_D: Request data for channel D.
+ * @PHY_MSE_CHANNEL_WORST: Request data for the single worst-performing
+ *   channel. This is a convenience for PHYs or drivers that can identify the
+ *   worst channel in hardware.
+ * @PHY_MSE_CHANNEL_LINK: Request data for the link as a whole. Use when the
+ *   PHY exposes only a link-wide aggregate MSE or cannot attribute results to
+ *   any single channel/pair (e.g. 100BASE-TX with unknown MDI/MDI-X mapping).
+ */
+enum ethtool_phy_mse_channel {
+	PHY_MSE_CHANNEL_A,
+	PHY_MSE_CHANNEL_B,
+	PHY_MSE_CHANNEL_C,
+	PHY_MSE_CHANNEL_D,
+	PHY_MSE_CHANNEL_WORST,
+	PHY_MSE_CHANNEL_LINK,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
-- 
2.47.3


