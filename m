Return-Path: <netdev+bounces-26856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C4779398
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C439D1C216BD
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAEE329BD;
	Fri, 11 Aug 2023 15:57:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF55692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:27 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C330D4
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31965c94001so77108f8f.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769444; x=1692374244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkXwBDNeSXcWz6xkHzY/XF8RxF0kbokj0qe2BpFd5CY=;
        b=PzZXDj0omuJDwimMOWw5izRsHb7XZ8Mc96AQ52Vg94pnidcRBhTRaGHVV8TVHLUxK6
         LfkY9dhCAeSvYQPImppUEv26XprpSjnm6zwoHubMTwwJ2Be2BR/Es8DP/kSRggoCM+41
         vE+PAty5qUxFof9GJmEOMgv5/IQPBoJ/nNZ+w1i4bzjAc+l7jEy8S1X9X4GGf+Ty3YbJ
         r/W9ScQxE6gONX4rLCziW3pWlZ4zKUngwVgTAfGF1p6cEEvUTt7/rKEvaFMPMBNnvpm+
         ZqFT/uOgdE3pfzGKptYP7r1ZK9lWU0f9kNfoNEwjFbqMc+EMVqdGnYm2SehzGjapQdVu
         VdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769444; x=1692374244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkXwBDNeSXcWz6xkHzY/XF8RxF0kbokj0qe2BpFd5CY=;
        b=U1opExyUGV284G3jgDa5Qkl+YzSkVU90ct30Ccr7RO8DZuUhSsyiSV9IFuBP9h7pUz
         nXA3CB5/HiwBTOwEkgV9nxT8hl6A1RMNByuUDnUGU0oB1Yjo6JRqiJR3bbVTYLMAow7j
         qhWWfNwJy+sv05bijUAJch6KEADxrzRQSDMj2jXZbuk4kA7iB/j4heU5sdACl7traihT
         x6SV2kmbBCpazHHCXARGfOTZdChn1OhXVfHX0qGxLqEWDSVWYSamyB2oBGbaoKgWw3CO
         y4Ow09IMM/H5P/NEoy0pcKBOFnW1oFXoPWuEdffdctUp4ywupT4nCPO1kYN0qfkcIkTp
         DPsg==
X-Gm-Message-State: AOJu0YzpzGdzaDZttjtOXmB+VcBkpc+KFEAFVUxDttGb/1bdK4OmA+eg
	LT5zYPUgJeL47XcT9Ad82Whl2GeLPz3M0tyLHeIA4g==
X-Google-Smtp-Source: AGHT+IHl2GuNnvDp5RnCnIOC6svItsi3PFjvt2DIEf+eKY5puGp71jvLVFJT20F9+EP36xg79D+SwA==
X-Received: by 2002:a05:6000:104e:b0:314:1b6a:a095 with SMTP id c14-20020a056000104e00b003141b6aa095mr1782839wrx.23.1691769444080;
        Fri, 11 Aug 2023 08:57:24 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q11-20020adff94b000000b00317c742ca9asm5693550wrr.43.2023.08.11.08.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:23 -0700 (PDT)
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
Subject: [patch net-next v4 04/13] devlink: rename doit callbacks for per-instance dump commands
Date: Fri, 11 Aug 2023 17:57:05 +0200
Message-ID: <20230811155714.1736405-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811155714.1736405-1-jiri@resnulli.us>
References: <20230811155714.1736405-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Rename netlink doit callback functions for the commands that do
implement per-instance dump to match the generated names that are going
to be introduce in the follow-up patch.

Note that the function prototypes are temporary until the generated ones
will replace them in a follow-up patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/dev.c           |  3 +-
 net/devlink/devl_internal.h | 22 ++++++++++--
 net/devlink/health.c        |  4 +--
 net/devlink/leftover.c      | 68 ++++++++++++++++---------------------
 4 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 5dfba2248b90..167fe6188d21 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -1206,8 +1206,7 @@ devlink_nl_selftests_fill(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-int devlink_nl_cmd_selftests_get_doit(struct sk_buff *skb,
-				      struct genl_info *info)
+int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct sk_buff *msg;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 9851fd48ab59..f29ec0bfc559 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -214,10 +214,22 @@ int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_health_reporter_get_doit(struct sk_buff *skb,
-					    struct genl_info *info);
+int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
+				     struct genl_info *info);
+int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
+					struct genl_info *info);
+int devlink_nl_param_get_doit(struct sk_buff *skb,
+			      struct genl_info *info);
+int devlink_nl_region_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
+					struct genl_info *info);
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
 					    struct genl_info *info);
 int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
@@ -230,3 +242,7 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 						   struct genl_info *info);
 int devlink_nl_cmd_health_reporter_test_doit(struct sk_buff *skb,
 					     struct genl_info *info);
+int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
+				     struct genl_info *info);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 194340a8bb86..6df4e343d8c2 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -356,8 +356,8 @@ devlink_health_reporter_get_from_info(struct devlink *devlink,
 	return devlink_health_reporter_get_from_attrs(devlink, info->attrs);
 }
 
-int devlink_nl_cmd_health_reporter_get_doit(struct sk_buff *skb,
-					    struct genl_info *info)
+int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
+					struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_health_reporter *reporter;
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index b7b6850e26d8..bd8fa2f9a05b 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -1038,8 +1038,7 @@ const struct devlink_cmd devl_cmd_rate_get = {
 	.dump_one		= devlink_nl_cmd_rate_get_dump_one,
 };
 
