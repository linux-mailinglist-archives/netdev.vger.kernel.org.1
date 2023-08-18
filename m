Return-Path: <netdev+bounces-28786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFC780B2F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67091C21410
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121CC182C2;
	Fri, 18 Aug 2023 11:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EC518031
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:33:32 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8082112
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4IdvUELL2qcfkP6KpCnSS6jJvb4vHg72O/eVIgglPdI=; b=GcmERo43T/6N3TQafdxibDCATV
	UKgqO57DannAji7XH7awIDghDhF5PFXGISDKdKrpCzOSzyWctmJmiDRyuCaTlFv5jwWrbouxg/CVU
	EbVVgLZpCDNxd0eyHpY5dORjToahyu/pgA0G6pu55Da0kGwk7+t/54XU5rw87AJMxmZiNuhOrRK8J
	HUMZcaEX4srymrmZTyS8xSdyNJxARu2pS2HF8+N47SiKMbOhwIzjhCDKAbCVUZvC1WY5XKGxdpEuT
	Ln8iGf3XLAf4aZxdKav1CtDoX5VEARAaD1vqpRsBCVO8cUdU3EDJh8W4UHDIdbLfI6Vvdz9q8ckVo
	iRj0rBwg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46968 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qWxjI-0005XE-0K;
	Fri, 18 Aug 2023 12:33:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qWxjI-0056nx-CU; Fri, 18 Aug 2023 12:33:24 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: mdio: xgene: remove useless xgene_mdio_status
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qWxjI-0056nx-CU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 18 Aug 2023 12:33:24 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xgene_mdio_status is declared static, and is only written once by the
driver. It appears to have been this way since the driver was first
added to the kernel tree. No other users can be found, so let's remove
it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/mdio/mdio-xgene.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 1af7a4d9f86c..1190a793555a 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -20,8 +20,6 @@
 #include <linux/prefetch.h>
 #include <net/ip.h>
 
-static bool xgene_mdio_status;
-
 u32 xgene_mdio_rd_mac(struct xgene_mdio_pdata *pdata, u32 rd_addr)
 {
 	void __iomem *addr, *rd, *cmd, *cmd_done;
@@ -421,7 +419,6 @@ static int xgene_mdio_probe(struct platform_device *pdev)
 		goto out_mdiobus;
 
 	pdata->mdio_bus = mdio_bus;
-	xgene_mdio_status = true;
 
 	return 0;
 
-- 
2.30.2


