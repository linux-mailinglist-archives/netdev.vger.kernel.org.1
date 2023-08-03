Return-Path: <netdev+bounces-23983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D18D76E68F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27B81C20282
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D111E501;
	Thu,  3 Aug 2023 11:13:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6651DDFD
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:54 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB302D54
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c0cb7285fso109793766b.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061229; x=1691666029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0V95E+E9v5A3LYct/pBl2OmVmab1G7YRAMVTHMnX1c=;
        b=ad5+079NGe28kGw9icG+l221TNNaYDnYa9kYmd12QkPp8kQXSFa3WeTK1BRVxfMn2+
         a20YvSz7TiJ0nYqZMUxOrZwSlN/V0DL7+YwjIgitTzzbcftC0OTX/anQYWjuYR2Dz2Bo
         3/kF3nknsiYvmM8LYGf2tOGWJX9AVy+c7+ywNQLiW3U+D6FdpwloMpH3O+mrJb5NC6rr
         3EvE6W6Or99Lzb2ZsycAEJ64G/me9KA7ZJP0zzHlV6OW04apabRzHqRiKzFKOhx/3f7r
         sslh9aQxZAwPBqBH+aEw8yCxGP8ivHDLskgF733CwcvhAeELLcLbwG7lElBCmKDQDl0S
         /eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061229; x=1691666029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0V95E+E9v5A3LYct/pBl2OmVmab1G7YRAMVTHMnX1c=;
        b=HzAtZuRKE+XGz9hm+dyYF79c4mCOnZwyXJbdgvVCIkX1cf1FNZprzbAUTGUDt5+Zo3
         ny0mlaRF1O9kYvCajRDQRCTgGj1bqNh5yFhbNdjN3956YhWUBcvctEzPUwpAD500pPBK
         ANRpDdIyzamk3jhymlTxhDvnDGmrLAg/9lnEtHbPkK4eNtRTYaVtIbBo1KG7vA3wzkc+
         J2f/MXCQ+/HM/62LE5xTHKuf4Z/I9cz9GzSKCmYZiDzN1YUfpZ8vxnDFGhwUwW+gmdkE
         8TC651X+gD2ZROpmXLaPCI7GIYU7C9ld8ogw+I8ZcKMCnGcnFVXJKrAzppr+JxottWyd
         aLJw==
X-Gm-Message-State: AOJu0YxH74hgznra5MVq3hJz/+0CpLS87jfXrY1A1YVz5ppo8LwMd4N0
	1FoGtX7lS9GkUKFDE1BJY1uYqrunnL7ZXlERWxMwiA==
X-Google-Smtp-Source: AGHT+IH1FpSdfWO+jvw4mmgko5gFnwzbQ2BShxobyNXGRuBXuohoiVy7V/JlMwREAPcl748min9MnA==
X-Received: by 2002:a17:906:314b:b0:99c:4a29:f304 with SMTP id e11-20020a170906314b00b0099c4a29f304mr3520219eje.34.1691061229684;
        Thu, 03 Aug 2023 04:13:49 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906495700b0098748422178sm10355652ejt.56.2023.08.03.04.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:49 -0700 (PDT)
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
Subject: [patch net-next v3 05/12] devlink: rename devlink_nl_ops to devlink_nl_small_ops
Date: Thu,  3 Aug 2023 13:13:33 +0200
Message-ID: <20230803111340.1074067-6-jiri@resnulli.us>
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


