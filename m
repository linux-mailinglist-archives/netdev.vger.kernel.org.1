Return-Path: <netdev+bounces-290242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK/cAcKiDmpCAwYAu9opvQ
	(envelope-from <netdev+bounces-290242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:14:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B859F55E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5EAA3044B98
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31E639282B;
	Thu, 21 May 2026 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KR1p5BDX"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA23783BB
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343970; cv=none; b=PjGaCodVha/eZpdHD54CFE5mY1qokKgF1y/HgZOX9DnpuUolXf7QqsJ9CI+vDKFdFDIbrJw9De7wgIxlJiF42CkL/CMm2cRankMBPgTCrQgF+/IvncYjnxOUIoLRdrQIPsTW1cwSXduFV7qY3+rN6P2eiTFrDLsvjCaFIkPrh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343970; c=relaxed/simple;
	bh=ZyHqgUUbaGBpEzIbSDJO60Y9NW5NbPWwaXLD7lFlaGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPKRaPaAMvFMVt8YoiZGcoG4JuKdC4BXbYEvV2s4z8VcUsyGCcoFO2FC2ARDZGoNMlNZCXeQFWsZ32Qnia1/cj0c2ghur/vXVmi5ekgo7DP0CW0fEerA1E2goynl7HgvkvpeSsQqSMFe8HqHIDfwVmj/2jrvrw8YBdahZ6afXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KR1p5BDX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9A2B7C2C64E;
	Thu, 21 May 2026 06:13:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9C64360718;
	Thu, 21 May 2026 06:12:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45CD9107EA6B7;
	Thu, 21 May 2026 08:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779343966; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hSyXQPdeEcJyfgWN1LkTnOQpvEunR5kMnuz5yyCH/+U=;
	b=KR1p5BDXGfe1lk7KxyFqP92JUqUh5r1h/ar8R6u3Lk9X5U7hfFNvAlX5vPN0zqlV06o+yQ
	j1sOXOX/zJg7d3Zq3fcUWXvohOn7COCJNVc1DWXmP/DWU/2KVUAk/Z0NBTn0KX6eK579UA
	Cwq8VyTqbpci3Taby2Q//hrrpP9oIgmGLfsvhQLrE8+tP/ZvH9EZfwtdXLywILuFTbb0wJ
	RFusXDFgjWkRMnG3iROkyEFr6+QCy0uiIFJnIcR0aLiaMr7eK9KplwwTfwdhL8x9AXj894
	j6cBKi3x874+2Z5SpGHRfq75z8J8ABCmf8UNhH59iK/FdS7nVG4Ljlsvn1Br2A==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 21 May 2026 08:12:36 +0200
Subject: [PATCH net-next v3 1/8] net: dsa: microchip: don't reset on
 shutdown or driver removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-clean-ksz-2nd-series-v3-1-75c38971c19a@bootlin.com>
References: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
In-Reply-To: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 5C0B859F55E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The ksz_switch driver is one of the few which reset the switch when
unbinding the driver or shutting down - in the same category with
ar9331_sw_remove(), bcm_sf2_sw_remove(), and ks8995_remove(),
vsc73xx_remove() and lan9303_remove().

I don't think there exists any requirement to do this, and in fact it
does create complications for WoL, as the code already shows.

My issue with this logic is that it is the only thing keeping
dev_ops->reset() necessary, which I would like to remove after
individual KSZ switch families get their own setup() and teardown()
methods that don't go through dev_ops.

Don't reset the switch when unbinding the driver or shutting down.
Remove the exit callbacks from the ksz_dev_ops.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  8 -------
 drivers/net/dsa/microchip/ksz9477.c      |  6 -----
 drivers/net/dsa/microchip/ksz_common.c   | 38 ++++++++------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  1 -
 drivers/net/dsa/microchip/lan937x_main.c |  6 -----
 5 files changed, 9 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 825133e9ce6e..ccbc3480717f 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2109,11 +2109,6 @@ static int ksz8_switch_init(struct ksz_device *dev)
 	return 0;
 }
 
-static void ksz8_switch_exit(struct ksz_device *dev)
-{
-	ksz8_reset_switch(dev);
-}
-
 static enum dsa_tag_protocol ksz8463_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
@@ -2226,7 +2221,6 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 	.enable_stp_addr = ksz8_enable_stp_addr,
 	.reset = ksz8_reset_switch,
 	.init = ksz8_switch_init,
-	.exit = ksz8_switch_exit,
 };
 
 const struct ksz_dev_ops ksz87xx_dev_ops = {
@@ -2245,7 +2239,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.enable_stp_addr = ksz8_enable_stp_addr,
 	.reset = ksz8_reset_switch,
 	.init = ksz8_switch_init,
-	.exit = ksz8_switch_exit,
 	.pme_write8 = ksz8_pme_write8,
 	.pme_pread8 = ksz8_pme_pread8,
 	.pme_pwrite8 = ksz8_pme_pwrite8,
@@ -2267,7 +2260,6 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.enable_stp_addr = ksz8_enable_stp_addr,
 	.reset = ksz8_reset_switch,
 	.init = ksz8_switch_init,
-	.exit = ksz8_switch_exit,
 	.pme_write8 = ksz8_pme_write8,
 	.pme_pread8 = ksz8_pme_pread8,
 	.pme_pwrite8 = ksz8_pme_pwrite8,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 65fd07ef73ad..88a5ff62aae8 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1624,11 +1624,6 @@ static int ksz9477_switch_init(struct ksz_device *dev)
 	return 0;
 }
 
