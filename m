Return-Path: <netdev+bounces-291441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGOKNuWnFGrtPAcAu9opvQ
	(envelope-from <netdev+bounces-291441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:49:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD65CE237
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B34D30387A5
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D7D390C81;
	Mon, 25 May 2026 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhqFCHgA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC53932EE
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738526; cv=none; b=m7PRKF3sYwBxCpl01cmpGLJADRUCp/N3ULsf1S9AJyG/U0KFoJyoSp0xa5IdgyC4fWdo9dCvIpqa9NdF2ZrbWU3Pv/OQy5z5rSHoSyN5/jrDq/4zIMOkIEjVTBju48Dg9ULkaf+TGXLgf9XMsCCklEzzWSPujvSYO8R3YnnztJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738526; c=relaxed/simple;
	bh=2zqJ8QJy4ge/MjbwAvJXtcVrLywReo9XXcM/Fp1pXPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=So0Sfpt4+nRqNkeow66/68HdW0mkSbzhW05M2/5nwHHnrfjC93+D21E1hojXroG47ZIswbdmqGULtp2/hBTN35mpnlU1EPIYDHAs0hIWxuYkOC+vkudPEmHhsbXnUgXrCNYPfl/9roR7gnUcEgckgLtVOGMKvaggT2u/zGid4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhqFCHgA; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-95cc3522c40so7033107241.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738523; x=1780343323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXnSH6n3y2btDlDvWiWJ5S+rnyM/aJwZbN87RdLfDlE=;
        b=fhqFCHgAsyUZD6odHlkivmt/DI3kJgcc2iV57hy+Olo8wvybOPG5ZoHXcdQ39rYS8b
         h50m72SaAMI56N5DLFNoXmT5kAtyh/rLRiiWpyiV2D56DwPcj8JNAHKk/9MaMiNygjUs
         XsQaPvXEMggsR2fjxeNTKkKyTSzeeiu87Zwhha7R/XyagMMtpRsckyjfncwM2xXnB/b5
         9zyWk9Ip+GwpJGmleklJhzXNixJOlwE2NuYcx9ueC+JOE1kBmyM/IoKrCQlDf23ihLWs
         wK6fjP7pHv57Xi9m3UB1anciF8nOrbT5b1JvLvpTzuPoqnTlYuygo4ayNgK/OhOQ/StR
         Dn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738523; x=1780343323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vXnSH6n3y2btDlDvWiWJ5S+rnyM/aJwZbN87RdLfDlE=;
        b=peozkvZi3rV9qH+Tq6PH9iooKbSiI5sKby78kXXJo4IC+6TYdi2ZulwoNflIFabDw6
         /ivHF7ByavxpuGQMzpJWlZ3I9SL46IckIhFwvYNSYpwlshnVR9ph67Agr888UIqDNitQ
         IgMiu+ScWuYMovWYNBN+NkiyexfTJPKxnzdM6IkZDL1OgRUj+HdIWYK4xZPSP3ZI6J7X
         aXnLAuWSp1z0eW1is27ftrYvvlo7DgVX3AWkgaFIAx+eseTbO946BM8ZOR/geiTydokR
         VoDxk6F1RsLknIYiybev6o/a4SinLwxEG4v5XIBybLPQKRXlO97C/39lTo+3rkMGu2Bo
         iCyg==
X-Gm-Message-State: AOJu0Yw4i/xXec459DNecaqoSzh5uWV4x/xnyDyIJhsE6JlzyL7BZngB
	iBUkBZH9tWzr7d7JIylRb0zyVhDDfXvdxrgbb/wFmSlUU66+G931P5K5
X-Gm-Gg: Acq92OH5wqKj7Na9ia2p+dIdMr9kehhnmbzFUu1tXxCmWtF+/WVgtUzbvRKHzb/JvnF
	4F3lGbayd/st3M7FsD9FGNSjEutHeQGb1wdH2n8Kxt/dh/IrY8/NYSXIprFot5YtBzi71iuGYsC
	AJ0PoDnEKATLvoPifSSeVALtiN5D2phsDCpgOBM+1FFK52BRlcVRf7r3bKsVBfBz1rel26U8wEl
	ZEmgmC2SaPumEBoEobmwjSU4CsyWOlHqBHXQSvhMTd631CxzWvhba58iQV6kj8nwhIGFQ2nMs+N
	okVDD+Ed8YPL1XmQBKZTLGo09B6qj82RUm/cZd29N2OPpu87nESRljAbYRI5q7r5shnTvIqb4q6
	9U/z2J/r2J5DoyJiUUHfC7hHWdKB8MlYnsCjcEpdrudSAJwLU+BSkocY7ctjyVUbdw0ayTJrurZ
	4TeDizws9XJjPHsECDm2OU7LrhdgXj2x4545HVRg==
X-Received: by 2002:a05:6102:e12:b0:631:b834:e054 with SMTP id ada2fe7eead31-67c751b2451mr8378928137.11.1779738522826;
        Mon, 25 May 2026 12:48:42 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173af3e82sm11092456241.10.2026.05.25.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:48:42 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 25 May 2026 16:48:02 -0300
Subject: [net-next PATCH v8 6/8] net: dsa: realtek: rtl8365mb: add
 port_bridge_{join,leave}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260525-realtek_forward-v8-6-5eb80a4675be@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291441-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,bang-olufsen.dk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 92BD65CE237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Implement hardware offloading of bridge functionality. This is achieved
by using the per-port isolation registers, which contain a forwarding
port mask. The switch will refuse to forward packets ingressed on a
given port to a port which is not in its forwarding mask.

For each bridge that is offloaded, use the DSA-provided bridge number
for the Extended Filtering ID (EFID). When using Independent VLAN
Learning (IVL), the forwarding database is keyed with the tuple
{VID, MAC, EFID}. There are 8 EFIDs available (0~7), but we reserve the
default EFID 0 for standalone ports where learning is disabled. This
fits nicely because DSA indexes the bridge number starting from 1.

Because of the limited number of EFIDs, we have to set the
max_num_bridges property of our switch to 7: we can't offload more than
that or we will fail to offer IVL as at least two bridges would end up
having to share an EFID.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek.h        |   7 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  58 +++++++++++-
 drivers/net/dsa/realtek/rtl83xx.c        | 156 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h        |   7 ++
 4 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index b9c4cbdd72fb..c271a15a9ae2 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -112,6 +112,13 @@ struct realtek_ops {
 	int	(*enable_vlan)(struct realtek_priv *priv, bool enable);
 	int	(*enable_vlan4k)(struct realtek_priv *priv, bool enable);
 	int	(*enable_port)(struct realtek_priv *priv, int port, bool enable);
+	int	(*port_add_isolation)(struct realtek_priv *priv, int port,
+				      u32 mask);
+	int	(*port_remove_isolation)(struct realtek_priv *priv, int port,
+					 u32 mask);
+	int	(*port_set_efid)(struct realtek_priv *priv, int port, u32 efid);
+	int	(*port_set_learning)(struct realtek_priv *priv, int port,
+				     bool enable);
 	int	(*phy_read)(struct realtek_priv *priv, int phy, int regnum);
 	int	(*phy_write)(struct realtek_priv *priv, int phy, int regnum,
 			     u16 val);
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 334bb6a02310..e2c0fe3f08fb 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -285,6 +285,15 @@
 		(RTL8365MB_PORT_ISOLATION_REG_BASE + (_physport))
 #define   RTL8365MB_PORT_ISOLATION_MASK			0x07FF
 
+/* Extended filter ID registers - used to key forwarding database with IVL */
+#define RTL8365MB_EFID_MASK			GENMASK(2, 0)
+#define RTL8365MB_PORT_EFID_REG_BASE		0x0A32
+#define RTL8365MB_PORT_EFID_REG(_p) \
+		(RTL8365MB_PORT_EFID_REG_BASE + ((_p) >> 2))
+#define   RTL8365MB_PORT_EFID_OFFSET(_p)	(((_p) & 0x3) << 2)
+#define   RTL8365MB_PORT_EFID_MASK(_p) \
+		(RTL8365MB_EFID_MASK << RTL8365MB_PORT_EFID_OFFSET(_p))
+
 /* MSTP port state registers - indexed by tree instance */
 #define RTL8365MB_MSTI_CTRL_BASE			0x0A00
 #define RTL8365MB_MSTI_CTRL_REG(_msti, _physport) \
@@ -1519,10 +1528,44 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
 			    enable ? RTL8365MB_LEARN_LIMIT_MAX : 0);
 }
 
