Return-Path: <netdev+bounces-23258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73776B734
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A311C20F26
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E12514C;
	Tue,  1 Aug 2023 14:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D322F1F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:17 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E6DC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-986d8332f50so824599166b.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690899554; x=1691504354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0V95E+E9v5A3LYct/pBl2OmVmab1G7YRAMVTHMnX1c=;
        b=pVypkHHDj4voxPFOEms19NfXxCBaVbukv883aFy+Gljtem0GAyY6Ox97zFcx3LU+15
         09w9i2/kPC1BQ8hupWiB9vwJ2sQ3JnQDgnykuSuVLnzK28w5ZO9wwHgDPI9vW+Ld/et/
         AxQIioqS8es6IDDn1w04i5xL77UdsJQzBhSeAAkQ7ufy0bzOGCYhDE0bAsF1iFzJ6l8G
         6hApywc4YHODhsekVkuExKeARKf7E2B74Dj5FPun0LHlYWt2guaKl8DsEj6vMhoDooTF
         f3KMHQASTvvMezZ31dQCCk2qGawOtYob8lYjj4YIwKmqogzaJcqhjpsg0nDTmwlVOyGW
         0CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899554; x=1691504354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0V95E+E9v5A3LYct/pBl2OmVmab1G7YRAMVTHMnX1c=;
        b=ewl7uN5IbO5yBMACvQdYqj41xtwGkBBYYO5EyV/MQ/PvYiOQ1TOqqTF7Dy17fD3okQ
         xXWXMtOo9DY7Gzodlt/V3A6fA0ksMfDlakxoT6ADKRSwc05uTMGPwzpXxk9c6MdKoQbI
         5yXaQcXqIuY0xqTxyOc9Xjre5GLS8XyHLN5zPJgWSScsbME32X48MnKqSI2uxbAVUH+z
         MHB0UnclOXpyxoAXYRwR8Jzzmumt/Vljl46JZQHXlaJJs1cjeESz4pVfPVJXEIYe+jfB
         7O04zfMiSCVgI4dpUJPGj4iKuWDK+vN6mvW94NHrDljpC7BWcVjbTIC9ACBsXs8P39RL
         IgMg==
X-Gm-Message-State: ABy/qLZcLfP0pF9XyEL3AUwv4OxIVvQ4AsijZMuiJBCyfN7DcIRdJKXG
	DIArTV27slSfIIZUX7zc8SCznLDVieuXwMWreoIbTw==
X-Google-Smtp-Source: APBJJlGLcBjFpMnpeVpmsVEGyQ2nzgFqS644ujIIR9CXxnh26bjyXgEDpbEB1ahqHHtEzYiuzH69Ew==
X-Received: by 2002:a17:907:75f2:b0:99b:7f52:ccd5 with SMTP id jz18-20020a17090775f200b0099b7f52ccd5mr2743246ejc.10.1690899554329;
        Tue, 01 Aug 2023 07:19:14 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id e6-20020a1709067e0600b00992b66e54e9sm7693129ejr.214.2023.08.01.07.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:19:13 -0700 (PDT)
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
Subject: [patch net-next 3/8] devlink: rename devlink_nl_ops to devlink_nl_small_ops
Date: Tue,  1 Aug 2023 16:19:02 +0200
Message-ID: <20230801141907.816280-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801141907.816280-1-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
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

In order to avoid name collision with the generated split ops array
which is going to be introduced as a follow-up patch, rename
the existing ops array to devlink_nl_small_ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h | 2 +-
 net/devlink/leftover.c      | 2 +-
 net/devlink/netlink.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 62921b2eb0d3..c67f074641d4 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -119,7 +119,7 @@ struct devlink_cmd {
 			struct netlink_callback *cb);
 };
 
-extern const struct genl_small_ops devlink_nl_ops[56];
+extern const struct genl_small_ops devlink_nl_small_ops[56];
 
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 5128b9c7eea8..8f42f1f45705 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6278,7 +6278,7 @@ static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 	return devlink_trap_policer_set(devlink, policer_item, info);
 }
 
-const struct genl_small_ops devlink_nl_ops[56] = {
+const struct genl_small_ops devlink_nl_small_ops[56] = {
 	{
 		.cmd = DEVLINK_CMD_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 7a332eb70f70..82a3238d5344 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -243,8 +243,8 @@ struct genl_family devlink_nl_family __ro_after_init = {
 	.pre_doit	= devlink_nl_pre_doit,
 	.post_doit	= devlink_nl_post_doit,
 	.module		= THIS_MODULE,
-	.small_ops	= devlink_nl_ops,
-	.n_small_ops	= ARRAY_SIZE(devlink_nl_ops),
+	.small_ops	= devlink_nl_small_ops,
+	.n_small_ops	= ARRAY_SIZE(devlink_nl_small_ops),
 	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
 	.mcgrps		= devlink_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
-- 
2.41.0


