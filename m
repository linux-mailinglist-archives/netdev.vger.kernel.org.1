Return-Path: <netdev+bounces-26854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86582779393
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92481C2170D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33718329A6;
	Fri, 11 Aug 2023 15:57:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203425692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:23 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C33270F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso20873455e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769440; x=1692374240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3MGpRRIkEwK4fIe76DsxXMX7cQziov7HIz9Z7EesPk=;
        b=L+bwTiWLRaeUiUA846Z6jL9EJJye1yCLV53E9HuMlXen8XIxKc+aCh1LKSLI3rqpSR
         pGPEuJLml67RyVsKVkKQt5SpNeMFTipkvNvImRgIyAYaUMEHCzB0hGJ+ljvGcbOFYebE
         6uUYUjEVUfaYv1h0aLlxYvrmftkddOXRUlLFXNAi5iX6EH7VlHvqWwP+PW/kpoRRopYb
         7JNSXqASk7vVjsrH7N0ni3tyF+qtkvX11LZIN7IDX451+P2+NU1tfSYtnBZIwAi+aTzc
         jgsP8G1hew8yCAJqGXorRbc4nYhdXR3I8TmFgzmARrhozylDnp155vbnfWnWi9OjfFEp
         RtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769440; x=1692374240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3MGpRRIkEwK4fIe76DsxXMX7cQziov7HIz9Z7EesPk=;
        b=CxD9Pw9iWyJob60SJff/ogbp9XoK1g/Y/QI1yRQBhFSoUK2MUOjnXyBPLq0tARm2XG
         4tuhSXSH/+aTP0iXJi6n/4tN6c6QX13Dg/FeQ65vxiiiZ5uTeVMnaXgU4XyGE27CS7aS
         pGMb9TbKGWvl7Nhj9wrkNGpMxH/jjtZnEmb5e27XWit/Hd6QQRhmzLFarH14aW3gBhrJ
         ZB9locuxNM6vwXIX7PLlmg1HTj0x0GC+LWRQ8PJeWaH2aTO84EOoMqycr915wnxhek3y
         mDpl2mLen3QVJfXHrde9QjolSZeLUlIqDPnaDtqg/z8g/cYHK0Ts/ZApTDgELWcQC2JI
         hZUA==
X-Gm-Message-State: AOJu0YwG7Mb0sNBenwwWIHxCuPMxgkDsmsSRVI2whskztotrBOnRfDaY
	Tb0QW0Iij7AZh5J7v1jjH71/Kgjp/BsQ1zjz2WXkwQ==
X-Google-Smtp-Source: AGHT+IGQwVb1awVWOdjr73LJY+e0KpeslpSczk4AysgWSFhFZgBvTpiOcEzQtYNELp+c2PtOBomrhg==
X-Received: by 2002:a7b:c8d2:0:b0:3fe:ad4:27b4 with SMTP id f18-20020a7bc8d2000000b003fe0ad427b4mr2134733wml.27.1691769439763;
        Fri, 11 Aug 2023 08:57:19 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fe61c33df5sm8600736wmh.3.2023.08.11.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:19 -0700 (PDT)
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
Subject: [patch net-next v4 02/13] devlink: parse rate attrs in doit() callbacks
Date: Fri, 11 Aug 2023 17:57:03 +0200
Message-ID: <20230811155714.1736405-3-jiri@resnulli.us>
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


