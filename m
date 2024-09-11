Return-Path: <netdev+bounces-127470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBA897580F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97ADB1F28212
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB851AE87E;
	Wed, 11 Sep 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Re5r7x30"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903EA1AD40D;
	Wed, 11 Sep 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071353; cv=none; b=NbqfoI/J88i8cXty3OZnzDoVq/tbuerf4mLLX15axz+qA9hVD7CrXRvz01ScpyH3UKkyQehdVu7hxeygUKW+hYvGLsi2rrKhBlsOJNbYZ4qDgP7OMjr2fRC8cBOm7pNFO3Oc1CrstpFhr8s2IolmJCUpxUk9g1pj97Q5Fp98F/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071353; c=relaxed/simple;
	bh=DGQSUDDdyRJOFJ1VH1Rob5rJribm+UEFtdMpF8HJa/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCcUX3boIy+zfNpyZ17Xa1a1ObQ6uS5oapT/zNKbHQFLIeintC++H6ITK3mDQGNG5TkjiuzDgT/UsJc+XxToHe82lE7cPD856KrW7zNunFBcwaEUQWc7G0GGg8cz1DtdFrtv12ucrtEzzD+KiwHcUTUd7LKVE1Qk66MnX4wvJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Re5r7x30; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726071351; x=1757607351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGQSUDDdyRJOFJ1VH1Rob5rJribm+UEFtdMpF8HJa/c=;
  b=Re5r7x30RQQZfymvdu3Oel0wtUao0yurL+SUISivC1LCmxIjQssyJBdR
   f67zcg/imbW3HArJvtfVv+0hZNlrlWN6/iV1zxnQm+5hzUUbmhHk/RVmS
   g4I4c0no5IEOLq2JWdGxvUwarFUYZiXgk8ecO3jIWNT+2UhFrTXjwPc+u
   VBs7h7zd7mfkBpHXpYgpeMxNEpRCbZ7/Z+EMeSVcsOLvnzVxPkvxlAsUL
   Cy4/4dMPbvmbWHsXwM97n5XBxTvTUnmf573LzBxNyU0KmABluZUhujXVj
   2v327uP0Aq+WymGijumS5OHaFkYg1BRV86iQUg4No2M5m2RnGOpMyRcfi
   A==;
X-CSE-ConnectionGUID: wQTYqSpVRaKatvgABLE7Ew==
X-CSE-MsgGUID: Za8HzPuCTpetq2lmKjkOpA==
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="34798045"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 09:15:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 09:15:15 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 09:15:11 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>, <andrew@lunn.ch>,
	<Steen.Hegelund@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 5/5] net: lan743x: Add Support for 2.5G SFP with 2500Base-X Interface
Date: Wed, 11 Sep 2024 21:40:54 +0530
Message-ID: <20240911161054.4494-6-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Support for 2.5G SFP modules utilizing the 2500Base-X interface.
The implementation includes integration with the Phylink subsystem to
manage the link state and configuration dynamically.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============
V2 : Include this new patch in the V2 series. 

 drivers/net/ethernet/microchip/lan743x_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index ef76d0c1642f..7fe699e5a134 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1495,7 +1495,10 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 	data = lan743x_csr_read(adapter, MAC_CR);
 	id_rev = adapter->csr.id_rev & ID_REV_ID_MASK_;
 
-	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
+	if (adapter->is_pci11x1x && adapter->is_sgmii_en &&
+	    adapter->is_sfp_support_en)
+		adapter->phy_interface = PHY_INTERFACE_MODE_2500BASEX;
+	else if (adapter->is_pci11x1x && adapter->is_sgmii_en)
 		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	else if (id_rev == ID_REV_ID_LAN7430_)
 		adapter->phy_interface = PHY_INTERFACE_MODE_GMII;
@@ -3359,6 +3362,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 	lan743x_phy_interface_select(adapter);
 
 	switch (adapter->phy_interface) {
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  adapter->phylink_config.supported_interfaces);
@@ -3412,12 +3416,13 @@ static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
 	struct device_node *dn = adapter->pdev->dev.of_node;
 	struct net_device *dev = adapter->netdev;
 	struct phy_device *phydev;
-	int ret;
+	int ret = 0;
 
 	if (dn)
 		ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
 
-	if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
+	if (!adapter->is_sfp_support_en &&
+	    (!dn || (ret && !lan743x_phy_handle_exists(dn)))) {
 		phydev = phy_find_first(adapter->mdiobus);
 		if (phydev) {
 			/* attach the mac to the phy */
-- 
2.34.1


