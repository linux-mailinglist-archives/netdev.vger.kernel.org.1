Return-Path: <netdev+bounces-19487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92E75AE2E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F01281DC5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59EA182AA;
	Thu, 20 Jul 2023 12:18:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF08182A9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:39 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E732106
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so6298225e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855515; x=1690460315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d+tR6uSf/87DNnoqjV0r7jwvenZOCziKxtTsdd31WI=;
        b=cWs4Kj0qfETc/oA/OjsRni/E4S/1iVu/gSmcj/2qWSnXsW8Iah6aAVL8Q+AY1FCPlI
         CxP0wSx1/RuA1t+fVzmHIO2cS6d3onJv/ghBE4ADB4pmzekhZNAtENYvXzugG+RHsHai
         sTW6y5OcA67anyOYwkWJh2kbpXUhjT2NXCXlPH1HsAu9GORGz6xaSSAWghQTXH2Awh52
         IkbT6yzqWeG10FIEVkjVxdwuI7DZr2ps3eKqWLoomw0hh8dnOK9GT3aUFjHfZP/ejW3E
         UgLjH6OXJznm9iBJ8Wl/goGIlSYe2Zhjck7LKLS6zscf6ctQdwNcapVGRjbn31g97qbF
         Ft/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855515; x=1690460315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d+tR6uSf/87DNnoqjV0r7jwvenZOCziKxtTsdd31WI=;
        b=a9H4hH7ZVRxefiTemI0SG0Srl5ZtMYE+BSrNrIxuFwPytGtnQ1N7K94hOUt1fDho82
         AA5/l0N+Un8Bbsz3WIOEJ5/ArWZdQAjZK/AIaDTY8Or7JtKLj9R3ZS2xZy26jvr2SYBu
         JRp18AmcgXSNcW9nQCIuoUtMYxMT/+f1ECvG2HsqUc/DpabUBe62L0A4QtPaggZRx3lg
         n95tW04OCXayokP/qKwEdMDz3LLNxe9hEeFrhjpoubkhAPQa7CEEtRFpNvMOxgmRHlSQ
         cdlY8028MYlaxMh9r8U5uiI7VfZ+v5XVykhNQ7N3KdjovIVveRaKjK7I14Ivk0EKKnuQ
         LBqQ==
X-Gm-Message-State: ABy/qLYe8iSk1uyhzP7awJkhFmaDu8G9PHTGiHGAB4MtZg3fYl1s+Xl0
	p4erhHfbodfgNLW8zpWCBTddjClON/9kqvf5YEY=
X-Google-Smtp-Source: APBJJlHpZ3jJzuG1AR3+nkQkpbWM27kXGUCTQAs2gvocY6aQL23LsEecwJrdHD+Nbyu4u1yNLw/qQg==
X-Received: by 2002:a7b:cd9a:0:b0:3fa:97b3:7ce0 with SMTP id y26-20020a7bcd9a000000b003fa97b37ce0mr1620545wmj.26.1689855515728;
        Thu, 20 Jul 2023 05:18:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b003fc04d13242sm3815347wmq.0.2023.07.20.05.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:35 -0700 (PDT)
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
Subject: [patch net-next v2 03/11] devlink: introduce __devlink_nl_pre_doit() with internal flags as function arg
Date: Thu, 20 Jul 2023 14:18:21 +0200
Message-ID: <20230720121829.566974-4-jiri@resnulli.us>
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

To be able define pre_doit() helpers what don't rely on internal_flags
in the follow-up patches, have __devlink_nl_pre_doit() to accept the
flags as a function arg and make devlink_nl_pre_doit() a wrapper helper
function calling it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 336f375f9ff6..f1a5ba0f6deb 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -109,8 +109,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 	return ERR_PTR(-ENODEV);
 }
 
-static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
-			       struct sk_buff *skb, struct genl_info *info)
+static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
+				 u8 flags)
 {
 	struct devlink_port *devlink_port;
 	struct devlink *devlink;
@@ -121,14 +121,14 @@ static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 		return PTR_ERR(devlink);
 
 	info->user_ptr[0] = devlink;
-	if (ops->internal_flags & DEVLINK_NL_FLAG_NEED_PORT) {
+	if (flags & DEVLINK_NL_FLAG_NEED_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
 		if (IS_ERR(devlink_port)) {
 			err = PTR_ERR(devlink_port);
 			goto unlock;
 		}
 		info->user_ptr[1] = devlink_port;
-	} else if (ops->internal_flags & DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT) {
+	} else if (flags & DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
 		if (!IS_ERR(devlink_port))
 			info->user_ptr[1] = devlink_port;
@@ -141,6 +141,12 @@ static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 	return err;
 }
 
+static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
+			       struct sk_buff *skb, struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, ops->internal_flags);
+}
+
 static void devlink_nl_post_doit(const struct genl_split_ops *ops,
 				 struct sk_buff *skb, struct genl_info *info)
 {
-- 
2.41.0


