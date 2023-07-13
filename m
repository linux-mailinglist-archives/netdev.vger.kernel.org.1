Return-Path: <netdev+bounces-17623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A99475266A
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F72281E37
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A41EA94;
	Thu, 13 Jul 2023 15:15:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363A1EA74
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:15:43 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6927FA2
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:15:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991ef0b464cso453205066b.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689261331; x=1691853331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSOMyhPHQHsjkQqbe1+Sy5kPDPFeX1/HO98Z7nr1IRw=;
        b=tCA4ACsn5Jt/1IPY+UNtTPFBsBAl31J+322bpYm/DmWc3MaCL3nktarCAUyuflH3wc
         fsQW6Jyd1mpF4FUWSym/IvCwzDAoMvUtzR3N2zUq/hGSUnqkezo8DcGnJNLGWdXuYJIF
         lD5o96byH0C+SzDpHYKYkSlr6q019anAsvajz527zg9YaowLAg0+ldeqXiav1SrkL4l1
         Qs5nV7uVSYtAjAkB3qlEL7m3CzQmBb7x/lnPtLarYGVni8WwyOXgMWqA9FHKtpuqqTvD
         rX74+qrXYBDP4TIWVk2fwQWTLXVHq+lTvMh6m8/KuPv/OXLJxcRVNjw9lhzU98qWyfDZ
         H2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261331; x=1691853331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSOMyhPHQHsjkQqbe1+Sy5kPDPFeX1/HO98Z7nr1IRw=;
        b=gLc7nlAszoqbbMiVVyVMiPeQ+7WQOThoki2XLUzaPcPP7steqfRQgTxseQkEOtdRUi
         DXhJCXdsCnap0DFMf242TP67/69M6GogVS1vVd1I7/En1dFVQjgqszkevY9h0fPX/y3J
         EYMwBxA5W/0w99yCJfXmQKsnK+pAzRajX6plJPByi6N6ExnLkc3gewLHifVQutRHRQMk
         k0hBbuFEDyJs7DaMqDQnKEICRc3hh9hE11oSYxMmq9bJ/0y3XJ4135UzlSDR75kbGuVg
         6xdYGgj+eh0PyZShiPNZfIteyxwyfOwjNDQUIVeIOBfhMfkeGNV0Lpb5DwMK4BlJLBDq
         Eygw==
X-Gm-Message-State: ABy/qLbdCvwO6Yt2lw3vaYb3iB0xITLsJTms6MXT9AOU8NgRaFOdYGUZ
	xF8TW2/sDlHucQiYP7wvyrnwOjRpkoC3AkcWT3I=
X-Google-Smtp-Source: APBJJlEyGVKGYEUqZoR7juJ/3MaFsqxup3FkrtueuevcXuPnx1JZzZZii4Tr/HZFYT7gSiQOBjrxow==
X-Received: by 2002:a17:906:1019:b0:98f:8481:24b3 with SMTP id 25-20020a170906101900b0098f848124b3mr2781103ejm.37.1689261330632;
        Thu, 13 Jul 2023 08:15:30 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z26-20020a1709064e1a00b009937dbabbd5sm4088513eju.220.2023.07.13.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:15:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next] devlink: introduce dump selector attr and implement it for port dumps
Date: Thu, 13 Jul 2023 17:15:28 +0200
Message-Id: <20230713151528.2546909-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.39.2
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

Allow user to pass devlink handle alongside the dump command for
ports and dump only ports which are under selected devlink instance.

Introduce new attr DEVLINK_ATTR_DUMP_SELECTOR to nest the selection
attributes. This way the userspace can use maxattr to tell if dump
selector is supported by kernel or not.

Each object (port in this case), has to pass nla_policy array to expose
what are the supported selection attributes. If user passes attr unknown
to kernel, netlink validation errors out.

