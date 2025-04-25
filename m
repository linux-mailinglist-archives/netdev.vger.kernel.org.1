Return-Path: <netdev+bounces-185925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B7A9C1F7
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCC6172C65
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16C121D3DB;
	Fri, 25 Apr 2025 08:50:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A171F91F6
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571010; cv=none; b=CdjF75k01syY1LwpmH7vBPyItRtysCZThOinLvO0PPxWjANeUeGWBVu2lWdwG7Q0pmg3UrOg1nleeUZv7Jsl3AaZyw/UxVevnSSBwFdQrfgh/nKUGQX8ODDNauZ2k8Msfthawz5ycH9jQ9RNSGxcMJ1ZnOzO0eDN33fCQ4dOsGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571010; c=relaxed/simple;
	bh=JAMws/vtOTxHeLm3gccrM03foPW5z5Ne+1T0subrk1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AnW9KScz2yw/VIw1vZGTltNYXIex8bZ1BNYsX5EqY2Hh3narEnJ96WvtVLwTsRVErrh989RbE/astqE8rwOUr9qHI/Wt9v0MMYhEe1u9ydUL7k1GMvBXuDGsxyg64vR7slYiJg7SXbtELDIj1Ug5de3c6MfPI1/+r8wsQirgbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u8Ekm-0004ed-2U; Fri, 25 Apr 2025 10:49:48 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u8Ekh-00218p-1o;
	Fri, 25 Apr 2025 10:49:43 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u8Ekh-00144S-1W;
	Fri, 25 Apr 2025 10:49:43 +0200
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
Subject: [PATCH net-next v1 1/1] Documentation: networking: expand and clarify EEE_GET/EEE_SET documentation
Date: Fri, 25 Apr 2025 10:49:41 +0200
Message-Id: <20250425084941.253961-1-o.rempel@pengutronix.de>
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
 Documentation/networking/ethtool-netlink.rst | 103 ++++++++++++++++---
 1 file changed, 90 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b6e9af4d0f1b..dfbdd99a7228 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1215,20 +1215,65 @@ Kernel response contents:
 
   =====================================  ======  ==========================
   ``ETHTOOL_A_EEE_HEADER``               nested  request header
-  ``ETHTOOL_A_EEE_MODES_OURS``           bool    supported/advertised modes
-  ``ETHTOOL_A_EEE_MODES_PEER``           bool    peer advertised link modes
+  ``ETHTOOL_A_EEE_MODES_OURS``           bitset  supported/advertised modes
+  ``ETHTOOL_A_EEE_MODES_PEER``           bitset  peer advertised link modes
   ``ETHTOOL_A_EEE_ACTIVE``               bool    EEE is actively used
   ``ETHTOOL_A_EEE_ENABLED``              bool    EEE is enabled
   ``ETHTOOL_A_EEE_TX_LPI_ENABLED``       bool    Tx lpi enabled
   ``ETHTOOL_A_EEE_TX_LPI_TIMER``         u32     Tx lpi timeout (in us)
   =====================================  ======  ==========================
 
-In ``ETHTOOL_A_EEE_MODES_OURS``, mask consists of link modes for which EEE is
-enabled, value of link modes for which EEE is advertised. Link modes for which
-peer advertises EEE are listed in ``ETHTOOL_A_EEE_MODES_PEER`` (no mask). The
-netlink interface allows reporting EEE status for all link modes but only
-first 32 are provided by the ``ethtool_ops`` callback.
+Detailed behavior:
 
