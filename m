Return-Path: <netdev+bounces-30602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86147882CA
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2C01C20F9F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3264DD2E9;
	Fri, 25 Aug 2023 08:53:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34AD51B
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:53:54 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577DC1BCD
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so9251271fa.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692953630; x=1693558430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x77Qg/BjgNoz0Q/ag/jLI620TxfLaHya5Tlt9sTjz+0=;
        b=olLHUPPaXNDtNsCJNe9clk8ZLmkRbfBZn3Q5UBcydtI3k9DMyFbEWz8Yp2IGmOQSM8
         TMqRHYQqjm5D/iAH3yuY3cUSDZskH9VRsComQmCYKQa6eqt14UL7KR1J0MmduZ1Qbjw6
         DevCmZZx8vQRag+zQ2hD6xsbknAQ9qooPpF0sJucrqqCOigKE2mml+rPsb1WfXRSbAQE
         fzk7RGX0eqd75jP3rQFlOLukiBeDQs79zesITQBEWVl6m3YokKLtj2QIkleIbq5LNqo+
         Zf3VXv+vHt0ibmUfXln5nBASIPsevtlfuCBNSJCRORBu2/dZj2w2QYmEGupKvdbiHR/R
         AuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953630; x=1693558430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x77Qg/BjgNoz0Q/ag/jLI620TxfLaHya5Tlt9sTjz+0=;
        b=lZ1FvjxT4bnLt1Eyhggxh1l9ZbmUX/wMH67H6YEjDLGds53czl1vFmTDi4oQ5Cr86G
         CPTLVulGk7qviq3ga6y14+cuzKZQ8lADbBeJy1ZJplDHdFqV+cUfPl+G2Afd3T/uBjju
         4yW0cn6ZKHx3cB/4C9uJyGVn5wa/OCPuYMABtY/qNRKh5pXL37aCb0+q9WtOEv9t/JL3
         +6rAxFtTWIw1Xx0gdLDiLZ3wHSbRaEYHoaPV/TfWsm133V2Mju3QNFEBFBeC1AKZnLpo
         f68xrRtSfT7FBjumHrpTm1xBXo/HMqPw44Vb/NpLhACHeJt1FrrIxRJCeSuqfUlLz59+
         SrhA==
X-Gm-Message-State: AOJu0Yw7ZgWYy5TM9H/DCjbwr3u0zsjJQEbd8lYrRi3gHez63QGqIQPt
	l8HsJCSpHNbs2XJF11k7MU80D/Kc4TmNoZRdBziOZtTh
X-Google-Smtp-Source: AGHT+IG5Z5Hvtpf4NShGSGO2lCGAT/fxzokFGqooBTBon1Dl1JPrPAuZV9AZygdVYZthKP8APxQsUw==
X-Received: by 2002:a2e:9b18:0:b0:2bc:db99:1306 with SMTP id u24-20020a2e9b18000000b002bcdb991306mr6024981lji.38.1692953630663;
        Fri, 25 Aug 2023 01:53:50 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c221600b003fe1c332810sm4780260wml.33.2023.08.25.01.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:53:49 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next 15/15] devlink: move devlink_notify_register/unregister() to dev.c
Date: Fri, 25 Aug 2023 10:53:21 +0200
Message-ID: <20230825085321.178134-16-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825085321.178134-1-jiri@resnulli.us>
References: <20230825085321.178134-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

At last, move the last bits out of leftover.c,
the devlink_notify_register/unregister() functions to dev.c

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/Makefile        |  2 +-
 net/devlink/dev.c           | 28 +++++++++++++++++-
 net/devlink/devl_internal.h |  6 ++--
 net/devlink/leftover.c      | 58 -------------------------------------
 4 files changed, 30 insertions(+), 64 deletions(-)
 delete mode 100644 net/devlink/leftover.c

diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 71f490d301d7..000da622116a 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := leftover.o core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
+obj-y := core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
 	 resource.o param.o region.o health.o trap.o rate.o linecard.o
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index abf3393a7a17..bba4ace7d22b 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -174,7 +174,7 @@ static int devlink_nl_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
+static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 {
 	struct sk_buff *msg;
 	int err;
@@ -230,6 +230,32 @@ int devlink_nl_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
 	return devlink_nl_dumpit(msg, cb, devlink_nl_get_dump_one);
 }
 
