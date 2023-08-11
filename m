Return-Path: <netdev+bounces-26858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 341157793AA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F771C216BD
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8C2329D0;
	Fri, 11 Aug 2023 15:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0025692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:30 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DBA30D8
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so18809415e9.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769447; x=1692374247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTTNtyVdQ54Vp2keCdE/XH3tw/qXv7u3Z2Jlwnps83E=;
        b=ALmG/vuNa498h4u0aKNKi22Jh+A/a1GB43o2jtxYqWuo6w1gLwYgas7SPIGtJ0Yoos
         kOaGHVGUwRhgHAotTbWzrGMtEjqa4PzPUMmzix3p8hcyELmm4ENh0yGKDcEeZ2d/Fxa9
         SKqxKvPe+P1bxUmJZvvMV1PBRJzRmMEW7OVI8D5uU/tfPXoYsI2RrRpKblm9PDVR3JxX
         Y2/QM4o6M7KejShqbgh8vGpix+CKy5BKwuTnPux3noRUJOwmE830Oj+midu/2129NT/w
         Qh1Ds/UIXC6gEFZ1qf/2kG5OmYtaZkJ001ZtaJ8zOl64JJgpbC0OI0qwWZn3bIWB177S
         Htbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769447; x=1692374247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTTNtyVdQ54Vp2keCdE/XH3tw/qXv7u3Z2Jlwnps83E=;
        b=QPgQFqE3aT43wBfC/IFFlsfxiegRdDOb8bFGoPmKPBv5Lk3QJwdMV0Qz6E70pFEGJD
         qF8Z4c/mHYxNiglEX6+aaCEM6XMuFN2+nNf9gue0MZSbYU+xCL6Bi2slf8GpvNklRp2/
         Ef701eZL7A2dvDlmfkglAymZBnaC0fzqx76R8lcJREIKxVy3auThC4j/1tKroRPiSNA6
         iUC4W/jN2qi92QTXAI/cPOz3mIqMFx8jA12rLhJaIBBwa3bwFfmwQCUz8VkCN4owSP7w
         MLsoRCfjuTZouIWxDv4F3xoq2ANVFUPuCL1bPjNn9PAhGgYpZt/7km89AWmHx65QuFuc
         3A5w==
X-Gm-Message-State: AOJu0YxlZ24hzM7TjaZZ/oVASMaHfL7VUrX/QEiq7GCDpNbU2HMjz6+T
	nIBrj9IZeTPv5tYrsJzqiC7r5ZzzHm+3VwpY3coiMw==
X-Google-Smtp-Source: AGHT+IFezlDPF4lfh6fT+Y92i7AwCnz5TDcYTLnjKpjGME+LXopjEgeW+JNVRPBSzplwOVnCmQ5F2w==
X-Received: by 2002:a05:600c:2494:b0:3fc:7d2:e0c0 with SMTP id 20-20020a05600c249400b003fc07d2e0c0mr2100187wms.27.1691769447364;
        Fri, 11 Aug 2023 08:57:27 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c029800b003fe2397c17fsm8364625wmk.17.2023.08.11.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:26 -0700 (PDT)
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
Subject: [patch net-next v4 06/13] devlink: pass flags as an arg of dump_one() callback
Date: Fri, 11 Aug 2023 17:57:07 +0200
Message-ID: <20230811155714.1736405-7-jiri@resnulli.us>
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

In order to easily set NLM_F_DUMP_FILTERED for partial dumps, pass the
flags as an arg of dump_one() callback. Currently, it is always
NLM_F_MULTI.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/dev.c           | 13 +++---
 net/devlink/devl_internal.h |  3 +-
 net/devlink/health.c        |  7 +--
 net/devlink/leftover.c      | 87 ++++++++++++++++++-------------------
 net/devlink/netlink.c       |  2 +-
 5 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 22e8ab3eaaa2..abf3393a7a17 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -218,11 +218,11 @@ int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int
 devlink_nl_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			struct netlink_callback *cb)
+			struct netlink_callback *cb, int flags)
 {
 	return devlink_nl_fill(msg, devlink, DEVLINK_CMD_NEW,
 			       NETLINK_CB(cb->skb).portid,
-			       cb->nlh->nlmsg_seq, NLM_F_MULTI);
+			       cb->nlh->nlmsg_seq, flags);
 }
 
 int devlink_nl_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
@@ -828,13 +828,13 @@ int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int
 devlink_nl_info_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			     struct netlink_callback *cb)
