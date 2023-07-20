Return-Path: <netdev+bounces-19486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B8675AE2D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE62281E1B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7CC18013;
	Thu, 20 Jul 2023 12:18:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C63182AA
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:37 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832192118
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so11932315e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855514; x=1690460314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x9FZDhdqblB+z/ExbJxjIHAvQZBsO/rmW9NK1t2hdg=;
        b=uXC8Y6DjL0uaP1H7Oc1B0OSISmt1/nOcbzTY7LKqTmvC6MFVG2fJpgA0ysNZvXcbP4
         G/zkVXZGRYDzQFRYsuOJh3RqkvFnveeawar5SuRigJm5V94NYzXvBasyKYizw3r+OM6k
         o8I+yDhKO/2Axev9X/iJoWccxynlW3GXPbCawGSnSsuQP2rCkd3ZpRpBGq2ukvYYjgTS
         mqWpAT54k4nphbErbeNnF+71fI7ZJYbWaKWRcFjARPwrMw1m2rOdHuXyNVTanvOQPndo
         CfwFg5jarZ4h7dqqhDq2OW8UhoKUV4rIfDattIb+kgFUVIfiQjhP7x59mjfqw04VeKBZ
         T00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855514; x=1690460314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x9FZDhdqblB+z/ExbJxjIHAvQZBsO/rmW9NK1t2hdg=;
        b=GFNVMR0SvShspxIvrY4BdsiRRGHeFRpmeSYZX0hux9p6Ss60IUjmdLo+tf5Sy0rwtH
         Uue2PkfoRonwXgvtLDna6fBL+ENdgocuf7IPnrkG6d2cuCjs54HZguGY6tTwiYlwr6ld
         GWnS0Jy9UpXvNjNAo3USDUdt5Dhc0OvC9g7/jF4+thRMiB7zp3kNQXMszrAAo53SbPlt
         qLHs1vGmtThZ4yhu3C9yYSWeJ26g0s88g6hK/gf7CKQG4jq+dr3XinAAb4+6HmYO+qsn
         hV0XbEKst4cKqozHEAGgOklYsGBNuMmv68Z8FWf7/MYySPfOomY/e/USWSImqCRcqHIv
         dtag==
X-Gm-Message-State: ABy/qLZONqPbtY2Jt6PYwlhl9fZAdYFtQ8fpn8mYmblTpcEBu5CCe4Vx
	vd/PIEcoDEK01DjoObPSKaZ/paHj7MJmLX+wdHk=
X-Google-Smtp-Source: APBJJlGrBPv62yTag8+NVdZHmWQ4m7yz8yDaMlUXb0IdyiyCctvm1KHdewat4jQtJzAfbadJvH02fQ==
X-Received: by 2002:a05:600c:1d8e:b0:3fb:ebe2:6f5f with SMTP id p14-20020a05600c1d8e00b003fbebe26f5fmr4465130wms.13.1689855514128;
        Thu, 20 Jul 2023 05:18:34 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d5145000000b00314145e6d61sm1212356wrt.6.2023.07.20.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:33 -0700 (PDT)
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
Subject: [patch net-next v2 02/11] devlink: parse rate attrs in doit() callbacks
Date: Thu, 20 Jul 2023 14:18:20 +0200
Message-ID: <20230720121829.566974-3-jiri@resnulli.us>
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

No need to give the rate any special treatment in netlink attributes
parsing, as unlike for ports, there is only a couple of commands
benefiting from that.

Remove DEVLINK_NL_FLAG_NEED_RATE*, make pre_doit() callback simpler
by moving the rate attributes parsing to rate_*_doit() ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  8 +-------
 net/devlink/leftover.c      | 37 ++++++++++++++++++++++++-------------
 net/devlink/netlink.c       | 18 ------------------
 3 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 44b3a69c448e..f6e466be2310 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -90,8 +90,6 @@ static inline bool devl_is_registered(struct devlink *devlink)
 /* Netlink */
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
-#define DEVLINK_NL_FLAG_NEED_RATE		BIT(2)
-#define DEVLINK_NL_FLAG_NEED_RATE_NODE		BIT(3)
 
 enum devlink_multicast_groups {
 	DEVLINK_MCGRP_CONFIG,
@@ -201,11 +199,7 @@ int devlink_resources_validate(struct devlink *devlink,
 /* Rates */
 int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 			     struct netlink_ext_ack *extack);
-struct devlink_rate *
-devlink_rate_get_from_info(struct devlink *devlink, struct genl_info *info);
-struct devlink_rate *
-devlink_rate_node_get_from_info(struct devlink *devlink,
-				struct genl_info *info);
+
 /* Devlink nl cmds */
 int devlink_nl_cmd_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index dba58830ed28..2f7130c60333 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -232,13 +232,13 @@ devlink_rate_node_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
 	return devlink_rate_node_get_by_name(devlink, rate_node_name);
 }
 
