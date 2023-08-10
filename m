Return-Path: <netdev+bounces-26348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF6B777961
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DC31C2156C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05A41F951;
	Thu, 10 Aug 2023 13:15:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC41E1C1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:15:52 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F1E10E6
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31768ce2e81so902951f8f.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673346; x=1692278146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJWI/nJj25ekoXeCxeUuHs5tuWlKM2ENFOQ/QLY/dY0=;
        b=TwFOCJfaOGDcMD63ZDGHAu9n+C75RlI2uio1tD1LSqeegLlofPvATeMYmh/q4OnkD3
         ntsM9r6y2228XNfXU5ycLV4rItIyArxKDfdfLH2mkKO/+UYuZ6q3jSi9PLB3ImKFf6oD
         xoAIUzXSEzorVrQXKV+wqHE550MqomG87U0DGEUcq93MhqqHaMmbCUSMs8fd9v7lwtzV
         W+cLRxBmWLA5FcESTQnLbq4ZKN2cA41swj27ME+8qTMNsWeBtQiUvnDMS6cq0Q4d8ne8
         6uwJcw1dwmy+FD+wzR/bAlNkzAvR/nmV1igE1shk7LeZ27F/BYeGJ+vW6S2fW9U7sib/
         V48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673346; x=1692278146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJWI/nJj25ekoXeCxeUuHs5tuWlKM2ENFOQ/QLY/dY0=;
        b=ejYl4zXw4gPSElOCOb0DsLXhpJ6TtT1H4qyA1VJf2z2VvkQ7TuVRpD5BhW2SaocXXL
         JAo2UlReoYj6sNA/r2R6ed216X3/otpPvhpF+cpNRM9tWkMDHb/U+x9BeRVhKFHCYffw
         NoLtERpAF4fjDAcjL0f4liHO9Rl9FEkHdzU3RBkwuMtg1NgwEm/jOLYyPxlL26tyS/aa
         4UELDhCX/muDBKagLkFz2L6pYzY6lv/lHkzbugF1Kz44wm07M3eaX+mp+MaygJBDfLnv
         BTvqmZVDXlmk8hkyUhfhuHlRrj6j60pZg8ozoPFHlDHxpQ+xL1qSAFdUQFnT3b1K5ESA
         JKNA==
X-Gm-Message-State: AOJu0YwbUhPtQCQsN0YS7a4DGZQm+gOupNTj0UXYscICM3VCMQLCMi8Z
	alO2vVadtq39loA28ZU0B1t65BNbB5MjcBuX7Np31g==
X-Google-Smtp-Source: AGHT+IEKumM5z5ZDQ9T1179QwvshFy0k9getWoGJkFWZcOAc/SlPcqQrvJ6x+5jIZWz7Sw0mU1JFtQ==
X-Received: by 2002:a5d:4385:0:b0:313:ee2e:dae5 with SMTP id i5-20020a5d4385000000b00313ee2edae5mr1979385wrq.21.1691673346395;
        Thu, 10 Aug 2023 06:15:46 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b0031766e99429sm2128254wrt.115.2023.08.10.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:15:45 -0700 (PDT)
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
Subject: [patch net-next v3 03/13] devlink: introduce devlink_nl_pre_doit_port*() helper functions
Date: Thu, 10 Aug 2023 15:15:29 +0200
Message-ID: <20230810131539.1602299-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810131539.1602299-1-jiri@resnulli.us>
References: <20230810131539.1602299-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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


