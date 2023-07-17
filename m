Return-Path: <netdev+bounces-18163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401A7559F2
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AB92812C9
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB03615CA;
	Mon, 17 Jul 2023 03:11:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DE23C0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 03:11:47 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id A6E52E51;
	Sun, 16 Jul 2023 20:11:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id ECAF16012605B;
	Mon, 17 Jul 2023 11:11:38 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Wu Yunchuan <yunchuan@nfschina.com>
To: yisen.zhuang@huawei.com,
	salil.mehta@huawei.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Wu Yunchuan <yunchuan@nfschina.com>,
	Hao Lan <lanhao@huawei.com>
Subject: [PATCH net-next v3 4/9] net: hns: Remove unnecessary (void*) conversions
Date: Mon, 17 Jul 2023 11:11:37 +0800
Message-Id: <20230717031137.54639-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

No need cast (void*) to (struct hns_mdio_device *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
Reviewed-by: Hao Lan <lanhao@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 9232caaf0bdc..409a89d80220 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -217,7 +217,7 @@ static void hns_mdio_cmd_write(struct hns_mdio_device *mdio_dev,
 static int hns_mdio_write_c22(struct mii_bus *bus,
 			      int phy_id, int regnum, u16 data)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	u16 reg = (u16)(regnum & 0xffff);
 	u16 cmd_reg_cfg;
 	int ret;
@@ -259,7 +259,7 @@ static int hns_mdio_write_c22(struct mii_bus *bus,
 static int hns_mdio_write_c45(struct mii_bus *bus, int phy_id, int devad,
 			      int regnum, u16 data)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	u16 reg = (u16)(regnum & 0xffff);
 	u16 cmd_reg_cfg;
 	int ret;
@@ -312,7 +312,7 @@ static int hns_mdio_write_c45(struct mii_bus *bus, int phy_id, int devad,
  */
 static int hns_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	u16 reg = (u16)(regnum & 0xffff);
 	u16 reg_val;
 	int ret;
@@ -363,7 +363,7 @@ static int hns_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
 static int hns_mdio_read_c45(struct mii_bus *bus, int phy_id, int devad,
 			     int regnum)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	u16 reg = (u16)(regnum & 0xffff);
 	u16 reg_val;
 	int ret;
@@ -424,7 +424,7 @@ static int hns_mdio_read_c45(struct mii_bus *bus, int phy_id, int devad,
  */
 static int hns_mdio_reset(struct mii_bus *bus)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	const struct hns_mdio_sc_reg *sc_reg;
 	int ret;
 
-- 
2.30.2


