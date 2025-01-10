Return-Path: <netdev+bounces-157078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C1BA08DB7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C208E3A150B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11714209F56;
	Fri, 10 Jan 2025 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ighEh0r9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBD1C3C04
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504318; cv=none; b=Ey7PmjzrTxIu7SSgy3YD0WSBCI+kybcBHYKwB3XTwFWNxXI0n8E3TwpbAoYKezY1E4PIY9MKTos0tRGQDCfnzsrTCknmoPI6jgJWQZ1yrnnEOqxb+t7yYpug7ijs+8q39Ow02NQg8JCb+ilITkVJoaUCro3I6IPLc/kH478wLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504318; c=relaxed/simple;
	bh=oKlq476fY9QM/OujOfwpqryzpqHCumE+M3ptAU9F1uM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UNBL833/GFV3o41B8Fckn2grcs+vAR1tIrr/AKBy5Wemt+t8DjWGvll7cmybJiRn2VLjVolu9gdDspHuiBT7Nz/OLN9jyWdz9rJOYgHxFzsE6A23WXOsUaYrjhF2N65IGRsAIHb+uszrlEJzXCdyapgwJPZP46XJYovDpCMyLbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ighEh0r9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0236AC4CED6;
	Fri, 10 Jan 2025 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736504317;
	bh=oKlq476fY9QM/OujOfwpqryzpqHCumE+M3ptAU9F1uM=;
	h=From:Date:Subject:To:Cc:From;
	b=ighEh0r9RCenwY5oVRkBESBSyg2uDQ7vER54rOH8yoUZV44AdsvHYIL1VZ/dQNEox
	 udfiIztFH/6OwsTjL8O28Y5p55G7ptEBOALldhh4k2flxHpCUwZNUV6kk9TwMN3NX3
	 gDoE61mYLDynVPGn+z36fuJ0SyqHoDEGv26H4LtBi8MlirpTtRntSq+B+onrhriRSl
	 pJ8tWejCVztm6d7ntMpSVSU1vLxNFz6uP9rOEIuaOIJIuxDtk18vqUy4Mm06GtsQ3G
	 2ql+GBVQfTjglmD9NISkf7ixH7TGU1Ik/NNGXOAg2jtn9QHt4yW4KCKVMBCdzr0KiU
	 FNGcxsD1WPfSQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 10 Jan 2025 10:18:33 +0000
Subject: [PATCH net-next] freescale: ucc_geth: Remove set but unused
 variables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-ucc-unused-var-v1-1-4cf02475b21d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPjzgGcC/x2MzQqDMBAGX0X23IWsQWh8FelB4le7l23JjwiSd
 zf0OAwzF2UkRaZ5uCjh0Kxf6yCPgeJntR2sW2ca3Tg5Ecc1Rq5WMzY+1sTh2YWIR/CeevRLeOv
 5Hy5kKGw4C71auwELOsi/agAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.14.0

Remove set but unused variables. These seem to provide no value.
So in the spirit of less being more, remove them.

Flagged by gcc-14 as:

.../ucc_geth.c: In function 'ucc_geth_free_rx':
.../ucc_geth.c:1708:31: warning: variable 'uf_info' set but not used [-Wunused-but-set-variable]
 1708 |         struct ucc_fast_info *uf_info;
      |                               ^~~~~~~
.../ucc_geth.c: In function 'ucc_geth_free_tx':
.../ucc_geth.c:1747:31: warning: variable 'uf_info' set but not used [-Wunused-but-set-variable]
 1747 |         struct ucc_fast_info *uf_info;
      |                               ^~~~~~~
.../ucc_geth.c: In function 'ucc_geth_alloc_tx':
.../ucc_geth.c:2039:31: warning: variable 'uf_info' set but not used [-Wunused-but-set-variable]
 2039 |         struct ucc_fast_info *uf_info;
      |                               ^~~~~~~
.../ucc_geth.c: In function 'ucc_geth_alloc_rx':
.../ucc_geth.c:2101:31: warning: variable 'uf_info' set but not used [-Wunused-but-set-variable]
 2101 |         struct ucc_fast_info *uf_info;
      |                               ^~~~~~~
.../ucc_geth.c: In function 'ucc_geth_startup':
.../ucc_geth.c:2168:13: warning: variable 'ifstat' set but not used [-Wunused-but-set-variable]
 2168 |         u32 ifstat, i, j, size, l2qt, l3qt;
      |             ^~~~~~
.../ucc_geth.c:2158:62: warning: variable 'p_82xx_addr_filt' set but not used [-Wunused-but-set-variable]
 2158 |         struct ucc_geth_82xx_address_filtering_pram __iomem *p_82xx_addr_filt;
      |                                                              ^~~~~~~~~~~~~~~~
.../ucc_geth.c: In function 'ucc_geth_rx':
.../ucc_geth.c:2893:13: warning: variable 'bdBuffer' set but not used [-Wunused-but-set-variable]
 2893 |         u8 *bdBuffer;
      |             ^~~~~~~~
.../ucc_geth.c: In function 'ucc_geth_irq_handler':
.../ucc_geth.c:3046:31: warning: variable 'ug_info' set but not used [-Wunused-but-set-variable]
 3046 |         struct ucc_geth_info *ug_info;
      |                               ^~~~~~~