Note this infrastructure could be later on easily extended by:
1) Other commands to select dumps by devlink instance.
2) Include other attrs into selection for specific object type. For that
   the dump_one() op would be extended by selector attrs arg.

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
 include/uapi/linux/devlink.h |  2 ++
 net/devlink/devl_internal.h  |  3 +++
 net/devlink/leftover.c       |  5 +++--
 net/devlink/netlink.c        | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 2 deletions(-)

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
index 62921b2eb0d3..4f5cf18af6a1 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -117,6 +117,7 @@ struct devlink_nl_dump_state {
 struct devlink_cmd {
 	int (*dump_one)(struct sk_buff *msg, struct devlink *devlink,
 			struct netlink_callback *cb);
+	const struct nla_policy *dump_selector_nla_policy;
 };
 
 extern const struct genl_small_ops devlink_nl_ops[56];
@@ -127,6 +128,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
 void devlink_notify_unregister(struct devlink *devlink);
 void devlink_notify_register(struct devlink *devlink);
 
+extern const struct nla_policy devlink_nl_handle_policy[DEVLINK_ATTR_MAX + 1];
+
 int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 				    struct netlink_callback *cb);
 
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 5128b9c7eea8..aeb61b8e9e62 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -1119,7 +1119,8 @@ devlink_nl_cmd_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 }
 
 const struct devlink_cmd devl_cmd_port_get = {
-	.dump_one		= devlink_nl_cmd_port_get_dump_one,
+	.dump_one			= devlink_nl_cmd_port_get_dump_one,
+	.dump_selector_nla_policy	= devlink_nl_handle_policy,
 };
 
 static int devlink_port_type_set(struct devlink_port *devlink_port,
@@ -6288,7 +6289,7 @@ const struct genl_small_ops devlink_nl_ops[56] = {
 	},
 	{
 		.cmd = DEVLINK_CMD_PORT_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP_STRICT,
 		.doit = devlink_nl_cmd_port_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 7a332eb70f70..f6cd06bd1f09 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -80,6 +80,7 @@ static const struct nla_policy devlink_nl_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32 },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32 },
 	[DEVLINK_ATTR_REGION_DIRECT] = { .type = NLA_FLAG },
+	[DEVLINK_ATTR_DUMP_SELECTOR] = { .type = NLA_NESTED },
 };
 
 struct devlink *
@@ -196,17 +197,47 @@ static const struct devlink_cmd *devl_cmds[] = {
 	[DEVLINK_CMD_SELFTESTS_GET]	= &devl_cmd_selftests_get,
 };
 
+const struct nla_policy devlink_nl_handle_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING },
+};
+
 int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 				    struct netlink_callback *cb)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct nlattr **attrs = info->attrs;
 	const struct devlink_cmd *cmd;
 	struct devlink *devlink;
 	int err = 0;
 
 	cmd = devl_cmds[info->op.cmd];
 
+	/* If the user provided selector attribute with devlink handle, dump only
+	 * objects that belong under this instance.
+	 */
+	if (cmd->dump_selector_nla_policy &&
+	    attrs[DEVLINK_ATTR_DUMP_SELECTOR]) {
+		struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
+
+		err = nla_parse_nested(tb, DEVLINK_ATTR_MAX,
+				       attrs[DEVLINK_ATTR_DUMP_SELECTOR],
+				       cmd->dump_selector_nla_policy,
+				       cb->extack);
+		if (err)
+			return err;
+		if (tb[DEVLINK_ATTR_BUS_NAME] && tb[DEVLINK_ATTR_DEV_NAME]) {
+			devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), tb);
+			if (IS_ERR(devlink))
+				return PTR_ERR(devlink);
+			err = cmd->dump_one(msg, devlink, cb);
+			devl_unlock(devlink);
+			devlink_put(devlink);
+			goto out;
+		}
+	}
+
 	while ((devlink = devlinks_xa_find_get(sock_net(msg->sk),
 					       &state->instance))) {
 		devl_lock(devlink);
@@ -228,6 +259,7 @@ int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 		state->idx = 0;
 	}
 
+out:
 	if (err != -EMSGSIZE)
 		return err;
 	return msg->len;
-- 
2.39.2


