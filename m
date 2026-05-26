Return-Path: <netdev+bounces-291626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBkOLqptFWojVAcAu9opvQ
	(envelope-from <netdev+bounces-291626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:53:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B77685D3BDE
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7946B30583F7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F045A3DD514;
	Tue, 26 May 2026 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I6n9GHtZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DD3DB658;
	Tue, 26 May 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788873; cv=none; b=Nxnh4YfcaSy+nrhAWkenrcZ04HcHGt7r0PXvm6wEAk4P8pnjdkZxB73LeWx46ZfH2Hn8PsdjYFePy/9HCh9EqVEvow3LvmwDxpGaQYAkPjmHgvNfjhT4FpSD4SRywu2UctySb1Yq/lk/hI9UTra/Z8OPCwpWyS2u3GjG5w6zkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788873; c=relaxed/simple;
	bh=vgv+HBrXp8+fLCMfSEFfB3zZxws4BkQdT6goxXUHjy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXwJ7hRHmT8lsyOatGUB2bWxeusWJM/E86DUOPLQ1nkSDB3Lniv25RKtPRS4HpZ6sza7sUDpNKCw4+2SxmRsIjzmTyXASCXk1YzcRc0xApI0jH0xFrdMSw3NGihFXZS1s7AEjDxGGeoqMHriIqmmLgQQAcNMMMzq3Ay3te3Wghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I6n9GHtZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 783B11A36D8;
	Tue, 26 May 2026 09:47:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B67960732;
	Tue, 26 May 2026 09:47:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1D0710888582;
	Tue, 26 May 2026 11:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788869; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dKO1xS8jIVdj/J9VfLrYaDU87m2Qrkpv+lORKi93T+I=;
	b=I6n9GHtZLGQPhmDRt/C/lSPl3dAycqTN0YAGZs5L/eM/h+g5F8zPSD0ElT0E+i6B8kt4bw
	obqzDsbGXBPxhhmNPDZjyqERuBIhWWUTr+ANe1RffGxDB4HCTZH6U+0zexms8kLWgg3G6b
	WGkdan+ZJLukPx2j/fmViM2F6JRmMcFni8n044Vbbv5ATugVipNqtzDj2ytiRzPWcxATqs
	e6T5P32wptVyOrKMPdh3NUc8oyLEIiShhemuYs/CI6/wT9gFwjWljvC6xF6K6PbeXtWahr
	rwzLxQM+3aPzAiFV6hKtBsQe0Y28+WPQNq0w/ugnLxlf5WEh6xxzDzmPdUGQ+A==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 11:47:31 +0200
Subject: [PATCH net-next 5/9] net: dsa: microchip: implement .support_eee()
 only if needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-clean-ksz-3rd-v1-5-5b63e732149a@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291626-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: B77685D3BDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The .support_eee() operation is optional. Yet, it is implemented by the
KSZ switches through a common functon that reports false for every chip
except for KSZ8563, KSZ9563 and KSZ9893 from the KSZ9477 family.

Remove the implementation from the switches that don't support EEE.
Implement instead a ksz9477-specific suppor_eee for these three supported
switches.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  3 --
 drivers/net/dsa/microchip/ksz9477.c      | 50 +++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.c   | 57 --------------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  1 -
 drivers/net/dsa/microchip/lan937x_main.c |  1 -
 5 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 98cf7239057d..f297aa03f42a 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2477,7 +2477,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
@@ -2534,7 +2533,6 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
@@ -2592,7 +2590,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index a39541d29ad5..e0b3724a7558 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1909,6 +1909,54 @@ void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 	ksz9477_duplex_flowctrl(dev, port, duplex, tx_pause, rx_pause);
 }
 
