Return-Path: <netdev+bounces-291041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCU3Ln5CEWrsjAYAu9opvQ
	(envelope-from <netdev+bounces-291041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:00:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46D5BD608
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1D9F3066301
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA233121E;
	Sat, 23 May 2026 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWR4Vu3W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C432E692
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515802; cv=none; b=gpkzWME68zUpbkzUC76ROjcDr8H/RcVU5wGcaQJvOq4JSjORYCrVO9u5f6rQ6J1dpGtlA1tlYNl7jNFKuAIxw8+VLgiGLD570SQq6dLx0HimakYp6tB9xxyMYIUx/rY5JvnJv75O4p2bvf0qDPDfRtk8JjwbK6HGkexxAZA8QSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515802; c=relaxed/simple;
	bh=X0myBaS3VVVwV4wjc+gXT0Mi72l9Tx1J6i+oEZw865U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9I32kDoZ7OZkn79qzAoGJTSNFmb8dNOePlmaIz4sFYa5eweAP7AyhE04xfGMWgj+VWH0UbdYxtD4elWshv9CgzzUfP2XKMVy1CkZaiPiUNrLC0QhcCYFLlqIBJxulIoQAHkjdczVyz82zTqEAHflT11bz+1NlMG4RC5cQ3/nNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWR4Vu3W; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-575602688deso2847199e0c.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779515800; x=1780120600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFotW0v0gridS6wcO7g5BlebnUuCg2SzP//5+Z/2KCI=;
        b=VWR4Vu3WyLyLjI//ks3Stgz0m7GKmNMQ9Tmm9ycMv6NQpmdqCtDhs4hkajPbuwZF1c
         IT4BYUFlPyZcm5706L8L3h9DXfX68jeuScpZqONN0LawUzSnRj4zI/wQSxhpxjcpTqJS
         M5X6TC4ALrqdMPvMqz/DJTDZTRzBNTQMpuafjop6JbINzEeZzGeHm1ayE0rvKPXOybTg
         X3xnahYmnaMI7rIQvGJKOGGnPECSzN5asDWsOuQDhkcWDtzL8EgPBmu15UZ6qh31T6oG
         H9+jpFJzj741jcoWunV5cFTpnLSLHAzCFY87R9U4PnW233J1GhZFy9MPXPZZeRaLxuX3
         le2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779515800; x=1780120600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QFotW0v0gridS6wcO7g5BlebnUuCg2SzP//5+Z/2KCI=;
        b=k3qGahEYf3HtHHfL+ERLgv2Nv0MPDOD92PAvMcOAgl8AZV8OG7IciOptSBkbK8KetQ
         vQuDr3gc2FVr3E7WT0qr5uFYOuUD8EqYmbMeBMqsZtGd/ntiLMktC/jICi/04q0+bVbP
         NlCNDRZ8RZemSVh4ZkPGa/0D4Laojm4CHqqQWKsG2AkpHXbBkpEQUhFRGOH0QZ+MZL9t
         2mL1RccJJ1MQuAHnK10VXbXO+pHK6/UytbNn6XDjGKpyuAM/MMxJaFr2hm/4zgraaIFJ
         OpxbO7ea0Dgr2ln29NViGaQvpzv/qcmJlqw+HPc7CGVuuvPhWpLDY1FPj+r4W3L7Eeqd
         6Pdw==
X-Gm-Message-State: AOJu0YzmgTTQlxUutuypDOuOME73ReiwruQX/FD/UwxDLm8GzVuEcSTu
	ju8YczNOAHa9iKWnPqXk7ViWlxfr+w3OrvtlOKntMZ/YDOkzA16KoJ08
X-Gm-Gg: Acq92OEurftCQKVJPRnQV1f9q+f/2t/3Fb1saTeNAJmeUKz+aCHXSUZqk0ZOOLowMiH
	67le1KQWwLTh9172NllxGDxxsTvCfIEMp+vdUfQEK5AdtHtSv5DwubyCgEFJJBHr0Ygi9z1veyB
	Fx4jD6hq1O3NJcDybEIrqh7Kqdo+izPKQ22Hc1sOQpL3da9SQ6JEA0R8ooC4MEbXs8X71vgj4WJ
	/ne3I/GpViX1MeVomYFPtVHuJR6UhhF1VRgTznf+TUgT5qCqOfIqnlPMQ/RrpldNXPw4rmFboKt
	jnL3nj3iqrgWUruWLb4uX7A+NgqI/2JWO7VcGeskxbL/Oj6w7+jP2e1kanelolzY7yPnt2fIGHM
	lBwPRWtub6cPXR/40zflTks6r2m2mUhrzQd/G7aXOLPP7MeX0ZryTT+2goaCbPOKqEcNqCXbCYT
	7NlS4tNN05vgZbV0ytrHry3e4g7SUr5KiTRqZP3Pg=
X-Received: by 2002:a05:6122:608e:b0:56d:b639:5c0d with SMTP id 71dfb90a1353d-5866357ce4dmr3630495e0c.13.1779515799927;
        Fri, 22 May 2026 22:56:39 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f973300dsm5023718e0c.18.2026.05.22.22.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:56:39 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 23 May 2026 02:55:41 -0300
Subject: [net-next PATCH v7 8/8] net: dsa: realtek: rtl8365mb: add bridge
 port flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260523-realtek_forward-v7-8-313805e218f3@gmail.com>
References: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
In-Reply-To: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291041-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bang-olufsen.dk:email,linaro.org:email]
X-Rspamd-Queue-Id: 2E46D5BD608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Implement support for bridge port flags to control learning and flooding
behavior. This patch maps hardware functionalities to the following
bridge flags:

