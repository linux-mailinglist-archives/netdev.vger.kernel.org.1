Return-Path: <netdev+bounces-30588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557117882AC
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFC6281811
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D705BA29;
	Fri, 25 Aug 2023 08:53:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875DA925
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:53:29 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFE21BF2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff933f9ca8so1015868e87.1
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692953606; x=1693558406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymCUaI9Sd81RMgDR1qn0M+wpDprHHG3RZOZbigNcOKc=;
        b=M4IwCWiPZfdY9S6/164U6uxCJiZ6M9PeBlGWwM5erx61RLCbr/f66GmtrY/Ickuw4Y
         T8WYfydC/IbndJqO4P0vChTk2pcyqZWxF8ZJa22w0xDAW4hQn2h4/tcs734U0OzcViQX
         hWuVLuE0LbXnDoI7dusWlaeXbOzmAplOzKrC9vRUpswvT840BXgfalz9jCwltHV79eLt
         ZwhmD9aNG8FJujXuOj0Asa3Ucc+a3CX23ipdJRmQj7UXldVU1tOFrmAFCVej8TgepK0u
         spFwOBSeYderkYvmK++sfKrnoWy+QK8cq9ekrU7hFyy7r/CkW+nGCLZ5eAlPC9Ia7b+9
         tncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953606; x=1693558406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymCUaI9Sd81RMgDR1qn0M+wpDprHHG3RZOZbigNcOKc=;
        b=h0NLxdtPueNHRfguIQeDewRciEuhA2g1cwg6OZF6V7NfIybNieajtKOjLwmSrI6YjZ
         tmfX0tBBKwZNIBcxAVHkT3gvBdpfsTI+BJid0iJ0OjFGHdkdn9nOs8F8tIqJVyXidVM6
         C4heORIdSotcQbN3BzlU2ZYx6WJzH1Pbf7MEHvhys4k5CoXsKBqIdUOwayeObjMHVtUF
         XUCIe54cNi9wSAllYvPKd5haudl68QMJB/2O2SJmMRyeQMsbrAPVbHvi6UHuymd8EooL
         L8bj5SlLXzUQwjT67eoAOlCqXTg0eHsBfdKHpWygDU/V1Q/zQefeiQP2j5G0zTn8RJ8+
         26mQ==
X-Gm-Message-State: AOJu0YwFaMAFdb+BRuCL2iUPd1yfeGyfQdDnmuvY3w1wyKvrol57v6a7
	pKzWJHF+ffXBFjd9OEGrREbK7efWlc63ttZRTQpoL0Sx
X-Google-Smtp-Source: AGHT+IH552WjlPozGhHmWOwXEneL4k3Q1FmeDKzvo/kXeBE7fFnAbgCvbdlPmAGLzWwhXf6gr73VEA==
X-Received: by 2002:ac2:5f85:0:b0:500:9860:f8a with SMTP id r5-20020ac25f85000000b0050098600f8amr4328601lfe.4.1692953605481;
        Fri, 25 Aug 2023 01:53:25 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bce19000000b003fc080acf68sm4792172wmc.34.2023.08.25.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:53:24 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next 01/15] devlink: push object register/unregister notifications into separate helpers
Date: Fri, 25 Aug 2023 10:53:07 +0200
Message-ID: <20230825085321.178134-2-jiri@resnulli.us>
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
index e2cd13958cc2..a134dddf2632 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -978,6 +978,26 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
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
@@ -1004,6 +1024,22 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
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
@@ -1824,6 +1860,22 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
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
@@ -4181,6 +4233,26 @@ static void devlink_param_notify(struct devlink *devlink,
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
@@ -4590,6 +4662,22 @@ static void devlink_nl_region_notify(struct devlink_region *region,
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
@@ -6558,98 +6646,36 @@ const struct genl_small_ops devlink_nl_small_ops[40] = {
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
 
@@ -8775,6 +8801,24 @@ devlink_trap_group_notify(struct devlink *devlink,
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
@@ -8817,6 +8861,22 @@ static void devlink_trap_notify(struct devlink *devlink,
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
@@ -9278,6 +9338,25 @@ devlink_trap_policer_notify(struct devlink *devlink,
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


