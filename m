Return-Path: <netdev+bounces-30984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C9778A59B
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7341C2085F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06BED4;
	Mon, 28 Aug 2023 06:17:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17EED3
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:17:34 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9217B1A5
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so41681931fa.0
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693203421; x=1693808221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tz4KPFoQ+DKFEVPlIdGQMHgPe6n8ve1ALjATz0ky28=;
        b=SIjLI0HZ6rnQiQ5ZURgpIIwuFroMMCbB3TFUwlSFDbK7NJaX01GGLsRugcSpaLkxUt
         DP7GoEy7u9QHiJeSinA9Ua0uCUx+2bBu6dEQPrdbMGpgNqt/lwcT8JDAXX46pqhFWTfm
         gnVtxCET3PLB9nXkwO6K10s2o3KA6w7LgDcJA7axw3d6Vl54sNKZqt9U/oz4QI5BvIT/
         TE7hE00XrwLHoPTh1ICKFBj4H4z1+JM3oHF2xHWSCPC0q/0seVetKL9HTBTFyWaUO5Fp
         L0QiZEuLReaGAemhBBFxeZlMe6TEOwVxFuKjiO0VkHQQanp3sfAPn9nNsrGaeRYiKWpu
         sQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203421; x=1693808221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tz4KPFoQ+DKFEVPlIdGQMHgPe6n8ve1ALjATz0ky28=;
        b=Al6sKqACelq9/QQo8mDNcuF+l8lHgUBTzXln/9/FTCOxURXhi+BeGJeUOXieO6Jbxp
         YPgqx6F5cw6QgQ7Izx/zZvIUwVj0+suzZnYqZDtyMwOnNeR9gV3+2MYsv363Id5rV/c7
         MMZbfsOL99V4BQQ1wu6BdC9sbvWlM3U9N4DtpPP7kARQez1AFua/cydv5xiUMpcQUYKD
         xtjG2Ocr37jtx2ub5z4rImCl57uAIIq4yxq8yejVpqoKoqCipqV6nw/2/RrMExQ65C7m
         j0aV34htvE5/4lgD7ynTjD3vzPK0mDuGKgCqXpD0daqsi8NetkB5JShhwNScgJcpPnd0
         GMAA==
X-Gm-Message-State: AOJu0YzjukYW8uSye8Kdfc7AEFuh6MRMIDVgLdpqbOOD7dxhvMw3gnbC
	hVdT5teJcYBkGqB12JGpu3yjGfscknMmFn2uj1nhVQ==
X-Google-Smtp-Source: AGHT+IGqu4F0114sXY4juLwJ9kiQSVDqN2iNGtrbHxV7DDrylaFLOF8Ojk9oSpCgYvMIA4KtkXnJMA==
X-Received: by 2002:a05:651c:1699:b0:2bd:10b7:4610 with SMTP id bd25-20020a05651c169900b002bd10b74610mr788841ljb.25.1693203420681;
        Sun, 27 Aug 2023 23:17:00 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c108b00b003fe2397c17fsm12843713wmd.17.2023.08.27.23.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:17:00 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next v2 01/15] devlink: push object register/unregister notifications into separate helpers
Date: Mon, 28 Aug 2023 08:16:43 +0200
Message-ID: <20230828061657.300667-2-jiri@resnulli.us>
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

In preparations of leftover.c split to individual files, avoid need to
have object structures exposed in devl_internal.h and allow to have them
maintained in object files.

The register/unregister notifications need to know the structures
to iterate lists. To avoid the need, introduce per-object
register/unregister notification helpers and use them.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/leftover.c | 247 +++++++++++++++++++++++++++--------------
 1 file changed, 163 insertions(+), 84 deletions(-)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 149752bc9f2d..890eafac9f8f 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -1058,6 +1058,26 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
+static void devlink_ports_notify(struct devlink *devlink,
+				 enum devlink_command cmd)
+{
+	struct devlink_port *devlink_port;
+	unsigned long port_index;
+
+	xa_for_each(&devlink->ports, port_index, devlink_port)
+		devlink_port_notify(devlink_port, cmd);
+}
+
+static void devlink_ports_notify_register(struct devlink *devlink)
+{
+	devlink_ports_notify(devlink, DEVLINK_CMD_PORT_NEW);
+}
+
+static void devlink_ports_notify_unregister(struct devlink *devlink)
+{
+	devlink_ports_notify(devlink, DEVLINK_CMD_PORT_DEL);
+}
+
 static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 				enum devlink_command cmd)
 {
@@ -1084,6 +1104,22 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
+static void devlink_rates_notify_register(struct devlink *devlink)
+{
+	struct devlink_rate *rate_node;
+
+	list_for_each_entry(rate_node, &devlink->rate_list, list)
+		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+}
+
+static void devlink_rates_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_rate *rate_node;
+
+	list_for_each_entry_reverse(rate_node, &devlink->rate_list, list)
+		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+}
+
 static int
 devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 			     struct netlink_callback *cb, int flags)
