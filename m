Return-Path: <netdev+bounces-153889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90A9F9F41
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 09:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F10916D892
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA31F3D51;
	Sat, 21 Dec 2024 08:15:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF341F2376
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734768955; cv=none; b=UMO2GV6xZNDhql5Qjs+gRBmCeg3Z9F1YIxBaueCbKrUItTdHijKt9Q6YtpeHl2uy+nI1lRvy3Fze/1JPzGrxeE6mwYBDgesBdCZpAs6cZv+lZk56PtMuXzf8Iu1gJY2ESlgs5evwcC6RCmH5qMTN+t1KtceGb8h/Da0AU+JnkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734768955; c=relaxed/simple;
	bh=2wXbYqaWGW9mOPTkLt5y4RaTyBb9rPot160rt9mK8bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JPmBx9nCJsu8aWSLbz1GBW9AVQtmRpr57jn9JDk5RTRwQWIl3vS6azvwvEjwHu3KrZEfu5c7foKkgh+TMmBQS8DhhIJlk/JCwvm5Zzagp0pH3dBvVfiVR9CVL6Auf+2G28A9duvKdM9C2OQn+sd8tr5FOTJyaGdHCZXDbVhpajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue8-0000Qq-3z; Sat, 21 Dec 2024 09:15:36 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue2-004Vds-37;
	Sat, 21 Dec 2024 09:15:31 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue3-00CbTD-25;
	Sat, 21 Dec 2024 09:15:31 +0100
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
Subject: [PATCH net-next v4 4/8] Documentation: networking: update PHY error counter diagnostics in twisted pair guide
Date: Sat, 21 Dec 2024 09:15:26 +0100
Message-Id: <20241221081530.3003900-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241221081530.3003900-1-o.rempel@pengutronix.de>
References: <20241221081530.3003900-1-o.rempel@pengutronix.de>
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

Replace generic instructions for monitoring error counters with a
procedure using the unified PHY statistics interface (`--all-groups`).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../twisted_pair_layer1_diagnostics.rst       | 39 +++++++++++++------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/diagnostic/twisted_pair_layer1_diagnostics.rst b/Documentation/networking/diagnostic/twisted_pair_layer1_diagnostics.rst
index c9be5cc7e113..079e17effadf 100644
--- a/Documentation/networking/diagnostic/twisted_pair_layer1_diagnostics.rst
+++ b/Documentation/networking/diagnostic/twisted_pair_layer1_diagnostics.rst
@@ -713,17 +713,23 @@ driver supports reporting such events.
 
 - **Monitor Error Counters**:
 
-  - While some NIC drivers and PHYs provide error counters, there is no unified
-    set of PHY-specific counters across all hardware. Additionally, not all
-    PHYs provide useful information related to errors like CRC errors, frame
-    drops, or link flaps. Therefore, this step is dependent on the specific
-    hardware and driver support.
-
-  - **Next Steps**: Use `ethtool -S <interface>` to check if your driver
-    provides useful error counters. In some cases, counters may provide
-    information about errors like link flaps or physical layer problems (e.g.,
-    excessive CRC errors), but results can vary significantly depending on the
-    PHY.
+  - Use `ethtool -S <interface> --all-groups` to retrieve standardized interface
+    statistics if the driver supports the unified interface:
+
+  - **Command:** `ethtool -S <interface> --all-groups`
+
+  - **Example Output (if supported)**:
+
+    .. code-block:: bash
+
+      phydev-RxFrames: 100391
+      phydev-RxErrors: 0
+      phydev-TxFrames: 9
+      phydev-TxErrors: 0
+
+  - If the unified interface is not supported, use `ethtool -S <interface>` to
+    retrieve MAC and PHY counters. Note that non-standardized PHY counter names
+    vary by driver and must be interpreted accordingly:
 
   - **Command:** `ethtool -S <interface>`
 
@@ -740,6 +746,17 @@ driver supports reporting such events.
     condition) or kernel log messages (e.g., link up/down events) to further
     diagnose the issue.
 
+  - **Compare Counters**:
+
+    - Compare the egress and ingress frame counts reported by the PHY and MAC.
+
+    - A small difference may occur due to sampling rate differences between the
+      MAC and PHY drivers, or if the PHY and MAC are not always fully
+      synchronized in their UP or DOWN states.
+
+    - Significant discrepancies indicate potential issues in the data path
+      between the MAC and PHY.
+
 When All Else Fails...
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.39.5


