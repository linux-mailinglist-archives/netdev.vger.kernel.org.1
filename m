Return-Path: <netdev+bounces-291628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNyFHVBtFWoIVAcAu9opvQ
	(envelope-from <netdev+bounces-291628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:52:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183545D3B85
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9605930474DC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DE23DE451;
	Tue, 26 May 2026 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L/pAI8Oz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04473DD872
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788877; cv=none; b=Z2anBgNXWHDQ0oiru/UHNm4yvHea4g66VQSIKeVjrJx7XAJ8nlxt/UrCHWnJV2HA8KD7mtTHqXOSVDb9XPg1Mq6JymyFHocLtnsrr98J9akWe8LeIcOytt2dZ1KBM0ajqwGJYkxVcc4HZrzgczt9xyNslKaizwnSXolfVZVqVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788877; c=relaxed/simple;
	bh=VTK07zuWvuXLGuNFl/CVuX9HM50QZx01yYMzA7qKsuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piAw1wFuvFWm4BsKkDST6gNlhrc+fFLjuyP3ZiWkaMdIDEeVvs9kpx3L9E2C4yFI+2eFd7kK9mZXESicREHt59vc69LO+9fmD2anF2MH2ozwkVXZay2CfbynvoJZ7nqHq+dqfnRx4wXDP3ATZFqlp/Bs4Gbqp+c1CmNkcfC2LsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L/pAI8Oz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CAFF54E42D0E;
	Tue, 26 May 2026 09:47:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9784D60732;
	Tue, 26 May 2026 09:47:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76B0D1088858A;
	Tue, 26 May 2026 11:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788867; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=W5I520zCD5y1iYXl8IK7VlXE/m8EK+QkgDqIt4zWqBM=;
	b=L/pAI8OzTo7HwejTjTMFEPYGV3qJM2tvvhTTIqPDIUl3utJCdGoT3GtaDwACzLHHlWJSTX
	3Vln8X/AexS+7nV6URajjlLcpmCkTwwKAURmmYnpV1GUnXWATs7VA6i1b+3EnPvSQpIeLZ
	cWdrX0/TKT48BFlSFZXhlnh5a9rUFD2SrNMRBLlTdiFTlYmU8S8nZhRlx8q4bWjjfX/sAO
	Sr5ImMzFZ5eWIILMvxvOjKZqbjBHGG1WB8Kw3f+HLNSwJDkkot51JvTy3nEOXXsNynvcGX
	HwPz57R0a3HAvuZlExIOtBrEXJ24tHqd8cZ93mVtteIQQeEyI/3VN4H/PY8pBg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 11:47:30 +0200
Subject: [PATCH net-next 4/9] net: dsa: microchip: remove
 setup_rgmii_delay() KSZ operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-clean-ksz-3rd-v1-4-5b63e732149a@bootlin.com>
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
In-Reply-To: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291628-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 183545D3B85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

setup_rgmii_delay() operation is only used once during the common phylink
MAC configuration. Only the lan937x switch implements this
setup_rgmii_delay().

Remove the setup_rgmii_delay operation from ksz_dev_ops.
Implement a lan937x-specific phylink MAC configuration that does this
RGMII delay setup.
Export ksz_set_xmii since it's needed by the lan937x implementation.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c   |  6 +-----
 drivers/net/dsa/microchip/ksz_common.h   |  2 +-
 drivers/net/dsa/microchip/lan937x_main.c | 29 +++++++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 5fb151fbf4f3..d6511fcebcf2 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3127,8 +3127,7 @@ int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static void ksz_set_xmii(struct ksz_device *dev, int port,
-			 phy_interface_t interface)
+void ksz_set_xmii(struct ksz_device *dev, int port, phy_interface_t interface)
 {
 	const u8 *bitval = dev->info->xmii_ctrl1;
 	struct ksz_port *p = &dev->ports[port];
@@ -3233,9 +3232,6 @@ void ksz_phylink_mac_config(struct phylink_config *config,
 	}
 
 	ksz_set_xmii(dev, port, state->interface);
-
-	if (dev->dev_ops->setup_rgmii_delay)
-		dev->dev_ops->setup_rgmii_delay(dev, port);
 }
 
 bool ksz_get_gbit(struct ksz_device *dev, int port)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 804912fdd2db..ab08c98ed257 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -410,7 +410,6 @@ struct ksz_dev_ops {
 			   u8 data);
 	void (*freeze_mib)(struct ksz_device *dev, int port, bool freeze);
 	void (*port_init_cnt)(struct ksz_device *dev, int port);
-	void (*setup_rgmii_delay)(struct ksz_device *dev, int port);
 	int (*tc_cbs_set_cinc)(struct ksz_device *dev, int port, u32 val);
 	int (*init)(struct ksz_device *dev);
 };
@@ -468,6 +467,7 @@ void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config);
 int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
 				  u32 timer, bool tx_clock_stop);
+void ksz_set_xmii(struct ksz_device *dev, int port, phy_interface_t interface);
 void ksz_phylink_mac_config(struct phylink_config *config,
 			    unsigned int mode,
 			    const struct phylink_link_state *state);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 57e289637193..f8f220242f7a 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -643,6 +643,32 @@ static void lan937x_setup_rgmii_delay(struct ksz_device *dev, int port)
 	}
 }
 
+static void lan937x_phylink_mac_config(struct phylink_config *config,
+				       unsigned int mode,
+				       const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	int port = dp->index;
+
+	/* Internal PHYs */
+	if (dev->info->internal_phy[port])
+		return;
+
+	/* No need to configure XMII control register when using SGMII. */
+	if (ksz_is_sgmii_port(dev, port))
+		return;
+
+	if (phylink_autoneg_inband(mode)) {
+		dev_err(dev->dev, "In-band AN not supported!\n");
+		return;
+	}
+
+	ksz_set_xmii(dev, port, state->interface);
+
+	lan937x_setup_rgmii_delay(dev, port);
+}
+
 static int lan937x_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
 {
 	return ksz_pwrite32(dev, port, REG_PORT_MTI_CREDIT_INCREMENT, val);
@@ -821,7 +847,7 @@ static int lan937x_connect_tag_protocol(struct dsa_switch *ds,
 }
 
 const struct phylink_mac_ops lan937x_phylink_mac_ops = {
-	.mac_config	= ksz_phylink_mac_config,
+	.mac_config	= lan937x_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz9477_phylink_mac_link_up,
 	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
@@ -838,7 +864,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
-	.setup_rgmii_delay = lan937x_setup_rgmii_delay,
 	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
 	.init = lan937x_switch_init,
 };

-- 
2.54.0


