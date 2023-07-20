Return-Path: <netdev+bounces-19494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77CD75AE36
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93AB1C213FD
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C018B1D;
	Thu, 20 Jul 2023 12:18:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B318AE6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:49 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3801D2118
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so6133955e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855527; x=1690460327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPxToTyBRAptPJ35kaLzduS5meI3ZEBgPclW44Vycyk=;
        b=hGE3Cb6axyvxsCYd80XKyzxnymoezB9L3ebJSEfr7cwnTeK4O69aHFd/zsahlW0ldc
         yLLnsYNlatvpt4OIYazxzm+XdxHgHOAC3zlL8xgWBOrZ3EKVMYkRnQ58pc0wWD4Et8rs
         3kcQQPj5jT6SNMfEFqbZAEdyPFxitCOZFRWkFYoP1pPxfOlTOVSJy9ISgGtjxpssFM+W
         M039ERxTMQlCyyvuXAm32pjqHJbftIj2gbgg23OwwlxDhytc5eZ3/Az8U19JlKSVz7hI
         muUfKShr9ekp6U7iSUSvZX2GDOv18Ivzj3wouR3s9720zaWdL46bBkFaO54zZbR7wlSh
         E1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855527; x=1690460327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPxToTyBRAptPJ35kaLzduS5meI3ZEBgPclW44Vycyk=;
        b=l07ypgylegKyD2foTdPWgGbiAE5dPXygP6QgbdcAM++8IniS5ajB8kn3LgUcuSANXo
         qqllkYnaaOFyaIdFDH/9vX0nDS1gQRRdRgXIf1WCNkWEAFt7ZUXRlsY/A52/XP4cPFg2
         1jPjnePCuTTXS4tRKXJKph8hE2KVlKNk6jaT6nmjo8lw6ngU8ZEUt04UI/3O2xQHRUq/
         6VTxXzWarJMpgVQuIXaTaBo3IV8qCGLlk0Mz6KbueciX8QKi7+5aguuSqdh9ZM5/5EZ9
         QmqG5n9gbmdDw5MM8YpYgpw22/oqfEX8JGii7ls8GxSmLrJyCkRHppjc0rarhrjG/ThL
         LbQw==
X-Gm-Message-State: ABy/qLaen4AJZvoVafVmpk7IP+G4Jz/WPO5v7e3GjsUOJJTaQO8a+B0a
	kT/nemEkbqYxYKV5Eu8LjUCNTKdYSwIPAe4e0oM=
X-Google-Smtp-Source: APBJJlEKaMsIOXNYQdIIXdOsnw4w8ZmxIy38WTbEdVHcKgfpdGx85exAdP2+1RyvY6AxcupXrvkyWg==
X-Received: by 2002:a05:600c:3658:b0:3fb:b008:2003 with SMTP id y24-20020a05600c365800b003fbb0082003mr6888217wmq.38.1689855526785;
        Thu, 20 Jul 2023 05:18:46 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c378100b003fbd9e390e1sm3748391wmr.47.2023.07.20.05.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:46 -0700 (PDT)
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
Subject: [patch net-next v2 10/11] devlink: introduce dump selector attr and use it for per-instance dumps
Date: Thu, 20 Jul 2023 14:18:28 +0200
Message-ID: <20230720121829.566974-11-jiri@resnulli.us>
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

For SFs, one devlink instance per SF is created. There might be
thousands of these on a single host. When a user needs to know port
handle for specific SF, he needs to dump all devlink ports on the host
which does not scale good.

Allow user to pass devlink handle alongside the dump command
and dump only objects which are under selected devlink instance.

Introduce new attr DEVLINK_ATTR_DUMP_SELECTOR to nest the selection
attributes. This way the userspace can use maxattr to tell if dump
selector is supported by kernel or not.

Assemble netlink policy for selector attribute. If user passes attr
unknown to kernel, netlink validation errors out.

Example:
$ devlink port show
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

$ devlink port show auxiliary/mlx5_core.eth.0
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false

$ devlink port show auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- extended to patch that covers all dumpit commands
- used start() and done() callback to parse the selector attr
- changed the selector attr netlink policy to be created on fly
- changed patch description accordingly
---
 include/uapi/linux/devlink.h |  2 +
 net/devlink/devl_internal.h  |  1 +
 net/devlink/netlink.c        | 99 +++++++++++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 3782d4219ac9..8b74686512ae 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -612,6 +612,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_DUMP_SELECTOR,		/* nested */
+
 	/* add new attributes above here, update the policy in devlink.c */
 
 	__DEVLINK_ATTR_MAX,
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 79614b45e8ac..168d36dbc6f7 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -109,6 +109,7 @@ struct devlink_nl_dump_state {
 			u64 dump_ts;
 		};
 	};
