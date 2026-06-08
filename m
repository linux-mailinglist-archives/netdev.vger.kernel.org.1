Return-Path: <netdev+bounces-296595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lNjxEDfQJmrnkwIAu9opvQ
	(envelope-from <netdev+bounces-296595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:22:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFD6571D1
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:22:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=OT7EPH7c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296595-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296595-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02850314F887
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099393D1CC6;
	Mon,  8 Jun 2026 14:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977003D0BFB;
	Mon,  8 Jun 2026 14:10:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927828; cv=none; b=oTdvY6Er7MXzQ0OwcNLAEaocM6hRzUyIOrTuDHvwZ0gv2yXYnxAH2SyGa0CYHP03tFpDT1I24vacQNXe8owGJ7ZvrE2gp0qkVCzk0Fj8XOCEB/yfGCmmjLEwB4wE88Cm7z6THC0wfpLc6uGfeCTxJ8ulo2XTbJhQX47ATmtoFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927828; c=relaxed/simple;
	bh=MAgf7vq6Z0Wq6cX28QGN7dC/EHWKnTUsoIZrmr14QdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KK74CQPhH4qf93SAUKH0I1FbDYZRx+tIUIO7s/85RKX+0z8XT0wbCxNv6LULGckiGJJV1f0WJEsqF8/EB+wUKbVdYoHpiskTC1aX1+J1ODTWA1KaopBmR9ZGH+7zpdURcQL5Gp5KXnHyZZJhW4b0InYfSRi7bxoGxJyZoeql1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OT7EPH7c; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7E32B1A37D5;
	Mon,  8 Jun 2026 14:10:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5154F5FFB7;
	Mon,  8 Jun 2026 14:10:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03144106A2941;
	Mon,  8 Jun 2026 16:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927825; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L8JKEMuqeLOLXD7sRAPR2ArzrkLzIQkNq/JilyTl52M=;
	b=OT7EPH7crpCGFRMK4PuLsuiwkEa6sXjfr/WGLis3Z6uaZ+Fk1jb9fv9Rwsx2bDvLUd+XCT
	xgjyDgAs/yxtxyJI3eey/+E36erYaseC9PrUCkikWGDFmVPmii1D+xtIlURNFgUBcnvw/E
	AuApgzdpye2wS2k4Y196meCcwIuOvDeWlDfkB0AyHPHWhQy6TYWqNGQwnXGzVNd2XQJkfF
	YOurRgWY2EIi+27pswW/MBmLN4KmbLQ0cX35Q7AZJDetnY3aLAmiPxGpyGi2+LXXd3Oi4i
	fWuCjDy9CDNgPDlrBBesdYd8nYjxcteI8T6CWiEMOqB3mF8QtixtKLpkUvq4XA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 16:10:08 +0200
Subject: [PATCH net-next v2 05/10] net: dsa: microchip: remove
 setup_rgmii_delay() KSZ operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-clean-ksz-3rd-v2-5-6e61b7be23c4@bootlin.com>
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
In-Reply-To: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBBFD6571D1

setup_rgmii_delay() operation is only used once during the common phylink
MAC configuration. Only the lan937x switch implements this
setup_rgmii_delay().

Remove the setup_rgmii_delay operation from ksz_dev_ops.
Implement a lan937x-specific phylink MAC configuration that does this
RGMII delay setup.
Export ksz_set_xmii since it's needed by the lan937x implementation.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c   |  9 ++-------
 drivers/net/dsa/microchip/ksz_common.h   |  2 +-
 drivers/net/dsa/microchip/lan937x_main.c | 17 +++++++++++++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f29287922843..33a20c2e0a8a 100644
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
@@ -3242,12 +3241,8 @@ void ksz_phylink_mac_config(struct phylink_config *config,
 	struct ksz_device *dev = dp->ds->priv;
 	int port = dp->index;
 
-	if (ksz_phylink_need_config(config, mode)) {
+	if (ksz_phylink_need_config(config, mode))
 		ksz_set_xmii(dev, port, state->interface);
-
-		if (dev->dev_ops->setup_rgmii_delay)
-			dev->dev_ops->setup_rgmii_delay(dev, port);
-	}
 }
 
 bool ksz_get_gbit(struct ksz_device *dev, int port)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c377bd3e5542..ef8eb10fde50 100644
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
 bool ksz_phylink_need_config(struct phylink_config *config, unsigned int mode);
 void ksz_phylink_mac_config(struct phylink_config *config,
 			    unsigned int mode,
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 57e289637193..69df378a40bf 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -643,6 +643,20 @@ static void lan937x_setup_rgmii_delay(struct ksz_device *dev, int port)
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
+	if (ksz_phylink_need_config(config, mode)) {
+		ksz_set_xmii(dev, port, state->interface);
+		lan937x_setup_rgmii_delay(dev, port);
+	}
+}
+
 static int lan937x_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
 {
 	return ksz_pwrite32(dev, port, REG_PORT_MTI_CREDIT_INCREMENT, val);
@@ -821,7 +835,7 @@ static int lan937x_connect_tag_protocol(struct dsa_switch *ds,
 }
 
 const struct phylink_mac_ops lan937x_phylink_mac_ops = {
-	.mac_config	= ksz_phylink_mac_config,
+	.mac_config	= lan937x_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz9477_phylink_mac_link_up,
 	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
@@ -838,7 +852,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
-	.setup_rgmii_delay = lan937x_setup_rgmii_delay,
 	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
 	.init = lan937x_switch_init,
 };

-- 
2.54.0