+			     struct netlink_callback *cb, int flags)
 {
 	int err;
 
 	err = devlink_nl_info_fill(msg, devlink, DEVLINK_CMD_INFO_GET,
 				   NETLINK_CB(cb->skb).portid,
-				   cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				   cb->nlh->nlmsg_seq, flags,
 				   cb->extack);
 	if (err == -EOPNOTSUPP)
 		err = 0;
@@ -1231,14 +1231,15 @@ int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int devlink_nl_selftests_get_dump_one(struct sk_buff *msg,
 					     struct devlink *devlink,
-					     struct netlink_callback *cb)
+					     struct netlink_callback *cb,
+					     int flags)
 {
 	if (!devlink->ops->selftest_check)
 		return 0;
 
 	return devlink_nl_selftests_fill(msg, devlink,
 					 NETLINK_CB(cb->skb).portid,
-					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
+					 cb->nlh->nlmsg_seq, flags,
 					 cb->extack);
 }
 
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 500c91c61b2d..f8af6ffdbb3a 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -115,7 +115,8 @@ struct devlink_nl_dump_state {
 
 typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 				       struct devlink *devlink,
-				       struct netlink_callback *cb);
+				       struct netlink_callback *cb,
+				       int flags);
 
 extern const struct genl_small_ops devlink_nl_small_ops[54];
 
diff --git a/net/devlink/health.c b/net/devlink/health.c
index dbe2d6a1df3b..b9b3e68d9043 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -386,7 +386,8 @@ int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
 
 static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
 						   struct devlink *devlink,
-						   struct netlink_callback *cb)
+						   struct netlink_callback *cb,
+						   int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_health_reporter *reporter;
@@ -404,7 +405,7 @@ static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
 						      DEVLINK_CMD_HEALTH_REPORTER_GET,
 						      NETLINK_CB(cb->skb).portid,
 						      cb->nlh->nlmsg_seq,
-						      NLM_F_MULTI);
+						      flags);
 		if (err) {
 			state->idx = idx;
 			return err;
@@ -421,7 +422,7 @@ static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
 							      DEVLINK_CMD_HEALTH_REPORTER_GET,
 							      NETLINK_CB(cb->skb).portid,
 							      cb->nlh->nlmsg_seq,
-							      NLM_F_MULTI);
+							      flags);
 			if (err) {
 				state->idx = idx;
 				return err;
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 21f1058ef14d..883c65545d26 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -1006,7 +1006,7 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 
 static int
 devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			     struct netlink_callback *cb)
+			     struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_rate *devlink_rate;
@@ -1022,8 +1022,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 			continue;
 		}
 		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
-					   cb->nlh->nlmsg_seq,
-					   NLM_F_MULTI, NULL);
+					   cb->nlh->nlmsg_seq, flags, NULL);
 		if (err) {
 			state->idx = idx;
 			break;
@@ -1100,7 +1099,7 @@ int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int
 devlink_nl_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			     struct netlink_callback *cb)
+			     struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_port *devlink_port;
@@ -1111,8 +1110,8 @@ devlink_nl_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		err = devlink_nl_port_fill(msg, devlink_port,
 					   DEVLINK_CMD_NEW,
 					   NETLINK_CB(cb->skb).portid,
-					   cb->nlh->nlmsg_seq,
-					   NLM_F_MULTI, cb->extack);
+					   cb->nlh->nlmsg_seq, flags,
+					   cb->extack);
 		if (err) {
 			state->idx = port_index;
 			break;
@@ -1856,7 +1855,8 @@ int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int devlink_nl_linecard_get_dump_one(struct sk_buff *msg,
 					    struct devlink *devlink,
-					    struct netlink_callback *cb)
+					    struct netlink_callback *cb,
+					    int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_linecard *linecard;
@@ -1872,8 +1872,7 @@ static int devlink_nl_linecard_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_linecard_fill(msg, devlink, linecard,
 					       DEVLINK_CMD_LINECARD_NEW,
 					       NETLINK_CB(cb->skb).portid,
-					       cb->nlh->nlmsg_seq,
-					       NLM_F_MULTI,
+					       cb->nlh->nlmsg_seq, flags,
 					       cb->extack);
 		mutex_unlock(&linecard->state_lock);
 		if (err) {
@@ -2120,7 +2119,7 @@ int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int
 devlink_nl_sb_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			   struct netlink_callback *cb)
+			   struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2135,8 +2134,7 @@ devlink_nl_sb_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		err = devlink_nl_sb_fill(msg, devlink, devlink_sb,
 					 DEVLINK_CMD_SB_NEW,
 					 NETLINK_CB(cb->skb).portid,
-					 cb->nlh->nlmsg_seq,
-					 NLM_F_MULTI);
+					 cb->nlh->nlmsg_seq, flags);
 		if (err) {
 			state->idx = idx;
 			break;
@@ -2233,7 +2231,7 @@ int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
 static int __sb_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 				struct devlink *devlink,
 				struct devlink_sb *devlink_sb,
-				u32 portid, u32 seq)
+				u32 portid, u32 seq, int flags)
 {
 	u16 pool_count = devlink_sb_pool_count(devlink_sb);
 	u16 pool_index;
@@ -2248,7 +2246,7 @@ static int __sb_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 					      devlink_sb,
 					      pool_index,
 					      DEVLINK_CMD_SB_POOL_NEW,
-					      portid, seq, NLM_F_MULTI);
+					      portid, seq, flags);
 		if (err)
 			return err;
 		(*p_idx)++;
