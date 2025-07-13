Return-Path: <netdev+bounces-206429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8BCB031AC
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB737189DBA1
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895622797A3;
	Sun, 13 Jul 2025 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ROma9nT+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC0219E8C;
	Sun, 13 Jul 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752419452; cv=none; b=NOmNhfB8VuIbqYgAuTSZiY06EEmx2zuRuX6v9P0NZVprMmTqxfgaP9CZEQJIK+H2fBozFbUagaCkyT86dbxUsuLIlQu644UVM6Wn21XZlviaHCxNQaEzj0F3EBbgSrQMSEhIgYvwwdlKtBKlJj6w6bUcPmZSdvpKPwF89NN7Xvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752419452; c=relaxed/simple;
	bh=CHo+u63bLinhn22BEK79KEsilSH+G0MXjcy+Fuv/I64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOJDQDv9f9ZFwg1iHoYwMnwed9dI1onkYvx+P9j9d46Oar19AYg0XtG2Z+cgHGJOJSYe1G9d1fuQ6ZmeVqKXe5M+tIHFvtXSGXMcS1+ah7SFfEkFe8hqIvJLu37+WDWcAE24FKd5sy08apM9Cfr5ocDo+JO7mIoN/Ad7dxbNR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ROma9nT+; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id ayKXuhGW5bk8wayKYuwJrD; Sun, 13 Jul 2025 17:09:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752419376;
	bh=lbrnp32zBlzDoe9yrenmDLqGbdobjnzv1C3nXLatAF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ROma9nT+GTSVOPpxJhSq8uDpwkB+c0AgQ5ppcgoKc4o/MdmPamwRe0tJlAIdQUev1
	 9gph+AiqU4f+NY6DsiBBv9FtPnZslSiFuGuxqgwz/RyLrj6PylHbElYo/a/99xegbS
	 BhK/iKlvWR9Ld06wWFcpDS8Son4OS9XtDIYj9gZw8vEaSPw3oA5s/urh8BJdPVN3xE
	 Y7sOPRiWo347dq52QNyJBPwMgcH6WPktiN+eYtzt0CNN66TDPAg3GLDQDwKidxMWYy
	 HXt+riBxF8S9VCaKyoUW8q/df9zioI/+z8tYUh890Eo2Ma0mDFzpcDES6hD6i15mNM
	 RA/9Z58Td/9uQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jul 2025 17:09:36 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: dsa: mt7530: Constify struct regmap_config
Date: Sun, 13 Jul 2025 17:09:24 +0200
Message-ID: <1b20b2e717e9ff15aa0d1e73442dde613174cfef.1752419299.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct regmap_config' are not modified in these drivers. They be
statically defined instead of allocated and populated at run-time.

The main benefits are:
  - it saves some memory at runtime
  - the structures can be declared as 'const', which is always better for
    structures that hold some function pointers
  - the code is less verbose

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/dsa/mt7530-mdio.c | 21 +++++++++------------
 drivers/net/dsa/mt7530-mmio.c | 21 ++++++++++-----------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 51df42ccdbe6..0286a6cecb6f 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -136,10 +136,17 @@ static const struct of_device_id mt7530_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mt7530_of_match);
 
+static const struct regmap_config regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = MT7530_CREV,
+	.disable_locking = true,
+};
+
 static int
 mt7530_probe(struct mdio_device *mdiodev)
 {
-	static struct regmap_config *regmap_config;
 	struct mt7530_priv *priv;
 	struct device_node *dn;
 	int ret;
@@ -193,18 +200,8 @@ mt7530_probe(struct mdio_device *mdiodev)
 			return PTR_ERR(priv->io_pwr);
 	}
 
-	regmap_config = devm_kzalloc(&mdiodev->dev, sizeof(*regmap_config),
-				     GFP_KERNEL);
-	if (!regmap_config)
-		return -ENOMEM;
-
-	regmap_config->reg_bits = 16;
-	regmap_config->val_bits = 32;
-	regmap_config->reg_stride = 4;
-	regmap_config->max_register = MT7530_CREV;
-	regmap_config->disable_locking = true;
 	priv->regmap = devm_regmap_init(priv->dev, &mt7530_regmap_bus, priv,
-					regmap_config);
+					&regmap_config);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index 842d74268e77..1dc8b93fb51a 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -18,10 +18,17 @@ static const struct of_device_id mt7988_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mt7988_of_match);
 
+static const struct regmap_config sw_regmap_config = {
+	.name = "switch",
+	.reg_bits = 16,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = MT7530_CREV,
+};
+
 static int
 mt7988_probe(struct platform_device *pdev)
 {
-	static struct regmap_config *sw_regmap_config;
 	struct mt7530_priv *priv;
 	void __iomem *base_addr;
 	int ret;
@@ -49,16 +56,8 @@ mt7988_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	sw_regmap_config = devm_kzalloc(&pdev->dev, sizeof(*sw_regmap_config), GFP_KERNEL);
-	if (!sw_regmap_config)
-		return -ENOMEM;
-
-	sw_regmap_config->name = "switch";
-	sw_regmap_config->reg_bits = 16;
-	sw_regmap_config->val_bits = 32;
-	sw_regmap_config->reg_stride = 4;
-	sw_regmap_config->max_register = MT7530_CREV;
-	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base_addr, sw_regmap_config);
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base_addr,
+					     &sw_regmap_config);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
-- 
2.50.1