+``ETHTOOL_A_EEE_MODES_OURS`` is a bitset consisting of:
+
+ - Value: link modes that the driver intends to advertise for EEE.
+ - Mask: subset of link modes supported for EEE by the interface.
+
+The `advertised` value is stored in software and remains even if EEE is
+disabled. It can be modified independently and is preserved across toggles of
+EEE enable/disable. If ``ETHTOOL_A_EEE_ENABLED`` is false, PHY does not
+advertise EEE, but the configured value is reported.
+
+``ETHTOOL_A_EEE_MODES_PEER`` shows the peer's EEE capabilities. It is a bitset
+consisting of:
+
+ - Value: link modes that the link partner advertises for EEE.
+ - Mask: empty
+
+This value is typically reported by the hardware and may represent only a
+subset of the actual capabilities supported and advertised by the link partner.
+The local hardware may not be able to detect or represent all EEE-capable modes
+of the peer. As a result, the true EEE support on the peer side may exceed what
+is reported.
+
+``ETHTOOL_A_EEE_ACTIVE`` indicates whether EEE is currently active on the link.
+This is determined by the kernel as a combination of the currently active link
+mode, locally advertised EEE modes, and peer-advertised EEE modes:
+
+    active = (current_link_mode & advertised & link_partner)
+
+In practice, the evaluation may also depend on whether the MAC supports EEE for
+the given mode. There is mostly no hardware status bit that directly indicates
+an active EEE state. Furthermore, even if ``ETHTOOL_A_EEE_ACTIVE`` is true,
+other settings such as ``ETHTOOL_A_EEE_TX_LPI_ENABLED`` or an excessively high
+``ETHTOOL_A_EEE_TX_LPI_TIMER`` may prevent the MAC from actually entering the
+LPI state. Thus, the "active" status should be interpreted as a potential
+capability, not as a guaranteed indication of LPI activity. The only strict
+rule is that if ``ETHTOOL_A_EEE_ENABLED`` is false, then
+``ETHTOOL_A_EEE_ACTIVE`` must also be false.
+
+``ETHTOOL_A_EEE_ENABLED`` is a software-only switch that controls if the
+advertisement is programmed into hardware.
+
+``ETHTOOL_A_EEE_TX_LPI_TIMER`` defines the delay in microseconds after the last
+transmitted frame before the MAC enters the Low Power Idle (LPI) state. This
+value applies globally to all link modes, though in practice, optimal values
+may differ between modes.
+
+The netlink interface can represent link modes up to
+``__ETHTOOL_LINK_MODE_MASK_NBITS``, but traditional ioctls only support the
+first 32.
 
 EEE_SET
 =======
@@ -1239,18 +1284,50 @@ Request contents:
 
   =====================================  ======  ==========================
   ``ETHTOOL_A_EEE_HEADER``               nested  request header
-  ``ETHTOOL_A_EEE_MODES_OURS``           bool    advertised modes
+  ``ETHTOOL_A_EEE_MODES_OURS``           bitset  advertised modes
   ``ETHTOOL_A_EEE_ENABLED``              bool    EEE is enabled
   ``ETHTOOL_A_EEE_TX_LPI_ENABLED``       bool    Tx lpi enabled
   ``ETHTOOL_A_EEE_TX_LPI_TIMER``         u32     Tx lpi timeout (in us)
   =====================================  ======  ==========================
 
-``ETHTOOL_A_EEE_MODES_OURS`` is used to either list link modes to advertise
-EEE for (if there is no mask) or specify changes to the list (if there is
-a mask). The netlink interface allows reporting EEE status for all link modes
-but only first 32 can be set at the moment as that is what the ``ethtool_ops``
-callback supports.
+Detailed behavior:
+
+``ETHTOOL_A_EEE_MODES_OURS`` can specify the list of advertised link modes.
+
+``ETHTOOL_A_EEE_ENABLED`` is a software flag that tells the kernel to prepare
+EEE functionality. If autonegotiation is enabled, this means writing the EEE
+advertisement register so that the PHY includes the EEE-capable modes in the
+autonegotiation pages it transmits. The actual advertisement set is a subset
+derived from PHY-supported modes, MAC capabilities, and possible blacklists.
+This subset can be further restricted by ``ETHTOOL_A_EEE_MODES_OURS``. If
+autonegotiation is disabled, EEE advertisement is not transmitted and EEE will
+not be negotiated or used.
+
+``ETHTOOL_A_EEE_TX_LPI_ENABLED`` controls whether the system should enter the
+Low Power Idle (LPI) state. In this state, the MAC typically notifies the PHY,
+which then transitions the medium (e.g., twisted pair) side into LPI. The exact
+behavior depends on the active link mode:
+
+ - In **100BaseT/Full**, an asymmetric LPI configuration (local off, peer on)
+   leads to asymmetric behavior: the local TX line remains active, while the RX
+   line may enter LPI.
+ - In **1000BaseT/Full**, there are no separate TX/RX lines; the wire is silent
+   only if both sides enter the LPI state.
+
+- ``ETHTOOL_A_EEE_TX_LPI_TIMER`` configures the delay after the last
+  transmitted frame before the MAC enters the LPI state. This single timer
+  value applies to all link modes, although using the same value for all modes
+  may not be optimal in practice. A value that is too high may effectively
+  prevent entry into the LPI state.
+
+.. note::
+   For EEE advertisement to take effect, PHY autonegotiation must be enabled.
+
+Limitations:
 
+The netlink interface allows configuring all link modes up to
+``__ETHTOOL_LINK_MODE_MASK_NBITS``, but if drivers depend on legacy
+``ethtool_ops``, only the first 32 link modes are supported.
 
 TSINFO_GET
 ==========
-- 
2.39.5