+static int rtl8365mb_port_set_efid(struct realtek_priv *priv, int port,
+				   u32 efid)
+{
+	return regmap_update_bits(priv->map, RTL8365MB_PORT_EFID_REG(port),
+				  RTL8365MB_PORT_EFID_MASK(port),
+				  efid << RTL8365MB_PORT_EFID_OFFSET(port));
+}
+
+/* Port isolation manipulation functions.
+ *
+ * The port isolation register controls the forwarding mask of a given
+ * port. The switch will not forward packets ingressed on a given port
+ * to ports which are not enabled in its forwarding mask.
+ *
+ * The port forwarding mask has the highest priority in forwarding
+ * decisions. The only exception to this rule is when the switch
+ * receives a packet on its CPU port with ALLOW=0. In that case the TX
+ * field of the CPU tag will override the forwarding port mask.
+ */
 static int rtl8365mb_port_set_isolation(struct realtek_priv *priv, int port,
 					u32 mask)
 {
-	return regmap_write(priv->map, RTL8365MB_PORT_ISOLATION_REG(port), mask);
+	return regmap_write(priv->map, RTL8365MB_PORT_ISOLATION_REG(port),
+			    mask);
+}
+
+static int rtl8365mb_port_add_isolation(struct realtek_priv *priv, int port,
+					u32 mask)
+{
+	return regmap_update_bits(priv->map, RTL8365MB_PORT_ISOLATION_REG(port),
+				  mask, mask);
+}
+
+static int rtl8365mb_port_remove_isolation(struct realtek_priv *priv, int port,
+					   u32 mask)
+{
+	return regmap_update_bits(priv->map, RTL8365MB_PORT_ISOLATION_REG(port),
+				  mask, 0);
 }
 
 static int rtl8365mb_mib_counter_read(struct realtek_priv *priv, int port,
@@ -2324,6 +2367,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		if (ret)
 			goto out_teardown_irq;
 
+		/* Set the default EFID 0 for standalone mode */
+		ret = rtl8365mb_port_set_efid(priv, dp->index, 0);
+		if (ret)
+			goto out_teardown_irq;
+
 		/* Disable learning */
 		ret = rtl8365mb_port_set_learning(priv, dp->index, false);
 		if (ret)
@@ -2392,6 +2440,8 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
+	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
+	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
 	ds->configure_vlan_while_not_filtering = true;
 
 	/* Set up VLAN */
@@ -2508,6 +2558,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.setup = rtl8365mb_setup,
 	.teardown = rtl8365mb_teardown,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
+	.port_bridge_join = rtl83xx_port_bridge_join,
+	.port_bridge_leave = rtl83xx_port_bridge_leave,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_vlan_add = rtl8365mb_port_vlan_add,
 	.port_vlan_del = rtl8365mb_port_vlan_del,
@@ -2527,6 +2579,10 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 
 static const struct realtek_ops rtl8365mb_ops = {
 	.detect = rtl8365mb_detect,
+	.port_add_isolation = rtl8365mb_port_add_isolation,
+	.port_remove_isolation = rtl8365mb_port_remove_isolation,
+	.port_set_efid = rtl8365mb_port_set_efid,
+	.port_set_learning = rtl8365mb_port_set_learning,
 	.phy_read = rtl8365mb_phy_read,
 	.phy_write = rtl8365mb_phy_write,
 };
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 93bc47dfe7f7..089fac660829 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -326,6 +326,162 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
 	gpiod_set_value(priv->reset, false);
 }
 
