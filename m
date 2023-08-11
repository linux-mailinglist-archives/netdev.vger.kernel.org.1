Return-Path: <netdev+bounces-26853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B958C779392
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB7E1C216B7
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487F2AB5A;
	Fri, 11 Aug 2023 15:57:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F05692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:23 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EA12723
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so19639495e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769438; x=1692374238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS4maoKCErTkiOhuvBGkMIGUBJDDkZ9nPNgJbvrjAc0=;
        b=aa448WhC7qRalSpdQn+hn4us7Y3xD+kMjobOUwr3H109cSlefCiA+yMpIY1jEpMKtr
         yippgctxsu/rQ6Ayvz9PaT0JkSzx0hhXY4+BJtbYKUuHQ63CJgSwxN6LKkdeVgi2ojLe
         kEScY4aeQrhLHylyf5JdTfQe1E9D1mPh/1mUCvA5zXa4na6My+jA3Z7GGG4GhkzyY9/C
         T1ZWAW7Siv/524BuP1RGepydwhoFjXbaiPFO+/p3pQtyDBJNCHdigHforVQsvnZFmTMr
         XHE9sUFZ+7cHlrr6wktJ+ORc7PlUQ+3hGbOLN6jmtv96C04s5Qr57Zoiq5GTOp90EFy4
         yUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769438; x=1692374238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS4maoKCErTkiOhuvBGkMIGUBJDDkZ9nPNgJbvrjAc0=;
        b=AGBhEN3xsGFsNndF504b1ELoMZ2EJW30jUSgW9FmQm8hNqY7FXjBY73/79TzWCOFiE
         EKrbuHlY0Wf07xwwheWPCFRbyj7HOAYEDLL08TeDxJPjxe1NR/dxXLi/WbeSFojB1GvL
         Tfy6VZeJiX4xZ8Trkn1e+1A5qmbLJIcWeSH1YzhzeH1ptreuOdI8feBcp3ij/j3ZsekJ
         ROj0ggez4Bnn6W80DOwkTxDmHQKpcZDnVvrbjVnKRTpw/BOH8CRKpGivhj+VrZHv3xEV
         1IIfw0gGfXidBQNytf9BwmAvJe5KTL56CgHVCYYH2lPTXheyDhsakLDko6g0NocXf4OI
         5SgA==
X-Gm-Message-State: AOJu0YzY6F0uTjtvcPiOmayvYgrV7zLrexAaGyr6Q8glOkOzmssObgcW
	CGeEEzDDqaaLdTE6UxBRx/I6QulMrrouufeOaVKEeA==
X-Google-Smtp-Source: AGHT+IHbMlRkAatFZ4k1n7FwuCT46W30dNh99Rxmqvs6YTL04evgiDNMg9ekX6ZFtsqcZ0pSgTSBFw==
X-Received: by 2002:a5d:53c3:0:b0:315:a74c:f627 with SMTP id a3-20020a5d53c3000000b00315a74cf627mr1762272wrw.16.1691769438104;
        Fri, 11 Aug 2023 08:57:18 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe7ca000000b0031784ac0babsm5776387wrn.28.2023.08.11.08.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:17 -0700 (PDT)
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
Subject: [patch net-next v4 01/13] devlink: parse linecard attr in doit() callbacks
Date: Fri, 11 Aug 2023 17:57:02 +0200
Message-ID: <20230811155714.1736405-2-jiri@resnulli.us>
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


