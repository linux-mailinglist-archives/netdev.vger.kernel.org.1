Return-Path: <netdev+bounces-26860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA47793AD
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89D32811D4
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96C32AB50;
	Fri, 11 Aug 2023 15:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D95692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:35 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B842723
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3110ab7110aso1925797f8f.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769453; x=1692374253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQDuGOkAjJPOER/22K/WlHSttoL0hpj7V6Oed+7zG/I=;
        b=iFysRuOZZg9Q5TpydEjbKZ9hjRzI6kEtnePGPMU4JzQge+Jc4zPvqG3hdDrlJBBkSR
         oT/eWQFL2M8XUtyROkPpnKA8lXYAP9m+AgvgPayRqHC3yn4NcU2uqM28t8aUXzx2RV6p
         lGwsD3KPIF17Lc+Sw3ZQ7ciiIZoSrLXi6NR9HBfJYu+HElXl/FfqWr1HoecjELsiI8ZG
         zJAWfa5VEV+H8d5laEvTJ62eCkcKcK5o/U70VxJvGBV9u8f+vUzo/Q2GZJUIHRPThQEJ
         Wkf6AQ5eshkh2qJ1wFNDcda3inQ9KfxnWfEScZIyXjTG2vT7o+Y+b5aBN85L17lISxD4
         KZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769453; x=1692374253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQDuGOkAjJPOER/22K/WlHSttoL0hpj7V6Oed+7zG/I=;
        b=dUaPTaAhHbKjaDqe4pCTNrxDyQ45mxtJ4XgAOUdkJZL8MwoO7H0234N6IUWMSnXim7
         GwRcsszy0K1BvvRuVe8tXpHid2GEKZIllgxRiDnow0dqqSIBOHml2GIgiMqGUi2p/C42
         17V5MCcb0imXWSgF0AwpVk9JOaWNQt6NusYLxRHa3vgPJrsNNT7fC8oZsG3hksgY2Klk
         SW4thtsQn/PHgu1LcVey07vDCHjPdKSMqZNKWHKpXnhhsiikQXdRWvv8w0l7etsau7ug
         9u4bE5SAh0VAtOHfnbTZRcEepbS+fBLT+axWfHmWuSiuqnZwDMT6iJDs0izWfGesq/+E
         JxGw==
X-Gm-Message-State: AOJu0YzmtqMzXLbpLLumxRK1k5GixHARW5LcDGP8Rw3HMn5k/Ixm0LhZ
	W+XscxcD+7KtpDGjRMTzzTFK0smkxB7FZdkWRPkFjw==
X-Google-Smtp-Source: AGHT+IEQmLeFpsrDRk06SyZq4TFzB1J3K2v4ypqysYEFx4AWiK2xwVdrpN03DJ4Ak1L2X41bf1cm0Q==
X-Received: by 2002:adf:fe10:0:b0:317:73d3:441a with SMTP id n16-20020adffe10000000b0031773d3441amr1833566wrr.46.1691769452711;
        Fri, 11 Aug 2023 08:57:32 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm5808907wru.107.2023.08.11.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:32 -0700 (PDT)
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
Subject: [patch net-next v4 09/13] devlink: remove converted commands from small ops
Date: Fri, 11 Aug 2023 17:57:10 +0200
Message-ID: <20230811155714.1736405-10-jiri@resnulli.us>
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


