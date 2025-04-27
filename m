Return-Path: <netdev+bounces-186314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5343A9E353
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 15:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB739189FEC1
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF3A17CA1B;
	Sun, 27 Apr 2025 13:41:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92D7E110
	for <netdev@vger.kernel.org>; Sun, 27 Apr 2025 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745761280; cv=none; b=euHFMhywm9j7ro+lbk6PW274Jm4VApGptFzhuPlQCSQ+/etAh5r07VlIyOMAIvEMLNOJCxXUg+Q6WPMRRibpuvd6rQXWQcYuPRG090GWBBMvizg2Ep0umMLH3yDGxnY0AmffLJRjMTyPj5DExjGU+p+YX+sc/eKXuDJFFqDEWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745761280; c=relaxed/simple;
	bh=ikFGBs4KPnaLHm/wpDtXdgUB435DQd98kOARQxyqFsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ri4o11q/tOZiTXMKqqzNB5JsYJglowOmS9kepsoboxm1dkhyEPPr0nn0Nc48siia24Xa/vlMdkE0FV37p4L/dC5qJF2LEfa01DVd47tPzG+PgvRNxf+PVVSh+7QoZ5axIU2p3NKgsM4AjKtxYgjw50BusqyglDpbaBWUzocMe/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u92FO-0002FE-Jm; Sun, 27 Apr 2025 15:40:42 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u92FI-002N5b-32;
	Sun, 27 Apr 2025 15:40:36 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u92FI-00AJYY-2k;
	Sun, 27 Apr 2025 15:40:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 1/1] Documentation: networking: expand and clarify EEE_GET/EEE_SET documentation
Date: Sun, 27 Apr 2025 15:40:34 +0200
Message-Id: <20250427134035.2458430-1-o.rempel@pengutronix.de>
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

Improve the documentation for ETHTOOL_MSG_EEE_GET and ETHTOOL_MSG_EEE_SET
to provide accurate descriptions of all netlink attributes involved.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/networking/ethtool-netlink.rst | 111 ++++++++++++++++---
 include/uapi/linux/ethtool.h                 |   3 +
 2 files changed, 96 insertions(+), 18 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b6e9af4d0f1b..78ee481437a4 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1215,20 +1215,16 @@ Kernel response contents:
 
   =====================================  ======  ==========================
   ``ETHTOOL_A_EEE_HEADER``               nested  request header
-  ``ETHTOOL_A_EEE_MODES_OURS``           bool    supported/advertised modes
-  ``ETHTOOL_A_EEE_MODES_PEER``           bool    peer advertised link modes
+  ``ETHTOOL_A_EEE_MODES_OURS``           bitset  supported/advertised modes
+  ``ETHTOOL_A_EEE_MODES_PEER``           bitset  peer advertised link modes
   ``ETHTOOL_A_EEE_ACTIVE``               bool    EEE is actively used
   ``ETHTOOL_A_EEE_ENABLED``              bool    EEE is enabled
-  ``ETHTOOL_A_EEE_TX_LPI_ENABLED``       bool    Tx lpi enabled
-  ``ETHTOOL_A_EEE_TX_LPI_TIMER``         u32     Tx lpi timeout (in us)
+  ``ETHTOOL_A_EEE_TX_LPI_ENABLED``       bool    Tx LPI enabled
+  ``ETHTOOL_A_EEE_TX_LPI_TIMER``         u32     Tx LPI timeout (in us)
   =====================================  ======  ==========================
 
-In ``ETHTOOL_A_EEE_MODES_OURS``, mask consists of link modes for which EEE is
-enabled, value of link modes for which EEE is advertised. Link modes for which
-peer advertises EEE are listed in ``ETHTOOL_A_EEE_MODES_PEER`` (no mask). The
-netlink interface allows reporting EEE status for all link modes but only
-first 32 are provided by the ``ethtool_ops`` callback.
-
+For detailed explanation of each attribute, see the ``EEE Attributes``
+section.
 
 EEE_SET
 =======
@@ -1239,17 +1235,96 @@ Request contents:
 
   =====================================  ======  ==========================
   ``ETHTOOL_A_EEE_HEADER``               nested  request header
-  ``ETHTOOL_A_EEE_MODES_OURS``           bool    advertised modes
+  ``ETHTOOL_A_EEE_MODES_OURS``           bitset  advertised modes
   ``ETHTOOL_A_EEE_ENABLED``              bool    EEE is enabled
-  ``ETHTOOL_A_EEE_TX_LPI_ENABLED``       bool    Tx lpi enabled
-  ``ETHTOOL_A_EEE_TX_LPI_TIMER``         u32     Tx lpi timeout (in us)
+  ``ETHTOOL_A_EEE_TX_LPI_ENABLED``       bool    Tx LPI enabled
+  ``ETHTOOL_A_EEE_TX_LPI_TIMER``         u32     Tx LPI timeout (in us)
   =====================================  ======  ==========================
 
