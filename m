Return-Path: <netdev+bounces-30998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C2C78A5B5
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED23280DAF
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110376AD7;
	Mon, 28 Aug 2023 06:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341BEEDF
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:17:49 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F3131
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313e742a787so1713923f8f.1
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693203444; x=1693808244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqNWuxo68jYgBpf79Bc3c/Gn8vBAj1yPz9W5PW5VsHg=;
        b=PV/YaMI06ikdtigmruHBRIIIKZCWxHgv6XQ5tWVJtKLHrwyjFjnhRes6ARZALKWE6x
         ZQy0+9Z9DCBEqfGvta5/iFcpahpG+lOCpq7sYmVNS5jUpPZK7R12nRvx1MdPI7IFt2Op
         wk2lQtDHKl6A26fApWx/VjRUa2k24ZlO4ZYHy8X5uyII35XESkLMhc+U8FED8f4tM2gZ
         rpsqtD6ETiypB72zAqXhBJ1xD8ZoChxzuG8dp4dwwr8ED1N71btijJkBwXF9UXfXiJfj
         iK0kVmjr5MOKqU0OmU5f7mPCcHpzPXsGwrzS2th1vCyEJhi9Co11bpW50rj3pxCniK2e
         Vngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203444; x=1693808244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqNWuxo68jYgBpf79Bc3c/Gn8vBAj1yPz9W5PW5VsHg=;
        b=dxvab4XzQaBccxbHBbgElvBJdiUvPXKg6dFPx/a/gOUXuSQm1LFLQxOE9aq8kbALZb
         koInNlpSIavn4/B5er4fkqfFJdEmrlk50cCfbGRFhTiuI+Rk1SxvZ6vOdJfkLtMtsYLC
         5N3gNSLNX7dmbENXmcHV7UTYEZkp4k/Vuzdt2U1YzuRnc2pWzuzfvtdDQ9Ut7i2ce1LQ
         Eumi/KqmXm2qFNIO7ggKOsimtr/JL9xEEb1nxRfDTQhg3Fo8/nUW0yvznZFUi7xmjulu
         BOq5T0HlHtqiS6h5JF4WC0TmXNXnDmVnPIW0m/NljQZFD/iI41Aq7DaERNKvIrd7xwcT
         GcrA==
X-Gm-Message-State: AOJu0Yxb8WVGHCRX/tj4HO6nB5nsUzFI3QtLn4IAxrydENV42zT9u0js
	kV/eVE/B0zLIhKyS3kgdtlepEeynV7gMIXVPIS1DrQ==
X-Google-Smtp-Source: AGHT+IGkMP/m0EWso+4lfaCgTcJ8oJJ0O/ycliogwNV3kLGDgaeKNxVuC+ufPQEM/x6hqPaDSzvfTg==
X-Received: by 2002:a5d:63c2:0:b0:314:3369:df57 with SMTP id c2-20020a5d63c2000000b003143369df57mr19413535wrw.5.1693203444452;
        Sun, 27 Aug 2023 23:17:24 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l12-20020a7bc44c000000b003fbc0a49b57sm9700275wmi.6.2023.08.27.23.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:17:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next v2 14/15] devlink: move small_ops definition into netlink.c
Date: Mon, 28 Aug 2023 08:16:56 +0200
Message-ID: <20230828061657.300667-15-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Move the generic netlink small_ops definition where they are consumed,
into netlink.c

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |   2 -
 net/devlink/leftover.c      | 251 ------------------------------------
 net/devlink/netlink.c       | 251 ++++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 253 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 8c81f731a4c7..efca6abf7af7 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -121,8 +121,6 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 				       struct netlink_callback *cb,
 				       int flags);
 
-extern const struct genl_small_ops devlink_nl_small_ops[40];
-
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
 
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index a477cdbab940..05e056d6d5ea 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -31,257 +31,6 @@
 
 #include "devl_internal.h"
 
