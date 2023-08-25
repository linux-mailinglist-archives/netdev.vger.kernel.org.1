Return-Path: <netdev+bounces-30597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49C7882B9
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EC81C20FC1
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21943C8F7;
	Fri, 25 Aug 2023 08:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6D291F
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:53:48 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A261BF6
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31c615eb6feso514590f8f.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692953622; x=1693558422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90kF7zNLkYCIoQo6UsQcmZDSxwS5FcMUqPGWve4tuxk=;
        b=hIGJTWuIHMt14kNcR6CEn8ft7vSXGV5ZeiqGAlx9rCw/biQLupTOD1IctLWuwh2gEv
         wG9Rze5Jy7F4k6C7FkUOrNTJrQPFgGRtmiUWiw9WyI/T79YM1xAhoXgZueNteTzbgEM4
         EKw9JAsKYEEMjSIsMGRS5erToi0yGOeP8GONebLhA6Rrx2RekWKCwyErIFxRTj1KfOqY
         5/Rn7sp4nAql/Vnv6aNjkDjEodKFNZ63Y0CvvWCW0IsPfIEALiKAGpJzwj0U0SH3+ENB
         ObbDJcMT3xUfl9qjjKjbVk8mXjyqVOBm9uAouYDMbqvg5GUacagv9FOLDxqzDRavL6er
         bJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953622; x=1693558422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90kF7zNLkYCIoQo6UsQcmZDSxwS5FcMUqPGWve4tuxk=;
        b=jCu3d5G4kvckR5rruqFbKO4RtHOhGX86KUo2FGLGRaLgiuRC1MusZayCkdYUlP4OZJ
         Qln4CNoJpDfZ0Wolmea3Fb2VU9ioWjM/SdMMJHj8VSghQvZGqSrsbHNasbApOVhu8+HH
         g6d3Nr2ceykbi+ACA+nMy+z5Xx+VJwwdZjWCZoLfGr8gzcM+hBW8sG/iZsNjrBpPmD4H
         mo0qhbFYWHlUv3qxLcN63/EWtL+lVbWc3o7vMhv5PMbc1cVVpJCDGQRanFFFfDnFMnrQ
         MTPD3lHWM6KAuWLYMdSYbpnBGQddIM+7d1tWawOKdN1i9rzquRfAqcJxVppLULtdE2Fe
         HGEQ==
X-Gm-Message-State: AOJu0Yz/PIqoxLHxiFtTr4JvCyKBmO87LrNHDbj6V9mIkvgmGZw14Lrd
	VxdFYoDZcWV0Dtu0BvYoP5O85fPVYsIaRVrRQW3c/l2A
X-Google-Smtp-Source: AGHT+IHv1AOdRmDtOBJv1beigw0kHPAPhZ7BBmKaFKtqyoXDABpdi5KjqhBp4hUPCzXS0qpkjhRY3Q==
X-Received: by 2002:adf:e482:0:b0:317:7eec:5e9d with SMTP id i2-20020adfe482000000b003177eec5e9dmr13016262wrm.16.1692953621604;
        Fri, 25 Aug 2023 01:53:41 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z8-20020adff1c8000000b0031c612146f1sm1551623wro.100.2023.08.25.01.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:53:40 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next 10/15] devlink: push trap related code into separate file
Date: Fri, 25 Aug 2023 10:53:16 +0200
Message-ID: <20230825085321.178134-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825085321.178134-1-jiri@resnulli.us>
References: <20230825085321.178134-1-jiri@resnulli.us>
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

Cut out another chunk from leftover.c and put trap related code
into a separate file.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/Makefile        |    2 +-
 net/devlink/devl_internal.h |   11 +
 net/devlink/leftover.c      | 2915 +++++++----------------------------
 net/devlink/trap.c          | 1861 ++++++++++++++++++++++
 4 files changed, 2400 insertions(+), 2389 deletions(-)
 create mode 100644 net/devlink/trap.c

diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 744f64e467b7..523efffe522c 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := leftover.o core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o
+	 resource.o param.o region.o health.o trap.o
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 32b66233240f..148525aa2847 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -160,6 +160,12 @@ void devlink_params_notify_register(struct devlink *devlink);
 void devlink_params_notify_unregister(struct devlink *devlink);
 void devlink_regions_notify_register(struct devlink *devlink);
 void devlink_regions_notify_unregister(struct devlink *devlink);
+void devlink_trap_policers_notify_register(struct devlink *devlink);
+void devlink_trap_policers_notify_unregister(struct devlink *devlink);
+void devlink_trap_groups_notify_register(struct devlink *devlink);
+void devlink_trap_groups_notify_unregister(struct devlink *devlink);
+void devlink_traps_notify_register(struct devlink *devlink);
+void devlink_traps_notify_unregister(struct devlink *devlink);
 
 /* Ports */
 #define ASSERT_DEVLINK_PORT_INITIALIZED(devlink_port)				\
@@ -267,3 +273,8 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 						   struct genl_info *info);
 int devlink_nl_cmd_health_reporter_test_doit(struct sk_buff *skb,
 					     struct genl_info *info);
+int devlink_nl_cmd_trap_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_trap_group_set_doit(struct sk_buff *skb,
+				       struct genl_info *info);
+int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
+					 struct genl_info *info);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 1db3a7928465..5b153ce097ab 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -999,2495 +999,634 @@ int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 	return 0;
 }
 
