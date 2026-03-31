Return-Path: <netdev+bounces-273782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBlAGP1SzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6086372979
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1042B30E5539
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5F46AEC7;
	Tue, 31 Mar 2026 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKzTr1+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B897466B64
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998064; cv=none; b=Xpmm+JsUJzHo8OA5TTh1BNkIzcohqfA+1j3qzL842aES0qcHI0ySf4Ms00Gx8Z9IB4Mc5HdMMBX74NwIDliWZErarCpatj97p0CYw0Q748GiHvDnEkx6/i/DKzBfpGGFXskwdaAnBMljIJZS6DIDVGu4TK4ZpwqM+ob0bRIgwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998064; c=relaxed/simple;
	bh=saMCRLvcAfVJd1CcnzEV9fSwr/on3STCPFcEkdYn+28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIR1vLK46jtJGW6claeDj/Qo1vY7runuXdmYP1FKECgrXjVlscBm+Xjbp686oNaglHF6TgQAQ1R7+EfdVvSJ31wAM4Xx+gaCMa+bq3dtU0iltKPzDoMLR9Pb9ukAdYX1AsS/1qTOe8wAeqXePOSVLH2H285jXDFXSsBYob3dsSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKzTr1+i; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56d89f35940so192263e0c.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998062; x=1775602862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLQtIV9wOsG2KyNPG3MRoTNeEqvzgHfhMrQmDCa9Iq0=;
        b=bKzTr1+iGxzBXzne44yv6OtYSqnH5xgI/kw4aC0fX03CBUTEuGttZ3H3tUFtcZVvqq
         dZ3Aw/0dYO9awf8FHhenQ86I9L/3fKiTfpQH0m+DVGEIojZZpHydBRKIGQxAhUAAZ5XS
         ePr/Vy6qy65zN4LIYEvlU1OcWIGgzpstJEiDVfZfGQI2w9jtljDd+DefaiUJz1zN2XCH
         3xCVqQiZlxHWpsVBTD9wxu6qt4w29kocM0QM29a9tztphmfOQ5o+nARKLBX7t1xtkXRA
         pXWwLS3Rjhu0z1iq4MtmtS702SG4cvDHdMVSIUdM+a12zTZujBgdSkWK590TVRDHS11J
         yODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998062; x=1775602862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RLQtIV9wOsG2KyNPG3MRoTNeEqvzgHfhMrQmDCa9Iq0=;
        b=Eoos8ATlP0GGNiGKmV1ygO0ZB2IqEwG/q/woMcQhHFFzthAn8BsiDQGoAQW5FnEYCW
         F08cQ2QD3/OPlgvo6xH0yfnxxjReOg1o7eikVSh1u/9SZCH0E03xjdA+V8OeewYm8F2J
         5C2P/OYd2+t6O1FuVvOcyH9CRI8VSnFaEduTq5M7OT9W1mnsbm7FapxA4IQq9f5LQFbo
         xqasRGzOcrlSGTcOwe7PSdWp+GLGzf3m4b8mWtPqwsFgTTmjfBgS1VdWEb0scD0TEQg5
         uXsZiRMe5ENPWG3FztXUa3C9NshsMfECQJBn72w3R48Fs388/vVEQ/5ufNIDuaZIKWD1
         FbdQ==
X-Gm-Message-State: AOJu0YydPr+WKuZIp/bNhH20aoJCxOrNGcXl8WCHLgZ6nK+GRCcYa6Do
	VXOPMNEshcKfQNw41KPtIIGvqXGc60xBRPtx+FEEn9ijmCqIzve2ARxS
X-Gm-Gg: ATEYQzyhI3HrZAmre+gUq3fm0XIrdTmtkALqo61l9U/MagYQc970fq0+QnFydd+5HhU
	UASp33is65JFNH85U4y3Ep2PItBNbvVldSc1Glb6Q8kkpCgN0mvsZvChtXTBlZGfyq4/6ck57mc
	5HVYiDPrTwV73exqjAd57pLqyjgTndfK0wzXf4vOvOlTJsI1UqrLuHnqiY4w1dF87M5zStTvMQL
	rn/KaRdwOTo+vlvecimSzDTzuz0AUTMGFVOT/9h4tZMNxhtJfLYowMRQODfpPCs1WQj4gI9fVAf
	dYROF8XfSF1WRE2BaNS7EHESrfS7eJ0abc6cAUaNtZSpVJ1romhjPlvHxFTX+zeuoXtKKIe1dIZ
	YJl3XXR8G3xu57UZBZvqT03AK/LHH3eOWVrSRUCOr3cxmvyjA/4L3+DNoNF8Fzy0973OF5oDVkD
	V7kTZksURURWc4BSvwAhmPCtqjt2ZfQY1y9sGSVg==
