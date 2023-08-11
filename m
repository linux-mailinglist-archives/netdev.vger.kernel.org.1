Return-Path: <netdev+bounces-26855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F8779394
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D41C21495
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B607B329B2;
	Fri, 11 Aug 2023 15:57:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9E5692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:26 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CF12712
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-317b31203c7so1923418f8f.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769442; x=1692374242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJWI/nJj25ekoXeCxeUuHs5tuWlKM2ENFOQ/QLY/dY0=;
        b=ypph5+bRnh9R6qNoIBqdnKlZX9/yAYA0yDaOY8j1t5g3i2JaAPsTbP542F9CVSLXDL
         7wWN/IxsMBbkOIwUapiJZ4AiZq2sYjn+NWT+xZYv1GGhoVxCsjeqjafyuz08Q3Eq2qs8
         Y3J8XJ5tgtyZrQScT0zfbvElynSpCsYqCJRLzVuvleA8n4dfpmV2UvCcXZSHsHYRshOo
         s3b6zSc2KcX9/Om7KR1O8Wcn1ycM+ECjLaL2IhlP098rH7+a/ORJBmaKqt9vGNyauMmN
         SZLiQxomTpj7YUzI3YB3ZlqBMo+QwNYlOUOuPcxpNlCaPCMnDAtIM3D56wyw2K11QvCx
         EkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769442; x=1692374242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJWI/nJj25ekoXeCxeUuHs5tuWlKM2ENFOQ/QLY/dY0=;
        b=dzvTqlJ7qnnIvDyaVeW89bDTFbOd7ySk1GwqjFN5Tf/8bU7e/gbZKer7bWWU3l8zX6
         gcecGYQ/S8kZ7walJ0FiR09rGNExUrmMiALEN4RTI+YnWNJRrPmHwe5aXjmHH+MjExtC
         iH1lQgASgRIIqpI9bjZX1kjv6zOAf+DVf/gQbMyhhydkeIP6Mij1TEoLSZN281USIbs7
         +qjz0WR+QAWpqlhs5E5U757uoj8Um+GXRFGSN6IOEY5SnCAkaw+qIbCQYyXfqkSyE5Hk
         /OKrwSjvh5AYMdFQ+DuD1BHD1RUtpuN9fn1OP2WxohX4YVBIeap/1cpcXYK10XXoFye5
         RFfg==
X-Gm-Message-State: AOJu0YyNOYET3odONQPgJH0qN6TeBQemp0t3hhbLiq7pHPASZk/7M1dw
	DCrAK/pn47P12EBYhltwCIXJFuUch0Xeqyhd9oWsHg==
X-Google-Smtp-Source: AGHT+IFZlbesZlDjjcrJK36e4bQs4bAAo/KqwrCr9I+DqWFlO4KWioCoUwPwpB6p6DrWDxlLqQnlLg==
X-Received: by 2002:a5d:5183:0:b0:315:9e1b:4ea6 with SMTP id k3-20020a5d5183000000b003159e1b4ea6mr1835515wrv.58.1691769441292;
        Fri, 11 Aug 2023 08:57:21 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b0031801aa34e2sm5896042wrv.9.2023.08.11.08.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:20 -0700 (PDT)
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
Subject: [patch net-next v4 03/13] devlink: introduce devlink_nl_pre_doit_port*() helper functions
Date: Fri, 11 Aug 2023 17:57:04 +0200
Message-ID: <20230811155714.1736405-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811155714.1736405-1-jiri@resnulli.us>
References: <20230811155714.1736405-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Define port handling helpers what don't rely on internal_flags.
Have __devlink_nl_pre_doit() to accept the flags as a function arg and
make devlink_nl_pre_doit() a wrapper helper function calling it.
Introduce new helpers devlink_nl_pre_doit_port() and
devlink_nl_pre_doit_port_optional() to be used by split ops in follow-up
patch.

Note that the function prototypes are temporary until the generated ones
will replace them in a follow-up patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- added devlink_nl_pre_doit_port_*() functions definition
- adjusted patch name and description
---
 net/devlink/devl_internal.h |  5 +++++
 net/devlink/netlink.c       | 27 +++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index ca04e4ee9427..9851fd48ab59 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -205,6 +205,11 @@ int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 			     struct netlink_ext_ack *extack);
 
 /* Devlink nl cmds */
+int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
+			     struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
+				      struct sk_buff *skb,
+				      struct genl_info *info);
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 96cf8a1b8bce..3c59b9c49150 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -109,8 +109,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 	return ERR_PTR(-ENODEV);
 }
 
-int devlink_nl_pre_doit(const struct genl_split_ops *ops,
-			struct sk_buff *skb, struct genl_info *info)
+static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
+				 u8 flags)
 {
 	struct devlink_port *devlink_port;
 	struct devlink *devlink;
@@ -121,14 +121,14 @@ int devlink_nl_pre_doit(const struct genl_split_ops *ops,
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
@@ -141,6 +141,25 @@ int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 	return err;
 }
 
+int devlink_nl_pre_doit(const struct genl_split_ops *ops,
+			struct sk_buff *skb, struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, ops->internal_flags);
+}
+
+int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
+			     struct sk_buff *skb, struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_PORT);
+}
+
+int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
+				      struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
+}
+
 void devlink_nl_post_doit(const struct genl_split_ops *ops,
 			  struct sk_buff *skb, struct genl_info *info)
 {
-- 
2.41.0