-struct devlink_stats {
-	u64_stats_t rx_bytes;
-	u64_stats_t rx_packets;
-	struct u64_stats_sync syncp;
-};
-
-/**
- * struct devlink_trap_policer_item - Packet trap policer attributes.
- * @policer: Immutable packet trap policer attributes.
- * @rate: Rate in packets / sec.
- * @burst: Burst size in packets.
- * @list: trap_policer_list member.
- *
- * Describes packet trap policer attributes. Created by devlink during trap
- * policer registration.
- */
-struct devlink_trap_policer_item {
-	const struct devlink_trap_policer *policer;
-	u64 rate;
-	u64 burst;
-	struct list_head list;
-};
-
-/**
- * struct devlink_trap_group_item - Packet trap group attributes.
- * @group: Immutable packet trap group attributes.
- * @policer_item: Associated policer item. Can be NULL.
- * @list: trap_group_list member.
- * @stats: Trap group statistics.
- *
- * Describes packet trap group attributes. Created by devlink during trap
- * group registration.
- */
-struct devlink_trap_group_item {
-	const struct devlink_trap_group *group;
-	struct devlink_trap_policer_item *policer_item;
-	struct list_head list;
-	struct devlink_stats __percpu *stats;
-};
-
-/**
- * struct devlink_trap_item - Packet trap attributes.
- * @trap: Immutable packet trap attributes.
- * @group_item: Associated group item.
- * @list: trap_list member.
- * @action: Trap action.
- * @stats: Trap statistics.
- * @priv: Driver private information.
- *
- * Describes both mutable and immutable packet trap attributes. Created by
- * devlink during trap registration and used for all trap related operations.
- */
-struct devlink_trap_item {
-	const struct devlink_trap *trap;
-	struct devlink_trap_group_item *group_item;
-	struct list_head list;
-	enum devlink_trap_action action;
-	struct devlink_stats __percpu *stats;
-	void *priv;
-};
-
-static struct devlink_trap_policer_item *
-devlink_trap_policer_item_lookup(struct devlink *devlink, u32 id)
-{
-	struct devlink_trap_policer_item *policer_item;
-
-	list_for_each_entry(policer_item, &devlink->trap_policer_list, list) {
-		if (policer_item->policer->id == id)
-			return policer_item;
-	}
-
-	return NULL;
-}
-
-static struct devlink_trap_item *
-devlink_trap_item_lookup(struct devlink *devlink, const char *name)
-{
-	struct devlink_trap_item *trap_item;
-
-	list_for_each_entry(trap_item, &devlink->trap_list, list) {
-		if (!strcmp(trap_item->trap->name, name))
-			return trap_item;
-	}
-
-	return NULL;
-}
-
-static struct devlink_trap_item *
-devlink_trap_item_get_from_info(struct devlink *devlink,
-				struct genl_info *info)
-{
-	struct nlattr *attr;
-
-	if (!info->attrs[DEVLINK_ATTR_TRAP_NAME])
-		return NULL;
-	attr = info->attrs[DEVLINK_ATTR_TRAP_NAME];
-
-	return devlink_trap_item_lookup(devlink, nla_data(attr));
-}
-
-static int
-devlink_trap_action_get_from_info(struct genl_info *info,
-				  enum devlink_trap_action *p_trap_action)
-{
-	u8 val;
-
-	val = nla_get_u8(info->attrs[DEVLINK_ATTR_TRAP_ACTION]);
-	switch (val) {
-	case DEVLINK_TRAP_ACTION_DROP:
-	case DEVLINK_TRAP_ACTION_TRAP:
-	case DEVLINK_TRAP_ACTION_MIRROR:
-		*p_trap_action = val;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int devlink_trap_metadata_put(struct sk_buff *msg,
-				     const struct devlink_trap *trap)
-{
-	struct nlattr *attr;
-
-	attr = nla_nest_start(msg, DEVLINK_ATTR_TRAP_METADATA);
-	if (!attr)
-		return -EMSGSIZE;
-
-	if ((trap->metadata_cap & DEVLINK_TRAP_METADATA_TYPE_F_IN_PORT) &&
-	    nla_put_flag(msg, DEVLINK_ATTR_TRAP_METADATA_TYPE_IN_PORT))
-		goto nla_put_failure;
-	if ((trap->metadata_cap & DEVLINK_TRAP_METADATA_TYPE_F_FA_COOKIE) &&
-	    nla_put_flag(msg, DEVLINK_ATTR_TRAP_METADATA_TYPE_FA_COOKIE))
-		goto nla_put_failure;
-
-	nla_nest_end(msg, attr);
-
-	return 0;
-
-nla_put_failure:
-	nla_nest_cancel(msg, attr);
-	return -EMSGSIZE;
-}
-
-static void devlink_trap_stats_read(struct devlink_stats __percpu *trap_stats,
-				    struct devlink_stats *stats)
-{
-	int i;
-
-	memset(stats, 0, sizeof(*stats));
-	for_each_possible_cpu(i) {
-		struct devlink_stats *cpu_stats;
-		u64 rx_packets, rx_bytes;
-		unsigned int start;
-
-		cpu_stats = per_cpu_ptr(trap_stats, i);
-		do {
-			start = u64_stats_fetch_begin(&cpu_stats->syncp);
-			rx_packets = u64_stats_read(&cpu_stats->rx_packets);
-			rx_bytes = u64_stats_read(&cpu_stats->rx_bytes);
-		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
-
-		u64_stats_add(&stats->rx_packets, rx_packets);
-		u64_stats_add(&stats->rx_bytes, rx_bytes);
-	}
-}
-
-static int
-devlink_trap_group_stats_put(struct sk_buff *msg,
-			     struct devlink_stats __percpu *trap_stats)
-{
-	struct devlink_stats stats;
-	struct nlattr *attr;
-
-	devlink_trap_stats_read(trap_stats, &stats);
-
-	attr = nla_nest_start(msg, DEVLINK_ATTR_STATS);
-	if (!attr)
-		return -EMSGSIZE;
-
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_PACKETS,
-			      u64_stats_read(&stats.rx_packets),
-			      DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_BYTES,
-			      u64_stats_read(&stats.rx_bytes),
-			      DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	nla_nest_end(msg, attr);
-
-	return 0;
-
-nla_put_failure:
-	nla_nest_cancel(msg, attr);
-	return -EMSGSIZE;
-}
-
-static int devlink_trap_stats_put(struct sk_buff *msg, struct devlink *devlink,
-				  const struct devlink_trap_item *trap_item)
-{
-	struct devlink_stats stats;
-	struct nlattr *attr;
-	u64 drops = 0;
-	int err;
-
-	if (devlink->ops->trap_drop_counter_get) {
-		err = devlink->ops->trap_drop_counter_get(devlink,
-							  trap_item->trap,
-							  &drops);
-		if (err)
-			return err;
-	}
-
-	devlink_trap_stats_read(trap_item->stats, &stats);
-
-	attr = nla_nest_start(msg, DEVLINK_ATTR_STATS);
-	if (!attr)
-		return -EMSGSIZE;
-
-	if (devlink->ops->trap_drop_counter_get &&
-	    nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_DROPPED, drops,
-			      DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_PACKETS,
-			      u64_stats_read(&stats.rx_packets),
-			      DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_BYTES,
-			      u64_stats_read(&stats.rx_bytes),
-			      DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	nla_nest_end(msg, attr);
-
-	return 0;
-
-nla_put_failure:
-	nla_nest_cancel(msg, attr);
-	return -EMSGSIZE;
-}
-
-static int devlink_nl_trap_fill(struct sk_buff *msg, struct devlink *devlink,
-				const struct devlink_trap_item *trap_item,
-				enum devlink_command cmd, u32 portid, u32 seq,
-				int flags)
-{
-	struct devlink_trap_group_item *group_item = trap_item->group_item;
-	void *hdr;
-	int err;
-
-	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
-	if (!hdr)
-		return -EMSGSIZE;
-
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-
-	if (nla_put_string(msg, DEVLINK_ATTR_TRAP_GROUP_NAME,
-			   group_item->group->name))
-		goto nla_put_failure;
-
-	if (nla_put_string(msg, DEVLINK_ATTR_TRAP_NAME, trap_item->trap->name))
-		goto nla_put_failure;
-
-	if (nla_put_u8(msg, DEVLINK_ATTR_TRAP_TYPE, trap_item->trap->type))
-		goto nla_put_failure;
-
-	if (trap_item->trap->generic &&
-	    nla_put_flag(msg, DEVLINK_ATTR_TRAP_GENERIC))
-		goto nla_put_failure;
-
-	if (nla_put_u8(msg, DEVLINK_ATTR_TRAP_ACTION, trap_item->action))
-		goto nla_put_failure;
-
-	err = devlink_trap_metadata_put(msg, trap_item->trap);
-	if (err)
-		goto nla_put_failure;
-
-	err = devlink_trap_stats_put(msg, devlink, trap_item);
-	if (err)
-		goto nla_put_failure;
-
-	genlmsg_end(msg, hdr);
-
-	return 0;
-
-nla_put_failure:
-	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
-}
-
-int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_trap_item *trap_item;
-	struct sk_buff *msg;
-	int err;
-
-	if (list_empty(&devlink->trap_list))
-		return -EOPNOTSUPP;
-
-	trap_item = devlink_trap_item_get_from_info(devlink, info);
-	if (!trap_item) {
-		NL_SET_ERR_MSG(extack, "Device did not register this trap");
-		return -ENOENT;
-	}
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	err = devlink_nl_trap_fill(msg, devlink, trap_item,
-				   DEVLINK_CMD_TRAP_NEW, info->snd_portid,
-				   info->snd_seq, 0);
-	if (err)
-		goto err_trap_fill;
-
-	return genlmsg_reply(msg, info);
-
-err_trap_fill:
-	nlmsg_free(msg);
-	return err;
-}
-
-static int devlink_nl_trap_get_dump_one(struct sk_buff *msg,
-					struct devlink *devlink,
-					struct netlink_callback *cb, int flags)
-{
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_trap_item *trap_item;
-	int idx = 0;
-	int err = 0;
-
-	list_for_each_entry(trap_item, &devlink->trap_list, list) {
-		if (idx < state->idx) {
-			idx++;
-			continue;
-		}
-		err = devlink_nl_trap_fill(msg, devlink, trap_item,
-					   DEVLINK_CMD_TRAP_NEW,
-					   NETLINK_CB(cb->skb).portid,
-					   cb->nlh->nlmsg_seq, flags);
-		if (err) {
-			state->idx = idx;
-			break;
-		}
-		idx++;
-	}
-
-	return err;
-}
-
-int devlink_nl_trap_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	return devlink_nl_dumpit(skb, cb, devlink_nl_trap_get_dump_one);
-}
-
-static int __devlink_trap_action_set(struct devlink *devlink,
-				     struct devlink_trap_item *trap_item,
-				     enum devlink_trap_action trap_action,
-				     struct netlink_ext_ack *extack)
-{
-	int err;
-
-	if (trap_item->action != trap_action &&
-	    trap_item->trap->type != DEVLINK_TRAP_TYPE_DROP) {
-		NL_SET_ERR_MSG(extack, "Cannot change action of non-drop traps. Skipping");
-		return 0;
-	}
-
-	err = devlink->ops->trap_action_set(devlink, trap_item->trap,
-					    trap_action, extack);
-	if (err)
-		return err;
-
-	trap_item->action = trap_action;
-
-	return 0;
-}
-
-static int devlink_trap_action_set(struct devlink *devlink,
-				   struct devlink_trap_item *trap_item,
-				   struct genl_info *info)
-{
-	enum devlink_trap_action trap_action;
-	int err;
-
-	if (!info->attrs[DEVLINK_ATTR_TRAP_ACTION])
-		return 0;
-
-	err = devlink_trap_action_get_from_info(info, &trap_action);
-	if (err) {
-		NL_SET_ERR_MSG(info->extack, "Invalid trap action");
-		return -EINVAL;
-	}
-
-	return __devlink_trap_action_set(devlink, trap_item, trap_action,
-					 info->extack);
-}
-
-static int devlink_nl_cmd_trap_set_doit(struct sk_buff *skb,
-					struct genl_info *info)
-{
-	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_trap_item *trap_item;
-
-	if (list_empty(&devlink->trap_list))
-		return -EOPNOTSUPP;
-
-	trap_item = devlink_trap_item_get_from_info(devlink, info);
-	if (!trap_item) {
-		NL_SET_ERR_MSG(extack, "Device did not register this trap");
-		return -ENOENT;
-	}
-
-	return devlink_trap_action_set(devlink, trap_item, info);
-}
-
-static struct devlink_trap_group_item *
-devlink_trap_group_item_lookup(struct devlink *devlink, const char *name)
-{
-	struct devlink_trap_group_item *group_item;
-
-	list_for_each_entry(group_item, &devlink->trap_group_list, list) {
-		if (!strcmp(group_item->group->name, name))
-			return group_item;
-	}
-
-	return NULL;
-}
-
-static struct devlink_trap_group_item *
-devlink_trap_group_item_lookup_by_id(struct devlink *devlink, u16 id)
-{
-	struct devlink_trap_group_item *group_item;
-
-	list_for_each_entry(group_item, &devlink->trap_group_list, list) {
-		if (group_item->group->id == id)
-			return group_item;
-	}
-
-	return NULL;
-}
-
-static struct devlink_trap_group_item *
-devlink_trap_group_item_get_from_info(struct devlink *devlink,
-				      struct genl_info *info)
-{
-	char *name;
-
-	if (!info->attrs[DEVLINK_ATTR_TRAP_GROUP_NAME])
-		return NULL;
-	name = nla_data(info->attrs[DEVLINK_ATTR_TRAP_GROUP_NAME]);
-
-	return devlink_trap_group_item_lookup(devlink, name);
-}
-
-static int
-devlink_nl_trap_group_fill(struct sk_buff *msg, struct devlink *devlink,
-			   const struct devlink_trap_group_item *group_item,
-			   enum devlink_command cmd, u32 portid, u32 seq,
-			   int flags)
-{
-	void *hdr;
-	int err;
-
-	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
-	if (!hdr)
-		return -EMSGSIZE;
-
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-
-	if (nla_put_string(msg, DEVLINK_ATTR_TRAP_GROUP_NAME,
-			   group_item->group->name))
-		goto nla_put_failure;
-
-	if (group_item->group->generic &&
-	    nla_put_flag(msg, DEVLINK_ATTR_TRAP_GENERIC))
-		goto nla_put_failure;
-
-	if (group_item->policer_item &&
-	    nla_put_u32(msg, DEVLINK_ATTR_TRAP_POLICER_ID,
-			group_item->policer_item->policer->id))
-		goto nla_put_failure;
-
-	err = devlink_trap_group_stats_put(msg, group_item->stats);
-	if (err)
-		goto nla_put_failure;
-
-	genlmsg_end(msg, hdr);
-
-	return 0;
-
-nla_put_failure:
-	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
-}
-
-int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_trap_group_item *group_item;
-	struct sk_buff *msg;
-	int err;
-
-	if (list_empty(&devlink->trap_group_list))
-		return -EOPNOTSUPP;
-
-	group_item = devlink_trap_group_item_get_from_info(devlink, info);
-	if (!group_item) {
-		NL_SET_ERR_MSG(extack, "Device did not register this trap group");
-		return -ENOENT;
-	}
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	err = devlink_nl_trap_group_fill(msg, devlink, group_item,
-					 DEVLINK_CMD_TRAP_GROUP_NEW,
-					 info->snd_portid, info->snd_seq, 0);
-	if (err)
-		goto err_trap_group_fill;
-
-	return genlmsg_reply(msg, info);
-
-err_trap_group_fill:
-	nlmsg_free(msg);
-	return err;
-}
-
-static int devlink_nl_trap_group_get_dump_one(struct sk_buff *msg,
-					      struct devlink *devlink,
-					      struct netlink_callback *cb,
-					      int flags)
-{
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_trap_group_item *group_item;
-	int idx = 0;
-	int err = 0;
-
-
-	list_for_each_entry(group_item, &devlink->trap_group_list, list) {
-		if (idx < state->idx) {
-			idx++;
-			continue;
-		}
-		err = devlink_nl_trap_group_fill(msg, devlink, group_item,
-						 DEVLINK_CMD_TRAP_GROUP_NEW,
-						 NETLINK_CB(cb->skb).portid,
-						 cb->nlh->nlmsg_seq, flags);
-		if (err) {
-			state->idx = idx;
-			break;
-		}
-		idx++;
-	}
-
-	return err;
-}
-
-int devlink_nl_trap_group_get_dumpit(struct sk_buff *skb,
-				     struct netlink_callback *cb)
-{
-	return devlink_nl_dumpit(skb, cb, devlink_nl_trap_group_get_dump_one);
-}
-
-static int
-__devlink_trap_group_action_set(struct devlink *devlink,
-				struct devlink_trap_group_item *group_item,
-				enum devlink_trap_action trap_action,
-				struct netlink_ext_ack *extack)
-{
-	const char *group_name = group_item->group->name;
-	struct devlink_trap_item *trap_item;
-	int err;
-
-	if (devlink->ops->trap_group_action_set) {
-		err = devlink->ops->trap_group_action_set(devlink, group_item->group,
-							  trap_action, extack);
-		if (err)
-			return err;
-
-		list_for_each_entry(trap_item, &devlink->trap_list, list) {
-			if (strcmp(trap_item->group_item->group->name, group_name))
-				continue;
-			if (trap_item->action != trap_action &&
-			    trap_item->trap->type != DEVLINK_TRAP_TYPE_DROP)
-				continue;
-			trap_item->action = trap_action;
-		}
-
-		return 0;
-	}
-
-	list_for_each_entry(trap_item, &devlink->trap_list, list) {
-		if (strcmp(trap_item->group_item->group->name, group_name))
-			continue;
-		err = __devlink_trap_action_set(devlink, trap_item,
-						trap_action, extack);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
-static int
-devlink_trap_group_action_set(struct devlink *devlink,
-			      struct devlink_trap_group_item *group_item,
-			      struct genl_info *info, bool *p_modified)
-{
-	enum devlink_trap_action trap_action;
-	int err;
-
-	if (!info->attrs[DEVLINK_ATTR_TRAP_ACTION])
-		return 0;
-
-	err = devlink_trap_action_get_from_info(info, &trap_action);
-	if (err) {
-		NL_SET_ERR_MSG(info->extack, "Invalid trap action");
-		return -EINVAL;
-	}
-
-	err = __devlink_trap_group_action_set(devlink, group_item, trap_action,
-					      info->extack);
-	if (err)
-		return err;
-
-	*p_modified = true;
-
-	return 0;
-}
-
-static int devlink_trap_group_set(struct devlink *devlink,
-				  struct devlink_trap_group_item *group_item,
-				  struct genl_info *info)
-{
-	struct devlink_trap_policer_item *policer_item;
-	struct netlink_ext_ack *extack = info->extack;
-	const struct devlink_trap_policer *policer;
-	struct nlattr **attrs = info->attrs;
-	u32 policer_id;
-	int err;
-
-	if (!attrs[DEVLINK_ATTR_TRAP_POLICER_ID])
-		return 0;
-
-	if (!devlink->ops->trap_group_set)
-		return -EOPNOTSUPP;
-
-	policer_id = nla_get_u32(attrs[DEVLINK_ATTR_TRAP_POLICER_ID]);
-	policer_item = devlink_trap_policer_item_lookup(devlink, policer_id);
-	if (policer_id && !policer_item) {
-		NL_SET_ERR_MSG(extack, "Device did not register this trap policer");
-		return -ENOENT;
-	}
-	policer = policer_item ? policer_item->policer : NULL;
-
-	err = devlink->ops->trap_group_set(devlink, group_item->group, policer,
-					   extack);
-	if (err)
-		return err;
-
-	group_item->policer_item = policer_item;
-
-	return 0;
-}
-
-static int devlink_nl_cmd_trap_group_set_doit(struct sk_buff *skb,
-					      struct genl_info *info)
-{
-	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_trap_group_item *group_item;
-	bool modified = false;
-	int err;
-
-	if (list_empty(&devlink->trap_group_list))
-		return -EOPNOTSUPP;
-
-	group_item = devlink_trap_group_item_get_from_info(devlink, info);
-	if (!group_item) {
-		NL_SET_ERR_MSG(extack, "Device did not register this trap group");
-		return -ENOENT;
-	}
-
-	err = devlink_trap_group_action_set(devlink, group_item, info,
-					    &modified);
-	if (err)
-		return err;
-
-	err = devlink_trap_group_set(devlink, group_item, info);
-	if (err)
-		goto err_trap_group_set;
-
-	return 0;
-
-err_trap_group_set:
-	if (modified)
-		NL_SET_ERR_MSG(extack, "Trap group set failed, but some changes were committed already");
-	return err;
-}
-
-static struct devlink_trap_policer_item *
-devlink_trap_policer_item_get_from_info(struct devlink *devlink,
-					struct genl_info *info)
-{
-	u32 id;
-
-	if (!info->attrs[DEVLINK_ATTR_TRAP_POLICER_ID])
-		return NULL;
-	id = nla_get_u32(info->attrs[DEVLINK_ATTR_TRAP_POLICER_ID]);
-
-	return devlink_trap_policer_item_lookup(devlink, id);
-}
-
-static int
-devlink_trap_policer_stats_put(struct sk_buff *msg, struct devlink *devlink,
-			       const struct devlink_trap_policer *policer)
-{
-	struct nlattr *attr;
-	u64 drops;
-	int err;
-
-	if (!devlink->ops->trap_policer_counter_get)
-		return 0;
-
-	err = devlink->ops->trap_policer_counter_get(devlink, policer, &drops);
-	if (err)
-		return err;
-
-	attr = nla_nest_start(msg, DEVLINK_ATTR_STATS);
-	if (!attr)
-		return -EMSGSIZE;
-
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_DROPPED, drops,
-			      DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	nla_nest_end(msg, attr);
-
-	return 0;
-
-nla_put_failure:
-	nla_nest_cancel(msg, attr);
-	return -EMSGSIZE;
-}
-
-static int
-devlink_nl_trap_policer_fill(struct sk_buff *msg, struct devlink *devlink,
-			     const struct devlink_trap_policer_item *policer_item,
-			     enum devlink_command cmd, u32 portid, u32 seq,
-			     int flags)
-{
-	void *hdr;
-	int err;
-
-	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
-	if (!hdr)
-		return -EMSGSIZE;
-
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-
-	if (nla_put_u32(msg, DEVLINK_ATTR_TRAP_POLICER_ID,
-			policer_item->policer->id))
-		goto nla_put_failure;
-
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_TRAP_POLICER_RATE,
-			      policer_item->rate, DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_TRAP_POLICER_BURST,
-			      policer_item->burst, DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	err = devlink_trap_policer_stats_put(msg, devlink,
-					     policer_item->policer);
-	if (err)
-		goto nla_put_failure;
-
-	genlmsg_end(msg, hdr);
-
-	return 0;
-
-nla_put_failure:
-	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
-}
-
-int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
-				     struct genl_info *info)
-{
-	struct devlink_trap_policer_item *policer_item;
-	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
-	struct sk_buff *msg;
-	int err;
-
-	if (list_empty(&devlink->trap_policer_list))
-		return -EOPNOTSUPP;
-
-	policer_item = devlink_trap_policer_item_get_from_info(devlink, info);
-	if (!policer_item) {
-		NL_SET_ERR_MSG(extack, "Device did not register this trap policer");
-		return -ENOENT;
-	}
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	err = devlink_nl_trap_policer_fill(msg, devlink, policer_item,
-					   DEVLINK_CMD_TRAP_POLICER_NEW,
-					   info->snd_portid, info->snd_seq, 0);
-	if (err)
-		goto err_trap_policer_fill;
-
-	return genlmsg_reply(msg, info);
-
-err_trap_policer_fill:
-	nlmsg_free(msg);
-	return err;
-}
-
-static int devlink_nl_trap_policer_get_dump_one(struct sk_buff *msg,
-						struct devlink *devlink,
-						struct netlink_callback *cb,
-						int flags)
-{
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_trap_policer_item *policer_item;
-	int idx = 0;
-	int err = 0;
-
-	list_for_each_entry(policer_item, &devlink->trap_policer_list, list) {
-		if (idx < state->idx) {
-			idx++;
-			continue;
-		}
-		err = devlink_nl_trap_policer_fill(msg, devlink, policer_item,
-						   DEVLINK_CMD_TRAP_POLICER_NEW,
-						   NETLINK_CB(cb->skb).portid,
-						   cb->nlh->nlmsg_seq, flags);
-		if (err) {
-			state->idx = idx;
-			break;
-		}
-		idx++;
-	}
-
-	return err;
-}
-
-int devlink_nl_trap_policer_get_dumpit(struct sk_buff *skb,
-				       struct netlink_callback *cb)
-{
-	return devlink_nl_dumpit(skb, cb, devlink_nl_trap_policer_get_dump_one);
-}
-
-static int
-devlink_trap_policer_set(struct devlink *devlink,
-			 struct devlink_trap_policer_item *policer_item,
-			 struct genl_info *info)
-{
-	struct netlink_ext_ack *extack = info->extack;
-	struct nlattr **attrs = info->attrs;
-	u64 rate, burst;
-	int err;
-
-	rate = policer_item->rate;
-	burst = policer_item->burst;
-
-	if (attrs[DEVLINK_ATTR_TRAP_POLICER_RATE])
-		rate = nla_get_u64(attrs[DEVLINK_ATTR_TRAP_POLICER_RATE]);
-
-	if (attrs[DEVLINK_ATTR_TRAP_POLICER_BURST])
-		burst = nla_get_u64(attrs[DEVLINK_ATTR_TRAP_POLICER_BURST]);
-
-	if (rate < policer_item->policer->min_rate) {
-		NL_SET_ERR_MSG(extack, "Policer rate lower than limit");
-		return -EINVAL;
-	}
-
-	if (rate > policer_item->policer->max_rate) {
-		NL_SET_ERR_MSG(extack, "Policer rate higher than limit");
-		return -EINVAL;
-	}
-
-	if (burst < policer_item->policer->min_burst) {
-		NL_SET_ERR_MSG(extack, "Policer burst size lower than limit");
-		return -EINVAL;
-	}
-
-	if (burst > policer_item->policer->max_burst) {
-		NL_SET_ERR_MSG(extack, "Policer burst size higher than limit");
-		return -EINVAL;
-	}
-
-	err = devlink->ops->trap_policer_set(devlink, policer_item->policer,
-					     rate, burst, info->extack);
-	if (err)
-		return err;
-
-	policer_item->rate = rate;
-	policer_item->burst = burst;
-
-	return 0;
-}
-
-static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
-						struct genl_info *info)
-{
-	struct devlink_trap_policer_item *policer_item;
-	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
-
-	if (list_empty(&devlink->trap_policer_list))
-		return -EOPNOTSUPP;
-
-	if (!devlink->ops->trap_policer_set)
-		return -EOPNOTSUPP;
-
-	policer_item = devlink_trap_policer_item_get_from_info(devlink, info);
-	if (!policer_item) {
-		NL_SET_ERR_MSG(extack, "Device did not register this trap policer");
-		return -ENOENT;
-	}
-
-	return devlink_trap_policer_set(devlink, policer_item, info);
-}
-
-const struct genl_small_ops devlink_nl_small_ops[40] = {
-	{
-		.cmd = DEVLINK_CMD_PORT_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_RATE_SET,
-		.doit = devlink_nl_cmd_rate_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RATE_NEW,
-		.doit = devlink_nl_cmd_rate_new_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RATE_DEL,
-		.doit = devlink_nl_cmd_rate_del_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_SPLIT,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_split_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_UNSPLIT,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_unsplit_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_NEW,
-		.doit = devlink_nl_cmd_port_new_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_DEL,
-		.doit = devlink_nl_cmd_port_del_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-
-	{
-		.cmd = DEVLINK_CMD_LINECARD_SET,
-		.doit = devlink_nl_cmd_linecard_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_POOL_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_pool_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_PORT_POOL_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_port_pool_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_tc_pool_bind_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_OCC_SNAPSHOT,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_occ_snapshot_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_OCC_MAX_CLEAR,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_sb_occ_max_clear_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_ESWITCH_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_eswitch_get_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_ESWITCH_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_eswitch_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_TABLE_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_table_get,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_ENTRIES_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_entries_get,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_HEADERS_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_headers_get,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_dpipe_table_counters_set,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RESOURCE_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_resource_set,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RESOURCE_DUMP,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_resource_dump,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_RELOAD,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_reload,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PARAM_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_param_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_PARAM_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_param_get_doit,
-		.dumpit = devlink_nl_cmd_port_param_get_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_PARAM_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_port_param_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_REGION_NEW,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_region_new,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_REGION_DEL,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_region_del,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_REGION_READ,
-		.validate = GENL_DONT_VALIDATE_STRICT |
-			    GENL_DONT_VALIDATE_DUMP_STRICT,
-		.dumpit = devlink_nl_cmd_region_read_dumpit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_RECOVER,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_recover_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_diagnose_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT |
-			    GENL_DONT_VALIDATE_DUMP_STRICT,
-		.dumpit = devlink_nl_cmd_health_reporter_dump_get_dumpit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_dump_clear_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_TEST,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_health_reporter_test_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_FLASH_UPDATE,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_cmd_flash_update,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_SET,
-		.doit = devlink_nl_cmd_trap_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_GROUP_SET,
-		.doit = devlink_nl_cmd_trap_group_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_POLICER_SET,
-		.doit = devlink_nl_cmd_trap_policer_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SELFTESTS_RUN,
-		.doit = devlink_nl_cmd_selftests_run,
-		.flags = GENL_ADMIN_PERM,
-	},
-	/* -- No new ops here! Use split ops going forward! -- */
-};
-
-static void devlink_trap_policers_notify_register(struct devlink *devlink);
-static void devlink_trap_policers_notify_unregister(struct devlink *devlink);
-static void devlink_trap_groups_notify_register(struct devlink *devlink);
-static void devlink_trap_groups_notify_unregister(struct devlink *devlink);
-static void devlink_traps_notify_register(struct devlink *devlink);
-static void devlink_traps_notify_unregister(struct devlink *devlink);
-
-void devlink_notify_register(struct devlink *devlink)
-{
-	devlink_notify(devlink, DEVLINK_CMD_NEW);
-	devlink_linecards_notify_register(devlink);
-	devlink_ports_notify_register(devlink);
-	devlink_trap_policers_notify_register(devlink);
-	devlink_trap_groups_notify_register(devlink);
-	devlink_traps_notify_register(devlink);
-	devlink_rates_notify_register(devlink);
-	devlink_regions_notify_register(devlink);
-	devlink_params_notify_register(devlink);
-}
-
-void devlink_notify_unregister(struct devlink *devlink)
-{
-	devlink_params_notify_unregister(devlink);
-	devlink_regions_notify_unregister(devlink);
-	devlink_rates_notify_unregister(devlink);
-	devlink_traps_notify_unregister(devlink);
-	devlink_trap_groups_notify_unregister(devlink);
-	devlink_trap_policers_notify_unregister(devlink);
-	devlink_ports_notify_unregister(devlink);
-	devlink_linecards_notify_unregister(devlink);
-	devlink_notify(devlink, DEVLINK_CMD_DEL);
-}
-
-/**
- * devl_rate_node_create - create devlink rate node
- * @devlink: devlink instance
- * @priv: driver private data
- * @node_name: name of the resulting node
- * @parent: parent devlink_rate struct
- *
- * Create devlink rate object of type node
- */
-struct devlink_rate *
-devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
-		      struct devlink_rate *parent)
-{
-	struct devlink_rate *rate_node;
-
-	rate_node = devlink_rate_node_get_by_name(devlink, node_name);
-	if (!IS_ERR(rate_node))
-		return ERR_PTR(-EEXIST);
-
-	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
-	if (!rate_node)
-		return ERR_PTR(-ENOMEM);
-
-	if (parent) {
-		rate_node->parent = parent;
-		refcount_inc(&rate_node->parent->refcnt);
-	}
-
-	rate_node->type = DEVLINK_RATE_TYPE_NODE;
-	rate_node->devlink = devlink;
-	rate_node->priv = priv;
-
-	rate_node->name = kstrdup(node_name, GFP_KERNEL);
-	if (!rate_node->name) {
-		kfree(rate_node);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
-	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
-	return rate_node;
-}
-EXPORT_SYMBOL_GPL(devl_rate_node_create);
-
-/**
- * devl_rate_leaf_create - create devlink rate leaf
- * @devlink_port: devlink port object to create rate object on
- * @priv: driver private data
- * @parent: parent devlink_rate struct
- *
- * Create devlink rate object of type leaf on provided @devlink_port.
- */
-int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
-			  struct devlink_rate *parent)
-{
-	struct devlink *devlink = devlink_port->devlink;
-	struct devlink_rate *devlink_rate;
-
-	devl_assert_locked(devlink_port->devlink);
-
-	if (WARN_ON(devlink_port->devlink_rate))
-		return -EBUSY;
-
-	devlink_rate = kzalloc(sizeof(*devlink_rate), GFP_KERNEL);
-	if (!devlink_rate)
-		return -ENOMEM;
-
-	if (parent) {
-		devlink_rate->parent = parent;
-		refcount_inc(&devlink_rate->parent->refcnt);
-	}
-
-	devlink_rate->type = DEVLINK_RATE_TYPE_LEAF;
-	devlink_rate->devlink = devlink;
-	devlink_rate->devlink_port = devlink_port;
-	devlink_rate->priv = priv;
-	list_add_tail(&devlink_rate->list, &devlink->rate_list);
-	devlink_port->devlink_rate = devlink_rate;
-	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devl_rate_leaf_create);
-
-/**
- * devl_rate_leaf_destroy - destroy devlink rate leaf
- *
- * @devlink_port: devlink port linked to the rate object
- *
- * Destroy the devlink rate object of type leaf on provided @devlink_port.
- */
-void devl_rate_leaf_destroy(struct devlink_port *devlink_port)
-{
-	struct devlink_rate *devlink_rate = devlink_port->devlink_rate;
-
-	devl_assert_locked(devlink_port->devlink);
-	if (!devlink_rate)
-		return;
-
-	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_DEL);
-	if (devlink_rate->parent)
-		refcount_dec(&devlink_rate->parent->refcnt);
-	list_del(&devlink_rate->list);
-	devlink_port->devlink_rate = NULL;
-	kfree(devlink_rate);
-}
-EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
-
-/**
- * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
- * @devlink: devlink instance
- *
- * Unset parent for all rate objects and destroy all rate nodes
- * on specified device.
- */
-void devl_rate_nodes_destroy(struct devlink *devlink)
-{
-	static struct devlink_rate *devlink_rate, *tmp;
-	const struct devlink_ops *ops = devlink->ops;
-
-	devl_assert_locked(devlink);
-
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (!devlink_rate->parent)
-			continue;
-
-		refcount_dec(&devlink_rate->parent->refcnt);
-		if (devlink_rate_is_leaf(devlink_rate))
-			ops->rate_leaf_parent_set(devlink_rate, NULL, devlink_rate->priv,
-						  NULL, NULL);
-		else if (devlink_rate_is_node(devlink_rate))
-			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
-						  NULL, NULL);
-	}
-	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate)) {
-			ops->rate_node_del(devlink_rate, devlink_rate->priv, NULL);
-			list_del(&devlink_rate->list);
-			kfree(devlink_rate->name);
-			kfree(devlink_rate);
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(devl_rate_nodes_destroy);
-
-static int devlink_linecard_types_init(struct devlink_linecard *linecard)
-{
-	struct devlink_linecard_type *linecard_type;
-	unsigned int count;
-	int i;
-
-	count = linecard->ops->types_count(linecard, linecard->priv);
-	linecard->types = kmalloc_array(count, sizeof(*linecard_type),
-					GFP_KERNEL);
-	if (!linecard->types)
-		return -ENOMEM;
-	linecard->types_count = count;
-
-	for (i = 0; i < count; i++) {
-		linecard_type = &linecard->types[i];
-		linecard->ops->types_get(linecard, linecard->priv, i,
-					 &linecard_type->type,
-					 &linecard_type->priv);
-	}
-	return 0;
-}
-
-static void devlink_linecard_types_fini(struct devlink_linecard *linecard)
-{
-	kfree(linecard->types);
-}
-
-/**
- *	devl_linecard_create - Create devlink linecard
- *
- *	@devlink: devlink
- *	@linecard_index: driver-specific numerical identifier of the linecard
- *	@ops: linecards ops
- *	@priv: user priv pointer
- *
- *	Create devlink linecard instance with provided linecard index.
- *	Caller can use any indexing, even hw-related one.
- *
- *	Return: Line card structure or an ERR_PTR() encoded error code.
- */
-struct devlink_linecard *
-devl_linecard_create(struct devlink *devlink, unsigned int linecard_index,
-		     const struct devlink_linecard_ops *ops, void *priv)
-{
-	struct devlink_linecard *linecard;
-	int err;
-
-	if (WARN_ON(!ops || !ops->provision || !ops->unprovision ||
-		    !ops->types_count || !ops->types_get))
-		return ERR_PTR(-EINVAL);
-
-	if (devlink_linecard_index_exists(devlink, linecard_index))
-		return ERR_PTR(-EEXIST);
-
-	linecard = kzalloc(sizeof(*linecard), GFP_KERNEL);
-	if (!linecard)
-		return ERR_PTR(-ENOMEM);
-
-	linecard->devlink = devlink;
-	linecard->index = linecard_index;
-	linecard->ops = ops;
-	linecard->priv = priv;
-	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-	mutex_init(&linecard->state_lock);
-
-	err = devlink_linecard_types_init(linecard);
-	if (err) {
-		mutex_destroy(&linecard->state_lock);
-		kfree(linecard);
-		return ERR_PTR(err);
-	}
-
-	list_add_tail(&linecard->list, &devlink->linecard_list);
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	return linecard;
-}
-EXPORT_SYMBOL_GPL(devl_linecard_create);
-
-/**
- *	devl_linecard_destroy - Destroy devlink linecard
- *
- *	@linecard: devlink linecard
- */
-void devl_linecard_destroy(struct devlink_linecard *linecard)
-{
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
-	list_del(&linecard->list);
-	devlink_linecard_types_fini(linecard);
-	mutex_destroy(&linecard->state_lock);
-	kfree(linecard);
-}
-EXPORT_SYMBOL_GPL(devl_linecard_destroy);
-
-/**
- *	devlink_linecard_provision_set - Set provisioning on linecard
- *
- *	@linecard: devlink linecard
- *	@type: linecard type
- *
- *	This is either called directly from the provision() op call or
- *	as a result of the provision() op call asynchronously.
- */
-void devlink_linecard_provision_set(struct devlink_linecard *linecard,
-				    const char *type)
-{
-	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->type && strcmp(linecard->type, type));
-	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONED;
-	linecard->type = type;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_provision_set);
-
-/**
- *	devlink_linecard_provision_clear - Clear provisioning on linecard
- *
- *	@linecard: devlink linecard
- *
- *	This is either called directly from the unprovision() op call or
- *	as a result of the unprovision() op call asynchronously.
- */
-void devlink_linecard_provision_clear(struct devlink_linecard *linecard)
-{
-	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->nested_devlink);
-	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-	linecard->type = NULL;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_provision_clear);
-
-/**
- *	devlink_linecard_provision_fail - Fail provisioning on linecard
- *
- *	@linecard: devlink linecard
- *
- *	This is either called directly from the provision() op call or
- *	as a result of the provision() op call asynchronously.
- */
-void devlink_linecard_provision_fail(struct devlink_linecard *linecard)
-{
-	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->nested_devlink);
-	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONING_FAILED;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_provision_fail);
-
-/**
- *	devlink_linecard_activate - Set linecard active
- *
- *	@linecard: devlink linecard
- */
-void devlink_linecard_activate(struct devlink_linecard *linecard)
-{
-	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->state != DEVLINK_LINECARD_STATE_PROVISIONED);
-	linecard->state = DEVLINK_LINECARD_STATE_ACTIVE;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_activate);
-
-/**
- *	devlink_linecard_deactivate - Set linecard inactive
- *
- *	@linecard: devlink linecard
- */
-void devlink_linecard_deactivate(struct devlink_linecard *linecard)
-{
-	mutex_lock(&linecard->state_lock);
-	switch (linecard->state) {
-	case DEVLINK_LINECARD_STATE_ACTIVE:
-		linecard->state = DEVLINK_LINECARD_STATE_PROVISIONED;
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-		break;
-	case DEVLINK_LINECARD_STATE_UNPROVISIONING:
-		/* Line card is being deactivated as part
-		 * of unprovisioning flow.
-		 */
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_deactivate);
-
-/**
- *	devlink_linecard_nested_dl_set - Attach/detach nested devlink
- *					 instance to linecard.
- *
- *	@linecard: devlink linecard
- *	@nested_devlink: devlink instance to attach or NULL to detach
- */
-void devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
-				    struct devlink *nested_devlink)
-{
-	mutex_lock(&linecard->state_lock);
-	linecard->nested_devlink = nested_devlink;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_nested_dl_set);
-
-#define DEVLINK_TRAP(_id, _type)					      \
-	{								      \
-		.type = DEVLINK_TRAP_TYPE_##_type,			      \
-		.id = DEVLINK_TRAP_GENERIC_ID_##_id,			      \
-		.name = DEVLINK_TRAP_GENERIC_NAME_##_id,		      \
-	}
-
-static const struct devlink_trap devlink_trap_generic[] = {
-	DEVLINK_TRAP(SMAC_MC, DROP),
-	DEVLINK_TRAP(VLAN_TAG_MISMATCH, DROP),
-	DEVLINK_TRAP(INGRESS_VLAN_FILTER, DROP),
-	DEVLINK_TRAP(INGRESS_STP_FILTER, DROP),
-	DEVLINK_TRAP(EMPTY_TX_LIST, DROP),
-	DEVLINK_TRAP(PORT_LOOPBACK_FILTER, DROP),
-	DEVLINK_TRAP(BLACKHOLE_ROUTE, DROP),
-	DEVLINK_TRAP(TTL_ERROR, EXCEPTION),
-	DEVLINK_TRAP(TAIL_DROP, DROP),
-	DEVLINK_TRAP(NON_IP_PACKET, DROP),
-	DEVLINK_TRAP(UC_DIP_MC_DMAC, DROP),
-	DEVLINK_TRAP(DIP_LB, DROP),
-	DEVLINK_TRAP(SIP_MC, DROP),
-	DEVLINK_TRAP(SIP_LB, DROP),
-	DEVLINK_TRAP(CORRUPTED_IP_HDR, DROP),
-	DEVLINK_TRAP(IPV4_SIP_BC, DROP),
-	DEVLINK_TRAP(IPV6_MC_DIP_RESERVED_SCOPE, DROP),
-	DEVLINK_TRAP(IPV6_MC_DIP_INTERFACE_LOCAL_SCOPE, DROP),
-	DEVLINK_TRAP(MTU_ERROR, EXCEPTION),
-	DEVLINK_TRAP(UNRESOLVED_NEIGH, EXCEPTION),
-	DEVLINK_TRAP(RPF, EXCEPTION),
-	DEVLINK_TRAP(REJECT_ROUTE, EXCEPTION),
-	DEVLINK_TRAP(IPV4_LPM_UNICAST_MISS, EXCEPTION),
-	DEVLINK_TRAP(IPV6_LPM_UNICAST_MISS, EXCEPTION),
-	DEVLINK_TRAP(NON_ROUTABLE, DROP),
-	DEVLINK_TRAP(DECAP_ERROR, EXCEPTION),
-	DEVLINK_TRAP(OVERLAY_SMAC_MC, DROP),
-	DEVLINK_TRAP(INGRESS_FLOW_ACTION_DROP, DROP),
-	DEVLINK_TRAP(EGRESS_FLOW_ACTION_DROP, DROP),
-	DEVLINK_TRAP(STP, CONTROL),
-	DEVLINK_TRAP(LACP, CONTROL),
-	DEVLINK_TRAP(LLDP, CONTROL),
-	DEVLINK_TRAP(IGMP_QUERY, CONTROL),
-	DEVLINK_TRAP(IGMP_V1_REPORT, CONTROL),
-	DEVLINK_TRAP(IGMP_V2_REPORT, CONTROL),
-	DEVLINK_TRAP(IGMP_V3_REPORT, CONTROL),
-	DEVLINK_TRAP(IGMP_V2_LEAVE, CONTROL),
-	DEVLINK_TRAP(MLD_QUERY, CONTROL),
-	DEVLINK_TRAP(MLD_V1_REPORT, CONTROL),
-	DEVLINK_TRAP(MLD_V2_REPORT, CONTROL),
-	DEVLINK_TRAP(MLD_V1_DONE, CONTROL),
-	DEVLINK_TRAP(IPV4_DHCP, CONTROL),
-	DEVLINK_TRAP(IPV6_DHCP, CONTROL),
-	DEVLINK_TRAP(ARP_REQUEST, CONTROL),
-	DEVLINK_TRAP(ARP_RESPONSE, CONTROL),
-	DEVLINK_TRAP(ARP_OVERLAY, CONTROL),
-	DEVLINK_TRAP(IPV6_NEIGH_SOLICIT, CONTROL),
-	DEVLINK_TRAP(IPV6_NEIGH_ADVERT, CONTROL),
-	DEVLINK_TRAP(IPV4_BFD, CONTROL),
-	DEVLINK_TRAP(IPV6_BFD, CONTROL),
-	DEVLINK_TRAP(IPV4_OSPF, CONTROL),
-	DEVLINK_TRAP(IPV6_OSPF, CONTROL),
-	DEVLINK_TRAP(IPV4_BGP, CONTROL),
-	DEVLINK_TRAP(IPV6_BGP, CONTROL),
-	DEVLINK_TRAP(IPV4_VRRP, CONTROL),
-	DEVLINK_TRAP(IPV6_VRRP, CONTROL),
-	DEVLINK_TRAP(IPV4_PIM, CONTROL),
-	DEVLINK_TRAP(IPV6_PIM, CONTROL),
-	DEVLINK_TRAP(UC_LB, CONTROL),
-	DEVLINK_TRAP(LOCAL_ROUTE, CONTROL),
-	DEVLINK_TRAP(EXTERNAL_ROUTE, CONTROL),
-	DEVLINK_TRAP(IPV6_UC_DIP_LINK_LOCAL_SCOPE, CONTROL),
-	DEVLINK_TRAP(IPV6_DIP_ALL_NODES, CONTROL),
-	DEVLINK_TRAP(IPV6_DIP_ALL_ROUTERS, CONTROL),
-	DEVLINK_TRAP(IPV6_ROUTER_SOLICIT, CONTROL),
-	DEVLINK_TRAP(IPV6_ROUTER_ADVERT, CONTROL),
-	DEVLINK_TRAP(IPV6_REDIRECT, CONTROL),
-	DEVLINK_TRAP(IPV4_ROUTER_ALERT, CONTROL),
-	DEVLINK_TRAP(IPV6_ROUTER_ALERT, CONTROL),
-	DEVLINK_TRAP(PTP_EVENT, CONTROL),
-	DEVLINK_TRAP(PTP_GENERAL, CONTROL),
-	DEVLINK_TRAP(FLOW_ACTION_SAMPLE, CONTROL),
-	DEVLINK_TRAP(FLOW_ACTION_TRAP, CONTROL),
-	DEVLINK_TRAP(EARLY_DROP, DROP),
-	DEVLINK_TRAP(VXLAN_PARSING, DROP),
-	DEVLINK_TRAP(LLC_SNAP_PARSING, DROP),
-	DEVLINK_TRAP(VLAN_PARSING, DROP),
-	DEVLINK_TRAP(PPPOE_PPP_PARSING, DROP),
-	DEVLINK_TRAP(MPLS_PARSING, DROP),
-	DEVLINK_TRAP(ARP_PARSING, DROP),
-	DEVLINK_TRAP(IP_1_PARSING, DROP),
-	DEVLINK_TRAP(IP_N_PARSING, DROP),
-	DEVLINK_TRAP(GRE_PARSING, DROP),
-	DEVLINK_TRAP(UDP_PARSING, DROP),
-	DEVLINK_TRAP(TCP_PARSING, DROP),
-	DEVLINK_TRAP(IPSEC_PARSING, DROP),
-	DEVLINK_TRAP(SCTP_PARSING, DROP),
-	DEVLINK_TRAP(DCCP_PARSING, DROP),
-	DEVLINK_TRAP(GTP_PARSING, DROP),
-	DEVLINK_TRAP(ESP_PARSING, DROP),
-	DEVLINK_TRAP(BLACKHOLE_NEXTHOP, DROP),
-	DEVLINK_TRAP(DMAC_FILTER, DROP),
-	DEVLINK_TRAP(EAPOL, CONTROL),
-	DEVLINK_TRAP(LOCKED_PORT, DROP),
-};
-
-#define DEVLINK_TRAP_GROUP(_id)						      \
-	{								      \
-		.id = DEVLINK_TRAP_GROUP_GENERIC_ID_##_id,		      \
-		.name = DEVLINK_TRAP_GROUP_GENERIC_NAME_##_id,		      \
-	}
-
-static const struct devlink_trap_group devlink_trap_group_generic[] = {
-	DEVLINK_TRAP_GROUP(L2_DROPS),
-	DEVLINK_TRAP_GROUP(L3_DROPS),
-	DEVLINK_TRAP_GROUP(L3_EXCEPTIONS),
-	DEVLINK_TRAP_GROUP(BUFFER_DROPS),
-	DEVLINK_TRAP_GROUP(TUNNEL_DROPS),
-	DEVLINK_TRAP_GROUP(ACL_DROPS),
-	DEVLINK_TRAP_GROUP(STP),
-	DEVLINK_TRAP_GROUP(LACP),
-	DEVLINK_TRAP_GROUP(LLDP),
-	DEVLINK_TRAP_GROUP(MC_SNOOPING),
-	DEVLINK_TRAP_GROUP(DHCP),
-	DEVLINK_TRAP_GROUP(NEIGH_DISCOVERY),
-	DEVLINK_TRAP_GROUP(BFD),
-	DEVLINK_TRAP_GROUP(OSPF),
-	DEVLINK_TRAP_GROUP(BGP),
-	DEVLINK_TRAP_GROUP(VRRP),
-	DEVLINK_TRAP_GROUP(PIM),
-	DEVLINK_TRAP_GROUP(UC_LB),
-	DEVLINK_TRAP_GROUP(LOCAL_DELIVERY),
-	DEVLINK_TRAP_GROUP(EXTERNAL_DELIVERY),
-	DEVLINK_TRAP_GROUP(IPV6),
-	DEVLINK_TRAP_GROUP(PTP_EVENT),
-	DEVLINK_TRAP_GROUP(PTP_GENERAL),
-	DEVLINK_TRAP_GROUP(ACL_SAMPLE),
-	DEVLINK_TRAP_GROUP(ACL_TRAP),
-	DEVLINK_TRAP_GROUP(PARSER_ERROR_DROPS),
-	DEVLINK_TRAP_GROUP(EAPOL),
-};
-
-static int devlink_trap_generic_verify(const struct devlink_trap *trap)
-{
-	if (trap->id > DEVLINK_TRAP_GENERIC_ID_MAX)
-		return -EINVAL;
-
-	if (strcmp(trap->name, devlink_trap_generic[trap->id].name))
-		return -EINVAL;
-
-	if (trap->type != devlink_trap_generic[trap->id].type)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int devlink_trap_driver_verify(const struct devlink_trap *trap)
-{
-	int i;
-
-	if (trap->id <= DEVLINK_TRAP_GENERIC_ID_MAX)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(devlink_trap_generic); i++) {
-		if (!strcmp(trap->name, devlink_trap_generic[i].name))
-			return -EEXIST;
-	}
-
-	return 0;
-}
-
-static int devlink_trap_verify(const struct devlink_trap *trap)
-{
-	if (!trap || !trap->name)
-		return -EINVAL;
-
-	if (trap->generic)
-		return devlink_trap_generic_verify(trap);
-	else
-		return devlink_trap_driver_verify(trap);
-}
-
-static int
-devlink_trap_group_generic_verify(const struct devlink_trap_group *group)
-{
-	if (group->id > DEVLINK_TRAP_GROUP_GENERIC_ID_MAX)
-		return -EINVAL;
-
-	if (strcmp(group->name, devlink_trap_group_generic[group->id].name))
-		return -EINVAL;
-
-	return 0;
-}
-
-static int
-devlink_trap_group_driver_verify(const struct devlink_trap_group *group)
-{
-	int i;
-
-	if (group->id <= DEVLINK_TRAP_GROUP_GENERIC_ID_MAX)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(devlink_trap_group_generic); i++) {
-		if (!strcmp(group->name, devlink_trap_group_generic[i].name))
-			return -EEXIST;
-	}
-
-	return 0;
-}
-
-static int devlink_trap_group_verify(const struct devlink_trap_group *group)
-{
-	if (group->generic)
-		return devlink_trap_group_generic_verify(group);
-	else
-		return devlink_trap_group_driver_verify(group);
-}
-
-static void
-devlink_trap_group_notify(struct devlink *devlink,
-			  const struct devlink_trap_group_item *group_item,
-			  enum devlink_command cmd)
-{
-	struct sk_buff *msg;
-	int err;
-
-	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_GROUP_NEW &&
-		     cmd != DEVLINK_CMD_TRAP_GROUP_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
-		return;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return;
-
-	err = devlink_nl_trap_group_fill(msg, devlink, group_item, cmd, 0, 0,
-					 0);
-	if (err) {
-		nlmsg_free(msg);
-		return;
-	}
-
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
-}
-
-static void devlink_trap_groups_notify_register(struct devlink *devlink)
-{
-	struct devlink_trap_group_item *group_item;
+const struct genl_small_ops devlink_nl_small_ops[40] = {
+	{
+		.cmd = DEVLINK_CMD_PORT_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_RATE_SET,
+		.doit = devlink_nl_cmd_rate_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_RATE_NEW,
+		.doit = devlink_nl_cmd_rate_new_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_RATE_DEL,
+		.doit = devlink_nl_cmd_rate_del_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_SPLIT,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_split_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_UNSPLIT,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_unsplit_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_NEW,
+		.doit = devlink_nl_cmd_port_new_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_DEL,
+		.doit = devlink_nl_cmd_port_del_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
 
-	list_for_each_entry(group_item, &devlink->trap_group_list, list)
-		devlink_trap_group_notify(devlink, group_item,
-					  DEVLINK_CMD_TRAP_GROUP_NEW);
-}
+	{
+		.cmd = DEVLINK_CMD_LINECARD_SET,
+		.doit = devlink_nl_cmd_linecard_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_POOL_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_pool_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_PORT_POOL_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_port_pool_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_tc_pool_bind_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_OCC_SNAPSHOT,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_occ_snapshot_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_SB_OCC_MAX_CLEAR,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_sb_occ_max_clear_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_ESWITCH_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_eswitch_get_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_ESWITCH_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_eswitch_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_DPIPE_TABLE_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_dpipe_table_get,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_DPIPE_ENTRIES_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_dpipe_entries_get,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_DPIPE_HEADERS_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_dpipe_headers_get,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_dpipe_table_counters_set,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_RESOURCE_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_resource_set,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_RESOURCE_DUMP,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_resource_dump,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_RELOAD,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_reload,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_PARAM_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_param_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_PARAM_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_param_get_doit,
+		.dumpit = devlink_nl_cmd_port_param_get_dumpit,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+		/* can be retrieved by unprivileged users */
+	},
+	{
+		.cmd = DEVLINK_CMD_PORT_PARAM_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_port_param_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_REGION_NEW,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_region_new,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_REGION_DEL,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_region_del,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_REGION_READ,
+		.validate = GENL_DONT_VALIDATE_STRICT |
+			    GENL_DONT_VALIDATE_DUMP_STRICT,
+		.dumpit = devlink_nl_cmd_region_read_dumpit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_set_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_RECOVER,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_recover_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_diagnose_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT |
+			    GENL_DONT_VALIDATE_DUMP_STRICT,
+		.dumpit = devlink_nl_cmd_health_reporter_dump_get_dumpit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_dump_clear_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_HEALTH_REPORTER_TEST,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_health_reporter_test_doit,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
+	},
+	{
+		.cmd = DEVLINK_CMD_FLASH_UPDATE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = devlink_nl_cmd_flash_update,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_TRAP_SET,
+		.doit = devlink_nl_cmd_trap_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_TRAP_GROUP_SET,
+		.doit = devlink_nl_cmd_trap_group_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_TRAP_POLICER_SET,
+		.doit = devlink_nl_cmd_trap_policer_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = DEVLINK_CMD_SELFTESTS_RUN,
+		.doit = devlink_nl_cmd_selftests_run,
+		.flags = GENL_ADMIN_PERM,
+	},
+	/* -- No new ops here! Use split ops going forward! -- */
+};
 
-static void devlink_trap_groups_notify_unregister(struct devlink *devlink)
+void devlink_notify_register(struct devlink *devlink)
 {
-	struct devlink_trap_group_item *group_item;
-
-	list_for_each_entry_reverse(group_item, &devlink->trap_group_list, list)
-		devlink_trap_group_notify(devlink, group_item,
-					  DEVLINK_CMD_TRAP_GROUP_DEL);
+	devlink_notify(devlink, DEVLINK_CMD_NEW);
+	devlink_linecards_notify_register(devlink);
+	devlink_ports_notify_register(devlink);
+	devlink_trap_policers_notify_register(devlink);
+	devlink_trap_groups_notify_register(devlink);
+	devlink_traps_notify_register(devlink);
+	devlink_rates_notify_register(devlink);
+	devlink_regions_notify_register(devlink);
+	devlink_params_notify_register(devlink);
 }
 
-static int
-devlink_trap_item_group_link(struct devlink *devlink,
-			     struct devlink_trap_item *trap_item)
+void devlink_notify_unregister(struct devlink *devlink)
 {
-	u16 group_id = trap_item->trap->init_group_id;
-	struct devlink_trap_group_item *group_item;
-
-	group_item = devlink_trap_group_item_lookup_by_id(devlink, group_id);
-	if (WARN_ON_ONCE(!group_item))
-		return -EINVAL;
-
-	trap_item->group_item = group_item;
-
-	return 0;
+	devlink_params_notify_unregister(devlink);
+	devlink_regions_notify_unregister(devlink);
+	devlink_rates_notify_unregister(devlink);
+	devlink_traps_notify_unregister(devlink);
+	devlink_trap_groups_notify_unregister(devlink);
+	devlink_trap_policers_notify_unregister(devlink);
+	devlink_ports_notify_unregister(devlink);
+	devlink_linecards_notify_unregister(devlink);
+	devlink_notify(devlink, DEVLINK_CMD_DEL);
 }
 
-static void devlink_trap_notify(struct devlink *devlink,
-				const struct devlink_trap_item *trap_item,
-				enum devlink_command cmd)
+/**
+ * devl_rate_node_create - create devlink rate node
+ * @devlink: devlink instance
+ * @priv: driver private data
+ * @node_name: name of the resulting node
+ * @parent: parent devlink_rate struct
+ *
+ * Create devlink rate object of type node
+ */
+struct devlink_rate *
+devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
+		      struct devlink_rate *parent)
 {
-	struct sk_buff *msg;
-	int err;
+	struct devlink_rate *rate_node;
 
-	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_NEW &&
-		     cmd != DEVLINK_CMD_TRAP_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
-		return;
+	rate_node = devlink_rate_node_get_by_name(devlink, node_name);
+	if (!IS_ERR(rate_node))
+		return ERR_PTR(-EEXIST);
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return;
+	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
+	if (!rate_node)
+		return ERR_PTR(-ENOMEM);
 
-	err = devlink_nl_trap_fill(msg, devlink, trap_item, cmd, 0, 0, 0);
-	if (err) {
-		nlmsg_free(msg);
-		return;
+	if (parent) {
+		rate_node->parent = parent;
+		refcount_inc(&rate_node->parent->refcnt);
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
-}
-
-static void devlink_traps_notify_register(struct devlink *devlink)
-{
-	struct devlink_trap_item *trap_item;
-
-	list_for_each_entry(trap_item, &devlink->trap_list, list)
-		devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_NEW);
-}
-
-static void devlink_traps_notify_unregister(struct devlink *devlink)
-{
-	struct devlink_trap_item *trap_item;
-
-	list_for_each_entry_reverse(trap_item, &devlink->trap_list, list)
-		devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_DEL);
-}
-
-static int
-devlink_trap_register(struct devlink *devlink,
-		      const struct devlink_trap *trap, void *priv)
-{
-	struct devlink_trap_item *trap_item;
-	int err;
-
-	if (devlink_trap_item_lookup(devlink, trap->name))
-		return -EEXIST;
-
-	trap_item = kzalloc(sizeof(*trap_item), GFP_KERNEL);
-	if (!trap_item)
-		return -ENOMEM;
+	rate_node->type = DEVLINK_RATE_TYPE_NODE;
+	rate_node->devlink = devlink;
+	rate_node->priv = priv;
 
-	trap_item->stats = netdev_alloc_pcpu_stats(struct devlink_stats);
-	if (!trap_item->stats) {
-		err = -ENOMEM;
-		goto err_stats_alloc;
+	rate_node->name = kstrdup(node_name, GFP_KERNEL);
+	if (!rate_node->name) {
+		kfree(rate_node);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	trap_item->trap = trap;
-	trap_item->action = trap->init_action;
-	trap_item->priv = priv;
-
-	err = devlink_trap_item_group_link(devlink, trap_item);
-	if (err)
-		goto err_group_link;
-
-	err = devlink->ops->trap_init(devlink, trap, trap_item);
-	if (err)
-		goto err_trap_init;
-
-	list_add_tail(&trap_item->list, &devlink->trap_list);
-	devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_NEW);
-
-	return 0;
-
-err_trap_init:
-err_group_link:
-	free_percpu(trap_item->stats);
-err_stats_alloc:
-	kfree(trap_item);
-	return err;
-}
-
-static void devlink_trap_unregister(struct devlink *devlink,
-				    const struct devlink_trap *trap)
-{
-	struct devlink_trap_item *trap_item;
-
-	trap_item = devlink_trap_item_lookup(devlink, trap->name);
-	if (WARN_ON_ONCE(!trap_item))
-		return;
-
-	devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_DEL);
-	list_del(&trap_item->list);
-	if (devlink->ops->trap_fini)
-		devlink->ops->trap_fini(devlink, trap, trap_item);
-	free_percpu(trap_item->stats);
-	kfree(trap_item);
-}
-
-static void devlink_trap_disable(struct devlink *devlink,
-				 const struct devlink_trap *trap)
-{
-	struct devlink_trap_item *trap_item;
-
-	trap_item = devlink_trap_item_lookup(devlink, trap->name);
-	if (WARN_ON_ONCE(!trap_item))
-		return;
-
-	devlink->ops->trap_action_set(devlink, trap, DEVLINK_TRAP_ACTION_DROP,
-				      NULL);
-	trap_item->action = DEVLINK_TRAP_ACTION_DROP;
+	refcount_set(&rate_node->refcnt, 1);
+	list_add(&rate_node->list, &devlink->rate_list);
+	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	return rate_node;
 }
