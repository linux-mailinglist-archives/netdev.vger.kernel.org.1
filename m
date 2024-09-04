Return-Path: <netdev+bounces-124924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5996B628
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED061F23F1C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281A31CC17A;
	Wed,  4 Sep 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LGpHJIYV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03D1CC175;
	Wed,  4 Sep 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441051; cv=none; b=G47QrxTUDmzANWQ/Y/2zlVI5BRhxkesooQyQmtmyWt4SYp53u4HLOpxq5HUGpogwMFJbc4BMuuA7yrrmrjBnLKC0ugDeiANIyQxTJzqvHVaV7B0x5DxlWk0Y2VvTKmr6XbP1imWrl+TcyYdtyRR2+1AiocVWqsJZfY4rOuSf8ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441051; c=relaxed/simple;
	bh=GhftJTNYBQsH0YlmdiwKhPt2pNrTrWNZEEDXJiqQTfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrAfq5Y8Cx65vYdTwtSPlhnf/mCAsuGmVUCsutLJdr0PDQaB8L4x3Q4XrVVujQnOcubxufw8Wryqqogz+RR5IbkHAHVQS/FNNjN6YZ7JGnSHCmZoH1e+Pdsytd2iWV5fsoeXQAs4TGiDLZMtDs+qmQPj7QHAnWFj1TsiFLfSR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LGpHJIYV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725441048; x=1756977048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GhftJTNYBQsH0YlmdiwKhPt2pNrTrWNZEEDXJiqQTfA=;
  b=LGpHJIYVRMd5XNQjZ+bB+J7bTiS+o7miYeBZz8AzSyBIyEwnLMWjDNIW
   AeF568umz5VDEREW9YV/mgJLW6vrVBsMEZUntbq3qcXl3o1omMLIvC4EK
   UyMCeVrs/ZSwssOkOiB3KSW2Oa+J/UqC5p4XILs8CV9U1zUlF7Z2rJMnH
   89k5/l/ZCd/rRl+fZlTOmcuoktg0Tu2zltZGVHKqApAQpglEFeYfq2Ac8
   ee6b+lBmw1S2HFikOeMNQO6TfeFUVkUfDSOxRFxp3jWbOnaJLmAVXVL8r
   QplCzzdLgEvearNEJ8OeqYJkmAXyCMZNmmBNj8UKzjakM/R+1pWyEy4oy
   A==;
X-CSE-ConnectionGUID: T9hQj/yXR7C6BLB59O45Pg==
X-CSE-MsgGUID: orYwlxhSREKz9oXTKHW4rw==
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="31212933"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 02:10:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Sep 2024 02:10:41 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Sep 2024 02:10:37 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <bryan.whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <maxime.chevallier@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V5 1/5] net: phylink: Add phylink_set_fixed_link() to configure fixed link state in phylink
Date: Wed, 4 Sep 2024 14:36:41 +0530
Message-ID: <20240904090645.8742-2-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
References: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============
V4 -> V5:
  - No change
V4 :
  - Add this patch along with "Add support to PHYLINK for LAN743x/PCI11x1x
    chips" patch series
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


