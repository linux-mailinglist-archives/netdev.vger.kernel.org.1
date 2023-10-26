Return-Path: <netdev+bounces-44382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D57D7C0B
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D29281E92
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 05:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7331CC2D9;
	Thu, 26 Oct 2023 05:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E0C8E1
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 05:11:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE4318C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:11:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qvsdy-0004Y9-Oc; Thu, 26 Oct 2023 07:10:54 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qvsdw-004L1R-MZ; Thu, 26 Oct 2023 07:10:52 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qvsdw-009ikn-21;
	Thu, 26 Oct 2023 07:10:52 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v8 2/5] net: dsa: microchip: Refactor comment for ksz_switch_macaddr_get() function
Date: Thu, 26 Oct 2023 07:10:48 +0200
Message-Id: <20231026051051.2316937-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026051051.2316937-1-o.rempel@pengutronix.de>
References: <20231026051051.2316937-1-o.rempel@pengutronix.de>
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

Update the comment to follow kernel-doc format.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 8244204e177d..0c3adc389d0b 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3617,12 +3617,20 @@ bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port)
 	return true;
 }
 
-/* Program the switch's MAC address register with the MAC address of the
- * requesting user port. This single address is used by the switch for multiple
- * features, like HSR self-address filtering and WoL. Other user ports are
- * allowed to share ownership of this address as long as their MAC address is
- * the same. The user ports' MAC addresses must not change while they have
- * ownership of the switch MAC address.
+/**
+ * ksz_switch_macaddr_get - Program the switch's MAC address register.
+ * @ds: DSA switch instance.
+ * @port: Port number.
+ * @extack: Netlink extended acknowledgment.
+ *
+ * This function programs the switch's MAC address register with the MAC address
+ * of the requesting user port. This single address is used by the switch for
+ * multiple features like HSR self-address filtering and WoL. Other user ports
+ * can share ownership of this address as long as their MAC address is the same.
+ * The MAC addresses of user ports must not change while they have ownership of
+ * the switch MAC address.
+ *
+ * Return: 0 on success, or other error codes on failure.
  */
 int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 			   struct netlink_ext_ack *extack)
-- 
2.39.2


