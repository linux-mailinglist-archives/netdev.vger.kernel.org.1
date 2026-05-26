Return-Path: <netdev+bounces-291631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHRcMjdvFWojVAcAu9opvQ
	(envelope-from <netdev+bounces-291631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E905D3D9B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1564033D0ED5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF03DFC6F;
	Tue, 26 May 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ce7/Zz/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CD3DD87B
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788884; cv=none; b=YwvWNa16CxrxSmDsKwBKt4mXP2fVGiJu6VnEDnuHcbkep4A6gauuPVQNqp4TBkOFCmoM557hRl5vCJkReopeQ0iSx4nXxkv0IEJXVaDsv4mlfg8sSNt1myPTRwPf7U5VWkcGidorT39M1oVfH83FqWZRX63Wf31BahQtqIxGq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788884; c=relaxed/simple;
	bh=TJAsHonXH7rQdWgbjJwmPvFrpTQNxpZnfdHNYkOvLBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqPgtbWb5pp574Z3Vwi63mAKbILOvvvcqd2FtY81dtOD8dlrDS4T8CkISzPJva7PWqy5Ny+Uughoq9dYKLyNrZ/1kayE2AQRAlIv3QkRWLcwf29OS39dx/6Z/ljxFxc3KiN1g6gkPxnrLxYwO7CgzJ3RnI1B1upYwCmLn0rGyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ce7/Zz/F; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4B395C79AB7;
	Tue, 26 May 2026 09:47:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 030AD60732;
	Tue, 26 May 2026 09:47:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7699210888589;
	Tue, 26 May 2026 11:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788877; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iilN8KF8C83AesyPJyQQ0xVeNXqiT5pjrbqiZCp3vjs=;
	b=Ce7/Zz/F/3FzQzfOWLzwZn3NuDGiOd6kf5rBKPMu2RebOvYCd6nN6h2qb3Il22oD0Ua5mz
	TwK9qW+6qZJGheMu//2cxhYEJ4IcRMYgWT9pl+kXl5LOmzAtnXWSgpTdaxAZLhdsvXDex/
	4CGX+kaj9CAMkKdH28u+1F3IUeTz+2Md0u7b0zqndqmM5E5RMT7VyY7UzRuUnwUsNGVAPf
	pV3EyX/hlEQcdH6E+6r5QvaKNWxV/clE5vBd8KTBf5rwSVzDX9G8ARxlPYH6nhjej8jkSJ
	20pruq4Rny+3WiMu0HWscQk7Sn+CZo2pTxdIY7i5G/jg1HLcHPwb1H6uKkKI5A==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 11:47:35 +0200
Subject: [PATCH net-next 9/9] net: dsa: microchip: implement port_teardown
 only if needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-clean-ksz-3rd-v1-9-5b63e732149a@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291631-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 01E905D3D9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The port_teardown() operation is optional. Yet, it is implemented by all
the KSZ switches through a common function that doesn't do anything for
the switches that aren't part of the ksz9477 family

Remove the implementation from the switches that don't need it.
Implement instead a ksz9477-specific port_teardown.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  3 ---
 drivers/net/dsa/microchip/ksz9477.c      | 10 +++++++++-
 drivers/net/dsa/microchip/ksz_common.c   | 19 -------------------
 drivers/net/dsa/microchip/ksz_common.h   |  1 -
 drivers/net/dsa/microchip/lan937x_main.c |  1 -
 5 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index bea66183238e..e5d4ade0b29a 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2450,7 +2450,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_bridge_leave	= ksz_port_bridge_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
@@ -2499,7 +2498,6 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_bridge_leave	= ksz_port_bridge_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
@@ -2554,7 +2552,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_bridge_leave	= ksz_port_bridge_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index d7903814a2a5..c2220afd7466 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1940,6 +1940,14 @@ static void ksz9477_duplex_flowctrl(struct ksz_device *dev, int port, int duplex
 	ksz_prmw8(dev, port, regs[P_XMII_CTRL_0], mask, val);
 }
 
+static void ksz9477_port_teardown(struct dsa_switch *ds, int port)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (dsa_is_user_port(ds, port))
+		ksz9477_port_acl_free(dev, port);
+}
+
 void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 				 struct phy_device *phydev,
 				 unsigned int mode,
@@ -2072,7 +2080,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.port_hsr_leave		= ksz9477_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
+	.port_teardown		= ksz9477_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz9477_flush_dyn_mac_table,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 708dddf2c6cf..3f5b1c4e7169 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2953,25 +2953,6 @@ void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	ksz_update_port_member(dev, port);
 }
 
-void ksz_port_teardown(struct dsa_switch *ds, int port)
-{
-	struct ksz_device *dev = ds->priv;
-
-	switch (dev->chip_id) {
-	case KSZ8563_CHIP_ID:
-	case KSZ8567_CHIP_ID:
-	case KSZ9477_CHIP_ID:
-	case KSZ9563_CHIP_ID:
-	case KSZ9567_CHIP_ID:
-	case KSZ9893_CHIP_ID:
-	case KSZ9896_CHIP_ID:
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		if (dsa_is_user_port(ds, port))
-			ksz9477_port_acl_free(dev, port);
-	}
-}
-
 int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 			      struct switchdev_brport_flags flags,
 			      struct netlink_ext_ack *extack)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a7fc23ced38c..80cb4265dbdc 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -387,7 +387,6 @@ int ksz_switch_suspend(struct device *dev);
 int ksz_switch_resume(struct device *dev);
 
 void ksz_teardown(struct dsa_switch *ds);
-void ksz_port_teardown(struct dsa_switch *ds, int port);
 
 void ksz_init_mib_timer(struct ksz_device *dev);
 bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 73ad99dac72d..084ee811f6e2 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -978,7 +978,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_bridge_leave	= ksz_port_bridge_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz9477_flush_dyn_mac_table,

-- 
2.54.0


