Return-Path: <netdev+bounces-23990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D78376E69C
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D6428207F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C33D1F176;
	Thu,  3 Aug 2023 11:14:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B31DDF6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:14:03 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE171DF
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:14:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdd262bb0so119701766b.3
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061240; x=1691666040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYAfhr+kIZLqFF0wZYJ8uWRcm1Dn7Z+b4KAI90SijJI=;
        b=hw0MOexoVs+iXBXBEraatRJkFiIN4SY4SocJd9Sz3K0Mm+fu1C3SyCAs59iMsjFQNs
         O9kqICyxr7aE4Kq/hD1oqpW7pCX0l3gAJURKNPayGdzDMgliCXjOIunCFcq53Nvz0mze
         hFzja2F7B+Z5s6wrxQDFp0mNyJPNSYW4/xteHlLE2EDLfov1ol4bVv8ODZ0hIpYzT/jm
         qU8IME5XYwXDTV2nw8cnxlbB/J+TDvwWXU66BOXIW5x9j7kIku/RvpiIkFf37WMLr1pv
         81vrotKoO3kYUG8XB1p7gANn1G0Qo6M3cUrn/0YXsa13o7k4JCVLowrew5nJdsMArD4e
         QHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061240; x=1691666040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYAfhr+kIZLqFF0wZYJ8uWRcm1Dn7Z+b4KAI90SijJI=;
        b=eafuYLQAIHQ0uPpZ1U3+f37PbKB6r1NoDl68NweIM+/3Z5R98l4E+2xRrUCBSW3Idp
         8ECSHecVnzk32czoWIl6ubmkNw4Qm/pH8gRnfuWsLZPYSK8RL7w8srWP3L3lIRUSyVIy
         SaHWghh2y/m20UZqpiavF7v3QQ6m34kiGXOrB/QK+Grg+PGdn/0H5SmiHE9m579V3+eQ
         8eFSbrRdODRDVs8Mzehfj0HeqUwPfGHI/aO3d4xfuki0AoYkgBXEpFClBrdfwA2UhTwR
         wAm6xqU9oy/CVFx9kfAs49Gn1bQ7annrIUQBrwbHgULa+KvogrTVR+s2pUhM6X4Ku5/Q
         lZ8g==
X-Gm-Message-State: ABy/qLYv347acpkpQsDsog/HN85wjcRyVkiqJ8CyRWPQyW9T4ib5D42D
	ognUXqw9TuHjhvSCweTbJlNvOeDIpoVlzfnmgfFVoA==
X-Google-Smtp-Source: APBJJlFNt3zNTDd8n30+hBOsGttW/2vpuyETIbjQTMk9IfZfTEZpOCRSIWrvyPdbpbv4igQUtU3Q8w==
X-Received: by 2002:a17:906:220c:b0:992:7594:e6b2 with SMTP id s12-20020a170906220c00b009927594e6b2mr6855198ejs.77.1691061240375;
        Thu, 03 Aug 2023 04:14:00 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709065a8c00b00992b2c5598csm10385936ejq.128.2023.08.03.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:59 -0700 (PDT)
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
Subject: [patch net-next v3 12/12] devlink: use generated split ops and remove duplicated commands from small ops
Date: Thu,  3 Aug 2023 13:13:40 +0200
Message-ID: <20230803111340.1074067-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803111340.1074067-1-jiri@resnulli.us>
References: <20230803111340.1074067-1-jiri@resnulli.us>
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

Do the switch and use generated split ops for get and info_get commands.
Remove those from small ops array.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  2 +-
 net/devlink/leftover.c      | 16 +---------------
 net/devlink/netlink.c       |  2 ++
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 51de0e1fc769..7fdd956ff992 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -124,7 +124,7 @@ struct devlink_cmd {
 	devlink_nl_dump_one_func_t *dump_one;
 };
 
-extern const struct genl_small_ops devlink_nl_small_ops[56];
+extern const struct genl_small_ops devlink_nl_small_ops[54];
 
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 895b732bed8e..3bf42f5335ed 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6278,14 +6278,7 @@ static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 	return devlink_trap_policer_set(devlink, policer_item, info);
 }
 
-const struct genl_small_ops devlink_nl_small_ops[56] = {
-	{
-		.cmd = DEVLINK_CMD_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_get_doit,
-		.dumpit = devlink_nl_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
+const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6533,13 +6526,6 @@ const struct genl_small_ops devlink_nl_small_ops[56] = {
 		.dumpit = devlink_nl_cmd_region_read_dumpit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_INFO_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_info_get_doit,
-		.dumpit = devlink_nl_info_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 98d5c6b0acd8..bada2819827b 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -248,6 +248,8 @@ struct genl_family devlink_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.small_ops	= devlink_nl_small_ops,
 	.n_small_ops	= ARRAY_SIZE(devlink_nl_small_ops),
+	.split_ops	= devlink_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(devlink_nl_ops),
 	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
 	.mcgrps		= devlink_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
-- 
2.41.0


