Return-Path: <netdev+bounces-14388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE236740884
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 04:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E5A1C20B3E
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 02:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63087E1;
	Wed, 28 Jun 2023 02:44:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1101FAB
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 02:44:09 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id BAE392D53;
	Tue, 27 Jun 2023 19:43:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 0F39E6032EB52;
	Wed, 28 Jun 2023 10:43:52 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: wuych <yunchuan@nfschina.com>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: yangyingliang@huawei.com,
	yunchuan@nfschina.com,
	linux@rempel-privat.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next 01/10] net: dsa: ar9331: remove unnecessary (void*) conversions
Date: Wed, 28 Jun 2023 10:43:50 +0800
Message-Id: <20230628024350.1439849-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pointer variables of void * type do not require type cast.

Signed-off-by: wuych <yunchuan@nfschina.com>
---
 drivers/net/dsa/qca/ar9331.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
index e7b98b864fa1..b2bf78ac485e 100644
--- a/drivers/net/dsa/qca/ar9331.c
+++ b/drivers/net/dsa/qca/ar9331.c
@@ -391,7 +391,7 @@ static int ar9331_sw_mbus_init(struct ar9331_sw_priv *priv)
 
 static int ar9331_sw_setup_port(struct dsa_switch *ds, int port)
 {
-	struct ar9331_sw_priv *priv = (struct ar9331_sw_priv *)ds->priv;
+	struct ar9331_sw_priv *priv = ds->priv;
 	struct regmap *regmap = priv->regmap;
 	u32 port_mask, port_ctrl, val;
 	int ret;
@@ -439,7 +439,7 @@ static int ar9331_sw_setup_port(struct dsa_switch *ds, int port)
 
 static int ar9331_sw_setup(struct dsa_switch *ds)
 {
-	struct ar9331_sw_priv *priv = (struct ar9331_sw_priv *)ds->priv;
+	struct ar9331_sw_priv *priv = ds->priv;
 	struct regmap *regmap = priv->regmap;
 	int ret, i;
 
@@ -484,7 +484,7 @@ static int ar9331_sw_setup(struct dsa_switch *ds)
 
 static void ar9331_sw_port_disable(struct dsa_switch *ds, int port)
 {
-	struct ar9331_sw_priv *priv = (struct ar9331_sw_priv *)ds->priv;
+	struct ar9331_sw_priv *priv = ds->priv;
 	struct regmap *regmap = priv->regmap;
 	int ret;
 
@@ -527,7 +527,7 @@ static void ar9331_sw_phylink_mac_config(struct dsa_switch *ds, int port,
 					 unsigned int mode,
 					 const struct phylink_link_state *state)
 {
-	struct ar9331_sw_priv *priv = (struct ar9331_sw_priv *)ds->priv;
+	struct ar9331_sw_priv *priv = ds->priv;
 	struct regmap *regmap = priv->regmap;
 	int ret;
 
@@ -542,7 +542,7 @@ static void ar9331_sw_phylink_mac_link_down(struct dsa_switch *ds, int port,
 					    unsigned int mode,
 					    phy_interface_t interface)
 {
-	struct ar9331_sw_priv *priv = (struct ar9331_sw_priv *)ds->priv;
+	struct ar9331_sw_priv *priv = ds->priv;
 	struct ar9331_sw_port *p = &priv->port[port];
 	struct regmap *regmap = priv->regmap;
 	int ret;
@@ -562,7 +562,7 @@ static void ar9331_sw_phylink_mac_link_up(struct dsa_switch *ds, int port,
 					  int speed, int duplex,
 					  bool tx_pause, bool rx_pause)
 {
-	struct ar9331_sw_priv *priv = (struct ar9331_sw_priv *)ds->priv;
+	struct ar9331_sw_priv *priv = ds->priv;
 	struct ar9331_sw_port *p = &priv->port[port];
 	struct regmap *regmap = priv->regmap;
 	u32 val;
@@ -665,7 +665,7 @@ static void ar9331_do_stats_poll(struct work_struct *work)
 static void ar9331_get_stats64(struct dsa_switch *ds, int port,
 			       struct rtnl_link_stats64 *s)
 {
-	struct ar9331_sw_priv *priv = (struct ar9331_sw_priv *)ds->priv;
+	struct ar9331_sw_priv *priv = ds->priv;
 	struct ar9331_sw_port *p = &priv->port[port];
 
 	spin_lock(&p->stats_lock);
@@ -676,7 +676,7 @@ static void ar9331_get_stats64(struct dsa_switch *ds, int port,
 static void ar9331_get_pause_stats(struct dsa_switch *ds, int port,
 				   struct ethtool_pause_stats *pause_stats)
 {
-	struct ar9331_sw_priv *priv = (struct ar9331_sw_priv *)ds->priv;
+	struct ar9331_sw_priv *priv = ds->priv;
 	struct ar9331_sw_port *p = &priv->port[port];
 
 	spin_lock(&p->stats_lock);
-- 
2.30.2