-const struct genl_small_ops devlink_nl_small_ops[40] = {
-	{
-		.cmd = DEVLINK_CMD_PORT_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_RATE_SET,
-		.doit = devlink_nl_cmd_rate_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RATE_NEW,
-		.doit = devlink_nl_cmd_rate_new_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RATE_DEL,
-		.doit = devlink_nl_cmd_rate_del_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_SPLIT,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_split_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_UNSPLIT,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_unsplit_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_NEW,
-		.doit = devlink_nl_cmd_port_new_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_DEL,
-		.doit = devlink_nl_cmd_port_del_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-
-	{
-		.cmd = DEVLINK_CMD_LINECARD_SET,
-		.doit = devlink_nl_cmd_linecard_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_POOL_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_pool_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_PORT_POOL_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_port_pool_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_tc_pool_bind_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_OCC_SNAPSHOT,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_occ_snapshot_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_OCC_MAX_CLEAR,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_occ_max_clear_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_ESWITCH_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_eswitch_get_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_ESWITCH_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_eswitch_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_TABLE_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_table_get,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_ENTRIES_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_entries_get,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_HEADERS_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_headers_get,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_table_counters_set,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RESOURCE_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_resource_set,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RESOURCE_DUMP,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_resource_dump,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_RELOAD,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_reload,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PARAM_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_param_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_PARAM_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_param_get_doit,
-		.dumpit = devlink_nl_cmd_port_param_get_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_PARAM_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_param_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_REGION_NEW,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_region_new,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_REGION_DEL,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_region_del,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_REGION_READ,
-		.validate = GENL_DONT_VALIDATE_STRICT |
-			    GENL_DONT_VALIDATE_DUMP_STRICT,
-		.dumpit = devlink_nl_cmd_region_read_dumpit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_RECOVER,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_recover_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_diagnose_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT |
-			    GENL_DONT_VALIDATE_DUMP_STRICT,
-		.dumpit = devlink_nl_cmd_health_reporter_dump_get_dumpit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_dump_clear_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_TEST,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_test_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_FLASH_UPDATE,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_flash_update,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_SET,
-		.doit = devlink_nl_cmd_trap_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_GROUP_SET,
-		.doit = devlink_nl_cmd_trap_group_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_POLICER_SET,
-		.doit = devlink_nl_cmd_trap_policer_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SELFTESTS_RUN,
-		.doit = devlink_nl_cmd_selftests_run,
-		.flags = GENL_ADMIN_PERM,
-	},
-	/* -- No new ops here! Use split ops going forward! -- */
-};
-
 void devlink_notify_register(struct devlink *devlink)
 {
 	devlink_notify(devlink, DEVLINK_CMD_NEW);
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 5f57afd31dea..fc3e7c029a3b 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -255,6 +255,257 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		return devlink_nl_inst_iter_dumpit(msg, cb, flags, dump_one);
 }
 
+static const struct genl_small_ops devlink_nl_small_ops[40] = {
+	{
+		.cmd = DEVLINK_CMD_PORT_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_RATE_SET,
+		.doit = devlink_nl_cmd_rate_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_RATE_NEW,
+		.doit = devlink_nl_cmd_rate_new_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_RATE_DEL,
+		.doit = devlink_nl_cmd_rate_del_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_SPLIT,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_split_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_UNSPLIT,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_unsplit_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_NEW,
+		.doit = devlink_nl_cmd_port_new_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_DEL,
+		.doit = devlink_nl_cmd_port_del_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+
+	{
+		.cmd = DEVLINK_CMD_LINECARD_SET,
+		.doit = devlink_nl_cmd_linecard_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_POOL_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_pool_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_PORT_POOL_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_port_pool_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_tc_pool_bind_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_OCC_SNAPSHOT,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_occ_snapshot_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_OCC_MAX_CLEAR,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_occ_max_clear_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_ESWITCH_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_eswitch_get_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_ESWITCH_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_eswitch_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_DPIPE_TABLE_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_dpipe_table_get,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_DPIPE_ENTRIES_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_dpipe_entries_get,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_DPIPE_HEADERS_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_dpipe_headers_get,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_dpipe_table_counters_set,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_RESOURCE_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_resource_set,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_RESOURCE_DUMP,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_resource_dump,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_RELOAD,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_reload,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_PARAM_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_param_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_PARAM_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_param_get_doit,
+		.dumpit = devlink_nl_cmd_port_param_get_dumpit,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_PARAM_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_param_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_REGION_NEW,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_region_new,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_REGION_DEL,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_region_del,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_REGION_READ,
+		.validate = GENL_DONT_VALIDATE_STRICT |
+			    GENL_DONT_VALIDATE_DUMP_STRICT,
+		.dumpit = devlink_nl_cmd_region_read_dumpit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_RECOVER,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_recover_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_diagnose_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT |
+			    GENL_DONT_VALIDATE_DUMP_STRICT,
+		.dumpit = devlink_nl_cmd_health_reporter_dump_get_dumpit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_dump_clear_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_TEST,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_test_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_FLASH_UPDATE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_flash_update,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_TRAP_SET,
+		.doit = devlink_nl_cmd_trap_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_TRAP_GROUP_SET,
+		.doit = devlink_nl_cmd_trap_group_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_TRAP_POLICER_SET,
+		.doit = devlink_nl_cmd_trap_policer_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_SELFTESTS_RUN,
+		.doit = devlink_nl_cmd_selftests_run,
+		.flags = GENL_ADMIN_PERM,
+	},
+	/* -- No new ops here! Use split ops going forward! -- */
+};
+
 struct genl_family devlink_nl_family __ro_after_init = {
 	.name		= DEVLINK_GENL_NAME,
 	.version	= DEVLINK_GENL_VERSION,
-- 
2.41.0


