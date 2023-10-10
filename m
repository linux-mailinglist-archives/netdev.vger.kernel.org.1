Return-Path: <netdev+bounces-39523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6617BF941
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C10E1C20B80
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE4E182AC;
	Tue, 10 Oct 2023 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QqBvGBup"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E556FBFC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:08:50 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB4DAF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9adb9fa7200so1204225566b.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936124; x=1697540924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlZOSn5Omy9jQk1WdIa5mWYTssZqCKsRPfMKTMzKmU0=;
        b=QqBvGBupM9H8moiNLMHxym/uoJyOLk8bUF1duTsPQHSvPVXEawiirRO+R7i/8dCQo1
         jY7/viSp3x7TsMszy7sFd4b8V25nRp6hIcT2FSeygbRRQlg2He7Ixg52Qz57xxtyebla
         BF/CzRTMcG0Bbp9h7YrY74YcnIjamM2ibntSZcovmSzJTl7yJMMCo3S2KDr3EvSSsxk9
         vJ4zJlwUe0CzVJrpTJ0j3shlnC4N9WgZYlVWMSa5FWNHVieflOJZy/FHuQGR8kyHgTdP
         wZb/JUQabnmqtcpzg7iROPs8lzh2TJ2lu0iobfGOr7lRIgbK3xRnkCkdvyLAq8k83LCl
         2PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936124; x=1697540924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlZOSn5Omy9jQk1WdIa5mWYTssZqCKsRPfMKTMzKmU0=;
        b=hp1zwowlAVdQmE/Dkp5fl/BpXDIONZLe7CWlm23TdcJZr5l0zKNxPPlRGCc8/HrxXc
         PZuijjG0FgDEHpmLgF5+FonsxB7kNa5kXIgRkt1btrpw+2OfK3PW6lqhEU5+kznvGrd9
         nu9/T8uKQFygo76TGckRXBlOzyVKyH9PowueBGWJyvIaaQVI85sHtQgem1MzrVJHqpMS
         LsdEQHk6EcG7FvhPu5azOkJv4HI1VBkrAVq3F0QSCTtG6qWYlPwDF902w9wE2spJymv/
         igNQwh9hnDGXQd32fAvTqMAH7KS1EfcVEku+v1JPutV/b9b1QPeTQntF4I7npjyEjOw9
         +OsQ==
X-Gm-Message-State: AOJu0YxRuNz5Jgv5sk88XCR0xw749v6RvNUVxBxkq2hXdCvcoZi+0gUR
	Abj3eh7ESMQIbt5V5U/EOzDRRqfzvu/CuOqKWX0=
X-Google-Smtp-Source: AGHT+IFGN49+/fm5IroTB0KfTDo/wlIzGM9tXdI5a55aoImcclYOO1JNCwEdmJMxYesIgAAyDINPbQ==
X-Received: by 2002:a17:907:3e1a:b0:9ae:699d:8a31 with SMTP id hp26-20020a1709073e1a00b009ae699d8a31mr17159576ejc.33.1696936123726;
        Tue, 10 Oct 2023 04:08:43 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b00992ea405a79sm8199640ejb.166.2023.10.10.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:08:43 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 07/10] devlink: rename netlink callback to be aligned with the generated ones
Date: Tue, 10 Oct 2023 13:08:26 +0200
Message-ID: <20231010110828.200709-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010110828.200709-1-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
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

All remaining doit and dumpit netlink callback functions are going to be
used by generated split ops. They expect certain name format. Rename the
callback to be aligned with generated names.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c           |  10 ++--
 net/devlink/devl_internal.h | 108 ++++++++++++++++++------------------
 net/devlink/dpipe.c         |  14 ++---
 net/devlink/health.c        |  24 ++++----
 net/devlink/linecard.c      |   3 +-
 net/devlink/netlink.c       |  82 +++++++++++++--------------
 net/devlink/param.c         |  14 ++---
 net/devlink/port.c          |  11 ++--
 net/devlink/rate.c          |   6 +-
 net/devlink/region.c        |   8 +--
 net/devlink/resource.c      |   4 +-
 net/devlink/sb.c            |  17 +++---
 net/devlink/trap.c          |   9 ++-
 13 files changed, 152 insertions(+), 158 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index dc8039ca2b38..4fc7adb32663 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -492,7 +492,7 @@ devlink_nl_reload_actions_performed_snd(struct devlink *devlink, u32 actions_per
 	return -EMSGSIZE;
 }
 
