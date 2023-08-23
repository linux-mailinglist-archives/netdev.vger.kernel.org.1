Return-Path: <netdev+bounces-29880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8B0785060
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC131C20C3C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F86FBF;
	Wed, 23 Aug 2023 06:09:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B606AA8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:09:41 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9273CE5E
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 23:09:21 -0700 (PDT)
X-QQ-mid: bizesmtp73t1692770853tiv7brnl
Received: from wxdbg.localdomain.com ( [60.177.96.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Aug 2023 14:07:32 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: QityeSR92A1sVJajvIP3vQNumMy2zMdJ/3vDMvfQlsZeRCAvnKf1eP42Z4ud7
	KXBdQ137G2qOmgBSxVivQVSyuZ7oi+Dt3c1EtdrEKS3Vlm8m+j/VUUF449WLELQOLVur0ht
	GJdgOVxySLiptvRQ9Z/wHMuURxUBDG5+wxVwhVYLEsOg3TTXMEjwm2dYkbE302X546ni+BN
	Ol/HPX9hsfNL6TIIRSUTNeE4CMQOdqZ3Ojo6CEBCboklfCWG0W7eJWHupng5oPKcLluDqWd
	tiEVH0ZiH/oulhqjYEo75sVhIdofesdjR8BCY4K6VTjuP8tZJYHOqZvPfd4HCDUYwDsFxUp
	A+9bcIqX782mmfuqevWUY9MNryq4nhftHDUmIDMme0BiKt2s4l+/kTo+mJFINvIDr1iIgSg
	qVo4qYQgPTg=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11822430123842236548
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 5/8] net: txgbe: add FW version warning
Date: Wed, 23 Aug 2023 14:19:32 +0800
Message-Id: <20230823061935.415804-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230823061935.415804-1-jiawenwu@trustnetic.com>
References: <20230823061935.415804-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since XPCS device identifier is implemented in the firmware version
0x20010 and above, so add a warning to prompt the users to upgrade the
firmware to make sure the driver works.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 46eba6d6188b..641b8188da4e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -663,6 +663,9 @@ static int txgbe_probe(struct pci_dev *pdev,
 			 "0x%08x", etrack_id);
 	}
 
+	if (etrack_id < 0x20010)
+		dev_warn(&pdev->dev, "Please upgrade the firmware to 0x20010 or above.\n");
+
 	txgbe = devm_kzalloc(&pdev->dev, sizeof(*txgbe), GFP_KERNEL);
 	if (!txgbe) {
 		err = -ENOMEM;
-- 
2.27.0


