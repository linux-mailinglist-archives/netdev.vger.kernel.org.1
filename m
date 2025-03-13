Return-Path: <netdev+bounces-174582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F91DA5F624
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D026817F061
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1814267B0A;
	Thu, 13 Mar 2025 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUU8TSrz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE10267B07
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873314; cv=none; b=ELa1QlyXH7C1/N9hioHQ+Sekqjp7KZZKopDv96rYms6cenQFEcfRyKAg1IEvyD+mDgB/tbJpdvCIU6xY0u0oLKshKxljXRWHwTP9UUsK8n4szOg6n4SpPbHM4KcXoAM1c+XsyIxgLrV6XOi3EwokM2bq0n89JjXle3wBW9NcAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873314; c=relaxed/simple;
	bh=BT5lWfMUTQOri9i/NI4YDR2vsj5kuck14Vz4RMGG7p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBBTVGbDg4Ytf7WqiWFr8KKZYYUS3UAyX0JFx1kPbza+ALTC5+8Hzb+TlJOvB8AyFU381ZSRB5vcebAf7ySPGC+Lr75wns0AiAxZrP3zM5NyBDXe3ODL0DGa4ZD25AGj/HCDKDTCscO5m4Z20nyzoTmCknpOti+vMc5V70wvLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUU8TSrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F9BC4CEE5;
	Thu, 13 Mar 2025 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873313;
	bh=BT5lWfMUTQOri9i/NI4YDR2vsj5kuck14Vz4RMGG7p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUU8TSrzhbdLbR1r2ZOWtwDlQSeO17H7KWhwzCyS8X2U5nDSw5CSBHNOuwpms+yjJ
	 SflgaOKrdZ5JOk4iky8kn22hH7PNl2hlJUNRKH+b8mje3TCWiKX0Iogvczthg/tr+L
	 vniSX7Q+rpOduYn76TTE9fhNjmNgiO6kSWzWO+FrCHVqBdP9wKfyrWnwsWheskbMAG
	 LrcK6p+EJzfIFq3Ol//I4HwJYHFPiLbQuSa2rlAUxLyVsGYsgcxHYsO7M/mb3yn+UB
	 w1Gmwv7habrUrCeNxDzhGNcQjoMnlgJeBmiuiRg1T3Yz6+5p/K2AQZdR4WMUFd84i6
	 itqyq5NhsnX5Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 01/13] net: dsa: mv88e6xxx: remove unused .port_max_speed_mode()
Date: Thu, 13 Mar 2025 14:41:34 +0100
Message-ID: <20250313134146.27087-2-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313134146.27087-1-kabel@kernel.org>
References: <20250313134146.27087-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The .port_max_speed_mode() method is not used anymore since commit
40da0c32c3fc ("net: dsa: mv88e6xxx: remove handling for DSA and CPU ports").
Drop it.

Fixes: 40da0c32c3fc ("net: dsa: mv88e6xxx: remove handling for DSA and CPU ports")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  9 -------
 drivers/net/dsa/mv88e6xxx/chip.h |  4 ----
 drivers/net/dsa/mv88e6xxx/port.c | 40 --------------------------------
 drivers/net/dsa/mv88e6xxx/port.h |  9 -------
 4 files changed, 62 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5db96ca52505..99d8d438e465 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4404,7 +4404,6 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6341_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -4797,7 +4796,6 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -4857,7 +4855,6 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390x_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -4917,7 +4914,6 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
@@ -5082,7 +5078,6 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5241,7 +5236,6 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6341_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5463,7 +5457,6 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5527,7 +5520,6 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390x_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5590,7 +5582,6 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6393x_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6393x_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6393x_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 86bf113c9bfa..07671d9fe0c3 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -551,10 +551,6 @@ struct mv88e6xxx_ops {
 	int (*port_set_speed_duplex)(struct mv88e6xxx_chip *chip, int port,
 				     int speed, int duplex);
 
-	/* What interface mode should be used for maximum speed? */
-	phy_interface_t (*port_max_speed_mode)(struct mv88e6xxx_chip *chip,
-					       int port);
-
 	int (*port_tag_remap)(struct mv88e6xxx_chip *chip, int port);
 
 	int (*port_set_policy)(struct mv88e6xxx_chip *chip, int port,
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 66b1b7277281..d7a6d12aadbf 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -344,15 +344,6 @@ int mv88e6341_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 					       duplex);
 }
 
-phy_interface_t mv88e6341_port_max_speed_mode(struct mv88e6xxx_chip *chip,
-					      int port)
-{
-	if (port == 5)
-		return PHY_INTERFACE_MODE_2500BASEX;
-
-	return PHY_INTERFACE_MODE_NA;
-}
-
 /* Support 10, 100, 200, 1000 Mbps (e.g. 88E6352 family) */
 int mv88e6352_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex)
@@ -384,15 +375,6 @@ int mv88e6390_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 					       duplex);
 }
 
-phy_interface_t mv88e6390_port_max_speed_mode(struct mv88e6xxx_chip *chip,
-					      int port)
-{
-	if (port == 9 || port == 10)
-		return PHY_INTERFACE_MODE_2500BASEX;
-
-	return PHY_INTERFACE_MODE_NA;
-}
-
 /* Support 10, 100, 200, 1000, 2500, 10000 Mbps (e.g. 88E6190X) */
 int mv88e6390x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				     int speed, int duplex)
@@ -407,15 +389,6 @@ int mv88e6390x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 					       duplex);
 }
 
-phy_interface_t mv88e6390x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
-					       int port)
-{
-	if (port == 9 || port == 10)
-		return PHY_INTERFACE_MODE_XAUI;
-
-	return PHY_INTERFACE_MODE_NA;
-}
-
 /* Support 10, 100, 200, 1000, 2500, 5000, 10000 Mbps (e.g. 88E6393X)
  * Function mv88e6xxx_port_set_speed_duplex() can't be used as the register
  * values for speeds 2500 & 5000 conflict.
@@ -509,19 +482,6 @@ int mv88e6393x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 	return 0;
 }
 
-phy_interface_t mv88e6393x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
-					       int port)
-{
-
-	if (port != 0 && port != 9 && port != 10)
-		return PHY_INTERFACE_MODE_NA;
-
-	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6361)
-		return PHY_INTERFACE_MODE_2500BASEX;
-
-	return PHY_INTERFACE_MODE_10GBASER;
-}
-
 static int mv88e6xxx_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 				    phy_interface_t mode, bool force)
 {
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index c1d2f99efb1c..d662b09bf481 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -501,15 +501,6 @@ int mv88e6390x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 int mv88e6393x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				     int speed, int duplex);
 
-phy_interface_t mv88e6341_port_max_speed_mode(struct mv88e6xxx_chip *chip,
-					      int port);
-phy_interface_t mv88e6390_port_max_speed_mode(struct mv88e6xxx_chip *chip,
-					      int port);
-phy_interface_t mv88e6390x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
-					       int port);
-phy_interface_t mv88e6393x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
-					       int port);
-
 int mv88e6xxx_port_set_state(struct mv88e6xxx_chip *chip, int port, u8 state);
 
 int mv88e6xxx_port_set_vlan_map(struct mv88e6xxx_chip *chip, int port, u16 map);
-- 
2.48.1


