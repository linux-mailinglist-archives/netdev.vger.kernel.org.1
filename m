Return-Path: <netdev+bounces-19490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E175AE31
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2B11C211F2
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF3182D2;
	Thu, 20 Jul 2023 12:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2918AE6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:43 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A722106
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so5968985e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855520; x=1690460320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfomzBd2PwRVNE5zLngiFCaGvBicotIQrBKITcrn62Q=;
        b=c2iF+WKBdmbseLYY3RfM1Ae2jHp8vbRU6goGfHE9vrVnhjLMYgsdAmwds5yimqi51w
         UvhoK0LfZeJThWia6mIOA+HMprLDVN+RI5AfMcOPk2bqqy/Kh2ynMGnL9f94lLPmf3uJ
         XMFHrUm3103xY+FzLXsaiQ9CjLknL/wLDLZFqw8DB3rxy9aQ7wiuAcx2HUWoJoC0vWL8
         VPcT3N40S9ZdsrHOVN+0t3afjoHqC5h/l9LQ9ECcNXolagJTVu9cATnUnpafnQJcoESH
         ZSlm/FoM6R2GiCfH591EBCbWkArao50Cf2Yhl19nVZBwvcTJgFQdAt3RVYfcZbBfXN7i
         e1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855520; x=1690460320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfomzBd2PwRVNE5zLngiFCaGvBicotIQrBKITcrn62Q=;
        b=FqTvA1QxpZ/SH1jlb3tBnKsrbNq/IZn0pIfJ8UVkntHC0QbamIY1BYShmqJKMQrCkO
         HE+JzQu9TjXM/aCrgF5SduKSCz+Zoq7UeKCLTiTeohnzwlaa+8Yg3CIXPasEcEZHJHqA
         IPCfr9n+x11Ol0onHQ54MHGzQ6fKAjykH+oIgwJYX11zJjF2cHywvdG/gUt1Gl0C4OQ6
         6hZV6CWOoeqyvaVa5D09P6a7T7R08YOlTH9n5TqPXMB8VqKPd/ChOdtFYNcirlQG64tA
         StuhGDTy4oVNw5GKnIavZA1QFZr4VW4IHs2uv+CZ4Le+KeOsdkTAP53EX2IJxe0rxh8C
         Rdmg==
X-Gm-Message-State: ABy/qLbimCfnCT4rTCwBYn8Ij9rHk7toZKVbH9OUsXant+5c8wLD0Y5Z
	rCgHLBcyntH+9hNOSsm+zXJ2FcPxqwLRTYAAlqk=
X-Google-Smtp-Source: APBJJlHtLhc0qTZoJD3wnXQpAZG5EyKx9lYdlL6uPcZoE3Hp23DNOeUP1q0R8SpiLGulue05eD0sww==
X-Received: by 2002:a05:600c:218:b0:3fb:b008:1ff6 with SMTP id 24-20020a05600c021800b003fbb0081ff6mr6231664wmi.0.1689855520484;
        Thu, 20 Jul 2023 05:18:40 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003fc07e1908csm1029404wml.43.2023.07.20.05.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:40 -0700 (PDT)
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
Subject: [patch net-next v2 06/11] devlink: convert param get command to split ops
Date: Thu, 20 Jul 2023 14:18:24 +0200
Message-ID: <20230720121829.566974-7-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Do the conversion of param get command to split ops. Introduce
devlink_nl_pre_doit_simple() helper to indicate just devlink handle
attributes parsing and use it as pre_doit() callback.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  4 +++-
 net/devlink/leftover.c      | 13 +++----------
 net/devlink/netlink.c       | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 948b112c1328..5ba3f066b3b2 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -116,7 +116,7 @@ struct devlink_cmd {
 			struct netlink_callback *cb);
 };
 
-extern const struct genl_small_ops devlink_nl_ops[54];
+extern const struct genl_small_ops devlink_nl_ops[53];
 
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
@@ -211,6 +211,8 @@ int devlink_nl_cmd_selftests_get_doit(struct sk_buff *skb, struct genl_info *inf
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_port_get_doit(struct sk_buff *skb,
 				 struct genl_info *info);
+int devlink_nl_cmd_param_get_doit(struct sk_buff *skb,
+				  struct genl_info *info);
 int devlink_nl_cmd_health_reporter_get_doit(struct sk_buff *skb,
 					    struct genl_info *info);
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 262f3e49e87b..8729dd740171 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -4295,8 +4295,8 @@ devlink_param_get_from_info(struct xarray *params, struct genl_info *info)
 	return devlink_param_find_by_name(params, param_name);
 }
 
-static int devlink_nl_cmd_param_get_doit(struct sk_buff *skb,
-					 struct genl_info *info)
+int devlink_nl_cmd_param_get_doit(struct sk_buff *skb,
+				  struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_param_item *param_item;
@@ -6301,7 +6301,7 @@ static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 	return devlink_trap_policer_set(devlink, policer_item, info);
 }
 
-const struct genl_small_ops devlink_nl_ops[54] = {
+const struct genl_small_ops devlink_nl_ops[53] = {
 	{
 		.cmd = DEVLINK_CMD_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6489,13 +6489,6 @@ const struct genl_small_ops devlink_nl_ops[54] = {
 		.doit = devlink_nl_cmd_reload,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_PARAM_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_param_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_PARAM_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 794370e4d04a..bd128584e8c8 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -147,6 +147,12 @@ static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, ops->internal_flags);
 }
 
+static int devlink_nl_pre_doit_simple(const struct genl_split_ops *ops,
+				      struct sk_buff *skb, struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, 0);
+}
+
 static int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
 				    struct sk_buff *skb, struct genl_info *info)
 {
@@ -245,6 +251,24 @@ static const struct genl_split_ops devlink_nl_split_ops[] = {
 		.maxattr = DEVLINK_ATTR_MAX,
 		.policy	= devlink_nl_policy,
 	},
+	{
+		.cmd = DEVLINK_CMD_PARAM_GET,
+		.pre_doit = devlink_nl_pre_doit_simple,
+		.doit = devlink_nl_cmd_param_get_doit,
+		.post_doit = devlink_nl_post_doit,
+		.flags = GENL_CMD_CAP_DO,
+		.validate = GENL_DONT_VALIDATE_STRICT,
+		.maxattr = DEVLINK_ATTR_MAX,
+		.policy	= devlink_nl_policy,
+	},
+	{
+		.cmd = DEVLINK_CMD_PARAM_GET,
+		.dumpit = devlink_nl_instance_iter_dumpit,
+		.flags = GENL_CMD_CAP_DUMP,
+		.validate = GENL_DONT_VALIDATE_DUMP,
+		.maxattr = DEVLINK_ATTR_MAX,
+		.policy	= devlink_nl_policy,
+	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
 		.pre_doit = devlink_nl_pre_doit_port_optional,
-- 
2.41.0


