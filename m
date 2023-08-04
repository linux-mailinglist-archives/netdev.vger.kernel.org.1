Return-Path: <netdev+bounces-24407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5B7701AB
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728E02826BE
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E634C133;
	Fri,  4 Aug 2023 13:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537DDC2D9
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:32:14 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45151BC3;
	Fri,  4 Aug 2023 06:31:53 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4RHRRv2kV0z9tG4;
	Fri,  4 Aug 2023 15:30:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AWRoa8KH-Kaf; Fri,  4 Aug 2023 15:30:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4RHRRr2hWzz9tG6;
	Fri,  4 Aug 2023 15:30:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 57E128B779;
	Fri,  4 Aug 2023 15:30:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id cB3mPuJfFaYW; Fri,  4 Aug 2023 15:30:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A0B0D8B775;
	Fri,  4 Aug 2023 15:30:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 374DUedk693349
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 4 Aug 2023 15:30:40 +0200
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 374DUe08693348;
	Fri, 4 Aug 2023 15:30:40 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, robh@kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 07/10] net: fs_enet: Move struct fs_platform_info into fs_enet.h
Date: Fri,  4 Aug 2023 15:30:17 +0200
Message-ID: <f882d6b0b7075d0d8435310634ceaa2cc8e9938f.1691155347.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691155346.git.christophe.leroy@csgroup.eu>
References: <cover.1691155346.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691155810; l=3265; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=qyzkIQa/5qiZulhLDtPL2XsttSmiHqUEBcr0qMA7XoY=; b=6o3DlExpb9tEttdqPqjigNbQOf+zadibk9WcnFBDp/RanYVfJK0u+AxwOh1vtbB4RFNYopbVq EXvCkzd5lzFDtracA3lrftbhKy/DF7dC/5WOshKavJG4awyDMPsTV6J
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

struct fs_platform_info is only used in fs_enet ethernet driver since
commit 3dd82a1ea724 ("[POWERPC] CPM: Always use new binding.").

Stale prototypes using fs_platform_info were left over in
arch/powerpc/sysdev/fsl_soc.c but they are now removed by
previous patch.

Move struct fs_platform_info into fs_enet.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../net/ethernet/freescale/fs_enet/fs_enet.h  | 19 ++++++++++++++++++-
 .../net/ethernet/freescale/fs_enet/mii-fec.c  |  1 +
 include/linux/fs_enet_pd.h                    | 16 ----------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index cb419aef8d1b..d371072fff60 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -2,6 +2,7 @@
 #ifndef FS_ENET_H
 #define FS_ENET_H
 
+#include <linux/clk.h>
 #include <linux/mii.h>
 #include <linux/netdevice.h>
 #include <linux/types.h>
@@ -9,7 +10,6 @@
 #include <linux/phy.h>
 #include <linux/dma-mapping.h>
 
-#include <linux/fs_enet_pd.h>
 #include <asm/fs_pd.h>
 
 #ifdef CONFIG_CPM1
@@ -118,6 +118,23 @@ struct phy_info {
 #define ENET_RX_ALIGN  16
 #define ENET_RX_FRSIZE L1_CACHE_ALIGN(PKT_MAXBUF_SIZE + ENET_RX_ALIGN - 1)
 
+struct fs_platform_info {
+	/* device specific information */
+	u32 cp_command;		/* CPM page/sblock/mcn */
+
+	u32 dpram_offset;
+
+	struct device_node *phy_node;
+
+	int rx_ring, tx_ring;	/* number of buffers on rx	*/
+	int rx_copybreak;	/* limit we copy small frames	*/
+	int napi_weight;	/* NAPI weight			*/
+
+	int use_rmii;		/* use RMII mode		*/
+
+	struct clk *clk_per;	/* 'per' clock for register access */
+};
+
 struct fs_enet_private {
 	struct napi_struct napi;
 	struct device *dev;	/* pointer back to the device (must be initialized first) */
diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
index 1910df250c33..a1e777a4b75f 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
+#include <linux/of_mdio.h>
 #include <linux/of_platform.h>
 #include <linux/pgtable.h>
 
diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 2b351b676467..7c9897dab558 100644
--- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -110,22 +110,6 @@ struct fs_mii_bb_platform_info {
 	int irq[32]; 	/* irqs per phy's */
 };
 
-struct fs_platform_info {
-	/* device specific information */
-	u32 cp_command;		/* CPM page/sblock/mcn */
-
-	u32 dpram_offset;
-	
-	struct device_node *phy_node;
-
-	int rx_ring, tx_ring;	/* number of buffers on rx     */
-	int rx_copybreak;	/* limit we copy small frames  */
-	int napi_weight;	/* NAPI weight                 */
-
-	int use_rmii;		/* use RMII mode 	       */
-
-	struct clk *clk_per;	/* 'per' clock for register access */
-};
 struct fs_mii_fec_platform_info {
 	u32 irq[32];
 	u32 mii_speed;
-- 
2.41.0