Compile tested only.
No runtime effect intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 39 +++++++------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 88510f822759..1e3a1cb997c3 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1704,14 +1704,8 @@ static int ugeth_82xx_filtering_clear_addr_in_paddr(struct ucc_geth_private *uge
 
 static void ucc_geth_free_rx(struct ucc_geth_private *ugeth)
 {
-	struct ucc_geth_info *ug_info;
-	struct ucc_fast_info *uf_info;
-	u16 i, j;
 	u8 __iomem *bd;
-
-
-	ug_info = ugeth->ug_info;
-	uf_info = &ug_info->uf_info;
+	u16 i, j;
 
 	for (i = 0; i < ucc_geth_rx_queues(ugeth->ug_info); i++) {
 		if (ugeth->p_rx_bd_ring[i]) {
@@ -1743,16 +1737,11 @@ static void ucc_geth_free_rx(struct ucc_geth_private *ugeth)
 
 static void ucc_geth_free_tx(struct ucc_geth_private *ugeth)
 {
-	struct ucc_geth_info *ug_info;
-	struct ucc_fast_info *uf_info;
-	u16 i, j;
 	u8 __iomem *bd;
+	u16 i, j;
 
 	netdev_reset_queue(ugeth->ndev);
 
-	ug_info = ugeth->ug_info;
-	uf_info = &ug_info->uf_info;
-
 	for (i = 0; i < ucc_geth_tx_queues(ugeth->ug_info); i++) {
 		bd = ugeth->p_tx_bd_ring[i];
 		if (!bd)
@@ -2036,13 +2025,11 @@ static int ucc_struct_init(struct ucc_geth_private *ugeth)
 static int ucc_geth_alloc_tx(struct ucc_geth_private *ugeth)
 {
 	struct ucc_geth_info *ug_info;
-	struct ucc_fast_info *uf_info;
+	u8 __iomem *bd;
 	int length;
 	u16 i, j;
-	u8 __iomem *bd;
 
 	ug_info = ugeth->ug_info;
-	uf_info = &ug_info->uf_info;
 
 	/* Allocate Tx bds */
 	for (j = 0; j < ucc_geth_tx_queues(ug_info); j++) {
@@ -2098,13 +2085,11 @@ static int ucc_geth_alloc_tx(struct ucc_geth_private *ugeth)
 static int ucc_geth_alloc_rx(struct ucc_geth_private *ugeth)
 {
 	struct ucc_geth_info *ug_info;
-	struct ucc_fast_info *uf_info;
+	u8 __iomem *bd;
 	int length;
 	u16 i, j;
-	u8 __iomem *bd;
 
 	ug_info = ugeth->ug_info;
-	uf_info = &ug_info->uf_info;
 
 	/* Allocate Rx bds */
 	for (j = 0; j < ucc_geth_rx_queues(ug_info); j++) {
@@ -2155,7 +2140,6 @@ static int ucc_geth_alloc_rx(struct ucc_geth_private *ugeth)
 
 static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 {
-	struct ucc_geth_82xx_address_filtering_pram __iomem *p_82xx_addr_filt;
 	struct ucc_geth_init_pram __iomem *p_init_enet_pram;
 	struct ucc_fast_private *uccf;
 	struct ucc_geth_info *ug_info;
@@ -2165,8 +2149,8 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	int ret_val = -EINVAL;
 	u32 remoder = UCC_GETH_REMODER_INIT;
 	u32 init_enet_pram_offset, cecr_subblock, command;
-	u32 ifstat, i, j, size, l2qt, l3qt;
 	u16 temoder = UCC_GETH_TEMODER_INIT;
+	u32 i, j, size, l2qt, l3qt;
 	u8 function_code = 0;
 	u8 __iomem *endOfRing;
 	u8 numThreadsRxNumerical, numThreadsTxNumerical;
@@ -2260,7 +2244,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/*                    Set IFSTAT                     */
 	/* For more details see the hardware spec.           */
 	/* Read only - resets upon read                      */
-	ifstat = in_be32(&ug_regs->ifstat);
+	in_be32(&ug_regs->ifstat);
 
 	/*                    Clear UEMPR                    */
 	/* For more details see the hardware spec.           */
@@ -2651,10 +2635,6 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 		for (j = 0; j < NUM_OF_PADDRS; j++)
 			ugeth_82xx_filtering_clear_addr_in_paddr(ugeth, (u8) j);
 
-		p_82xx_addr_filt =
-		    (struct ucc_geth_82xx_address_filtering_pram __iomem *) ugeth->
-		    p_rx_glbl_pram->addressfiltering;
-
 		ugeth_82xx_filtering_clear_all_addr_in_hash(ugeth,
 			ENET_ADDR_TYPE_GROUP);
 		ugeth_82xx_filtering_clear_all_addr_in_hash(ugeth,
@@ -2889,9 +2869,8 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 	struct sk_buff *skb;
 	u8 __iomem *bd;
 	u16 length, howmany = 0;
-	u32 bd_status;
-	u8 *bdBuffer;
 	struct net_device *dev;
+	u32 bd_status;
 
 	ugeth_vdbg("%s: IN", __func__);
 
@@ -2904,7 +2883,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 
 	/* while there are received buffers and BD is full (~R_E) */
 	while (!((bd_status & (R_E)) || (--rx_work_limit < 0))) {
-		bdBuffer = (u8 *) in_be32(&((struct qe_bd __iomem *)bd)->buf);
+		in_be32(&((struct qe_bd __iomem *)bd)->buf);
 		length = (u16) ((bd_status & BD_LENGTH_MASK) - 4);
 		skb = ugeth->rx_skbuff[rxQ][ugeth->skb_currx[rxQ]];
 
@@ -3043,14 +3022,12 @@ static irqreturn_t ucc_geth_irq_handler(int irq, void *info)
 	struct net_device *dev = info;
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
 	struct ucc_fast_private *uccf;
-	struct ucc_geth_info *ug_info;
 	register u32 ucce;
 	register u32 uccm;
 
 	ugeth_vdbg("%s: IN", __func__);
 
 	uccf = ugeth->uccf;
-	ug_info = ugeth->ug_info;
 
 	/* read and clear events */
 	ucce = (u32) in_be32(uccf->p_ucce);