- BR_LEARNING
- BR_FLOOD
- BR_MCAST_FLOOD
- BR_BCAST_FLOOD

By default, all flooding types are enabled during port setup to ensure
standard bridge behavior.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek.h        |   8 +++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  69 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.c        | 101 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h        |   4 ++
 4 files changed, 182 insertions(+)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index afbffcd448f6..6043c0c6f3cf 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -145,6 +145,14 @@ struct realtek_ops {
 	int	(*l2_del_mc)(struct realtek_priv *priv, int port,
 			     const unsigned char addr[ETH_ALEN], u16 vid);
 	int	(*l2_flush)(struct realtek_priv *priv, int port, u16 vid);
+	int	(*port_set_learning)(struct realtek_priv *priv, int port,
+				     bool enable);
+	int	(*port_set_ucast_flood)(struct realtek_priv *priv, int port,
+					bool enable);
+	int	(*port_set_mcast_flood)(struct realtek_priv *priv, int port,
+					bool enable);
+	int	(*port_set_bcast_flood)(struct realtek_priv *priv, int port,
+					bool enable);
 	int	(*phy_read)(struct realtek_priv *priv, int phy, int regnum);
 	int	(*phy_write)(struct realtek_priv *priv, int phy, int regnum,
 			     u16 val);
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 0d0ff61278c1..a6625ff87d44 100644
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
@@ -1538,6 +1553,49 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
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
@@ -2387,6 +2445,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -2572,6 +2635,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
 	.port_bridge_join = rtl83xx_port_bridge_join,
 	.port_bridge_leave = rtl83xx_port_bridge_leave,
+	.port_pre_bridge_flags = rtl8365mb_port_pre_bridge_flags,
+	.port_bridge_flags = rtl83xx_port_bridge_flags,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
@@ -2606,6 +2671,10 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.l2_add_mc = rtl8365mb_l2_add_mc,
 	.l2_del_mc = rtl8365mb_l2_del_mc,
 	.l2_flush = rtl8365mb_l2_flush,
+	.port_set_learning = rtl8365mb_port_set_learning,
+	.port_set_ucast_flood = rtl8365mb_port_set_ucast_flood,
+	.port_set_mcast_flood = rtl8365mb_port_set_mcast_flood,
+	.port_set_bcast_flood = rtl8365mb_port_set_bcast_flood,
 	.phy_read = rtl8365mb_phy_read,
 	.phy_write = rtl8365mb_phy_write,
 };
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index bacba17184e4..77461e0afb5b 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/of_mdio.h>
+#include <linux/if_bridge.h>
 
 #include "realtek.h"
 #include "rtl83xx.h"
@@ -760,6 +761,106 @@ int rtl83xx_port_mdb_del(struct dsa_switch *ds, int port,
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


