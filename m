Return-Path: <netdev+bounces-94493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0228BFB1B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F361F23151
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5108175F;
	Wed,  8 May 2024 10:39:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8C81726
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164754; cv=none; b=EJx3TlUDSEXzKupmhR/uaT4fKMsePfSHIb2oJRWjVEV8i+lpT+Yty+O/8iAdWXj8gvtP3OFuQnf6IoeQsdGoyEOhvk+8xsgDBOye0eXaO0l7xM7Dk8LwlAol8+qaxw9naukktg55dZMkHCmUMcRcqdnrEOoIFlWQ2pQLZGVlioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164754; c=relaxed/simple;
	bh=yDHGXknAKcnKVyO/nYkC7OKUIyh3qMraCazNQoiwyLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuJKj2ApxeQ+bnWvDruJtFMF4S1YNxrcdTTRbS4JjLDVZL961x4w9vTqhnVVC10YcztnKuuNjitNTb/BYLsf6+Dp38W1VNqdQe3/Ovfcf9OfDFwIjjEZnHV6u45fiMun2BKmEKU60R3M3aGgpIiO5bGNACttH0tgoI79dW0cBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehV-0004BI-8n; Wed, 08 May 2024 12:39:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-000G0G-Gi; Wed, 08 May 2024 12:39:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-00HLTZ-1S;
	Wed, 08 May 2024 12:39:03 +0200
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
Subject: [PATCH net-next v1 1/3] net: dsa: microchip: dcb: add comments for DSCP related functions
Date: Wed,  8 May 2024 12:39:00 +0200
Message-Id: <20240508103902.4134098-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508103902.4134098-1-o.rempel@pengutronix.de>
References: <20240508103902.4134098-1-o.rempel@pengutronix.de>
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
---
 drivers/net/dsa/microchip/ksz_dcb.c | 33 ++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index 5e520c02afd72..879471cf815e3 100644
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


