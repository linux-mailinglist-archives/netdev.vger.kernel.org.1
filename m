Return-Path: <netdev+bounces-41695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AFB7CBB58
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C22FB2126A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AB14F9D;
	Tue, 17 Oct 2023 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Dx6hfkhe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA836111BB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:34:25 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D76195
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697524464; x=1729060464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKh81DkhhiO25LJ47IAgSQP8dQIGt7fK6Jkvr1wchHk=;
  b=Dx6hfkhedxapxzVbaEYepfSy96u2RunmVHCR6jmBiPGHC/eMf34vB7jY
   P88QFdQRZg5viV+wrbqa/H8Br39C7unxZRxmpp36o4EZEmvvzgslAcBYR
   75MgyQkUQJ2YFJ9xNmA3SQHAvJ+XEKD4to68mckSncpSSTpXeXo8epSBx
   i9VfeSLUj+URvIKjnNYk7nLdAeyFtjpFotbNfkEQipxE2jPnLGkeeRmeC
   yJxMJIwdNzX1ATLE8xJN9XQP35fp7Upo4II6DGtp7+dWVSL86HfwaivhQ
   2hdi9MQdZiiKLe1AqT4QTAbPrfu+/sL7hhFUjOOKBT6kuHWY52Qs/Navu
   g==;
X-IronPort-AV: E=Sophos;i="6.03,231,1694728800"; 
   d="scan'208";a="33494791"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Oct 2023 08:34:19 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8F221280082;
	Tue, 17 Oct 2023 08:34:19 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/2] net: fec: Remove non-Coldfire platform IDs
Date: Tue, 17 Oct 2023 08:34:19 +0200
Message-Id: <20231017063419.925266-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
References: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All i.MX platforms (non-Coldfire) use DT nowadays, so their platform ID
entries can be removed.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 30 -----------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2530463be2a1f..032c15b541ff2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -186,36 +186,6 @@ static struct platform_device_id fec_devtype[] = {
 		/* keep it for coldfire */
 		.name = DRIVER_NAME,
 		.driver_data = 0,
-	}, {
-		.name = "imx25-fec",
-		.driver_data = (kernel_ulong_t)&fec_imx25_info,
-	}, {
-		.name = "imx27-fec",
-		.driver_data = (kernel_ulong_t)&fec_imx27_info,
-	}, {
-		.name = "imx28-fec",
-		.driver_data = (kernel_ulong_t)&fec_imx28_info,
-	}, {
-		.name = "imx6q-fec",
-		.driver_data = (kernel_ulong_t)&fec_imx6q_info,
-	}, {
-		.name = "mvf600-fec",
-		.driver_data = (kernel_ulong_t)&fec_mvf600_info,
-	}, {
-		.name = "imx6sx-fec",
-		.driver_data = (kernel_ulong_t)&fec_imx6x_info,
-	}, {
-		.name = "imx6ul-fec",
-		.driver_data = (kernel_ulong_t)&fec_imx6ul_info,
-	}, {
-		.name = "imx8mq-fec",
-		.driver_data = (kernel_ulong_t)&fec_imx8mq_info,
-	}, {
-		.name = "imx8qm-fec",
-		.driver_data = (kernel_ulong_t)&fec_imx8qm_info,
-	}, {
-		.name = "s32v234-fec",
-		.driver_data = (kernel_ulong_t)&fec_s32v234_info,
 	}, {
 		/* sentinel */
 	}
-- 
2.34.1


