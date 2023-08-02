Return-Path: <netdev+bounces-23686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3A176D1D0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B94B281DB8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01A1F9F8;
	Wed,  2 Aug 2023 15:21:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2793F9EC
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:28 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EF42D72
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:21:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso35880105e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989644; x=1691594444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYAfhr+kIZLqFF0wZYJ8uWRcm1Dn7Z+b4KAI90SijJI=;
        b=xhmgeH32pgHr9MQc6gGwGqddLTLlil0p8kufx1JtjdHbt0zhMLvzZ75p7jRS8BGPs3
         I6lwY7iR12qxXPSsTtlLYGHE7TEDFwxHTuIBB1HYz15Giu6xwBhUaDr6hG6sh44BPbfz
         aZpTyVuFtO2fq+iPnwsNovUMb30kQ6y1VsUhaQVzUC0Dam7npUtU9Oou6RQLWaxPKejB
         LGpJu+05j45af22/FVUvWVZRVrzu1lhd/pZkFX+zRLocZjRZ7xAufudtIWt/AvR4+R2z
         mWRGIgKTUTpHUddwmKjBAAim+QxvApWV4IQweRijvkLiqyzsKDx4ZLPGUX63OfE6elpt
         FkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989644; x=1691594444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYAfhr+kIZLqFF0wZYJ8uWRcm1Dn7Z+b4KAI90SijJI=;
        b=OJuKmSoFn9VwHa2/zJMxdUdYa4EldvssFDrSeUrhEqWYjgIl/8YsvjNxtzf/eORQpr
         zW2frRNGvAUBYaICinONrqGy+qdE452BHwVkRWmKKRiOKrJ557/oeJafMK6iohDzy8R2
         8aoK1lqq/SaB3W+5U3JV8lcyYxd1qlbSpAkDzzm2FZRuFOEBTnFwCcxN5ANa89QxKY0w
         9Ca2asUIcTM2HFUiYTGjxF5DOCjkJI0/MuRrJwSbT4+pJhvrmb4Tb76PkTZgKd3S3EWq
         8CR+pneSC/5MlERXrbSe38FUTKMvx/2T1VHavIA6rH246YiUrmZhj+BbietDg7Gh7jwO
         9b7Q==
X-Gm-Message-State: ABy/qLaTZNYsX4OUOwmmjgkA5w/3FRBiKpsGLh/PbxXFXccBbbzVNzHw
	Yk6x/j46uT/BUAlGGsLqDfzSM70cji/vM4FxySasNA==
X-Google-Smtp-Source: APBJJlG8nTY6/YXT3H8MzinVxAwDebc6iKgbfGVdqn/EVDx53mS6kCGRex9LGPvgMOwzOF1RcSIE+Q==
X-Received: by 2002:adf:e883:0:b0:317:6e08:ed35 with SMTP id d3-20020adfe883000000b003176e08ed35mr5496988wrm.1.1690989644054;
        Wed, 02 Aug 2023 08:20:44 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b003177074f830sm19163075wrr.59.2023.08.02.08.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:43 -0700 (PDT)
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
Subject: [patch net-next v2 11/11] devlink: use generated split ops and remove duplicated commands from small ops
Date: Wed,  2 Aug 2023 17:20:23 +0200
Message-ID: <20230802152023.941837-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802152023.941837-1-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
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


