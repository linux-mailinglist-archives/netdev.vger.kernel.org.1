Return-Path: <netdev+bounces-149692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6B9E6D7D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5128D18850B1
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37C1FECD4;
	Fri,  6 Dec 2024 11:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743D1DD0EC
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733485218; cv=none; b=e/08PzjA95xCXOKFUiztSH0BzDv72CqWa9nuw6A1hLRIj269De3vHExMb5tBtNeZnFxf5AvVgVj3RvjLFJwKF1lZTG5eL5S75yTvNJMVm+X34TCVOHmizEiU1DTFw0YSx+kSXFFrOKyKsDloA4ARdpF/kuymWVA3bLVSjNx+GiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733485218; c=relaxed/simple;
	bh=ehR4ayXGQzgx/R3FrORqWt1kBFmo9zk7t909tW6mK04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=egFbbqvO9E9WmJLNvpQFZtL9nrPMaZX9f0tnOWqv3L55b9kbUe6Ju/T+dAtMAVa9IFDE95aiqBGbTkv06XIBPrQGCcdqAg1Qn8Se6+oUnXbhn+2TzzPYqQZ1Zc2xh6F3s008/arNmDOMSyu348nXG3/evRrul948ZEZEEkN/qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tJWge-0003yo-9s; Fri, 06 Dec 2024 12:39:56 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJWgc-001zVW-2k;
	Fri, 06 Dec 2024 12:39:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJWgd-001hi8-1n;
	Fri, 06 Dec 2024 12:39:55 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v1 1/1] net: phy: Move callback comments from struct to kernel-doc section
Date: Fri,  6 Dec 2024 12:39:52 +0100
Message-Id: <20241206113952.406311-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Relocate all callback-related comments from the `struct phy_driver`
definition to a dedicated `kernel-doc` section. This improves code
readability by decluttering the structure definition and consolidating
callback documentation in a central place for kernel-doc generation.