@@ -2258,7 +2256,7 @@ static int __sb_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 
 static int
 devlink_nl_sb_pool_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				struct netlink_callback *cb)
+				struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2272,7 +2270,7 @@ devlink_nl_sb_pool_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		err = __sb_pool_get_dumpit(msg, state->idx, &idx,
 					   devlink, devlink_sb,
 					   NETLINK_CB(cb->skb).portid,
-					   cb->nlh->nlmsg_seq);
+					   cb->nlh->nlmsg_seq, flags);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -2436,7 +2434,7 @@ int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
 static int __sb_port_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 				     struct devlink *devlink,
 				     struct devlink_sb *devlink_sb,
-				     u32 portid, u32 seq)
+				     u32 portid, u32 seq, int flags)
 {
 	struct devlink_port *devlink_port;
 	u16 pool_count = devlink_sb_pool_count(devlink_sb);
@@ -2455,8 +2453,7 @@ static int __sb_port_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 							   devlink_sb,
 							   pool_index,
 							   DEVLINK_CMD_SB_PORT_POOL_NEW,
-							   portid, seq,
-							   NLM_F_MULTI);
+							   portid, seq, flags);
 			if (err)
 				return err;
 			(*p_idx)++;
@@ -2468,7 +2465,7 @@ static int __sb_port_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 static int
 devlink_nl_sb_port_pool_get_dump_one(struct sk_buff *msg,
 				     struct devlink *devlink,
-				     struct netlink_callback *cb)
+				     struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2482,7 +2479,7 @@ devlink_nl_sb_port_pool_get_dump_one(struct sk_buff *msg,
 		err = __sb_port_pool_get_dumpit(msg, state->idx, &idx,
 						devlink, devlink_sb,
 						NETLINK_CB(cb->skb).portid,
-						cb->nlh->nlmsg_seq);
+						cb->nlh->nlmsg_seq, flags);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -2654,7 +2651,7 @@ static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
 					int start, int *p_idx,
 					struct devlink *devlink,
 					struct devlink_sb *devlink_sb,
-					u32 portid, u32 seq)
+					u32 portid, u32 seq, int flags)
 {
 	struct devlink_port *devlink_port;
 	unsigned long port_index;
@@ -2675,7 +2672,7 @@ static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
 							      DEVLINK_SB_POOL_TYPE_INGRESS,
 							      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
 							      portid, seq,
-							      NLM_F_MULTI);
+							      flags);
 			if (err)
 				return err;
 			(*p_idx)++;
@@ -2693,7 +2690,7 @@ static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
 							      DEVLINK_SB_POOL_TYPE_EGRESS,
 							      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
 							      portid, seq,
-							      NLM_F_MULTI);
+							      flags);
 			if (err)
 				return err;
 			(*p_idx)++;
@@ -2704,7 +2701,8 @@ static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
 
 static int devlink_nl_sb_tc_pool_bind_get_dump_one(struct sk_buff *msg,
 						   struct devlink *devlink,
-						   struct netlink_callback *cb)
+						   struct netlink_callback *cb,
+						   int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2718,7 +2716,7 @@ static int devlink_nl_sb_tc_pool_bind_get_dump_one(struct sk_buff *msg,
 		err = __sb_tc_pool_bind_get_dumpit(msg, state->idx, &idx,
 						   devlink, devlink_sb,
 						   NETLINK_CB(cb->skb).portid,
-						   cb->nlh->nlmsg_seq);
+						   cb->nlh->nlmsg_seq, flags);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -4185,7 +4183,8 @@ static void devlink_param_notify(struct devlink *devlink,
 
 static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 					 struct devlink *devlink,
-					 struct netlink_callback *cb)
+					 struct netlink_callback *cb,
+					 int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_param_item *param_item;
@@ -4196,8 +4195,7 @@ static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_param_fill(msg, devlink, 0, param_item,
 					    DEVLINK_CMD_PARAM_GET,
 					    NETLINK_CB(cb->skb).portid,
-					    cb->nlh->nlmsg_seq,
-					    NLM_F_MULTI);
+					    cb->nlh->nlmsg_seq, flags);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -4848,8 +4846,7 @@ int devlink_nl_region_get_doit(struct sk_buff *skb, struct genl_info *info)
 static int devlink_nl_cmd_region_get_port_dumpit(struct sk_buff *msg,
 						 struct netlink_callback *cb,
 						 struct devlink_port *port,
-						 int *idx,
-						 int start)
+						 int *idx, int start, int flags)
 {
 	struct devlink_region *region;
 	int err = 0;
@@ -4863,7 +4860,7 @@ static int devlink_nl_cmd_region_get_port_dumpit(struct sk_buff *msg,
 					     DEVLINK_CMD_REGION_GET,
 					     NETLINK_CB(cb->skb).portid,
 					     cb->nlh->nlmsg_seq,
-					     NLM_F_MULTI, region);
+					     flags, region);
 		if (err)
 			goto out;
 		(*idx)++;
