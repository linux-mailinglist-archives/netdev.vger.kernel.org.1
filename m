Return-Path: <netdev+bounces-18162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1777559F1
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB011C20A1F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 03:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FF15B4;
	Mon, 17 Jul 2023 03:11:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583F1FAD
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 03:11:36 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id BA4DDE76;
	Sun, 16 Jul 2023 20:11:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 628E76012605B;
	Mon, 17 Jul 2023 11:11:30 +0800 (CST)
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
Subject: [PATCH net-next v3 3/9] net: hns3: remove unnecessary (void*) conversions.
Date: Mon, 17 Jul 2023 11:11:28 +0800
Message-Id: <20230717031128.54557-1-yunchuan@nfschina.com>
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

No need cast (void*) to (struct hns3_nic_priv *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
Reviewed-by: Hao Lan <lanhao@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 407d30ee55d2..36858a72d771 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -569,8 +569,8 @@ static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 static u64 *hns3_get_stats_tqps(struct hnae3_handle *handle, u64 *data)
 {
-	struct hns3_nic_priv *nic_priv = (struct hns3_nic_priv *)handle->priv;
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
+	struct hns3_nic_priv *nic_priv = handle->priv;
 	struct hns3_enet_ring *ring;
 	u8 *stat;
 	int i, j;
-- 
2.30.2