-``ETHTOOL_A_EEE_MODES_OURS`` is used to either list link modes to advertise
-EEE for (if there is no mask) or specify changes to the list (if there is
-a mask). The netlink interface allows reporting EEE status for all link modes
-but only first 32 can be set at the moment as that is what the ``ethtool_ops``
-callback supports.
+For detailed explanation of each attribute, see the ``EEE Attributes``
+section.
+
+EEE Attributes
+==============
+
+Limitations:
+
+The netlink interface allows configuring all link modes up to
+``__ETHTOOL_LINK_MODE_MASK_NBITS``, but if the driver relies on legacy
+``ethtool_ops``, only the first 32 link modes are supported.
+
+The following structure is used for the ioctl interface (``ETHTOOL_GEEE`` and
+``ETHTOOL_SEEE``):
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_eee
+
+Mapping between netlink attributes and struct fields:
+
+  ================================  ================================
+  Netlink attribute                 struct ethtool_eee field
+  ================================  ================================
+  ``ETHTOOL_A_EEE_MODES_OURS``       advertised
+  ``ETHTOOL_A_EEE_MODES_PEER``       lp_advertised
+  ``ETHTOOL_A_EEE_ACTIVE``           eee_active
+  ``ETHTOOL_A_EEE_ENABLED``          eee_enabled
+  ``ETHTOOL_A_EEE_TX_LPI_ENABLED``   tx_lpi_enabled
+  ``ETHTOOL_A_EEE_TX_LPI_TIMER``     tx_lpi_timer
+  ================================  ================================
+
+
+``ETHTOOL_A_EEE_MODES_OURS`` (bitset)
+-------------------------------------
+- Value: link modes that the driver intends to advertise for EEE.
+- Mask: subset of link modes supported for EEE by the interface.
+
+The advertised EEE capabilities are maintained in software state and persist
+across toggling EEE on or off. If ``ETHTOOL_A_EEE_ENABLED`` is false, the PHY
+does not advertise EEE, but the configured value is reported.
+
+``ETHTOOL_A_EEE_MODES_PEER`` (bitset)
+-------------------------------------
+- Value: link modes that the link partner advertises for EEE.
+- Mask: empty.
+
+This value is typically reported by the hardware and may represent only a
+subset of the actual capabilities supported and advertised by the link partner.
+The local hardware may not be able to detect or represent all EEE-capable modes
+of the peer.
+
+``ETHTOOL_A_EEE_ACTIVE`` (bool)
+-------------------------------
+Indicates whether EEE is currently active on the link. EEE is considered active
+if:
+
+ - ``ETHTOOL_A_EEE_ENABLED`` is true,
+ - Autonegotiation is enabled,
+ - The current link mode is EEE-capable,
+ - Both the local advertisement and the peer advertisement include this link
+   mode.
+
+``ETHTOOL_A_EEE_ENABLED`` (bool)
+--------------------------------
+A software-controlled flag.
+
+When ``ETHTOOL_A_EEE_ENABLED`` is set to true and autonegotiation is active,
+the kernel programs the EEE advertisement settings into the PHY hardware
+registers. This enables negotiation of EEE capability with the link partner.
+
+When ``ETHTOOL_A_EEE_ENABLED`` is set to false, EEE advertisement is disabled.
+The PHY will not include EEE capability in its autonegotiation pages, and EEE
+will not be negotiated even if it remains configured in software state.
+
+``ETHTOOL_A_EEE_TX_LPI_ENABLED`` (bool)
+---------------------------------------
+Controls whether the system may enter the Low Power Idle (LPI) state after
+transmission has stopped.
+
+``ETHTOOL_A_EEE_TX_LPI_TIMER`` (u32)
+------------------------------------
+Defines the delay in microseconds after the last transmitted frame before the
+MAC may enter the Low Power Idle (LPI) state. This value applies globally to
+all link modes. A higher timer value delays LPI entry.
 
 
 TSINFO_GET
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 84833cca29fe..c596618633bc 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -366,6 +366,9 @@ struct ethtool_eeprom {
  *	its tx lpi (after reaching 'idle' state). Effective only when eee
  *	was negotiated and tx_lpi_enabled was set.
  * @reserved: Reserved for future use; see the note on reserved space.
+ *
+ * More detailed documentation can be found in
+ * Documentation/networking/ethtool-netlink.rst section "EEE Attributes".
  */
 struct ethtool_eee {
 	__u32	cmd;
-- 
2.39.5


