Return-Path: <netdev+bounces-292969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCImBFoYGWoMqQgAu9opvQ
	(envelope-from <netdev+bounces-292969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:38:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FA35FD0C1
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3C0303ADFB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549B374E6D;
	Fri, 29 May 2026 04:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjAnynRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74C373C1A
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029076; cv=none; b=L8akOo7kvEsVeNJxJYlDYtS6VIvEttOw8um6cipsHpmJjk48QKp5iiDQ0A+37Ys5rR8CHE/rrsqo/aTMZQWlNQH0bYRRbWZ5w5/hWo+jyYiQMb3//jPr1KRQ8ykQQlLFC7ne4z+XyPkOw3t9yJV/DU0dnYfTHtGNJKUGoDnCkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029076; c=relaxed/simple;
	bh=dYjJ6Mi6TRVeId1JcWPnFO+uroefRgyzrrGlWj7S2Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qx0eqQsxkHuLb091WJ+JutFAN69e4K1Wvy7sd7IwU/OZsHcp+xLZ3YwshSIRrNUuSxKGymTU8qgupOz83Y0rq2Pdqz5tZvZATEsFlupKzaH2aVZODWrWRTIBgcBKZrRgQ2TI9xym1/Lq4nWMyZ+v8z6Tp8z/DcjbYL+KheaXs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjAnynRd; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516cc597842so41444851cf.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 21:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780029073; x=1780633873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYABlDQ7E38wra7Ekl4jydx28wDMumKdnP8MqmSbXNQ=;
        b=NjAnynRdn5qLynYrXw0pUXREtDGqejUsD5Xpcqz0Ephw+0czyMYiRnr4DR+QUBZmZx
         VJRPFV16268z8Mq99xQxLJoHFhomahH11HJgrEKvlbAFM0+4gex5aH/XpUtsq1GTMaLQ
         JKb3U2NUP43qz9NlBulHyzl+cs6pvoFWCV6GgBnOS4E7AEs6wQnDdj+II5rWhEbZ1nEZ
         l8IYMyAqz7uspcSFQ9/ce7tmjWGjDArLn75CL6rWsGEsatlOpBJq61zjIepIVz+/8Uz/
         ZbAqYovAGLIV+RztDd4Yg6qvLlypbFhAwrSzEsnUJ+0IsOuii8QgmO6WrhSGax7SDqWy
         oiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780029073; x=1780633873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lYABlDQ7E38wra7Ekl4jydx28wDMumKdnP8MqmSbXNQ=;
        b=LKoTTUjVOHLqDouFRiE+TNKzbpTt3cyvDmr2ybvRrg2wpk/Z5U4cRrPj0yqKJy9mEW
         4hpv9fb0veF7jh79EgSlD5lqBlRaVe3HXmk9GyVw2yz5GLMKo27jF9zZb9yV8dL2Xhrq
         F17brQv33RxOttftgM0COQfi1aApBasvoYImEFB8lJZce/nDnjuyUrnMp0yEBEZH8OnP
         J6tgvfwl/bp8Km8lH+52zRN5zB+A7d2LY30vVVL6/MSlN5nsoop0v71qvKbEH1/gZoc4
         76qrBXvJL7s3XDDLvSsTebXUU6WJJtAhPGAuktBCjBrGk0hRTVlyDGf5JLaQkp+x7EWT
         elhw==
X-Gm-Message-State: AOJu0Yz8XZiI4h3GlmDK0AeEFE0Dx/73PU55s/ss3O1JKMj58qAZxbhN
	/EbKLsFUImxgTtOzT8vZkOnG/GjS/RE3qOpsxg1vgTHgLSy3k5LvGOza
X-Gm-Gg: Acq92OFA3KudlHS4NIFdOxPaZQahMUyLf+I294pqGBhy9RwQxpfTGlEODmqtYIEiop6
	jGEMRQ4Lom6XmUxR3bgebIwzdxXReP65UFBd01cDAocYdMK86M49ZOO4MW57c+e2h+5MTggluJy
	pvl+Mdq+ykh0W2OK47OcLPOAzw5uGWFUY/Rgq5+K5H5vFsWfZILX4r21GxP62PAUW2gvr1yZXYU
	UyDtawg5t1Pg4aiR6cfXScWHQrWozOiDTAm1qabgmQNsUuXQ9z3dHecojDfqwVh0AzMtutDYbkz
	HM7cMF3CFHbodLa7czIPcwlMuapF9Duysl7nuzMn/a8va0KJOP+iEtawAlv0eZ5YacUp841sRu6
	TgaYanbbrdb+EjEh6SgyL+1A3VybRFNixV7IKyyR8OXE3Z/7UPYLfckk0U40Hwf3bzLCnOZbkxE
	W7W/SF8fo4qCf1MK3qBTqDGbrLeeMTbAgeCNxxiONulGZmPCRJGA==
X-Received: by 2002:ac8:5d88:0:b0:50d:a8aa:8087 with SMTP id d75a77b69052e-5172dd04f80mr17096881cf.38.1780029073049;
        Thu, 28 May 2026 21:31:13 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5172ebc7d23sm9260991cf.29.2026.05.28.21.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 21:31:12 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 29 May 2026 01:29:53 -0300
Subject: [net-next PATCH v9 8/8] net: dsa: realtek: rtl8365mb: add bridge
 port flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-realtek_forward-v9-8-e7c61872d923@gmail.com>
References: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com>
In-Reply-To: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292969-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 49FA35FD0C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement support for bridge port flags to control learning and flooding
behavior. This patch maps hardware functionalities to the following
bridge flags:

- BR_LEARNING
- BR_FLOOD
- BR_MCAST_FLOOD
- BR_BCAST_FLOOD

By default, all flooding types are enabled during port setup to ensure
standard bridge behavior.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek.h        |   6 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  68 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.c        | 101 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h        |   4 ++
 4 files changed, 179 insertions(+)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 426c9d345e6e..452e4e6dd157 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -134,6 +134,12 @@ struct realtek_ops {
 	int	(*port_set_efid)(struct realtek_priv *priv, int port, u32 efid);
 	int	(*port_set_learning)(struct realtek_priv *priv, int port,
 				     bool enable);
+	int	(*port_set_ucast_flood)(struct realtek_priv *priv, int port,
+					bool enable);
+	int	(*port_set_mcast_flood)(struct realtek_priv *priv, int port,
+					bool enable);
+	int	(*port_set_bcast_flood)(struct realtek_priv *priv, int port,
+					bool enable);
 	int	(*l2_add_uc)(struct realtek_priv *priv, int port,
 			     const unsigned char addr[ETH_ALEN],
 			     u16 efid, u16 vid);
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 3f7dc568d210..2677b2be3220 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -310,6 +310,21 @@
 #define   RTL8365MB_MSTI_CTRL_PORT_STATE_MASK(_physport) \
 		(0x3 << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET((_physport)))
 
+/* Unknown unicast DA flooding port mask */
+#define RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_REG		0x0890
+#define   RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_MASK		0x07FF
+
+/* Unknown multicast DA flooding port mask */
+#define RTL8365MB_UNKNOWN_MULTICAST_FLOODING_PMASK_REG		0x0891
+#define   RTL8365MB_UNKNOWN_MULTICAST_FLOODING_PMASK_MASK	0x07FF
+
+/* Broadcast flooding port mask */
+#define RTL8365MB_UNKNOWN_BROADCAST_FLOODING_PMASK_REG		0x0892
+#define   RTL8365MB_UNKNOWN_BROADCAST_FLOODING_PMASK_MASK	0x07FF
+
+#define RTL8365MB_SUPPORTED_BRIDGE_FLAGS \
+	    (BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD)
+
 /* Miscellaneous port configuration register, incl. VLAN egress mode */
 #define RTL8365MB_PORT_MISC_CFG_REG_BASE			0x000E
 #define RTL8365MB_PORT_MISC_CFG_REG(_p) \
@@ -1550,6 +1565,49 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
 			    enable ? RTL8365MB_LEARN_LIMIT_MAX : 0);
 }
 
