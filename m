Return-Path: <netdev+bounces-42930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD567D0B45
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B75E1F21E48
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB610A3D;
	Fri, 20 Oct 2023 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67265847D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:16:43 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 72129106;
	Fri, 20 Oct 2023 02:16:41 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 23851604AABDF;
	Fri, 20 Oct 2023 17:16:39 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] net: lan966x: remove useless code in lan966x_xtr_irq_handler
Date: Fri, 20 Oct 2023 17:16:26 +0800
Message-Id: <20231020091625.206561-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'err' is useless after break, remove this to save space and
be more clear.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 0d6e79af2410..7861defafb85 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -671,7 +671,6 @@ static irqreturn_t lan966x_xtr_irq_handler(int irq, void *args)
 		skb = netdev_alloc_skb(dev, len);
 		if (unlikely(!skb)) {
 			netdev_err(dev, "Unable to allocate sk_buff\n");
-			err = -ENOMEM;
 			break;
 		}
 		buf_len = len - ETH_FCS_LEN;
-- 
2.30.2


