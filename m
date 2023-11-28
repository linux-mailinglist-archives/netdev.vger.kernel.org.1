Return-Path: <netdev+bounces-51501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE497FAF02
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CA6B21228
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952AA35;
	Tue, 28 Nov 2023 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIrpXgXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD75C1
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daee86e2d70so5942009276.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701131241; x=1701736041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kekvBZIjgx8B5SHHHMl/JjBecTTdofRLTOShhgmahqU=;
        b=rIrpXgXIw8aAAxedCzO8X2MnVTbXt0YZ85pVLOi4ahoTTlqA1s3DQLbwi3/wqvDQnG
         h2ypjzhXaAKFL7x4DE4zp7wSghb+06wNP92j7krcinlTir+3ABmo8TjI8N33WH98Lg1Q
         X4tgWzZ9npkv8fJ3/L6pMLjOo3YFr98YuNqsPXtDZOXn0uTrY5u9rC+XY/a4v/FrvZJ9
         3YYdheufOOvJ2ix5XSu4/qAimR0kMQXC0OeYYgxQNHrcgXrIspg27mnRB7upBz9g7tGh
         TB32uFtGwWyzgcP/f2Dqaki/Ch4NhUnAqH7niB/kDHM/IxXysmqWyvdj3H3bETvw8gEx
         yH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131241; x=1701736041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kekvBZIjgx8B5SHHHMl/JjBecTTdofRLTOShhgmahqU=;
        b=oTvPHyx5nKZNBYAMVSEnrjCHxVS7P5Fp4hWX0Shve2rZ6IjW6DetJk7nwOd0kzMRKx
         jj9u2R0nQGHp4fxyZm+s75mpD3KPCgf0IAfO2jnAaXvokOeVOxWHrHHNQi9DmoAHzUeA
         McBrom83Y9YH+rJ7IVdaD/zKzWu01YnDp46UtriwsUhPFL6BI2dbro1S2diN3h2Kemy/
         Vzz285cwj/GHhAMl2mx8U6kq1SZKUx5RPxEvtZJ0jlM4wZAT9BUpKlGSkGYP/B7YSkDw
         HYabVPyNtntl9XA09nAkL4a6j1WYTlqkVaNPwJoqjDVi7IMOneHo1twUAuoihcrm4aIL
         WBRA==
X-Gm-Message-State: AOJu0YzZ/eleVeF3WDcmQekh3OUGMjKRl7IDkfWyhFxcCC64PcVrksvs
	ATzs9qVfeuT3MMwqBkWU3jY75Prz12itdkgE6shb3RdI8OA1Cjxeh5J+mtZQVU41/q0IGqGcCHm
	DgYxQtXRVBlrjgE1jLHgbcZdK2CrBKCTsNRj63v+tfLna7tnqWkTLUstEFvMp1voI
X-Google-Smtp-Source: AGHT+IF+VYh18iez2e0dTFhqxypcKofIu1kgfuCV72Cv8cTSUAgjbCIz5Av8rr5ZC9uMheAKFogk5VSvT+uj
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:19d5:f826:3460:9345])
 (user=jfraker job=sendgmr) by 2002:a25:3d44:0:b0:db3:fa34:50b0 with SMTP id
 k65-20020a253d44000000b00db3fa3450b0mr423367yba.4.1701131241575; Mon, 27 Nov
 2023 16:27:21 -0800 (PST)
Date: Mon, 27 Nov 2023 16:26:44 -0800
In-Reply-To: <20231128002648.320892-1-jfraker@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231128002648.320892-1-jfraker@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128002648.320892-2-jfraker@google.com>
Subject: [PATCH net-next 1/5] gve: Perform adminq allocations through a dma_pool.
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>, Jordan Kimbrough <jrkim@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

This allows the adminq to be smaller than a page, paving the way for
non 4k page support. This is to support platforms where PAGE_SIZE
is not 4k, such as some ARM platforms.

Signed-off-by: Jordan Kimbrough <jrkim@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  4 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 28 ++++++++++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 0d1e681be..abc0c708b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -8,6 +8,7 @@
 #define _GVE_H_
 
 #include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/u64_stats_sync.h>
