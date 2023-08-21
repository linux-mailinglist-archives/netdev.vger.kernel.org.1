Return-Path: <netdev+bounces-29336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF871782B07
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B872B1C20899
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D497483;
	Mon, 21 Aug 2023 13:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7A5258
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:56:03 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB6BC
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:56:02 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RTv7X4Qn2zLpTS;
	Mon, 21 Aug 2023 21:52:56 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 21:55:59 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] net: microchip: Remove unused declarations
Date: Mon, 21 Aug 2023 21:55:56 +0800
Message-ID: <20230821135556.43224-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 264a9c5c9dff ("net: sparx5: Remove unused GLAG handling in PGID")
removed sparx5_pgid_alloc_glag() but not its declaration.
Commit 27d293cceee5 ("net: microchip: sparx5: Add support for rule count by cookie")
removed vcap_rule_iter() but not its declaration.
Commit 8beef08f4618 ("net: microchip: sparx5: Adding initial VCAP API support")
declared but never implemented vcap_api_set_client().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h   | 1 -
 drivers/net/ethernet/microchip/vcap/vcap_api.h        | 3 ---
 drivers/net/ethernet/microchip/vcap/vcap_api_client.h | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 89a9a7afa32c..6f565c0c0c3d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -414,7 +414,6 @@ enum sparx5_pgid_type {
 };
 
 void sparx5_pgid_init(struct sparx5 *spx5);
-int sparx5_pgid_alloc_glag(struct sparx5 *spx5, u16 *idx);
 int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx);
 int sparx5_pgid_free(struct sparx5 *spx5, u16 idx);
 
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.h b/drivers/net/ethernet/microchip/vcap/vcap_api.h
index 62db270f65af..9eccfa633c1a 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.h
@@ -277,7 +277,4 @@ struct vcap_control {
 	struct list_head list; /* list of vcap instances */
 };
 
-/* Set client control interface on the API */
-int vcap_api_set_client(struct vcap_control *vctrl);
-
 #endif /* __VCAP_API__ */
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
index d9d1f7c9d762..88641508f885 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
@@ -226,9 +226,6 @@ int vcap_chain_offset(struct vcap_control *vctrl, int from_cid, int to_cid);
 bool vcap_is_next_lookup(struct vcap_control *vctrl, int cur_cid, int next_cid);
 /* Is this chain id the last lookup of all VCAPs */
 bool vcap_is_last_chain(struct vcap_control *vctrl, int cid, bool ingress);
-/* Provide all rules via a callback interface */
-int vcap_rule_iter(struct vcap_control *vctrl,
-		   int (*callback)(void *, struct vcap_rule *), void *arg);
 /* Match a list of keys against the keysets available in a vcap type */
 bool vcap_rule_find_keysets(struct vcap_rule *rule,
 			    struct vcap_keyset_list *matches);
-- 
2.34.1


