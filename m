Return-Path: <netdev+bounces-26346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8C77795B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3CB282127
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEA81E1DC;
	Thu, 10 Aug 2023 13:15:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54541E1C1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:15:47 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743F810E6
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso8216945e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673345; x=1692278145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3MGpRRIkEwK4fIe76DsxXMX7cQziov7HIz9Z7EesPk=;
        b=pVpF0bgzBtCQYfHg+dQ6gNy1auLO4hLFUzpLUfkDCJReMO19/jftQYrL21ax/tJo8F
         n+NrKbq0AyKq955Usj1H6CkwBfTLWaX/hWN3xi8wszcQP1H+hHsL3k7yDJMDjzmQKDe+
         UM17XKeuR9Dul+qLgPjKX0DrhxmZEnum0+01F0rZFz+yIVWPV+WZ7deZQKpcj8sNZBDt
         hxR9Jq8hAViRGxbvk2/s9bciRP528MzgoAb4fy/nyCkzZV2502fmDBR4d5PzijILcGmH
         5YiNY/RYO/ij9V+ILYbulvVIK9S9t5hg0V6RmqXNJ08uoU46f3LoZQoq/Ws2N17vo14B
         gnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673345; x=1692278145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3MGpRRIkEwK4fIe76DsxXMX7cQziov7HIz9Z7EesPk=;
        b=D1MnWxz+Njmj5+fVfqz3H5Z9Gbbiy5mL/JbZ4JFmCYBASmprsnwgDG3gtaBubxuFly
         akh/karp0uuUGbnpWkJJjhqbXJdgXVJaQB1eNmUjE/k4z/X8DEgm+nPDc7tBfD74rv69
         y2O4bjjfvhvZ1PPt7L38zzYRVJTWhcspkVpq1b3QC6Y63tlhRN/9hv+j3/mxdecXHN7H
         tgd3kY3RFZ/kzwS5iMo6QCBaOgtQcGS33jJBPTgwXx7exCM2rz1yQvpWvj7h8EvropvW
         W4lWjPqJkQFIopPSEBLQQ6plXcoXHFWuawN1qbd7dE/UJSG1pgp2lyYlOavxaaZOzCgN
         Ruiw==
X-Gm-Message-State: AOJu0Yy5fQ9spP2mMJ8stzMZkXll3sHQ7NgYOBkvLLESD5yyFDsJ4DMM
	3xusnK4DS/qY4Sh4PLKQy5Qq9VmrgGZUgRTi8mj6qQ==
X-Google-Smtp-Source: AGHT+IEiK/Dudorkp7VVZ76kWrGezFQaaDIB2Bof7uPI/vwCvDcJqi1P9gT8w8gFqc8euUCn0N0qZA==
X-Received: by 2002:a5d:5489:0:b0:317:5d1c:9719 with SMTP id h9-20020a5d5489000000b003175d1c9719mr2069645wrv.9.1691673344807;
        Thu, 10 Aug 2023 06:15:44 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5949000000b003143add4396sm2171336wri.22.2023.08.10.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:15:44 -0700 (PDT)
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
Subject: [patch net-next v3 02/13] devlink: parse rate attrs in doit() callbacks
Date: Thu, 10 Aug 2023 15:15:28 +0200
Message-ID: <20230810131539.1602299-3-jiri@resnulli.us>
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
index 3bbecebf192d..ca04e4ee9427 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -92,8 +92,6 @@ static inline bool devl_is_registered(struct devlink *devlink)
 /* Netlink */
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
-#define DEVLINK_NL_FLAG_NEED_RATE		BIT(2)
-#define DEVLINK_NL_FLAG_NEED_RATE_NODE		BIT(3)
 
 enum devlink_multicast_groups {
 	DEVLINK_MCGRP_CONFIG,
@@ -205,11 +203,7 @@ int devlink_resources_validate(struct devlink *devlink,
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
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 46cdd5d88583..b7b6850e26d8 100644
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
@@ -6307,14 +6321,12 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
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
@@ -6325,7 +6337,6 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.cmd = DEVLINK_CMD_RATE_DEL,
 		.doit = devlink_nl_cmd_rate_del_doit,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_RATE_NODE,
 	},
 	{
 		.cmd = DEVLINK_CMD_PORT_SPLIT,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 9fd683f38a53..96cf8a1b8bce 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -132,24 +132,6 @@ int devlink_nl_pre_doit(const struct genl_split_ops *ops,
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


