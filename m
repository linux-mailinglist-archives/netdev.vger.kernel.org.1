Return-Path: <netdev+bounces-19485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93975AE29
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428911C213BE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1799F18016;
	Thu, 20 Jul 2023 12:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173A18013
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:35 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5842115
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso6222125e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855513; x=1690460313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kSaJ38xyljlMmEibkqyMZA7beyTOEb9WwKeGXy20WQ=;
        b=BZj1w451fg0D7cDc3MXIrh6zUaRjq2WNzIW+VezbgTcKhTFroU5lDvDib4nsL1LkWf
         uM+RY9iBeZk+TJUh/hr+NdDj8HiSlZY4L6HC0PgR2wwTiDkgCxl5Wu6eajMQ88ZlHSYM
         wvEa3Ouh92q/lwCbYU4QlX33Rcm1ZWcWsjLU5uLj+5zXE96O10SnFQWXQ6Y0hhB0y64e
         o9nRScbjynoq8lRzZ5AK+ALNmsBX595c1Me2dR50FmXzG9pyrnfWbL5a4IXKlCazMmo6
         WAO/GG8hTET4jYLZbh+RjNSh0s3zHEhGnmgkB9fxCrBEMNe0VOLKM71POnnQddIYYmhv
         neCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855513; x=1690460313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kSaJ38xyljlMmEibkqyMZA7beyTOEb9WwKeGXy20WQ=;
        b=V+gS7bOB4JCe/6IIZJQZud1XRHROc8u8poNhttwYaPGoHADN2OlrWMvgKQoVFb4ZAI
         QCIC6EFZaKmOLRsDIc77kM13j8wGRiqBcurYxY6jDXEDThHcvSG9O5jpxm0fnuK9nu23
         jk3uL8faEPdPXINsRctKbVhGp9DNZL0BmRdxynn6gMUMAhoo8pI4ysV4SiFDp0QLApa3
         KGUWtJspvP63adU7SjLHA/kGBfbcJN5b+AjVOsG+U/D8F70iHARdm+sKcgwVAD+4Hx4N
         Qn7gW9cBQpBlgtcRW6RnHct6UxeriSykATpIxDekTipFbwqBKu2MDt6xt1I3Lgz+sPLK
         VKaw==
X-Gm-Message-State: ABy/qLZkbgiCbDrjC/GliiFpMtRLnJeufuwUGZ0vc9yX0rp4TWYeWe70
	SLSI7DO49aYUEmSWzwDQU13ILOEan62A7swvgrQ=
X-Google-Smtp-Source: APBJJlHOSygQmnwwMtYo17bqtx+2J6XgsPIeC5IHsZl8thIbciUJY8rkFjV4qbGUX4Br+TyW3GI7OQ==
X-Received: by 2002:a1c:ed14:0:b0:3fb:b67b:7f15 with SMTP id l20-20020a1ced14000000b003fbb67b7f15mr4239815wmh.21.1689855512699;
        Thu, 20 Jul 2023 05:18:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o1-20020a056000010100b003144bfbd0b3sm1186142wrx.37.2023.07.20.05.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:32 -0700 (PDT)
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
Subject: [patch net-next v2 01/11] devlink: parse linecard attr in doit() callbacks
Date: Thu, 20 Jul 2023 14:18:19 +0200
Message-ID: <20230720121829.566974-2-jiri@resnulli.us>
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

No need to give the linecards any special treatment in netlink attribute
parsing, as unlike for ports, there is only a couple of commands
benefiting from that.

Remove DEVLINK_NL_FLAG_NEED_LINECARD, make pre_doit() callback simpler
by moving the linecard attribute parsing to linecard_[gs]et_doit() ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  7 -------
 net/devlink/leftover.c      | 19 +++++++++++++------
 net/devlink/netlink.c       |  8 --------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 62921b2eb0d3..44b3a69c448e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -92,7 +92,6 @@ static inline bool devl_is_registered(struct devlink *devlink)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
 #define DEVLINK_NL_FLAG_NEED_RATE		BIT(2)
 #define DEVLINK_NL_FLAG_NEED_RATE_NODE		BIT(3)
-#define DEVLINK_NL_FLAG_NEED_LINECARD		BIT(4)
 
 enum devlink_multicast_groups {
 	DEVLINK_MCGRP_CONFIG,
@@ -199,12 +198,6 @@ int devlink_resources_validate(struct devlink *devlink,
 			       struct devlink_resource *resource,
 			       struct genl_info *info);
 
-/* Line cards */
-struct devlink_linecard;
-
-struct devlink_linecard *
-devlink_linecard_get_from_info(struct devlink *devlink, struct genl_info *info);
-
 /* Rates */
 int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 			     struct netlink_ext_ack *extack);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 5128b9c7eea8..dba58830ed28 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -285,7 +285,7 @@ devlink_linecard_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
 	return ERR_PTR(-EINVAL);
 }
 
-struct devlink_linecard *
+static struct devlink_linecard *
 devlink_linecard_get_from_info(struct devlink *devlink, struct genl_info *info)
 {
 	return devlink_linecard_get_from_attrs(devlink, info->attrs);
@@ -1814,11 +1814,15 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 static int devlink_nl_cmd_linecard_get_doit(struct sk_buff *skb,
 					    struct genl_info *info)
 {
-	struct devlink_linecard *linecard = info->user_ptr[1];
-	struct devlink *devlink = linecard->devlink;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_linecard *linecard;
 	struct sk_buff *msg;
 	int err;
 
+	linecard = devlink_linecard_get_from_info(devlink, info);
+	if (IS_ERR(linecard))
+		return PTR_ERR(linecard);
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
@@ -2008,10 +2012,15 @@ static int devlink_linecard_type_unset(struct devlink_linecard *linecard,
 static int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
 					    struct genl_info *info)
 {
-	struct devlink_linecard *linecard = info->user_ptr[1];
 	struct netlink_ext_ack *extack = info->extack;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_linecard *linecard;
 	int err;
 
+	linecard = devlink_linecard_get_from_info(devlink, info);
+	if (IS_ERR(linecard))
+		return PTR_ERR(linecard);
+
 	if (info->attrs[DEVLINK_ATTR_LINECARD_TYPE]) {
 		const char *type;
 
@@ -6354,14 +6363,12 @@ const struct genl_small_ops devlink_nl_ops[56] = {
 		.cmd = DEVLINK_CMD_LINECARD_GET,
 		.doit = devlink_nl_cmd_linecard_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_LINECARD,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_LINECARD_SET,
 		.doit = devlink_nl_cmd_linecard_set_doit,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_LINECARD,
 	},
 	{
 		.cmd = DEVLINK_CMD_SB_GET,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 7a332eb70f70..cd2754698478 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -112,7 +112,6 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 			       struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_linecard *linecard;
 	struct devlink_port *devlink_port;
 	struct devlink *devlink;
 	int err;
@@ -151,13 +150,6 @@ static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 			goto unlock;
 		}
 		info->user_ptr[1] = rate_node;
-	} else if (ops->internal_flags & DEVLINK_NL_FLAG_NEED_LINECARD) {
-		linecard = devlink_linecard_get_from_info(devlink, info);
-		if (IS_ERR(linecard)) {
-			err = PTR_ERR(linecard);
-			goto unlock;
-		}
-		info->user_ptr[1] = linecard;
 	}
 	return 0;
 
-- 
2.41.0


