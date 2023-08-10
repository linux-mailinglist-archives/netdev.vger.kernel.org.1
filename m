Return-Path: <netdev+bounces-26345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E169777958
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE01B1C21506
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4F31E1CA;
	Thu, 10 Aug 2023 13:15:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A51E1C1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:15:45 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AE810E7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so8174505e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673343; x=1692278143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS4maoKCErTkiOhuvBGkMIGUBJDDkZ9nPNgJbvrjAc0=;
        b=3LtM02PcQBqZfHeeY6X5fojOakVa0l5DON4VSXHUlgz/0D7E+rKrAhXhW+FaEQmTFY
         7naDmxHBFqeB/Xe80NdImz+CisfDFnp2WLnMYZw8ZfEL02iZqbbNI3ytuxajCbsRjkoP
         CHT1w7IOgmZ6UHSTsbweCsYJhP5mpYnlqlOiAkB8VCdaD4/71SddaxP8TvHkkbJ7gKAE
         RDBqqEVIxEeCD00WqC4MDx6CZ08Zti4YHcayrWovozbzmAEnC4MMJnG0XWsGEzF+GV1m
         WNWs78UDJeURSHMegwhLJd/A9RiuFpt17PtL5pcK8WEiUqLD74fsNI6MAAkewiO9dGBy
         hvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673343; x=1692278143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS4maoKCErTkiOhuvBGkMIGUBJDDkZ9nPNgJbvrjAc0=;
        b=MJEGzkGecghREO2TJs/VDimsEeYIWvIKnt1evdqwJATtxeXa5OGtFdNS14ySX1z9JH
         DB5bZr5WyZXt0BaUqSPKEX4XGu+oS1pCIzj1ahlg6AAtbtnQ6k6JUu/D0dyu63aPzhmT
         TQu+ADniZiLhQXwG2NUINJFF7jO4Fc2V3xjxwUqZHrsUhMRKmm/xCc9tU4n/uFeV3vDc
         45SbbbecX68vb/R6qYT3G1IOzzynnXLOIe5/0x0XG/6ZIjrGDond1RgJCAKIFWbnZoNZ
         ct11KJJMXnzcn2Q9hOPtg/zeUML+ncBTUeCWSo7+5x3g+9h/k+2UWq7bSBvgfFhQZCbI
         1GBw==
X-Gm-Message-State: AOJu0YyV9joZ2UpiMyXpy6vvJjs5RP4NGPwK8GcKWuwECZghPZytVWKB
	Z5pCeU49RRg17vXZ7aSnL/6AhyveqLSzu/66kCxLkQ==
X-Google-Smtp-Source: AGHT+IFmahFuAlpaZwjHA1Awq4ZO4SJn2T3Y+o5Ga6iFkp5DI57tBXVjB/FXf/om2wTiDTjiVTbNwA==
X-Received: by 2002:a05:600c:3641:b0:3fb:feb0:6f40 with SMTP id y1-20020a05600c364100b003fbfeb06f40mr2015679wmq.11.1691673343012;
        Thu, 10 Aug 2023 06:15:43 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fe1fe56202sm2142224wmd.33.2023.08.10.06.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:15:42 -0700 (PDT)
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
Subject: [patch net-next v3 01/13] devlink: parse linecard attr in doit() callbacks
Date: Thu, 10 Aug 2023 15:15:27 +0200
Message-ID: <20230810131539.1602299-2-jiri@resnulli.us>
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

No need to give the linecards any special treatment in netlink attribute
parsing, as unlike for ports, there is only a couple of commands
benefiting from that.

Remove DEVLINK_NL_FLAG_NEED_LINECARD, make pre_doit() callback simpler
by moving the linecard attribute parsing to linecard_[gs]et_doit() ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  7 -------
 net/devlink/leftover.c      | 19 +++++++++++++------
 net/devlink/netlink.c       |  8 --------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7fdd956ff992..3bbecebf192d 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -94,7 +94,6 @@ static inline bool devl_is_registered(struct devlink *devlink)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
 #define DEVLINK_NL_FLAG_NEED_RATE		BIT(2)
 #define DEVLINK_NL_FLAG_NEED_RATE_NODE		BIT(3)
-#define DEVLINK_NL_FLAG_NEED_LINECARD		BIT(4)
 
 enum devlink_multicast_groups {
 	DEVLINK_MCGRP_CONFIG,
@@ -203,12 +202,6 @@ int devlink_resources_validate(struct devlink *devlink,
 			       struct devlink_resource *resource,
 			       struct genl_info *info);
 
-/* Line cards */
-struct devlink_linecard;
-
-struct devlink_linecard *
-devlink_linecard_get_from_info(struct devlink *devlink, struct genl_info *info);
-
 /* Rates */
 int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 			     struct netlink_ext_ack *extack);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index e7900d9fa205..46cdd5d88583 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -285,7 +285,7 @@ devlink_linecard_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
 	return ERR_PTR(-EINVAL);
 }
 
-struct devlink_linecard *
+static struct devlink_linecard *
 devlink_linecard_get_from_info(struct devlink *devlink, struct genl_info *info)
 {
 	return devlink_linecard_get_from_attrs(devlink, info->attrs);
@@ -1814,11 +1814,15 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 static int devlink_nl_cmd_linecard_get_doit(struct sk_buff *skb,
 					    struct genl_info *info)
 {
-	struct devlink_linecard *linecard = info->user_ptr[1];
-	struct devlink *devlink = linecard->devlink;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_linecard *linecard;
 	struct sk_buff *msg;
 	int err;
 
+	linecard = devlink_linecard_get_from_info(devlink, info);
+	if (IS_ERR(linecard))
+		return PTR_ERR(linecard);
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
@@ -2008,10 +2012,15 @@ static int devlink_linecard_type_unset(struct devlink_linecard *linecard,
 static int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
 					    struct genl_info *info)
 {
-	struct devlink_linecard *linecard = info->user_ptr[1];
 	struct netlink_ext_ack *extack = info->extack;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_linecard *linecard;
 	int err;
 
+	linecard = devlink_linecard_get_from_info(devlink, info);
+	if (IS_ERR(linecard))
+		return PTR_ERR(linecard);
+
 	if (info->attrs[DEVLINK_ATTR_LINECARD_TYPE]) {
 		const char *type;
 
@@ -6347,14 +6356,12 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.cmd = DEVLINK_CMD_LINECARD_GET,
 		.doit = devlink_nl_cmd_linecard_get_doit,
 		.dumpit = devlink_nl_instance_iter_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_LINECARD,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_LINECARD_SET,
 		.doit = devlink_nl_cmd_linecard_set_doit,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_LINECARD,
 	},
 	{
 		.cmd = DEVLINK_CMD_SB_GET,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index bada2819827b..9fd683f38a53 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -112,7 +112,6 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 			struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_linecard *linecard;
 	struct devlink_port *devlink_port;
 	struct devlink *devlink;
 	int err;
@@ -151,13 +150,6 @@ int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 			goto unlock;
 		}
 		info->user_ptr[1] = rate_node;
-	} else if (ops->internal_flags & DEVLINK_NL_FLAG_NEED_LINECARD) {
-		linecard = devlink_linecard_get_from_info(devlink, info);
-		if (IS_ERR(linecard)) {
-			err = PTR_ERR(linecard);
-			goto unlock;
-		}
-		info->user_ptr[1] = linecard;
 	}
 	return 0;
 
-- 
2.41.0