+EXPORT_SYMBOL_GPL(devl_rate_node_create);
 
 /**
- * devl_traps_register - Register packet traps with devlink.
- * @devlink: devlink.
- * @traps: Packet traps.
- * @traps_count: Count of provided packet traps.
- * @priv: Driver private information.
+ * devl_rate_leaf_create - create devlink rate leaf
+ * @devlink_port: devlink port object to create rate object on
+ * @priv: driver private data
+ * @parent: parent devlink_rate struct
  *
- * Return: Non-zero value on failure.
+ * Create devlink rate object of type leaf on provided @devlink_port.
  */
-int devl_traps_register(struct devlink *devlink,
-			const struct devlink_trap *traps,
-			size_t traps_count, void *priv)
+int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
+			  struct devlink_rate *parent)
 {
-	int i, err;
+	struct devlink *devlink = devlink_port->devlink;
+	struct devlink_rate *devlink_rate;
 
-	if (!devlink->ops->trap_init || !devlink->ops->trap_action_set)
-		return -EINVAL;
+	devl_assert_locked(devlink_port->devlink);
 
-	devl_assert_locked(devlink);
-	for (i = 0; i < traps_count; i++) {
-		const struct devlink_trap *trap = &traps[i];
+	if (WARN_ON(devlink_port->devlink_rate))
+		return -EBUSY;
 
-		err = devlink_trap_verify(trap);
-		if (err)
-			goto err_trap_verify;
+	devlink_rate = kzalloc(sizeof(*devlink_rate), GFP_KERNEL);
+	if (!devlink_rate)
+		return -ENOMEM;
 
-		err = devlink_trap_register(devlink, trap, priv);
-		if (err)
-			goto err_trap_register;
+	if (parent) {
+		devlink_rate->parent = parent;
+		refcount_inc(&devlink_rate->parent->refcnt);
 	}
 
-	return 0;
+	devlink_rate->type = DEVLINK_RATE_TYPE_LEAF;
+	devlink_rate->devlink = devlink;
+	devlink_rate->devlink_port = devlink_port;
+	devlink_rate->priv = priv;
+	list_add_tail(&devlink_rate->list, &devlink->rate_list);
+	devlink_port->devlink_rate = devlink_rate;
+	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
 
-err_trap_register:
-err_trap_verify:
-	for (i--; i >= 0; i--)
-		devlink_trap_unregister(devlink, &traps[i]);
-	return err;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(devl_traps_register);
+EXPORT_SYMBOL_GPL(devl_rate_leaf_create);
 
 /**
- * devlink_traps_register - Register packet traps with devlink.
- * @devlink: devlink.
- * @traps: Packet traps.
- * @traps_count: Count of provided packet traps.
- * @priv: Driver private information.
- *
- * Context: Takes and release devlink->lock <mutex>.
+ * devl_rate_leaf_destroy - destroy devlink rate leaf
  *
- * Return: Non-zero value on failure.
- */
-int devlink_traps_register(struct devlink *devlink,
-			   const struct devlink_trap *traps,
-			   size_t traps_count, void *priv)
-{
-	int err;
-
-	devl_lock(devlink);
-	err = devl_traps_register(devlink, traps, traps_count, priv);
-	devl_unlock(devlink);
-	return err;
-}
-EXPORT_SYMBOL_GPL(devlink_traps_register);
-
-/**
- * devl_traps_unregister - Unregister packet traps from devlink.
- * @devlink: devlink.
- * @traps: Packet traps.
- * @traps_count: Count of provided packet traps.
- */
-void devl_traps_unregister(struct devlink *devlink,
-			   const struct devlink_trap *traps,
-			   size_t traps_count)
-{
-	int i;
-
-	devl_assert_locked(devlink);
-	/* Make sure we do not have any packets in-flight while unregistering
-	 * traps by disabling all of them and waiting for a grace period.
-	 */
-	for (i = traps_count - 1; i >= 0; i--)
-		devlink_trap_disable(devlink, &traps[i]);
-	synchronize_rcu();
-	for (i = traps_count - 1; i >= 0; i--)
-		devlink_trap_unregister(devlink, &traps[i]);
-}
-EXPORT_SYMBOL_GPL(devl_traps_unregister);
-
-/**
- * devlink_traps_unregister - Unregister packet traps from devlink.
- * @devlink: devlink.
- * @traps: Packet traps.
- * @traps_count: Count of provided packet traps.
+ * @devlink_port: devlink port linked to the rate object
  *
- * Context: Takes and release devlink->lock <mutex>.
- */
-void devlink_traps_unregister(struct devlink *devlink,
-			      const struct devlink_trap *traps,
-			      size_t traps_count)
-{
-	devl_lock(devlink);
-	devl_traps_unregister(devlink, traps, traps_count);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_traps_unregister);
-
-static void
-devlink_trap_stats_update(struct devlink_stats __percpu *trap_stats,
-			  size_t skb_len)
-{
-	struct devlink_stats *stats;
-
-	stats = this_cpu_ptr(trap_stats);
-	u64_stats_update_begin(&stats->syncp);
-	u64_stats_add(&stats->rx_bytes, skb_len);
-	u64_stats_inc(&stats->rx_packets);
-	u64_stats_update_end(&stats->syncp);
-}
-
-static void
-devlink_trap_report_metadata_set(struct devlink_trap_metadata *metadata,
-				 const struct devlink_trap_item *trap_item,
-				 struct devlink_port *in_devlink_port,
-				 const struct flow_action_cookie *fa_cookie)
-{
-	metadata->trap_name = trap_item->trap->name;
-	metadata->trap_group_name = trap_item->group_item->group->name;
-	metadata->fa_cookie = fa_cookie;
-	metadata->trap_type = trap_item->trap->type;
-
-	spin_lock(&in_devlink_port->type_lock);
-	if (in_devlink_port->type == DEVLINK_PORT_TYPE_ETH)
-		metadata->input_dev = in_devlink_port->type_eth.netdev;
-	spin_unlock(&in_devlink_port->type_lock);
-}
-
-/**
- * devlink_trap_report - Report trapped packet to drop monitor.
- * @devlink: devlink.
- * @skb: Trapped packet.
- * @trap_ctx: Trap context.
- * @in_devlink_port: Input devlink port.
- * @fa_cookie: Flow action cookie. Could be NULL.
+ * Destroy the devlink rate object of type leaf on provided @devlink_port.
  */
-void devlink_trap_report(struct devlink *devlink, struct sk_buff *skb,
-			 void *trap_ctx, struct devlink_port *in_devlink_port,
-			 const struct flow_action_cookie *fa_cookie)
-
+void devl_rate_leaf_destroy(struct devlink_port *devlink_port)
 {
-	struct devlink_trap_item *trap_item = trap_ctx;
-
-	devlink_trap_stats_update(trap_item->stats, skb->len);
-	devlink_trap_stats_update(trap_item->group_item->stats, skb->len);
+	struct devlink_rate *devlink_rate = devlink_port->devlink_rate;
 
-	if (tracepoint_enabled(devlink_trap_report)) {
-		struct devlink_trap_metadata metadata = {};
+	devl_assert_locked(devlink_port->devlink);
+	if (!devlink_rate)
+		return;
 
-		devlink_trap_report_metadata_set(&metadata, trap_item,
-						 in_devlink_port, fa_cookie);
-		trace_devlink_trap_report(devlink, skb, &metadata);
-	}
+	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_DEL);
+	if (devlink_rate->parent)
+		refcount_dec(&devlink_rate->parent->refcnt);
+	list_del(&devlink_rate->list);
+	devlink_port->devlink_rate = NULL;
+	kfree(devlink_rate);
 }
-EXPORT_SYMBOL_GPL(devlink_trap_report);
+EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
 
 /**
- * devlink_trap_ctx_priv - Trap context to driver private information.
- * @trap_ctx: Trap context.
+ * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
+ * @devlink: devlink instance
  *
- * Return: Driver private information passed during registration.
+ * Unset parent for all rate objects and destroy all rate nodes
+ * on specified device.
  */
-void *devlink_trap_ctx_priv(void *trap_ctx)
-{
-	struct devlink_trap_item *trap_item = trap_ctx;
-
-	return trap_item->priv;
-}
-EXPORT_SYMBOL_GPL(devlink_trap_ctx_priv);
-
-static int
-devlink_trap_group_item_policer_link(struct devlink *devlink,
-				     struct devlink_trap_group_item *group_item)
-{
-	u32 policer_id = group_item->group->init_policer_id;
-	struct devlink_trap_policer_item *policer_item;
-
-	if (policer_id == 0)
-		return 0;
-
-	policer_item = devlink_trap_policer_item_lookup(devlink, policer_id);
-	if (WARN_ON_ONCE(!policer_item))
-		return -EINVAL;
-
-	group_item->policer_item = policer_item;
-
-	return 0;
-}
-
-static int
-devlink_trap_group_register(struct devlink *devlink,
-			    const struct devlink_trap_group *group)
+void devl_rate_nodes_destroy(struct devlink *devlink)
 {
-	struct devlink_trap_group_item *group_item;
-	int err;
+	static struct devlink_rate *devlink_rate, *tmp;
+	const struct devlink_ops *ops = devlink->ops;
 
-	if (devlink_trap_group_item_lookup(devlink, group->name))
-		return -EEXIST;
+	devl_assert_locked(devlink);
 
-	group_item = kzalloc(sizeof(*group_item), GFP_KERNEL);
-	if (!group_item)
-		return -ENOMEM;
+	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+		if (!devlink_rate->parent)
+			continue;
 
-	group_item->stats = netdev_alloc_pcpu_stats(struct devlink_stats);
-	if (!group_item->stats) {
-		err = -ENOMEM;
-		goto err_stats_alloc;
+		refcount_dec(&devlink_rate->parent->refcnt);
+		if (devlink_rate_is_leaf(devlink_rate))
+			ops->rate_leaf_parent_set(devlink_rate, NULL, devlink_rate->priv,
+						  NULL, NULL);
+		else if (devlink_rate_is_node(devlink_rate))
+			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
+						  NULL, NULL);
+	}
+	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
+		if (devlink_rate_is_node(devlink_rate)) {
+			ops->rate_node_del(devlink_rate, devlink_rate->priv, NULL);
+			list_del(&devlink_rate->list);
+			kfree(devlink_rate->name);
+			kfree(devlink_rate);
+		}
 	}
