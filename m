Return-Path: <netdev+bounces-23985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3622D76E693
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF33D282080
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D861EA9B;
	Thu,  3 Aug 2023 11:13:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726B1DDFD
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:55 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413C7EA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bcc0adab4so120170366b.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061232; x=1691666032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHLqQEQLXBodpfNSH6Ik79GTCpp9uGMnhYBHyud7ZOQ=;
        b=mlCIHzRmwWREFp0j50lsBkZNUwF3XeLRfZzviOjffRnSEpaYW3zPBqSDTPoCQQZPEc
         jwsXJq3yUad9MWA9L4hst3XMDTz4lj/hWE5kbRf0yr1oCWXCm1sHBGkPEiL/lr7odzqB
         ssUlJ1C4QmsMWSRwaNoG2UwUYkQL4UiYwLHHnbXImRRrd9SvAHnXkr5l58s9McZ+4NNE
         d5YEjjZAnl8/BAvgxZqeVR+K45ptZraZa9Y7wML6XAu0B4pclPCn9H7WQfiGKJS76s4L
         VZQUnGsr9bDO1RHHZIc8mi8OagMztMmK9BfBBtuMiazPnhOkzdyUTKR+k06HluVfPTbk
         3uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061232; x=1691666032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHLqQEQLXBodpfNSH6Ik79GTCpp9uGMnhYBHyud7ZOQ=;
        b=Q5m/WrMJ3oQEiNGDW6XGYkaA6NPYCgiFqYpdh0Y879W5w2sTWCE2LAsljM0kUk+Tbw
         6RZrk1g52DxFioNH4C85/LTeF7pUD9rjStg8DobawMvydAJ16jVnJ0/TcPHn22Dsewu+
         JUn8mORh7ubGPRi/ys7gxm6WFkHv5FNiLMEE36z/xz4cYB4qoeRQBZGupv1jXS37OEi0
         UGFSCbK2OxqUk7tB8e64pUx90PV84rYcVvNIjzoLM/DMPj1QiF2TxOpCuVpgFA/OE+6P
         Fyj++huv34GvO4Gs7Jkeh7PG9FB1zssUCVkkjTTsh+ftkNpg3De243ob3dF8q9HOIj9m
         DQgg==
X-Gm-Message-State: ABy/qLZLYORGzVuTi733Vk601gKPoNFn8hD6eeRnqIhBnXqE4rSPDana
	OoqNmiXZqrMLhzQJqgnYguxwGc2eCngh0ssQTck0wA==
X-Google-Smtp-Source: APBJJlFR+4my0+7nSk/Pl/PO/lTumares0Evk0zWXb7aDSYeiYc9ELdrSfmxS65qd275SgB1Q58eYQ==
X-Received: by 2002:a17:906:c1:b0:99b:f554:1f10 with SMTP id 1-20020a17090600c100b0099bf5541f10mr6814567eji.7.1691061232751;
        Thu, 03 Aug 2023 04:13:52 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709062b4e00b0099bd7b26639sm10393913ejg.6.2023.08.03.04.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:52 -0700 (PDT)
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
Subject: [patch net-next v3 07/12] devlink: introduce couple of dumpit callbacks for split ops
Date: Thu,  3 Aug 2023 13:13:35 +0200
Message-ID: <20230803111340.1074067-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803111340.1074067-1-jiri@resnulli.us>
References: <20230803111340.1074067-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Introduce couple of dumpit callbacks for generated split ops. Have them
as a thin wrapper around iteration function and allow to pass dump_one()
function pointer directly without need to store in devlink_cmd structs.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- fixed double empty line issue
- added temporary prototypes to devl_internal.h
- moved the patch before "devlink: add split ops generated according to
  spec" in order to fix the build breakage
v1->v2:
- fixed typo in patch subject
---
 net/devlink/dev.c           | 22 ++++++++++++----------
 net/devlink/devl_internal.h | 17 +++++++++++------
 net/devlink/leftover.c      |  4 ++--
 net/devlink/netlink.c       | 21 ++++++++++++---------
 4 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 2e120b3da220..5dfba2248b90 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -217,17 +217,18 @@ int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-devlink_nl_cmd_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			    struct netlink_callback *cb)
+devlink_nl_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+			struct netlink_callback *cb)
 {
 	return devlink_nl_fill(msg, devlink, DEVLINK_CMD_NEW,
 			       NETLINK_CB(cb->skb).portid,
 			       cb->nlh->nlmsg_seq, NLM_F_MULTI);
 }
 
-const struct devlink_cmd devl_cmd_get = {
-	.dump_one		= devlink_nl_cmd_get_dump_one,
-};
+int devlink_nl_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(msg, cb, devlink_nl_get_dump_one);
+}
 
 static void devlink_reload_failed_set(struct devlink *devlink,
 				      bool reload_failed)
@@ -826,8 +827,8 @@ int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-devlink_nl_cmd_info_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				 struct netlink_callback *cb)
+devlink_nl_info_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+			     struct netlink_callback *cb)
 {
 	int err;
 
@@ -840,9 +841,10 @@ devlink_nl_cmd_info_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_info_get = {
-	.dump_one		= devlink_nl_cmd_info_get_dump_one,
-};
+int devlink_nl_info_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(msg, cb, devlink_nl_info_get_dump_one);
+}
 
 static int devlink_nl_flash_update_fill(struct sk_buff *msg,
 					struct devlink *devlink,
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index d32a32705430..7d0a9dd1aceb 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -114,9 +114,12 @@ struct devlink_nl_dump_state {
 	};
 };
 
+typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
+				       struct devlink *devlink,
+				       struct netlink_callback *cb);
+
 struct devlink_cmd {
-	int (*dump_one)(struct sk_buff *msg, struct devlink *devlink,
-			struct netlink_callback *cb);
+	devlink_nl_dump_one_func_t *dump_one;
 };
 
 extern const struct genl_small_ops devlink_nl_small_ops[56];
@@ -127,8 +130,9 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
 void devlink_notify_unregister(struct devlink *devlink);
 void devlink_notify_register(struct devlink *devlink);
 
-int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
-				    struct netlink_callback *cb);
+int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
+		      devlink_nl_dump_one_func_t *dump_one);
+int devlink_nl_instance_iter_dumpit(struct sk_buff *msg, struct netlink_callback *cb);
 
 static inline struct devlink_nl_dump_state *
 devlink_dump_state(struct netlink_callback *cb)
@@ -149,7 +153,6 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 }
 
 /* Commands */
-extern const struct devlink_cmd devl_cmd_get;
 extern const struct devlink_cmd devl_cmd_port_get;
 extern const struct devlink_cmd devl_cmd_sb_get;
 extern const struct devlink_cmd devl_cmd_sb_pool_get;
@@ -157,7 +160,6 @@ extern const struct devlink_cmd devl_cmd_sb_port_pool_get;
 extern const struct devlink_cmd devl_cmd_sb_tc_pool_bind_get;
 extern const struct devlink_cmd devl_cmd_param_get;
 extern const struct devlink_cmd devl_cmd_region_get;
-extern const struct devlink_cmd devl_cmd_info_get;
 extern const struct devlink_cmd devl_cmd_health_reporter_get;
 extern const struct devlink_cmd devl_cmd_trap_get;
 extern const struct devlink_cmd devl_cmd_trap_group_get;
@@ -215,10 +217,13 @@ devlink_rate_node_get_from_info(struct devlink *devlink,
 				struct genl_info *info);
 /* Devlink nl cmds */
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_info_get_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb);
 int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 094cd0e8224e..895b732bed8e 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6283,7 +6283,7 @@ const struct genl_small_ops devlink_nl_small_ops[56] = {
 		.cmd = DEVLINK_CMD_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
@@ -6537,7 +6537,7 @@ const struct genl_small_ops devlink_nl_small_ops[56] = {
 		.cmd = DEVLINK_CMD_INFO_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_info_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_info_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 82a3238d5344..624d0db7e229 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -178,7 +178,6 @@ static void devlink_nl_post_doit(const struct genl_split_ops *ops,
 }
 
 static const struct devlink_cmd *devl_cmds[] = {
-	[DEVLINK_CMD_GET]		= &devl_cmd_get,
 	[DEVLINK_CMD_PORT_GET]		= &devl_cmd_port_get,
 	[DEVLINK_CMD_SB_GET]		= &devl_cmd_sb_get,
 	[DEVLINK_CMD_SB_POOL_GET]	= &devl_cmd_sb_pool_get,
@@ -186,7 +185,6 @@ static const struct devlink_cmd *devl_cmds[] = {
 	[DEVLINK_CMD_SB_TC_POOL_BIND_GET] = &devl_cmd_sb_tc_pool_bind_get,
 	[DEVLINK_CMD_PARAM_GET]		= &devl_cmd_param_get,
 	[DEVLINK_CMD_REGION_GET]	= &devl_cmd_region_get,
-	[DEVLINK_CMD_INFO_GET]		= &devl_cmd_info_get,
 	[DEVLINK_CMD_HEALTH_REPORTER_GET] = &devl_cmd_health_reporter_get,
 	[DEVLINK_CMD_TRAP_GET]		= &devl_cmd_trap_get,
 	[DEVLINK_CMD_TRAP_GROUP_GET]	= &devl_cmd_trap_group_get,
@@ -196,23 +194,19 @@ static const struct devlink_cmd *devl_cmds[] = {
 	[DEVLINK_CMD_SELFTESTS_GET]	= &devl_cmd_selftests_get,
 };
 
-int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
-				    struct netlink_callback *cb)
+int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
+		      devlink_nl_dump_one_func_t *dump_one)
 {
-	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	const struct devlink_cmd *cmd;
 	struct devlink *devlink;
 	int err = 0;
 
-	cmd = devl_cmds[info->op.cmd];
-
 	while ((devlink = devlinks_xa_find_get(sock_net(msg->sk),
 					       &state->instance))) {
 		devl_lock(devlink);
 
 		if (devl_is_registered(devlink))
-			err = cmd->dump_one(msg, devlink, cb);
+			err = dump_one(msg, devlink, cb);
 		else
 			err = 0;
 
@@ -233,6 +227,15 @@ int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
+				    struct netlink_callback *cb)
+{
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	const struct devlink_cmd *cmd = devl_cmds[info->op.cmd];
+
+	return devlink_nl_dumpit(msg, cb, cmd->dump_one);
+}
+
 struct genl_family devlink_nl_family __ro_after_init = {
 	.name		= DEVLINK_GENL_NAME,
 	.version	= DEVLINK_GENL_VERSION,
-- 
2.41.0


