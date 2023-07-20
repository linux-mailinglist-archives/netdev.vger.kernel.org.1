Return-Path: <netdev+bounces-19493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803075AE34
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A211C2141F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979E18B10;
	Thu, 20 Jul 2023 12:18:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796218AE6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:48 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F732115
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so606803f8f.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855525; x=1690460325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhsdohNrpAKlDKxlWkClE3hMEC+PlU07lAyGbkdCoME=;
        b=4tTrogEMLpltBC+jb3/7oktR/7Snpx6rHPuPSX9vx4TvurEXn/dwjx0Gaqe/rWH+MM
         Tn2Cjz0IWmlXVwhJNg4d5199Ge63/xZN6g9B8bw9h8flSadWksbg/BZkRopV0zUXXypb
         Lnh4Sn3058VW2NhUB5RY/t8z4AEpM/vMyaa8o4abrH204TEMV9zgHtQa+UhY9U44eak5
         miex4+cMKx2W64zeaTw+jQnoGsVaznWPY5U1I4Ccdc9cKwKcHRzSXHYoK9Z7OtI7R3Ng
         Smh6Plapnv/ZacMmi/5O+tDLEtEjjrItmm9zJuc4HN0xQDY1RY/xXVpDUr7oc49EZ0V8
         QnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855525; x=1690460325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhsdohNrpAKlDKxlWkClE3hMEC+PlU07lAyGbkdCoME=;
        b=U3HhJ1Og48NNKRXId1y/ja006ZR/cBGbs6mZ94DqYpOlTBx6mZ/f4eNTcrcNLKgrUh
         BC39uFqOl7M2EDvlH/ffEw0PqsnZHT+hxEV1yhTMsA2Y1M79Ttsv4gUy/3VQmrMYo48C
         pJSJSHJKhsbPY85NFBkExR63gV5C4/fsfG7WYON88JzcPeOYK8rqdrrH+taeOXkBv1ED
         utJa4dEXCDkkIn39koUgSLdvy+ypUzRhYOSZXrISo7gyoQkonNq/fj+LgZ4roGvbVs4z
         Wid3ZWJ5X4G9Z319M/xNcOJPG254/xdhToQXonju6ZS8I92A3LYyhXzQ7Nif/m+LqUm1
         plRg==
X-Gm-Message-State: ABy/qLbbcy4kcf2LIjfjrtGQcgr00M5WPc2s09jaJx4a4ZyB0zIjGMFl
	AhmjMgB7V6/Cn1qpO2ePT/b6G2z4rjSicaiQkTA=
X-Google-Smtp-Source: APBJJlHb9dsBx1+DTfwF58IRCHVnaFRN06rjjomKV8in2mphxRfn9TVfcKl7857h5SuQn6nCyVHLxA==
X-Received: by 2002:adf:ee8f:0:b0:314:2ba3:15dd with SMTP id b15-20020adfee8f000000b003142ba315ddmr1698362wro.16.1689855525220;
        Thu, 20 Jul 2023 05:18:45 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bcc0c000000b003fc0062f0f8sm1079569wmh.9.2023.07.20.05.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:44 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v2 09/11] devlink: convert rest of the iterator dumpit commands to split ops
Date: Thu, 20 Jul 2023 14:18:27 +0200
Message-ID: <20230720121829.566974-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720121829.566974-1-jiri@resnulli.us>
References: <20230720121829.566974-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

In a similar fashion couple of example commands were converted
previously, do the conversion of the rest of the commands that use
devlink_nl_instance_iter_dumpit() callback.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  19 ++++--
 net/devlink/leftover.c      | 115 +++++-------------------------------
 net/devlink/netlink.c       |  28 ++++++++-
 3 files changed, 56 insertions(+), 106 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index dc655d5797a8..79614b45e8ac 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -116,7 +116,7 @@ struct devlink_cmd {
 			struct netlink_callback *cb);
 };
 
-extern const struct genl_small_ops devlink_nl_ops[52];
+extern const struct genl_small_ops devlink_nl_ops[40];
 
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
@@ -124,9 +124,6 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
 void devlink_notify_unregister(struct devlink *devlink);
 void devlink_notify_register(struct devlink *devlink);
 
-int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
-				    struct netlink_callback *cb);
-
 static inline struct devlink_nl_dump_state *
 devlink_dump_state(struct netlink_callback *cb)
 {
@@ -211,8 +208,15 @@ int devlink_nl_cmd_selftests_get_doit(struct sk_buff *skb, struct genl_info *inf
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_port_get_doit(struct sk_buff *skb,
 				 struct genl_info *info);
+int devlink_nl_cmd_sb_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_sb_port_pool_get_doit(struct sk_buff *skb,
+					 struct genl_info *info);
+int devlink_nl_cmd_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
+					    struct genl_info *info);
 int devlink_nl_cmd_param_get_doit(struct sk_buff *skb,
 				  struct genl_info *info);
+int devlink_nl_cmd_region_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_health_reporter_get_doit(struct sk_buff *skb,
 					    struct genl_info *info);
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
@@ -227,4 +231,11 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 						   struct genl_info *info);
 int devlink_nl_cmd_health_reporter_test_doit(struct sk_buff *skb,
 					     struct genl_info *info);
