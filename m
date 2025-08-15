Return-Path: <netdev+bounces-213985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E1B2793C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420B3628740
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 06:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E4B2C0F7F;
	Fri, 15 Aug 2025 06:35:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522A2BEC2B
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755239740; cv=none; b=lpMn4i//We2SkU8vwzPNVK9cB2QDNZ2nBP54Z9UJ3JOMX+3Jc9peeyHBPxIJgAs5rWLpofzk/1JFDa3d1RzyuBx7HVtjWLLPlCr3UYEoxMEK2Y1+bYVhSSdxEwsbRkoEMcco6CHoxthF/PP29iV9ZnePNmpVhYn+VDCm0X1Ud9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755239740; c=relaxed/simple;
	bh=QsPwgBuURGKP0jDlOdKgZSdtXUH9A/U65DgGWsnOPwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmNNp3ZlJpv5FnIhX0QOnBPYndaQpHUXiYG366znaxJRq0Nw+abLh9iTEz7Cr+6JF5dUNyIjoGlA6lcRAJm1QR8uGXPA4rN/VU8R2lrnXEH/ng9WgWziKo1y6QsNlC6jHadJU3hdBDF3wZFPH6sDbZKNmEsTlpR/Zr5QftQ9Hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1umo1z-0000hl-T3; Fri, 15 Aug 2025 08:35:15 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umo1u-000NPf-0i;
	Fri, 15 Aug 2025 08:35:10 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umo1u-0037VL-0Q;
	Fri, 15 Aug 2025 08:35:10 +0200
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
Subject: [PATCH net-next v2 1/5] ethtool: introduce core UAPI and driver API for PHY MSE diagnostics
Date: Fri, 15 Aug 2025 08:35:05 +0200
Message-Id: <20250815063509.743796-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250815063509.743796-1-o.rempel@pengutronix.de>
References: <20250815063509.743796-1-o.rempel@pengutronix.de>
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

All investigated devices differ in MSE configuration parameters, such
as sample rate, number of analyzed symbols, and scaling factors.
For example, the KSZ9131 uses different scaling for MSE and pMSE.
To make this visible to userspace, scale limits and timing information
are returned via get_mse_config().

Some PHYs sample very few symbols at high frequency (e.g. 2 µs update
rate). To cover such cases and allow for future high-speed PHYs with
even shorter intervals, the refresh rate is reported as u64 in
picoseconds.

This patch defines new UAPI enums for MSE capability flags and channel
selectors in ethtool_netlink (generated from YAML), kernel-side
`struct phy_mse_config` and `struct phy_mse_snapshot`, and new
phy_driver ops:

  - get_mse_config(): report supported capabilities, scaling, and
    sampling parameters for the current link mode
  - get_mse_snapshot(): retrieve a correlated set of MSE values from
    the latest measurement window

These definitions form the core API; no driver implements them yet.

[1] <https://opensig.org/wp-content/uploads/2024/01/
     Advanced_PHY_features_for_automotive_Ethernet_V1.0.pdf>

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/netlink/specs/ethtool.yaml      |  78 +++++++++++
 include/linux/phy.h                           | 126 ++++++++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  54 ++++++++
 3 files changed, 258 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 7a7594713f1f..6bffac0904f1 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -211,6 +211,84 @@ definitions:
         name: discard
         value: 31
 