@@ -1928,6 +1964,22 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
+static void devlink_linecards_notify_register(struct devlink *devlink)
+{
+	struct devlink_linecard *linecard;
+
+	list_for_each_entry(linecard, &devlink->linecard_list, list)
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+}
+
+static void devlink_linecards_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_linecard *linecard;
+
+	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
+}
+
 int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
@@ -4285,6 +4337,26 @@ static void devlink_param_notify(struct devlink *devlink,
 				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
+static void devlink_params_notify(struct devlink *devlink,
+				  enum devlink_command cmd)
+{
+	struct devlink_param_item *param_item;
+	unsigned long param_id;
+
+	xa_for_each(&devlink->params, param_id, param_item)
+		devlink_param_notify(devlink, 0, param_item, cmd);
+}
+
+static void devlink_params_notify_register(struct devlink *devlink)
+{
+	devlink_params_notify(devlink, DEVLINK_CMD_PARAM_NEW);
+}
+
+static void devlink_params_notify_unregister(struct devlink *devlink)
+{
+	devlink_params_notify(devlink, DEVLINK_CMD_PARAM_DEL);
+}
+
 static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 					 struct devlink *devlink,
 					 struct netlink_callback *cb,
@@ -4694,6 +4766,22 @@ static void devlink_nl_region_notify(struct devlink_region *region,
 				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
+static void devlink_regions_notify_register(struct devlink *devlink)
+{
+	struct devlink_region *region;
+
+	list_for_each_entry(region, &devlink->region_list, list)
+		devlink_nl_region_notify(region, NULL, DEVLINK_CMD_REGION_NEW);
+}
+
+static void devlink_regions_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_region *region;
+
+	list_for_each_entry_reverse(region, &devlink->region_list, list)
+		devlink_nl_region_notify(region, NULL, DEVLINK_CMD_REGION_DEL);
+}
+
 /**
  * __devlink_snapshot_id_increment - Increment number of snapshots using an id
  *	@devlink: devlink instance
@@ -6662,98 +6750,36 @@ const struct genl_small_ops devlink_nl_small_ops[40] = {
 	/* -- No new ops here! Use split ops going forward! -- */
 };
 
-static void
-devlink_trap_policer_notify(struct devlink *devlink,
-			    const struct devlink_trap_policer_item *policer_item,
-			    enum devlink_command cmd);
-static void
-devlink_trap_group_notify(struct devlink *devlink,
-			  const struct devlink_trap_group_item *group_item,
-			  enum devlink_command cmd);
-static void devlink_trap_notify(struct devlink *devlink,
-				const struct devlink_trap_item *trap_item,
-				enum devlink_command cmd);
+static void devlink_trap_policers_notify_register(struct devlink *devlink);
+static void devlink_trap_policers_notify_unregister(struct devlink *devlink);
+static void devlink_trap_groups_notify_register(struct devlink *devlink);
+static void devlink_trap_groups_notify_unregister(struct devlink *devlink);
+static void devlink_traps_notify_register(struct devlink *devlink);
+static void devlink_traps_notify_unregister(struct devlink *devlink);
 
 void devlink_notify_register(struct devlink *devlink)
 {
-	struct devlink_trap_policer_item *policer_item;
-	struct devlink_trap_group_item *group_item;
-	struct devlink_param_item *param_item;
-	struct devlink_trap_item *trap_item;
-	struct devlink_port *devlink_port;
-	struct devlink_linecard *linecard;
-	struct devlink_rate *rate_node;
-	struct devlink_region *region;
-	unsigned long port_index;
-	unsigned long param_id;
-
 	devlink_notify(devlink, DEVLINK_CMD_NEW);
-	list_for_each_entry(linecard, &devlink->linecard_list, list)
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-
-	xa_for_each(&devlink->ports, port_index, devlink_port)
-		devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_NEW);
-
-	list_for_each_entry(policer_item, &devlink->trap_policer_list, list)
-		devlink_trap_policer_notify(devlink, policer_item,
-					    DEVLINK_CMD_TRAP_POLICER_NEW);
-
-	list_for_each_entry(group_item, &devlink->trap_group_list, list)
-		devlink_trap_group_notify(devlink, group_item,
-					  DEVLINK_CMD_TRAP_GROUP_NEW);
-
-	list_for_each_entry(trap_item, &devlink->trap_list, list)
-		devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_NEW);
-
-	list_for_each_entry(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
-
-	list_for_each_entry(region, &devlink->region_list, list)
-		devlink_nl_region_notify(region, NULL, DEVLINK_CMD_REGION_NEW);
-
-	xa_for_each(&devlink->params, param_id, param_item)
-		devlink_param_notify(devlink, 0, param_item,
-				     DEVLINK_CMD_PARAM_NEW);
+	devlink_linecards_notify_register(devlink);
+	devlink_ports_notify_register(devlink);
+	devlink_trap_policers_notify_register(devlink);
+	devlink_trap_groups_notify_register(devlink);
+	devlink_traps_notify_register(devlink);
+	devlink_rates_notify_register(devlink);
+	devlink_regions_notify_register(devlink);
+	devlink_params_notify_register(devlink);
 }
 
 void devlink_notify_unregister(struct devlink *devlink)
 {
-	struct devlink_trap_policer_item *policer_item;
-	struct devlink_trap_group_item *group_item;
-	struct devlink_param_item *param_item;
-	struct devlink_trap_item *trap_item;
-	struct devlink_port *devlink_port;
-	struct devlink_linecard *linecard;
-	struct devlink_rate *rate_node;
-	struct devlink_region *region;
-	unsigned long port_index;
-	unsigned long param_id;
-
-	xa_for_each(&devlink->params, param_id, param_item)
-		devlink_param_notify(devlink, 0, param_item,
-				     DEVLINK_CMD_PARAM_DEL);
-
-	list_for_each_entry_reverse(region, &devlink->region_list, list)
-		devlink_nl_region_notify(region, NULL, DEVLINK_CMD_REGION_DEL);
-
-	list_for_each_entry_reverse(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
-
-	list_for_each_entry_reverse(trap_item, &devlink->trap_list, list)
-		devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_DEL);
-
-	list_for_each_entry_reverse(group_item, &devlink->trap_group_list, list)
-		devlink_trap_group_notify(devlink, group_item,
-					  DEVLINK_CMD_TRAP_GROUP_DEL);
-	list_for_each_entry_reverse(policer_item, &devlink->trap_policer_list,
-				    list)
-		devlink_trap_policer_notify(devlink, policer_item,
-					    DEVLINK_CMD_TRAP_POLICER_DEL);
-
-	xa_for_each(&devlink->ports, port_index, devlink_port)
-		devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
-	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
+	devlink_params_notify_unregister(devlink);
+	devlink_regions_notify_unregister(devlink);
+	devlink_rates_notify_unregister(devlink);
+	devlink_traps_notify_unregister(devlink);
+	devlink_trap_groups_notify_unregister(devlink);
+	devlink_trap_policers_notify_unregister(devlink);
+	devlink_ports_notify_unregister(devlink);
+	devlink_linecards_notify_unregister(devlink);
 	devlink_notify(devlink, DEVLINK_CMD_DEL);
 }
 
