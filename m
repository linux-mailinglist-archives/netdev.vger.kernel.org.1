Return-Path: <netdev+bounces-26353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3F77796B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA01C214B1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240AD200D2;
	Thu, 10 Aug 2023 13:16:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE6200CA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:16:00 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3CD10E9
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso7704925e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673357; x=1692278157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQDuGOkAjJPOER/22K/WlHSttoL0hpj7V6Oed+7zG/I=;
        b=4reeL/zToeimqd33ijQlxOoPZHeYvLwt7JB3aanRlY5TvnZnfewHWyCRoB9uvx6Fan
         raMlbPk3eF0enbu71YpVStIhyn1MuRoMR1sd3v8MDa6vRKCcPFjFvSdrabE8aQNXblCH
         x4BeBqBvjqMN5u6Sb4AE6mZYMSRh9hBJRQTH+P5Ae+Ancsn5C4cHwredfXj8fisYehhx
         DVSb9YEFGkt+rE1V8aYt4YUE2Jlj4XgC6mmGFZ8IVFdfdJJTaZRuyEAMrbTWJhw+mhqt
         wfgCadD5WIrVVKaNIuNauG5fvFSJUY/2xwUhYY+4Mz3NI5fvmX+Ur66R6I7OkQ5pkrJR
         9aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673357; x=1692278157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQDuGOkAjJPOER/22K/WlHSttoL0hpj7V6Oed+7zG/I=;
        b=dM1AHPx7owkOqcGgrws5s0GenQKDAWZbTi06wiG4loiMiTnvM1uhP73EyReAAEMvZg
         wwK2En/1TokrbVavbsyP/VGVFF4J0rybrfsriAc0aWUkFcu1KKkZd/1yE8MiRALbdnkQ
         IRm1hHMX6UpbJ16OqSdQXdgZFbE5POW87Se2ma807CBbpCPVDPxLzbZf/yillsrFJykE
         4tFsEjFODFxOTcYPhP6Jyuq6+GzdWnBzZ2IDS0YQSlV+2Z44OmknX0lGmaDgZ/aZgNft
         A+fDPb0hrJUZmmXsrbKILK42XBtKGGv3110RjpPrbxmeHhtEc2k1ce425/HMcXT0og0v
         aydw==
X-Gm-Message-State: AOJu0YyM/XzJJZnVmFsp/G7C4qC1LqpCzKuesKkBOKzsj/U7MBDbeXrt
	pghlBGoEOKApbLrM+YfSU9uw8ZdhQ4ETRflXSbKwPA==
X-Google-Smtp-Source: AGHT+IFX8ZlgGqnktdOu/xJhmLHhXHIGVLie38vvmhoFGvSLj+L6sle7gefvhI8Npt/dkh/Y4ABTbQ==
X-Received: by 2002:a7b:cb0e:0:b0:3fd:1daf:abd8 with SMTP id u14-20020a7bcb0e000000b003fd1dafabd8mr1694906wmj.40.1691673357305;
        Thu, 10 Aug 2023 06:15:57 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c378d00b003fe2de3f94fsm2127177wmr.12.2023.08.10.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:15:56 -0700 (PDT)
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
Subject: [patch net-next v3 09/13] devlink: remove converted commands from small ops
Date: Thu, 10 Aug 2023 15:15:35 +0200
Message-ID: <20230810131539.1602299-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810131539.1602299-1-jiri@resnulli.us>
References: <20230810131539.1602299-1-jiri@resnulli.us>
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

As the commands are already defined in split ops, remove them
from small ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/devl_internal.h |  2 +-
 net/devlink/leftover.c      | 99 +------------------------------------
 2 files changed, 3 insertions(+), 98 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7caa385703de..eb1d5066c73f 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -118,7 +118,7 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 				       struct netlink_callback *cb,
 				       int flags);
 
-extern const struct genl_small_ops devlink_nl_small_ops[54];
+extern const struct genl_small_ops devlink_nl_small_ops[40];
 
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 883c65545d26..3883a90d32bb 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6307,15 +6307,7 @@ static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 	return devlink_trap_policer_set(devlink, policer_item, info);
 }
 
-const struct genl_small_ops devlink_nl_small_ops[54] = {
-	{
-		.cmd = DEVLINK_CMD_PORT_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_port_get_doit,
-		.dumpit = devlink_nl_port_get_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-		/* can be retrieved by unprivileged users */
-	},
+const struct genl_small_ops devlink_nl_small_ops[40] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6323,12 +6315,6 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
-	{
-		.cmd = DEVLINK_CMD_RATE_GET,
-		.doit = devlink_nl_rate_get_doit,
-		.dumpit = devlink_nl_rate_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_RATE_SET,
 		.doit = devlink_nl_cmd_rate_set_doit,
@@ -6369,45 +6355,18 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
-	{
-		.cmd = DEVLINK_CMD_LINECARD_GET,
-		.doit = devlink_nl_linecard_get_doit,
-		.dumpit = devlink_nl_linecard_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
+
 	{
 		.cmd = DEVLINK_CMD_LINECARD_SET,
 		.doit = devlink_nl_cmd_linecard_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_SB_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_sb_get_doit,
-		.dumpit = devlink_nl_sb_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_POOL_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_sb_pool_get_doit,
-		.dumpit = devlink_nl_sb_pool_get_dumpit,
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
-		.doit = devlink_nl_sb_port_pool_get_doit,
-		.dumpit = devlink_nl_sb_port_pool_get_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_SB_PORT_POOL_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6415,14 +6374,6 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
-	{
-		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_sb_tc_pool_bind_get_doit,
-		.dumpit = devlink_nl_sb_tc_pool_bind_get_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6496,13 +6447,6 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.doit = devlink_nl_cmd_reload,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_PARAM_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_param_get_doit,
-		.dumpit = devlink_nl_param_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_PARAM_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6524,13 +6468,6 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 	},
-	{
-		.cmd = DEVLINK_CMD_REGION_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_region_get_doit,
-		.dumpit = devlink_nl_region_get_dumpit,
-		.flags = GENL_ADMIN_PERM,
-	},
 	{
 		.cmd = DEVLINK_CMD_REGION_NEW,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6550,14 +6487,6 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.dumpit = devlink_nl_cmd_region_read_dumpit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_health_reporter_get_doit,
-		.dumpit = devlink_nl_health_reporter_get_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6606,45 +6535,21 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.doit = devlink_nl_cmd_flash_update,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_GET,
-		.doit = devlink_nl_trap_get_doit,
-		.dumpit = devlink_nl_trap_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_SET,
 		.doit = devlink_nl_cmd_trap_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_GROUP_GET,
-		.doit = devlink_nl_trap_group_get_doit,
-		.dumpit = devlink_nl_trap_group_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_GROUP_SET,
 		.doit = devlink_nl_cmd_trap_group_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_POLICER_GET,
-		.doit = devlink_nl_trap_policer_get_doit,
-		.dumpit = devlink_nl_trap_policer_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_POLICER_SET,
 		.doit = devlink_nl_cmd_trap_policer_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_SELFTESTS_GET,
-		.doit = devlink_nl_selftests_get_doit,
-		.dumpit = devlink_nl_selftests_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_SELFTESTS_RUN,
 		.doit = devlink_nl_cmd_selftests_run,
-- 
2.41.0


