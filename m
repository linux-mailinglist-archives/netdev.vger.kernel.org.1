Return-Path: <netdev+bounces-24261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B9A76F8A5
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 05:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AC9281050
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 03:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618351FD0;
	Fri,  4 Aug 2023 03:54:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525BC1FC2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 03:54:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578542D45;
	Thu,  3 Aug 2023 20:54:40 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHBb36Vf0zNmlJ;
	Fri,  4 Aug 2023 11:51:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 11:54:37 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <tariqt@nvidia.com>, <s.shtylyov@omp.ru>,
	<aspriel@gmail.com>, <franky.lin@broadcom.com>,
	<hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
	<richardcochran@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<ruanjinjie@huawei.com>, <u.kleine-koenig@pengutronix.de>,
	<mkl@pengutronix.de>, <lee@kernel.org>, <set_pte_at@outlook.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<brcm80211-dev-list.pdl@broadcom.com>, <SHA-cyfmac-dev-list@infineon.com>
Subject: [PATCH -next 1/6] net: thunderx: Remove unnecessary ternary operators
Date: Fri, 4 Aug 2023 11:53:41 +0800
Message-ID: <20230804035346.2879318-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804035346.2879318-1-ruanjinjie@huawei.com>
References: <20230804035346.2879318-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ther are a little ternary operators, the true or false judgement
of which is unnecessary in C language semantics.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c    | 2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 0ec65ec634df..b7cf4ba89b7c 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -174,7 +174,7 @@ static void nic_mbx_send_ready(struct nicpf *nic, int vf)
 		if (mac)
 			ether_addr_copy((u8 *)&mbx.nic_cfg.mac_addr, mac);
 	}
-	mbx.nic_cfg.sqs_mode = (vf >= nic->num_vf_en) ? true : false;
+	mbx.nic_cfg.sqs_mode = vf >= nic->num_vf_en;
 	mbx.nic_cfg.node_id = nic->node;
 
 	mbx.nic_cfg.loopback_supported = vf < nic->num_vf_en;
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a317feb8decb..9e467cecc33a 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -957,7 +957,7 @@ static void bgx_poll_for_sgmii_link(struct lmac *lmac)
 		goto next_poll;
 	}
 
-	lmac->link_up = ((pcs_link & PCS_MRX_STATUS_LINK) != 0) ? true : false;
+	lmac->link_up = (pcs_link & PCS_MRX_STATUS_LINK) != 0;
 	an_result = bgx_reg_read(lmac->bgx, lmac->lmacid,
 				 BGX_GMP_PCS_ANX_AN_RESULTS);
 
-- 
2.34.1


