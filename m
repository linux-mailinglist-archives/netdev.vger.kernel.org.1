Return-Path: <netdev+bounces-19492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D921A75AE33
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086941C21415
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B844F18B06;
	Thu, 20 Jul 2023 12:18:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0318AE6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:46 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB392106
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so6133415e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855523; x=1690460323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii8JB/y8HnFzFLg5jRSqjsd1dxooNhCffkYW/XJ2yHk=;
        b=XTgqp70aVW5kQPNF+nbUH014Vb+x52MsdQc4nlsSl76ME4D8nbfnCVR16UBRqrUqYR
         FmHYs2FKCVkXzvpnf+hLVwR8S8Yv5UjMLY0zR6KazYx5eYsxluTds++ZxTPZcPkvNDaw
         B4LuynPimy8RPWrAgLcsH2e9Ex+cXUYehz7HaaVswsyPrIYQcbYP+PDbNbgZG2dGqR/l
         zTtkQUq/Pt1uN0hIevL4grye0dRWNj/ozEclNYSORjYaJi7CDNB8LlX1mssHUcnrcRor
         YkRPFvf9Niau5DEOprEPMjLQdaXmeKsPgoj7nbLz+2B7cVfx/QKknuB26KeQrynrUFr6
         dxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855523; x=1690460323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii8JB/y8HnFzFLg5jRSqjsd1dxooNhCffkYW/XJ2yHk=;
        b=Z6W2NNJ0vLg+iJluMNt9JgnHv4Tjc6FPM9xqkOTvlfIOmwQLCCCoWTir8bz5YYTfnv
         BtCv348YV0cow52rBZHUoPZXNd9/K46dJxJGYD8GFJXkCPR6Q98cv+ATBs+OJceusoLh
         sg1sVgssLGFomQzVW+feKA0f29mTWAWZKxT87fvRRdigpPGOe2j0ojaMrsrDAsZSuuw6
         1AZqThWzdK8UUJMBD2HWQCiOA7ib2g5CFr1r6PEH2lXmJT7UILp0N7otIv/2itU5oJVt
         sdi0E151Be2IHZRbfWbFfOPmZbQk6phdUPp3Aydf1YHN/PtBEQeeOW/zw3+SEuK/1xz1
         PtsA==
X-Gm-Message-State: ABy/qLZjmakEXIr5Heexbug6Ej4t9pei50VZT9s6bj18XBNJ+cwZZmye
	iHJ/ReIOf9oA/GsnhY53F+5KDsV7C2EoQYpc2rQ=
X-Google-Smtp-Source: APBJJlG8UEpEyNAB3B/JeI3EA8UiE90J6o986qXvT3xbygseLG67RQEMC633oxEzk/36TzG/sei0LA==
X-Received: by 2002:a05:600c:3658:b0:3fb:b008:2003 with SMTP id y24-20020a05600c365800b003fbb0082003mr6888098wmq.38.1689855523603;
        Thu, 20 Jul 2023 05:18:43 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x2-20020adff642000000b0031444673643sm1180135wrp.57.2023.07.20.05.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:43 -0700 (PDT)
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
Subject: [patch net-next v2 08/11] devlink: introduce set of macros and use it for split ops definitions
Date: Thu, 20 Jul 2023 14:18:26 +0200
Message-ID: <20230720121829.566974-9-jiri@resnulli.us>
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

The split ops structures for all commands look pretty much the same.
The are all using the same/similar callbacks.

Introduce a set of macros to make the code shorter and also avoid
possible future copy&paste mistakes and inconsistencies.

