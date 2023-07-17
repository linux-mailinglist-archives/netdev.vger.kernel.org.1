Return-Path: <netdev+bounces-18168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F157755A03
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAA728110D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F73C1FAD;
	Mon, 17 Jul 2023 03:12:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B71FA2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 03:12:46 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 37CCB172C;
	Sun, 16 Jul 2023 20:12:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 2987A601858F3;
	Mon, 17 Jul 2023 11:12:30 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Wu Yunchuan <yunchuan@nfschina.com>
To: rmody@marvell.com,
	skalluru@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH net-next v3 9/9] net: bna: Remove unnecessary (void*) conversions
Date: Mon, 17 Jul 2023 11:12:29 +0800
Message-Id: <20230717031229.55169-1-yunchuan@nfschina.com>
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

No need cast (void*) to (struct bnad_tx_info *) or
(struct bnad_rx_info *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/ethernet/brocade/bna/bnad.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index d6d90f9722a7..31191b520b58 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1037,8 +1037,7 @@ bnad_cb_ccb_destroy(struct bnad *bnad, struct bna_ccb *ccb)
 static void
 bnad_cb_tx_stall(struct bnad *bnad, struct bna_tx *tx)
 {
-	struct bnad_tx_info *tx_info =
-			(struct bnad_tx_info *)tx->priv;
+	struct bnad_tx_info *tx_info = tx->priv;
 	struct bna_tcb *tcb;
 	u32 txq_id;
 	int i;
@@ -1056,7 +1055,7 @@ bnad_cb_tx_stall(struct bnad *bnad, struct bna_tx *tx)
 static void
 bnad_cb_tx_resume(struct bnad *bnad, struct bna_tx *tx)
 {
-	struct bnad_tx_info *tx_info = (struct bnad_tx_info *)tx->priv;
+	struct bnad_tx_info *tx_info = tx->priv;
 	struct bna_tcb *tcb;
 	u32 txq_id;
 	int i;
@@ -1133,7 +1132,7 @@ bnad_tx_cleanup(struct delayed_work *work)
 static void
 bnad_cb_tx_cleanup(struct bnad *bnad, struct bna_tx *tx)
 {
-	struct bnad_tx_info *tx_info = (struct bnad_tx_info *)tx->priv;
+	struct bnad_tx_info *tx_info = tx->priv;
 	struct bna_tcb *tcb;
 	int i;
 
@@ -1149,7 +1148,7 @@ bnad_cb_tx_cleanup(struct bnad *bnad, struct bna_tx *tx)
 static void
 bnad_cb_rx_stall(struct bnad *bnad, struct bna_rx *rx)
 {
-	struct bnad_rx_info *rx_info = (struct bnad_rx_info *)rx->priv;
+	struct bnad_rx_info *rx_info = rx->priv;
 	struct bna_ccb *ccb;
 	struct bnad_rx_ctrl *rx_ctrl;
 	int i;
@@ -1208,7 +1207,7 @@ bnad_rx_cleanup(void *work)
 static void
 bnad_cb_rx_cleanup(struct bnad *bnad, struct bna_rx *rx)
 {
-	struct bnad_rx_info *rx_info = (struct bnad_rx_info *)rx->priv;
+	struct bnad_rx_info *rx_info = rx->priv;
 	struct bna_ccb *ccb;
 	struct bnad_rx_ctrl *rx_ctrl;
 	int i;
@@ -1231,7 +1230,7 @@ bnad_cb_rx_cleanup(struct bnad *bnad, struct bna_rx *rx)
 static void
 bnad_cb_rx_post(struct bnad *bnad, struct bna_rx *rx)
 {
-	struct bnad_rx_info *rx_info = (struct bnad_rx_info *)rx->priv;
+	struct bnad_rx_info *rx_info = rx->priv;
 	struct bna_ccb *ccb;
 	struct bna_rcb *rcb;
 	struct bnad_rx_ctrl *rx_ctrl;
-- 
2.30.2