+	struct nlattr **selector;
 };
 
 struct devlink_cmd {
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 90497d0e1a7b..c2083398bd73 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -80,6 +80,7 @@ static const struct nla_policy devlink_nl_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32 },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32 },
 	[DEVLINK_ATTR_REGION_DIRECT] = { .type = NLA_FLAG },
+	[DEVLINK_ATTR_DUMP_SELECTOR] = { .type = NLA_NESTED },
 };
 
 struct devlink *
@@ -195,6 +196,30 @@ static const struct devlink_cmd *devl_cmds[] = {
 	[DEVLINK_CMD_SELFTESTS_GET]	= &devl_cmd_selftests_get,
 };
 
+static int devlink_nl_instance_single_dumpit(struct sk_buff *msg,
+					     struct netlink_callback *cb)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct nlattr **selector = state->selector;
+	const struct devlink_cmd *cmd;
+	struct devlink *devlink;
+	int err;
+
+	cmd = devl_cmds[info->op.cmd];
+
+	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), selector);
+	if (IS_ERR(devlink))
+		return PTR_ERR(devlink);
+	err = cmd->dump_one(msg, devlink, cb);
+	devl_unlock(devlink);
+	devlink_put(devlink);
+
+	if (err != -EMSGSIZE)
+		return err;
+	return msg->len;
+}
+
 static int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 					   struct netlink_callback *cb)
 {
@@ -232,6 +257,76 @@ static int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+static void devlink_nl_policy_cpy(struct nla_policy *policy, unsigned int attr)
+{
+	memcpy(&policy[attr], &devlink_nl_policy[attr], sizeof(*policy));
+}
+
+static void devlink_nl_dump_selector_policy_init(const struct devlink_cmd *cmd,
+						 struct nla_policy *policy)
+{
+	devlink_nl_policy_cpy(policy, DEVLINK_ATTR_BUS_NAME);
+	devlink_nl_policy_cpy(policy, DEVLINK_ATTR_DEV_NAME);
+}
+
+static int devlink_nl_start(struct netlink_callback *cb)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct nlattr **attrs = info->attrs;
+	const struct devlink_cmd *cmd;
+	struct nla_policy *policy;
+	struct nlattr **selector;
+	int err;
+
+	if (!attrs[DEVLINK_ATTR_DUMP_SELECTOR])
+		return 0;
+
+	selector = kzalloc(sizeof(*selector) * (DEVLINK_ATTR_MAX + 1),
+			   GFP_KERNEL);
+	if (!selector)
+		return -ENOMEM;
+	policy = kzalloc(sizeof(*policy) * (DEVLINK_ATTR_MAX + 1), GFP_KERNEL);
+	if (!policy) {
+		kfree(selector);
+		return -ENOMEM;
+	}
+
+	cmd = devl_cmds[info->op.cmd];
+	devlink_nl_dump_selector_policy_init(cmd, policy);
+	err = nla_parse_nested(selector, DEVLINK_ATTR_MAX,
+			       attrs[DEVLINK_ATTR_DUMP_SELECTOR],
+			       policy, cb->extack);
+	kfree(policy);
+	if (err) {
+		kfree(selector);
+		return err;
+	}
+
+	state->selector = selector;
+	return 0;
+}
+
+static int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct nlattr **selector = state->selector;
+
+	if (selector && selector[DEVLINK_ATTR_BUS_NAME] &&
+	    selector[DEVLINK_ATTR_DEV_NAME])
+		return devlink_nl_instance_single_dumpit(msg, cb);
+	else
+		return devlink_nl_instance_iter_dumpit(msg, cb);
+}
+
+static int devlink_nl_done(struct netlink_callback *cb)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+
+	kfree(state->selector);
+	return 0;
+}
+
 #define __DEVL_NL_OP_DO(cmd_subname, doit_subname, pre_doit_suffix, _validate,	\
 			_maxattr, _policy)					\
 	{									\
@@ -248,7 +343,9 @@ static int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 #define __DEVL_NL_OP_DUMP(cmd_subname, _validate, _maxattr, _policy)		\
 	{									\
 		.cmd = DEVLINK_CMD_##cmd_subname,				\
-		.dumpit = devlink_nl_instance_iter_dumpit,			\
+		.start = devlink_nl_start,					\
+		.dumpit = devlink_nl_dumpit,					\
+		.done = devlink_nl_done,					\
 		.flags = GENL_CMD_CAP_DUMP,					\
 		.validate = _validate,						\
 		.maxattr = _maxattr,						\
-- 
2.41.0


