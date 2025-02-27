Return-Path: <netdev+bounces-170217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8AFA47D7A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CFB174821
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A9233148;
	Thu, 27 Feb 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzjm99Kp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456223314B;
	Thu, 27 Feb 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658638; cv=none; b=sBaP4Nw1itlWOMXRn2xPe0QD4r9l1e13O8UYO+wPCMKkPI2bnlAZ85d1XbI6lwYD8a09wc3yf+EVXl4gZvhVXgAl//B4gAC4mdYhvYaWGktHaarjiOfA1mCCDz7TJS1GTlb00MDM8s/+pNdGP7ZK5BdfwxitOmg7VoC14Gn2k0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658638; c=relaxed/simple;
	bh=23Wnyd3qZHaBZICVaJoi2NlVrSEsbcWxMjuwRlV42ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8ve6g2J9CDtZWCSj/P0xlLZNw3N5JDtNFx7RZNZt7FJjFUQV5GHB4j+aqfYIEzoJXXtE2ekMerOetG4YoG5GtgUeBmdrlkUzNC0CxDKVaIddFzEMKiWI6CVZYqM4t8RUlwKWXwWIiS1ldwRflLXw6onz4R4mt9lG5mAmG/upwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzjm99Kp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740658636; x=1772194636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=23Wnyd3qZHaBZICVaJoi2NlVrSEsbcWxMjuwRlV42ko=;
  b=nzjm99Kpp5p+C8z9iI0+nyL7LItd86R8UCkdw1QlaSqukUqyoAUvtl6v
   FVkfXLDwJix2ExrUZBLQzLWjrXPYYSo+o5FeLC7ISY+wHALvbmz8rXpL2
   WNWm3d/eQa+teIfr6SggjZyhmOamAY/9yGaRhIO1jcf9Npqt28AMZXHRo
   C7L8JBWu4HpBAQgruCcofC5eK07j24P+0jeNfiiWWoXatgT5p6BB2cB5Z
   iVXHHkOLRaq+ofppKc3+rwpG8EzEj1UIpD70pED7VpS/fG2IKX+sCWyFj
   flHTqZHzhplDhJ0UYB23Qs1xpJGClRbEdjdrxPZcWaerHKu3BMGBr7wJ7
   g==;
X-CSE-ConnectionGUID: 6rr7gYN2TpmGhz7LSwAyzA==
X-CSE-MsgGUID: QQ6pcJq2Ry6ryB9lQ2BHjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41464366"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41464366"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 04:17:15 -0800
X-CSE-ConnectionGUID: t2HlU1RRQQOkaHSTBT+bwg==
X-CSE-MsgGUID: WDg8vf6+Q46I63fgcAp6Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117519259"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa007.jf.intel.com with ESMTP; 27 Feb 2025 04:17:09 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Simon Horman <horms@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v9 4/6] net: stmmac: configure SerDes on mac_finish
Date: Thu, 27 Feb 2025 20:15:20 +0800
Message-Id: <20250227121522.1802832-5-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SerDes will configure according to the provided interface mode after
finish a major reconfiguration of the interface mode.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 include/linux/stmmac.h                            |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 424fa2fe31c6..72ec2ef3907f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1086,6 +1086,18 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	return 0;
 }
 
+static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
+			     phy_interface_t interface)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	if (priv->plat->mac_finish)
+		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode, interface);
+
+	return 0;
+}
+
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
 	.mac_get_caps = stmmac_mac_get_caps,
 	.mac_select_pcs = stmmac_mac_select_pcs,
@@ -1094,6 +1106,7 @@ static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
 	.mac_link_up = stmmac_mac_link_up,
 	.mac_disable_tx_lpi = stmmac_mac_disable_tx_lpi,
 	.mac_enable_tx_lpi = stmmac_mac_enable_tx_lpi,
+	.mac_finish = stmmac_mac_finish,
 };
 
 /**
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 6d2aa77ea963..af22a11c2b8a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -236,6 +236,10 @@ struct plat_stmmacenet_data {
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
+	int (*mac_finish)(struct net_device *ndev,
+			  void *priv,
+			  unsigned int mode,
+			  phy_interface_t interface);
 	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
-- 
2.34.1