+void devlink_notify_register(struct devlink *devlink)
+{
+	devlink_notify(devlink, DEVLINK_CMD_NEW);
+	devlink_linecards_notify_register(devlink);
+	devlink_ports_notify_register(devlink);
+	devlink_trap_policers_notify_register(devlink);
+	devlink_trap_groups_notify_register(devlink);
+	devlink_traps_notify_register(devlink);
+	devlink_rates_notify_register(devlink);
+	devlink_regions_notify_register(devlink);
+	devlink_params_notify_register(devlink);
+}
+
+void devlink_notify_unregister(struct devlink *devlink)
+{
+	devlink_params_notify_unregister(devlink);
+	devlink_regions_notify_unregister(devlink);
+	devlink_rates_notify_unregister(devlink);
+	devlink_traps_notify_unregister(devlink);
+	devlink_trap_groups_notify_unregister(devlink);
+	devlink_trap_policers_notify_unregister(devlink);
+	devlink_ports_notify_unregister(devlink);
+	devlink_linecards_notify_unregister(devlink);
+	devlink_notify(devlink, DEVLINK_CMD_DEL);
+}
+
 static void devlink_reload_failed_set(struct devlink *devlink,
 				      bool reload_failed)
 {
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index efca6abf7af7..f6b5fea2e13c 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -124,9 +124,6 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
 
-void devlink_notify_unregister(struct devlink *devlink);
-void devlink_notify_register(struct devlink *devlink);
-
 int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		      devlink_nl_dump_one_func_t *dump_one);
 
@@ -151,7 +148,8 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
 
 /* Notify */
-void devlink_notify(struct devlink *devlink, enum devlink_command cmd);
+void devlink_notify_register(struct devlink *devlink);
+void devlink_notify_unregister(struct devlink *devlink);
 void devlink_ports_notify_register(struct devlink *devlink);
 void devlink_ports_notify_unregister(struct devlink *devlink);
 void devlink_params_notify_register(struct devlink *devlink);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
deleted file mode 100644
index 05e056d6d5ea..000000000000
--- a/net/devlink/leftover.c
+++ /dev/null
@@ -1,58 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * net/core/devlink.c - Network physical/parent device Netlink interface
- *
- * Heavily inspired by net/wireless/
- * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
- * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
- */
-
-#include <linux/etherdevice.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/gfp.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/netdevice.h>
-#include <linux/spinlock.h>
-#include <linux/refcount.h>
-#include <linux/workqueue.h>
-#include <linux/u64_stats_sync.h>
-#include <linux/timekeeping.h>
-#include <rdma/ib_verbs.h>
-#include <net/netlink.h>
-#include <net/genetlink.h>
-#include <net/rtnetlink.h>
-#include <net/net_namespace.h>
-#include <net/sock.h>
-#include <net/devlink.h>
-
-#include "devl_internal.h"
-
-void devlink_notify_register(struct devlink *devlink)
-{
-	devlink_notify(devlink, DEVLINK_CMD_NEW);
-	devlink_linecards_notify_register(devlink);
-	devlink_ports_notify_register(devlink);
-	devlink_trap_policers_notify_register(devlink);
-	devlink_trap_groups_notify_register(devlink);
-	devlink_traps_notify_register(devlink);
-	devlink_rates_notify_register(devlink);
-	devlink_regions_notify_register(devlink);
-	devlink_params_notify_register(devlink);
-}
-
-void devlink_notify_unregister(struct devlink *devlink)
-{
-	devlink_params_notify_unregister(devlink);
-	devlink_regions_notify_unregister(devlink);
-	devlink_rates_notify_unregister(devlink);
-	devlink_traps_notify_unregister(devlink);
-	devlink_trap_groups_notify_unregister(devlink);
-	devlink_trap_policers_notify_unregister(devlink);
-	devlink_ports_notify_unregister(devlink);
-	devlink_linecards_notify_unregister(devlink);
-	devlink_notify(devlink, DEVLINK_CMD_DEL);
-}
-- 
2.41.0


