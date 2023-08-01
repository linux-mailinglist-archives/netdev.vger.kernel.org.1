Return-Path: <netdev+bounces-23155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DB576B304
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F333E2815E3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3143C20FA2;
	Tue,  1 Aug 2023 11:20:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256241ED3C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:20:09 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7B1A5
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:20:07 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFXcR3DTpzNmYn;
	Tue,  1 Aug 2023 19:16:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 19:20:04 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <aelior@marvell.com>, <skalluru@marvell.com>, <manishc@marvell.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2] bnx2x: Remove unnecessary ternary operators
Date: Tue, 1 Aug 2023 19:19:28 +0800
Message-ID: <20230801111928.300231-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are a little ternary operators, the true or false judgement
of which is unnecessary in C language semantics.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
- Fix the subject prefix and commit message issue.
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
index 542c69822649..8e04552d2216 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
@@ -890,7 +890,7 @@ static void bnx2x_set_one_mac_e2(struct bnx2x *bp,
 		(struct eth_classify_rules_ramrod_data *)(raw->rdata);
 	int rule_cnt = rule_idx + 1, cmd = elem->cmd_data.vlan_mac.cmd;
 	union eth_classify_rule_cmd *rule_entry = &data->rules[rule_idx];
-	bool add = (cmd == BNX2X_VLAN_MAC_ADD) ? true : false;
+	bool add = cmd == BNX2X_VLAN_MAC_ADD;
 	unsigned long *vlan_mac_flags = &elem->cmd_data.vlan_mac.vlan_mac_flags;
 	u8 *mac = elem->cmd_data.vlan_mac.u.mac.mac;
 
@@ -1075,7 +1075,7 @@ static void bnx2x_set_one_vlan_e2(struct bnx2x *bp,
 	int rule_cnt = rule_idx + 1;
 	union eth_classify_rule_cmd *rule_entry = &data->rules[rule_idx];
 	enum bnx2x_vlan_mac_cmd cmd = elem->cmd_data.vlan_mac.cmd;
-	bool add = (cmd == BNX2X_VLAN_MAC_ADD) ? true : false;
+	bool add = cmd == BNX2X_VLAN_MAC_ADD;
 	u16 vlan = elem->cmd_data.vlan_mac.u.vlan.vlan;
 
 	/* Reset the ramrod data buffer for the first rule */
@@ -1125,7 +1125,7 @@ static void bnx2x_set_one_vlan_mac_e2(struct bnx2x *bp,
 	int rule_cnt = rule_idx + 1;
 	union eth_classify_rule_cmd *rule_entry = &data->rules[rule_idx];
 	enum bnx2x_vlan_mac_cmd cmd = elem->cmd_data.vlan_mac.cmd;
-	bool add = (cmd == BNX2X_VLAN_MAC_ADD) ? true : false;
+	bool add = cmd == BNX2X_VLAN_MAC_ADD;
 	u16 vlan = elem->cmd_data.vlan_mac.u.vlan_mac.vlan;
 	u8 *mac = elem->cmd_data.vlan_mac.u.vlan_mac.mac;
 	u16 inner_mac;
-- 
2.34.1