@@ -41,6 +42,8 @@
 #define NIC_TX_STATS_REPORT_NUM	0
 #define NIC_RX_STATS_REPORT_NUM	4
 
+#define GVE_ADMINQ_BUFFER_SIZE 4096
+
 #define GVE_DATA_SLOT_ADDR_PAGE_MASK (~(PAGE_SIZE - 1))
 
 /* PTYPEs are always 10 bits. */
@@ -672,6 +675,7 @@ struct gve_priv {
 	/* Admin queue - see gve_adminq.h*/
 	union gve_adminq_command *adminq;
 	dma_addr_t adminq_bus_addr;
+	struct dma_pool *adminq_pool;
 	u32 adminq_mask; /* masks prod_cnt to adminq size */
 	u32 adminq_prod_cnt; /* free-running count of AQ cmds executed */
 	u32 adminq_cmd_fail; /* free-running count of AQ cmds failed */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 79db7a6d4..d3f3a0152 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -194,12 +194,19 @@ gve_process_device_options(struct gve_priv *priv,
 
 int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 {
-	priv->adminq = dma_alloc_coherent(dev, PAGE_SIZE,
-					  &priv->adminq_bus_addr, GFP_KERNEL);
-	if (unlikely(!priv->adminq))
+	priv->adminq_pool = dma_pool_create("adminq_pool", dev,
+					    GVE_ADMINQ_BUFFER_SIZE, 0, 0);
+	if (unlikely(!priv->adminq_pool))
 		return -ENOMEM;
+	priv->adminq = dma_pool_alloc(priv->adminq_pool, GFP_KERNEL,
+				      &priv->adminq_bus_addr);
+	if (unlikely(!priv->adminq)) {
+		dma_pool_destroy(priv->adminq_pool);
+		return -ENOMEM;
+	}
 
-	priv->adminq_mask = (PAGE_SIZE / sizeof(union gve_adminq_command)) - 1;
+	priv->adminq_mask =
+		(GVE_ADMINQ_BUFFER_SIZE / sizeof(union gve_adminq_command)) - 1;
 	priv->adminq_prod_cnt = 0;
 	priv->adminq_cmd_fail = 0;
 	priv->adminq_timeouts = 0;
@@ -251,7 +258,8 @@ void gve_adminq_free(struct device *dev, struct gve_priv *priv)
 	if (!gve_get_admin_queue_ok(priv))
 		return;
 	gve_adminq_release(priv);
-	dma_free_coherent(dev, PAGE_SIZE, priv->adminq, priv->adminq_bus_addr);
+	dma_pool_free(priv->adminq_pool, priv->adminq, priv->adminq_bus_addr);
+	dma_pool_destroy(priv->adminq_pool);
 	gve_clear_admin_queue_ok(priv);
 }
 
@@ -778,8 +786,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	u16 mtu;
 
 	memset(&cmd, 0, sizeof(cmd));
-	descriptor = dma_alloc_coherent(&priv->pdev->dev, PAGE_SIZE,
-					&descriptor_bus, GFP_KERNEL);
+	descriptor = dma_pool_alloc(priv->adminq_pool, GFP_KERNEL,
+				    &descriptor_bus);
 	if (!descriptor)
 		return -ENOMEM;
 	cmd.opcode = cpu_to_be32(GVE_ADMINQ_DESCRIBE_DEVICE);
@@ -787,7 +795,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 						cpu_to_be64(descriptor_bus);
 	cmd.describe_device.device_descriptor_version =
 			cpu_to_be32(GVE_ADMINQ_DEVICE_DESCRIPTOR_VERSION);
-	cmd.describe_device.available_length = cpu_to_be32(PAGE_SIZE);
+	cmd.describe_device.available_length =
+		cpu_to_be32(GVE_ADMINQ_BUFFER_SIZE);
 
 	err = gve_adminq_execute_cmd(priv, &cmd);
 	if (err)
@@ -868,8 +877,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 				      dev_op_jumbo_frames, dev_op_dqo_qpl);
 
 free_device_descriptor:
-	dma_free_coherent(&priv->pdev->dev, PAGE_SIZE, descriptor,
-			  descriptor_bus);
+	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
 	return err;
 }
 
-- 
2.43.0.rc1.413.gea7ed67945-goog


