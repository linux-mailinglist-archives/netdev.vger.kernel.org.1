Return-Path: <netdev+bounces-16341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32C774CD5D
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 08:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A101C209CB
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 06:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C91E3FF5;
	Mon, 10 Jul 2023 06:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE653BE
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 06:41:39 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id A9D721BF;
	Sun,  9 Jul 2023 23:41:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 4E21A602B2DC6;
	Mon, 10 Jul 2023 14:41:32 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: iyappan@os.amperecomputing.com,
	keyur@os.amperecomputing.com,
	quan@os.amperecomputing.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 08/10] net: mdio: Remove unnecessary (void*) conversions
Date: Mon, 10 Jul 2023 14:41:27 +0800
Message-Id: <20230710064127.173818-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: wuych <yunchuan@nfschina.com>

Pointer variables of void * type do not require type cast.

Signed-off-by: wuych <yunchuan@nfschina.com>
---
 drivers/net/mdio/mdio-xgene.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 7aafc221b5cf..683e8f8319ab 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -79,7 +79,7 @@ EXPORT_SYMBOL(xgene_mdio_wr_mac);
 
 int xgene_mdio_rgmii_read(struct mii_bus *bus, int phy_id, int reg)
 {
-	struct xgene_mdio_pdata *pdata = (struct xgene_mdio_pdata *)bus->priv;
+	struct xgene_mdio_pdata *pdata = bus->priv;
 	u32 data, done;
 	u8 wait = 10;
 
@@ -105,7 +105,7 @@ EXPORT_SYMBOL(xgene_mdio_rgmii_read);
 
 int xgene_mdio_rgmii_write(struct mii_bus *bus, int phy_id, int reg, u16 data)
 {
-	struct xgene_mdio_pdata *pdata = (struct xgene_mdio_pdata *)bus->priv;
+	struct xgene_mdio_pdata *pdata = bus->priv;
 	u32 val, done;
 	u8 wait = 10;
 
-- 
2.30.2