X-Received: by 2002:ac5:c9a8:0:b0:56b:8665:9da9 with SMTP id 71dfb90a1353d-56d8a93571fmr502585e0c.9.1774998061501;
        Tue, 31 Mar 2026 16:01:01 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:01:00 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Mar 2026 20:00:09 -0300
Subject: [net-next PATCH 09/10] net: dsa: realtek: rtl8365mb: add bridge
 port flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260331-realtek_forward-v1-9-44fb63033b7e@gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: E6086372979
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Add bridge port flags for:
- BR_LEARNING
- BR_FLOOD
- BR_MCAST_FLOOD
- BR_BCAST_FLOOD

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 125 +++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 0767b2704ad7..b26335c5b27e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -302,6 +302,21 @@
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
@@ -1641,6 +1656,97 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
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
+static int rtl8365mb_port_bridge_flags(struct dsa_switch *ds, int port,
+				       struct switchdev_brport_flags flags,
+				       struct netlink_ext_ack *exack)
+{
+	struct realtek_priv *priv = ds->priv;
+	int ret;
+
+	dev_dbg(priv->dev, "port_bridge_flags port:%d flags:%lx supported:%lx",
+		port, flags.mask, RTL8365MB_SUPPORTED_BRIDGE_FLAGS);
+
+	if (flags.mask & BR_LEARNING) {
+		bool learning_en = !!(flags.val & BR_LEARNING);
+
+		ret = rtl8365mb_port_set_learning(priv, port, learning_en);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_FLOOD) {
+		bool ucast_flood_en = !!(flags.val & BR_FLOOD);
+
+		ret = rtl8365mb_port_set_ucast_flood(priv, port,
+						     ucast_flood_en);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_MCAST_FLOOD) {
+		bool mcast_flood_en = !!(flags.val & BR_MCAST_FLOOD);
+
+		ret = rtl8365mb_port_set_mcast_flood(priv, port,
+						     mcast_flood_en);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_BCAST_FLOOD) {
+		bool bcast_flood_en = !!(flags.val & BR_BCAST_FLOOD);
+
+		ret = rtl8365mb_port_set_bcast_flood(priv, port,
+						     bcast_flood_en);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int rtl8365mb_port_set_efid(struct realtek_priv *priv, int port,
 				   u32 efid)
 {
@@ -1691,6 +1797,8 @@ static int rtl8365mb_port_bridge_join(struct dsa_switch *ds, int port,
 	int ret;
 	int i;
 
+	dev_dbg(priv->dev, "bridge %d join port %d\n", port, bridge.num);
+
 	/* Add this port to the isolation group of every other port
 	 * offloading this bridge.
 	 */
@@ -1730,6 +1838,8 @@ static void rtl8365mb_port_bridge_leave(struct dsa_switch *ds, int port,
 	u32 mask = 0;
 	int i;
 
+	dev_dbg(priv->dev, "bridge %d leave port %d\n", port, bridge.num);
+
 	/* Remove this port from the isolation group of every other
 	 * port offloading this bridge.
 	 */
@@ -2547,6 +2657,19 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		if (ret)
 			goto out_teardown_irq;
 
+		/* Enable all types of flooding */
+		ret = rtl8365mb_port_set_ucast_flood(priv, i, true);
+		if (ret)
+			goto out_teardown_irq;
+
+		ret = rtl8365mb_port_set_mcast_flood(priv, i, true);
+		if (ret)
+			goto out_teardown_irq;
+
+		ret = rtl8365mb_port_set_bcast_flood(priv, i, true);
+		if (ret)
+			goto out_teardown_irq;
+
 		/* Set up per-port private data */
 		p->priv = priv;
 		p->index = i;
@@ -2686,6 +2809,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
 	.port_bridge_join = rtl8365mb_port_bridge_join,
 	.port_bridge_leave = rtl8365mb_port_bridge_leave,
+	.port_pre_bridge_flags = rtl8365mb_port_pre_bridge_flags,
+	.port_bridge_flags = rtl8365mb_port_bridge_flags,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl8365mb_port_fast_age,
 	.port_fdb_add = rtl8365mb_port_fdb_add,

-- 
2.53.0


