Return-Path: <netdev+bounces-293507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N6nJ6D0HGrxUQkAu9opvQ
	(envelope-from <netdev+bounces-293507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:55:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B102618F50
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B82DB301066A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88423BD1D;
	Mon,  1 Jun 2026 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgHx/A0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF612376FD
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282478; cv=none; b=GUmGmnLm9mIss4WuTpIx+ROzg95Dj8EtZnHFC66r3PBhmhkngJOsm4mxGNtKwmnCKgcCb4hUB1nYsRQKn823GfsSs+Tvo4m0IlDmUJ9jd3Zygnr9Do3u7iJ7920CmCkfauuDhBhCnws/Qt1r7lOffTjV55SaaED2anioMkTfG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282478; c=relaxed/simple;
	bh=EsDBi9KJSmj9z0qILLpm3x3qGMT8UEASWNzUmRIvnmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwbE1eqaj8uqxIG1/ejcgsC8whJLQg5JyjY/ozgmLdvpoeC1blXq5hqkBn3O8EVKOPCDL174n2dWXboS6MHgkSnNxzXXptizsXl3tEKn5p+4bovJ8IoZMnkWxUFq0RSX9ikdPNHO4wtHXLSUInINyhEdvQlviEwCaFxQSgYc8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgHx/A0q; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66077c46c5cso660420d50.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780282475; x=1780887275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmawKbRm1/hCjQC4DVRJQjGPLqtvpA+DS0zkTTjXdhE=;
        b=dgHx/A0qCMh4f3+uJmhoKK6oqHSThUOXMea43lVe9Pl4Vuk2tu/U/YKA6R2Vl3jH1n
         NeaR8oe8jCH4mOhFbHznFxAXwWhfY+mB+etHodjora4+G98TTZzd7tP96SVZqerDXnDb
         pqPcoRizbgaUQLXunxlEQdVnEDMcAHBIhFKBoBJBKnoIsMFt3iPVyn2Mrv4LcRVgPj9o
         Qihltn3QvnJL2RLg/EANs8VnKTwTCCujUZcta6XlZiF3NVterJDCTbrsCRqdR1HqYegF
         7DOKAmdOk1cfaaPdQAS3qK4JNzUAiD7nWUqiFcjaG+hjUxrb1b+1JTbKiusuw5t00SNU
         /qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282475; x=1780887275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vmawKbRm1/hCjQC4DVRJQjGPLqtvpA+DS0zkTTjXdhE=;
        b=XtNRfe/M6DYlheiCHUupBK/2wDFwoXfTAVpFB3OoSGQLYxMwF2F6GGrnlxoeSVdNAn
         47g1whLTlQD7Iws5asU/wXAhftkhJTdb46Ek/Dcy7veRYqnDxJ1TnyBkb+vjT6B0Th3m
         o25DI1TQNaUw5aD/91lEtnQx47o9rzbghvdUOuMDQX+1MUqCw3uj60qIKBKUa3INxsVy
         ce0mOsIDpgmkEwt+qQExLYF+9c5SP+4TGSq2ndzZ33Cfsp9YkSEEkIxhRfoJm0cpstd5
         Ex34SDeU0r6ugq4m80gGPNYN7QODII1YHOY0BtbqBg6hvra/lBM8QsJnnZobq4BaP2Qm
         BizQ==
X-Gm-Message-State: AOJu0YyE8aBdUtmZ9H0+0Ex7I0tee/NoUFt4MRuV4YHlN6I7Z8o+N9of
	UchA5GIAqV2Je/fJmy8QIItZcbODx6OKd4K5f0cQlSvXY3h4pFwU6BEl
X-Gm-Gg: Acq92OGq4qbQHvw9Whby1XdVqoa/XhkbXHeyI27jd805pqSoR+x1Hz781q2A/X+jKUB
	ChjEcqMlvIXl7Ca7O2KD/n3cgCxI6ABEIjuyNhZhogbHeAMcR29ijFRV4WYde5qwoI5kyHrPMGt
	lim7HJ8gx6xoxbpwgjrNrPZwQsMIDtFLspjYh5/5ICc4A/ASp0r9nYVpV9exPfwDJYip2kODH2Y
	ZqUfWGou+azmWyjaLUOR2KaVcpCpFDobeHQKLc3P+HFE9pkAG67zQoeAt8O6PwAjNqMsAkf1lCT
	NfxEJOBKzv/XmZcDXIX+/g8S7CM2SKnGI+YNjKoOsH09kXJqQYJ4Sqt+eFxUQEyWDlSTagVNd0M
	wGHj5Vb0p6oaYcaLlqq77N9tv0QKO9k0oHDUKKuOqsi/0R5hU69uPWOWe1pF9OBXVYp3bFFafNB
	Gxfwo7sHarNGmhZWay3TsclykQL2rOLNmZBIQtJy6GAOepbayDYGggiHxu181f
X-Received: by 2002:a53:b687:0:b0:660:5b90:b426 with SMTP id 956f58d0204a3-6605ee282bbmr5877754d50.46.1780282475389;
        Sun, 31 May 2026 19:54:35 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6606977ab05sm2952518d50.9.2026.05.31.19.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:54:34 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 31 May 2026 23:53:24 -0300
Subject: [net-next PATCH v11 9/9] net: dsa: realtek: rtl8365mb: add bridge
 port flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-realtek_forward-v11-9-50d60f5717e8@gmail.com>
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
In-Reply-To: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-293507-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3B102618F50
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
index 75317e47e32d..71bc91aff7be 100644
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
@@ -1554,6 +1569,49 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
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
@@ -2404,6 +2462,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -2589,6 +2652,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
 	.port_bridge_join = rtl83xx_port_bridge_join,
 	.port_bridge_leave = rtl83xx_port_bridge_leave,
+	.port_pre_bridge_flags = rtl8365mb_port_pre_bridge_flags,
+	.port_bridge_flags = rtl83xx_port_bridge_flags,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
@@ -2618,6 +2683,9 @@ static const struct realtek_ops rtl8365mb_ops = {
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
index 8b7154db3887..218de350918f 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/of_mdio.h>
+#include <linux/if_bridge.h>
 #include <linux/etherdevice.h>
 
 #include "realtek.h"
@@ -793,6 +794,106 @@ int rtl83xx_port_mdb_del(struct dsa_switch *ds, int port,
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


