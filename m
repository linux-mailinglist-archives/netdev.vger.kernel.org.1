Return-Path: <netdev+bounces-283917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM4wOsa6+Gnh0AIAu9opvQ
	(envelope-from <netdev+bounces-283917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:27:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A68A4C0A94
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8B3300D841
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A20E3DFC77;
	Mon,  4 May 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw8zFknh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E933F5BF
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908420; cv=none; b=uXzn0+qby73Dmw6NV4qK4EVcryvndT98V4TIItYlYuzbKaFR+bCkIAdJ6VgKnH2sVX0i+1LQL9uhZkePAH9itNN/vl2GpPU8tbUCxZMRUhVUF/UgZwCjhaLjvL4JjvFjhr9RlfPDOcQwZOv7FRa/mDSflHRtJGrLTPuPcEv0cto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908420; c=relaxed/simple;
	bh=fmHQpYB6QIOlPggxdxF5xuuPVox9ItejlLVycJ8p8wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tca0Gi+QgnZk8HKBb505yH3oS7bvEObzP//AS8oTV80nv90XVJOhrmBZ8t7diHjTOU/0/Qrj9h9OWMJ9gny3AVXg0k9LmHSgFVmxpxexjN6NUI6gfbhqJYMhgERoyuRryyVVDWr8VeUhbg9J7ZreipKbJ7wBBzkzo3JLrYhW6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw8zFknh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7762EC2BCB8;
	Mon,  4 May 2026 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908420;
	bh=fmHQpYB6QIOlPggxdxF5xuuPVox9ItejlLVycJ8p8wI=;
	h=From:To:Cc:Subject:Date:From;
	b=Dw8zFknhMWqTAM0kARlGNUbkrBQswMkF6fpHr+vb4rDXk3rDwdoUCFYYMCXnCBccc
	 P5R+R95hC11prLe+Sv16/D62AbeOqQYjyq0BVz0wM4GcYDbJjUQgwXL41qbxoDH2T4
	 09QaW/lBfUiK5FUbDjEldbIFuAEPFwUZRMac8pOQ59uo7kLg8JshfYsfVSB98knXk3
	 SFd51slTgfBp8bnx/ornjNW3C9o6nXWfAcb8VVplbGVYdp1kEJ/8CDcAuxkSgRFQgh
	 R1Zbnbb+/ZvYB8N82pshavseYGNWydHP6ZYOdYrsstWVDr9IEHfU7i0gF7Prs39hbb
	 YkYc7NaRCOCkQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH] net: dsa: mv88e6xxx: remove unused .port_max_speed_mode()
Date: Mon,  4 May 2026 17:26:53 +0200
Message-ID: <20260504152653.1389394-1-kabel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A68A4C0A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283917-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,waldekranz.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The .port_max_speed_mode() method is not used anymore since commit
40da0c32c3fc ("net: dsa: mv88e6xxx: remove handling for DSA and CPU ports").
Drop it.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  9 -------
 drivers/net/dsa/mv88e6xxx/chip.h |  4 ----
 drivers/net/dsa/mv88e6xxx/port.c | 40 --------------------------------
 drivers/net/dsa/mv88e6xxx/port.h |  9 -------
 4 files changed, 62 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8ca5fd40df92..c618abc75ebb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4434,7 +4434,6 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6341_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -4826,7 +4825,6 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -4886,7 +4884,6 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390x_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -4946,7 +4943,6 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
@@ -5110,7 +5106,6 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5278,7 +5273,6 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6341_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5499,7 +5493,6 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5564,7 +5557,6 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390x_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5627,7 +5619,6 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6393x_port_set_speed_duplex,
-	.port_max_speed_mode = mv88e6393x_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_policy = mv88e6393x_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 2b235ac2c5df..4339f6810535 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -585,10 +585,6 @@ struct mv88e6xxx_ops {
 	int (*port_set_speed_duplex)(struct mv88e6xxx_chip *chip, int port,
 				     int speed, int duplex);
 
-	/* What interface mode should be used for maximum speed? */
-	phy_interface_t (*port_max_speed_mode)(struct mv88e6xxx_chip *chip,
-					       int port);
-
 	int (*port_tag_remap)(struct mv88e6xxx_chip *chip, int port);
 
 	int (*port_set_policy)(struct mv88e6xxx_chip *chip, int port,
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 49cd82930b7a..74cfc0bb7b5b 100644
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
index a2492cf4d920..44b100dd618b 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -504,15 +504,6 @@ int mv88e6390x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
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
2.53.0


