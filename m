Return-Path: <netdev+bounces-94801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC58C0AFA
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 07:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F82282B15
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA31149C76;
	Thu,  9 May 2024 05:33:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA7148FF9
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232825; cv=none; b=D6zrwOjWuvnCjctyLbBVwJ9Pk+bJH9bK4UMaF8AzPcJ5dhPZM8/fL4/V7n0bzbigdzZ5kMoSUDn57eRWVhTsO6JMy4dCMYnLJq5XVzyM0caIrXAE0QCVZAunz7IIpPb5hml1uhM/7xF3fyMcywFOSXoGKO4mNnp/ctYF6IywiDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232825; c=relaxed/simple;
	bh=/ed8r6whzlIBj1u+mRN+0MIw1btORjgMStBR0Znhw2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIk1Lce7wR3XSiHeAhtEwVsSjR/Xjsx8crXymjtyWrZlvTgfMnnGMlMHtIyNs1tZXALrFMgtO4s3NfD95kE7nCaT8OsXKPZGvc1+8gAJcV1NNQVyj/Z7IslJ2IDtM6dx4QfhAvwtwdhe8mhf+ThK9mKscCTIDINsT/Tc7PrWoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s4wPR-0006kr-81; Thu, 09 May 2024 07:33:37 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s4wPP-000P90-VG; Thu, 09 May 2024 07:33:35 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s4wPP-000XZP-2q;
	Thu, 09 May 2024 07:33:35 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v2 2/3] net: dsa: microchip: dcb: add comments for DSCP related functions
Date: Thu,  9 May 2024 07:33:34 +0200
Message-Id: <20240509053335.129002-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509053335.129002-1-o.rempel@pengutronix.de>
References: <20240509053335.129002-1-o.rempel@pengutronix.de>
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

All other functions are commented. Add missing comments to following
functions:
ksz_set_global_dscp_entry()
ksz_port_add_dscp_prio()
ksz_port_del_dscp_prio()

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
changes v2:
- move this patch after IPV->IPM rename patch
---
 drivers/net/dsa/microchip/ksz_dcb.c | 33 ++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index e9c504c18677f..07f6742df41bd 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -310,7 +310,18 @@ int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
 	return (data >> shift) & mask;
 }
 
-static int ksz_set_global_dscp_entry(struct ksz_device *dev, u8 dscp, u8 ipv)
+/**
+ * ksz_set_global_dscp_entry - Sets the global DSCP-to-priority mapping entry
+ * @dev: Pointer to the KSZ switch device structure
+ * @dscp: DSCP value for which to set the priority
+ * @ipm: Priority value to set
+ *
+ * This function sets the global DSCP-to-priority mapping entry for the
+ * specified DSCP value.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int ksz_set_global_dscp_entry(struct ksz_device *dev, u8 dscp, u8 ipm)
 {
 	int reg, per_reg, shift;
 	u8 mask;
@@ -377,6 +388,16 @@ static int ksz_init_global_dscp_map(struct ksz_device *dev)
 	return 0;
 }
 
+/**
+ * ksz_port_add_dscp_prio - Adds a DSCP-to-priority mapping entry for a port on
+ *			    a KSZ switch.
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number for which to add the DSCP-to-priority mapping entry
+ * @dscp: DSCP value for which to add the priority
+ * @prio: Priority value to set
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
 int ksz_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 {
 	struct ksz_device *dev = ds->priv;
@@ -387,6 +408,16 @@ int ksz_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 	return ksz_set_global_dscp_entry(dev, dscp, prio);
 }
 
+/**
+ * ksz_port_del_dscp_prio - Deletes a DSCP-to-priority mapping entry for a port
+ *			    on a KSZ switch.
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number for which to delete the DSCP-to-priority mapping entry
+ * @dscp: DSCP value for which to delete the priority
+ * @prio: Priority value to delete
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
 int ksz_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 {
 	struct ksz_device *dev = ds->priv;
-- 
2.39.2


