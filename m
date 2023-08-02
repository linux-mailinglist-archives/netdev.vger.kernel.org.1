Return-Path: <netdev+bounces-23680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E44876D1C0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28732281E52
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A32D30F;
	Wed,  2 Aug 2023 15:21:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C9D514
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:21 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DAF4EDE
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso14723575e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989634; x=1691594434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0V95E+E9v5A3LYct/pBl2OmVmab1G7YRAMVTHMnX1c=;
        b=OKecDwoNWfTWNqGZpWcOBBH7F2W0mJ5Iei0oNHcsoBLGDgtzPtHUIcJqY3dhZJqyxn
         vqwdU3cF4Wr9Qnr573YPdSs+Xz2e37bjKBY4MudvOsmA/wikmtiYmMjrkcfycNvB/4Cz
         MT9aBzswGKO2V1yGrWAzpoacZyZc3ZuXF61joQiGMlgi6Getqqe9ci3g/ZsHG+ioAdm4
         K6LUL6X8yziNV8rB+9XPi6T+/dCDHhSEtBHUbnnC+VDMSR+vK2eJU1oV19YK0Xeb36AR
         a1fAohjL033mhKSI/u1GD5WlWtGD8yL2Lj3eH4ctQ+JiUnqodbMGEhZ+afKDjFFq6ptf
         YxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989634; x=1691594434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0V95E+E9v5A3LYct/pBl2OmVmab1G7YRAMVTHMnX1c=;
        b=D5Lp2Gc8y+j4YmmnOzZVlJMKN2HthE2larfMYqAKhLvFvOtjEsLjisgqbDkYXCz5Cc
         ljqVK8uo0WNSDIRIWBjRKpNEZ7Q0X3z3X/Bdk7M50sTDyJRVLqkyWsb5w+Jqk9/g8dyP
         UAR9QTjsykWP/PrZIJiBMu3Xn7NArbsIVEwk/hv0ArWmd2LKxKwT1BmtBauZ5rQvtMvi
         7EkoLi3ujCISRQVXfFo3yuuw/g8ZSlFrDKavF32aC8uCgnW0fIxZUnBuwa5Uc6xR4Zl9
         AxDwatuvLcL3q/CE2MssFjp3pfWVhbAH3HcZXaVaWfE5FZCPdsIjmhTUHzt/0FH/bSQd
         FsTA==
X-Gm-Message-State: ABy/qLb2r7vVpkLsNx5s4seSjDw+cI7pitPGFRoP6hc75MA+EP/9ETJJ
	ItZ3AyAMaiWCV1MYxXOfaDI7s76qzvdR7utaZ4q07A==
X-Google-Smtp-Source: APBJJlGjN06Slmc0PRLrf23JzhdT/hc72QHo3LNnKqCFuTBqDjTxYKU/BTPOFY4RGw9XeGwzIDN8sg==
X-Received: by 2002:adf:fe51:0:b0:317:5f04:c3de with SMTP id m17-20020adffe51000000b003175f04c3demr5356255wrs.4.1690989634130;
        Wed, 02 Aug 2023 08:20:34 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id p15-20020a056000018f00b0030ae53550f5sm19211086wrx.51.2023.08.02.08.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:33 -0700 (PDT)
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
Subject: [patch net-next v2 05/11] devlink: rename devlink_nl_ops to devlink_nl_small_ops
Date: Wed,  2 Aug 2023 17:20:17 +0200
Message-ID: <20230802152023.941837-6-jiri@resnulli.us>
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


