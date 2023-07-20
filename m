Return-Path: <netdev+bounces-19489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6245875AE30
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935DC1C213E9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AA182D4;
	Thu, 20 Jul 2023 12:18:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F6182A9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:41 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5785E2106
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so606742f8f.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855519; x=1690460319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmEdpWHeF8GWphuFHjL0WVrMSMYpJbqUJBQiBFOHlys=;
        b=GkzC0s2WM9fC4NsiKzbg2ieucKj5zd1Gsu76ADS39eyoXlShNs8vTODwcfb9HPkoUj
         3yTqF/LUADmTK7dP4+5Ox/uXZYRvKBwb/31PcSkZjT6vMOM+DJtJ8ef9kHXdsabbXucu
         0BhSXBMZlV763WZACbpag52OwI71ishF58jVZNy29JAfQaeJz/VsVlmXQKzgSSkkeghP
         xz6gFUVAyYyVg6q/pUPVdIFlzV4fSGMZN49ybsUlmDjKSSQLSEaakXgXG/Q6A0FOmrYP
         f1vDKtxGDb7m1VndIzdXJKNBOz2QOZqADlFWdRDMWVeYNQK/UdN6GNHsskmIhsmn0E1N
         G+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855519; x=1690460319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmEdpWHeF8GWphuFHjL0WVrMSMYpJbqUJBQiBFOHlys=;
        b=f3TuFv2El5BbkFWWy4SOjLxy6HnSHzU9/0nCK1O47dRUw76PRi4wUOf3RBZt7HVixt
         1kCkOp8ccfIj4+H9ZqOnjMzLhiwo2DvorCi8ODSkXYxPhLDAVzNd5cvL9/YX8Pe5ubST
         VshqPSnFUoBYf26JSGuTLLyT8BpNM97GHGDcsGkgdQEAqRYbNHsnQISWe24N8/JL6OOV
         Tezn5NBLKS6oWCululgPfBnFmtOsROkwXu6c/3c6INuvWNMTW53CVMO5kWc1iPAoxXJj
         rRCkuiQqGm9I/ZN/ZYXfzzTy+MM2PJyqA61CmPbmhhAUN1IJikKz8eAMvGHGMS3ZHtyI
         LqRg==
X-Gm-Message-State: ABy/qLZzwXhMQ94iDUlqm1UykpTWDxjmFwemG09Bltpd+fqS5W1uqKU6
	DWLebbAadPfUfpT5Zoxg5qFIQ8mLH7AhlK9YB0U=
X-Google-Smtp-Source: APBJJlHWzE+atNm0Ejq71qj+fV2+OcvrxNE/7GqMPrSZgev5FTvINXCOFO7xkQWRCvMgwyl+aBPqeQ==
X-Received: by 2002:adf:e8cf:0:b0:311:162a:ce2a with SMTP id k15-20020adfe8cf000000b00311162ace2amr1988981wrn.29.1689855518889;
        Thu, 20 Jul 2023 05:18:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t7-20020a5d6a47000000b00313f7b077fesm1197112wrw.59.2023.07.20.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:38 -0700 (PDT)
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
Subject: [patch net-next v2 05/11] devlink: convert health reporter get command to split ops
Date: Thu, 20 Jul 2023 14:18:23 +0200
Message-ID: <20230720121829.566974-6-jiri@resnulli.us>
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

Do the conversion of health reporter get command to split ops.
Introduce devlink_nl_pre_doit_port_optional() helper to indicate
optional port object attribute parsing and use it
as pre_doit() callback.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  2 +-
 net/devlink/leftover.c      | 10 +---------
 net/devlink/netlink.c       | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 2870be150ee3..948b112c1328 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -116,7 +116,7 @@ struct devlink_cmd {
 			struct netlink_callback *cb);
 };
 
-extern const struct genl_small_ops devlink_nl_ops[55];
+extern const struct genl_small_ops devlink_nl_ops[54];
 
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 33f71e8fe8ee..262f3e49e87b 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6301,7 +6301,7 @@ static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 	return devlink_trap_policer_set(devlink, policer_item, info);
 }
 
-const struct genl_small_ops devlink_nl_ops[55] = {
+const struct genl_small_ops devlink_nl_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6550,14 +6550,6 @@ const struct genl_small_ops devlink_nl_ops[55] = {
 		.dumpit = devlink_nl_instance_iter_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index cd35fa637846..794370e4d04a 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -153,6 +153,13 @@ static int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_PORT);
 }
 
+static int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
+					     struct sk_buff *skb,
+					     struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
+}
+
 static void devlink_nl_post_doit(const struct genl_split_ops *ops,
 				 struct sk_buff *skb, struct genl_info *info)
 {
@@ -238,6 +245,24 @@ static const struct genl_split_ops devlink_nl_split_ops[] = {
 		.maxattr = DEVLINK_ATTR_MAX,
 		.policy	= devlink_nl_policy,
 	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
+		.pre_doit = devlink_nl_pre_doit_port_optional,
+		.doit = devlink_nl_cmd_health_reporter_get_doit,
+		.post_doit = devlink_nl_post_doit,
+		.flags = GENL_CMD_CAP_DO,
+		.validate = GENL_DONT_VALIDATE_STRICT,
+		.maxattr = DEVLINK_ATTR_MAX,
+		.policy	= devlink_nl_policy,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
+		.dumpit = devlink_nl_instance_iter_dumpit,
+		.flags = GENL_CMD_CAP_DUMP,
+		.validate = GENL_DONT_VALIDATE_DUMP,
+		.maxattr = DEVLINK_ATTR_MAX,
+		.policy	= devlink_nl_policy,
+	},
 };
 
 struct genl_family devlink_nl_family __ro_after_init = {
-- 
2.41.0


