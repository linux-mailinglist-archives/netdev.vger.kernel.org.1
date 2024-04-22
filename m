Return-Path: <netdev+bounces-89984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F58AC743
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1584D1F21516
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E9446D1;
	Mon, 22 Apr 2024 08:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC934317E
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775260; cv=none; b=jsAyy+Nesf7j5gnrgjAm87NuF7UFgR6u11BZGefuKmsC3gQhvkzArsSVZYKvC2OJY4j5FuVwf0gFjuhf3Ycm1LbXq0WCdNZTyp+Zj7uYpqaVTf5h+QSVzYjsziCd5NzL5yTl2g29kIOdqGCaSexqNzPEw+9fKkNB95dORx3W8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775260; c=relaxed/simple;
	bh=JSjGj7t12vbRXL/ImSzG7oFk/QOs/rlr23VJkj1Qzjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u/UcesM7JaxHxZZSCtwv1qPmaPnaeZh/W8Tf9eqP0T2AQXZoQKkbhs7C9+Olod61tTG+cl1JTzYeNtXdw+RYYgiMa9Ywcib7HsLnwCy7cNxQjB/QK1oJscgLV3+ijuo5PXISvfmCDcMKnn1l3q8soX0Lik7MKgHdjdeySbrbEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz14t1713775175tcw75u
X-QQ-Originating-IP: uCtwqRzNKKvBtq3S85o3aQ9w8K8JZsbF3DRnMT5v1dE=
Received: from localhost.trustnetic.com ( [125.119.247.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Apr 2024 16:39:34 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: k8Irs33ik7sJFl8qwdx94UeAvZoMK4BVI/g4UXEus3kmLJZGwXYfpTrPwuZ1C
	JzE+f6Kul9lZ2IyZTa/H6uPGwOfnU20FsmXGqrlHaktUmTd98CzlbYm0rGxwMpglESJDoju
	Hz7b7IRfHuY80kPth0xjQUkJxVSC0vWO3blkrpdr0DsS7ovfeJJfG4ec6Ll88QLIh26FHyw
	3RJ8QJ64t7LPRO58Nj3DRPnWMIJVaWsTpzq9mNIgpdcTfEcfnyMzYzR/hDzPtIKYcMMoA9Y
	d1adr/yISVQkIFdn0yjfdW3YAuGwn6Xs7ryHx9L/nFXOUCufhAjVAn0pRZGvIqk3wH7g9zk
	eA/YO1wHltbM6SN1QB924Jfi65lyOPLFDSsew/ahD2RP25WFJPtu7KAmPMyxUNAUnhRIA/o
	TpZCnehDp4g=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15554260163409569988
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
Subject: [PATCH net 2/2] Revert "net: txgbe: fix clk_name exceed MAX_DEV_ID limits"
Date: Mon, 22 Apr 2024 16:41:09 +0800
Message-Id: <20240422084109.3201-2-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240422084109.3201-1-duanqiangwen@net-swift.com>
References: <20240422084109.3201-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

This reverts commit e30cef001da259e8df354b813015d0e5acc08740.
commit 99f4570cfba1 ("clkdev: Update clkdev id usage to allow
for longer names") can fix clk_name exceed MAX_DEV_ID limits,
so this commit is meaningless.

Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 5b5d5e4310d1..93295916b1d2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -571,7 +571,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
+	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
 		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
-- 
2.27.0


