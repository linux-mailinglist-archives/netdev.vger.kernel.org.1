Return-Path: <netdev+bounces-19491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3475AE32
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747F9281E8D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC018AFA;
	Thu, 20 Jul 2023 12:18:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122C18AE6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:44 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768062115
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so6216315e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855522; x=1690460322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNI4AIvtc24qZC/JImoWZi403YlvbJrU2GRSCx32kA0=;
        b=nSUea9AGjelwvRcQKCLz8iopr0Qi15cY2XWRoXu39BxFpRISle7eU+lGx0yfH4HySM
         TMNtwST4IVYKn855xB7wPHdlC5v3vy4ciCbUUPavcY1pLIQ9pg6d5i20gqitoQv9zsYU
         2eVKCw1wr4ukuIfgqBFpCx+Sb241h7Qxjbmipo08eYyVYGLUGRe0TdRFs8PwatTEcjlK
         H3zFOQkzKFzafFZUj7CDHot0FY+qNc3aGrIc7o8Qv1j7b0T/v+p5zUL4H3BOuMbqmJPS
         3BsDR92f1wLRx3bAw/fEgfWiyV81eSuiQAXIYjJCK0su2yIKJl7yD53yCP2obO/flTRq
         t9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855522; x=1690460322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNI4AIvtc24qZC/JImoWZi403YlvbJrU2GRSCx32kA0=;
        b=S7LZRdfwLVTYdjNhs51VRoFTmI4raBnBcaukhG7ZtmHRGPQdqijS1958RccLwJ25v1
         o77fpdQ27WAmHwJQVO677KFBUP6cWZvxhgNzhBxZAg1jyZKPINPRRVXr6sezKBR+bS7E
         EGlHzsJZ+sjdXaaw1se46bBKr8uFav9+x9WZhRSa5AADx+fXohqfnQg0yvuW2PHZozfz
         Y9nIZFCIXN9atjJJGZYCVXxryPs0jRZE/r7J+Ds1UIb+15usOPfnJ0RD+wD3786I6XRK
         ApjP7sRPdi3J+G7Wvgj1Oi0iKpS+5Gx0W5FLv9y4KatIsnxz0OJm6MV0wroLOq+0M/7i
         pmjg==
X-Gm-Message-State: ABy/qLbl+TK1ujt37rLrkn+xFISlpOdehtEHdoTpCVSkGDr2R0nTqnAZ
	FyL5ODGWk7FtJVXc1/zRbRSLyiFBzV8RUmluGnQ=
X-Google-Smtp-Source: APBJJlGcLgsQJsIa6W8tuxgKe4CqnGLcmOZ9FyFdm5OCiWqPqP80yEnOmnka7YCEuSUE5IayUIzZpg==
X-Received: by 2002:a05:600c:204b:b0:3fa:9561:3016 with SMTP id p11-20020a05600c204b00b003fa95613016mr6531587wmg.30.1689855522042;
        Thu, 20 Jul 2023 05:18:42 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z20-20020a1c4c14000000b003fc6179e20asm3674604wmf.1.2023.07.20.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:41 -0700 (PDT)
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
Subject: [patch net-next v2 07/11] devlink: convert trap get command to split ops
Date: Thu, 20 Jul 2023 14:18:25 +0200
Message-ID: <20230720121829.566974-8-jiri@resnulli.us>
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

Do the conversion of trap get command to split ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  3 ++-
 net/devlink/leftover.c      | 11 ++---------
 net/devlink/netlink.c       | 16 ++++++++++++++++
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 5ba3f066b3b2..dc655d5797a8 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -116,7 +116,7 @@ struct devlink_cmd {
 			struct netlink_callback *cb);
 };
 
-extern const struct genl_small_ops devlink_nl_ops[53];
+extern const struct genl_small_ops devlink_nl_ops[52];
 
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
@@ -227,3 +227,4 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 						   struct genl_info *info);
 int devlink_nl_cmd_health_reporter_test_doit(struct sk_buff *skb,
 					     struct genl_info *info);
+int devlink_nl_cmd_trap_get_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 8729dd740171..3dbba1906ee6 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -5655,8 +5655,7 @@ static int devlink_nl_trap_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_cmd_trap_get_doit(struct sk_buff *skb,
-					struct genl_info *info)
+int devlink_nl_cmd_trap_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink *devlink = info->user_ptr[0];
@@ -6301,7 +6300,7 @@ static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 	return devlink_trap_policer_set(devlink, policer_item, info);
 }
 
-const struct genl_small_ops devlink_nl_ops[53] = {
+const struct genl_small_ops devlink_nl_ops[52] = {
 	{
 		.cmd = DEVLINK_CMD_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6591,12 +6590,6 @@ const struct genl_small_ops devlink_nl_ops[53] = {
 		.doit = devlink_nl_cmd_flash_update,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_GET,
-		.doit = devlink_nl_cmd_trap_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_TRAP_SET,
 		.doit = devlink_nl_cmd_trap_set_doit,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index bd128584e8c8..cabebff6e7a7 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -287,6 +287,22 @@ static const struct genl_split_ops devlink_nl_split_ops[] = {
 		.maxattr = DEVLINK_ATTR_MAX,
 		.policy	= devlink_nl_policy,
 	},
+	{
+		.cmd = DEVLINK_CMD_TRAP_GET,
+		.pre_doit = devlink_nl_pre_doit_simple,
+		.doit = devlink_nl_cmd_trap_get_doit,
+		.post_doit = devlink_nl_post_doit,
+		.flags = GENL_CMD_CAP_DO,
+		.maxattr = DEVLINK_ATTR_MAX,
+		.policy	= devlink_nl_policy,
+	},
+	{
+		.cmd = DEVLINK_CMD_TRAP_GET,
+		.dumpit = devlink_nl_instance_iter_dumpit,
+		.flags = GENL_CMD_CAP_DUMP,
+		.maxattr = DEVLINK_ATTR_MAX,
+		.policy	= devlink_nl_policy,
+	},
 };
 
 struct genl_family devlink_nl_family __ro_after_init = {
-- 
2.41.0


