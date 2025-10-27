Return-Path: <netdev+bounces-233175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1DFC0D897
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82E5B4F833C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547EB30F7FE;
	Mon, 27 Oct 2025 12:28:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922FE30E0D4
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568117; cv=none; b=Zaxat5d2Fh/9IKWh5KkeREuNgr0obvUlMz2b3JYlTrGhpk0LGv7hDAqfK7oEcbIqD1kTNwl9vvPD5CEgmmlsdh34gLeff0Qxvv49rX0/WTwoimjGVM96PXzG0SJxILv25NtZkD5yMYIBNM8V8Rx+KTTNGHgv3D3p2Wg5CevJxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568117; c=relaxed/simple;
	bh=LByxTOoELAPaeXkiDHFsJ64fUBa1eC1LHtkTUMdAXKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q96MtyWtSVG0EzDylrOz6c+uajTQPkpSPDQFyM1mXc8/YxF6Aub+aKVXY7enGxaKnbLwrZ/AQyEya/q8mngVvoyceBF++3mDEpqzA43NMcHAl9kJKnsgMAEEonKR4E1n9+fIlVVdQW77ZUxfWjRv7kXl8PCdu4ZA3MmJh/UDaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMKX-0004fo-TA; Mon, 27 Oct 2025 13:28:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMKV-005hdv-1N;
	Mon, 27 Oct 2025 13:28:07 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMKV-000000047Zr-1LJP;
	Mon, 27 Oct 2025 13:28:07 +0100
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
Subject: [PATCH net-next v8 1/4] net: phy: introduce internal API for PHY MSE diagnostics
Date: Mon, 27 Oct 2025 13:27:58 +0100
Message-ID: <20251027122801.982364-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027122801.982364-1-o.rempel@pengutronix.de>
References: <20251027122801.982364-1-o.rempel@pengutronix.de>
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
To make this visible to callers, scale limits and timing information
are returned via get_mse_capability().

Some PHYs sample very few symbols at high frequency (e.g. 2 us update
rate). To cover such cases and allow for future high-speed PHYs with
even shorter intervals, the refresh rate is reported as u64 in
picoseconds.

This patch introduces the internal PHY API for Mean Square Error
diagnostics. It defines new kernel-side data types and driver hooks:

  - struct phy_mse_capability: describes supported metrics, scale
    limits, update interval, and sampling length.
  - struct phy_mse_snapshot: holds one correlated measurement set.
  - New phy_driver ops: `get_mse_capability()` and `get_mse_snapshot()`.

These definitions form the core kernel API. No user-visible interfaces
are added in this commit.

Standardization notes:
OPEN Alliance defines presence and interpretation of some metrics but does
not fix numeric scales or sampling internals:

- SQI (3-bit, 0..7) is mandatory; correlation to SNR/BER is informative
  (OA 100BASE-T1 TC1 v1.0 6.1.2; OA 1000BASE-T1 TC12 v2.2 6.1.2).
- MSE is optional; OA recommends 2^16 symbols and scaling to 0..511,
  with a worst-case latch since last read (OA 100BASE-T1 TC1 v1.0 6.1.1; OA
  1000BASE-T1 TC12 v2.2 6.1.1). Refresh is recommended (~0.8-2.0 ms for
  100BASE-T1; ~80-200 us for 1000BASE-T1). Exact scaling/time windows
  are vendor-specific.
- Peak MSE (pMSE) is defined only for 100BASE-T1 as optional, e.g.
  128-symbol sliding window with 8-bit range and worst-case latch (OA
  100BASE-T1 TC1 v1.0 6.1.3).

Therefore this API exposes which measures and selectors a PHY supports,
and documents where behavior is standard-referenced vs vendor-specific.

[1] <https://opensig.org/wp-content/uploads/2024/01/
     Advanced_PHY_features_for_automotive_Ethernet_V1.0.pdf>

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
changes v8:
- use enum phy_mse_channel for the
- Make this patch kernel-internal only: no UAPI in this patch; ethtool
  netlink exposure moved to patch 2.
- Drop user-space channel selector and capability flags from this patch;
  keep only internal API and docs.
- Update commit message; add OA Technical Committee numbers (TC1 / TC12).
- Change get_mse_snapshot() callback to use enum phy_mse_channel
  instead of u32