@@ -8879,6 +8905,24 @@ devlink_trap_group_notify(struct devlink *devlink,
 				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
+static void devlink_trap_groups_notify_register(struct devlink *devlink)
+{
+	struct devlink_trap_group_item *group_item;
+
+	list_for_each_entry(group_item, &devlink->trap_group_list, list)
+		devlink_trap_group_notify(devlink, group_item,
+					  DEVLINK_CMD_TRAP_GROUP_NEW);
+}
+
+static void devlink_trap_groups_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_trap_group_item *group_item;
+
+	list_for_each_entry_reverse(group_item, &devlink->trap_group_list, list)
+		devlink_trap_group_notify(devlink, group_item,
+					  DEVLINK_CMD_TRAP_GROUP_DEL);
+}
+
 static int
 devlink_trap_item_group_link(struct devlink *devlink,
 			     struct devlink_trap_item *trap_item)
@@ -8921,6 +8965,22 @@ static void devlink_trap_notify(struct devlink *devlink,
 				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
+static void devlink_traps_notify_register(struct devlink *devlink)
+{
+	struct devlink_trap_item *trap_item;
+
+	list_for_each_entry(trap_item, &devlink->trap_list, list)
+		devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_NEW);
+}
+
+static void devlink_traps_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_trap_item *trap_item;
+
+	list_for_each_entry_reverse(trap_item, &devlink->trap_list, list)
+		devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_DEL);
+}
+
 static int
 devlink_trap_register(struct devlink *devlink,
 		      const struct devlink_trap *trap, void *priv)
@@ -9382,6 +9442,25 @@ devlink_trap_policer_notify(struct devlink *devlink,
 				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
+static void devlink_trap_policers_notify_register(struct devlink *devlink)
+{
+	struct devlink_trap_policer_item *policer_item;
+
+	list_for_each_entry(policer_item, &devlink->trap_policer_list, list)
+		devlink_trap_policer_notify(devlink, policer_item,
+					    DEVLINK_CMD_TRAP_POLICER_NEW);
+}
+
+static void devlink_trap_policers_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_trap_policer_item *policer_item;
+
+	list_for_each_entry_reverse(policer_item, &devlink->trap_policer_list,
+				    list)
+		devlink_trap_policer_notify(devlink, policer_item,
+					    DEVLINK_CMD_TRAP_POLICER_DEL);
+}
+
 static int
 devlink_trap_policer_register(struct devlink *devlink,
 			      const struct devlink_trap_policer *policer)
-- 
2.41.0