@@ -4875,7 +4872,8 @@ static int devlink_nl_cmd_region_get_port_dumpit(struct sk_buff *msg,
 
 static int devlink_nl_region_get_dump_one(struct sk_buff *msg,
 					  struct devlink *devlink,
-					  struct netlink_callback *cb)
+					  struct netlink_callback *cb,
+					  int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_region *region;
@@ -4892,8 +4890,8 @@ static int devlink_nl_region_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_region_fill(msg, devlink,
 					     DEVLINK_CMD_REGION_GET,
 					     NETLINK_CB(cb->skb).portid,
-					     cb->nlh->nlmsg_seq,
-					     NLM_F_MULTI, region);
+					     cb->nlh->nlmsg_seq, flags,
+					     region);
 		if (err) {
 			state->idx = idx;
 			return err;
@@ -4903,7 +4901,7 @@ static int devlink_nl_region_get_dump_one(struct sk_buff *msg,
 
 	xa_for_each(&devlink->ports, port_index, port) {
 		err = devlink_nl_cmd_region_get_port_dumpit(msg, cb, port, &idx,
-							    state->idx);
+							    state->idx, flags);
 		if (err) {
 			state->idx = idx;
 			return err;
@@ -5699,7 +5697,7 @@ int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int devlink_nl_trap_get_dump_one(struct sk_buff *msg,
 					struct devlink *devlink,
-					struct netlink_callback *cb)
+					struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_trap_item *trap_item;
@@ -5714,8 +5712,7 @@ static int devlink_nl_trap_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_trap_fill(msg, devlink, trap_item,
 					   DEVLINK_CMD_TRAP_NEW,
 					   NETLINK_CB(cb->skb).portid,
-					   cb->nlh->nlmsg_seq,
-					   NLM_F_MULTI);
+					   cb->nlh->nlmsg_seq, flags);
 		if (err) {
 			state->idx = idx;
 			break;
@@ -5910,7 +5907,8 @@ int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int devlink_nl_trap_group_get_dump_one(struct sk_buff *msg,
 					      struct devlink *devlink,
-					      struct netlink_callback *cb)
+					      struct netlink_callback *cb,
+					      int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_trap_group_item *group_item;
@@ -5926,8 +5924,7 @@ static int devlink_nl_trap_group_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_trap_group_fill(msg, devlink, group_item,
 						 DEVLINK_CMD_TRAP_GROUP_NEW,
 						 NETLINK_CB(cb->skb).portid,
-						 cb->nlh->nlmsg_seq,
-						 NLM_F_MULTI);
+						 cb->nlh->nlmsg_seq, flags);
 		if (err) {
 			state->idx = idx;
 			break;
@@ -6205,7 +6202,8 @@ int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
 
 static int devlink_nl_trap_policer_get_dump_one(struct sk_buff *msg,
 						struct devlink *devlink,
-						struct netlink_callback *cb)
+						struct netlink_callback *cb,
+						int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_trap_policer_item *policer_item;
@@ -6220,8 +6218,7 @@ static int devlink_nl_trap_policer_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_trap_policer_fill(msg, devlink, policer_item,
 						   DEVLINK_CMD_TRAP_POLICER_NEW,
 						   NETLINK_CB(cb->skb).portid,
-						   cb->nlh->nlmsg_seq,
-						   NLM_F_MULTI);
+						   cb->nlh->nlmsg_seq, flags);
 		if (err) {
 			state->idx = idx;
 			break;
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 13388665f319..47e44fb45815 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -182,7 +182,7 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		devl_lock(devlink);
 
 		if (devl_is_registered(devlink))
-			err = dump_one(msg, devlink, cb);
+			err = dump_one(msg, devlink, cb, NLM_F_MULTI);
 		else
 			err = 0;
 
-- 
2.41.0