Use this macros for already converted commands.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 136 ++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 70 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index cabebff6e7a7..3dae9303cfa7 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -232,77 +232,73 @@ int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+#define __DEVL_NL_OP_DO(cmd_subname, doit_subname, pre_doit_suffix, _validate,	\
+			_maxattr, _policy)					\
+	{									\
+		.cmd = DEVLINK_CMD_##cmd_subname,				\
+		.pre_doit = devlink_nl_pre_doit_##pre_doit_suffix,		\
+		.doit = devlink_nl_cmd_##doit_subname##_doit,			\
+		.post_doit = devlink_nl_post_doit,				\
+		.flags = GENL_CMD_CAP_DO,					\
+		.validate = _validate,						\
+		.maxattr = _maxattr,						\
+		.policy	= _policy,						\
+	}
+
+#define __DEVL_NL_OP_DUMP(cmd_subname, _validate, _maxattr, _policy)		\
+	{									\
+		.cmd = DEVLINK_CMD_##cmd_subname,				\
+		.dumpit = devlink_nl_instance_iter_dumpit,			\
+		.flags = GENL_CMD_CAP_DUMP,					\
+		.validate = _validate,						\
+		.maxattr = _maxattr,						\
+		.policy	= _policy,						\
+	}
+
+#define __DEVL_NL_OP_LEGACY_DO(cmd_subname, doit_subname, pre_doit_suffix,	\
+			       validate)					\
+	__DEVL_NL_OP_DO(cmd_subname, doit_subname, pre_doit_suffix, validate,	\
+			DEVLINK_ATTR_MAX, devlink_nl_policy)
+
+#define __DEVL_NL_OP_LEGACY_DUMP(cmd_subname, validate)				\
+	__DEVL_NL_OP_DUMP(cmd_subname, validate,				\
+			  DEVLINK_ATTR_MAX, devlink_nl_policy)
+
+#define DEVL_NL_OP_LEGACY_DO(cmd_subname, doit_subname, pre_doit_suffix)	\
+	__DEVL_NL_OP_LEGACY_DO(cmd_subname, doit_subname, pre_doit_suffix,	\
+			       GENL_DONT_VALIDATE_STRICT)
+
+#define DEVL_NL_OP_LEGACY_DUMP(cmd_subname)					\
+	__DEVL_NL_OP_LEGACY_DUMP(cmd_subname, GENL_DONT_VALIDATE_DUMP_STRICT)
+
+#define DEVL_NL_OP_LEGACY_STRICT_DO(cmd_subname, doit_subname, pre_doit_suffix)	\
+	__DEVL_NL_OP_LEGACY_DO(cmd_subname, doit_subname, pre_doit_suffix, 0)
+
+#define DEVL_NL_OP_LEGACY_STRICT_DUMP(cmd_subname)				\
+	__DEVL_NL_OP_LEGACY_DUMP(cmd_subname, 0)
+
+#define DEVL_NL_OP_DO(cmd_subname, doit_subname, pre_doit_suffix,		\
+		      maxattr, policy)						\
+	__DEVL_NL_OP_DO(cmd_subname, doit_subname, pre_doit_suffix, 0,		\
+			maxattr, policy)
+
+#define DEVL_NL_OP_DUMP(cmd_subname, maxattr, policy)			\
+	__DEVL_NL_OP_DUMP(cmd_subname, 0, maxattr, policy)
+
 static const struct genl_split_ops devlink_nl_split_ops[] = {
-	{
-		.cmd = DEVLINK_CMD_PORT_GET,
-		.pre_doit = devlink_nl_pre_doit_port,
-		.doit = devlink_nl_cmd_port_get_doit,
-		.post_doit = devlink_nl_post_doit,
-		.flags = GENL_CMD_CAP_DO,
-		.validate = GENL_DONT_VALIDATE_STRICT,
-		.maxattr = DEVLINK_ATTR_MAX,
-		.policy	= devlink_nl_policy,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_GET,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		.flags = GENL_CMD_CAP_DUMP,
-		.validate = GENL_DONT_VALIDATE_DUMP,
-		.maxattr = DEVLINK_ATTR_MAX,
-		.policy	= devlink_nl_policy,
-	},
-	{
-		.cmd = DEVLINK_CMD_PARAM_GET,
-		.pre_doit = devlink_nl_pre_doit_simple,
-		.doit = devlink_nl_cmd_param_get_doit,
-		.post_doit = devlink_nl_post_doit,
-		.flags = GENL_CMD_CAP_DO,
-		.validate = GENL_DONT_VALIDATE_STRICT,
-		.maxattr = DEVLINK_ATTR_MAX,
-		.policy	= devlink_nl_policy,
-	},
-	{
-		.cmd = DEVLINK_CMD_PARAM_GET,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		.flags = GENL_CMD_CAP_DUMP,
-		.validate = GENL_DONT_VALIDATE_DUMP,
-		.maxattr = DEVLINK_ATTR_MAX,
-		.policy	= devlink_nl_policy,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
-		.pre_doit = devlink_nl_pre_doit_port_optional,
-		.doit = devlink_nl_cmd_health_reporter_get_doit,
-		.post_doit = devlink_nl_post_doit,
-		.flags = GENL_CMD_CAP_DO,
-		.validate = GENL_DONT_VALIDATE_STRICT,
-		.maxattr = DEVLINK_ATTR_MAX,
-		.policy	= devlink_nl_policy,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		.flags = GENL_CMD_CAP_DUMP,
-		.validate = GENL_DONT_VALIDATE_DUMP,
-		.maxattr = DEVLINK_ATTR_MAX,
-		.policy	= devlink_nl_policy,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_GET,
-		.pre_doit = devlink_nl_pre_doit_simple,
-		.doit = devlink_nl_cmd_trap_get_doit,
-		.post_doit = devlink_nl_post_doit,
-		.flags = GENL_CMD_CAP_DO,
-		.maxattr = DEVLINK_ATTR_MAX,
-		.policy	= devlink_nl_policy,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_GET,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		.flags = GENL_CMD_CAP_DUMP,
-		.maxattr = DEVLINK_ATTR_MAX,
-		.policy	= devlink_nl_policy,
-	},
+	DEVL_NL_OP_LEGACY_DO(PORT_GET, port_get, port),
+	DEVL_NL_OP_LEGACY_DUMP(PORT_GET),
+	DEVL_NL_OP_LEGACY_DO(PARAM_GET, param_get, simple),
+	DEVL_NL_OP_LEGACY_DUMP(PARAM_GET),
+	DEVL_NL_OP_LEGACY_DO(HEALTH_REPORTER_GET, health_reporter_get,
+			     port_optional),
+	DEVL_NL_OP_LEGACY_DUMP(HEALTH_REPORTER_GET),
+	DEVL_NL_OP_LEGACY_STRICT_DO(TRAP_GET, trap_get, simple),
+	DEVL_NL_OP_LEGACY_STRICT_DUMP(TRAP_GET),
+	/* For every newly added command put above this line the set of macros
+	 * DEVL_NL_OP_DO and DEVL_NL_OP_DUMP should be used. Note that
+	 * there is an exception with non-iterator dump implementation.
+	 */
 };
 
 struct genl_family devlink_nl_family __ro_after_init = {
-- 
2.41.0