-static void ksz9477_switch_exit(struct ksz_device *dev)
-{
-	ksz9477_reset_switch(dev);
-}
-
 static enum dsa_tag_protocol ksz9477_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
@@ -1803,7 +1798,6 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.enable_stp_addr = ksz9477_enable_stp_addr,
 	.reset = ksz9477_reset_switch,
 	.init = ksz9477_switch_init,
-	.exit = ksz9477_switch_exit,
 	.pcs_create = ksz9477_pcs_create,
 };
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 4a7bcd1a9392..b1fe7428fc3e 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4162,24 +4162,19 @@ int ksz_set_wol(struct dsa_switch *ds, int port,
  * ksz_wol_pre_shutdown - Prepares the switch device for shutdown while
  *                        considering Wake-on-LAN (WoL) settings.
  * @dev: The switch device structure.
- * @wol_enabled: Pointer to a boolean which will be set to true if WoL is
- *               enabled on any port.
  *
  * This function prepares the switch device for a safe shutdown while taking
- * into account the Wake-on-LAN (WoL) settings on the user ports. It updates
- * the wol_enabled flag accordingly to reflect whether WoL is active on any
- * port.
+ * into account the Wake-on-LAN (WoL) settings on the user ports.
  */
-static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
+static void ksz_wol_pre_shutdown(struct ksz_device *dev)
 {
 	const struct ksz_dev_ops *ops = dev->dev_ops;
 	const u16 *regs = dev->info->regs;
 	u8 pme_pin_en = PME_ENABLE;
+	bool wol_enabled = false;
 	struct dsa_port *dp;
 	int ret;
 
-	*wol_enabled = false;
-
 	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
 		return;
 
@@ -4192,7 +4187,7 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 		ret = ops->pme_pread8(dev, dp->index,
 				      regs[REG_PORT_PME_CTRL], &pme_ctrl);
 		if (!ret && pme_ctrl)
-			*wol_enabled = true;
+			wol_enabled = true;
 
 		/* make sure there are no pending wake events which would
 		 * prevent the device from going to sleep/shutdown.
@@ -4201,7 +4196,7 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 	}
 
 	/* Now we are save to enable PME pin. */
-	if (*wol_enabled) {
+	if (wol_enabled) {
 		if (dev->pme_active_high)
 			pme_pin_en |= PME_POLARITY;
 		ops->pme_write8(dev, regs[REG_SW_PME_CTRL], pme_pin_en);
@@ -4480,20 +4475,12 @@ EXPORT_SYMBOL(ksz_switch_alloc);
  * @dev: The switch device structure.
  *
  * This function is responsible for initiating a shutdown sequence for the
- * switch device. It invokes the reset operation defined in the device
- * operations, if available, to reset the switch. Subsequently, it calls the
- * DSA framework's shutdown function to ensure a proper shutdown of the DSA
- * switch.
+ * switch device. Subsequently, it calls the DSA framework's shutdown function
+ * to ensure a proper shutdown of the DSA switch.
  */
 void ksz_switch_shutdown(struct ksz_device *dev)
 {
-	bool wol_enabled = false;
-
-	ksz_wol_pre_shutdown(dev, &wol_enabled);
-
-	if (dev->dev_ops->reset && !wol_enabled)
-		dev->dev_ops->reset(dev);
-
+	ksz_wol_pre_shutdown(dev);
 	dsa_switch_shutdown(dev->ds);
 }
 EXPORT_SYMBOL(ksz_switch_shutdown);
@@ -4943,10 +4930,8 @@ int ksz_switch_register(struct ksz_device *dev)
 	}
 
 	ret = dsa_register_switch(dev->ds);
-	if (ret) {
-		dev->dev_ops->exit(dev);
+	if (ret)
 		return ret;
-	}
 
 	/* Read MIB counters every 30 seconds to avoid overflow. */
 	dev->mib_read_interval = msecs_to_jiffies(5000);
@@ -4966,12 +4951,7 @@ void ksz_switch_remove(struct ksz_device *dev)
 		cancel_delayed_work_sync(&dev->mib_read);
 	}
 
-	dev->dev_ops->exit(dev);
 	dsa_unregister_switch(dev->ds);
-
-	if (dev->reset_gpio)
-		gpiod_set_value_cansleep(dev->reset_gpio, 1);
-
 }
 EXPORT_SYMBOL(ksz_switch_remove);
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index f6dad256a550..1cdb6661729a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -421,7 +421,6 @@ struct ksz_dev_ops {
 	int (*enable_stp_addr)(struct ksz_device *dev);
 	int (*reset)(struct ksz_device *dev);
 	int (*init)(struct ksz_device *dev);
-	void (*exit)(struct ksz_device *dev);
 
 	int (*pcs_create)(struct ksz_device *dev);
 };
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index f84548168b37..778e32f568df 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -668,11 +668,6 @@ static void lan937x_teardown(struct dsa_switch *ds)
 
 }
 
-static void lan937x_switch_exit(struct ksz_device *dev)
-{
-	lan937x_reset_switch(dev);
-}
-
 static enum dsa_tag_protocol lan937x_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
@@ -723,7 +718,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.enable_stp_addr = ksz9477_enable_stp_addr,
 	.reset = lan937x_reset_switch,
 	.init = lan937x_switch_init,
-	.exit = lan937x_switch_exit,
 };
 
 const struct dsa_switch_ops lan937x_switch_ops = {

-- 
2.54.0