+/**
+ * rtl83xx_port_bridge_join() - join a port to a bridge
+ * @ds: DSA switch instance
+ * @port: port index
+ * @bridge: bridge being joined
+ * @tx_forward_offload: if the switch can offload TX forwarding
+ * @extack: netlink extended ack for reporting errors
+ *
+ * This function handles joining a port to a bridge. It updates the port
+ * isolation masks and EFID.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
+			     struct dsa_bridge bridge,
+			     bool *tx_forward_offload,
+			     struct netlink_ext_ack *extack)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	u32 mask = 0;
+	int ret;
+
+	if (!priv->ops->port_add_isolation)
+		return -EOPNOTSUPP;
+
+	if (!priv->ops->port_set_learning)
+		return -EOPNOTSUPP;
+
+	dev_dbg(priv->dev, "bridge %d join port %d\n", bridge.num, port);
+
+	/* Add this port to the isolation group of every other port
+	 * offloading this bridge.
+	 */
+	dsa_switch_for_each_user_port(dp, ds) {
+		/* Handle this port after */
+		if (dp->index == port)
+			continue;
+
+		/* Skip ports that are not in this bridge */
+		if (!dsa_port_offloads_bridge(dp, &bridge))
+			continue;
+
+		ret = priv->ops->port_add_isolation(priv, dp->index, BIT(port));
+		if (ret)
+			goto undo_isolation;
+
+		mask |= BIT(dp->index);
+	}
+
+	/* If we support cascade switches, it should also include the
+	 * downstream DSA ports to the isolation group.
+	 */
+
+	/* Add those ports to the isolation group of this port */
+	ret = priv->ops->port_add_isolation(priv, port, mask);
+	if (ret)
+		goto undo_isolation;
+
+	ret = priv->ops->port_set_learning(priv, port, true);
+	if (ret)
+		goto undo_self_isolation;
+
+	/* Use the bridge number as the EFID for this port */
+	if (priv->ops->port_set_efid) {
+		ret = priv->ops->port_set_efid(priv, port, bridge.num);
+		if (ret)
+			goto undo_learning;
+	}
+
+	return 0;
+
+undo_learning:
+	priv->ops->port_set_learning(priv, port, false);
+
+undo_self_isolation:
+	priv->ops->port_remove_isolation(priv, port, mask);
+
+undo_isolation:
+	dsa_switch_for_each_port_continue_reverse(dp, ds) {
+		if (dp->index == port)
+			continue;
+
+		if (!dsa_port_offloads_bridge(dp, &bridge))
+			continue;
+
+		if (!dsa_port_is_user(dp))
+			continue;
+
+		priv->ops->port_remove_isolation(priv, dp->index, BIT(port));
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_bridge_join, "REALTEK_DSA");
+
+/**
+ * rtl83xx_port_bridge_leave() - leave a bridge
+ * @ds: DSA switch instance
+ * @port: port index
+ * @bridge: bridge being left
+ *
+ * This function handles removing a port from a bridge. It updates the port
+ * isolation masks and EFID.
+ *
+ * Context: Can sleep.
+ * Return: nothing
+ */
+void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
+			       struct dsa_bridge bridge)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	u32 mask = 0;
+
+	if (!priv->ops->port_remove_isolation)
+		return;
+
+	if (!priv->ops->port_set_learning)
+		return;
+
+	dev_dbg(priv->dev, "bridge %d leave port %d\n", bridge.num, port);
+
+	/* Remove this port from the isolation group of every other
+	 * port offloading this bridge.
+	 */
+	dsa_switch_for_each_user_port(dp, ds) {
+		/* Handle this port after */
+		if (dp->index == port)
+			continue;
+
+		/* Skip ports that are not in this bridge */
+		if (!dsa_port_offloads_bridge(dp, &bridge))
+			continue;
+
+		priv->ops->port_remove_isolation(priv, dp->index, BIT(port));
+
+		mask |= BIT(dp->index);
+	}
+
+	/* If we support cascade switches, it should also exclude the
+	 * downstream DSA ports from the isolation group.
+	 */
+
+	priv->ops->port_set_learning(priv, port, false);
+
+	/* Remove those ports from the isolation group of this port */
+	priv->ops->port_remove_isolation(priv, port, mask);
+
+	/* Revert to the default EFID 0 for standalone mode */
+	if (priv->ops->port_set_efid)
+		priv->ops->port_set_efid(priv, port, 0);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_bridge_leave, "REALTEK_DSA");
+
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index c8a0ff8fd75e..2481a1aaa226 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -21,4 +21,11 @@ void rtl83xx_remove(struct realtek_priv *priv);
 void rtl83xx_reset_assert(struct realtek_priv *priv);
 void rtl83xx_reset_deassert(struct realtek_priv *priv);
 
+int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
+			     struct dsa_bridge bridge,
+			     bool *tx_forward_offload,
+			     struct netlink_ext_ack *extack);
+void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
+			       struct dsa_bridge bridge);
+
 #endif /* _RTL83XX_H */

-- 
2.54.0