No functional changes are introduced by this patch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/phy.h | 705 ++++++++++++++++++++++++++++++++------------
 1 file changed, 522 insertions(+), 183 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 61a1bc81f597..e8a2e568cd32 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -934,6 +934,52 @@ struct phy_led {
  *   supports (like interrupts)
  * @driver_data: Static driver data
  *
+ * @soft_reset: Perform a software reset on the PHY.
+ * @config_init: Initialize the PHY, including after a reset.
+ * @probe: Probe the PHY during device discovery.
+ * @get_features: Retrieve the PHY's supported features.
+ * @inband_caps: Query in-band signaling capabilities for a given interface.
+ * @config_inband: Configure in-band signaling for the PHY.
+ * @get_rate_matching: Get supported rate matching for a specific interface.
+ * @suspend: Suspend the PHY device, saving state if needed.
+ * @resume: Resume the PHY device, restoring state if needed.
+ * @config_aneg: Configure autonegotiation or force speed/duplex.
+ * @aneg_done: Check if autonegotiation is completed.
+ * @read_status: Retrieve the negotiated speed and duplex settings.
+ * @config_intr: Enable or disable PHY interrupts.
+ * @handle_interrupt: Handle PHY interrupts.
+ * @remove: Cleanup resources during PHY removal.
+ * @match_phy_device: Check if the driver matches a given PHY device.
+ * @set_wol: Configure Wake-on-LAN (WoL) settings.
+ * @get_wol: Retrieve current Wake-on-LAN (WoL) settings.
+ * @link_change_notify: Notify the driver of a link state change.
+ * @read_mmd: Read a register from a specific MMD.
+ * @write_mmd: Write a value to a specific MMD register.
+ * @read_page: Retrieve the current PHY register page.
+ * @write_page: Set the current PHY register page.
+ * @module_info: Retrieve size and type of the module EEPROM.
+ * @module_eeprom: Retrieve EEPROM data from the plug-in module.
+ * @cable_test_start: Start a cable test.
+ * @cable_test_tdr_start: Start a raw TDR (Time-Domain Reflectometry) cable test.
+ * @cable_test_get_status: Retrieve the status of an ongoing cable test.
+ * @get_sset_count: Retrieve the number of supported statistic counters.
+ * @get_strings: Retrieve the names of supported statistic counters.
+ * @get_stats: Retrieve values of supported statistic counters.
+ * @get_tunable: Retrieve the value of a PHY tunable parameter.
+ * @set_tunable: Configure a PHY tunable parameter.
+ * @set_loopback: Enable or disable PHY loopback mode.
+ * @get_sqi: Retrieve the signal quality indicator (SQI).
+ * @get_sqi_max: Retrieve the maximum supported signal quality indicator (SQI).
+ * @get_plca_cfg: Retrieve the current PLCA configuration.
+ * @set_plca_cfg: Configure PLCA settings for the PHY.
+ * @get_plca_status: Retrieve the current PLCA status information.
+ * @led_brightness_set: Configure the brightness of a PHY LED.
+ * @led_blink_set: Configure the blinking behavior of a PHY LED.
+ * @led_hw_is_supported: Check if hardware supports specified LED control rules.
+ * @led_hw_control_set: Configure hardware control for a PHY LED.
+ * @led_hw_control_get: Retrieve the hardware control rules for a PHY LED.
+ * @led_polarity_set: Configure the polarity modes of a PHY LED.
+ *
  * All functions are optional. If config_aneg or read_status
  * are not implemented, the phy core uses the genphy versions.
  * Note that none of these functions should be called from
@@ -951,277 +997,570 @@ struct phy_driver {
 	u32 flags;
 	const void *driver_data;
 
-	/**
-	 * @soft_reset: Called to issue a PHY software reset
-	 */
 	int (*soft_reset)(struct phy_device *phydev);
-
-	/**
-	 * @config_init: Called to initialize the PHY,
-	 * including after a reset
-	 */
 	int (*config_init)(struct phy_device *phydev);
-
-	/**
-	 * @probe: Called during discovery.  Used to set
-	 * up device-specific structures, if any
-	 */
 	int (*probe)(struct phy_device *phydev);
-
-	/**
-	 * @get_features: Probe the hardware to determine what
-	 * abilities it has.  Should only set phydev->supported.
-	 */
 	int (*get_features)(struct phy_device *phydev);
 
-	/**
-	 * @inband_caps: query whether in-band is supported for the given PHY
-	 * interface mode. Returns a bitmask of bits defined by enum
-	 * link_inband_signalling.
-	 */
 	unsigned int (*inband_caps)(struct phy_device *phydev,
 				    phy_interface_t interface);
-
-	/**
-	 * @config_inband: configure in-band mode for the PHY
-	 */
 	int (*config_inband)(struct phy_device *phydev, unsigned int modes);
 
-	/**
-	 * @get_rate_matching: Get the supported type of rate matching for a
-	 * particular phy interface. This is used by phy consumers to determine
-	 * whether to advertise lower-speed modes for that interface. It is
-	 * assumed that if a rate matching mode is supported on an interface,
-	 * then that interface's rate can be adapted to all slower link speeds
-	 * supported by the phy. If the interface is not supported, this should
-	 * return %RATE_MATCH_NONE.
-	 */
 	int (*get_rate_matching)(struct phy_device *phydev,
 				   phy_interface_t iface);
 
 	/* PHY Power Management */
-	/** @suspend: Suspend the hardware, saving state if needed */
 	int (*suspend)(struct phy_device *phydev);
-	/** @resume: Resume the hardware, restoring state if needed */
 	int (*resume)(struct phy_device *phydev);
 
-	/**
-	 * @config_aneg: Configures the advertisement and resets
-	 * autonegotiation if phydev->autoneg is on,
-	 * forces the speed to the current settings in phydev
-	 * if phydev->autoneg is off
-	 */
 	int (*config_aneg)(struct phy_device *phydev);
-
-	/** @aneg_done: Determines the auto negotiation result */
 	int (*aneg_done)(struct phy_device *phydev);
 
-	/** @read_status: Determines the negotiated speed and duplex */
 	int (*read_status)(struct phy_device *phydev);
 
-	/**
-	 * @config_intr: Enables or disables interrupts.
-	 * It should also clear any pending interrupts prior to enabling the
-	 * IRQs and after disabling them.
-	 */
 	int (*config_intr)(struct phy_device *phydev);
-
-	/** @handle_interrupt: Override default interrupt handling */
 	irqreturn_t (*handle_interrupt)(struct phy_device *phydev);
 
-	/** @remove: Clears up any memory if needed */
 	void (*remove)(struct phy_device *phydev);
 
-	/**
-	 * @match_phy_device: Returns true if this is a suitable
-	 * driver for the given phydev.	 If NULL, matching is based on
-	 * phy_id and phy_id_mask.
-	 */
 	int (*match_phy_device)(struct phy_device *phydev);
 
-	/**
-	 * @set_wol: Some devices (e.g. qnap TS-119P II) require PHY
-	 * register changes to enable Wake on LAN, so set_wol is
-	 * provided to be called in the ethernet driver's set_wol
-	 * function.
-	 */
 	int (*set_wol)(struct phy_device *dev, struct ethtool_wolinfo *wol);
-
-	/**
-	 * @get_wol: See set_wol, but for checking whether Wake on LAN
-	 * is enabled.
-	 */
 	void (*get_wol)(struct phy_device *dev, struct ethtool_wolinfo *wol);
 
-	/**
-	 * @link_change_notify: Called to inform a PHY device driver
-	 * when the core is about to change the link state. This
-	 * callback is supposed to be used as fixup hook for drivers
-	 * that need to take action when the link state
-	 * changes. Drivers are by no means allowed to mess with the
-	 * PHY device structure in their implementations.
-	 */
 	void (*link_change_notify)(struct phy_device *dev);
 
-	/**
-	 * @read_mmd: PHY specific driver override for reading a MMD
-	 * register.  This function is optional for PHY specific
-	 * drivers.  When not provided, the default MMD read function
-	 * will be used by phy_read_mmd(), which will use either a
-	 * direct read for Clause 45 PHYs or an indirect read for
-	 * Clause 22 PHYs.  devnum is the MMD device number within the
-	 * PHY device, regnum is the register within the selected MMD
-	 * device.
-	 */
 	int (*read_mmd)(struct phy_device *dev, int devnum, u16 regnum);
-
-	/**
-	 * @write_mmd: PHY specific driver override for writing a MMD
-	 * register.  This function is optional for PHY specific
-	 * drivers.  When not provided, the default MMD write function
-	 * will be used by phy_write_mmd(), which will use either a
-	 * direct write for Clause 45 PHYs, or an indirect write for
-	 * Clause 22 PHYs.  devnum is the MMD device number within the
-	 * PHY device, regnum is the register within the selected MMD
-	 * device.  val is the value to be written.
-	 */
 	int (*write_mmd)(struct phy_device *dev, int devnum, u16 regnum,
 			 u16 val);
 
-	/** @read_page: Return the current PHY register page number */
 	int (*read_page)(struct phy_device *dev);
-	/** @write_page: Set the current PHY register page number */
 	int (*write_page)(struct phy_device *dev, int page);
 
-	/**
-	 * @module_info: Get the size and type of the eeprom contained
-	 * within a plug-in module
-	 */
 	int (*module_info)(struct phy_device *dev,
 			   struct ethtool_modinfo *modinfo);
-
-	/**
-	 * @module_eeprom: Get the eeprom information from the plug-in
-	 * module
-	 */
 	int (*module_eeprom)(struct phy_device *dev,
 			     struct ethtool_eeprom *ee, u8 *data);
 
-	/** @cable_test_start: Start a cable test */
 	int (*cable_test_start)(struct phy_device *dev);
-
-	/**  @cable_test_tdr_start: Start a raw TDR cable test */
 	int (*cable_test_tdr_start)(struct phy_device *dev,
 				    const struct phy_tdr_config *config);
-
-	/**
-	 * @cable_test_get_status: Once per second, or on interrupt,
-	 * request the status of the test.
-	 */
 	int (*cable_test_get_status)(struct phy_device *dev, bool *finished);
 
 	/* Get statistics from the PHY using ethtool */
-	/** @get_sset_count: Number of statistic counters */
 	int (*get_sset_count)(struct phy_device *dev);
-	/** @get_strings: Names of the statistic counters */
 	void (*get_strings)(struct phy_device *dev, u8 *data);
-	/** @get_stats: Return the statistic counter values */
 	void (*get_stats)(struct phy_device *dev,
 			  struct ethtool_stats *stats, u64 *data);
 
 	/* Get and Set PHY tunables */
-	/** @get_tunable: Return the value of a tunable */
 	int (*get_tunable)(struct phy_device *dev,
 			   struct ethtool_tunable *tuna, void *data);
-	/** @set_tunable: Set the value of a tunable */
 	int (*set_tunable)(struct phy_device *dev,
 			    struct ethtool_tunable *tuna,
 			    const void *data);
-	/** @set_loopback: Set the loopback mood of the PHY */
+
 	int (*set_loopback)(struct phy_device *dev, bool enable);
-	/** @get_sqi: Get the signal quality indication */
+
 	int (*get_sqi)(struct phy_device *dev);
-	/** @get_sqi_max: Get the maximum signal quality indication */
 	int (*get_sqi_max)(struct phy_device *dev);
 
 	/* PLCA RS interface */
-	/** @get_plca_cfg: Return the current PLCA configuration */
 	int (*get_plca_cfg)(struct phy_device *dev,
 			    struct phy_plca_cfg *plca_cfg);
-	/** @set_plca_cfg: Set the PLCA configuration */
 	int (*set_plca_cfg)(struct phy_device *dev,
 			    const struct phy_plca_cfg *plca_cfg);
-	/** @get_plca_status: Return the current PLCA status info */
 	int (*get_plca_status)(struct phy_device *dev,
 			       struct phy_plca_status *plca_st);
 
-	/**
-	 * @led_brightness_set: Set a PHY LED brightness. Index
-	 * indicates which of the PHYs led should be set. Value
-	 * follows the standard LED class meaning, e.g. LED_OFF,
-	 * LED_HALF, LED_FULL.
-	 */
 	int (*led_brightness_set)(struct phy_device *dev,
 				  u8 index, enum led_brightness value);
-
-	/**
-	 * @led_blink_set: Set a PHY LED blinking.  Index indicates
-	 * which of the PHYs led should be configured to blink. Delays
-	 * are in milliseconds and if both are zero then a sensible
-	 * default should be chosen.  The call should adjust the
-	 * timings in that case and if it can't match the values
-	 * specified exactly.
-	 */
 	int (*led_blink_set)(struct phy_device *dev, u8 index,
 			     unsigned long *delay_on,
 			     unsigned long *delay_off);
-	/**
-	 * @led_hw_is_supported: Can the HW support the given rules.
-	 * @dev: PHY device which has the LED
-	 * @index: Which LED of the PHY device
-	 * @rules The core is interested in these rules
-	 *
-	 * Return 0 if yes,  -EOPNOTSUPP if not, or an error code.
-	 */
 	int (*led_hw_is_supported)(struct phy_device *dev, u8 index,
 				   unsigned long rules);
-	/**
-	 * @led_hw_control_set: Set the HW to control the LED
-	 * @dev: PHY device which has the LED
-	 * @index: Which LED of the PHY device
-	 * @rules The rules used to control the LED
-	 *
-	 * Returns 0, or a an error code.
-	 */
 	int (*led_hw_control_set)(struct phy_device *dev, u8 index,
 				  unsigned long rules);
-	/**
-	 * @led_hw_control_get: Get how the HW is controlling the LED
-	 * @dev: PHY device which has the LED
-	 * @index: Which LED of the PHY device
-	 * @rules Pointer to the rules used to control the LED
-	 *
-	 * Set *@rules to how the HW is currently blinking. Returns 0
-	 * on success, or a error code if the current blinking cannot
-	 * be represented in rules, or some other error happens.
-	 */
 	int (*led_hw_control_get)(struct phy_device *dev, u8 index,
 				  unsigned long *rules);
-
-	/**
-	 * @led_polarity_set: Set the LED polarity modes
-	 * @dev: PHY device which has the LED
-	 * @index: Which LED of the PHY device
-	 * @modes: bitmap of LED polarity modes
-	 *
-	 * Configure LED with all the required polarity modes in @modes
-	 * to make it correctly turn ON or OFF.
-	 *
-	 * Returns 0, or an error code.
-	 */
 	int (*led_polarity_set)(struct phy_device *dev, int index,
 				unsigned long modes);
 };
+
+#if 0 /* For kernel-doc purposes only. */
+
+/**
+ * soft_reset - Issue a PHY software reset.
+ * @phydev: The PHY device to reset.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int soft_reset(struct phy_device *phydev);
+
+/**
+ * config_init - Initialize the PHY, including after a reset.
+ * @phydev: The PHY device to initialize.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int config_init(struct phy_device *phydev);
+
+/**
+ * probe - Set up device-specific structures during discovery.
+ * @phydev: The PHY device to probe.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int probe(struct phy_device *phydev);
+
+/**
+ * get_features - Probe the PHY hardware for supported abilities.
+ * @phydev: The PHY device to probe.
+ *
+ * Sets @phydev->supported with the PHY's capabilities.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int get_features(struct phy_device *phydev);
+
+/**
+ * inband_caps - Query in-band capabilities for a PHY interface.
+ * @phydev: The PHY device to query.
+ * @interface: The PHY interface mode to check.
+ *
+ * Returns a bitmask of supported in-band signaling modes (see
+ * enum link_inband_signalling) or 0 if unsupported.
+ */
+unsigned int inband_caps(struct phy_device *phydev, phy_interface_t interface);
+
+/**
+ * config_inband - Configure in-band mode for the PHY.
+ * @phydev: The PHY device to configure.
+ * @modes: A bitmask of in-band modes to configure.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int config_inband(struct phy_device *phydev, unsigned int modes);
+
+/**
+ * get_rate_matching - Get the supported type of rate matching for a PHY
+ *   interface.
+ * @phydev: The PHY device to query.
+ * @iface: The PHY interface to check.
+ *
+ * Returns the rate matching mode (see enum rate_match_mode) or
+ * %RATE_MATCH_NONE if not supported.
+ */
+int get_rate_matching(struct phy_device *phydev, phy_interface_t iface);
+
+/**
+ * suspend - Suspend the PHY device.
+ * @phydev: The PHY device to suspend.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int suspend(struct phy_device *phydev);
+
+/**
+ * resume - Resume the PHY device.
+ * @phydev: The PHY device to resume.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int resume(struct phy_device *phydev);
+
+/**
+ * config_aneg - Configure autonegotiation or force speed/duplex.
+ * @phydev: The PHY device to configure.
+ *
+ * If @phydev->autoneg is enabled, this configures advertisement
+ * and resets autonegotiation. Otherwise, it forces the speed and
+ * duplex settings from @phydev.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int config_aneg(struct phy_device *phydev);
+
+/**
+ * aneg_done - Check the result of autonegotiation.
+ * @phydev: The PHY device to check.
+ *
+ * Returns 0 if autonegotiation is not completed, 1 if it is completed,
+ * or a negative error code on failure.
+ */
+int aneg_done(struct phy_device *phydev);
+
+/**
+ * read_status - Get the negotiated speed and duplex settings.
+ * @phydev: The PHY device to query.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int read_status(struct phy_device *phydev);
+
+/**
+ * config_intr - Enable or disable interrupts for the PHY.
+ * @phydev: The PHY device to configure.
+ *
+ * Clears pending interrupts before enabling or after disabling IRQs.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int config_intr(struct phy_device *phydev);
+
+/**
+ * handle_interrupt - Handle a PHY interrupt.
+ * @phydev: The PHY device that triggered the interrupt.
+ *
+ * Returns an IRQ return code indicating the result of handling.
+ */
+irqreturn_t handle_interrupt(struct phy_device *phydev);
+
+/**
+ * remove - Clean up resources allocated during probe.
+ * @phydev: The PHY device to clean up.
+ */
+void remove(struct phy_device *phydev);
+
+/**
+ * match_phy_device - Check if this driver is suitable for the PHY device.
+ * @phydev: The PHY device to match.
+ *
+ * Returns 1 (true) if the driver is suitable for the given PHY device,
+ * or 0 (false) otherwise. If not provided, matching is based on
+ * `phy_id` and `phy_id_mask`.
+ */
+int match_phy_device(struct phy_device *phydev);
+
+/**
+ * set_wol - Configure Wake-on-LAN (WoL) settings for the PHY.
+ * @dev: The PHY device to configure.
+ * @wol: Pointer to a structure containing the WoL settings.
+ *
+ * Some devices require PHY register changes to enable WoL. This function
+ * should be called from the Ethernet driver's `set_wol` function to
+ * configure WoL settings.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int set_wol(struct phy_device *dev, struct ethtool_wolinfo *wol);
+
+/**
+ * get_wol - Retrieve the current Wake-on-LAN (WoL) settings for the PHY.
+ * @dev: The PHY device to query.
+ * @wol: Pointer to a structure where the WoL settings will be stored.
+ */
+void get_wol(struct phy_device *dev, struct ethtool_wolinfo *wol);
+
+/**
+ * link_change_notify - Notify the driver of a link state change.
+ * @dev: The PHY device whose link state is changing.
+ *
+ * Called to inform the PHY device driver when the core is about to change
+ * the link state. This callback should be used as a fixup hook for drivers
+ * that need to take specific actions during link state changes. Drivers
+ * must not modify the PHY device structure in this callback.
+ */
+void link_change_notify(struct phy_device *dev);
+
+/**
+ * read_mmd - Read a register from a specific MMD (Clause 45 or Clause 22).
+ * @dev: The PHY device to query.
+ * @devnum: The MMD device number within the PHY device.
+ * @regnum: The register number within the selected MMD device.
+ *
+ * Returns the register value on success or a negative error code on failure.
+ */
+int read_mmd(struct phy_device *dev, int devnum, u16 regnum);
+
+/**
+ * write_mmd - Write a value to a specific MMD register.
+ * @dev: The PHY device to configure.
+ * @devnum: The MMD device number within the PHY device.
+ * @regnum: The register number within the selected MMD device.
+ * @val: The value to write to the register.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int write_mmd(struct phy_device *dev, int devnum, u16 regnum, u16 val);
+
+/**
+ * read_page - Retrieve the current PHY register page number.
+ * @dev: The PHY device to query.
+ *
+ * Returns the current page number or a negative error code on failure.
+ */
+int read_page(struct phy_device *dev);
+
+/**
+ * write_page - Set the current PHY register page number.
+ * @dev: The PHY device to configure.
+ * @page: The page number to set.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int write_page(struct phy_device *dev, int page);
+
+/**
+ * module_info - Retrieve the size and type of the EEPROM in a plug-in module.
+ * @dev: The PHY device to query.
+ * @modinfo: Pointer to a structure where the module information will be stored.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int module_info(struct phy_device *dev, struct ethtool_modinfo *modinfo);
+
+/**
+ * module_eeprom - Retrieve EEPROM data from a plug-in module.
+ * @dev: The PHY device to query.
+ * @ee: Pointer to a structure specifying the EEPROM read parameters.
+ * @data: Buffer to store the retrieved EEPROM data.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int module_eeprom(struct phy_device *dev, struct ethtool_eeprom *ee, u8 *data);
+
+/**
+ * cable_test_start - Start a cable test.
+ * @dev: The PHY device to test.
+ *
+ * Initiates a cable test on the specified PHY device.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int cable_test_start(struct phy_device *dev);
+
+/**
+ * cable_test_tdr_start - Start a raw TDR (Time-Domain Reflectometry) cable test.
+ * @dev: The PHY device to test.
+ * @config: Configuration parameters for the TDR cable test.
+ *
+ * Initiates a raw TDR cable test with the provided configuration.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int cable_test_tdr_start(struct phy_device *dev,
+			 const struct phy_tdr_config *config);
+
+/**
+ * cable_test_get_status - Request the status of an ongoing cable test.
+ * @dev: The PHY device being tested.
+ * @finished: Pointer to a boolean where the completion status will be stored.
+ *
+ * This function should be called once per second or on an interrupt to check
+ * the status of an ongoing cable test.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int cable_test_get_status(struct phy_device *dev, bool *finished);
+
+/**
+ * get_sset_count - Retrieve the number of statistic counters.
+ * @dev: The PHY device to query.
+ *
+ * Returns the number of statistic counters available for the specified PHY
+ * device.
+ */
+int get_sset_count(struct phy_device *dev);
+
+/**
+ * get_strings - Retrieve the names of statistic counters.
+ * @dev: The PHY device to query.
+ * @data: Buffer where the statistic counter names will be stored.
+ *
+ * Populates the provided buffer with the names of statistic counters for
+ * the specified PHY device.
+ */
+void get_strings(struct phy_device *dev, u8 *data);
+
+/**
+ * get_stats - Retrieve the values of statistic counters.
+ * @dev: The PHY device to query.
+ * @stats: Pointer to the structure describing the statistics.
+ * @data: Buffer to store the statistic counter values.
+ *
+ * Retrieves the values of the statistic counters for the specified PHY device
+ * and stores them in the provided buffer.
+ */
+void get_stats(struct phy_device *dev,
+	       struct ethtool_stats *stats, u64 *data);
+
+/**
+ * get_tunable - Retrieve the value of a PHY tunable.
+ * @dev: The PHY device to query.
+ * @tuna: Pointer to a structure describing the tunable.
+ * @data: Buffer to store the tunable value.
+ *
+ * Retrieves the value of a tunable parameter for the specified PHY device.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int get_tunable(struct phy_device *dev,
+		struct ethtool_tunable *tuna, void *data);
+
+/**
+ * set_tunable - Set the value of a PHY tunable.
+ * @dev: The PHY device to configure.
+ * @tuna: Pointer to a structure describing the tunable.
+ * @data: Pointer to the value to set for the tunable parameter.
+ *
+ * Configures a tunable parameter for the specified PHY device.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int set_tunable(struct phy_device *dev,
+		struct ethtool_tunable *tuna,
+		const void *data);
+
+/**
+ * set_loopback - Configure the loopback mode of the PHY.
+ * @dev: The PHY device to configure.
+ * @enable: Boolean indicating whether to enable (true) or disable (false)
+ *   loopback mode.
+ *
+ * Configures the PHY device to operate in loopback mode.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int set_loopback(struct phy_device *dev, bool enable);
+
+/**
+ * get_sqi - Retrieve the signal quality index (SQI).
+ * @dev: The PHY device to query.
+ *
+ * Returns the current signal quality index for the specified PHY device,
+ * or a negative error code on failure.
+ */
+int get_sqi(struct phy_device *dev);
+
+/**
+ * get_sqi_max - Retrieve the maximum signal quality index (SQI).
+ * @dev: The PHY device to query.
+ *
+ * Returns the maximum signal quality index supported by the PHY device,
+ * or a negative error code on failure.
+ */
+int get_sqi_max(struct phy_device *dev);
+
+/**
+ * get_plca_cfg - Retrieve the current PLCA configuration.
+ * @dev: The PHY device to query.
+ * @plca_cfg: Pointer to a structure where the PLCA configuration will be stored.
+ *
+ * Retrieves the current PLCA (Physical Layer Collision Avoidance) configuration
+ * for the specified PHY device.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int get_plca_cfg(struct phy_device *dev, struct phy_plca_cfg *plca_cfg);
+
+/**
+ * set_plca_cfg - Configure the PLCA settings.
+ * @dev: The PHY device to configure.
+ * @plca_cfg: Pointer to a structure containing the desired PLCA configuration.
+ *
+ * Sets the PLCA configuration for the specified PHY device.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int set_plca_cfg(struct phy_device *dev, const struct phy_plca_cfg *plca_cfg);
+
+/**
+ * get_plca_status - Retrieve the current PLCA status information.
+ * @dev: The PHY device to query.
+ * @plca_st: Pointer to a structure where the PLCA status will be stored.
+ *
+ * Retrieves the current PLCA status for the specified PHY device.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int get_plca_status(struct phy_device *dev, struct phy_plca_status *plca_st);
+
+/**
+ * led_brightness_set - Configure the brightness of a PHY LED.
+ * @dev: The PHY device that controls the LED.
+ * @index: The index of the LED to configure.
+ * @value: The brightness value to set (e.g., LED_OFF, LED_HALF, LED_FULL).
+ *
+ * Sets the brightness of the specified LED for the given PHY device.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int led_brightness_set(struct phy_device *dev, u8 index,
+		       enum led_brightness value);
+
+/**
+ * led_blink_set - Configure the blinking behavior of a PHY LED.
+ * @dev: The PHY device that controls the LED.
+ * @index: The index of the LED to configure.
+ * @delay_on: Pointer to the duration (in milliseconds) for which the LED is on.
+ * @delay_off: Pointer to the duration (in milliseconds) for which the LED is
+ *   off.
+ *
+ * Configures the blinking behavior of the specified LED. If both @delay_on
+ * and @delay_off are zero, the function sets a default blinking configuration.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int led_blink_set(struct phy_device *dev, u8 index, unsigned long *delay_on,
+		  unsigned long *delay_off);
+
+/**
+ * led_hw_is_supported - Check if the hardware supports the specified LED rules.
+ * @dev: The PHY device that controls the LED.
+ * @index: The index of the LED to check.
+ * @rules: Bitmask of rules to check against the hardware capabilities.
+ *
+ * Determines if the hardware supports the specified rules for controlling the
+ * LED.
+ *
+ * Returns 0 if the rules are supported, -EOPNOTSUPP if not supported,
+ * or another negative error code on failure.
+ */
+int led_hw_is_supported(struct phy_device *dev, u8 index, unsigned long rules);
+
+/**
+ * led_hw_control_set - Configure hardware control for a PHY LED.
+ * @dev: The PHY device that controls the LED.
+ * @index: The index of the LED to configure.
+ * @rules: Bitmask of rules to use for hardware control.
+ *
+ * Sets the hardware control rules for the specified LED.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int led_hw_control_set(struct phy_device *dev, u8 index, unsigned long rules);
+
+/**
+ * led_hw_control_get - Retrieve the current hardware control rules for a PHY
+ *   LED.
+ * @dev: The PHY device that controls the LED.
+ * @index: The index of the LED to query.
+ * @rules: Pointer to a variable where the current rules will be stored.
+ *
+ * Retrieves the hardware control rules currently applied to the specified LED.
+ *
+ * Returns 0 on success, or a negative error code if the rules cannot be
+ * represented or an error occurs.
+ */
+int led_hw_control_get(struct phy_device *dev, u8 index, unsigned long *rules);
+
+/**
+ * led_polarity_set - Configure the polarity modes of a PHY LED.
+ * @dev: The PHY device that controls the LED.
+ * @index: The index of the LED to configure.
+ * @modes: Bitmap of polarity modes to configure.
+ *
+ * Configures the LED polarity modes to ensure the LED operates correctly
+ * (turns on or off as needed).
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int led_polarity_set(struct phy_device *dev, int index, unsigned long modes);
+
+#endif
+
 #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
 
-- 
2.39.5