changes v7:
- add Reviewed-by
- fix "Unexpected indentation" error
- fix "Block quote ends without a blank line; unexpected unindent."
  warning.
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
 include/linux/phy.h | 206 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 17a2cdc9f1a0..0c9a2ef0ec75 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -903,6 +903,165 @@ struct phy_led {
 
 #define to_phy_led(d) container_of(d, struct phy_led, led_cdev)
 
+/*
+ * PHY_MSE_CAP_* - Bitmask flags for Mean Square Error (MSE) capabilities
+ *
+ * These flags describe which MSE metrics and selectors are implemented
+ * by the PHY for the current link mode. They are used in
+ * struct phy_mse_capability.supported_caps.
+ *
+ * Standardization:
+ *   The OPEN Alliance (OA) defines the presence of MSE/SQI/pMSE but not their
+ *   numeric scaling, update intervals, or aggregation windows.  See:
+ *     OA 100BASE-T1 TC1 v1.0, sections 6.1.1-6.1.3
+ *     OA 1000BASE-T1 TC12 v2.2, sections 6.1.1-6.1.2
+ *
+ * Description of flags:
+ *
+ *   PHY_MSE_CAP_CHANNEL_A
+ *     Per-pair diagnostics for Channel A are supported.  Mapping to the
+ *     physical wire pair may depend on MDI/MDI-X polarity.
+ *
+ *   PHY_MSE_CAP_CHANNEL_B, _C, _D
+ *     Same as above for channels B-D.
+ *
+ *   PHY_MSE_CAP_WORST_CHANNEL
+ *     The PHY or driver can identify and report the single worst-performing
+ *     channel without querying each one individually.
+ *
+ *   PHY_MSE_CAP_LINK
+ *     The PHY provides only a link-wide aggregate measurement or cannot map
+ *     results to a specific pair (for example 100BASE-TX with unknown
+ *     MDI/MDI-X).
+ *
+ *   PHY_MSE_CAP_AVG
+ *     Average MSE (mean DCQ metric) is supported.  For 100/1000BASE-T1 the OA
+ *     recommends 2^16 symbols, scaled 0..511, but the exact scaling is
+ *     vendor-specific.
+ *
+ *   PHY_MSE_CAP_PEAK
+ *     Peak MSE (current peak within the measurement window) is supported.
+ *     Defined as pMSE for 100BASE-T1; vendor-specific for others.
+ *
+ *   PHY_MSE_CAP_WORST_PEAK
+ *     Latched worst-case peak MSE since the last read (read-to-clear if
+ *     implemented).  Optional in OA 100BASE-T1 TC1 6.1.3.
+ */
+#define PHY_MSE_CAP_CHANNEL_A BIT(0)
+#define PHY_MSE_CAP_CHANNEL_B BIT(1)
+#define PHY_MSE_CAP_CHANNEL_C BIT(2)
+#define PHY_MSE_CAP_CHANNEL_D BIT(3)
+#define PHY_MSE_CAP_WORST_CHANNEL BIT(4)
+#define PHY_MSE_CAP_LINK BIT(5)
+#define PHY_MSE_CAP_AVG BIT(6)
+#define PHY_MSE_CAP_PEAK BIT(7)
+#define PHY_MSE_CAP_WORST_PEAK BIT(8)
+
+/*
+ * enum phy_mse_channel - Identifiers for selecting MSE measurement channels
+ *
+ * PHY_MSE_CHANNEL_A - PHY_MSE_CHANNEL_D
+ *   Select per-pair measurement for the corresponding channel.
+ *
+ * PHY_MSE_CHANNEL_WORST
+ *   Select the single worst-performing channel reported by hardware.
+ *
+ * PHY_MSE_CHANNEL_LINK
+ *   Select link-wide aggregate data (used when per-pair results are
+ *   unavailable).
+ */
+enum phy_mse_channel {
+	PHY_MSE_CHANNEL_A,
+	PHY_MSE_CHANNEL_B,
+	PHY_MSE_CHANNEL_C,
+	PHY_MSE_CHANNEL_D,
+	PHY_MSE_CHANNEL_WORST,
+	PHY_MSE_CHANNEL_LINK,
+};
+
+/**
+ * struct phy_mse_capability - Capabilities of Mean Square Error (MSE)
+ *                             measurement interface
+ *
+ * Standardization notes:
+ *
+ * - Presence of MSE/SQI/pMSE is defined by OPEN Alliance specs, but numeric
+ *   scaling, refresh/update rate and aggregation windows are not fixed and
+ *   are vendor-/product-specific. (OA 100BASE-T1 TC1 v1.0 6.1.*;
+ *   OA 1000BASE-T1 TC12 v2.2 6.1.*)
+ *
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
+ *   (100BASE-T1 TC1 v1.0 6.1.1; 1000BASE-T1 TC12 v2.2 6.1.1).
+ *
+ * @peak_mse: The peak MSE value observed within the measurement window.
+ *   For 100BASE-T1, "pMSE" is optional and may be implemented via a sliding
+ *   128-symbol window with periodic capture; not standardized for 1000BASE-T1.
+ *   (100BASE-T1 TC1 v1.0 6.1.3, Table "DCQ.peakMSE").
+ *
+ * @worst_peak_mse: A latched high-water mark of the peak MSE since last read
+ *   (read-to-clear if implemented). OPEN Alliance shows a latched "worst case
+ *   peak MSE" for 100BASE-T1 pMSE; availability/semantics outside that are
+ *   vendor-specific. (100BASE-T1 TC1 v1.0 6.1.3, DCQ.peakMSE high byte;
+ *   1000BASE-T1 TC12 v2.2 treats DCQ details as vendor-specific.)
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
@@ -1184,6 +1343,53 @@ struct phy_driver {
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
+	int (*get_mse_snapshot)(struct phy_device *dev,
+				enum phy_mse_channel channel,
+				struct phy_mse_snapshot *snapshot);
+
 	/* PLCA RS interface */
 	/** @get_plca_cfg: Return the current PLCA configuration */
 	int (*get_plca_cfg)(struct phy_device *dev,
-- 
2.47.3