-static int devlink_nl_cmd_rate_get_doit(struct sk_buff *skb,
-					struct genl_info *info)
+int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_rate *devlink_rate;
@@ -1077,8 +1076,7 @@ devlink_rate_is_parent_node(struct devlink_rate *devlink_rate,
 	return false;
 }
 
-static int devlink_nl_cmd_port_get_doit(struct sk_buff *skb,
-					struct genl_info *info)
+int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct sk_buff *msg;
@@ -1825,8 +1823,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
-static int devlink_nl_cmd_linecard_get_doit(struct sk_buff *skb,
-					    struct genl_info *info)
+int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_linecard *linecard;
@@ -2091,8 +2088,7 @@ static int devlink_nl_sb_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_sb_get_doit(struct sk_buff *skb,
-				      struct genl_info *info)
+int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_sb *devlink_sb;
@@ -2194,8 +2190,7 @@ static int devlink_nl_sb_pool_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_sb_pool_get_doit(struct sk_buff *skb,
-					   struct genl_info *info)
+int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_sb *devlink_sb;
@@ -2394,8 +2389,8 @@ static int devlink_nl_sb_port_pool_fill(struct sk_buff *msg,
 	return err;
 }
 
-static int devlink_nl_cmd_sb_port_pool_get_doit(struct sk_buff *skb,
-						struct genl_info *info)
+int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
+				     struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = devlink_port->devlink;
@@ -2603,8 +2598,8 @@ devlink_nl_sb_tc_pool_bind_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
-						   struct genl_info *info)
+int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
+					struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = devlink_port->devlink;
@@ -4295,8 +4290,8 @@ devlink_param_get_from_info(struct xarray *params, struct genl_info *info)
 	return devlink_param_find_by_name(params, param_name);
 }
 
-static int devlink_nl_cmd_param_get_doit(struct sk_buff *skb,
-					 struct genl_info *info)
+int devlink_nl_param_get_doit(struct sk_buff *skb,
+			      struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_param_item *param_item;
@@ -4793,8 +4788,7 @@ static void devlink_region_snapshot_del(struct devlink_region *region,
 	kfree(snapshot);
 }
 
-static int devlink_nl_cmd_region_get_doit(struct sk_buff *skb,
-					  struct genl_info *info)
+int devlink_nl_region_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_port *port = NULL;
@@ -5655,8 +5649,7 @@ static int devlink_nl_trap_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_trap_get_doit(struct sk_buff *skb,
-					struct genl_info *info)
+int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink *devlink = info->user_ptr[0];
@@ -5866,8 +5859,7 @@ devlink_nl_trap_group_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_trap_group_get_doit(struct sk_buff *skb,
-					      struct genl_info *info)
+int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink *devlink = info->user_ptr[0];
@@ -6160,8 +6152,8 @@ devlink_nl_trap_policer_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_trap_policer_get_doit(struct sk_buff *skb,
-						struct genl_info *info)
+int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
+				     struct genl_info *info)
 {
 	struct devlink_trap_policer_item *policer_item;
 	struct netlink_ext_ack *extack = info->extack;
@@ -6305,7 +6297,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_get_doit,
+		.doit = devlink_nl_port_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 		/* can be retrieved by unprivileged users */
@@ -6319,7 +6311,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	},
 	{
 		.cmd = DEVLINK_CMD_RATE_GET,
-		.doit = devlink_nl_cmd_rate_get_doit,
+		.doit = devlink_nl_rate_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6365,7 +6357,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	},
 	{
 		.cmd = DEVLINK_CMD_LINECARD_GET,
-		.doit = devlink_nl_cmd_linecard_get_doit,
+		.doit = devlink_nl_linecard_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6377,14 +6369,14 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_SB_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_get_doit,
+		.doit = devlink_nl_sb_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_SB_POOL_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_pool_get_doit,
+		.doit = devlink_nl_sb_pool_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6397,7 +6389,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_SB_PORT_POOL_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_port_pool_get_doit,
+		.doit = devlink_nl_sb_port_pool_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 		/* can be retrieved by unprivileged users */
@@ -6412,7 +6404,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_tc_pool_bind_get_doit,
+		.doit = devlink_nl_sb_tc_pool_bind_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 		/* can be retrieved by unprivileged users */
@@ -6493,7 +6485,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_PARAM_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_param_get_doit,
+		.doit = devlink_nl_param_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6521,7 +6513,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_REGION_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_region_get_doit,
+		.doit = devlink_nl_region_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		.flags = GENL_ADMIN_PERM,
 	},
@@ -6547,7 +6539,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_get_doit,
+		.doit = devlink_nl_health_reporter_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
 		/* can be retrieved by unprivileged users */
@@ -6602,7 +6594,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_GET,
-		.doit = devlink_nl_cmd_trap_get_doit,
+		.doit = devlink_nl_trap_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6613,7 +6605,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_GROUP_GET,
-		.doit = devlink_nl_cmd_trap_group_get_doit,
+		.doit = devlink_nl_trap_group_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6624,7 +6616,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_POLICER_GET,
-		.doit = devlink_nl_cmd_trap_policer_get_doit,
+		.doit = devlink_nl_trap_policer_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6635,7 +6627,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	},
 	{
 		.cmd = DEVLINK_CMD_SELFTESTS_GET,
-		.doit = devlink_nl_cmd_selftests_get_doit,
+		.doit = devlink_nl_selftests_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
-- 
2.41.0