-struct devlink_rate *
+static struct devlink_rate *
 devlink_rate_node_get_from_info(struct devlink *devlink, struct genl_info *info)
 {
 	return devlink_rate_node_get_from_attrs(devlink, info->attrs);
 }
 
-struct devlink_rate *
+static struct devlink_rate *
 devlink_rate_get_from_info(struct devlink *devlink, struct genl_info *info)
 {
 	struct nlattr **attrs = info->attrs;
@@ -1041,10 +1041,15 @@ const struct devlink_cmd devl_cmd_rate_get = {
 static int devlink_nl_cmd_rate_get_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink_rate *devlink_rate = info->user_ptr[1];
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_rate *devlink_rate;
 	struct sk_buff *msg;
 	int err;
 
+	devlink_rate = devlink_rate_get_from_info(devlink, info);
+	if (IS_ERR(devlink_rate))
+		return PTR_ERR(devlink_rate);
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
@@ -1629,11 +1634,16 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 static int devlink_nl_cmd_rate_set_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink_rate *devlink_rate = info->user_ptr[1];
-	struct devlink *devlink = devlink_rate->devlink;
-	const struct devlink_ops *ops = devlink->ops;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_rate *devlink_rate;
+	const struct devlink_ops *ops;
 	int err;
 
+	devlink_rate = devlink_rate_get_from_info(devlink, info);
+	if (IS_ERR(devlink_rate))
+		return PTR_ERR(devlink_rate);
+
+	ops = devlink->ops;
 	if (!ops || !devlink_rate_set_ops_supported(ops, info, devlink_rate->type))
 		return -EOPNOTSUPP;
 
@@ -1704,18 +1714,22 @@ static int devlink_nl_cmd_rate_new_doit(struct sk_buff *skb,
 static int devlink_nl_cmd_rate_del_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink_rate *rate_node = info->user_ptr[1];
-	struct devlink *devlink = rate_node->devlink;
-	const struct devlink_ops *ops = devlink->ops;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_rate *rate_node;
 	int err;
 
+	rate_node = devlink_rate_node_get_from_info(devlink, info);
+	if (IS_ERR(rate_node))
+		return PTR_ERR(rate_node);
+
 	if (refcount_read(&rate_node->refcnt) > 1) {
 		NL_SET_ERR_MSG(info->extack, "Node has children. Cannot delete node.");
 		return -EBUSY;
 	}
 
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
-	err = ops->rate_node_del(rate_node, rate_node->priv, info->extack);
+	err = devlink->ops->rate_node_del(rate_node, rate_node->priv,
+					  info->extack);
 	if (rate_node->parent)
 		refcount_dec(&rate_node->parent->refcnt);
 	list_del(&rate_node->list);
@@ -6314,14 +6328,12 @@ const struct genl_small_ops devlink_nl_ops[56] = {
 		.cmd = DEVLINK_CMD_RATE_GET,
 		.doit = devlink_nl_cmd_rate_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_RATE,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_RATE_SET,
 		.doit = devlink_nl_cmd_rate_set_doit,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_RATE,
 	},
 	{
 		.cmd = DEVLINK_CMD_RATE_NEW,
@@ -6332,7 +6344,6 @@ const struct genl_small_ops devlink_nl_ops[56] = {
 		.cmd = DEVLINK_CMD_RATE_DEL,
 		.doit = devlink_nl_cmd_rate_del_doit,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_RATE_NODE,
 	},
 	{
 		.cmd = DEVLINK_CMD_PORT_SPLIT,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index cd2754698478..336f375f9ff6 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -132,24 +132,6 @@ static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 		devlink_port = devlink_port_get_from_info(devlink, info);
 		if (!IS_ERR(devlink_port))
 			info->user_ptr[1] = devlink_port;
-	} else if (ops->internal_flags & DEVLINK_NL_FLAG_NEED_RATE) {
-		struct devlink_rate *devlink_rate;
-
-		devlink_rate = devlink_rate_get_from_info(devlink, info);
-		if (IS_ERR(devlink_rate)) {
-			err = PTR_ERR(devlink_rate);
-			goto unlock;
-		}
-		info->user_ptr[1] = devlink_rate;
-	} else if (ops->internal_flags & DEVLINK_NL_FLAG_NEED_RATE_NODE) {
-		struct devlink_rate *rate_node;
-
-		rate_node = devlink_rate_node_get_from_info(devlink, info);
-		if (IS_ERR(rate_node)) {
-			err = PTR_ERR(rate_node);
-			goto unlock;
-		}
-		info->user_ptr[1] = rate_node;
 	}
 	return 0;
 
-- 
2.41.0


