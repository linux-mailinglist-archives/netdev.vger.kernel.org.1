Return-Path: <netdev+bounces-291443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bi8BNunFGrtPAcAu9opvQ
	(envelope-from <netdev+bounces-291443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:49:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1815CE21F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50CCF300C306
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39F4394493;
	Mon, 25 May 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpYYLHq2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E839183C
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738536; cv=none; b=TntJfkmxvnbPrwFGRll4x8rlgGWTYogH/dkC2WE6RZ/w5xftq4exAKOW27L25X1RmKQ8ATHVPGqaXAIKL1t2P0/HSb1gGk20uWFwx6Qn/6EWgpaMMvij/bxrNB0LvJNF+CEI/aPzJ93zEmWiYsfU3N6zCrEPNUXkpSSQFgZYCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738536; c=relaxed/simple;
	bh=XNxwP6ZPMRXfd+LkzxJW8Gvv6cfLtF7qkvqbwK7ARqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bEqJPFFyvtb2soiCWzB+McdZbuHn8U+HmXOutNAi0THHtEQZL9BqkRkH+g3PqLAQ9Ytah2tRI3JjbreghD2H9+GWMw/iQuASui+2dIiEfIvmK7WuZGD/a8TUZqPrkyH1Yrxs+sE4sr0epSxFs15TY1dsbZm6rP1OW2grLILywnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpYYLHq2; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6324ee4040cso3417229137.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738534; x=1780343334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFU2OoeIXqK2fk+LjSzzM4F/guKkRliqsxP0sFhZJcs=;
        b=OpYYLHq27bOiYY6ITNUEGP95RwkQpA/77khlUMG7ESAQrrI2M/1YzOps1zlCt8MosP
         USMqFfujFMdlwbsEprrGRKbsdcUwsascOIWmutDtRePCP2wnqDrMtookhMjgO0rBoxbW
         EF8Jk6+J7/ZdNklizsAIxExK+3QJLvoMxFB0AS8x+artU77TcBelkMA06Q2bRrl10Evr
         fnzGHgMBL8qRQjf6xeKfmifOtoqrWdHMVPcq8ZickYSSUmSEORaSDBAIu4sdq5PgcZeA
         jrdJEdeqHcCfh7dwRoeZ95IHJwOZmdCVg9PhL4la0W2mG69KmUUcUz+n4QU5KVwfO3k0
         kiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738534; x=1780343334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bFU2OoeIXqK2fk+LjSzzM4F/guKkRliqsxP0sFhZJcs=;
        b=qJ/tMjvlnDufnscSvOpSe2qXH53SeFjYNPnqTdv6qDZ3H40mg3/mU1OR8KcvSovUKK
         ba6XiWXlo618t2HC0pdxilZbbso4HV6CjxIaq+mjB5qNc6HcB2wx7h9Pa9rUwA1WZIGm
         A35eoQggQlFHnsIYvxQJ/DMWLPkBlFB2xdsed+tLa+WXBF2P01LVxl+X52hXUKH2YEh7
         uQkpGqf9PoSKvvuKyAApKrLRaK2gWHCNk/wu6pUvvFB/crLTgAcPDpBsnzrPtL3QosEk
         DbVQbyDzbOWi2tbAi2Xr3p7Ng6C7v7B9Q+N53mCrHn6m5F3AXnLPLHO9MTql4NuggUdM
         OagQ==
X-Gm-Message-State: AOJu0Yyz6iCXaalL0Tf1jGwtbXnwbJ8F+mlzhHJ4K8ko8rtWI9AROBvM
	bfTBip9d0EoKQBehT6cJJTSLVnjBeJK1eZxsdCEzXthiYZCnLvDSFkWQ
X-Gm-Gg: Acq92OFWGnHLfm2xCAB15NFONPRNG5iuMnCzsJHxXPAFFkkVpAtIgLzQacu/GsFMnwm
	+jlvhShILfXxbgC8ncBiddEXYsrhcjNdJ9sR2pr6lMeIdrB58Va3TGr5hk87qD0Nsh3J/vvCf6S
	bJeO+vc12LsGnQByIWqjbwnmIYfoQO8VIPCgS96HqVvSYZNuxasiI6wC2luXqEUx0J9+nI4pqPN
	b0OFPK1Moc4Fllq9VU6JGk5TE8pRkZdp3ZAkeqSIYd9HHkDknTN4TvIKJ/dwtq+rIly8EOC7+kL
	qI8lrviAUEEdeVYxp7pomGuW7aDBpuXSMDLr4cjywhiBQpDTbDFZ87a24ecVmDECs4dEGzZcdkd
	xumXA5vMUyjPOAL184oGlbxJAioDMw/fkiQub1lo0GOLWJMdh/h5RpUv1nnISRORalFaDSVP+3U
	6KvN1uUJX7zGq4zTxnunqlLZhp0XDiEqWruUUKQF+Sy+8t/v1+
X-Received: by 2002:a05:6102:a4d:b0:631:b834:e05f with SMTP id ada2fe7eead31-67c751b7be5mr7882003137.11.1779738533868;
        Mon, 25 May 2026 12:48:53 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173af3e82sm11092456241.10.2026.05.25.12.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:48:53 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 25 May 2026 16:48:04 -0300
Subject: [net-next PATCH v8 8/8] net: dsa: realtek: rtl8365mb: add bridge
 port flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-realtek_forward-v8-8-5eb80a4675be@gmail.com>
References: <20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com>
In-Reply-To: <20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291443-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Queue-Id: 8F1815CE21F
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
index 688b37de8c91..a8a881a2c43b 100644
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
@@ -1536,6 +1551,49 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
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
@@ -2385,6 +2443,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -2570,6 +2633,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
 	.port_bridge_join = rtl83xx_port_bridge_join,
 	.port_bridge_leave = rtl83xx_port_bridge_leave,
+	.port_pre_bridge_flags = rtl8365mb_port_pre_bridge_flags,
+	.port_bridge_flags = rtl83xx_port_bridge_flags,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
@@ -2599,6 +2664,9 @@ static const struct realtek_ops rtl8365mb_ops = {
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
index 2ec8e3701e72..adb5328d7b80 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/of_mdio.h>
+#include <linux/if_bridge.h>
 #include <linux/etherdevice.h>
 
 #include "realtek.h"
@@ -799,6 +800,106 @@ int rtl83xx_port_mdb_del(struct dsa_switch *ds, int port,
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


