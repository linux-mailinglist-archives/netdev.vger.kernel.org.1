Return-Path: <netdev+bounces-30997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB55F78A5B4
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3BB1C20431
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4D56AD9;
	Mon, 28 Aug 2023 06:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8C6AD7
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:17:49 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99062136
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so2308042f8f.2
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693203446; x=1693808246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x77Qg/BjgNoz0Q/ag/jLI620TxfLaHya5Tlt9sTjz+0=;
        b=ytssBqXy/dr9kNg4u1jUc5zLMKG8i2MGg5VLdyrsQNPm/D/nOi0Bk7qswUWqvwf8r9
         nDMWKgz6k40dX6doxflhEM38TOtbBsoEfsWgawtghFKnKTCx4FzhlCvRCQIU697sEwGA
         ponKlqSa+be9OGaGwjV7UdBtW6LSa1YSEsHN9a7MOaEN5SFluK0eQftX27iMGNn6V3ui
         aR5oi8yjMynm2+bS1pugYFVqUAUN7bgMcZ0+LWCCZ2p71BUDIAkCBWjvwdeOG6uGL3ix
         YGBdsbr1H3g5HgP7iTReI+mjERaZP/tH0/hGq1nNzRxXozpStynA8h4L0W/Nmsx8OS2o
         hjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203446; x=1693808246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x77Qg/BjgNoz0Q/ag/jLI620TxfLaHya5Tlt9sTjz+0=;
        b=IEOJwNN1N8/YjMYZaePjQ3Opoetruro1ZqNavjFBLP3+RBBMbyWJbvrL0O8r+mEzEJ
         0BrBFWhoyYfgX4cqg53uw8d9V6CrKVrJUWTWsrOMI7g1LnZrDUZD/9tFCRuWuYWu0KfZ
         9rvxlqkHG61IvfR/ACzxL08TWX+gX4syk6DuexXWk9KGrfCdIHislTc8ZHp4SGQ++5jV
         EHQIv5phsvjnSHJ+DmjWyHdqy2VgvsgrHbSo14hqL1vc4lbtwEMyzvQ0bN+YIlk/MHog
         5ZfEqkeJ7VBvO+kzHw8eqFIf1fnrhpAFaDSox5JlPKvQ9ptTdJEs3Vwl4IS8OhvIuuEK
         vUgg==
X-Gm-Message-State: AOJu0Ywhn/DQ8OS0hsVa11NZ6Y2DiWTpfrLRK0eqNpm+cw8P6Cgir+bw
	5AyZu1pnKxdWEwqWFVrnzwb3kgVmPvTox/Mgz74+sg==
X-Google-Smtp-Source: AGHT+IFAczWSy5kXtanZc1sjr+qW+EjsLQloQpqoE2C+St4DgwXRiU2AXnmHlhsxED6sLIBnVfTczw==
X-Received: by 2002:a05:6000:234:b0:317:6623:e33f with SMTP id l20-20020a056000023400b003176623e33fmr20743059wrz.14.1693203446131;
        Sun, 27 Aug 2023 23:17:26 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z12-20020adff1cc000000b00317f29ad113sm9506931wro.32.2023.08.27.23.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:17:25 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next v2 15/15] devlink: move devlink_notify_register/unregister() to dev.c
Date: Mon, 28 Aug 2023 08:16:57 +0200
Message-ID: <20230828061657.300667-16-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828061657.300667-1-jiri@resnulli.us>
References: <20230828061657.300667-1-jiri@resnulli.us>
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