-int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	enum devlink_reload_action action;
@@ -658,7 +658,7 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct sk_buff *msg;
@@ -679,7 +679,7 @@ int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
-int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	const struct devlink_ops *ops = devlink->ops;
@@ -1108,7 +1108,7 @@ static int devlink_flash_component_get(struct devlink *devlink,
 	return 0;
 }
 
-int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_flash_update_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *nla_overwrite_mask, *nla_file_name;
 	struct devlink_flash_update_params params = {};
@@ -1351,7 +1351,7 @@ static const struct nla_policy devlink_selftest_nl_policy[DEVLINK_ATTR_SELFTEST_
 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG },
 };
 
-int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *tb[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
 	struct devlink *devlink = info->user_ptr[0];
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 741d1bf1bec8..daf4c696a618 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -229,65 +229,63 @@ int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
 
 /* Devlink nl cmds */
-int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_port_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_port_split_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_port_unsplit_doit(struct sk_buff *skb,
+int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_flash_update_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_port_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_port_split_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_port_unsplit_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_port_del_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_sb_port_pool_set_doit(struct sk_buff *skb,
 				     struct genl_info *info);
-int devlink_nl_cmd_port_new_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_port_del_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_sb_port_pool_set_doit(struct sk_buff *skb,
-					 struct genl_info *info);
-int devlink_nl_cmd_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
-					    struct genl_info *info);
-int devlink_nl_cmd_sb_occ_snapshot_doit(struct sk_buff *skb,
+int devlink_nl_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
 					struct genl_info *info);
-int devlink_nl_cmd_sb_occ_max_clear_doit(struct sk_buff *skb,
-					 struct genl_info *info);
-int devlink_nl_cmd_dpipe_table_get(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_dpipe_entries_get(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_cmd_dpipe_headers_get(struct sk_buff *skb,
+int devlink_nl_sb_occ_snapshot_doit(struct sk_buff *skb,
+				    struct genl_info *info);
+int devlink_nl_sb_occ_max_clear_doit(struct sk_buff *skb,
 				     struct genl_info *info);
-int devlink_nl_cmd_dpipe_table_counters_set(struct sk_buff *skb,
-					    struct genl_info *info);
-int devlink_nl_cmd_resource_set(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_resource_dump(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_param_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_port_param_get_dumpit(struct sk_buff *msg,
-					 struct netlink_callback *cb);
-int devlink_nl_cmd_port_param_get_doit(struct sk_buff *skb,
-				       struct genl_info *info);
-int devlink_nl_cmd_port_param_set_doit(struct sk_buff *skb,
-				       struct genl_info *info);
-int devlink_nl_cmd_region_new(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_region_del(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_region_read_dumpit(struct sk_buff *skb,
-				      struct netlink_callback *cb);
-int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
+int devlink_nl_dpipe_table_get_doit(struct sk_buff *skb,
+				    struct genl_info *info);
+int devlink_nl_dpipe_entries_get_doit(struct sk_buff *skb,
+				      struct genl_info *info);
+int devlink_nl_dpipe_headers_get_doit(struct sk_buff *skb,
+				      struct genl_info *info);
+int devlink_nl_dpipe_table_counters_set_doit(struct sk_buff *skb,
+					     struct genl_info *info);
+int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_port_param_get_dumpit(struct sk_buff *msg,
+				     struct netlink_callback *cb);
+int devlink_nl_port_param_get_doit(struct sk_buff *skb,
+				   struct genl_info *info);
+int devlink_nl_port_param_set_doit(struct sk_buff *skb,
+				   struct genl_info *info);
+int devlink_nl_region_new_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_region_del_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_region_read_dumpit(struct sk_buff *skb,
+				  struct netlink_callback *cb);
+int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
+					struct genl_info *info);
+int devlink_nl_health_reporter_recover_doit(struct sk_buff *skb,
 					    struct genl_info *info);
-int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
-						struct genl_info *info);
-int devlink_nl_cmd_health_reporter_diagnose_doit(struct sk_buff *skb,
-						 struct genl_info *info);
-int devlink_nl_cmd_health_reporter_dump_get_dumpit(struct sk_buff *skb,
-						   struct netlink_callback *cb);
-int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
-						   struct genl_info *info);
-int devlink_nl_cmd_health_reporter_test_doit(struct sk_buff *skb,
+int devlink_nl_health_reporter_diagnose_doit(struct sk_buff *skb,
 					     struct genl_info *info);
-int devlink_nl_cmd_trap_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_trap_group_set_doit(struct sk_buff *skb,
-				       struct genl_info *info);
-int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
+int devlink_nl_health_reporter_dump_get_dumpit(struct sk_buff *skb,
+					       struct netlink_callback *cb);
+int devlink_nl_health_reporter_dump_clear_doit(struct sk_buff *skb,
+					       struct genl_info *info);
+int devlink_nl_health_reporter_test_doit(struct sk_buff *skb,
 					 struct genl_info *info);
-int devlink_nl_cmd_rate_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_rate_new_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_rate_del_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
+int devlink_nl_trap_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_trap_group_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_trap_policer_set_doit(struct sk_buff *skb,
 				     struct genl_info *info);
+int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_linecard_set_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/dpipe.c b/net/devlink/dpipe.c
index 431227c412e5..a72a9292efc5 100644
--- a/net/devlink/dpipe.c
+++ b/net/devlink/dpipe.c
@@ -289,7 +289,7 @@ static int devlink_dpipe_tables_fill(struct genl_info *info,
 	return err;
 }
 
-int devlink_nl_cmd_dpipe_table_get(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_dpipe_table_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	const char *table_name =  NULL;
@@ -562,8 +562,8 @@ static int devlink_dpipe_entries_fill(struct genl_info *info,
 	return genlmsg_reply(dump_ctx.skb, info);
 }
 
-int devlink_nl_cmd_dpipe_entries_get(struct sk_buff *skb,
-				     struct genl_info *info)
+int devlink_nl_dpipe_entries_get_doit(struct sk_buff *skb,
+				      struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_dpipe_table *table;
@@ -712,8 +712,8 @@ static int devlink_dpipe_headers_fill(struct genl_info *info,
 	return err;
 }
 
-int devlink_nl_cmd_dpipe_headers_get(struct sk_buff *skb,
-				     struct genl_info *info)
+int devlink_nl_dpipe_headers_get_doit(struct sk_buff *skb,
+				      struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 
@@ -746,8 +746,8 @@ static int devlink_dpipe_table_counters_set(struct devlink *devlink,
 	return 0;
 }
 
-int devlink_nl_cmd_dpipe_table_counters_set(struct sk_buff *skb,
-					    struct genl_info *info)
+int devlink_nl_dpipe_table_counters_set_doit(struct sk_buff *skb,
+					     struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	const char *table_name;
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 638cad8d5c65..1a13a90cf5c7 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -454,8 +454,8 @@ int devlink_nl_health_reporter_get_dumpit(struct sk_buff *skb,
 				 devlink_nl_health_reporter_get_dump_one);
 }
 
-int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
-					    struct genl_info *info)
+int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
+					struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_health_reporter *reporter;
@@ -660,8 +660,8 @@ devlink_health_reporter_state_update(struct devlink_health_reporter *reporter,
 }
 EXPORT_SYMBOL_GPL(devlink_health_reporter_state_update);
 
-int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
-						struct genl_info *info)
+int devlink_nl_health_reporter_recover_doit(struct sk_buff *skb,
+					    struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_health_reporter *reporter;
@@ -1222,8 +1222,8 @@ static int devlink_fmsg_dumpit(struct devlink_fmsg *fmsg, struct sk_buff *skb,
 	return err;
 }
 
-int devlink_nl_cmd_health_reporter_diagnose_doit(struct sk_buff *skb,
-						 struct genl_info *info)
+int devlink_nl_health_reporter_diagnose_doit(struct sk_buff *skb,
+					     struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_health_reporter *reporter;
@@ -1279,8 +1279,8 @@ devlink_health_reporter_get_from_cb(struct netlink_callback *cb)
 	return reporter;
 }
 
-int devlink_nl_cmd_health_reporter_dump_get_dumpit(struct sk_buff *skb,
-						   struct netlink_callback *cb)
+int devlink_nl_health_reporter_dump_get_dumpit(struct sk_buff *skb,
+					       struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_health_reporter *reporter;
@@ -1313,8 +1313,8 @@ int devlink_nl_cmd_health_reporter_dump_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
-int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
-						   struct genl_info *info)
+int devlink_nl_health_reporter_dump_clear_doit(struct sk_buff *skb,
+					       struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_health_reporter *reporter;
@@ -1332,8 +1332,8 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 	return 0;
 }
 
-int devlink_nl_cmd_health_reporter_test_doit(struct sk_buff *skb,
-					     struct genl_info *info)
+int devlink_nl_health_reporter_test_doit(struct sk_buff *skb,
+					 struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_health_reporter *reporter;
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 9ff1813f88c5..2f1c317b64cd 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -369,8 +369,7 @@ static int devlink_linecard_type_unset(struct devlink_linecard *linecard,
 	return err;
 }
 
-int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
-				     struct genl_info *info)
+int devlink_nl_linecard_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink *devlink = info->user_ptr[0];
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 809bfc3ba8c4..ca63e59a5e92 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -291,200 +291,200 @@ static const struct genl_small_ops devlink_nl_small_ops[40] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_set_doit,
+		.doit = devlink_nl_port_set_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_RATE_SET,
-		.doit = devlink_nl_cmd_rate_set_doit,
+		.doit = devlink_nl_rate_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_RATE_NEW,
-		.doit = devlink_nl_cmd_rate_new_doit,
+		.doit = devlink_nl_rate_new_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_RATE_DEL,
-		.doit = devlink_nl_cmd_rate_del_doit,
+		.doit = devlink_nl_rate_del_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_PORT_SPLIT,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_split_doit,
+		.doit = devlink_nl_port_split_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_PORT_UNSPLIT,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_unsplit_doit,
+		.doit = devlink_nl_port_unsplit_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_PORT_NEW,
-		.doit = devlink_nl_cmd_port_new_doit,
+		.doit = devlink_nl_port_new_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_PORT_DEL,
-		.doit = devlink_nl_cmd_port_del_doit,
+		.doit = devlink_nl_port_del_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
 
 	{
 		.cmd = DEVLINK_CMD_LINECARD_SET,
-		.doit = devlink_nl_cmd_linecard_set_doit,
+		.doit = devlink_nl_linecard_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_SB_POOL_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_pool_set_doit,
+		.doit = devlink_nl_sb_pool_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_SB_PORT_POOL_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_port_pool_set_doit,
+		.doit = devlink_nl_sb_port_pool_set_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_tc_pool_bind_set_doit,
+		.doit = devlink_nl_sb_tc_pool_bind_set_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_SB_OCC_SNAPSHOT,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_occ_snapshot_doit,
+		.doit = devlink_nl_sb_occ_snapshot_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_SB_OCC_MAX_CLEAR,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_occ_max_clear_doit,
+		.doit = devlink_nl_sb_occ_max_clear_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_ESWITCH_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_eswitch_get_doit,
+		.doit = devlink_nl_eswitch_get_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_ESWITCH_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_eswitch_set_doit,
+		.doit = devlink_nl_eswitch_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_DPIPE_TABLE_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_table_get,
+		.doit = devlink_nl_dpipe_table_get_doit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_DPIPE_ENTRIES_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_entries_get,
+		.doit = devlink_nl_dpipe_entries_get_doit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_DPIPE_HEADERS_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_headers_get,
+		.doit = devlink_nl_dpipe_headers_get_doit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_table_counters_set,
+		.doit = devlink_nl_dpipe_table_counters_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_RESOURCE_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_resource_set,
+		.doit = devlink_nl_resource_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_RESOURCE_DUMP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_resource_dump,
+		.doit = devlink_nl_resource_dump_doit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_RELOAD,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_reload,
+		.doit = devlink_nl_reload_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_PARAM_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_param_set_doit,
+		.doit = devlink_nl_param_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_PORT_PARAM_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_param_get_doit,
-		.dumpit = devlink_nl_cmd_port_param_get_dumpit,
+		.doit = devlink_nl_port_param_get_doit,
+		.dumpit = devlink_nl_port_param_get_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_PORT_PARAM_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_param_set_doit,
+		.doit = devlink_nl_port_param_set_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_REGION_NEW,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_region_new,
+		.doit = devlink_nl_region_new_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_REGION_DEL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_region_del,
+		.doit = devlink_nl_region_del_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_REGION_READ,
 		.validate = GENL_DONT_VALIDATE_STRICT |
 			    GENL_DONT_VALIDATE_DUMP_STRICT,
-		.dumpit = devlink_nl_cmd_region_read_dumpit,
+		.dumpit = devlink_nl_region_read_dumpit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_set_doit,
+		.doit = devlink_nl_health_reporter_set_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_RECOVER,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_recover_doit,
+		.doit = devlink_nl_health_reporter_recover_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_diagnose_doit,
+		.doit = devlink_nl_health_reporter_diagnose_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
 	},
@@ -492,47 +492,47 @@ static const struct genl_small_ops devlink_nl_small_ops[40] = {
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT |
 			    GENL_DONT_VALIDATE_DUMP_STRICT,
-		.dumpit = devlink_nl_cmd_health_reporter_dump_get_dumpit,
+		.dumpit = devlink_nl_health_reporter_dump_get_dumpit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_dump_clear_doit,
+		.doit = devlink_nl_health_reporter_dump_clear_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_TEST,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_test_doit,
+		.doit = devlink_nl_health_reporter_test_doit,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
 	},
 	{
 		.cmd = DEVLINK_CMD_FLASH_UPDATE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_flash_update,
+		.doit = devlink_nl_flash_update_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_SET,
-		.doit = devlink_nl_cmd_trap_set_doit,
+		.doit = devlink_nl_trap_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_GROUP_SET,
-		.doit = devlink_nl_cmd_trap_group_set_doit,
+		.doit = devlink_nl_trap_group_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_POLICER_SET,
-		.doit = devlink_nl_cmd_trap_policer_set_doit,
+		.doit = devlink_nl_trap_policer_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = DEVLINK_CMD_SELFTESTS_RUN,
-		.doit = devlink_nl_cmd_selftests_run,
+		.doit = devlink_nl_selftests_run_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	/* -- No new ops here! Use split ops going forward! -- */
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 31275f9d4cb7..d74df09311a9 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -581,7 +581,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 	return 0;
 }
 
-int devlink_nl_cmd_param_set_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 
@@ -589,22 +589,22 @@ int devlink_nl_cmd_param_set_doit(struct sk_buff *skb, struct genl_info *info)
 					       info, DEVLINK_CMD_PARAM_NEW);
 }
 
-int devlink_nl_cmd_port_param_get_dumpit(struct sk_buff *msg,
-					 struct netlink_callback *cb)
+int devlink_nl_port_param_get_dumpit(struct sk_buff *msg,
+				     struct netlink_callback *cb)
 {
 	NL_SET_ERR_MSG(cb->extack, "Port params are not supported");
 	return msg->len;
 }
 
-int devlink_nl_cmd_port_param_get_doit(struct sk_buff *skb,
-				       struct genl_info *info)
+int devlink_nl_port_param_get_doit(struct sk_buff *skb,
+				   struct genl_info *info)
 {
 	NL_SET_ERR_MSG(info->extack, "Port params are not supported");
 	return -EINVAL;
 }
 
-int devlink_nl_cmd_port_param_set_doit(struct sk_buff *skb,
-				       struct genl_info *info)
+int devlink_nl_port_param_set_doit(struct sk_buff *skb,
+				   struct genl_info *info)
 {
 	NL_SET_ERR_MSG(info->extack, "Port params are not supported");
 	return -EINVAL;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 4e9003242448..7634f187fa50 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -772,7 +772,7 @@ static int devlink_port_function_set(struct devlink_port *port,
 	return err;
 }
 
-int devlink_nl_cmd_port_set_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_port_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	int err;
@@ -798,7 +798,7 @@ int devlink_nl_cmd_port_set_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-int devlink_nl_cmd_port_split_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_port_split_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = info->user_ptr[0];
@@ -829,8 +829,7 @@ int devlink_nl_cmd_port_split_doit(struct sk_buff *skb, struct genl_info *info)
 					     info->extack);
 }
 
-int devlink_nl_cmd_port_unsplit_doit(struct sk_buff *skb,
-				     struct genl_info *info)
+int devlink_nl_port_unsplit_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = info->user_ptr[0];
@@ -840,7 +839,7 @@ int devlink_nl_cmd_port_unsplit_doit(struct sk_buff *skb,
 	return devlink_port->ops->port_unsplit(devlink, devlink_port, info->extack);
 }
 
-int devlink_nl_cmd_port_new_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink_port_new_attrs new_attrs = {};
@@ -904,7 +903,7 @@ int devlink_nl_cmd_port_new_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int devlink_nl_cmd_port_del_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_port_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct netlink_ext_ack *extack = info->extack;
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index dff1593b8406..94b289b93ff2 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -458,7 +458,7 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 	return true;
 }
 
-int devlink_nl_cmd_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_rate *devlink_rate;
@@ -480,7 +480,7 @@ int devlink_nl_cmd_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int devlink_nl_cmd_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_rate *rate_node;
@@ -536,7 +536,7 @@ int devlink_nl_cmd_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int devlink_nl_cmd_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_rate *rate_node;
diff --git a/net/devlink/region.c b/net/devlink/region.c
index d197cdb662db..0aab7b82d678 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -588,7 +588,7 @@ int devlink_nl_region_get_dumpit(struct sk_buff *skb,
 	return devlink_nl_dumpit(skb, cb, devlink_nl_region_get_dump_one);
 }
 
-int devlink_nl_cmd_region_del(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_region_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_snapshot *snapshot;
@@ -633,7 +633,7 @@ int devlink_nl_cmd_region_del(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-int devlink_nl_cmd_region_new(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_region_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_snapshot *snapshot;
@@ -863,8 +863,8 @@ devlink_region_direct_fill(void *cb_priv, u8 *chunk, u32 chunk_size,
 				 curr_offset, chunk_size, chunk);
 }
 
-int devlink_nl_cmd_region_read_dumpit(struct sk_buff *skb,
-				      struct netlink_callback *cb)
+int devlink_nl_region_read_dumpit(struct sk_buff *skb,
+				  struct netlink_callback *cb)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index c8b615e4c385..594c8aeb3bfa 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -105,7 +105,7 @@ devlink_resource_validate_size(struct devlink_resource *resource, u64 size,
 	return err;
 }
 
-int devlink_nl_cmd_resource_set(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_resource *resource;
@@ -285,7 +285,7 @@ static int devlink_resource_fill(struct genl_info *info,
 	return err;
 }
 
-int devlink_nl_cmd_resource_dump(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 
diff --git a/net/devlink/sb.c b/net/devlink/sb.c
index bd677fff5ec8..0a76bb32502b 100644
--- a/net/devlink/sb.c
+++ b/net/devlink/sb.c
@@ -413,7 +413,7 @@ static int devlink_sb_pool_set(struct devlink *devlink, unsigned int sb_index,
 	return -EOPNOTSUPP;
 }
 
-int devlink_nl_cmd_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	enum devlink_sb_threshold_type threshold_type;
@@ -621,8 +621,8 @@ static int devlink_sb_port_pool_set(struct devlink_port *devlink_port,
 	return -EOPNOTSUPP;
 }
 
-int devlink_nl_cmd_sb_port_pool_set_doit(struct sk_buff *skb,
-					 struct genl_info *info)
+int devlink_nl_sb_port_pool_set_doit(struct sk_buff *skb,
+				     struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = info->user_ptr[0];
@@ -861,8 +861,8 @@ static int devlink_sb_tc_pool_bind_set(struct devlink_port *devlink_port,
 	return -EOPNOTSUPP;
 }
 
-int devlink_nl_cmd_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
-					    struct genl_info *info)
+int devlink_nl_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
+					struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = info->user_ptr[0];
@@ -900,8 +900,7 @@ int devlink_nl_cmd_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
 					   pool_index, threshold, info->extack);
 }
 
-int devlink_nl_cmd_sb_occ_snapshot_doit(struct sk_buff *skb,
-					struct genl_info *info)
+int devlink_nl_sb_occ_snapshot_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	const struct devlink_ops *ops = devlink->ops;
@@ -916,8 +915,8 @@ int devlink_nl_cmd_sb_occ_snapshot_doit(struct sk_buff *skb,
 	return -EOPNOTSUPP;
 }
 
-int devlink_nl_cmd_sb_occ_max_clear_doit(struct sk_buff *skb,
-					 struct genl_info *info)
+int devlink_nl_sb_occ_max_clear_doit(struct sk_buff *skb,
+				     struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	const struct devlink_ops *ops = devlink->ops;
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index c26bf9b29bca..c26313e7ca08 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -414,7 +414,7 @@ static int devlink_trap_action_set(struct devlink *devlink,
 					 info->extack);
 }
 
-int devlink_nl_cmd_trap_set_doit(struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_trap_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink *devlink = info->user_ptr[0];
@@ -684,8 +684,7 @@ static int devlink_trap_group_set(struct devlink *devlink,
 	return 0;
 }
 
-int devlink_nl_cmd_trap_group_set_doit(struct sk_buff *skb,
-				       struct genl_info *info)
+int devlink_nl_trap_group_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink *devlink = info->user_ptr[0];
@@ -926,8 +925,8 @@ devlink_trap_policer_set(struct devlink *devlink,
 	return 0;
 }
 
-int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
-					 struct genl_info *info)
+int devlink_nl_trap_policer_set_doit(struct sk_buff *skb,
+				     struct genl_info *info)
 {
 	struct devlink_trap_policer_item *policer_item;
 	struct netlink_ext_ack *extack = info->extack;
-- 
2.41.0