+  -
+    name: phy-mse-capability
+    doc: |
+      Bitmask flags for MSE capabilities.
+
+      These flags are used in the 'supported_caps' field of struct
+      phy_mse_config to indicate which measurement capabilities are supported
+      by the PHY hardware.
+    type: flags
+    name-prefix: phy-mse-cap-
+    entries:
+      -
+        name: avg
+        doc: Average MSE value is supported.
+      -
+        name: peak
+        doc: Current peak MSE value is supported.
+      -
+        name: worst-peak
+        doc: Worst-case peak MSE (latched high-water mark) is supported.
+      -
+        name: channel-a
+        doc: Diagnostics for Channel A are supported.
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
+        value: 0
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
+        name: link
+        doc: |
+          Request data for the link as a whole. Use when the PHY exposes only
+          a link-wide aggregate MSE or cannot attribute results to any single
+          channel/pair (e.g. 100BASE-TX with unknown MDI/MDI-X mapping).
+      -
+        name: worst
+        doc: |
+          Request data for the single worst-performing channel. This is a
+          convenience for PHYs or drivers that can identify the worst channel
+          in hardware.
+
 attribute-sets:
   -
     name: header
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4c2b8b6e7187..469268b07b7b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -893,6 +893,78 @@ struct phy_led {
 
 #define to_phy_led(d) container_of(d, struct phy_led, led_cdev)
 
+/**
+ * struct phy_mse_config - Configuration for MSE measurement (current link mode)
+ *
+ * These properties apply to the current link mode and may change when link
+ * settings change. Callers should re-query after any link state change.
+ *
+ * Scaling:
+ *  - max_average_mse and max_peak_mse define the scale for corresponding
+ *    snapshot values. Users may normalize by dividing snapshot by the
+ *    respective max_* value to obtain a 0..1 ratio. Drivers must ensure
+ *    snapshot values do not exceed the corresponding max_*.
+ *  - If PHY_MSE_CAP_AVG is set, max_average_mse MUST be > 0.
+ *  - If PHY_MSE_CAP_PEAK or PHY_MSE_CAP_WORST_PEAK is set,
+ *    max_peak_mse MUST be > 0.
+ *
+ * Timing:
+ *  - refresh_rate_ps is the typical interval (picoseconds) between hardware
+ *    updates. Implementations may return older snapshots; do not assume
+ *    synchronous sampling.
+ *  - num_symbols is the number of symbols aggregated per hardware sample.
+ *
+ * Link-wide mode:
+ *  - Some PHYs only expose a link-wide aggregate MSE, or cannot map their
+ *    measurement to a specific channel/pair (e.g. 100BASE-TX when MDI/MDI-X
+ *    resolution is unknown). In that case, callers must use the LINK selector.
+ *
+ * Capabilities:
+ *  - supported_caps is a bitmask composed of PHY_MSE_CAP_* values from the
+ *    UAPI header. Channel-related capability bits indicate which channel
+ *    identifiers are valid.
+ *  - Callers should select only those channels/selectors that are indicated
+ *    as supported by supported_caps.
+ *
+ * If supported_caps is 0 the device provides no MSE diagnostics and drivers
+ * should typically return -EOPNOTSUPP from the ops.
+ */
+struct phy_mse_config {
+	u32 max_average_mse;
+	u32 max_peak_mse;
+	u64 refresh_rate_ps;
+	u64 num_symbols;
+	u32 supported_caps;
+};
+
+/**
+ * struct phy_mse_snapshot - Snapshot of MSE diagnostic values
+ *
+ * All fields refer to the same measurement window.
+ *
+ * Semantics:
+ *  - peak_mse is the current peak within the window.
+ *  - worst_peak_mse is a latched high-water mark since the last successful
+ *    read and MUST be cleared by the driver or hardware on read
+ *    (read-to-clear).
+ *
+ * Channel:
+ *  - 'channel' holds an integer identifier compatible with the UAPI
+ *    ethtool_phy_mse_channel enum. Callers must validate the requested
+ *    channel against supported_caps returned by get_mse_config() and must
+ *    use LINK when only link-wide is supported.
+ *  - Values must be one of the PHY_MSE_CHANNEL_* constants.
+ *  - Drivers must not coerce the requested selector (e.g. must not switch
+ *    a per-channel request to LINK). If an unsupported selector is requested,
+ *    return -EOPNOTSUPP.
+ */
+struct phy_mse_snapshot {
+	u32 channel;
+	u32 average_mse;
+	u32 peak_mse;
+	u32 worst_peak_mse;
+};
+
 /**
  * struct phy_driver - Driver structure for a particular PHY type
  *
@@ -1174,6 +1246,60 @@ struct phy_driver {
 	/** @get_sqi_max: Get the maximum signal quality indication */
 	int (*get_sqi_max)(struct phy_device *dev);
 
+	/**
+	 * get_mse_config - Get configuration and scale of MSE measurement
+	 * @dev:    PHY device
+	 * @config: Output (filled on success)
+	 *
+	 * Fill @config with the PHY's MSE configuration for the current
+	 * link mode: scale limits (max_average_mse, max_peak_mse), update
+	 * interval (refresh_rate_ps), sample length (num_symbols) and the
+	 * capability bitmask (supported_caps).
+	 *
+	 * Implementations may defer configuration until hardware has
+	 * converged; in that case they should return -EAGAIN and allow the
+	 * caller to retry later.
+	 *
+	 * Return:
+	 *  * 0              - success, @config is valid
+	 *  * -EOPNOTSUPP    - MSE configuration not implemented by the PHY
+	 *		       or not supported in the current link mode
+	 *  * -ENETDOWN      - link is down and configuration is not
+	 *		       available in that state
+	 *  * -EAGAIN        - configuration not yet established; retry later
+	 *  * <other>        - other negative errno on failure
+	 */
+	int (*get_mse_config)(struct phy_device *dev,
+			      struct phy_mse_config *config);
+
+	/**
+	 * get_mse_snapshot - Retrieve a snapshot of MSE diagnostic values
+	 * @dev:      PHY device
+	 * @channel:  Channel identifier (PHY_MSE_CHANNEL_*)
+	 * @snapshot: Output (filled on success)
+	 *
+	 * Fill @snapshot with a correlated set of MSE values from the most
+	 * recent measurement window.
+	 *
+	 * Callers must validate @channel against supported_caps returned by
+	 * get_mse_config(). Drivers must not coerce @channel; if the requested
+	 * selector is not implemented by the device or current link mode,
+	 * the operation must fail.
+	 *
+	 * On success, @snapshot->channel MUST equal the requested @channel.
+	 * worst_peak_mse is latched and must be treated as read-to-clear.
+	 *
+	 * Return:
+	 *  * 0           - success, @snapshot is valid
+	 *  * -EOPNOTSUPP - selector not implemented by device or link mode
+	 *  * -ENETDOWN   - link is down and data is not available in that state
+	 *  * -EAGAIN     - data not yet available (e.g. first sampling
+	 *		    incomplete)
+	 *  * <other>     - other negative errno on failure
+	 */
+	int (*get_mse_snapshot)(struct phy_device *dev, u32 channel,
+				struct phy_mse_snapshot *snapshot);
+
 	/* PLCA RS interface */
 	/** @get_plca_cfg: Return the current PLCA configuration */
 	int (*get_plca_cfg)(struct phy_device *dev,
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index e3b8813465d7..71d0ded01a3a 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -77,6 +77,60 @@ enum ethtool_pse_event {
 	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
 };
 
+/**
+ * enum ethtool_phy_mse_capability - Bitmask flags for MSE capabilities. These
+ *   flags are used in the 'supported_caps' field of struct phy_mse_config to
+ *   indicate which measurement capabilities are supported by the PHY hardware.
+ * @PHY_MSE_CAP_AVG: Average MSE value is supported.
+ * @PHY_MSE_CAP_PEAK: Current peak MSE value is supported.
+ * @PHY_MSE_CAP_WORST_PEAK: Worst-case peak MSE (latched high-water mark) is
+ *   supported.
+ * @PHY_MSE_CAP_CHANNEL_A: Diagnostics for Channel A are supported.
+ * @PHY_MSE_CAP_CHANNEL_B: Diagnostics for Channel B are supported.
+ * @PHY_MSE_CAP_CHANNEL_C: Diagnostics for Channel C are supported.
+ * @PHY_MSE_CAP_CHANNEL_D: Diagnostics for Channel D are supported.
+ * @PHY_MSE_CAP_WORST_CHANNEL: Hardware or drivers can identify the single
+ *   worst-performing channel without needing to query each one individually.
+ * @PHY_MSE_CAP_LINK: Hardware provides only a link-wide aggregate MSE or
+ *   cannot map the measurement to a specific channel/pair. Typical for media
+ *   where the MDI/MDI-X resolution or pair mapping is unknown (e.g.
+ *   100BASE-TX).
+ */
+enum ethtool_phy_mse_capability {
+	PHY_MSE_CAP_AVG = 1,
+	PHY_MSE_CAP_PEAK = 2,
+	PHY_MSE_CAP_WORST_PEAK = 4,
+	PHY_MSE_CAP_CHANNEL_A = 8,
+	PHY_MSE_CAP_CHANNEL_B = 16,
+	PHY_MSE_CAP_CHANNEL_C = 32,
+	PHY_MSE_CAP_CHANNEL_D = 64,
+	PHY_MSE_CAP_WORST_CHANNEL = 128,
+	PHY_MSE_CAP_LINK = 256,
+};
+
+/**
+ * enum ethtool_phy_mse_channel - Identifiers for the 'channel' parameter used
+ *   to select which diagnostic data to retrieve.
+ * @PHY_MSE_CHANNEL_A: Request data for channel A.
+ * @PHY_MSE_CHANNEL_B: Request data for channel B.
+ * @PHY_MSE_CHANNEL_C: Request data for channel C.
+ * @PHY_MSE_CHANNEL_D: Request data for channel D.
+ * @PHY_MSE_CHANNEL_LINK: Request data for the link as a whole. Use when the
+ *   PHY exposes only a link-wide aggregate MSE or cannot attribute results to
+ *   any single channel/pair (e.g. 100BASE-TX with unknown MDI/MDI-X mapping).
+ * @PHY_MSE_CHANNEL_WORST: Request data for the single worst-performing
+ *   channel. This is a convenience for PHYs or drivers that can identify the
+ *   worst channel in hardware.
+ */
+enum ethtool_phy_mse_channel {
+	PHY_MSE_CHANNEL_A,
+	PHY_MSE_CHANNEL_B,
+	PHY_MSE_CHANNEL_C,
+	PHY_MSE_CHANNEL_D,
+	PHY_MSE_CHANNEL_LINK,
+	PHY_MSE_CHANNEL_WORST,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
-- 
2.39.5


