Return-Path: <netdev+bounces-290648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAkUDWPAD2pwPQYAu9opvQ
	(envelope-from <netdev+bounces-290648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:33:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 282A25AE05B
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A9A930118CF
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99430CD81;
	Fri, 22 May 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG7uXag+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31B30F806
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417137; cv=none; b=I3X/UH+Mince6CjXuFAMmCLtugiV4DhieYFBCwkLEmb958/u2QptN2CPflSEFAon3eCpaFHk5RqtB3bK5njwVLI7c9oChAc8VYRzcC53kD9bS1sU29LrVdlDywzuxq6ynn+hDsqxB9/on936YmdMHQBrMl+vqMhLExDMYtbJEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417137; c=relaxed/simple;
	bh=naLlkgz9DBv6vD0ttV70npYt+SAVwP3pfDXKYAi29tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGgY6gSRXUn4JBdpCPqJi2DvELju+Za8YjqNvj1Zft30QnBG2QI4y8DB+6YlTiQVZ+Gfiwtx28rMmHoA007cTt4FxtIuXbgedVBMftK+2LVX7FXZSmjVL8quozWFnuhGgAikChFgSb3zYvYe47KM5zphlcf6cuKITlJXzs/gEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG7uXag+; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-575267e3398so5614512e0c.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 19:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779417134; x=1780021934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69z0KLuVUqkJj4huRrzXT7b90JzBGhyKX3v0GKKTDmI=;
        b=SG7uXag+ELiqtGjLROh5KNwryAOS3bQqHqj2c3N7y8vpUzXUV+rKDKBidq/eEJst9o
         Y0//wC4TZfi/SUD/e8Nt9zryihgsb4VFPCkm6VTYgXJCgbeLpMD4k1UTj1v698/kMYhO
         KkinuMc2edlPoKGFXoRrbVBiqx4k2215TF+XlJDvxKOlh3jZR0VqlRM97gAgvuq2kxu8
         wJwY7fH1Z6Pll5lEb9z3nLD/LWU76RXSpN4cGwKLD+sNnunXD0fJljnbpNZQ1ZO80EWA
         jN+gO6o8f6L2/EJD5EcKPzOUlgyZj0Sy3zai3Frl28KAFyxCwoGdMdFlZnmOSavmPXJj
         2jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779417134; x=1780021934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=69z0KLuVUqkJj4huRrzXT7b90JzBGhyKX3v0GKKTDmI=;
        b=H7xvpjIQbCSA08HO4wXu7VMYEjOU4XmJKEDU5X/npVU8ifUnXKySvllXL+VXAfG0bU
         b/tH5CsJyk1cZU6xRFgVOIAyJkEQA5oni0HlzTyaSIPLBFxiQPTchVixjVwp9Ff7h2u9
         lKKwgthOt/3LIg/H2lzKCUBnTPK5FEQSCMa2PX/T3AGvT57hGcknCtqs3LTT9ij3/cX7
         ZQtuY8hNfpI86J5rUYed17GxzVgagpw5/K4nGEVW0y0+U0c09ADRMuQNSRzrbCs7Mcrg
         M0EiEGvsBayFMBoDgksL16GYmkdIoFWOvAOCwjeVOf7D9mpGsGK3QDA3Ph96SpoiTapZ
         cmMA==
X-Gm-Message-State: AOJu0Yx1VoOkyG/aQJt2SXqbH+o7BuODzEHuysudsrBSNRNEcPjjAzyr
	zUaxeGgndktfLZuNUJuJbFrwXAQMnxW1G/+ZNQnVIBbmgB14ytowcIHS
X-Gm-Gg: Acq92OEd0E5rlohW2wexRXbGWMZqaUCYzYDVpMV4yjWijcRjh6YCRPjV9HTqlOEqm4u
	fHRVc8WQocWICfyClKnDcBSaE1cEKPWk2cqYqSaWbyLLWFxW26ar2Rq+TA0GB7sA9v5j7PliOuC
	smtRmrEv6Fy8FUZVrtFMe4OQzLUgdjYrvVGpfwGftpTfejSBUc+FAtk3SJxrMKxjIUKvyrA/Vy8
	FoS6gVrd8ODX0OPnslE93ui8aByP9ISW2r46mccYQ2/0h4H15hRBbZW7z3Q5j1BYR0OAcG7dsqN
	oXnJVoRn/szwFwZuAuZylWpCkPUVh46Ap1HUzOZ7s/4OYPsE539HwCqpHVirD8rXu38Kxez36nS
	WC2eU/f60Ia480iA7Hd5wHIlM5UuxA/eUtd0qExEzkPGAl//KrI9YzB0+lzhHzZuze8Qlhb/XPQ
	GxRXW2sHb83/WfeH7q84p3ZYrlC4YriFEamCDT8SI=
X-Received: by 2002:a05:6122:17a6:b0:575:cbe6:8416 with SMTP id 71dfb90a1353d-58663a5c6c2mr996763e0c.14.1779417134259;
        Thu, 21 May 2026 19:32:14 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm640709e0c.5.2026.05.21.19.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:32:13 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 May 2026 23:31:15 -0300
Subject: [net-next PATCH v6 6/8] net: dsa: realtek: rtl8365mb: add
 port_bridge_{join,leave}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-realtek_forward-v6-6-d391bbad38c3@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290648-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,bang-olufsen.dk:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 282A25AE05B
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
 drivers/net/dsa/realtek/realtek.h        |   5 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  57 ++++++++++++-
 drivers/net/dsa/realtek/rtl83xx.c        | 141 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h        |   7 ++
 4 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index b9c4cbdd72fb..e0079752f296 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -112,6 +112,11 @@ struct realtek_ops {
 	int	(*enable_vlan)(struct realtek_priv *priv, bool enable);
 	int	(*enable_vlan4k)(struct realtek_priv *priv, bool enable);
 	int	(*enable_port)(struct realtek_priv *priv, int port, bool enable);
+	int	(*port_add_isolation)(struct realtek_priv *priv, int port,
+				      u32 mask);
+	int	(*port_remove_isolation)(struct realtek_priv *priv, int port,
+					 u32 mask);
+	int	(*port_set_efid)(struct realtek_priv *priv, int port, u32 efid);
 	int	(*phy_read)(struct realtek_priv *priv, int phy, int regnum);
 	int	(*phy_write)(struct realtek_priv *priv, int phy, int regnum,
 			     u16 val);
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index c669ca6e2a71..91282cd39487 100644
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
@@ -1521,10 +1530,44 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
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
@@ -2316,6 +2359,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -2384,6 +2432,8 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
+	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
+	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
 	ds->configure_vlan_while_not_filtering = true;
 
 	/* Set up VLAN */
@@ -2500,6 +2550,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.setup = rtl8365mb_setup,
 	.teardown = rtl8365mb_teardown,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
+	.port_bridge_join = rtl83xx_port_bridge_join,
+	.port_bridge_leave = rtl83xx_port_bridge_leave,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_vlan_add = rtl8365mb_port_vlan_add,
 	.port_vlan_del = rtl8365mb_port_vlan_del,
@@ -2519,6 +2571,9 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 
 static const struct realtek_ops rtl8365mb_ops = {
 	.detect = rtl8365mb_detect,
+	.port_add_isolation = rtl8365mb_port_add_isolation,
+	.port_remove_isolation = rtl8365mb_port_remove_isolation,
+	.port_set_efid = rtl8365mb_port_set_efid,
 	.phy_read = rtl8365mb_phy_read,
 	.phy_write = rtl8365mb_phy_write,
 };
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 93bc47dfe7f7..126a5405272b 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -326,6 +326,147 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
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
+	/* Use the bridge number as the EFID for this port */
+	if (priv->ops->port_set_efid) {
+		ret = priv->ops->port_set_efid(priv, port, bridge.num);
+		if (ret)
+			goto undo_self_isolation;
+	}
+
+	return 0;
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