+static int rtl8365mb_port_set_ucast_flood(struct realtek_priv *priv, int port,
+					  bool enable)
+{
+	/* Frames with unknown unicast DA will be flooded to a programmable
+	 * port mask that by default includes all ports. Add or remove
+	 * the specified port from this port mask accordingly.
+	 */
+	return regmap_update_bits(priv->map,
+				  RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_REG,
+				  BIT(port), enable ? BIT(port) : 0);
+}
+
+static int rtl8365mb_port_set_mcast_flood(struct realtek_priv *priv, int port,
+					  bool enable)
+{
+	return regmap_update_bits(priv->map,
+			RTL8365MB_UNKNOWN_MULTICAST_FLOODING_PMASK_REG,
+			BIT(port), enable ? BIT(port) : 0);
+}
+
+static int rtl8365mb_port_set_bcast_flood(struct realtek_priv *priv, int port,
+					  bool enable)
+{
+	return regmap_update_bits(priv->map,
+			RTL8365MB_UNKNOWN_BROADCAST_FLOODING_PMASK_REG,
+			BIT(port), enable ? BIT(port) : 0);
+}
+
+static int rtl8365mb_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					   struct switchdev_brport_flags flags,
+					   struct netlink_ext_ack *extack)
+{
+	struct realtek_priv *priv = ds->priv;
+
+	dev_dbg(priv->dev, "pre_bridge_flags port:%d flags:%lx supported:%lx\n",
+		port, flags.mask, RTL8365MB_SUPPORTED_BRIDGE_FLAGS);
+
+	if (flags.mask & ~RTL8365MB_SUPPORTED_BRIDGE_FLAGS)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int rtl8365mb_port_set_efid(struct realtek_priv *priv, int port,
 				   u32 efid)
 {
@@ -2399,6 +2457,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		if (ret)
 			goto out_teardown_irq;
 
+		/* Enable all types of flooding */
+		ret = rtl83xx_setup_port_flood_control(priv, dp->index);
+		if (ret)
+			goto out_teardown_irq;
+
 		/* Set up per-port private data */
 		p->priv = priv;
 		p->index = dp->index;
@@ -2584,6 +2647,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
 	.port_bridge_join = rtl83xx_port_bridge_join,
 	.port_bridge_leave = rtl83xx_port_bridge_leave,
+	.port_pre_bridge_flags = rtl8365mb_port_pre_bridge_flags,
+	.port_bridge_flags = rtl83xx_port_bridge_flags,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
@@ -2613,6 +2678,9 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.port_remove_isolation = rtl8365mb_port_remove_isolation,
 	.port_set_efid = rtl8365mb_port_set_efid,
 	.port_set_learning = rtl8365mb_port_set_learning,
+	.port_set_ucast_flood = rtl8365mb_port_set_ucast_flood,
+	.port_set_mcast_flood = rtl8365mb_port_set_mcast_flood,
+	.port_set_bcast_flood = rtl8365mb_port_set_bcast_flood,
 	.l2_add_uc = rtl8365mb_l2_add_uc,
 	.l2_del_uc = rtl8365mb_l2_del_uc,
 	.l2_get_next_uc = rtl8365mb_l2_get_next_uc,
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 9151d7fa6700..f15a1b287bed 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/of_mdio.h>
+#include <linux/if_bridge.h>
 #include <linux/etherdevice.h>
 
 #include "realtek.h"
@@ -792,6 +793,106 @@ int rtl83xx_port_mdb_del(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_port_mdb_del, "REALTEK_DSA");
 
+/**
+ * rtl83xx_port_bridge_flags() - set port bridge flags
+ * @ds: DSA switch instance
+ * @port: port index
+ * @flags: bridge port flags
+ * @extack: netlink extended ack for reporting errors
+ *
+ * This function handles setting bridge port flags like learning and flooding.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_port_bridge_flags(struct dsa_switch *ds, int port,
+			      struct switchdev_brport_flags flags,
+			      struct netlink_ext_ack *extack)
+{
+	struct realtek_priv *priv = ds->priv;
+	bool enable;
+	int ret;
+
+	if (flags.mask & BR_LEARNING) {
+		if (!priv->ops->port_set_learning)
+			return -EOPNOTSUPP;
+
+		enable = !!(flags.val & BR_LEARNING);
+		ret = priv->ops->port_set_learning(priv, port, enable);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_FLOOD) {
+		if (!priv->ops->port_set_ucast_flood)
+			return -EOPNOTSUPP;
+
+		enable = !!(flags.val & BR_FLOOD);
+		ret = priv->ops->port_set_ucast_flood(priv, port, enable);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_MCAST_FLOOD) {
+		if (!priv->ops->port_set_mcast_flood)
+			return -EOPNOTSUPP;
+
+		enable = !!(flags.val & BR_MCAST_FLOOD);
+		ret = priv->ops->port_set_mcast_flood(priv, port, enable);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_BCAST_FLOOD) {
+		if (!priv->ops->port_set_bcast_flood)
+			return -EOPNOTSUPP;
+
+		enable = !!(flags.val & BR_BCAST_FLOOD);
+		ret = priv->ops->port_set_bcast_flood(priv, port, enable);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_bridge_flags, "REALTEK_DSA");
+
+/**
+ * rtl83xx_setup_port_flood_control() - setup default flood control for a port
+ * @priv: realtek_priv pointer
+ * @port: port index
+ *
+ * This function enables flooding for a given port.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_setup_port_flood_control(struct realtek_priv *priv, int port)
+{
+	int ret;
+
+	if (priv->ops->port_set_ucast_flood) {
+		ret = priv->ops->port_set_ucast_flood(priv, port, true);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->ops->port_set_mcast_flood) {
+		ret = priv->ops->port_set_mcast_flood(priv, port, true);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->ops->port_set_bcast_flood) {
+		ret = priv->ops->port_set_bcast_flood(priv, port, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_setup_port_flood_control, "REALTEK_DSA");
+
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index dcb819fe567f..d86447121276 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -27,6 +27,10 @@ int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
 			     struct netlink_ext_ack *extack);
 void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
 			       struct dsa_bridge bridge);
+int rtl83xx_port_bridge_flags(struct dsa_switch *ds, int port,
+			      struct switchdev_brport_flags flags,
+			      struct netlink_ext_ack *extack);
+int rtl83xx_setup_port_flood_control(struct realtek_priv *priv, int port);
 
 void rtl83xx_port_fast_age(struct dsa_switch *ds, int port);
 int rtl83xx_port_fdb_add(struct dsa_switch *ds, int port,

-- 
2.54.0


