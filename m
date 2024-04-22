Return-Path: <netdev+bounces-89985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4F8AC744
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1ADE28655C
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EAC502A6;
	Mon, 22 Apr 2024 08:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93324317E
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775269; cv=none; b=L0UcJ4cs4OOZLwf4NCQTu9oJ4axpoPrFpPy+NXbwIWq/eEDoTenylHXSc2DJeLMxfmNaKfZXTDpnfVyGR+DmkaDvmPlZMqi4YsUMnlesKwPttS5NA33oGEOG0mfFcnHeEG7rfroaWJHq9Cb5JFERkv/msabRmSfnaK6IPpZcssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775269; c=relaxed/simple;
	bh=I1Bbhjv99D66yQavwsjwUHBSY/MWqXj1gjpu2LigkXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UDoiiAKShk4lqI3Ag/kRD3BdTi/RXmBbPcLtcNCFy1nDGC5XIfDre1QJgnspSrmZThsitjEOw5TrnxSQT7zLkahpLijLZYb0/K+xsGTBmz1IpZ2XZ3DcS3PhcvX737m0KR3pQXWS0FLodDf/LmgbBOJ+25eJg7TA75LAvWOjWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz14t1713775170tr5ned
X-QQ-Originating-IP: n7mOI99YXCKbj17sHLTzx1a1pkbxmg6x/OKGN2Qpn48=
Received: from localhost.trustnetic.com ( [125.119.247.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Apr 2024 16:39:28 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: +ynUkgUhZJlE9UcmWaex+sOHoBEXhg9pDYtJOg01MfhpoxTWJLqwvS3oznYEx
	iLF6dGmQh+ZzUofBVln60a9epkkhhG6lrztOA0SxUYwzQhXTOm19WvnuZEkKZ5UenceCxml
	2FZOTyyMm/F2zveinD99wwTvHvUI45dgNrfLW1FpQobTVggaUNTiVbHBMYawlUE8RfX5tBr
	DYwjNwY5Evgo0DQagiwod2Hr181ebUyS+pMQweF2SrgWUPNi2kb/3i8L/rhlNZPWbKojmlY
	MdomNpLBKM/0TXL78yOmFNtqCAhTWydoVBSwJvYlmIqy4TrbWcFSqX8H2iGzGGi+SAdWnvs
	0OQOWHdSgIb1HXcs/jtfyz8t6dPWUCWnjKLFD2nr+PIxoOmnRCvO0O5XdYMrGpktg52eQyu
	jZbDtNw010I=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15245128689296459886
From: Duanqiang Wen <duanqiangwen@net-swift.com>
To: netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	andrew@lunn.ch
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH net 1/2] Revert "net: txgbe: fix i2c dev name cannot match clkdev"
Date: Mon, 22 Apr 2024 16:41:08 +0800
Message-Id: <20240422084109.3201-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

This reverts commit c644920ce9220d83e070f575a4df711741c07f07.
when register i2c dev, txgbe shorten "i2c_designware" to "i2c_dw",
will cause this i2c dev can't match platfom driver i2c_designware_platform.

Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 2fa511227eac..5b5d5e4310d1 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -20,8 +20,6 @@
 #include "txgbe_phy.h"
 #include "txgbe_hw.h"
 
-#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
-
 static int txgbe_swnodes_register(struct txgbe *txgbe)
 {
 	struct txgbe_nodes *nodes = &txgbe->nodes;
@@ -573,8 +571,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "%s.%d",
-		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
+	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
+		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
 	if (IS_ERR(clk))
@@ -636,7 +634,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
 
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
-	info.name = TXGBE_I2C_CLK_DEV_NAME;
+	info.name = "i2c_designware";
 	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);
-- 
2.27.0


