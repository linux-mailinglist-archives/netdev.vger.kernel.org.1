Return-Path: <netdev+bounces-16340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B193474CD57
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 08:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA5E280EFB
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 06:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E448F3D8C;
	Mon, 10 Jul 2023 06:41:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99DE3C29
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 06:41:24 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 8E80D1A8;
	Sun,  9 Jul 2023 23:41:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 9FDBE602A8713;
	Mon, 10 Jul 2023 14:41:17 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: steve.glendinning@shawell.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 07/10] ethernet: smsc: remove unnecessary (void*) conversions
Date: Mon, 10 Jul 2023 14:41:15 +0800
Message-Id: <20230710064115.173735-1-suhui@nfschina.com>
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
 drivers/net/ethernet/smsc/smsc911x.c | 4 ++--
 drivers/net/ethernet/smsc/smsc9420.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 174dc8908b72..c362bff3cb83 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -552,7 +552,7 @@ static void smsc911x_mac_write(struct smsc911x_data *pdata,
 /* Get a phy register */
 static int smsc911x_mii_read(struct mii_bus *bus, int phyaddr, int regidx)
 {
-	struct smsc911x_data *pdata = (struct smsc911x_data *)bus->priv;
+	struct smsc911x_data *pdata = bus->priv;
 	unsigned long flags;
 	unsigned int addr;
 	int i, reg;
@@ -591,7 +591,7 @@ static int smsc911x_mii_read(struct mii_bus *bus, int phyaddr, int regidx)
 static int smsc911x_mii_write(struct mii_bus *bus, int phyaddr, int regidx,
 			   u16 val)
 {
-	struct smsc911x_data *pdata = (struct smsc911x_data *)bus->priv;
+	struct smsc911x_data *pdata = bus->priv;
 	unsigned long flags;
 	unsigned int addr;
 	int i, reg;
diff --git a/drivers/net/ethernet/smsc/smsc9420.c b/drivers/net/ethernet/smsc/smsc9420.c
index 71fbb358bb7d..3b26f1d86beb 100644
--- a/drivers/net/ethernet/smsc/smsc9420.c
+++ b/drivers/net/ethernet/smsc/smsc9420.c
@@ -102,7 +102,7 @@ static inline void smsc9420_pci_flush_write(struct smsc9420_pdata *pd)
 
 static int smsc9420_mii_read(struct mii_bus *bus, int phyaddr, int regidx)
 {
-	struct smsc9420_pdata *pd = (struct smsc9420_pdata *)bus->priv;
+	struct smsc9420_pdata *pd = bus->priv;
 	unsigned long flags;
 	u32 addr;
 	int i, reg = -EIO;
@@ -140,7 +140,7 @@ static int smsc9420_mii_read(struct mii_bus *bus, int phyaddr, int regidx)
 static int smsc9420_mii_write(struct mii_bus *bus, int phyaddr, int regidx,
 			   u16 val)
 {
-	struct smsc9420_pdata *pd = (struct smsc9420_pdata *)bus->priv;
+	struct smsc9420_pdata *pd = bus->priv;
 	unsigned long flags;
 	u32 addr;
 	int i, reg = -EIO;
-- 
2.30.2