+/**
+ * ksz9477_support_eee - Determine Energy Efficient Ethernet (EEE) support for a
+ *                       port
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number to check
+ *
+ * This function also documents devices where EEE was initially advertised but
+ * later withdrawn due to reliability issues, as described in official errata
+ * documents. These devices are explicitly listed to record known limitations,
+ * even if there is no technical necessity for runtime checks.
+ *
+ * Returns: true if the internal PHY on the given port supports fully
+ * operational EEE, false otherwise.
+ */
+static bool ksz9477_support_eee(struct dsa_switch *ds, int port)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (!dev->info->internal_phy[port])
+		return false;
+
+	switch (dev->chip_id) {
+	case KSZ8563_CHIP_ID:
+	case KSZ9563_CHIP_ID:
+	case KSZ9893_CHIP_ID:
+		return true;
+	default:
+		/* KSZ8567R Errata DS80000752C Module 4 */
+		/* KSZ9477S Errata DS80000754A Module 4 */
+		/* KSZ9567S Errata DS80000756A Module 4 */
+		/* KSZ9896C Errata DS80000757A Module 3 */
+		/* KSZ9897R Errata DS80000758C Module 4 */
+		/* Energy Efficient Ethernet (EEE) feature select must be
+		 * manually disabled
+		 *   The EEE feature is enabled by default, but it is not fully
+		 *   operational. It must be manually disabled through register
+		 *   controls. If not disabled, the PHY ports can auto-negotiate
+		 *   to enable EEE, and this feature can cause link drops when
+		 *   linked to another device supporting EEE.
+		 *
+		 * The same item appears in the errata for all switches above.
+		 */
+		break;
+	}
+
+	return false;
+}
+
 static struct phylink_pcs *
 ksz9477_phylink_mac_select_pcs(struct phylink_config *config,
 			       phy_interface_t interface)
@@ -1998,7 +2046,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.cls_flower_add		= ksz9477_cls_flower_add,
 	.cls_flower_del		= ksz9477_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
+	.support_eee		= ksz9477_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d6511fcebcf2..475886b8c255 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3052,63 +3052,6 @@ int ksz_max_mtu(struct dsa_switch *ds, int port)
 	return -EOPNOTSUPP;
 }
 
-/**
- * ksz_support_eee - Determine Energy Efficient Ethernet (EEE) support for a
- *                   port
- * @ds: Pointer to the DSA switch structure
- * @port: Port number to check
- *
- * This function also documents devices where EEE was initially advertised but
- * later withdrawn due to reliability issues, as described in official errata
- * documents. These devices are explicitly listed to record known limitations,
- * even if there is no technical necessity for runtime checks.
- *
- * Returns: true if the internal PHY on the given port supports fully
- * operational EEE, false otherwise.
- */
-bool ksz_support_eee(struct dsa_switch *ds, int port)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->info->internal_phy[port])
-		return false;
-
-	switch (dev->chip_id) {
-	case KSZ8563_CHIP_ID:
-	case KSZ9563_CHIP_ID:
-	case KSZ9893_CHIP_ID:
-		return true;
-	case KSZ8567_CHIP_ID:
-		/* KSZ8567R Errata DS80000752C Module 4 */
-	case KSZ8765_CHIP_ID:
-	case KSZ8794_CHIP_ID:
-	case KSZ8795_CHIP_ID:
-		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
-	case KSZ9477_CHIP_ID:
-		/* KSZ9477S Errata DS80000754A Module 4 */
-	case KSZ9567_CHIP_ID:
-		/* KSZ9567S Errata DS80000756A Module 4 */
-	case KSZ9896_CHIP_ID:
-		/* KSZ9896C Errata DS80000757A Module 3 */
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		/* KSZ9897R Errata DS80000758C Module 4 */
-		/* Energy Efficient Ethernet (EEE) feature select must be
-		 * manually disabled
-		 *   The EEE feature is enabled by default, but it is not fully
-		 *   operational. It must be manually disabled through register
-		 *   controls. If not disabled, the PHY ports can auto-negotiate
-		 *   to enable EEE, and this feature can cause link drops when
-		 *   linked to another device supporting EEE.
-		 *
-		 * The same item appears in the errata for all switches above.
-		 */
-		break;
-	}
-
-	return false;
-}
-
 int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 		    struct ethtool_keee *e)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index ab08c98ed257..33cb2c44004b 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -477,7 +477,6 @@ void ksz_phylink_mac_link_down(struct phylink_config *config,
 
 int ksz_max_mtu(struct dsa_switch *ds, int port);
 
-bool ksz_support_eee(struct dsa_switch *ds, int port);
 int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 		    struct ethtool_keee *e);
 
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index f8f220242f7a..4cbbcf7993c9 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -915,7 +915,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,

-- 
2.54.0


