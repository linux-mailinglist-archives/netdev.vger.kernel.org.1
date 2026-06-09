Return-Path: <netdev+bounces-297123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w90BFtc1KGrnAAMAu9opvQ
	(envelope-from <netdev+bounces-297123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:48:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B25661F8B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:48:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="WC0lU/wz";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297123-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297123-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDBFA31709C1
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3011416CF7;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB093914F5;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018889; cv=none; b=ttG2DO0VG9ARlh7aiafzTPkUTQyJAOXR8WlHD7F4+R40YOgWYrFnu87DKH5PHyxdJXmkVun2yZqwBUB4BmY1sRDzgh4bNxxfpzEinJXFlVWkjMtk6azXyrQ3e4ACJGEzOuE4AbcFEpsekubjzkiPIymbuRuXTnwVlQarhOoVZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018889; c=relaxed/simple;
	bh=EJvTQsvjjjNaFcdcwnwQokls0ZpoiT9ZxJ5UN2ouEwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JE94V4Gip4qef4VQGXjJZPxt6rwhRvwgc6oFWdlpkDu/mUGTKrMVyFEHmE8IRZGuZNGrV9BPDbKbWcREzhPdKPUNY6ZHD/nXbv19Tf8EKu0pOy7L6JhqLBM6j7u1020XUp5VNeI9LdkBFZ5RRHPkhXOj0/cr4UOZEMFSlhN1VZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC0lU/wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45065C4AF0F;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781018889;
	bh=EJvTQsvjjjNaFcdcwnwQokls0ZpoiT9ZxJ5UN2ouEwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WC0lU/wzRrKBwyTkL/l2eCBX55+bNrrGq5jZWekIBqCNsVJ44b5f+4oDFh900UUZF
	 Cg/HaoaMxtasI6pQJshdPaYOS1qoJKkRH6gLnU54cvWTQ8yqsuCoDi9YU6WeNhfUtn
	 YQAj3oJkJRtsBTHclZpVcLoXnmTVYi822uuvYExlM7VxlzkeuLDI5GYniwwRs/PC69
	 tQYP+iUaMxbrCAMntoKQ0NjKW+2nKSS0R7u7zEftZ/grb56P/TJDre3jzj88blAjPh
	 7ZVzhFPDK97J8COMtrontG+Pu6h2Gj24PvyBZP62t+THI0m80q8yF3fkp1+YiIV7Xw
	 VHg35J1Mb3vuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5F2CD8CAA;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 18:28:02 +0300
Subject: [PATCH net-next v4 03/13] net: ethernet: oa_tc6: add
 OA_TC6_BROKEN_PHY quirk flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-adin1140-driver-v4-3-0753e28ee004@analog.com>
References: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
In-Reply-To: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781018886; l=5144;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=9TsRGTlIZdU2gO/bs2rZ+BFMFrMlFoFo6knK+fY1b6I=;
 b=yMgeMqIJp7pvAfeWimJ+QZjk8P4MkSO7wwFSlyX1EVn5v9VZTd/3lgz5cNDRcl0aahB76JT5s
 o15u2nG0TKVCGpgWczLqDO7qXMiqLcvOGWOICAbmLUHMsf9XZxjM/+O
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297123-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:email,analog.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07B25661F8B

From: Ciprian Regus <ciprian.regus@analog.com>

Some MAC-PHY devices need custom MDIO bus access functions to work
around hardware issues. Add the OA_TC6_BROKEN_PHY quirk flag so drivers
can opt in to skip oa_tc6's internal PHY init and manage the PHY
themselves. When the flag is set, oa_tc6 skips MDIO bus registration,
PHY discovery and PHY connection, leaving these to the driver.

Drivers that do not set the flag retain the existing behavior. Update
lan865x and the framework documentation accordingly.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v4 changelog:
 - no change
v3 changelog:
 - add the oa_tc6_quirks struct to the oa_tc6_init() parameters (along
   the spi_device and net_device), instead of adding everything in a
   single struct.
v2 changelog:
 - Added the quirk flag field in the oa_tc6_config struct and a first
   value entry (OA_TC6_BROKEN_PHY) instead of the mii_bus struct.
---
 Documentation/networking/oa-tc6-framework.rst    |  3 ++-
 drivers/net/ethernet/microchip/lan865x/lan865x.c |  2 +-
 drivers/net/ethernet/oa_tc6.c                    | 14 +++++++++++++-
 include/linux/oa_tc6.h                           | 11 ++++++++++-
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
index fe2aabde923a..013824078cea 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -454,7 +454,8 @@ Device drivers API
 The include/linux/oa_tc6.h defines the following functions:
 
 .. c:function:: struct oa_tc6 *oa_tc6_init(struct spi_device *spi, \
-                                           struct net_device *netdev)
+                                           struct net_device *netdev, \
+                                           struct oa_tc6_quirks *quirks)
 
 Initialize OA TC6 lib.
 
diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 0277d9737369..26a2761332a5 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -346,7 +346,7 @@ static int lan865x_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, priv);
 	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
 
-	priv->tc6 = oa_tc6_init(spi, netdev);
+	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
 	if (!priv->tc6) {
 		ret = -ENODEV;
 		goto free_netdev;
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index baba5aad84df..2a72f0c4b009 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -134,6 +134,7 @@ struct oa_tc6 {
 	bool rx_buf_overflow;
 	bool int_flag;
 	bool prot_ctrl;
+	enum oa_tc6_quirk_flag quirk_flags;
 };
 
 enum oa_tc6_header_type {
@@ -580,6 +581,9 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 {
 	int ret;
 
+	if (tc6->quirk_flags & OA_TC6_BROKEN_PHY)
+		return 0;
+
 	ret = oa_tc6_check_phy_reg_direct_access_capability(tc6);
 	if (ret) {
 		netdev_err(tc6->netdev,
@@ -616,6 +620,9 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 
 static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
 {
+	if (tc6->quirk_flags & OA_TC6_BROKEN_PHY)
+		return;
+
 	phy_disconnect(tc6->phydev);
 	oa_tc6_mdiobus_unregister(tc6);
 }
@@ -1279,11 +1286,13 @@ static int oa_tc6_check_ctrl_protection(struct oa_tc6 *tc6)
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
  * @netdev: network device interface structure.
+ * @quirks: device specific modifiers for the OA TC6 protocol.
  *
  * Return: pointer reference to the oa_tc6 structure if the MAC-PHY
  * initialization is successful otherwise NULL.
  */
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
+			   struct oa_tc6_quirks *quirks)
 {
 	struct oa_tc6 *tc6;
 	int ret;
@@ -1298,6 +1307,9 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	mutex_init(&tc6->spi_ctrl_lock);
 	spin_lock_init(&tc6->tx_skb_lock);
 
+	if (quirks)
+		tc6->quirk_flags = quirks->quirk_flags;
+
 	/* Set the SPI controller to pump at realtime priority */
 	tc6->spi->rt = true;
 	if (spi_setup(tc6->spi) < 0)
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 15f58e3c56c7..62e3d89f80ed 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -12,7 +12,16 @@
 
 struct oa_tc6;
 
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev);
+enum oa_tc6_quirk_flag {
+	OA_TC6_BROKEN_PHY = BIT(0),
+};
+
+struct oa_tc6_quirks {
+	enum oa_tc6_quirk_flag quirk_flags;
+};
+
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
+			   struct oa_tc6_quirks *quirks);
 void oa_tc6_exit(struct oa_tc6 *tc6);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value);
 int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address, u32 value[],

-- 
2.43.0