+}
+EXPORT_SYMBOL_GPL(devl_rate_nodes_destroy);
 
-	group_item->group = group;
+static int devlink_linecard_types_init(struct devlink_linecard *linecard)
+{
+	struct devlink_linecard_type *linecard_type;
+	unsigned int count;
+	int i;
 
-	err = devlink_trap_group_item_policer_link(devlink, group_item);
-	if (err)
-		goto err_policer_link;
+	count = linecard->ops->types_count(linecard, linecard->priv);
+	linecard->types = kmalloc_array(count, sizeof(*linecard_type),
+					GFP_KERNEL);
+	if (!linecard->types)
+		return -ENOMEM;
+	linecard->types_count = count;
 
-	if (devlink->ops->trap_group_init) {
-		err = devlink->ops->trap_group_init(devlink, group);
-		if (err)
-			goto err_group_init;
+	for (i = 0; i < count; i++) {
+		linecard_type = &linecard->types[i];
+		linecard->ops->types_get(linecard, linecard->priv, i,
+					 &linecard_type->type,
+					 &linecard_type->priv);
 	}
-
-	list_add_tail(&group_item->list, &devlink->trap_group_list);
-	devlink_trap_group_notify(devlink, group_item,
-				  DEVLINK_CMD_TRAP_GROUP_NEW);
-
 	return 0;
-
-err_group_init:
-err_policer_link:
-	free_percpu(group_item->stats);
-err_stats_alloc:
-	kfree(group_item);
-	return err;
 }
 
-static void
-devlink_trap_group_unregister(struct devlink *devlink,
-			      const struct devlink_trap_group *group)
+static void devlink_linecard_types_fini(struct devlink_linecard *linecard)
 {
-	struct devlink_trap_group_item *group_item;
-
-	group_item = devlink_trap_group_item_lookup(devlink, group->name);
-	if (WARN_ON_ONCE(!group_item))
-		return;
-
-	devlink_trap_group_notify(devlink, group_item,
-				  DEVLINK_CMD_TRAP_GROUP_DEL);
-	list_del(&group_item->list);
-	free_percpu(group_item->stats);
-	kfree(group_item);
+	kfree(linecard->types);
 }
 
 /**
- * devl_trap_groups_register - Register packet trap groups with devlink.
- * @devlink: devlink.
- * @groups: Packet trap groups.
- * @groups_count: Count of provided packet trap groups.
+ *	devl_linecard_create - Create devlink linecard
+ *
+ *	@devlink: devlink
+ *	@linecard_index: driver-specific numerical identifier of the linecard
+ *	@ops: linecards ops
+ *	@priv: user priv pointer
  *
- * Return: Non-zero value on failure.
+ *	Create devlink linecard instance with provided linecard index.
+ *	Caller can use any indexing, even hw-related one.
+ *
+ *	Return: Line card structure or an ERR_PTR() encoded error code.
  */
-int devl_trap_groups_register(struct devlink *devlink,
-			      const struct devlink_trap_group *groups,
-			      size_t groups_count)
+struct devlink_linecard *
+devl_linecard_create(struct devlink *devlink, unsigned int linecard_index,
+		     const struct devlink_linecard_ops *ops, void *priv)
 {
-	int i, err;
+	struct devlink_linecard *linecard;
+	int err;
 
-	devl_assert_locked(devlink);
-	for (i = 0; i < groups_count; i++) {
-		const struct devlink_trap_group *group = &groups[i];
+	if (WARN_ON(!ops || !ops->provision || !ops->unprovision ||
+		    !ops->types_count || !ops->types_get))
+		return ERR_PTR(-EINVAL);
 
-		err = devlink_trap_group_verify(group);
-		if (err)
-			goto err_trap_group_verify;
+	if (devlink_linecard_index_exists(devlink, linecard_index))
+		return ERR_PTR(-EEXIST);
 
-		err = devlink_trap_group_register(devlink, group);
-		if (err)
-			goto err_trap_group_register;
-	}
+	linecard = kzalloc(sizeof(*linecard), GFP_KERNEL);
+	if (!linecard)
+		return ERR_PTR(-ENOMEM);
 
-	return 0;
+	linecard->devlink = devlink;
+	linecard->index = linecard_index;
+	linecard->ops = ops;
+	linecard->priv = priv;
+	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+	mutex_init(&linecard->state_lock);
 
-err_trap_group_register:
-err_trap_group_verify:
-	for (i--; i >= 0; i--)
-		devlink_trap_group_unregister(devlink, &groups[i]);
-	return err;
+	err = devlink_linecard_types_init(linecard);
+	if (err) {
+		mutex_destroy(&linecard->state_lock);
+		kfree(linecard);
+		return ERR_PTR(err);
+	}
+
+	list_add_tail(&linecard->list, &devlink->linecard_list);
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	return linecard;
 }
-EXPORT_SYMBOL_GPL(devl_trap_groups_register);
+EXPORT_SYMBOL_GPL(devl_linecard_create);
 
 /**
- * devlink_trap_groups_register - Register packet trap groups with devlink.
- * @devlink: devlink.
- * @groups: Packet trap groups.
- * @groups_count: Count of provided packet trap groups.
- *
- * Context: Takes and release devlink->lock <mutex>.
+ *	devl_linecard_destroy - Destroy devlink linecard
  *
- * Return: Non-zero value on failure.
+ *	@linecard: devlink linecard
  */
-int devlink_trap_groups_register(struct devlink *devlink,
-				 const struct devlink_trap_group *groups,
-				 size_t groups_count)
+void devl_linecard_destroy(struct devlink_linecard *linecard)
 {
-	int err;
-
-	devl_lock(devlink);
-	err = devl_trap_groups_register(devlink, groups, groups_count);
-	devl_unlock(devlink);
-	return err;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
+	list_del(&linecard->list);
+	devlink_linecard_types_fini(linecard);
+	mutex_destroy(&linecard->state_lock);
+	kfree(linecard);
 }
-EXPORT_SYMBOL_GPL(devlink_trap_groups_register);
+EXPORT_SYMBOL_GPL(devl_linecard_destroy);
 
 /**
- * devl_trap_groups_unregister - Unregister packet trap groups from devlink.
- * @devlink: devlink.
- * @groups: Packet trap groups.
- * @groups_count: Count of provided packet trap groups.
+ *	devlink_linecard_provision_set - Set provisioning on linecard
+ *
+ *	@linecard: devlink linecard
+ *	@type: linecard type
+ *
+ *	This is either called directly from the provision() op call or
+ *	as a result of the provision() op call asynchronously.
  */
-void devl_trap_groups_unregister(struct devlink *devlink,
-				 const struct devlink_trap_group *groups,
-				 size_t groups_count)
+void devlink_linecard_provision_set(struct devlink_linecard *linecard,
+				    const char *type)
 {
-	int i;
-
-	devl_assert_locked(devlink);
-	for (i = groups_count - 1; i >= 0; i--)
-		devlink_trap_group_unregister(devlink, &groups[i]);
+	mutex_lock(&linecard->state_lock);
+	WARN_ON(linecard->type && strcmp(linecard->type, type));
+	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONED;
+	linecard->type = type;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
 }
-EXPORT_SYMBOL_GPL(devl_trap_groups_unregister);
+EXPORT_SYMBOL_GPL(devlink_linecard_provision_set);
 
 /**
- * devlink_trap_groups_unregister - Unregister packet trap groups from devlink.
- * @devlink: devlink.
- * @groups: Packet trap groups.
- * @groups_count: Count of provided packet trap groups.
+ *	devlink_linecard_provision_clear - Clear provisioning on linecard
+ *
+ *	@linecard: devlink linecard
  *
- * Context: Takes and release devlink->lock <mutex>.
+ *	This is either called directly from the unprovision() op call or
+ *	as a result of the unprovision() op call asynchronously.
  */
-void devlink_trap_groups_unregister(struct devlink *devlink,
-				    const struct devlink_trap_group *groups,
-				    size_t groups_count)
-{
-	devl_lock(devlink);
-	devl_trap_groups_unregister(devlink, groups, groups_count);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_trap_groups_unregister);
-
-static void
-devlink_trap_policer_notify(struct devlink *devlink,
-			    const struct devlink_trap_policer_item *policer_item,
-			    enum devlink_command cmd)
-{
-	struct sk_buff *msg;
-	int err;
-
-	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_POLICER_NEW &&
-		     cmd != DEVLINK_CMD_TRAP_POLICER_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
-		return;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return;
-
-	err = devlink_nl_trap_policer_fill(msg, devlink, policer_item, cmd, 0,
-					   0, 0);
-	if (err) {
-		nlmsg_free(msg);
-		return;
-	}
-
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
-}
-
-static void devlink_trap_policers_notify_register(struct devlink *devlink)
-{
-	struct devlink_trap_policer_item *policer_item;
-
-	list_for_each_entry(policer_item, &devlink->trap_policer_list, list)
-		devlink_trap_policer_notify(devlink, policer_item,
-					    DEVLINK_CMD_TRAP_POLICER_NEW);
-}
-
-static void devlink_trap_policers_notify_unregister(struct devlink *devlink)
+void devlink_linecard_provision_clear(struct devlink_linecard *linecard)
 {
-	struct devlink_trap_policer_item *policer_item;
-
-	list_for_each_entry_reverse(policer_item, &devlink->trap_policer_list,
-				    list)
-		devlink_trap_policer_notify(devlink, policer_item,
-					    DEVLINK_CMD_TRAP_POLICER_DEL);
+	mutex_lock(&linecard->state_lock);
+	WARN_ON(linecard->nested_devlink);
+	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+	linecard->type = NULL;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
 }
+EXPORT_SYMBOL_GPL(devlink_linecard_provision_clear);
 
-static int
-devlink_trap_policer_register(struct devlink *devlink,
-			      const struct devlink_trap_policer *policer)
+/**
+ *	devlink_linecard_provision_fail - Fail provisioning on linecard
+ *
+ *	@linecard: devlink linecard
+ *
+ *	This is either called directly from the provision() op call or
+ *	as a result of the provision() op call asynchronously.
+ */
+void devlink_linecard_provision_fail(struct devlink_linecard *linecard)
 {
-	struct devlink_trap_policer_item *policer_item;
-	int err;
-
-	if (devlink_trap_policer_item_lookup(devlink, policer->id))
-		return -EEXIST;
-
-	policer_item = kzalloc(sizeof(*policer_item), GFP_KERNEL);
-	if (!policer_item)
-		return -ENOMEM;
-
-	policer_item->policer = policer;
-	policer_item->rate = policer->init_rate;
-	policer_item->burst = policer->init_burst;
-
-	if (devlink->ops->trap_policer_init) {
-		err = devlink->ops->trap_policer_init(devlink, policer);
-		if (err)
-			goto err_policer_init;
-	}
-
-	list_add_tail(&policer_item->list, &devlink->trap_policer_list);
-	devlink_trap_policer_notify(devlink, policer_item,
-				    DEVLINK_CMD_TRAP_POLICER_NEW);
-
-	return 0;
-
-err_policer_init:
-	kfree(policer_item);
-	return err;
+	mutex_lock(&linecard->state_lock);
+	WARN_ON(linecard->nested_devlink);
+	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONING_FAILED;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
 }
+EXPORT_SYMBOL_GPL(devlink_linecard_provision_fail);
 
-static void
-devlink_trap_policer_unregister(struct devlink *devlink,
-				const struct devlink_trap_policer *policer)
+/**
+ *	devlink_linecard_activate - Set linecard active
+ *
+ *	@linecard: devlink linecard
+ */
+void devlink_linecard_activate(struct devlink_linecard *linecard)
 {
-	struct devlink_trap_policer_item *policer_item;
-
-	policer_item = devlink_trap_policer_item_lookup(devlink, policer->id);
-	if (WARN_ON_ONCE(!policer_item))
-		return;
-
-	devlink_trap_policer_notify(devlink, policer_item,
-				    DEVLINK_CMD_TRAP_POLICER_DEL);
-	list_del(&policer_item->list);
-	if (devlink->ops->trap_policer_fini)
-		devlink->ops->trap_policer_fini(devlink, policer);
-	kfree(policer_item);
+	mutex_lock(&linecard->state_lock);
+	WARN_ON(linecard->state != DEVLINK_LINECARD_STATE_PROVISIONED);
+	linecard->state = DEVLINK_LINECARD_STATE_ACTIVE;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
 }
+EXPORT_SYMBOL_GPL(devlink_linecard_activate);
 
 /**
- * devl_trap_policers_register - Register packet trap policers with devlink.
- * @devlink: devlink.
- * @policers: Packet trap policers.
- * @policers_count: Count of provided packet trap policers.
+ *	devlink_linecard_deactivate - Set linecard inactive
  *
- * Return: Non-zero value on failure.
+ *	@linecard: devlink linecard
  */
-int
-devl_trap_policers_register(struct devlink *devlink,
-			    const struct devlink_trap_policer *policers,
-			    size_t policers_count)
+void devlink_linecard_deactivate(struct devlink_linecard *linecard)
 {
-	int i, err;
-
-	devl_assert_locked(devlink);
-	for (i = 0; i < policers_count; i++) {
-		const struct devlink_trap_policer *policer = &policers[i];
-
-		if (WARN_ON(policer->id == 0 ||
-			    policer->max_rate < policer->min_rate ||
-			    policer->max_burst < policer->min_burst)) {
-			err = -EINVAL;
-			goto err_trap_policer_verify;
-		}
-
-		err = devlink_trap_policer_register(devlink, policer);
-		if (err)
-			goto err_trap_policer_register;
+	mutex_lock(&linecard->state_lock);
+	switch (linecard->state) {
+	case DEVLINK_LINECARD_STATE_ACTIVE:
+		linecard->state = DEVLINK_LINECARD_STATE_PROVISIONED;
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+		break;
+	case DEVLINK_LINECARD_STATE_UNPROVISIONING:
+		/* Line card is being deactivated as part
+		 * of unprovisioning flow.
+		 */
+		break;
+	default:
+		WARN_ON(1);
+		break;
 	}
-	return 0;
-
-err_trap_policer_register:
-err_trap_policer_verify:
-	for (i--; i >= 0; i--)
-		devlink_trap_policer_unregister(devlink, &policers[i]);
-	return err;
+	mutex_unlock(&linecard->state_lock);
 }
-EXPORT_SYMBOL_GPL(devl_trap_policers_register);
+EXPORT_SYMBOL_GPL(devlink_linecard_deactivate);
 
 /**
- * devl_trap_policers_unregister - Unregister packet trap policers from devlink.
- * @devlink: devlink.
- * @policers: Packet trap policers.
- * @policers_count: Count of provided packet trap policers.
+ *	devlink_linecard_nested_dl_set - Attach/detach nested devlink
+ *					 instance to linecard.
+ *
+ *	@linecard: devlink linecard
+ *	@nested_devlink: devlink instance to attach or NULL to detach
  */
-void
-devl_trap_policers_unregister(struct devlink *devlink,
-			      const struct devlink_trap_policer *policers,
-			      size_t policers_count)
+void devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
+				    struct devlink *nested_devlink)
 {
-	int i;
-
-	devl_assert_locked(devlink);
-	for (i = policers_count - 1; i >= 0; i--)
-		devlink_trap_policer_unregister(devlink, &policers[i]);
+	mutex_lock(&linecard->state_lock);
+	linecard->nested_devlink = nested_devlink;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
 }
-EXPORT_SYMBOL_GPL(devl_trap_policers_unregister);
+EXPORT_SYMBOL_GPL(devlink_linecard_nested_dl_set);
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
new file mode 100644
index 000000000000..c26bf9b29bca
--- /dev/null
+++ b/net/devlink/trap.c
@@ -0,0 +1,1861 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
+ */
+
+#include <trace/events/devlink.h>
+
+#include "devl_internal.h"
+
+struct devlink_stats {
+	u64_stats_t rx_bytes;
+	u64_stats_t rx_packets;
+	struct u64_stats_sync syncp;
+};
+
+/**
+ * struct devlink_trap_policer_item - Packet trap policer attributes.
+ * @policer: Immutable packet trap policer attributes.
+ * @rate: Rate in packets / sec.
+ * @burst: Burst size in packets.
+ * @list: trap_policer_list member.
+ *
+ * Describes packet trap policer attributes. Created by devlink during trap
+ * policer registration.
+ */
+struct devlink_trap_policer_item {
+	const struct devlink_trap_policer *policer;
+	u64 rate;
+	u64 burst;
+	struct list_head list;
+};
+
+/**
+ * struct devlink_trap_group_item - Packet trap group attributes.
+ * @group: Immutable packet trap group attributes.
+ * @policer_item: Associated policer item. Can be NULL.
+ * @list: trap_group_list member.
+ * @stats: Trap group statistics.
+ *
+ * Describes packet trap group attributes. Created by devlink during trap
+ * group registration.
+ */
+struct devlink_trap_group_item {
+	const struct devlink_trap_group *group;
+	struct devlink_trap_policer_item *policer_item;
+	struct list_head list;
+	struct devlink_stats __percpu *stats;
+};
+
+/**
+ * struct devlink_trap_item - Packet trap attributes.
+ * @trap: Immutable packet trap attributes.
+ * @group_item: Associated group item.
+ * @list: trap_list member.
+ * @action: Trap action.
+ * @stats: Trap statistics.
+ * @priv: Driver private information.
+ *
+ * Describes both mutable and immutable packet trap attributes. Created by
+ * devlink during trap registration and used for all trap related operations.
+ */
+struct devlink_trap_item {
+	const struct devlink_trap *trap;
+	struct devlink_trap_group_item *group_item;
+	struct list_head list;
+	enum devlink_trap_action action;
+	struct devlink_stats __percpu *stats;
+	void *priv;
+};
+
+static struct devlink_trap_policer_item *
+devlink_trap_policer_item_lookup(struct devlink *devlink, u32 id)
+{
+	struct devlink_trap_policer_item *policer_item;
+
+	list_for_each_entry(policer_item, &devlink->trap_policer_list, list) {
+		if (policer_item->policer->id == id)
+			return policer_item;
+	}
+
+	return NULL;
+}
+
+static struct devlink_trap_item *
+devlink_trap_item_lookup(struct devlink *devlink, const char *name)
+{
+	struct devlink_trap_item *trap_item;
+
+	list_for_each_entry(trap_item, &devlink->trap_list, list) {
+		if (!strcmp(trap_item->trap->name, name))
+			return trap_item;
+	}
+
+	return NULL;
+}
+
+static struct devlink_trap_item *
+devlink_trap_item_get_from_info(struct devlink *devlink,
+				struct genl_info *info)
+{
+	struct nlattr *attr;
+
+	if (!info->attrs[DEVLINK_ATTR_TRAP_NAME])
+		return NULL;
+	attr = info->attrs[DEVLINK_ATTR_TRAP_NAME];
+
+	return devlink_trap_item_lookup(devlink, nla_data(attr));
+}
+
+static int
+devlink_trap_action_get_from_info(struct genl_info *info,
+				  enum devlink_trap_action *p_trap_action)
+{
+	u8 val;
+
+	val = nla_get_u8(info->attrs[DEVLINK_ATTR_TRAP_ACTION]);
+	switch (val) {
+	case DEVLINK_TRAP_ACTION_DROP:
+	case DEVLINK_TRAP_ACTION_TRAP:
+	case DEVLINK_TRAP_ACTION_MIRROR:
+		*p_trap_action = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int devlink_trap_metadata_put(struct sk_buff *msg,
+				     const struct devlink_trap *trap)
+{
+	struct nlattr *attr;
+
+	attr = nla_nest_start(msg, DEVLINK_ATTR_TRAP_METADATA);
+	if (!attr)
+		return -EMSGSIZE;
+
+	if ((trap->metadata_cap & DEVLINK_TRAP_METADATA_TYPE_F_IN_PORT) &&
+	    nla_put_flag(msg, DEVLINK_ATTR_TRAP_METADATA_TYPE_IN_PORT))
+		goto nla_put_failure;
+	if ((trap->metadata_cap & DEVLINK_TRAP_METADATA_TYPE_F_FA_COOKIE) &&
+	    nla_put_flag(msg, DEVLINK_ATTR_TRAP_METADATA_TYPE_FA_COOKIE))
+		goto nla_put_failure;
+
+	nla_nest_end(msg, attr);
+
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, attr);
+	return -EMSGSIZE;
+}
+
+static void devlink_trap_stats_read(struct devlink_stats __percpu *trap_stats,
+				    struct devlink_stats *stats)
+{
+	int i;
+
+	memset(stats, 0, sizeof(*stats));
+	for_each_possible_cpu(i) {
+		struct devlink_stats *cpu_stats;
+		u64 rx_packets, rx_bytes;
+		unsigned int start;
+
+		cpu_stats = per_cpu_ptr(trap_stats, i);
+		do {
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
+			rx_packets = u64_stats_read(&cpu_stats->rx_packets);
+			rx_bytes = u64_stats_read(&cpu_stats->rx_bytes);
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
+
+		u64_stats_add(&stats->rx_packets, rx_packets);
+		u64_stats_add(&stats->rx_bytes, rx_bytes);
+	}
+}
+
+static int
+devlink_trap_group_stats_put(struct sk_buff *msg,
+			     struct devlink_stats __percpu *trap_stats)
+{
+	struct devlink_stats stats;
+	struct nlattr *attr;
+
+	devlink_trap_stats_read(trap_stats, &stats);
+
+	attr = nla_nest_start(msg, DEVLINK_ATTR_STATS);
+	if (!attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_PACKETS,
+			      u64_stats_read(&stats.rx_packets),
+			      DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_BYTES,
+			      u64_stats_read(&stats.rx_bytes),
+			      DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	nla_nest_end(msg, attr);
+
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, attr);
+	return -EMSGSIZE;
+}
+
+static int devlink_trap_stats_put(struct sk_buff *msg, struct devlink *devlink,
+				  const struct devlink_trap_item *trap_item)
+{
+	struct devlink_stats stats;
+	struct nlattr *attr;
+	u64 drops = 0;
+	int err;
+
+	if (devlink->ops->trap_drop_counter_get) {
+		err = devlink->ops->trap_drop_counter_get(devlink,
+							  trap_item->trap,
+							  &drops);
+		if (err)
+			return err;
+	}
+
+	devlink_trap_stats_read(trap_item->stats, &stats);
+
+	attr = nla_nest_start(msg, DEVLINK_ATTR_STATS);
+	if (!attr)
+		return -EMSGSIZE;
+
+	if (devlink->ops->trap_drop_counter_get &&
+	    nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_DROPPED, drops,
+			      DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_PACKETS,
+			      u64_stats_read(&stats.rx_packets),
+			      DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_BYTES,
+			      u64_stats_read(&stats.rx_bytes),
+			      DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	nla_nest_end(msg, attr);
+
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, attr);
+	return -EMSGSIZE;
+}
+
+static int devlink_nl_trap_fill(struct sk_buff *msg, struct devlink *devlink,
+				const struct devlink_trap_item *trap_item,
+				enum devlink_command cmd, u32 portid, u32 seq,
+				int flags)
+{
+	struct devlink_trap_group_item *group_item = trap_item->group_item;
+	void *hdr;
+	int err;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+
+	if (nla_put_string(msg, DEVLINK_ATTR_TRAP_GROUP_NAME,
+			   group_item->group->name))
+		goto nla_put_failure;
+
+	if (nla_put_string(msg, DEVLINK_ATTR_TRAP_NAME, trap_item->trap->name))
+		goto nla_put_failure;
+
+	if (nla_put_u8(msg, DEVLINK_ATTR_TRAP_TYPE, trap_item->trap->type))
+		goto nla_put_failure;
+
+	if (trap_item->trap->generic &&
+	    nla_put_flag(msg, DEVLINK_ATTR_TRAP_GENERIC))
+		goto nla_put_failure;
+
+	if (nla_put_u8(msg, DEVLINK_ATTR_TRAP_ACTION, trap_item->action))
+		goto nla_put_failure;
+
+	err = devlink_trap_metadata_put(msg, trap_item->trap);
+	if (err)
+		goto nla_put_failure;
+
+	err = devlink_trap_stats_put(msg, devlink, trap_item);
+	if (err)
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_trap_item *trap_item;
+	struct sk_buff *msg;
+	int err;
+
+	if (list_empty(&devlink->trap_list))
+		return -EOPNOTSUPP;
+
+	trap_item = devlink_trap_item_get_from_info(devlink, info);
+	if (!trap_item) {
+		NL_SET_ERR_MSG(extack, "Device did not register this trap");
+		return -ENOENT;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_trap_fill(msg, devlink, trap_item,
+				   DEVLINK_CMD_TRAP_NEW, info->snd_portid,
+				   info->snd_seq, 0);
+	if (err)
+		goto err_trap_fill;
+
+	return genlmsg_reply(msg, info);
+
+err_trap_fill:
+	nlmsg_free(msg);
+	return err;
+}
+
+static int devlink_nl_trap_get_dump_one(struct sk_buff *msg,
+					struct devlink *devlink,
+					struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_trap_item *trap_item;
+	int idx = 0;
+	int err = 0;
+
+	list_for_each_entry(trap_item, &devlink->trap_list, list) {
+		if (idx < state->idx) {
+			idx++;
+			continue;
+		}
+		err = devlink_nl_trap_fill(msg, devlink, trap_item,
+					   DEVLINK_CMD_TRAP_NEW,
+					   NETLINK_CB(cb->skb).portid,
+					   cb->nlh->nlmsg_seq, flags);
+		if (err) {
+			state->idx = idx;
+			break;
+		}
+		idx++;
+	}
+
+	return err;
+}
+
+int devlink_nl_trap_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_trap_get_dump_one);
+}
+
+static int __devlink_trap_action_set(struct devlink *devlink,
+				     struct devlink_trap_item *trap_item,
+				     enum devlink_trap_action trap_action,
+				     struct netlink_ext_ack *extack)
+{
+	int err;
+
+	if (trap_item->action != trap_action &&
+	    trap_item->trap->type != DEVLINK_TRAP_TYPE_DROP) {
+		NL_SET_ERR_MSG(extack, "Cannot change action of non-drop traps. Skipping");
+		return 0;
+	}
+
+	err = devlink->ops->trap_action_set(devlink, trap_item->trap,
+					    trap_action, extack);
+	if (err)
+		return err;
+
+	trap_item->action = trap_action;
+
+	return 0;
+}
+
+static int devlink_trap_action_set(struct devlink *devlink,
+				   struct devlink_trap_item *trap_item,
+				   struct genl_info *info)
+{
+	enum devlink_trap_action trap_action;
+	int err;
+
+	if (!info->attrs[DEVLINK_ATTR_TRAP_ACTION])
+		return 0;
+
+	err = devlink_trap_action_get_from_info(info, &trap_action);
+	if (err) {
+		NL_SET_ERR_MSG(info->extack, "Invalid trap action");
+		return -EINVAL;
+	}
+
+	return __devlink_trap_action_set(devlink, trap_item, trap_action,
+					 info->extack);
+}
+
+int devlink_nl_cmd_trap_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_trap_item *trap_item;
+
+	if (list_empty(&devlink->trap_list))
+		return -EOPNOTSUPP;
+
+	trap_item = devlink_trap_item_get_from_info(devlink, info);
+	if (!trap_item) {
+		NL_SET_ERR_MSG(extack, "Device did not register this trap");
+		return -ENOENT;
+	}
+
+	return devlink_trap_action_set(devlink, trap_item, info);
+}
+
+static struct devlink_trap_group_item *
+devlink_trap_group_item_lookup(struct devlink *devlink, const char *name)
+{
+	struct devlink_trap_group_item *group_item;
+
+	list_for_each_entry(group_item, &devlink->trap_group_list, list) {
+		if (!strcmp(group_item->group->name, name))
+			return group_item;
+	}
+
+	return NULL;
+}
+
+static struct devlink_trap_group_item *
+devlink_trap_group_item_lookup_by_id(struct devlink *devlink, u16 id)
+{
+	struct devlink_trap_group_item *group_item;
+
+	list_for_each_entry(group_item, &devlink->trap_group_list, list) {
+		if (group_item->group->id == id)
+			return group_item;
+	}
+
+	return NULL;
+}
+
+static struct devlink_trap_group_item *
+devlink_trap_group_item_get_from_info(struct devlink *devlink,
+				      struct genl_info *info)
+{
+	char *name;
+
+	if (!info->attrs[DEVLINK_ATTR_TRAP_GROUP_NAME])
+		return NULL;
+	name = nla_data(info->attrs[DEVLINK_ATTR_TRAP_GROUP_NAME]);
+
+	return devlink_trap_group_item_lookup(devlink, name);
+}
+
+static int
+devlink_nl_trap_group_fill(struct sk_buff *msg, struct devlink *devlink,
+			   const struct devlink_trap_group_item *group_item,
+			   enum devlink_command cmd, u32 portid, u32 seq,
+			   int flags)
+{
+	void *hdr;
+	int err;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+
+	if (nla_put_string(msg, DEVLINK_ATTR_TRAP_GROUP_NAME,
+			   group_item->group->name))
+		goto nla_put_failure;
+
+	if (group_item->group->generic &&
+	    nla_put_flag(msg, DEVLINK_ATTR_TRAP_GENERIC))
+		goto nla_put_failure;
+
+	if (group_item->policer_item &&
+	    nla_put_u32(msg, DEVLINK_ATTR_TRAP_POLICER_ID,
+			group_item->policer_item->policer->id))
+		goto nla_put_failure;
+
+	err = devlink_trap_group_stats_put(msg, group_item->stats);
+	if (err)
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_trap_group_item *group_item;
+	struct sk_buff *msg;
+	int err;
+
+	if (list_empty(&devlink->trap_group_list))
+		return -EOPNOTSUPP;
+
+	group_item = devlink_trap_group_item_get_from_info(devlink, info);
+	if (!group_item) {
+		NL_SET_ERR_MSG(extack, "Device did not register this trap group");
+		return -ENOENT;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_trap_group_fill(msg, devlink, group_item,
+					 DEVLINK_CMD_TRAP_GROUP_NEW,
+					 info->snd_portid, info->snd_seq, 0);
+	if (err)
+		goto err_trap_group_fill;
+
+	return genlmsg_reply(msg, info);
+
+err_trap_group_fill:
+	nlmsg_free(msg);
+	return err;
+}
+
+static int devlink_nl_trap_group_get_dump_one(struct sk_buff *msg,
+					      struct devlink *devlink,
+					      struct netlink_callback *cb,
+					      int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_trap_group_item *group_item;
+	int idx = 0;
+	int err = 0;
+
+	list_for_each_entry(group_item, &devlink->trap_group_list, list) {
+		if (idx < state->idx) {
+			idx++;
+			continue;
+		}
+		err = devlink_nl_trap_group_fill(msg, devlink, group_item,
+						 DEVLINK_CMD_TRAP_GROUP_NEW,
+						 NETLINK_CB(cb->skb).portid,
+						 cb->nlh->nlmsg_seq, flags);
+		if (err) {
+			state->idx = idx;
+			break;
+		}
+		idx++;
+	}
+
+	return err;
+}
+
+int devlink_nl_trap_group_get_dumpit(struct sk_buff *skb,
+				     struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_trap_group_get_dump_one);
+}
+
+static int
+__devlink_trap_group_action_set(struct devlink *devlink,
+				struct devlink_trap_group_item *group_item,
+				enum devlink_trap_action trap_action,
+				struct netlink_ext_ack *extack)
+{
+	const char *group_name = group_item->group->name;
+	struct devlink_trap_item *trap_item;
+	int err;
+
+	if (devlink->ops->trap_group_action_set) {
+		err = devlink->ops->trap_group_action_set(devlink, group_item->group,
+							  trap_action, extack);
+		if (err)
+			return err;
+
+		list_for_each_entry(trap_item, &devlink->trap_list, list) {
+			if (strcmp(trap_item->group_item->group->name, group_name))
+				continue;
+			if (trap_item->action != trap_action &&
+			    trap_item->trap->type != DEVLINK_TRAP_TYPE_DROP)
+				continue;
+			trap_item->action = trap_action;
+		}
+
+		return 0;
+	}
+
+	list_for_each_entry(trap_item, &devlink->trap_list, list) {
+		if (strcmp(trap_item->group_item->group->name, group_name))
+			continue;
+		err = __devlink_trap_action_set(devlink, trap_item,
+						trap_action, extack);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+devlink_trap_group_action_set(struct devlink *devlink,
+			      struct devlink_trap_group_item *group_item,
+			      struct genl_info *info, bool *p_modified)
+{
+	enum devlink_trap_action trap_action;
+	int err;
+
+	if (!info->attrs[DEVLINK_ATTR_TRAP_ACTION])
+		return 0;
+
+	err = devlink_trap_action_get_from_info(info, &trap_action);
+	if (err) {
+		NL_SET_ERR_MSG(info->extack, "Invalid trap action");
+		return -EINVAL;
+	}
+
+	err = __devlink_trap_group_action_set(devlink, group_item, trap_action,
+					      info->extack);
+	if (err)
+		return err;
+
+	*p_modified = true;
+
+	return 0;
+}
+
+static int devlink_trap_group_set(struct devlink *devlink,
+				  struct devlink_trap_group_item *group_item,
+				  struct genl_info *info)
+{
+	struct devlink_trap_policer_item *policer_item;
+	struct netlink_ext_ack *extack = info->extack;
+	const struct devlink_trap_policer *policer;
+	struct nlattr **attrs = info->attrs;
+	u32 policer_id;
+	int err;
+
+	if (!attrs[DEVLINK_ATTR_TRAP_POLICER_ID])
+		return 0;
+
+	if (!devlink->ops->trap_group_set)
+		return -EOPNOTSUPP;
+
+	policer_id = nla_get_u32(attrs[DEVLINK_ATTR_TRAP_POLICER_ID]);
+	policer_item = devlink_trap_policer_item_lookup(devlink, policer_id);
+	if (policer_id && !policer_item) {
+		NL_SET_ERR_MSG(extack, "Device did not register this trap policer");
+		return -ENOENT;
+	}
+	policer = policer_item ? policer_item->policer : NULL;
+
+	err = devlink->ops->trap_group_set(devlink, group_item->group, policer,
+					   extack);
+	if (err)
+		return err;
+
+	group_item->policer_item = policer_item;
+
+	return 0;
+}
+
+int devlink_nl_cmd_trap_group_set_doit(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_trap_group_item *group_item;
+	bool modified = false;
+	int err;
+
+	if (list_empty(&devlink->trap_group_list))
+		return -EOPNOTSUPP;
+
+	group_item = devlink_trap_group_item_get_from_info(devlink, info);
+	if (!group_item) {
+		NL_SET_ERR_MSG(extack, "Device did not register this trap group");
+		return -ENOENT;
+	}
+
+	err = devlink_trap_group_action_set(devlink, group_item, info,
+					    &modified);
+	if (err)
+		return err;
+
+	err = devlink_trap_group_set(devlink, group_item, info);
+	if (err)
+		goto err_trap_group_set;
+
+	return 0;
+
+err_trap_group_set:
+	if (modified)
+		NL_SET_ERR_MSG(extack, "Trap group set failed, but some changes were committed already");
+	return err;
+}
+
+static struct devlink_trap_policer_item *
+devlink_trap_policer_item_get_from_info(struct devlink *devlink,
+					struct genl_info *info)
+{
+	u32 id;
+
+	if (!info->attrs[DEVLINK_ATTR_TRAP_POLICER_ID])
+		return NULL;
+	id = nla_get_u32(info->attrs[DEVLINK_ATTR_TRAP_POLICER_ID]);
+
+	return devlink_trap_policer_item_lookup(devlink, id);
+}
+
+static int
+devlink_trap_policer_stats_put(struct sk_buff *msg, struct devlink *devlink,
+			       const struct devlink_trap_policer *policer)
+{
+	struct nlattr *attr;
+	u64 drops;
+	int err;
+
+	if (!devlink->ops->trap_policer_counter_get)
+		return 0;
+
+	err = devlink->ops->trap_policer_counter_get(devlink, policer, &drops);
+	if (err)
+		return err;
+
+	attr = nla_nest_start(msg, DEVLINK_ATTR_STATS);
+	if (!attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_DROPPED, drops,
+			      DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	nla_nest_end(msg, attr);
+
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, attr);
+	return -EMSGSIZE;
+}
+
+static int
+devlink_nl_trap_policer_fill(struct sk_buff *msg, struct devlink *devlink,
+			     const struct devlink_trap_policer_item *policer_item,
+			     enum devlink_command cmd, u32 portid, u32 seq,
+			     int flags)
+{
+	void *hdr;
+	int err;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, DEVLINK_ATTR_TRAP_POLICER_ID,
+			policer_item->policer->id))
+		goto nla_put_failure;
+
+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_TRAP_POLICER_RATE,
+			      policer_item->rate, DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_TRAP_POLICER_BURST,
+			      policer_item->burst, DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	err = devlink_trap_policer_stats_put(msg, devlink,
+					     policer_item->policer);
+	if (err)
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct devlink_trap_policer_item *policer_item;
+	struct netlink_ext_ack *extack = info->extack;
+	struct devlink *devlink = info->user_ptr[0];
+	struct sk_buff *msg;
+	int err;
+
+	if (list_empty(&devlink->trap_policer_list))
+		return -EOPNOTSUPP;
+
+	policer_item = devlink_trap_policer_item_get_from_info(devlink, info);
+	if (!policer_item) {
+		NL_SET_ERR_MSG(extack, "Device did not register this trap policer");
+		return -ENOENT;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_trap_policer_fill(msg, devlink, policer_item,
+					   DEVLINK_CMD_TRAP_POLICER_NEW,
+					   info->snd_portid, info->snd_seq, 0);
+	if (err)
+		goto err_trap_policer_fill;
+
+	return genlmsg_reply(msg, info);
+
+err_trap_policer_fill:
+	nlmsg_free(msg);
+	return err;
+}
+
+static int devlink_nl_trap_policer_get_dump_one(struct sk_buff *msg,
+						struct devlink *devlink,
+						struct netlink_callback *cb,
+						int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_trap_policer_item *policer_item;
+	int idx = 0;
+	int err = 0;
+
+	list_for_each_entry(policer_item, &devlink->trap_policer_list, list) {
+		if (idx < state->idx) {
+			idx++;
+			continue;
+		}
+		err = devlink_nl_trap_policer_fill(msg, devlink, policer_item,
+						   DEVLINK_CMD_TRAP_POLICER_NEW,
+						   NETLINK_CB(cb->skb).portid,
+						   cb->nlh->nlmsg_seq, flags);
+		if (err) {
+			state->idx = idx;
+			break;
+		}
+		idx++;
+	}
+
+	return err;
+}
+
+int devlink_nl_trap_policer_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_trap_policer_get_dump_one);
+}
+
+static int
+devlink_trap_policer_set(struct devlink *devlink,
+			 struct devlink_trap_policer_item *policer_item,
+			 struct genl_info *info)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	struct nlattr **attrs = info->attrs;
+	u64 rate, burst;
+	int err;
+
+	rate = policer_item->rate;
+	burst = policer_item->burst;
+
+	if (attrs[DEVLINK_ATTR_TRAP_POLICER_RATE])
+		rate = nla_get_u64(attrs[DEVLINK_ATTR_TRAP_POLICER_RATE]);
+
+	if (attrs[DEVLINK_ATTR_TRAP_POLICER_BURST])
+		burst = nla_get_u64(attrs[DEVLINK_ATTR_TRAP_POLICER_BURST]);
+
+	if (rate < policer_item->policer->min_rate) {
+		NL_SET_ERR_MSG(extack, "Policer rate lower than limit");
+		return -EINVAL;
+	}
+
+	if (rate > policer_item->policer->max_rate) {
+		NL_SET_ERR_MSG(extack, "Policer rate higher than limit");
+		return -EINVAL;
+	}
+
+	if (burst < policer_item->policer->min_burst) {
+		NL_SET_ERR_MSG(extack, "Policer burst size lower than limit");
+		return -EINVAL;
+	}
+
+	if (burst > policer_item->policer->max_burst) {
+		NL_SET_ERR_MSG(extack, "Policer burst size higher than limit");
+		return -EINVAL;
+	}
+
+	err = devlink->ops->trap_policer_set(devlink, policer_item->policer,
+					     rate, burst, info->extack);
+	if (err)
+		return err;
+
+	policer_item->rate = rate;
+	policer_item->burst = burst;
+
+	return 0;
+}
+
+int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	struct devlink_trap_policer_item *policer_item;
+	struct netlink_ext_ack *extack = info->extack;
+	struct devlink *devlink = info->user_ptr[0];
+
+	if (list_empty(&devlink->trap_policer_list))
+		return -EOPNOTSUPP;
+
+	if (!devlink->ops->trap_policer_set)
+		return -EOPNOTSUPP;
+
+	policer_item = devlink_trap_policer_item_get_from_info(devlink, info);
+	if (!policer_item) {
+		NL_SET_ERR_MSG(extack, "Device did not register this trap policer");
+		return -ENOENT;
+	}
+
+	return devlink_trap_policer_set(devlink, policer_item, info);
+}
+
+#define DEVLINK_TRAP(_id, _type)					      \
+	{								      \
+		.type = DEVLINK_TRAP_TYPE_##_type,			      \
+		.id = DEVLINK_TRAP_GENERIC_ID_##_id,			      \
+		.name = DEVLINK_TRAP_GENERIC_NAME_##_id,		      \
+	}
+
+static const struct devlink_trap devlink_trap_generic[] = {
+	DEVLINK_TRAP(SMAC_MC, DROP),
+	DEVLINK_TRAP(VLAN_TAG_MISMATCH, DROP),
+	DEVLINK_TRAP(INGRESS_VLAN_FILTER, DROP),
+	DEVLINK_TRAP(INGRESS_STP_FILTER, DROP),
+	DEVLINK_TRAP(EMPTY_TX_LIST, DROP),
+	DEVLINK_TRAP(PORT_LOOPBACK_FILTER, DROP),
+	DEVLINK_TRAP(BLACKHOLE_ROUTE, DROP),
+	DEVLINK_TRAP(TTL_ERROR, EXCEPTION),
+	DEVLINK_TRAP(TAIL_DROP, DROP),
+	DEVLINK_TRAP(NON_IP_PACKET, DROP),
+	DEVLINK_TRAP(UC_DIP_MC_DMAC, DROP),
+	DEVLINK_TRAP(DIP_LB, DROP),
+	DEVLINK_TRAP(SIP_MC, DROP),
+	DEVLINK_TRAP(SIP_LB, DROP),
+	DEVLINK_TRAP(CORRUPTED_IP_HDR, DROP),
+	DEVLINK_TRAP(IPV4_SIP_BC, DROP),
+	DEVLINK_TRAP(IPV6_MC_DIP_RESERVED_SCOPE, DROP),
+	DEVLINK_TRAP(IPV6_MC_DIP_INTERFACE_LOCAL_SCOPE, DROP),
+	DEVLINK_TRAP(MTU_ERROR, EXCEPTION),
+	DEVLINK_TRAP(UNRESOLVED_NEIGH, EXCEPTION),
+	DEVLINK_TRAP(RPF, EXCEPTION),
+	DEVLINK_TRAP(REJECT_ROUTE, EXCEPTION),
+	DEVLINK_TRAP(IPV4_LPM_UNICAST_MISS, EXCEPTION),
+	DEVLINK_TRAP(IPV6_LPM_UNICAST_MISS, EXCEPTION),
+	DEVLINK_TRAP(NON_ROUTABLE, DROP),
+	DEVLINK_TRAP(DECAP_ERROR, EXCEPTION),
+	DEVLINK_TRAP(OVERLAY_SMAC_MC, DROP),
+	DEVLINK_TRAP(INGRESS_FLOW_ACTION_DROP, DROP),
+	DEVLINK_TRAP(EGRESS_FLOW_ACTION_DROP, DROP),
+	DEVLINK_TRAP(STP, CONTROL),
+	DEVLINK_TRAP(LACP, CONTROL),
+	DEVLINK_TRAP(LLDP, CONTROL),
+	DEVLINK_TRAP(IGMP_QUERY, CONTROL),
+	DEVLINK_TRAP(IGMP_V1_REPORT, CONTROL),
+	DEVLINK_TRAP(IGMP_V2_REPORT, CONTROL),
+	DEVLINK_TRAP(IGMP_V3_REPORT, CONTROL),
+	DEVLINK_TRAP(IGMP_V2_LEAVE, CONTROL),
+	DEVLINK_TRAP(MLD_QUERY, CONTROL),
+	DEVLINK_TRAP(MLD_V1_REPORT, CONTROL),
+	DEVLINK_TRAP(MLD_V2_REPORT, CONTROL),
+	DEVLINK_TRAP(MLD_V1_DONE, CONTROL),
+	DEVLINK_TRAP(IPV4_DHCP, CONTROL),
+	DEVLINK_TRAP(IPV6_DHCP, CONTROL),
+	DEVLINK_TRAP(ARP_REQUEST, CONTROL),
+	DEVLINK_TRAP(ARP_RESPONSE, CONTROL),
+	DEVLINK_TRAP(ARP_OVERLAY, CONTROL),
+	DEVLINK_TRAP(IPV6_NEIGH_SOLICIT, CONTROL),
+	DEVLINK_TRAP(IPV6_NEIGH_ADVERT, CONTROL),
+	DEVLINK_TRAP(IPV4_BFD, CONTROL),
+	DEVLINK_TRAP(IPV6_BFD, CONTROL),
+	DEVLINK_TRAP(IPV4_OSPF, CONTROL),
+	DEVLINK_TRAP(IPV6_OSPF, CONTROL),
+	DEVLINK_TRAP(IPV4_BGP, CONTROL),
+	DEVLINK_TRAP(IPV6_BGP, CONTROL),
+	DEVLINK_TRAP(IPV4_VRRP, CONTROL),
+	DEVLINK_TRAP(IPV6_VRRP, CONTROL),
+	DEVLINK_TRAP(IPV4_PIM, CONTROL),
+	DEVLINK_TRAP(IPV6_PIM, CONTROL),
+	DEVLINK_TRAP(UC_LB, CONTROL),
+	DEVLINK_TRAP(LOCAL_ROUTE, CONTROL),
+	DEVLINK_TRAP(EXTERNAL_ROUTE, CONTROL),
+	DEVLINK_TRAP(IPV6_UC_DIP_LINK_LOCAL_SCOPE, CONTROL),
+	DEVLINK_TRAP(IPV6_DIP_ALL_NODES, CONTROL),
+	DEVLINK_TRAP(IPV6_DIP_ALL_ROUTERS, CONTROL),
+	DEVLINK_TRAP(IPV6_ROUTER_SOLICIT, CONTROL),
+	DEVLINK_TRAP(IPV6_ROUTER_ADVERT, CONTROL),
+	DEVLINK_TRAP(IPV6_REDIRECT, CONTROL),
+	DEVLINK_TRAP(IPV4_ROUTER_ALERT, CONTROL),
+	DEVLINK_TRAP(IPV6_ROUTER_ALERT, CONTROL),
+	DEVLINK_TRAP(PTP_EVENT, CONTROL),
+	DEVLINK_TRAP(PTP_GENERAL, CONTROL),
+	DEVLINK_TRAP(FLOW_ACTION_SAMPLE, CONTROL),
+	DEVLINK_TRAP(FLOW_ACTION_TRAP, CONTROL),
+	DEVLINK_TRAP(EARLY_DROP, DROP),
+	DEVLINK_TRAP(VXLAN_PARSING, DROP),
+	DEVLINK_TRAP(LLC_SNAP_PARSING, DROP),
+	DEVLINK_TRAP(VLAN_PARSING, DROP),
+	DEVLINK_TRAP(PPPOE_PPP_PARSING, DROP),
+	DEVLINK_TRAP(MPLS_PARSING, DROP),
+	DEVLINK_TRAP(ARP_PARSING, DROP),
+	DEVLINK_TRAP(IP_1_PARSING, DROP),
+	DEVLINK_TRAP(IP_N_PARSING, DROP),
+	DEVLINK_TRAP(GRE_PARSING, DROP),
+	DEVLINK_TRAP(UDP_PARSING, DROP),
+	DEVLINK_TRAP(TCP_PARSING, DROP),
+	DEVLINK_TRAP(IPSEC_PARSING, DROP),
+	DEVLINK_TRAP(SCTP_PARSING, DROP),
+	DEVLINK_TRAP(DCCP_PARSING, DROP),
+	DEVLINK_TRAP(GTP_PARSING, DROP),
+	DEVLINK_TRAP(ESP_PARSING, DROP),
+	DEVLINK_TRAP(BLACKHOLE_NEXTHOP, DROP),
+	DEVLINK_TRAP(DMAC_FILTER, DROP),
+	DEVLINK_TRAP(EAPOL, CONTROL),
+	DEVLINK_TRAP(LOCKED_PORT, DROP),
+};
+
+#define DEVLINK_TRAP_GROUP(_id)						      \
+	{								      \
+		.id = DEVLINK_TRAP_GROUP_GENERIC_ID_##_id,		      \
+		.name = DEVLINK_TRAP_GROUP_GENERIC_NAME_##_id,		      \
+	}
+
+static const struct devlink_trap_group devlink_trap_group_generic[] = {
+	DEVLINK_TRAP_GROUP(L2_DROPS),
+	DEVLINK_TRAP_GROUP(L3_DROPS),
+	DEVLINK_TRAP_GROUP(L3_EXCEPTIONS),
+	DEVLINK_TRAP_GROUP(BUFFER_DROPS),
+	DEVLINK_TRAP_GROUP(TUNNEL_DROPS),
+	DEVLINK_TRAP_GROUP(ACL_DROPS),
+	DEVLINK_TRAP_GROUP(STP),
+	DEVLINK_TRAP_GROUP(LACP),
+	DEVLINK_TRAP_GROUP(LLDP),
+	DEVLINK_TRAP_GROUP(MC_SNOOPING),
+	DEVLINK_TRAP_GROUP(DHCP),
+	DEVLINK_TRAP_GROUP(NEIGH_DISCOVERY),
+	DEVLINK_TRAP_GROUP(BFD),
+	DEVLINK_TRAP_GROUP(OSPF),
+	DEVLINK_TRAP_GROUP(BGP),
+	DEVLINK_TRAP_GROUP(VRRP),
+	DEVLINK_TRAP_GROUP(PIM),
+	DEVLINK_TRAP_GROUP(UC_LB),
+	DEVLINK_TRAP_GROUP(LOCAL_DELIVERY),
+	DEVLINK_TRAP_GROUP(EXTERNAL_DELIVERY),
+	DEVLINK_TRAP_GROUP(IPV6),
+	DEVLINK_TRAP_GROUP(PTP_EVENT),
+	DEVLINK_TRAP_GROUP(PTP_GENERAL),
+	DEVLINK_TRAP_GROUP(ACL_SAMPLE),
+	DEVLINK_TRAP_GROUP(ACL_TRAP),
+	DEVLINK_TRAP_GROUP(PARSER_ERROR_DROPS),
+	DEVLINK_TRAP_GROUP(EAPOL),
+};
+
+static int devlink_trap_generic_verify(const struct devlink_trap *trap)
+{
+	if (trap->id > DEVLINK_TRAP_GENERIC_ID_MAX)
+		return -EINVAL;
+
+	if (strcmp(trap->name, devlink_trap_generic[trap->id].name))
+		return -EINVAL;
+
+	if (trap->type != devlink_trap_generic[trap->id].type)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int devlink_trap_driver_verify(const struct devlink_trap *trap)
+{
+	int i;
+
+	if (trap->id <= DEVLINK_TRAP_GENERIC_ID_MAX)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(devlink_trap_generic); i++) {
+		if (!strcmp(trap->name, devlink_trap_generic[i].name))
+			return -EEXIST;
+	}
+
+	return 0;
+}
+
+static int devlink_trap_verify(const struct devlink_trap *trap)
+{
+	if (!trap || !trap->name)
+		return -EINVAL;
+
+	if (trap->generic)
+		return devlink_trap_generic_verify(trap);
+	else
+		return devlink_trap_driver_verify(trap);
+}
+
+static int
+devlink_trap_group_generic_verify(const struct devlink_trap_group *group)
+{
+	if (group->id > DEVLINK_TRAP_GROUP_GENERIC_ID_MAX)
+		return -EINVAL;
+
+	if (strcmp(group->name, devlink_trap_group_generic[group->id].name))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int
+devlink_trap_group_driver_verify(const struct devlink_trap_group *group)
+{
+	int i;
+
+	if (group->id <= DEVLINK_TRAP_GROUP_GENERIC_ID_MAX)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(devlink_trap_group_generic); i++) {
+		if (!strcmp(group->name, devlink_trap_group_generic[i].name))
+			return -EEXIST;
+	}
+
+	return 0;
+}
+
+static int devlink_trap_group_verify(const struct devlink_trap_group *group)
+{
+	if (group->generic)
+		return devlink_trap_group_generic_verify(group);
+	else
+		return devlink_trap_group_driver_verify(group);
+}
+
+static void
+devlink_trap_group_notify(struct devlink *devlink,
+			  const struct devlink_trap_group_item *group_item,
+			  enum devlink_command cmd)
+{
+	struct sk_buff *msg;
+	int err;
+
+	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_GROUP_NEW &&
+		     cmd != DEVLINK_CMD_TRAP_GROUP_DEL);
+	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	err = devlink_nl_trap_group_fill(msg, devlink, group_item, cmd, 0, 0,
+					 0);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
+void devlink_trap_groups_notify_register(struct devlink *devlink)
+{
+	struct devlink_trap_group_item *group_item;
+
+	list_for_each_entry(group_item, &devlink->trap_group_list, list)
+		devlink_trap_group_notify(devlink, group_item,
+					  DEVLINK_CMD_TRAP_GROUP_NEW);
+}
+
+void devlink_trap_groups_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_trap_group_item *group_item;
+
+	list_for_each_entry_reverse(group_item, &devlink->trap_group_list, list)
+		devlink_trap_group_notify(devlink, group_item,
+					  DEVLINK_CMD_TRAP_GROUP_DEL);
+}
+
+static int
+devlink_trap_item_group_link(struct devlink *devlink,
+			     struct devlink_trap_item *trap_item)
+{
+	u16 group_id = trap_item->trap->init_group_id;
+	struct devlink_trap_group_item *group_item;
+
+	group_item = devlink_trap_group_item_lookup_by_id(devlink, group_id);
+	if (WARN_ON_ONCE(!group_item))
+		return -EINVAL;
+
+	trap_item->group_item = group_item;
+
+	return 0;
+}
+
+static void devlink_trap_notify(struct devlink *devlink,
+				const struct devlink_trap_item *trap_item,
+				enum devlink_command cmd)
+{
+	struct sk_buff *msg;
+	int err;
+
+	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_NEW &&
+		     cmd != DEVLINK_CMD_TRAP_DEL);
+	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	err = devlink_nl_trap_fill(msg, devlink, trap_item, cmd, 0, 0, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
+void devlink_traps_notify_register(struct devlink *devlink)
+{
+	struct devlink_trap_item *trap_item;
+
+	list_for_each_entry(trap_item, &devlink->trap_list, list)
+		devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_NEW);
+}
+
+void devlink_traps_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_trap_item *trap_item;
+
+	list_for_each_entry_reverse(trap_item, &devlink->trap_list, list)
+		devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_DEL);
+}
+
+static int
+devlink_trap_register(struct devlink *devlink,
+		      const struct devlink_trap *trap, void *priv)
+{
+	struct devlink_trap_item *trap_item;
+	int err;
+
+	if (devlink_trap_item_lookup(devlink, trap->name))
+		return -EEXIST;
+
+	trap_item = kzalloc(sizeof(*trap_item), GFP_KERNEL);
+	if (!trap_item)
+		return -ENOMEM;
+
+	trap_item->stats = netdev_alloc_pcpu_stats(struct devlink_stats);
+	if (!trap_item->stats) {
+		err = -ENOMEM;
+		goto err_stats_alloc;
+	}
+
+	trap_item->trap = trap;
+	trap_item->action = trap->init_action;
+	trap_item->priv = priv;
+
+	err = devlink_trap_item_group_link(devlink, trap_item);
+	if (err)
+		goto err_group_link;
+
+	err = devlink->ops->trap_init(devlink, trap, trap_item);
+	if (err)
+		goto err_trap_init;
+
+	list_add_tail(&trap_item->list, &devlink->trap_list);
+	devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_NEW);
+
+	return 0;
+
+err_trap_init:
+err_group_link:
+	free_percpu(trap_item->stats);
+err_stats_alloc:
+	kfree(trap_item);
+	return err;
+}
+
+static void devlink_trap_unregister(struct devlink *devlink,
+				    const struct devlink_trap *trap)
+{
+	struct devlink_trap_item *trap_item;
+
+	trap_item = devlink_trap_item_lookup(devlink, trap->name);
+	if (WARN_ON_ONCE(!trap_item))
+		return;
+
+	devlink_trap_notify(devlink, trap_item, DEVLINK_CMD_TRAP_DEL);
+	list_del(&trap_item->list);
+	if (devlink->ops->trap_fini)
+		devlink->ops->trap_fini(devlink, trap, trap_item);
+	free_percpu(trap_item->stats);
+	kfree(trap_item);
+}
+
+static void devlink_trap_disable(struct devlink *devlink,
+				 const struct devlink_trap *trap)
+{
+	struct devlink_trap_item *trap_item;
+
+	trap_item = devlink_trap_item_lookup(devlink, trap->name);
+	if (WARN_ON_ONCE(!trap_item))
+		return;
+
+	devlink->ops->trap_action_set(devlink, trap, DEVLINK_TRAP_ACTION_DROP,
+				      NULL);
+	trap_item->action = DEVLINK_TRAP_ACTION_DROP;
+}
+
+/**
+ * devl_traps_register - Register packet traps with devlink.
+ * @devlink: devlink.
+ * @traps: Packet traps.
+ * @traps_count: Count of provided packet traps.
+ * @priv: Driver private information.
+ *
+ * Return: Non-zero value on failure.
+ */
+int devl_traps_register(struct devlink *devlink,
+			const struct devlink_trap *traps,
+			size_t traps_count, void *priv)
+{
+	int i, err;
+
+	if (!devlink->ops->trap_init || !devlink->ops->trap_action_set)
+		return -EINVAL;
+
+	devl_assert_locked(devlink);
+	for (i = 0; i < traps_count; i++) {
+		const struct devlink_trap *trap = &traps[i];
+
+		err = devlink_trap_verify(trap);
+		if (err)
+			goto err_trap_verify;
+
+		err = devlink_trap_register(devlink, trap, priv);
+		if (err)
+			goto err_trap_register;
+	}
+
+	return 0;
+
+err_trap_register:
+err_trap_verify:
+	for (i--; i >= 0; i--)
+		devlink_trap_unregister(devlink, &traps[i]);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devl_traps_register);
+
+/**
+ * devlink_traps_register - Register packet traps with devlink.
+ * @devlink: devlink.
+ * @traps: Packet traps.
+ * @traps_count: Count of provided packet traps.
+ * @priv: Driver private information.
+ *
+ * Context: Takes and release devlink->lock <mutex>.
+ *
+ * Return: Non-zero value on failure.
+ */
+int devlink_traps_register(struct devlink *devlink,
+			   const struct devlink_trap *traps,
+			   size_t traps_count, void *priv)
+{
+	int err;
+
+	devl_lock(devlink);
+	err = devl_traps_register(devlink, traps, traps_count, priv);
+	devl_unlock(devlink);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devlink_traps_register);
+
+/**
+ * devl_traps_unregister - Unregister packet traps from devlink.
+ * @devlink: devlink.
+ * @traps: Packet traps.
+ * @traps_count: Count of provided packet traps.
+ */
+void devl_traps_unregister(struct devlink *devlink,
+			   const struct devlink_trap *traps,
+			   size_t traps_count)
+{
+	int i;
+
+	devl_assert_locked(devlink);
+	/* Make sure we do not have any packets in-flight while unregistering
+	 * traps by disabling all of them and waiting for a grace period.
+	 */
+	for (i = traps_count - 1; i >= 0; i--)
+		devlink_trap_disable(devlink, &traps[i]);
+	synchronize_rcu();
+	for (i = traps_count - 1; i >= 0; i--)
+		devlink_trap_unregister(devlink, &traps[i]);
+}
+EXPORT_SYMBOL_GPL(devl_traps_unregister);
+
+/**
+ * devlink_traps_unregister - Unregister packet traps from devlink.
+ * @devlink: devlink.
+ * @traps: Packet traps.
+ * @traps_count: Count of provided packet traps.
+ *
+ * Context: Takes and release devlink->lock <mutex>.
+ */
+void devlink_traps_unregister(struct devlink *devlink,
+			      const struct devlink_trap *traps,
+			      size_t traps_count)
+{
+	devl_lock(devlink);
+	devl_traps_unregister(devlink, traps, traps_count);
+	devl_unlock(devlink);
+}
+EXPORT_SYMBOL_GPL(devlink_traps_unregister);
+
+static void
+devlink_trap_stats_update(struct devlink_stats __percpu *trap_stats,
+			  size_t skb_len)
+{
+	struct devlink_stats *stats;
+
+	stats = this_cpu_ptr(trap_stats);
+	u64_stats_update_begin(&stats->syncp);
+	u64_stats_add(&stats->rx_bytes, skb_len);
+	u64_stats_inc(&stats->rx_packets);
+	u64_stats_update_end(&stats->syncp);
+}
+
+static void
+devlink_trap_report_metadata_set(struct devlink_trap_metadata *metadata,
+				 const struct devlink_trap_item *trap_item,
+				 struct devlink_port *in_devlink_port,
+				 const struct flow_action_cookie *fa_cookie)
+{
+	metadata->trap_name = trap_item->trap->name;
+	metadata->trap_group_name = trap_item->group_item->group->name;
+	metadata->fa_cookie = fa_cookie;
+	metadata->trap_type = trap_item->trap->type;
+
+	spin_lock(&in_devlink_port->type_lock);
+	if (in_devlink_port->type == DEVLINK_PORT_TYPE_ETH)
+		metadata->input_dev = in_devlink_port->type_eth.netdev;
+	spin_unlock(&in_devlink_port->type_lock);
+}
+
+/**
+ * devlink_trap_report - Report trapped packet to drop monitor.
+ * @devlink: devlink.
+ * @skb: Trapped packet.
+ * @trap_ctx: Trap context.
+ * @in_devlink_port: Input devlink port.
+ * @fa_cookie: Flow action cookie. Could be NULL.
+ */
+void devlink_trap_report(struct devlink *devlink, struct sk_buff *skb,
+			 void *trap_ctx, struct devlink_port *in_devlink_port,
+			 const struct flow_action_cookie *fa_cookie)
+
+{
+	struct devlink_trap_item *trap_item = trap_ctx;
+
+	devlink_trap_stats_update(trap_item->stats, skb->len);
+	devlink_trap_stats_update(trap_item->group_item->stats, skb->len);
+
+	if (tracepoint_enabled(devlink_trap_report)) {
+		struct devlink_trap_metadata metadata = {};
+
+		devlink_trap_report_metadata_set(&metadata, trap_item,
+						 in_devlink_port, fa_cookie);
+		trace_devlink_trap_report(devlink, skb, &metadata);
+	}
+}
+EXPORT_SYMBOL_GPL(devlink_trap_report);
+
+/**
+ * devlink_trap_ctx_priv - Trap context to driver private information.
+ * @trap_ctx: Trap context.
+ *
+ * Return: Driver private information passed during registration.
+ */
+void *devlink_trap_ctx_priv(void *trap_ctx)
+{
+	struct devlink_trap_item *trap_item = trap_ctx;
+
+	return trap_item->priv;
+}
+EXPORT_SYMBOL_GPL(devlink_trap_ctx_priv);
+
+static int
+devlink_trap_group_item_policer_link(struct devlink *devlink,
+				     struct devlink_trap_group_item *group_item)
+{
+	u32 policer_id = group_item->group->init_policer_id;
+	struct devlink_trap_policer_item *policer_item;
+
+	if (policer_id == 0)
+		return 0;
+
+	policer_item = devlink_trap_policer_item_lookup(devlink, policer_id);
+	if (WARN_ON_ONCE(!policer_item))
+		return -EINVAL;
+
+	group_item->policer_item = policer_item;
+
+	return 0;
+}
+
+static int
+devlink_trap_group_register(struct devlink *devlink,
+			    const struct devlink_trap_group *group)
+{
+	struct devlink_trap_group_item *group_item;
+	int err;
+
+	if (devlink_trap_group_item_lookup(devlink, group->name))
+		return -EEXIST;
+
+	group_item = kzalloc(sizeof(*group_item), GFP_KERNEL);
+	if (!group_item)
+		return -ENOMEM;
+
+	group_item->stats = netdev_alloc_pcpu_stats(struct devlink_stats);
+	if (!group_item->stats) {
+		err = -ENOMEM;
+		goto err_stats_alloc;
+	}
+
+	group_item->group = group;
+
+	err = devlink_trap_group_item_policer_link(devlink, group_item);
+	if (err)
+		goto err_policer_link;
+
+	if (devlink->ops->trap_group_init) {
+		err = devlink->ops->trap_group_init(devlink, group);
+		if (err)
+			goto err_group_init;
+	}
+
+	list_add_tail(&group_item->list, &devlink->trap_group_list);
+	devlink_trap_group_notify(devlink, group_item,
+				  DEVLINK_CMD_TRAP_GROUP_NEW);
+
+	return 0;
+
+err_group_init:
+err_policer_link:
+	free_percpu(group_item->stats);
+err_stats_alloc:
+	kfree(group_item);
+	return err;
+}
+
+static void
+devlink_trap_group_unregister(struct devlink *devlink,
+			      const struct devlink_trap_group *group)
+{
+	struct devlink_trap_group_item *group_item;
+
+	group_item = devlink_trap_group_item_lookup(devlink, group->name);
+	if (WARN_ON_ONCE(!group_item))
+		return;
+
+	devlink_trap_group_notify(devlink, group_item,
+				  DEVLINK_CMD_TRAP_GROUP_DEL);
+	list_del(&group_item->list);
+	free_percpu(group_item->stats);
+	kfree(group_item);
+}
+
+/**
+ * devl_trap_groups_register - Register packet trap groups with devlink.
+ * @devlink: devlink.
+ * @groups: Packet trap groups.
+ * @groups_count: Count of provided packet trap groups.
+ *
+ * Return: Non-zero value on failure.
+ */
+int devl_trap_groups_register(struct devlink *devlink,
+			      const struct devlink_trap_group *groups,
+			      size_t groups_count)
+{
+	int i, err;
+
+	devl_assert_locked(devlink);
+	for (i = 0; i < groups_count; i++) {
+		const struct devlink_trap_group *group = &groups[i];
+
+		err = devlink_trap_group_verify(group);
+		if (err)
+			goto err_trap_group_verify;
+
+		err = devlink_trap_group_register(devlink, group);
+		if (err)
+			goto err_trap_group_register;
+	}
+
+	return 0;
+
+err_trap_group_register:
+err_trap_group_verify:
+	for (i--; i >= 0; i--)
+		devlink_trap_group_unregister(devlink, &groups[i]);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devl_trap_groups_register);
+
+/**
+ * devlink_trap_groups_register - Register packet trap groups with devlink.
+ * @devlink: devlink.
+ * @groups: Packet trap groups.
+ * @groups_count: Count of provided packet trap groups.
+ *
+ * Context: Takes and release devlink->lock <mutex>.
+ *
+ * Return: Non-zero value on failure.
+ */
+int devlink_trap_groups_register(struct devlink *devlink,
+				 const struct devlink_trap_group *groups,
+				 size_t groups_count)
+{
+	int err;
+
+	devl_lock(devlink);
+	err = devl_trap_groups_register(devlink, groups, groups_count);
+	devl_unlock(devlink);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devlink_trap_groups_register);
+
+/**
+ * devl_trap_groups_unregister - Unregister packet trap groups from devlink.
+ * @devlink: devlink.
+ * @groups: Packet trap groups.
+ * @groups_count: Count of provided packet trap groups.
+ */
+void devl_trap_groups_unregister(struct devlink *devlink,
+				 const struct devlink_trap_group *groups,
+				 size_t groups_count)
+{
+	int i;
+
+	devl_assert_locked(devlink);
+	for (i = groups_count - 1; i >= 0; i--)
+		devlink_trap_group_unregister(devlink, &groups[i]);
+}
+EXPORT_SYMBOL_GPL(devl_trap_groups_unregister);
+
+/**
+ * devlink_trap_groups_unregister - Unregister packet trap groups from devlink.
+ * @devlink: devlink.
+ * @groups: Packet trap groups.
+ * @groups_count: Count of provided packet trap groups.
+ *
+ * Context: Takes and release devlink->lock <mutex>.
+ */
+void devlink_trap_groups_unregister(struct devlink *devlink,
+				    const struct devlink_trap_group *groups,
+				    size_t groups_count)
+{
+	devl_lock(devlink);
+	devl_trap_groups_unregister(devlink, groups, groups_count);
+	devl_unlock(devlink);
+}
+EXPORT_SYMBOL_GPL(devlink_trap_groups_unregister);
+
+static void
+devlink_trap_policer_notify(struct devlink *devlink,
+			    const struct devlink_trap_policer_item *policer_item,
+			    enum devlink_command cmd)
+{
+	struct sk_buff *msg;
+	int err;
+
+	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_POLICER_NEW &&
+		     cmd != DEVLINK_CMD_TRAP_POLICER_DEL);
+	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	err = devlink_nl_trap_policer_fill(msg, devlink, policer_item, cmd, 0,
+					   0, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
+void devlink_trap_policers_notify_register(struct devlink *devlink)
+{
+	struct devlink_trap_policer_item *policer_item;
+
+	list_for_each_entry(policer_item, &devlink->trap_policer_list, list)
+		devlink_trap_policer_notify(devlink, policer_item,
+					    DEVLINK_CMD_TRAP_POLICER_NEW);
+}
+
+void devlink_trap_policers_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_trap_policer_item *policer_item;
+
+	list_for_each_entry_reverse(policer_item, &devlink->trap_policer_list,
+				    list)
+		devlink_trap_policer_notify(devlink, policer_item,
+					    DEVLINK_CMD_TRAP_POLICER_DEL);
+}
+
+static int
+devlink_trap_policer_register(struct devlink *devlink,
+			      const struct devlink_trap_policer *policer)
+{
+	struct devlink_trap_policer_item *policer_item;
+	int err;
+
+	if (devlink_trap_policer_item_lookup(devlink, policer->id))
+		return -EEXIST;
+
+	policer_item = kzalloc(sizeof(*policer_item), GFP_KERNEL);
+	if (!policer_item)
+		return -ENOMEM;
+
+	policer_item->policer = policer;
+	policer_item->rate = policer->init_rate;
+	policer_item->burst = policer->init_burst;
+
+	if (devlink->ops->trap_policer_init) {
+		err = devlink->ops->trap_policer_init(devlink, policer);
+		if (err)
+			goto err_policer_init;
+	}
+
+	list_add_tail(&policer_item->list, &devlink->trap_policer_list);
+	devlink_trap_policer_notify(devlink, policer_item,
+				    DEVLINK_CMD_TRAP_POLICER_NEW);
+
+	return 0;
+
+err_policer_init:
+	kfree(policer_item);
+	return err;
+}
+
+static void
+devlink_trap_policer_unregister(struct devlink *devlink,
+				const struct devlink_trap_policer *policer)
+{
+	struct devlink_trap_policer_item *policer_item;
+
+	policer_item = devlink_trap_policer_item_lookup(devlink, policer->id);
+	if (WARN_ON_ONCE(!policer_item))
+		return;
+
+	devlink_trap_policer_notify(devlink, policer_item,
+				    DEVLINK_CMD_TRAP_POLICER_DEL);
+	list_del(&policer_item->list);
+	if (devlink->ops->trap_policer_fini)
+		devlink->ops->trap_policer_fini(devlink, policer);
+	kfree(policer_item);
+}
+
+/**
+ * devl_trap_policers_register - Register packet trap policers with devlink.
+ * @devlink: devlink.
+ * @policers: Packet trap policers.
+ * @policers_count: Count of provided packet trap policers.
+ *
+ * Return: Non-zero value on failure.
+ */
+int
+devl_trap_policers_register(struct devlink *devlink,
+			    const struct devlink_trap_policer *policers,
+			    size_t policers_count)
+{
+	int i, err;
+
+	devl_assert_locked(devlink);
+	for (i = 0; i < policers_count; i++) {
+		const struct devlink_trap_policer *policer = &policers[i];
+
+		if (WARN_ON(policer->id == 0 ||
+			    policer->max_rate < policer->min_rate ||
+			    policer->max_burst < policer->min_burst)) {
+			err = -EINVAL;
+			goto err_trap_policer_verify;
+		}
+
+		err = devlink_trap_policer_register(devlink, policer);
+		if (err)
+			goto err_trap_policer_register;
+	}
+	return 0;
+
+err_trap_policer_register:
+err_trap_policer_verify:
+	for (i--; i >= 0; i--)
+		devlink_trap_policer_unregister(devlink, &policers[i]);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devl_trap_policers_register);
+
+/**
+ * devl_trap_policers_unregister - Unregister packet trap policers from devlink.
+ * @devlink: devlink.
+ * @policers: Packet trap policers.
+ * @policers_count: Count of provided packet trap policers.
+ */
+void
+devl_trap_policers_unregister(struct devlink *devlink,
+			      const struct devlink_trap_policer *policers,
+			      size_t policers_count)
+{
+	int i;
+
+	devl_assert_locked(devlink);
+	for (i = policers_count - 1; i >= 0; i--)
+		devlink_trap_policer_unregister(devlink, &policers[i]);
+}
+EXPORT_SYMBOL_GPL(devl_trap_policers_unregister);
-- 
2.41.0


