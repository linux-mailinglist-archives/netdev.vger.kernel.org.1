Return-Path: <netdev+bounces-22534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E674767EEA
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D891282220
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D591156FE;
	Sat, 29 Jul 2023 11:55:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EC156FA
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:55:20 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379653A9B;
	Sat, 29 Jul 2023 04:55:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3159d5e409dso2961435f8f.0;
        Sat, 29 Jul 2023 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690631716; x=1691236516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHLFz16W399qVNmvmODIwvF+gqIhV8D9L51W9B+pCHU=;
        b=Br621R6EwRtzQT6Ufb7IowghliEuTMXwl2BnEk4nL11w0ApVeNiyGG2cM4kgrjZsNs
         vjka/PV1FQvEnCAy2BJcOrzuvbdAnak4gc2W5jrDfKmgiICweV4OZtBzRZ/MBgoL2umC
         j1i4+6X8rJVT8B1111JbxeRTrd+VccFWfVPRo0uljLQJUTxY3MQnhdnZXTsd3hmi7edb
         TolXVQIkfh1p9ptusG4BnjViVIFmD039mfzcMpvK5x4k10tLmYccvbmYg4xYqKTcVWGF
         f+HS4Nlp2JhJs9mNU8I+1AE+18SE8l7om6UXvuhmSuHJBmyJkiVyLoVz/SSSiMzzfZK6
         r9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690631716; x=1691236516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHLFz16W399qVNmvmODIwvF+gqIhV8D9L51W9B+pCHU=;
        b=Gzt4XT3JKRfKhnki9YWwZWzcPN/Bo4CbXDzR92J5qz0dZ9hi0ffI40NDAJ8ri0G+mT
         Hrz/R42lTbPEHJYG6WIIqZ6IdzQOEWVG8ACQMipNnCHhPDZXMbApWSnZwNmGu0xrOpt7
         EOxyieSKscnVDalKluywW45SE/zLdXC4NAHiTxwA4rMoRNAzIMPU4ZhcQPWenjG9b3It
         WMB4kDly/YRogaNsxfSfP3U2CPVp0Xj0uwlXVFGj4Ua0zg4ZJ98GEkWLqXt4YwXZcwep
         x5FkAl+u+0RvYParZriVMfTP8/JFHcBzAXi8wdfGP79ypkIqy/BPqa6SjxmlpGyGBO4z
         Jngg==
X-Gm-Message-State: ABy/qLaPis/g54eD8qlyP+EE4FuptepyYNx0kryh03dImVKOWSalE0f7
	QOL51Ovyc4oMugon1bnnd70=
X-Google-Smtp-Source: APBJJlEZfb+1HKrOt8uwZHmFIWoVKeUdfegkgXwY3mMJof4Mhq6mCRZ39Op8HrRAR3ycXbjmLqbV2g==
X-Received: by 2002:a5d:6388:0:b0:314:314e:fdda with SMTP id p8-20020a5d6388000000b00314314efddamr7469969wru.23.1690631716316;
        Sat, 29 Jul 2023 04:55:16 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm7295289wrv.71.2023.07.29.04.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 04:55:16 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Atin Bainada <hi@atinb.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [net-next PATCH v2 2/5] net: dsa: qca8k: make learning configurable and keep off if standalone
Date: Sat, 29 Jul 2023 13:55:06 +0200
Message-Id: <20230729115509.32601-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230729115509.32601-1-ansuelsmth@gmail.com>
References: <20230729115509.32601-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Address learning should initially be turned off by the driver for port
operation in standalone mode, then the DSA core handles changes to it
via ds->ops->port_bridge_flags().

Currently this is not the case for qca8k where learning is enabled
unconditionally in qca8k_setup for every user port.

Handle ports configured in standalone mode by making the learning
configurable and not enabling it by default.

Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
enable learning for bridge that request it and tweak
.port_stp_state_set to correctly disable learning when port is
configured in standalone mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   |  7 +++--
 drivers/net/dsa/qca/qca8k-common.c | 48 ++++++++++++++++++++++++++++++
 drivers/net/dsa/qca/qca8k.h        |  6 ++++
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ae088a4df794..31552853fdd4 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1870,9 +1870,8 @@ qca8k_setup(struct dsa_switch *ds)
 			if (ret)
 				return ret;
 
-			/* Enable ARP Auto-learning by default */
-			ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
-					      QCA8K_PORT_LOOKUP_LEARN);
+			ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
+						QCA8K_PORT_LOOKUP_LEARN);
 			if (ret)
 				return ret;
 
@@ -1978,6 +1977,8 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.port_change_mtu	= qca8k_port_change_mtu,
 	.port_max_mtu		= qca8k_port_max_mtu,
 	.port_stp_state_set	= qca8k_port_stp_state_set,
+	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
+	.port_bridge_flags	= qca8k_port_bridge_flags,
 	.port_bridge_join	= qca8k_port_bridge_join,
 	.port_bridge_leave	= qca8k_port_bridge_leave,
 	.port_fast_age		= qca8k_port_fast_age,
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13b8452ce5b2..fce04ce12cf9 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -565,9 +565,26 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
+					 bool learning)
+{
+	struct qca8k_priv *priv = ds->priv;
+
+	if (learning)
+		return regmap_set_bits(priv->regmap,
+				       QCA8K_PORT_LOOKUP_CTRL(port),
+				       QCA8K_PORT_LOOKUP_LEARN);
+	else
+		return regmap_clear_bits(priv->regmap,
+					 QCA8K_PORT_LOOKUP_CTRL(port),
+					 QCA8K_PORT_LOOKUP_LEARN);
+}
+
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct qca8k_priv *priv = ds->priv;
+	bool learning = false;
 	u32 stp_state;
 
 	switch (state) {
@@ -582,8 +599,11 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 		break;
 	case BR_STATE_LEARNING:
 		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
+		learning = dp->learning;
 		break;
 	case BR_STATE_FORWARDING:
+		learning = dp->learning;
+		fallthrough;
 	default:
 		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
 		break;
@@ -591,6 +611,34 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
 		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
+
+	qca8k_port_configure_learning(ds, port, learning);
+}
+
+int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				struct switchdev_brport_flags flags,
+				struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~BR_LEARNING)
+		return -EINVAL;
+
+	return 0;
+}
+
+int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
+			    struct switchdev_brport_flags flags,
+			    struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	if (flags.mask & BR_LEARNING) {
+		ret = qca8k_port_configure_learning(ds, port,
+						    flags.val & BR_LEARNING);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index c5cc8a172d65..8f88b7db384d 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -522,6 +522,12 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
 
 /* Common bridge function */
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
+int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				struct switchdev_brport_flags flags,
+				struct netlink_ext_ack *extack);
+int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
+			    struct switchdev_brport_flags flags,
+			    struct netlink_ext_ack *extack);
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 			   struct dsa_bridge bridge,
 			   bool *tx_fwd_offload,
-- 
2.40.1


