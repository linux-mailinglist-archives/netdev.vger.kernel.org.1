Return-Path: <netdev+bounces-210393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE6B1310F
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 20:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0706B7A0253
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF022616C;
	Sun, 27 Jul 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="uk/wlKm7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF498224AF0
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639410; cv=none; b=RGwi+SUt259Nuug58G3ITQaeI4h51+ZYB0z14rD2lMR+I59C6qwkGlQ1R0cYeZRGy/w/zZKnZ0LxGyC8zuF4wboRC0EXZefIZDmCeb6SUtihi+Su0ION/yUnNdggbgMutKS89exZwTz2jDJGeW/mLIEYlVhrW820kE2w5XS195Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639410; c=relaxed/simple;
	bh=38m2SPryUnJAv/Hzt+CHmkXIGXr7hdL8wmqIXo2Ec7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mh7xP5k20gZkwrZ2nurtR2iUKz3CSGU5B1eKtGIVY2r5eBv8Bol63m04J43xJKSd2g3XzZznlUTKBK4j3Liu1GQGqAgphAj7g2eAWalTFJTvfTzSKcZAnmVgPUjcUmtGhyMOTAmD0dkXqf4Prg/0A1WpRbZNmGhNjx7rrm5UXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=uk/wlKm7; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753639408; bh=YWL3aOX28KQzuVWsTQMiXAVfLLtLJhYtG+UmgpEGycA=;
 b=uk/wlKm7RpLjrRSXSgjCdMwV66XlSZn1OBQ67zaKg1wuxd+mBAR+QK+Jee2nkOjs6O3PVxJVV
 2Ud2bszE1rKb2ssGKB/FSxTlEs98TaJXRubCsome6SQJCnDrPJ2IkpBYKuXWGKeMn2pwLX2ijo4
 yehkIo06l+bQ3lVMHJ70pUvwq3/esfNNUXe708vV6SyaGw05fH4P81TPJTIrbPNNfHaK6X2mZRl
 RGPvcumSF7fRQSH6HOI7kPbfDeomjOQWNkJhRMWSbp6/Nq22liawml9M18p91+ePTz1SeeJY3Os
 1yoMyJ1QDj0Bq+Dl+Toe8iVWWzS5oYbmzCV7qzF9qGrg==
X-Forward-Email-ID: 688669e9c509b9ee169cf326
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH net-next 2/3] net: dsa: realtek: Add support for use of an optional mdio node
Date: Sun, 27 Jul 2025 18:02:59 +0000
Message-ID: <20250727180305.381483-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250727180305.381483-1-jonas@kwiboo.se>
References: <20250727180305.381483-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dt-bindings schema for Realtek switches for unmanaged switches
contains a restriction on use of a mdio child OF node for MDIO-connected
switches, i.e.:

  if:
    required:
      - reg
  then:
    not:
      required:
        - mdio
    properties:
      mdio: false

However, the driver currently requires the existence of a mdio child OF
node to successfully probe and properly function.

Relax the requirement of a mdio child OF node and assign the dsa_switch
user_mii_bus to allow a MDIO-connected switch to probe and function
when a mdio child OF node is missing.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dsa/realtek/rtl83xx.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 9a05616acea8..47a09b27c4fa 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/of_mdio.h>
@@ -64,7 +65,7 @@ static int rtl83xx_user_mdio_write(struct mii_bus *bus, int addr, int regnum,
  * @ds: DSA switch associated with this user_mii_bus
  *
  * Registers the MDIO bus for built-in Ethernet PHYs, and associates it with
- * the mandatory 'mdio' child OF node of the switch.
+ * the optional 'mdio' child OF node of the switch.
  *
  * Context: Can sleep.
  * Return: 0 on success, negative value for failure.
@@ -75,11 +76,14 @@ int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
 	struct device_node *mdio_np;
 	struct mii_bus *bus;
 	int ret = 0;
+	int irq;
+	int i;
 
 	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
-	if (!mdio_np) {
-		dev_err(priv->dev, "no MDIO bus node\n");
-		return -ENODEV;
+	if (mdio_np && !of_device_is_available(mdio_np)) {
+		dev_err(priv->dev, "no available MDIO bus node\n");
+		ret = -ENODEV;
+		goto err_put_node;
 	}
 
 	bus = devm_mdiobus_alloc(priv->dev);
@@ -95,6 +99,20 @@ int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s:user_mii", dev_name(priv->dev));
 	bus->parent = priv->dev;
 
+	if (!mdio_np) {
+		ds->user_mii_bus = bus;
+		bus->phy_mask = ~ds->phys_mii_mask;
+
+		if (priv->irqdomain) {
+			for (i = 0; i < priv->num_ports; i++) {
+				irq = irq_find_mapping(priv->irqdomain, i);
+				if (irq < 0)
+					continue;
+				bus->irq[i] = irq;
+			}
+		}
+	}
+
 	ret = devm_of_mdiobus_register(priv->dev, bus, mdio_np);
 	if (ret) {
 		dev_err(priv->dev, "unable to register MDIO bus %s\n",
-- 
2.50.1


