Return-Path: <netdev+bounces-85146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7322899A0A
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10DA284DC8
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05997161B55;
	Fri,  5 Apr 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CXMQVHTV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3791607B0;
	Fri,  5 Apr 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310875; cv=none; b=MYTSbmaihsxJaY+/RKZS3rK3feF44lU01hi5yjVjg85m5bXIwc9h4xwTASVWt1W9Z2p+tpD9bVjApbSwTDGsNFaVzocDRZ1DrnfCoZVK0+vNdpHvzYLxDfUea+FUiwLL89P9c2aXyA7dbTQdmVAsIT2uKGGK9s7Z5gCpJ1EKiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310875; c=relaxed/simple;
	bh=Jcma1Bkmpn4Xfp/xZhIBVU0xAUREIn9xkPWZ8Dn7Qlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=oBCT9Zmum5YmzZDybrj2j4c70PBAapbFoaR+wbr0WFwcAWww/g2iOHXdTrZC+ekHr1OslYzybDHAq03lxRpCRJT1xzM+nC7ZIUCawsYPUJssCtUNpRxRWpyZ2d6xPlWiztIzwCzymrJegLwdyeN5C3nKhciK71g3w1Gdon4sbaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CXMQVHTV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712310873; x=1743846873;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Jcma1Bkmpn4Xfp/xZhIBVU0xAUREIn9xkPWZ8Dn7Qlc=;
  b=CXMQVHTVIHOxj0+Y/2GoAD+eTmCVZPvLvGf2LEdozPQjmnUlTQ5W0/tQ
   eaZGyy61lNMG0D0C61dx84YEQ3LKnXRamXviHjbMFIqHmZ+XDAt8EOmbm
   nlQwl0MolpoZD1JdeSN1TiMo2GS0JB4ZHUwEIq/2V3q8Fe6Fs6x615TYh
   j7JYQdXjlUzughRyZ2H65tm2/Rr6sqetOQD2iU//zhgWCXBMk4rfIuVPq
   qem1EXswcLqv8bOaaeYY2liil09X2XTAo+l+159tNDfH0CWEGp8iC/BCZ
   7KcW/r4BHHuRNBVidtD0cER2jXjJxO+zlPhmpT320NeIaM2EwDQv7IjGy
   g==;
X-CSE-ConnectionGUID: 1vip42wHS0yTUSEiMowacg==
X-CSE-MsgGUID: RvUkIgroQcSLUOvJQ5lDEg==
X-IronPort-AV: E=Sophos;i="6.07,181,1708412400"; 
   d="scan'208";a="20163440"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 02:54:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 02:53:52 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 02:53:49 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 5 Apr 2024 11:53:15 +0200
Subject: [PATCH net] net: sparx5: fix reconfiguration of PCS on link mode
 change
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-link-mode-reconfiguration-fix-v1-1-c1480bc2346a@microchip.com>
X-B4-Tracking: v=1; b=H4sIAArKD2YC/x2MwQrCQAwFf6XkbGBbXUF/RTyU7ksNalayVYTSf
 zd4nIGZlRpc0ejcreT4aNNqAf2uo+k22gzWEkxDGg5pnzI/1O78rAXsmKqJzm8fl6hY9MtFTsd
 eIDmnTPF4OUL//xcyLHTdth8IFnkldAAAAA==
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

It was observed that the PCS would be misconfigured on link mode change,
if the negotiated link mode went from no-inband capabilities to in-band
capabilities. This bug appeared after the neg_mode change of phylink [1],
but is really due to the wrong config being used when reconfiguring the PCS.

Fix this by correctly using the new port configuration instead of the old
one.

[1] https://lore.kernel.org/netdev/ZIxQIBfO9dH5xFlg@shell.armlinux.org.uk/

Fixes: 946e7fd5053a ("net: sparx5: add port module support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 3a1b1a1f5a19..60dd2fd603a8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -731,7 +731,7 @@ static int sparx5_port_pcs_low_set(struct sparx5 *sparx5,
 	bool sgmii = false, inband_aneg = false;
 	int err;
 
-	if (port->conf.inband) {
+	if (conf->inband) {
 		if (conf->portmode == PHY_INTERFACE_MODE_SGMII ||
 		    conf->portmode == PHY_INTERFACE_MODE_QSGMII)
 			inband_aneg = true; /* Cisco-SGMII in-band-aneg */
@@ -948,7 +948,7 @@ int sparx5_port_pcs_set(struct sparx5 *sparx5,
 	if (err)
 		return -EINVAL;
 
-	if (port->conf.inband) {
+	if (conf->inband) {
 		/* Enable/disable 1G counters in ASM */
 		spx5_rmw(ASM_PORT_CFG_CSC_STAT_DIS_SET(high_speed_dev),
 			 ASM_PORT_CFG_CSC_STAT_DIS,

---
base-commit: d76c740b2eaaddc5fc3a8b21eaec5b6b11e8c3f5
change-id: 20240305-link-mode-reconfiguration-fix-df961fef5505

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