+int devlink_nl_cmd_rate_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_linecard_get_doit(struct sk_buff *skb,
+				     struct genl_info *info);
 int devlink_nl_cmd_trap_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_trap_group_get_doit(struct sk_buff *skb,
+				       struct genl_info *info);
+int devlink_nl_cmd_trap_policer_get_doit(struct sk_buff *skb,
+					 struct genl_info *info);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 3dbba1906ee6..58ea1b9cc708 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -1038,8 +1038,7 @@ const struct devlink_cmd devl_cmd_rate_get = {
 	.dump_one		= devlink_nl_cmd_rate_get_dump_one,
 };
 
-static int devlink_nl_cmd_rate_get_doit(struct sk_buff *skb,
-					struct genl_info *info)
+int devlink_nl_cmd_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_rate *devlink_rate;
@@ -1825,8 +1824,8 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
-static int devlink_nl_cmd_linecard_get_doit(struct sk_buff *skb,
-					    struct genl_info *info)
+int devlink_nl_cmd_linecard_get_doit(struct sk_buff *skb,
+				     struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_linecard *linecard;
@@ -2091,8 +2090,7 @@ static int devlink_nl_sb_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_sb_get_doit(struct sk_buff *skb,
-				      struct genl_info *info)
+int devlink_nl_cmd_sb_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_sb *devlink_sb;
@@ -2194,8 +2192,7 @@ static int devlink_nl_sb_pool_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_sb_pool_get_doit(struct sk_buff *skb,
-					   struct genl_info *info)
+int devlink_nl_cmd_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_sb *devlink_sb;
@@ -2394,8 +2391,8 @@ static int devlink_nl_sb_port_pool_fill(struct sk_buff *msg,
 	return err;
 }
 
-static int devlink_nl_cmd_sb_port_pool_get_doit(struct sk_buff *skb,
-						struct genl_info *info)
+int devlink_nl_cmd_sb_port_pool_get_doit(struct sk_buff *skb,
+					 struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = devlink_port->devlink;
@@ -2603,8 +2600,8 @@ devlink_nl_sb_tc_pool_bind_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
-						   struct genl_info *info)
+int devlink_nl_cmd_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
+					    struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = devlink_port->devlink;
@@ -4793,8 +4790,7 @@ static void devlink_region_snapshot_del(struct devlink_region *region,
 	kfree(snapshot);
 }
 
-static int devlink_nl_cmd_region_get_doit(struct sk_buff *skb,
-					  struct genl_info *info)
+int devlink_nl_cmd_region_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_port *port = NULL;
@@ -5865,8 +5861,8 @@ devlink_nl_trap_group_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_trap_group_get_doit(struct sk_buff *skb,
-					      struct genl_info *info)
+int devlink_nl_cmd_trap_group_get_doit(struct sk_buff *skb,
+				       struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink *devlink = info->user_ptr[0];
@@ -6159,8 +6155,8 @@ devlink_nl_trap_policer_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_trap_policer_get_doit(struct sk_buff *skb,
-						struct genl_info *info)
+int devlink_nl_cmd_trap_policer_get_doit(struct sk_buff *skb,
+					 struct genl_info *info)
 {
 	struct devlink_trap_policer_item *policer_item;
 	struct netlink_ext_ack *extack = info->extack;
@@ -6300,14 +6296,7 @@ static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 	return devlink_trap_policer_set(devlink, policer_item, info);
 }
 
-const struct genl_small_ops devlink_nl_ops[52] = {
-	{
-		.cmd = DEVLINK_CMD_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
+const struct genl_small_ops devlink_nl_ops[40] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6315,12 +6304,6 @@ const struct genl_small_ops devlink_nl_ops[52] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
-	{
-		.cmd = DEVLINK_CMD_RATE_GET,
-		.doit = devlink_nl_cmd_rate_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_RATE_SET,
 		.doit = devlink_nl_cmd_rate_set_doit,
@@ -6361,45 +6344,17 @@ const struct genl_small_ops devlink_nl_ops[52] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
-	{
-		.cmd = DEVLINK_CMD_LINECARD_GET,
-		.doit = devlink_nl_cmd_linecard_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_LINECARD_SET,
 		.doit = devlink_nl_cmd_linecard_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_SB_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_POOL_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_pool_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_SB_POOL_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_cmd_sb_pool_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_SB_PORT_POOL_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_port_pool_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_SB_PORT_POOL_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6407,14 +6362,6 @@ const struct genl_small_ops devlink_nl_ops[52] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
-	{
-		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_tc_pool_bind_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6509,13 +6456,6 @@ const struct genl_small_ops devlink_nl_ops[52] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
-	{
-		.cmd = DEVLINK_CMD_REGION_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_region_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		.flags = GENL_ADMIN_PERM,
-	},
 	{
 		.cmd = DEVLINK_CMD_REGION_NEW,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6535,13 +6475,6 @@ const struct genl_small_ops devlink_nl_ops[52] = {
 		.dumpit = devlink_nl_cmd_region_read_dumpit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_INFO_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_info_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6595,34 +6528,16 @@ const struct genl_small_ops devlink_nl_ops[52] = {
 		.doit = devlink_nl_cmd_trap_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_GROUP_GET,
-		.doit = devlink_nl_cmd_trap_group_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_GROUP_SET,
 		.doit = devlink_nl_cmd_trap_group_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_POLICER_GET,
-		.doit = devlink_nl_cmd_trap_policer_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_POLICER_SET,
 		.doit = devlink_nl_cmd_trap_policer_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_SELFTESTS_GET,
-		.doit = devlink_nl_cmd_selftests_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_SELFTESTS_RUN,
 		.doit = devlink_nl_cmd_selftests_run,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 3dae9303cfa7..90497d0e1a7b 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -195,8 +195,8 @@ static const struct devlink_cmd *devl_cmds[] = {
 	[DEVLINK_CMD_SELFTESTS_GET]	= &devl_cmd_selftests_get,
 };
 
-int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
-				    struct netlink_callback *cb)
+static int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
+					   struct netlink_callback *cb)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
@@ -286,15 +286,39 @@ int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 	__DEVL_NL_OP_DUMP(cmd_subname, 0, maxattr, policy)
 
 static const struct genl_split_ops devlink_nl_split_ops[] = {
+	DEVL_NL_OP_LEGACY_DO(GET, get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(GET),
 	DEVL_NL_OP_LEGACY_DO(PORT_GET, port_get, port),
 	DEVL_NL_OP_LEGACY_DUMP(PORT_GET),
+	DEVL_NL_OP_LEGACY_DO(SB_GET, sb_get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(SB_GET),
+	DEVL_NL_OP_LEGACY_DO(SB_POOL_GET, sb_pool_get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(SB_POOL_GET),
+	DEVL_NL_OP_LEGACY_DO(SB_PORT_POOL_GET, sb_port_pool_get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(SB_PORT_POOL_GET),
+	DEVL_NL_OP_LEGACY_DO(SB_TC_POOL_BIND_GET, sb_tc_pool_bind_get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(SB_TC_POOL_BIND_GET),
 	DEVL_NL_OP_LEGACY_DO(PARAM_GET, param_get, simple),
 	DEVL_NL_OP_LEGACY_DUMP(PARAM_GET),
+	DEVL_NL_OP_LEGACY_DO(REGION_GET, region_get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(REGION_GET),
+	DEVL_NL_OP_LEGACY_DO(INFO_GET, info_get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(INFO_GET),
 	DEVL_NL_OP_LEGACY_DO(HEALTH_REPORTER_GET, health_reporter_get,
 			     port_optional),
 	DEVL_NL_OP_LEGACY_DUMP(HEALTH_REPORTER_GET),
 	DEVL_NL_OP_LEGACY_STRICT_DO(TRAP_GET, trap_get, simple),
 	DEVL_NL_OP_LEGACY_STRICT_DUMP(TRAP_GET),
+	DEVL_NL_OP_LEGACY_STRICT_DO(TRAP_GROUP_GET, trap_group_get, simple),
+	DEVL_NL_OP_LEGACY_STRICT_DUMP(TRAP_GROUP_GET),
+	DEVL_NL_OP_LEGACY_STRICT_DO(TRAP_POLICER_GET, trap_policer_get, simple),
+	DEVL_NL_OP_LEGACY_STRICT_DUMP(TRAP_POLICER_GET),
+	DEVL_NL_OP_LEGACY_DO(RATE_GET, rate_get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(RATE_GET),
+	DEVL_NL_OP_LEGACY_DO(LINECARD_GET, linecard_get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(LINECARD_GET),
+	DEVL_NL_OP_LEGACY_STRICT_DO(SELFTESTS_GET, selftests_get, simple),
+	DEVL_NL_OP_LEGACY_STRICT_DUMP(SELFTESTS_GET),
 	/* For every newly added command put above this line the set of macros
 	 * DEVL_NL_OP_DO and DEVL_NL_OP_DUMP should be used. Note that
 	 * there is an exception with non-iterator dump implementation.
-- 
2.41.0


