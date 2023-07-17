Return-Path: <netdev+bounces-18206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4A2755C9A
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110FF281248
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9F78814;
	Mon, 17 Jul 2023 07:18:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054D15A8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:18:51 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 0CC67E2;
	Mon, 17 Jul 2023 00:18:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3865C604D34EE;
	Mon, 17 Jul 2023 15:18:45 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Wu Yunchuan <yunchuan@nfschina.com>
To: wg@grandegger.com,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: uttenthaler@ems-wuensche.com,
	yunchuan@nfschina.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next v4 8/9] can: ems_pci: Remove unnecessary (void*) conversions
Date: Mon, 17 Jul 2023 15:18:01 +0800
Message-Id: <20230717071800.144129-1-yunchuan@nfschina.com>
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

No need cast (void*) to (struct ems_pci_card *).

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/can/sja1000/ems_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index c56e27223e5f..ac86640998a8 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -148,7 +148,7 @@ static void ems_pci_v1_write_reg(const struct sja1000_priv *priv,
 
 static void ems_pci_v1_post_irq(const struct sja1000_priv *priv)
 {
-	struct ems_pci_card *card = (struct ems_pci_card *)priv->priv;
+	struct ems_pci_card *card = priv->priv;
 
 	/* reset int flag of pita */
 	writel(PITA2_ICR_INT0_EN | PITA2_ICR_INT0,
@@ -168,7 +168,7 @@ static void ems_pci_v2_write_reg(const struct sja1000_priv *priv,
 
 static void ems_pci_v2_post_irq(const struct sja1000_priv *priv)
 {
-	struct ems_pci_card *card = (struct ems_pci_card *)priv->priv;
+	struct ems_pci_card *card = priv->priv;
 
 	writel(PLX_ICSR_ENA_CLR, card->conf_addr + PLX_ICSR);
 }
@@ -186,7 +186,7 @@ static void ems_pci_v3_write_reg(const struct sja1000_priv *priv,
 
 static void ems_pci_v3_post_irq(const struct sja1000_priv *priv)
 {
-	struct ems_pci_card *card = (struct ems_pci_card *)priv->priv;
+	struct ems_pci_card *card = priv->priv;
 
 	writel(ASIX_LINTSR_INT0AC, card->conf_addr + ASIX_LINTSR);
 }
-- 
2.30.2


