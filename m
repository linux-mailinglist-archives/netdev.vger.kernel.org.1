Return-Path: <netdev+bounces-123089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17017963A1F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C991B281EF5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F8D168483;
	Thu, 29 Aug 2024 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="k/5V2Gi3"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1247161311;
	Thu, 29 Aug 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910987; cv=none; b=VxVKE9grb1BYhuFBWVu9Q8n/md1ACxJ4iY4tQP03kimizGawbMytswEMZQVuyQIGszFFewhQjHRIH2FsmwKB48CrKkhFrlfnIAs6VUM1KARChB8p5CI1XA/s7B+uuCgUzEHPK5lChJzpqLrnPCRdrfs3WgsxVMXe0vfcI9qVMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910987; c=relaxed/simple;
	bh=YdBrZxHdBahscSw6EW/xiRHXsEWL/k9PsI1ofj+B+J0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmlT//hL91uTLJHMMhXAI0t7IL9MqLXTLYni18aMPNHniknk4KlJG251hdLjBEPoH1hTNPZFtxCw4oXRDJkEXw3C/1+pPDkylw1SPZGnWKCAlhxAAxYI2cqbJLFf+UqDapE7qCo4fzgeKo0r8DebXQ0J65dHVYLiOXg6Tv2r8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=k/5V2Gi3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724910985; x=1756446985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YdBrZxHdBahscSw6EW/xiRHXsEWL/k9PsI1ofj+B+J0=;
  b=k/5V2Gi3UnyqkZBGZ3mXVX5Be01fPb4nSr2C5DoWxJGJmei53ODx0QVw
   33yiCiMeoGTUuRSHeunwCwN2h+xbmEyUaOR+sYQS22K61OydMGWo6DjUs
   Vdep2v/fjgW+9BLl3tFWX2l+a/AO2/PrhJvKnWZ5FUWKhgdOGbGlxUVKU
   8zS+4e4fO62uHfUwnu6RvyYYDgjOAD5oJCYnnxKBN0ZN0fRdBiGwmiXbW
   5v53pS3aUpNRdxwtSTnInvvA4Jna3/0yuHeexsg+ADH7pfu+SyaJTxM+b
   uNmyDn2Rtxz6/VP7RiEcuoGkrOCgq2YTp+DsER2zYSgcI6P+/A4AezGf4
   Q==;
X-CSE-ConnectionGUID: djzvXQheSJmlEkJDxQRq3A==
X-CSE-MsgGUID: oGIzLZSKRNWtHv+lL8SuuA==
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="30971356"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2024 22:56:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Aug 2024 22:55:25 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 28 Aug 2024 22:55:21 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V4 1/5] net: phylink: Add phylink_set_fixed_link() to configure fixed link state in phylink
Date: Thu, 29 Aug 2024 11:21:28 +0530
Message-ID: <20240829055132.79638-2-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
References: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Russell King <linux@armlinux.org.uk>

The function allows for the configuration of a fixed link state for a given
phylink instance. This addition is particularly useful for network devices that
operate with a fixed link configuration, where the link parameters do not change
dynamically. By using `phylink_set_fixed_link()`, drivers can easily set up
the fixed link state during initialization or configuration changes.

Signed-off-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============
V0 -> V1:
  - Change phylink fixed-link function header's string from "Returns" to        
    "Returns:" 
  - Add fixed-link patch along with this series.                                
    Note: Note: This code was developed by Mr.Russell King                      
    Ref:                                                                        
    https://lore.kernel.org/netdev/LV8PR11MB8700C786F5F1C274C73036CC9F8E2@LV8PR11MB8700.namprd11.prod.outlook.com/T/#me943adf54f1ea082edf294aba448fa003a116815

 drivers/net/phy/phylink.c | 42 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ab4e9fc03017..4309317de3d1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1635,6 +1635,48 @@ static int phylink_register_sfp(struct phylink *pl,
 	return ret;
 }
 
+/**
+ * phylink_set_fixed_link() - set the fixed link
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ * @state: a pointer to a struct phylink_link_state.
+ *
+ * This function is used when the link parameters are known and do not change,
+ * making it suitable for certain types of network connections.
+ *
+ * Returns: zero on success or negative error code.
+ */
+int phylink_set_fixed_link(struct phylink *pl,
+			   const struct phylink_link_state *state)
+{
+	const struct phy_setting *s;
+	unsigned long *adv;
+
+	if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
+	    !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
+		return -EINVAL;
+
+	s = phy_lookup_setting(state->speed, state->duplex,
+			       pl->supported, true);
+	if (!s)
+		return -EINVAL;
+
+	adv = pl->link_config.advertising;
+	linkmode_zero(adv);
+	linkmode_set_bit(s->bit, adv);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, adv);
+
+	pl->link_config.speed = state->speed;
+	pl->link_config.duplex = state->duplex;
+	pl->link_config.link = 1;
+	pl->link_config.an_complete = 1;
+
+	pl->cfg_link_an_mode = MLO_AN_FIXED;
+	pl->cur_link_an_mode = pl->cfg_link_an_mode;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
+
 /**
  * phylink_create() - create a phylink instance
  * @config: a pointer to the target &struct phylink_config
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2381e07429a2..5c01048860c4 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -598,6 +598,8 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 			       const struct fwnode_handle *fwnode,
 			       u32 flags);
 void phylink_disconnect_phy(struct phylink *);
+int phylink_set_fixed_link(struct phylink *,
+			   const struct phylink_link_state *);
 
 void phylink_mac_change(struct phylink *, bool up);
 void phylink_pcs_change(struct phylink_pcs *, bool up);
-- 
2.34.1


