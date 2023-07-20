Return-Path: <netdev+bounces-19488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D633D75AE2F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124A51C2139A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C2182C6;
	Thu, 20 Jul 2023 12:18:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ACF182A9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:40 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EDC211B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so5968565e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855517; x=1690460317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB8dsxV8cWtAw51fDMZsKz1ROYUNPqZkPdJ43tnJILM=;
        b=xhhX+uga8+jdyb01Ot3w8XHj+9VuQOF51iF/NPJKN3+LmQyE+/WvMDNK1vAfLBsIri
         Zy3Rxrm905CitdbbhKWDYxyx9UUHnM5aCsoMsKLcq2+dN17gopvM+CopzaAnnsyrCF4f
         BSEQPEHPPJz9GSxFly4n1AS1OCdKat7zuzH/mSt+3FROAaxtXjKdLY+hKFDDWjRur/wg
         pKx7v0ngMlSu2alut5w7wWXjXAL9e7Q6T/scKxK4MnTHs/qKXmwkCWZWlgb6/+kQ6DUI
         0gbin2HHl568YpNUP9yQLQtJ/AHK5+SrzmAMPBJRyWn68q+TGgPvv1uzETWhi9DdkTeL
         GP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855517; x=1690460317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB8dsxV8cWtAw51fDMZsKz1ROYUNPqZkPdJ43tnJILM=;
        b=bqZKdENa6W7bbR5sJXOhkq/p0dEGwHG3rjtUju76RPCqJuYu5SDY7Sx8SrAn/wcvJa
         1Q7kiEqhvpqlJjqfiI7Fos/lH5zd8tuiK0OeMttmvtjmZH/V2efUHUeOJz2T3AqsOg3e
         uIFbKSqYYbS3DR0o96rEtfSgxvHmzMbI/EitpefwjcKk3FE4FfCcGP/Txuweschcukty
         F1Tv1xrXKGPYTtMtOYFK8Oq1osTMRviSrxByibzMItO8e44v114voWb9OrraL9zdN73x
         hhCZrU769/HPl23ZtpWz2Z0Vq3hQeCBKwbKWZ4ZMXJgn2Vsn/FdC7Y9tcfz1Cp03INYO
         M+Cw==
X-Gm-Message-State: ABy/qLYbQt0auSss7hJctryEFzK6AhBTGSlbB9Oq5vViK5xx4JmsYa4n
	WdQ9pHitBXfEz3SZlsOhE1LAeKKo/oHIfiuRuqY=
X-Google-Smtp-Source: APBJJlG5ggDdLw9+44eYVNRM1zmH9bYyWwRSvN/hP6xiR2DsP0ojcG26ouBbwBobu07KMtQQ5wjddA==
X-Received: by 2002:a05:600c:b57:b0:3fb:fa9f:5292 with SMTP id k23-20020a05600c0b5700b003fbfa9f5292mr6398267wmr.25.1689855517401;
        Thu, 20 Jul 2023 05:18:37 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q21-20020a1ce915000000b003fba6709c68sm1037643wmc.47.2023.07.20.05.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:36 -0700 (PDT)
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
Subject: [patch net-next v2 04/11] devlink: convert port get command to split ops
Date: Thu, 20 Jul 2023 14:18:22 +0200
Message-ID: <20230720121829.566974-5-jiri@resnulli.us>
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

Do the conversion of port get command to split ops. Introduce
devlink_nl_pre_doit_port() helper to indicate port object attribute
parsing and use it as pre_doit() callback.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  4 +++-
 net/devlink/leftover.c      | 14 +++-----------
 net/devlink/netlink.c       | 29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f6e466be2310..2870be150ee3 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -116,7 +116,7 @@ struct devlink_cmd {
 			struct netlink_callback *cb);
 };
 
-extern const struct genl_small_ops devlink_nl_ops[56];
+extern const struct genl_small_ops devlink_nl_ops[55];
 
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
@@ -209,6 +209,8 @@ int devlink_nl_cmd_info_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_port_get_doit(struct sk_buff *skb,
+				 struct genl_info *info);
 int devlink_nl_cmd_health_reporter_get_doit(struct sk_buff *skb,
 					    struct genl_info *info);
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 2f7130c60333..33f71e8fe8ee 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -1077,8 +1077,8 @@ devlink_rate_is_parent_node(struct devlink_rate *devlink_rate,
 	return false;
 }
 
-static int devlink_nl_cmd_port_get_doit(struct sk_buff *skb,
-					struct genl_info *info)
+int devlink_nl_cmd_port_get_doit(struct sk_buff *skb,
+				 struct genl_info *info)
 {
 	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct sk_buff *msg;
@@ -6301,7 +6301,7 @@ static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 	return devlink_trap_policer_set(devlink, policer_item, info);
 }
 
-const struct genl_small_ops devlink_nl_ops[56] = {
+const struct genl_small_ops devlink_nl_ops[55] = {
 	{
 		.cmd = DEVLINK_CMD_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6309,14 +6309,6 @@ const struct genl_small_ops devlink_nl_ops[56] = {
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
-	{
-		.cmd = DEVLINK_CMD_PORT_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_PORT_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index f1a5ba0f6deb..cd35fa637846 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -147,6 +147,12 @@ static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, ops->internal_flags);
 }
 
+static int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
+				    struct sk_buff *skb, struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_PORT);
+}
+
 static void devlink_nl_post_doit(const struct genl_split_ops *ops,
 				 struct sk_buff *skb, struct genl_info *info)
 {
@@ -213,6 +219,27 @@ int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+static const struct genl_split_ops devlink_nl_split_ops[] = {
+	{
+		.cmd = DEVLINK_CMD_PORT_GET,
+		.pre_doit = devlink_nl_pre_doit_port,
+		.doit = devlink_nl_cmd_port_get_doit,
+		.post_doit = devlink_nl_post_doit,
+		.flags = GENL_CMD_CAP_DO,
+		.validate = GENL_DONT_VALIDATE_STRICT,
+		.maxattr = DEVLINK_ATTR_MAX,
+		.policy	= devlink_nl_policy,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_GET,
+		.dumpit = devlink_nl_instance_iter_dumpit,
+		.flags = GENL_CMD_CAP_DUMP,
+		.validate = GENL_DONT_VALIDATE_DUMP,
+		.maxattr = DEVLINK_ATTR_MAX,
+		.policy	= devlink_nl_policy,
+	},
+};
+
 struct genl_family devlink_nl_family __ro_after_init = {
 	.name		= DEVLINK_GENL_NAME,
 	.version	= DEVLINK_GENL_VERSION,
@@ -225,6 +252,8 @@ struct genl_family devlink_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.small_ops	= devlink_nl_ops,
 	.n_small_ops	= ARRAY_SIZE(devlink_nl_ops),
+	.split_ops	= devlink_nl_split_ops,
+	.n_split_ops	= ARRAY_SIZE(devlink_nl_split_ops),
 	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
 	.mcgrps		= devlink_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
-- 
2.41.0


