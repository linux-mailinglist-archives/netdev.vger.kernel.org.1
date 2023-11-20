Return-Path: <netdev+bounces-49259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4770B7F1518
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39234B21933
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11001BDE9;
	Mon, 20 Nov 2023 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4oo1ef/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43401C2A3
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 14:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E356C43391;
	Mon, 20 Nov 2023 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700488929;
	bh=dr3+sSzJp88vs/TN7xhIBmLq13P72PlW1NtNYvaehQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4oo1ef/dgz9KeZ23Mw4XoEjsD7BV9lbwPGFsNk+WDGk8KVPGf5jHp9//9o1Lceen
	 mer8zYPL2aDSHSbj1ADJz26tUd+Qx2Velw/MTWwbfA8QI5TyuPLgANHPg0BAMMz4LZ
	 OHO/r1I8pQClkFP2ymScgmCAHErYIkkIReYgPomy0sYSdBb3+XhZKZ8k7zX4KrOtyn
	 eGMCblfktwZsYEmFnJkiUWLS06BTnxnGDcdeLXk/5FKAqg55PNRaHDNDxTApG7lsKt
	 Uvx7T89W0MaWrmLKaNcNGOCQQ7KtOZ69W9Sq7hgDm2ZOcWHVfUIz/ZYa3XdvZfMVma
	 /Lek5wY1KuENA==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v6 net-next 4/7] net: ethernet: am65-cpsw: Move register definitions to header file
Date: Mon, 20 Nov 2023 16:01:44 +0200
Message-Id: <20231120140147.78726-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120140147.78726-1-rogerq@kernel.org>
References: <20231120140147.78726-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move register definitions to header file. No functional change.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 35 -------------------------
 drivers/net/ethernet/ti/am65-cpsw-qos.h | 35 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 35 deletions(-)

Changelog:

v6: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 2d083eaea442..f0fb11dd9c98 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -15,41 +15,6 @@
 #include "am65-cpts.h"
 #include "cpsw_ale.h"
 
-#define AM65_CPSW_REG_CTL			0x004
-#define AM65_CPSW_PN_REG_CTL			0x004
-#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
-#define AM65_CPSW_PN_REG_EST_CTL		0x060
-#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
-
-/* AM65_CPSW_REG_CTL register fields */
-#define AM65_CPSW_CTL_EST_EN			BIT(18)
-
-/* AM65_CPSW_PN_REG_CTL register fields */
-#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
-
-/* AM65_CPSW_PN_REG_EST_CTL register fields */
-#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
-#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
-#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
-#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
-#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
-#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
-
-/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
-#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
-#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
-#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
-#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
-#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
-
-/* EST FETCH COMMAND RAM */
-#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
-#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
-#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
-#define AM65_CPSW_FETCH_CNT_OFFSET		8
-#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
-#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
-
 enum timer_act {
 	TACT_PROG,		/* need program timer */
 	TACT_NEED_STOP,		/* need stop first */
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index 898f13a4a112..d8bccfd48532 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -31,6 +31,41 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
 };
 
+#define AM65_CPSW_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
+#define AM65_CPSW_PN_REG_EST_CTL		0x060
+#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+
+/* AM65_CPSW_REG_CTL register fields */
+#define AM65_CPSW_CTL_EST_EN			BIT(18)
+
+/* AM65_CPSW_PN_REG_CTL register fields */
+#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
+
+/* AM65_CPSW_PN_REG_EST_CTL register fields */
+#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
+#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
+#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
+#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
+#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
+#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
+
+/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
+#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
+#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
+#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
+#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
+#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
+
+/* EST FETCH COMMAND RAM */
+#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
+#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
+#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
+#define AM65_CPSW_FETCH_CNT_OFFSET		8
+#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
+#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
+
 #if IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS)
 int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data);
-- 
2.34.1


