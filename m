Return-Path: <netdev+bounces-290650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEVWCorCD2oIPgYAu9opvQ
	(envelope-from <netdev+bounces-290650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:42:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B72AB5AE1F1
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C68EB307ACA6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCB931352B;
	Fri, 22 May 2026 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj/SofmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967E3128CF
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417149; cv=none; b=WFPMgLCyn3V/7o/Jh+9rYicL0266+nJ3EG0IY6n5bFTDzy6cFMz9Shk3OigxPyX19TBAoy4DhLGcuNsDII1aU1zYpiW4KOi4qcg7HFQ8ZlpjzLAVK6pHjY9+n6yPiJQGWdEu4cAxRtg5Jw1H+gYVkImW+BqzDR3L9nAvkB4TCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417149; c=relaxed/simple;
	bh=FizNDl5cD/Y45qkHxUb+Mk21HmF94SMCZghhrWLkOXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t+ZLVD5KXRCpCDsyRzL2zhcv8wim8uYKTLmOAzPVIYihBjRmzzaqt/7OupwzmFDrkXQZpuGkM9hn0GcQYPR5qAjWpsxjD/sp9iOyUBhF8BB2SOsT6DDIhWBsH5nmq3WyD4xGYVxEHr1OrLGo+pw0F2bzFVJYXY0FtI+ISmvbu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj/SofmK; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5751b7d147aso2579730e0c.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779417147; x=1780021947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTI8swrtoA/kkKDPcqyZvPsBgjj2K4qwneW7XqxZwfs=;
        b=Pj/SofmKXMDbiRMnmHQb3JovTp8H29YcbMiQKCG9lEKzhiZ8Qo5+OQYpzaCXxXsNnM
         tV0xs2BDfRLOduRdO8amzel1gPnL2BYp1i2u/KDkyhnKGh1YNxFXiEmsjvcHwwes1wSE
         Xw6X2jfeRTBc4SKtuQvIV/mYIis8Vc4lfBaCmFdZgkDahWGStgi/Gxt/PXiYsnSzjui5
         aHmZNYtXw8efqaeuQ5sITzkYoVE8DG2QBAjPlFFCQSahGurUyYt3OBytoByIwbMHtjfS
         ED+1G4c3/fBiX1MS5Ge5+qXt13xApZv5eVftkrJ+6yG7a/Ul9v69Be4txuvzbfSWVGMZ
         +hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779417147; x=1780021947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KTI8swrtoA/kkKDPcqyZvPsBgjj2K4qwneW7XqxZwfs=;
        b=mCYtxoTrTQnOvMv31kPksOqDr8wKBCAnk2o8Gj/TJOqytipyuUk+6PNsJMlleFdNW6
         3vOR+KqUr8E6QwgD37XY4cRQysTzbMqP1bRC/oxtwvbKQCGec2blOsvPKuXMPgi/N6lE
         abRKVAHlW6W3QukqwCsG7KTfiWZPyinkJOQf0qkbMMsGef0DohUD2VqJhubKnYpZnn8N
         MlKSJhW2S2xyPpIf1k9scbRsMn5iJDmIKIW7pFmB14NBg+/HSZDlPPAw5HGXC5bUr2xZ
         hyxEvmTYNhUDtOn7V/COncow0n4I/qpdHFktXPPpYo+OJzMrVkWJHWKyMNkH5pPO9qGh
         fD1Q==
X-Gm-Message-State: AOJu0YyP85nTkXqDZlfFaBDuzxNny4jCbFrt1vzcuJmV80Xtl6hRUX/i
	Ma7krthYBPVEOawaxKoIU0C/OGf9orGuSkOmLdgYKW7KyX3i1rouYM4I
X-Gm-Gg: Acq92OGodVq0PZ374GLReKxcvjvyivzGqe7LMU+yA2O9A8D3b3kOY1tvFKh9SNIEtgP
	spB1MeIAgRaQh2azweQYhvarDEo+iscozzwhcrEqwD8aqO8I1gWrGnW8k5zVr1sI5+HRHjIC2jP
	zoWbLdlQqfTQD6KQpIpXHbC6fiWzPDsdALf4zDql5L2RRqItOOYSvrwyxE1yT+oa/CBp3qbXY7u
	g9tKVhms1v3bJS/kpo885DzxUAHAc6pBGJvPEht21iUGmkfy4Q72ssPUrNU5s2mUQGUtjBrAHgR
	FSrwYNB3FOHXcA1w4gMolWoW2ITwqSsACUhAkdrS1q+Hg4ZZGnZkCxgHwNxzyuUQ7DUaVBcHHPl
	AtYIac5HkK/EHHXXG9Xp28xDagskeP3hCyhaVXXAZTtP7/z+tUsCB7pM7pvkQkD7xhIXgj2v44r
	jKdNJ0QRx/B+lRCuWvLK30Uwqv7L4rGudRoGC1jCM=
X-Received: by 2002:a05:6122:1804:b0:56b:9083:4331 with SMTP id 71dfb90a1353d-5866357e65amr932033e0c.12.1779417146831;
        Thu, 21 May 2026 19:32:26 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm640709e0c.5.2026.05.21.19.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:32:26 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 May 2026 23:31:17 -0300
Subject: [net-next PATCH v6 8/8] net: dsa: realtek: rtl8365mb: add bridge
 port flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-realtek_forward-v6-8-d391bbad38c3@gmail.com>
References: <20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com>
In-Reply-To: <20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290650-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Queue-Id: B72AB5AE1F1
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
index bcf917d0a58c..8533a64f266d 100644
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
+	dev_dbg(priv->dev, "pre_bridge_flags port:%d flags:%lx supported:%lx",
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
@@ -2377,6 +2435,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -2562,6 +2625,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
 	.port_bridge_join = rtl83xx_port_bridge_join,
 	.port_bridge_leave = rtl83xx_port_bridge_leave,
+	.port_pre_bridge_flags = rtl8365mb_port_pre_bridge_flags,
+	.port_bridge_flags = rtl83xx_port_bridge_flags,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
@@ -2596,6 +2661,10 @@ static const struct realtek_ops rtl8365mb_ops = {
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
index c2e39868c4c0..46c64ea6743c 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/of_mdio.h>
+#include <linux/if_bridge.h>
 
 #include "realtek.h"
 #include "rtl83xx.h"
@@ -761,6 +762,106 @@ int rtl83xx_port_mdb_del(struct dsa_switch *ds, int port,
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


