Return-Path: <netdev+bounces-30590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EE77882B0
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309222817EE
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABDCC2EF;
	Fri, 25 Aug 2023 08:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43732C2D1
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:53:36 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392941BF2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b974031aeaso10239361fa.0
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692953609; x=1693558409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB1vqLAWPmHeO/chCKqFWKRCaXNk0Wss7ueKL+HFxmQ=;
        b=sOZz2Fv9v32nUQ/gy5b3Yn4pvjhpq/pCpmwKZt+15SKt1vr747gnyjPVHCXkcZz7/h
         x+jUjx+LgVOvj0y3Xl7nYgZxw9AI1tdU/uSeRqkwZJkJL895wMI73m6vbl8EzYXHXYAG
         LurZTy7zn2XFCrBe7eA84wnGmr7+C5L1PM9KC+ExmFddcQB7F+WcBwFPGFIJEZLdjCne
         e7GA3nhGZ1EH5I3Oyntx9TUNkjmq/6S1KYop7Z0Oed1EP/uGFPxVu35ldbhwhBLTNcTn
         I7z5t5JcKaQWYnp0j/AiwM44LT7pEkwpyM6xF3TVFtKPLlwrCV8TmQA4AceQaHzgBQir
         zt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953609; x=1693558409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB1vqLAWPmHeO/chCKqFWKRCaXNk0Wss7ueKL+HFxmQ=;
        b=dnJIKAU6Y/lLjM4DjnQ0YdqJV3JqNnSUdHngkWEUxbA+fLCdMliwtM3TygOtdd2jyp
         5OpDTbItvZhj4iCX/1k0THo7DizoULsSblsrqfhrp2h3dMqtK+11go1GNFqFOf1dSrjm
         I3PmCYpPgo5ew0az+3ZtMjmxkUYdKvgIZV0KrOPft8lRhGFM/wfYMBjKOJqKLpz9CoFj
         U3kelhPzVXFi/H6YmgeaYmjNhuJpywp6ox5uD7rSEdVflU7ZmJDSzh24fPJTu++pj3h9
         M5zGM7sB24ozclDgLWodvreawRL5apGdr8YHt5r5LWzsrBaNXrlb5liOA+U0lP9n+7y5
         tbRw==
X-Gm-Message-State: AOJu0YxNnusHWSCChYY21s5JrJ8JqCJ9tgdfM9rOhbicC2+89uiXQsDW
	fakhDn0ctSDlKWkXvF6Lnfq+D330VDpJAHqt1I1i42IP
X-Google-Smtp-Source: AGHT+IHmYCdlDti++fPE54p6iDWZH7a8rxhawfss+JwEHce9gf4zMOZsQ2jKIQgJAdz0YdRdcFV6Qg==
X-Received: by 2002:a2e:a309:0:b0:2b5:68ad:291f with SMTP id l9-20020a2ea309000000b002b568ad291fmr14018820lje.19.1692953609139;
        Fri, 25 Aug 2023 01:53:29 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id s11-20020a1cf20b000000b003fe1a092925sm1586219wmc.19.2023.08.25.01.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:53:28 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next 03/15] devlink: push shared buffer related code into separate file
Date: Fri, 25 Aug 2023 10:53:09 +0200
Message-ID: <20230825085321.178134-4-jiri@resnulli.us>
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

Cut out another chunk from leftover.c and put sb related code
into a separate file.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/Makefile        |    2 +-
 net/devlink/devl_internal.h |    9 +
 net/devlink/leftover.c      | 1338 +++++------------------------------
 net/devlink/sb.c            |  996 ++++++++++++++++++++++++++
 4 files changed, 1180 insertions(+), 1165 deletions(-)
 create mode 100644 net/devlink/sb.c

diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 456bfb336540..dcc508af48a9 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := leftover.o core.o netlink.o netlink_gen.o dev.o port.o health.o
+obj-y := leftover.o core.o netlink.o netlink_gen.o dev.o port.o sb.o health.o \
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7d01e2060702..e1a6b7a763b8 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -220,6 +220,15 @@ int devlink_nl_cmd_port_unsplit_doit(struct sk_buff *skb,
 				     struct genl_info *info);
 int devlink_nl_cmd_port_new_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_port_del_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_sb_port_pool_set_doit(struct sk_buff *skb,
+					 struct genl_info *info);
+int devlink_nl_cmd_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
+					    struct genl_info *info);
+int devlink_nl_cmd_sb_occ_snapshot_doit(struct sk_buff *skb,
+					struct genl_info *info);
+int devlink_nl_cmd_sb_occ_max_clear_doit(struct sk_buff *skb,
+					 struct genl_info *info);
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
 					    struct genl_info *info);
 int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index d14b40fb8fdf..795bfdd41103 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -231,164 +231,6 @@ devlink_linecard_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_linecard_get_from_attrs(devlink, info->attrs);
 }
 
-struct devlink_sb {
-	struct list_head list;
-	unsigned int index;
-	u32 size;
-	u16 ingress_pools_count;
-	u16 egress_pools_count;
-	u16 ingress_tc_count;
-	u16 egress_tc_count;
-};
-
-static u16 devlink_sb_pool_count(struct devlink_sb *devlink_sb)
-{
-	return devlink_sb->ingress_pools_count + devlink_sb->egress_pools_count;
-}
-
-static struct devlink_sb *devlink_sb_get_by_index(struct devlink *devlink,
-						  unsigned int sb_index)
-{
-	struct devlink_sb *devlink_sb;
-
-	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
-		if (devlink_sb->index == sb_index)
-			return devlink_sb;
-	}
-	return NULL;
-}
-
-static bool devlink_sb_index_exists(struct devlink *devlink,
-				    unsigned int sb_index)
-{
-	return devlink_sb_get_by_index(devlink, sb_index);
-}
-
-static struct devlink_sb *devlink_sb_get_from_attrs(struct devlink *devlink,
-						    struct nlattr **attrs)
-{
-	if (attrs[DEVLINK_ATTR_SB_INDEX]) {
-		u32 sb_index = nla_get_u32(attrs[DEVLINK_ATTR_SB_INDEX]);
-		struct devlink_sb *devlink_sb;
-
-		devlink_sb = devlink_sb_get_by_index(devlink, sb_index);
-		if (!devlink_sb)
-			return ERR_PTR(-ENODEV);
-		return devlink_sb;
-	}
-	return ERR_PTR(-EINVAL);
-}
-
-static struct devlink_sb *devlink_sb_get_from_info(struct devlink *devlink,
-						   struct genl_info *info)
-{
-	return devlink_sb_get_from_attrs(devlink, info->attrs);
-}
-
-static int devlink_sb_pool_index_get_from_attrs(struct devlink_sb *devlink_sb,
-						struct nlattr **attrs,
-						u16 *p_pool_index)
-{
-	u16 val;
-
-	if (!attrs[DEVLINK_ATTR_SB_POOL_INDEX])
-		return -EINVAL;
-
-	val = nla_get_u16(attrs[DEVLINK_ATTR_SB_POOL_INDEX]);
-	if (val >= devlink_sb_pool_count(devlink_sb))
-		return -EINVAL;
-	*p_pool_index = val;
-	return 0;
-}
-
-static int devlink_sb_pool_index_get_from_info(struct devlink_sb *devlink_sb,
-					       struct genl_info *info,
-					       u16 *p_pool_index)
-{
-	return devlink_sb_pool_index_get_from_attrs(devlink_sb, info->attrs,
-						    p_pool_index);
-}
-
-static int
-devlink_sb_pool_type_get_from_attrs(struct nlattr **attrs,
-				    enum devlink_sb_pool_type *p_pool_type)
-{
-	u8 val;
-
-	if (!attrs[DEVLINK_ATTR_SB_POOL_TYPE])
-		return -EINVAL;
-
-	val = nla_get_u8(attrs[DEVLINK_ATTR_SB_POOL_TYPE]);
-	if (val != DEVLINK_SB_POOL_TYPE_INGRESS &&
-	    val != DEVLINK_SB_POOL_TYPE_EGRESS)
-		return -EINVAL;
-	*p_pool_type = val;
-	return 0;
-}
-
-static int
-devlink_sb_pool_type_get_from_info(struct genl_info *info,
-				   enum devlink_sb_pool_type *p_pool_type)
-{
-	return devlink_sb_pool_type_get_from_attrs(info->attrs, p_pool_type);
-}
-
-static int
-devlink_sb_th_type_get_from_attrs(struct nlattr **attrs,
-				  enum devlink_sb_threshold_type *p_th_type)
-{
-	u8 val;
-
-	if (!attrs[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE])
-		return -EINVAL;
-
-	val = nla_get_u8(attrs[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE]);
-	if (val != DEVLINK_SB_THRESHOLD_TYPE_STATIC &&
-	    val != DEVLINK_SB_THRESHOLD_TYPE_DYNAMIC)
-		return -EINVAL;
-	*p_th_type = val;
-	return 0;
-}
-
-static int
-devlink_sb_th_type_get_from_info(struct genl_info *info,
-				 enum devlink_sb_threshold_type *p_th_type)
-{
-	return devlink_sb_th_type_get_from_attrs(info->attrs, p_th_type);
-}
-
-static int
-devlink_sb_tc_index_get_from_attrs(struct devlink_sb *devlink_sb,
-				   struct nlattr **attrs,
-				   enum devlink_sb_pool_type pool_type,
-				   u16 *p_tc_index)
-{
-	u16 val;
-
-	if (!attrs[DEVLINK_ATTR_SB_TC_INDEX])
-		return -EINVAL;
-
-	val = nla_get_u16(attrs[DEVLINK_ATTR_SB_TC_INDEX]);
-	if (pool_type == DEVLINK_SB_POOL_TYPE_INGRESS &&
-	    val >= devlink_sb->ingress_tc_count)
-		return -EINVAL;
-	if (pool_type == DEVLINK_SB_POOL_TYPE_EGRESS &&
-	    val >= devlink_sb->egress_tc_count)
-		return -EINVAL;
-	*p_tc_index = val;
-	return 0;
-}
-
-static int
-devlink_sb_tc_index_get_from_info(struct devlink_sb *devlink_sb,
-				  struct genl_info *info,
-				  enum devlink_sb_pool_type pool_type,
-				  u16 *p_tc_index)
-{
-	return devlink_sb_tc_index_get_from_attrs(devlink_sb, info->attrs,
-						  pool_type, p_tc_index);
-}
-
 struct devlink_region {
 	struct devlink *devlink;
 	struct devlink_port *port;
@@ -1053,825 +895,31 @@ static void devlink_linecards_notify_unregister(struct devlink *devlink)
 {
 	struct devlink_linecard *linecard;
 
-	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
-}
-
-int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_linecard *linecard;
-	struct sk_buff *msg;
-	int err;
-
-	linecard = devlink_linecard_get_from_info(devlink, info);
-	if (IS_ERR(linecard))
-		return PTR_ERR(linecard);
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	mutex_lock(&linecard->state_lock);
-	err = devlink_nl_linecard_fill(msg, devlink, linecard,
-				       DEVLINK_CMD_LINECARD_NEW,
-				       info->snd_portid, info->snd_seq, 0,
-				       info->extack);
-	mutex_unlock(&linecard->state_lock);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
-
-	return genlmsg_reply(msg, info);
-}
-
-static int devlink_nl_linecard_get_dump_one(struct sk_buff *msg,
-					    struct devlink *devlink,
-					    struct netlink_callback *cb,
-					    int flags)
-{
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_linecard *linecard;
-	int idx = 0;
-	int err = 0;
-
-	list_for_each_entry(linecard, &devlink->linecard_list, list) {
-		if (idx < state->idx) {
-			idx++;
-			continue;
-		}
-		mutex_lock(&linecard->state_lock);
-		err = devlink_nl_linecard_fill(msg, devlink, linecard,
-					       DEVLINK_CMD_LINECARD_NEW,
-					       NETLINK_CB(cb->skb).portid,
-					       cb->nlh->nlmsg_seq, flags,
-					       cb->extack);
-		mutex_unlock(&linecard->state_lock);
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
-int devlink_nl_linecard_get_dumpit(struct sk_buff *skb,
-				   struct netlink_callback *cb)
-{
-	return devlink_nl_dumpit(skb, cb, devlink_nl_linecard_get_dump_one);
-}
-
-static struct devlink_linecard_type *
-devlink_linecard_type_lookup(struct devlink_linecard *linecard,
-			     const char *type)
-{
-	struct devlink_linecard_type *linecard_type;
-	int i;
-
-	for (i = 0; i < linecard->types_count; i++) {
-		linecard_type = &linecard->types[i];
-		if (!strcmp(type, linecard_type->type))
-			return linecard_type;
-	}
-	return NULL;
-}
-
-static int devlink_linecard_type_set(struct devlink_linecard *linecard,
-				     const char *type,
-				     struct netlink_ext_ack *extack)
-{
-	const struct devlink_linecard_ops *ops = linecard->ops;
-	struct devlink_linecard_type *linecard_type;
-	int err;
-
-	mutex_lock(&linecard->state_lock);
-	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING) {
-		NL_SET_ERR_MSG(extack, "Line card is currently being provisioned");
-		err = -EBUSY;
-		goto out;
-	}
-	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONING) {
-		NL_SET_ERR_MSG(extack, "Line card is currently being unprovisioned");
-		err = -EBUSY;
-		goto out;
-	}
-
-	linecard_type = devlink_linecard_type_lookup(linecard, type);
-	if (!linecard_type) {
-		NL_SET_ERR_MSG(extack, "Unsupported line card type provided");
-		err = -EINVAL;
-		goto out;
-	}
-
-	if (linecard->state != DEVLINK_LINECARD_STATE_UNPROVISIONED &&
-	    linecard->state != DEVLINK_LINECARD_STATE_PROVISIONING_FAILED) {
-		NL_SET_ERR_MSG(extack, "Line card already provisioned");
-		err = -EBUSY;
-		/* Check if the line card is provisioned in the same
-		 * way the user asks. In case it is, make the operation
-		 * to return success.
-		 */
-		if (ops->same_provision &&
-		    ops->same_provision(linecard, linecard->priv,
-					linecard_type->type,
-					linecard_type->priv))
-			err = 0;
-		goto out;
-	}
-
-	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONING;
-	linecard->type = linecard_type->type;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-	err = ops->provision(linecard, linecard->priv, linecard_type->type,
-			     linecard_type->priv, extack);
-	if (err) {
-		/* Provisioning failed. Assume the linecard is unprovisioned
-		 * for future operations.
-		 */
-		mutex_lock(&linecard->state_lock);
-		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-		linecard->type = NULL;
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-		mutex_unlock(&linecard->state_lock);
-	}
-	return err;
-
-out:
-	mutex_unlock(&linecard->state_lock);
-	return err;
-}
-
-static int devlink_linecard_type_unset(struct devlink_linecard *linecard,
-				       struct netlink_ext_ack *extack)
-{
-	int err;
-
-	mutex_lock(&linecard->state_lock);
-	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING) {
-		NL_SET_ERR_MSG(extack, "Line card is currently being provisioned");
-		err = -EBUSY;
-		goto out;
-	}
-	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONING) {
-		NL_SET_ERR_MSG(extack, "Line card is currently being unprovisioned");
-		err = -EBUSY;
-		goto out;
-	}
-	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING_FAILED) {
-		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-		linecard->type = NULL;
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-		err = 0;
-		goto out;
-	}
-
-	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONED) {
-		NL_SET_ERR_MSG(extack, "Line card is not provisioned");
-		err = 0;
-		goto out;
-	}
-	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONING;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-	err = linecard->ops->unprovision(linecard, linecard->priv,
-					 extack);
-	if (err) {
-		/* Unprovisioning failed. Assume the linecard is unprovisioned
-		 * for future operations.
-		 */
-		mutex_lock(&linecard->state_lock);
-		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-		linecard->type = NULL;
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-		mutex_unlock(&linecard->state_lock);
-	}
-	return err;
-
-out:
-	mutex_unlock(&linecard->state_lock);
-	return err;
-}
-
-static int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
-					    struct genl_info *info)
-{
-	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_linecard *linecard;
-	int err;
-
-	linecard = devlink_linecard_get_from_info(devlink, info);
-	if (IS_ERR(linecard))
-		return PTR_ERR(linecard);
-
-	if (info->attrs[DEVLINK_ATTR_LINECARD_TYPE]) {
-		const char *type;
-
-		type = nla_data(info->attrs[DEVLINK_ATTR_LINECARD_TYPE]);
-		if (strcmp(type, "")) {
-			err = devlink_linecard_type_set(linecard, type, extack);
-			if (err)
-				return err;
-		} else {
-			err = devlink_linecard_type_unset(linecard, extack);
-			if (err)
-				return err;
-		}
-	}
-
-	return 0;
-}
-
-static int devlink_nl_sb_fill(struct sk_buff *msg, struct devlink *devlink,
-			      struct devlink_sb *devlink_sb,
-			      enum devlink_command cmd, u32 portid,
-			      u32 seq, int flags)
-{
-	void *hdr;
-
-	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
-	if (!hdr)
-		return -EMSGSIZE;
-
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_SB_INDEX, devlink_sb->index))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_SB_SIZE, devlink_sb->size))
-		goto nla_put_failure;
-	if (nla_put_u16(msg, DEVLINK_ATTR_SB_INGRESS_POOL_COUNT,
-			devlink_sb->ingress_pools_count))
-		goto nla_put_failure;
-	if (nla_put_u16(msg, DEVLINK_ATTR_SB_EGRESS_POOL_COUNT,
-			devlink_sb->egress_pools_count))
-		goto nla_put_failure;
-	if (nla_put_u16(msg, DEVLINK_ATTR_SB_INGRESS_TC_COUNT,
-			devlink_sb->ingress_tc_count))
-		goto nla_put_failure;
-	if (nla_put_u16(msg, DEVLINK_ATTR_SB_EGRESS_TC_COUNT,
-			devlink_sb->egress_tc_count))
-		goto nla_put_failure;
-
-	genlmsg_end(msg, hdr);
-	return 0;
-
-nla_put_failure:
-	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
-}
-
-int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_sb *devlink_sb;
-	struct sk_buff *msg;
-	int err;
-
-	devlink_sb = devlink_sb_get_from_info(devlink, info);
-	if (IS_ERR(devlink_sb))
-		return PTR_ERR(devlink_sb);
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	err = devlink_nl_sb_fill(msg, devlink, devlink_sb,
-				 DEVLINK_CMD_SB_NEW,
-				 info->snd_portid, info->snd_seq, 0);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
-
-	return genlmsg_reply(msg, info);
-}
-
-static int
-devlink_nl_sb_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			   struct netlink_callback *cb, int flags)
-{
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_sb *devlink_sb;
-	int idx = 0;
-	int err = 0;
-
-	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
-		if (idx < state->idx) {
-			idx++;
-			continue;
-		}
-		err = devlink_nl_sb_fill(msg, devlink, devlink_sb,
-					 DEVLINK_CMD_SB_NEW,
-					 NETLINK_CB(cb->skb).portid,
-					 cb->nlh->nlmsg_seq, flags);
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
-int devlink_nl_sb_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	return devlink_nl_dumpit(skb, cb, devlink_nl_sb_get_dump_one);
-}
-
-static int devlink_nl_sb_pool_fill(struct sk_buff *msg, struct devlink *devlink,
-				   struct devlink_sb *devlink_sb,
-				   u16 pool_index, enum devlink_command cmd,
-				   u32 portid, u32 seq, int flags)
-{
-	struct devlink_sb_pool_info pool_info;
-	void *hdr;
-	int err;
-
-	err = devlink->ops->sb_pool_get(devlink, devlink_sb->index,
-					pool_index, &pool_info);
-	if (err)
-		return err;
-
-	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
-	if (!hdr)
-		return -EMSGSIZE;
-
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_SB_INDEX, devlink_sb->index))
-		goto nla_put_failure;
-	if (nla_put_u16(msg, DEVLINK_ATTR_SB_POOL_INDEX, pool_index))
-		goto nla_put_failure;
-	if (nla_put_u8(msg, DEVLINK_ATTR_SB_POOL_TYPE, pool_info.pool_type))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_SB_POOL_SIZE, pool_info.size))
-		goto nla_put_failure;
-	if (nla_put_u8(msg, DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE,
-		       pool_info.threshold_type))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_SB_POOL_CELL_SIZE,
-			pool_info.cell_size))
-		goto nla_put_failure;
-
-	genlmsg_end(msg, hdr);
-	return 0;
-
-nla_put_failure:
-	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
-}
-
-int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_sb *devlink_sb;
-	struct sk_buff *msg;
-	u16 pool_index;
-	int err;
-
-	devlink_sb = devlink_sb_get_from_info(devlink, info);
-	if (IS_ERR(devlink_sb))
-		return PTR_ERR(devlink_sb);
-
-	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
-						  &pool_index);
-	if (err)
-		return err;
-
-	if (!devlink->ops->sb_pool_get)
-		return -EOPNOTSUPP;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	err = devlink_nl_sb_pool_fill(msg, devlink, devlink_sb, pool_index,
-				      DEVLINK_CMD_SB_POOL_NEW,
-				      info->snd_portid, info->snd_seq, 0);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
-
-	return genlmsg_reply(msg, info);
-}
-
-static int __sb_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
-				struct devlink *devlink,
-				struct devlink_sb *devlink_sb,
-				u32 portid, u32 seq, int flags)
-{
-	u16 pool_count = devlink_sb_pool_count(devlink_sb);
-	u16 pool_index;
-	int err;
-
-	for (pool_index = 0; pool_index < pool_count; pool_index++) {
-		if (*p_idx < start) {
-			(*p_idx)++;
-			continue;
-		}
-		err = devlink_nl_sb_pool_fill(msg, devlink,
-					      devlink_sb,
-					      pool_index,
-					      DEVLINK_CMD_SB_POOL_NEW,
-					      portid, seq, flags);
-		if (err)
-			return err;
-		(*p_idx)++;
-	}
-	return 0;
-}
-
-static int
-devlink_nl_sb_pool_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				struct netlink_callback *cb, int flags)
-{
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_sb *devlink_sb;
-	int err = 0;
-	int idx = 0;
-
-	if (!devlink->ops->sb_pool_get)
-		return 0;
-
-	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
-		err = __sb_pool_get_dumpit(msg, state->idx, &idx,
-					   devlink, devlink_sb,
-					   NETLINK_CB(cb->skb).portid,
-					   cb->nlh->nlmsg_seq, flags);
-		if (err == -EOPNOTSUPP) {
-			err = 0;
-		} else if (err) {
-			state->idx = idx;
-			break;
-		}
-	}
-
-	return err;
-}
-
-int devlink_nl_sb_pool_get_dumpit(struct sk_buff *skb,
-				  struct netlink_callback *cb)
-{
-	return devlink_nl_dumpit(skb, cb, devlink_nl_sb_pool_get_dump_one);
-}
-
-static int devlink_sb_pool_set(struct devlink *devlink, unsigned int sb_index,
-			       u16 pool_index, u32 size,
-			       enum devlink_sb_threshold_type threshold_type,
-			       struct netlink_ext_ack *extack)
-
-{
-	const struct devlink_ops *ops = devlink->ops;
-
-	if (ops->sb_pool_set)
-		return ops->sb_pool_set(devlink, sb_index, pool_index,
-					size, threshold_type, extack);
-	return -EOPNOTSUPP;
-}
-
-static int devlink_nl_cmd_sb_pool_set_doit(struct sk_buff *skb,
-					   struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	enum devlink_sb_threshold_type threshold_type;
-	struct devlink_sb *devlink_sb;
-	u16 pool_index;
-	u32 size;
-	int err;
-
-	devlink_sb = devlink_sb_get_from_info(devlink, info);
-	if (IS_ERR(devlink_sb))
-		return PTR_ERR(devlink_sb);
-
-	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
-						  &pool_index);
-	if (err)
-		return err;
-
-	err = devlink_sb_th_type_get_from_info(info, &threshold_type);
-	if (err)
-		return err;
-
-	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_SB_POOL_SIZE))
-		return -EINVAL;
-
-	size = nla_get_u32(info->attrs[DEVLINK_ATTR_SB_POOL_SIZE]);
-	return devlink_sb_pool_set(devlink, devlink_sb->index,
-				   pool_index, size, threshold_type,
-				   info->extack);
-}
-
-static int devlink_nl_sb_port_pool_fill(struct sk_buff *msg,
-					struct devlink *devlink,
-					struct devlink_port *devlink_port,
-					struct devlink_sb *devlink_sb,
-					u16 pool_index,
-					enum devlink_command cmd,
-					u32 portid, u32 seq, int flags)
-{
-	const struct devlink_ops *ops = devlink->ops;
-	u32 threshold;
-	void *hdr;
-	int err;
-
-	err = ops->sb_port_pool_get(devlink_port, devlink_sb->index,
-				    pool_index, &threshold);
-	if (err)
-		return err;
-
-	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
-	if (!hdr)
-		return -EMSGSIZE;
-
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_SB_INDEX, devlink_sb->index))
-		goto nla_put_failure;
-	if (nla_put_u16(msg, DEVLINK_ATTR_SB_POOL_INDEX, pool_index))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_SB_THRESHOLD, threshold))
-		goto nla_put_failure;
-
-	if (ops->sb_occ_port_pool_get) {
-		u32 cur;
-		u32 max;
-
-		err = ops->sb_occ_port_pool_get(devlink_port, devlink_sb->index,
-						pool_index, &cur, &max);
-		if (err && err != -EOPNOTSUPP)
-			goto sb_occ_get_failure;
-		if (!err) {
-			if (nla_put_u32(msg, DEVLINK_ATTR_SB_OCC_CUR, cur))
-				goto nla_put_failure;
-			if (nla_put_u32(msg, DEVLINK_ATTR_SB_OCC_MAX, max))
-				goto nla_put_failure;
-		}
-	}
-
-	genlmsg_end(msg, hdr);
-	return 0;
-
-nla_put_failure:
-	err = -EMSGSIZE;
-sb_occ_get_failure:
-	genlmsg_cancel(msg, hdr);
-	return err;
-}
-
-int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
-				     struct genl_info *info)
-{
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = devlink_port->devlink;
-	struct devlink_sb *devlink_sb;
-	struct sk_buff *msg;
-	u16 pool_index;
-	int err;
-
-	devlink_sb = devlink_sb_get_from_info(devlink, info);
-	if (IS_ERR(devlink_sb))
-		return PTR_ERR(devlink_sb);
-
-	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
-						  &pool_index);
-	if (err)
-		return err;
-
-	if (!devlink->ops->sb_port_pool_get)
-		return -EOPNOTSUPP;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	err = devlink_nl_sb_port_pool_fill(msg, devlink, devlink_port,
-					   devlink_sb, pool_index,
-					   DEVLINK_CMD_SB_PORT_POOL_NEW,
-					   info->snd_portid, info->snd_seq, 0);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
-
-	return genlmsg_reply(msg, info);
-}
-
-static int __sb_port_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
-				     struct devlink *devlink,
-				     struct devlink_sb *devlink_sb,
-				     u32 portid, u32 seq, int flags)
-{
-	struct devlink_port *devlink_port;
-	u16 pool_count = devlink_sb_pool_count(devlink_sb);
-	unsigned long port_index;
-	u16 pool_index;
-	int err;
-
-	xa_for_each(&devlink->ports, port_index, devlink_port) {
-		for (pool_index = 0; pool_index < pool_count; pool_index++) {
-			if (*p_idx < start) {
-				(*p_idx)++;
-				continue;
-			}
-			err = devlink_nl_sb_port_pool_fill(msg, devlink,
-							   devlink_port,
-							   devlink_sb,
-							   pool_index,
-							   DEVLINK_CMD_SB_PORT_POOL_NEW,
-							   portid, seq, flags);
-			if (err)
-				return err;
-			(*p_idx)++;
-		}
-	}
-	return 0;
-}
-
-static int
-devlink_nl_sb_port_pool_get_dump_one(struct sk_buff *msg,
-				     struct devlink *devlink,
-				     struct netlink_callback *cb, int flags)
-{
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_sb *devlink_sb;
-	int idx = 0;
-	int err = 0;
-
-	if (!devlink->ops->sb_port_pool_get)
-		return 0;
-
-	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
-		err = __sb_port_pool_get_dumpit(msg, state->idx, &idx,
-						devlink, devlink_sb,
-						NETLINK_CB(cb->skb).portid,
-						cb->nlh->nlmsg_seq, flags);
-		if (err == -EOPNOTSUPP) {
-			err = 0;
-		} else if (err) {
-			state->idx = idx;
-			break;
-		}
-	}
-
-	return err;
-}
-
-int devlink_nl_sb_port_pool_get_dumpit(struct sk_buff *skb,
-				       struct netlink_callback *cb)
-{
-	return devlink_nl_dumpit(skb, cb, devlink_nl_sb_port_pool_get_dump_one);
-}
-
-static int devlink_sb_port_pool_set(struct devlink_port *devlink_port,
-				    unsigned int sb_index, u16 pool_index,
-				    u32 threshold,
-				    struct netlink_ext_ack *extack)
-
-{
-	const struct devlink_ops *ops = devlink_port->devlink->ops;
-
-	if (ops->sb_port_pool_set)
-		return ops->sb_port_pool_set(devlink_port, sb_index,
-					     pool_index, threshold, extack);
-	return -EOPNOTSUPP;
-}
-
-static int devlink_nl_cmd_sb_port_pool_set_doit(struct sk_buff *skb,
-						struct genl_info *info)
-{
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_sb *devlink_sb;
-	u16 pool_index;
-	u32 threshold;
-	int err;
-
-	devlink_sb = devlink_sb_get_from_info(devlink, info);
-	if (IS_ERR(devlink_sb))
-		return PTR_ERR(devlink_sb);
-
-	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
-						  &pool_index);
-	if (err)
-		return err;
-
-	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_SB_THRESHOLD))
-		return -EINVAL;
-
-	threshold = nla_get_u32(info->attrs[DEVLINK_ATTR_SB_THRESHOLD]);
-	return devlink_sb_port_pool_set(devlink_port, devlink_sb->index,
-					pool_index, threshold, info->extack);
-}
-
-static int
-devlink_nl_sb_tc_pool_bind_fill(struct sk_buff *msg, struct devlink *devlink,
-				struct devlink_port *devlink_port,
-				struct devlink_sb *devlink_sb, u16 tc_index,
-				enum devlink_sb_pool_type pool_type,
-				enum devlink_command cmd,
-				u32 portid, u32 seq, int flags)
-{
-	const struct devlink_ops *ops = devlink->ops;
-	u16 pool_index;
-	u32 threshold;
-	void *hdr;
-	int err;
-
-	err = ops->sb_tc_pool_bind_get(devlink_port, devlink_sb->index,
-				       tc_index, pool_type,
-				       &pool_index, &threshold);
-	if (err)
-		return err;
-
-	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
-	if (!hdr)
-		return -EMSGSIZE;
-
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_SB_INDEX, devlink_sb->index))
-		goto nla_put_failure;
-	if (nla_put_u16(msg, DEVLINK_ATTR_SB_TC_INDEX, tc_index))
-		goto nla_put_failure;
-	if (nla_put_u8(msg, DEVLINK_ATTR_SB_POOL_TYPE, pool_type))
-		goto nla_put_failure;
-	if (nla_put_u16(msg, DEVLINK_ATTR_SB_POOL_INDEX, pool_index))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_SB_THRESHOLD, threshold))
-		goto nla_put_failure;
-
-	if (ops->sb_occ_tc_port_bind_get) {
-		u32 cur;
-		u32 max;
-
-		err = ops->sb_occ_tc_port_bind_get(devlink_port,
-						   devlink_sb->index,
-						   tc_index, pool_type,
-						   &cur, &max);
-		if (err && err != -EOPNOTSUPP)
-			return err;
-		if (!err) {
-			if (nla_put_u32(msg, DEVLINK_ATTR_SB_OCC_CUR, cur))
-				goto nla_put_failure;
-			if (nla_put_u32(msg, DEVLINK_ATTR_SB_OCC_MAX, max))
-				goto nla_put_failure;
-		}
-	}
-
-	genlmsg_end(msg, hdr);
-	return 0;
-
-nla_put_failure:
-	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
+	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
 }
 
-int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
-					struct genl_info *info)
+int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = devlink_port->devlink;
-	struct devlink_sb *devlink_sb;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_linecard *linecard;
 	struct sk_buff *msg;
-	enum devlink_sb_pool_type pool_type;
-	u16 tc_index;
 	int err;
 
-	devlink_sb = devlink_sb_get_from_info(devlink, info);
-	if (IS_ERR(devlink_sb))
-		return PTR_ERR(devlink_sb);
-
-	err = devlink_sb_pool_type_get_from_info(info, &pool_type);
-	if (err)
-		return err;
-
-	err = devlink_sb_tc_index_get_from_info(devlink_sb, info,
-						pool_type, &tc_index);
-	if (err)
-		return err;
-
-	if (!devlink->ops->sb_tc_pool_bind_get)
-		return -EOPNOTSUPP;
+	linecard = devlink_linecard_get_from_info(devlink, info);
+	if (IS_ERR(linecard))
+		return PTR_ERR(linecard);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
-	err = devlink_nl_sb_tc_pool_bind_fill(msg, devlink, devlink_port,
-					      devlink_sb, tc_index, pool_type,
-					      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
-					      info->snd_portid,
-					      info->snd_seq, 0);
+	mutex_lock(&linecard->state_lock);
+	err = devlink_nl_linecard_fill(msg, devlink, linecard,
+				       DEVLINK_CMD_LINECARD_NEW,
+				       info->snd_portid, info->snd_seq, 0,
+				       info->extack);
+	mutex_unlock(&linecard->state_lock);
 	if (err) {
 		nlmsg_free(msg);
 		return err;
@@ -1880,179 +928,204 @@ int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
 	return genlmsg_reply(msg, info);
 }
 
-static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
-					int start, int *p_idx,
-					struct devlink *devlink,
-					struct devlink_sb *devlink_sb,
-					u32 portid, u32 seq, int flags)
-{
-	struct devlink_port *devlink_port;
-	unsigned long port_index;
-	u16 tc_index;
-	int err;
-
-	xa_for_each(&devlink->ports, port_index, devlink_port) {
-		for (tc_index = 0;
-		     tc_index < devlink_sb->ingress_tc_count; tc_index++) {
-			if (*p_idx < start) {
-				(*p_idx)++;
-				continue;
-			}
-			err = devlink_nl_sb_tc_pool_bind_fill(msg, devlink,
-							      devlink_port,
-							      devlink_sb,
-							      tc_index,
-							      DEVLINK_SB_POOL_TYPE_INGRESS,
-							      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
-							      portid, seq,
-							      flags);
-			if (err)
-				return err;
-			(*p_idx)++;
-		}
-		for (tc_index = 0;
-		     tc_index < devlink_sb->egress_tc_count; tc_index++) {
-			if (*p_idx < start) {
-				(*p_idx)++;
-				continue;
-			}
-			err = devlink_nl_sb_tc_pool_bind_fill(msg, devlink,
-							      devlink_port,
-							      devlink_sb,
-							      tc_index,
-							      DEVLINK_SB_POOL_TYPE_EGRESS,
-							      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
-							      portid, seq,
-							      flags);
-			if (err)
-				return err;
-			(*p_idx)++;
-		}
-	}
-	return 0;
-}
-
-static int devlink_nl_sb_tc_pool_bind_get_dump_one(struct sk_buff *msg,
-						   struct devlink *devlink,
-						   struct netlink_callback *cb,
-						   int flags)
+static int devlink_nl_linecard_get_dump_one(struct sk_buff *msg,
+					    struct devlink *devlink,
+					    struct netlink_callback *cb,
+					    int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_sb *devlink_sb;
+	struct devlink_linecard *linecard;
 	int idx = 0;
 	int err = 0;
 
-	if (!devlink->ops->sb_tc_pool_bind_get)
-		return 0;
-
-	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
-		err = __sb_tc_pool_bind_get_dumpit(msg, state->idx, &idx,
-						   devlink, devlink_sb,
-						   NETLINK_CB(cb->skb).portid,
-						   cb->nlh->nlmsg_seq, flags);
-		if (err == -EOPNOTSUPP) {
-			err = 0;
-		} else if (err) {
+	list_for_each_entry(linecard, &devlink->linecard_list, list) {
+		if (idx < state->idx) {
+			idx++;
+			continue;
+		}
+		mutex_lock(&linecard->state_lock);
+		err = devlink_nl_linecard_fill(msg, devlink, linecard,
+					       DEVLINK_CMD_LINECARD_NEW,
+					       NETLINK_CB(cb->skb).portid,
+					       cb->nlh->nlmsg_seq, flags,
+					       cb->extack);
+		mutex_unlock(&linecard->state_lock);
+		if (err) {
 			state->idx = idx;
 			break;
 		}
+		idx++;
 	}
 
 	return err;
 }
 
-int devlink_nl_sb_tc_pool_bind_get_dumpit(struct sk_buff *skb,
-					  struct netlink_callback *cb)
+int devlink_nl_linecard_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb)
 {
-	return devlink_nl_dumpit(skb, cb,
-				 devlink_nl_sb_tc_pool_bind_get_dump_one);
+	return devlink_nl_dumpit(skb, cb, devlink_nl_linecard_get_dump_one);
 }
 
-static int devlink_sb_tc_pool_bind_set(struct devlink_port *devlink_port,
-				       unsigned int sb_index, u16 tc_index,
-				       enum devlink_sb_pool_type pool_type,
-				       u16 pool_index, u32 threshold,
-				       struct netlink_ext_ack *extack)
-
+static struct devlink_linecard_type *
+devlink_linecard_type_lookup(struct devlink_linecard *linecard,
+			     const char *type)
 {
-	const struct devlink_ops *ops = devlink_port->devlink->ops;
+	struct devlink_linecard_type *linecard_type;
+	int i;
 
-	if (ops->sb_tc_pool_bind_set)
-		return ops->sb_tc_pool_bind_set(devlink_port, sb_index,
-						tc_index, pool_type,
-						pool_index, threshold, extack);
-	return -EOPNOTSUPP;
+	for (i = 0; i < linecard->types_count; i++) {
+		linecard_type = &linecard->types[i];
+		if (!strcmp(type, linecard_type->type))
+			return linecard_type;
+	}
+	return NULL;
 }
 
-static int devlink_nl_cmd_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
-						   struct genl_info *info)
+static int devlink_linecard_type_set(struct devlink_linecard *linecard,
+				     const char *type,
+				     struct netlink_ext_ack *extack)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
-	enum devlink_sb_pool_type pool_type;
-	struct devlink_sb *devlink_sb;
-	u16 tc_index;
-	u16 pool_index;
-	u32 threshold;
+	const struct devlink_linecard_ops *ops = linecard->ops;
+	struct devlink_linecard_type *linecard_type;
 	int err;
 
-	devlink_sb = devlink_sb_get_from_info(devlink, info);
-	if (IS_ERR(devlink_sb))
-		return PTR_ERR(devlink_sb);
-
-	err = devlink_sb_pool_type_get_from_info(info, &pool_type);
-	if (err)
-		return err;
+	mutex_lock(&linecard->state_lock);
+	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING) {
+		NL_SET_ERR_MSG(extack, "Line card is currently being provisioned");
+		err = -EBUSY;
+		goto out;
+	}
+	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONING) {
+		NL_SET_ERR_MSG(extack, "Line card is currently being unprovisioned");
+		err = -EBUSY;
+		goto out;
+	}
 
-	err = devlink_sb_tc_index_get_from_info(devlink_sb, info,
-						pool_type, &tc_index);
-	if (err)
-		return err;
+	linecard_type = devlink_linecard_type_lookup(linecard, type);
+	if (!linecard_type) {
+		NL_SET_ERR_MSG(extack, "Unsupported line card type provided");
+		err = -EINVAL;
+		goto out;
+	}
 
-	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
-						  &pool_index);
-	if (err)
-		return err;
+	if (linecard->state != DEVLINK_LINECARD_STATE_UNPROVISIONED &&
+	    linecard->state != DEVLINK_LINECARD_STATE_PROVISIONING_FAILED) {
+		NL_SET_ERR_MSG(extack, "Line card already provisioned");
+		err = -EBUSY;
+		/* Check if the line card is provisioned in the same
+		 * way the user asks. In case it is, make the operation
+		 * to return success.
+		 */
+		if (ops->same_provision &&
+		    ops->same_provision(linecard, linecard->priv,
+					linecard_type->type,
+					linecard_type->priv))
+			err = 0;
+		goto out;
+	}
 
-	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_SB_THRESHOLD))
-		return -EINVAL;
+	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONING;
+	linecard->type = linecard_type->type;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
+	err = ops->provision(linecard, linecard->priv, linecard_type->type,
+			     linecard_type->priv, extack);
+	if (err) {
+		/* Provisioning failed. Assume the linecard is unprovisioned
+		 * for future operations.
+		 */
+		mutex_lock(&linecard->state_lock);
+		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+		linecard->type = NULL;
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+		mutex_unlock(&linecard->state_lock);
+	}
+	return err;
 
-	threshold = nla_get_u32(info->attrs[DEVLINK_ATTR_SB_THRESHOLD]);
-	return devlink_sb_tc_pool_bind_set(devlink_port, devlink_sb->index,
-					   tc_index, pool_type,
-					   pool_index, threshold, info->extack);
+out:
+	mutex_unlock(&linecard->state_lock);
+	return err;
 }
 
-static int devlink_nl_cmd_sb_occ_snapshot_doit(struct sk_buff *skb,
-					       struct genl_info *info)
+static int devlink_linecard_type_unset(struct devlink_linecard *linecard,
+				       struct netlink_ext_ack *extack)
 {
-	struct devlink *devlink = info->user_ptr[0];
-	const struct devlink_ops *ops = devlink->ops;
-	struct devlink_sb *devlink_sb;
+	int err;
+
+	mutex_lock(&linecard->state_lock);
+	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING) {
+		NL_SET_ERR_MSG(extack, "Line card is currently being provisioned");
+		err = -EBUSY;
+		goto out;
+	}
+	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONING) {
+		NL_SET_ERR_MSG(extack, "Line card is currently being unprovisioned");
+		err = -EBUSY;
+		goto out;
+	}
+	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING_FAILED) {
+		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+		linecard->type = NULL;
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+		err = 0;
+		goto out;
+	}
 
-	devlink_sb = devlink_sb_get_from_info(devlink, info);
-	if (IS_ERR(devlink_sb))
-		return PTR_ERR(devlink_sb);
+	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONED) {
+		NL_SET_ERR_MSG(extack, "Line card is not provisioned");
+		err = 0;
+		goto out;
+	}
+	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONING;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
+	err = linecard->ops->unprovision(linecard, linecard->priv,
+					 extack);
+	if (err) {
+		/* Unprovisioning failed. Assume the linecard is unprovisioned
+		 * for future operations.
+		 */
+		mutex_lock(&linecard->state_lock);
+		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+		linecard->type = NULL;
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+		mutex_unlock(&linecard->state_lock);
+	}
+	return err;
 
-	if (ops->sb_occ_snapshot)
-		return ops->sb_occ_snapshot(devlink, devlink_sb->index);
-	return -EOPNOTSUPP;
+out:
+	mutex_unlock(&linecard->state_lock);
+	return err;
 }
 
-static int devlink_nl_cmd_sb_occ_max_clear_doit(struct sk_buff *skb,
-						struct genl_info *info)
+static int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
+					    struct genl_info *info)
 {
+	struct netlink_ext_ack *extack = info->extack;
 	struct devlink *devlink = info->user_ptr[0];
-	const struct devlink_ops *ops = devlink->ops;
-	struct devlink_sb *devlink_sb;
+	struct devlink_linecard *linecard;
+	int err;
 
-	devlink_sb = devlink_sb_get_from_info(devlink, info);
-	if (IS_ERR(devlink_sb))
-		return PTR_ERR(devlink_sb);
+	linecard = devlink_linecard_get_from_info(devlink, info);
+	if (IS_ERR(linecard))
+		return PTR_ERR(linecard);
+
+	if (info->attrs[DEVLINK_ATTR_LINECARD_TYPE]) {
+		const char *type;
+
+		type = nla_data(info->attrs[DEVLINK_ATTR_LINECARD_TYPE]);
+		if (strcmp(type, "")) {
+			err = devlink_linecard_type_set(linecard, type, extack);
+			if (err)
+				return err;
+		} else {
+			err = devlink_linecard_type_unset(linecard, extack);
+			if (err)
+				return err;
+		}
+	}
 
-	if (ops->sb_occ_max_clear)
-		return ops->sb_occ_max_clear(devlink, devlink_sb->index);
-	return -EOPNOTSUPP;
+	return 0;
 }
 
 int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
@@ -6215,69 +5288,6 @@ void devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
 }
 EXPORT_SYMBOL_GPL(devlink_linecard_nested_dl_set);
 
-int devl_sb_register(struct devlink *devlink, unsigned int sb_index,
-		     u32 size, u16 ingress_pools_count,
-		     u16 egress_pools_count, u16 ingress_tc_count,
-		     u16 egress_tc_count)
-{
-	struct devlink_sb *devlink_sb;
-
-	lockdep_assert_held(&devlink->lock);
-
-	if (devlink_sb_index_exists(devlink, sb_index))
-		return -EEXIST;
-
-	devlink_sb = kzalloc(sizeof(*devlink_sb), GFP_KERNEL);
-	if (!devlink_sb)
-		return -ENOMEM;
-	devlink_sb->index = sb_index;
-	devlink_sb->size = size;
-	devlink_sb->ingress_pools_count = ingress_pools_count;
-	devlink_sb->egress_pools_count = egress_pools_count;
-	devlink_sb->ingress_tc_count = ingress_tc_count;
-	devlink_sb->egress_tc_count = egress_tc_count;
-	list_add_tail(&devlink_sb->list, &devlink->sb_list);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devl_sb_register);
-
-int devlink_sb_register(struct devlink *devlink, unsigned int sb_index,
-			u32 size, u16 ingress_pools_count,
-			u16 egress_pools_count, u16 ingress_tc_count,
-			u16 egress_tc_count)
-{
-	int err;
-
-	devl_lock(devlink);
-	err = devl_sb_register(devlink, sb_index, size, ingress_pools_count,
-			       egress_pools_count, ingress_tc_count,
-			       egress_tc_count);
-	devl_unlock(devlink);
-	return err;
-}
-EXPORT_SYMBOL_GPL(devlink_sb_register);
-
-void devl_sb_unregister(struct devlink *devlink, unsigned int sb_index)
-{
-	struct devlink_sb *devlink_sb;
-
-	lockdep_assert_held(&devlink->lock);
-
-	devlink_sb = devlink_sb_get_by_index(devlink, sb_index);
-	WARN_ON(!devlink_sb);
-	list_del(&devlink_sb->list);
-	kfree(devlink_sb);
-}
-EXPORT_SYMBOL_GPL(devl_sb_unregister);
-
-void devlink_sb_unregister(struct devlink *devlink, unsigned int sb_index)
-{
-	devl_lock(devlink);
-	devl_sb_unregister(devlink, sb_index);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_sb_unregister);
-
 /**
  * devl_dpipe_headers_register - register dpipe headers
  *
diff --git a/net/devlink/sb.c b/net/devlink/sb.c
new file mode 100644
index 000000000000..bd677fff5ec8
--- /dev/null
+++ b/net/devlink/sb.c
@@ -0,0 +1,996 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
+ */
+
+#include "devl_internal.h"
+
+struct devlink_sb {
+	struct list_head list;
+	unsigned int index;
+	u32 size;
+	u16 ingress_pools_count;
+	u16 egress_pools_count;
+	u16 ingress_tc_count;
+	u16 egress_tc_count;
+};
+
+static u16 devlink_sb_pool_count(struct devlink_sb *devlink_sb)
+{
+	return devlink_sb->ingress_pools_count + devlink_sb->egress_pools_count;
+}
+
+static struct devlink_sb *devlink_sb_get_by_index(struct devlink *devlink,
+						  unsigned int sb_index)
+{
+	struct devlink_sb *devlink_sb;
+
+	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
+		if (devlink_sb->index == sb_index)
+			return devlink_sb;
+	}
+	return NULL;
+}
+
+static bool devlink_sb_index_exists(struct devlink *devlink,
+				    unsigned int sb_index)
+{
+	return devlink_sb_get_by_index(devlink, sb_index);
+}
+
+static struct devlink_sb *devlink_sb_get_from_attrs(struct devlink *devlink,
+						    struct nlattr **attrs)
+{
+	if (attrs[DEVLINK_ATTR_SB_INDEX]) {
+		u32 sb_index = nla_get_u32(attrs[DEVLINK_ATTR_SB_INDEX]);
+		struct devlink_sb *devlink_sb;
+
+		devlink_sb = devlink_sb_get_by_index(devlink, sb_index);
+		if (!devlink_sb)
+			return ERR_PTR(-ENODEV);
+		return devlink_sb;
+	}
+	return ERR_PTR(-EINVAL);
+}
+
+static struct devlink_sb *devlink_sb_get_from_info(struct devlink *devlink,
+						   struct genl_info *info)
+{
+	return devlink_sb_get_from_attrs(devlink, info->attrs);
+}
+
+static int devlink_sb_pool_index_get_from_attrs(struct devlink_sb *devlink_sb,
+						struct nlattr **attrs,
+						u16 *p_pool_index)
+{
+	u16 val;
+
+	if (!attrs[DEVLINK_ATTR_SB_POOL_INDEX])
+		return -EINVAL;
+
+	val = nla_get_u16(attrs[DEVLINK_ATTR_SB_POOL_INDEX]);
+	if (val >= devlink_sb_pool_count(devlink_sb))
+		return -EINVAL;
+	*p_pool_index = val;
+	return 0;
+}
+
+static int devlink_sb_pool_index_get_from_info(struct devlink_sb *devlink_sb,
+					       struct genl_info *info,
+					       u16 *p_pool_index)
+{
+	return devlink_sb_pool_index_get_from_attrs(devlink_sb, info->attrs,
+						    p_pool_index);
+}
+
+static int
+devlink_sb_pool_type_get_from_attrs(struct nlattr **attrs,
+				    enum devlink_sb_pool_type *p_pool_type)
+{
+	u8 val;
+
+	if (!attrs[DEVLINK_ATTR_SB_POOL_TYPE])
+		return -EINVAL;
+
+	val = nla_get_u8(attrs[DEVLINK_ATTR_SB_POOL_TYPE]);
+	if (val != DEVLINK_SB_POOL_TYPE_INGRESS &&
+	    val != DEVLINK_SB_POOL_TYPE_EGRESS)
+		return -EINVAL;
+	*p_pool_type = val;
+	return 0;
+}
+
+static int
+devlink_sb_pool_type_get_from_info(struct genl_info *info,
+				   enum devlink_sb_pool_type *p_pool_type)
+{
+	return devlink_sb_pool_type_get_from_attrs(info->attrs, p_pool_type);
+}
+
+static int
+devlink_sb_th_type_get_from_attrs(struct nlattr **attrs,
+				  enum devlink_sb_threshold_type *p_th_type)
+{
+	u8 val;
+
+	if (!attrs[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE])
+		return -EINVAL;
+
+	val = nla_get_u8(attrs[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE]);
+	if (val != DEVLINK_SB_THRESHOLD_TYPE_STATIC &&
+	    val != DEVLINK_SB_THRESHOLD_TYPE_DYNAMIC)
+		return -EINVAL;
+	*p_th_type = val;
+	return 0;
+}
+
+static int
+devlink_sb_th_type_get_from_info(struct genl_info *info,
+				 enum devlink_sb_threshold_type *p_th_type)
+{
+	return devlink_sb_th_type_get_from_attrs(info->attrs, p_th_type);
+}
+
+static int
+devlink_sb_tc_index_get_from_attrs(struct devlink_sb *devlink_sb,
+				   struct nlattr **attrs,
+				   enum devlink_sb_pool_type pool_type,
+				   u16 *p_tc_index)
+{
+	u16 val;
+
+	if (!attrs[DEVLINK_ATTR_SB_TC_INDEX])
+		return -EINVAL;
+
+	val = nla_get_u16(attrs[DEVLINK_ATTR_SB_TC_INDEX]);
+	if (pool_type == DEVLINK_SB_POOL_TYPE_INGRESS &&
+	    val >= devlink_sb->ingress_tc_count)
+		return -EINVAL;
+	if (pool_type == DEVLINK_SB_POOL_TYPE_EGRESS &&
+	    val >= devlink_sb->egress_tc_count)
+		return -EINVAL;
+	*p_tc_index = val;
+	return 0;
+}
+
+static int
+devlink_sb_tc_index_get_from_info(struct devlink_sb *devlink_sb,
+				  struct genl_info *info,
+				  enum devlink_sb_pool_type pool_type,
+				  u16 *p_tc_index)
+{
+	return devlink_sb_tc_index_get_from_attrs(devlink_sb, info->attrs,
+						  pool_type, p_tc_index);
+}
+
+static int devlink_nl_sb_fill(struct sk_buff *msg, struct devlink *devlink,
+			      struct devlink_sb *devlink_sb,
+			      enum devlink_command cmd, u32 portid,
+			      u32 seq, int flags)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_SB_INDEX, devlink_sb->index))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_SB_SIZE, devlink_sb->size))
+		goto nla_put_failure;
+	if (nla_put_u16(msg, DEVLINK_ATTR_SB_INGRESS_POOL_COUNT,
+			devlink_sb->ingress_pools_count))
+		goto nla_put_failure;
+	if (nla_put_u16(msg, DEVLINK_ATTR_SB_EGRESS_POOL_COUNT,
+			devlink_sb->egress_pools_count))
+		goto nla_put_failure;
+	if (nla_put_u16(msg, DEVLINK_ATTR_SB_INGRESS_TC_COUNT,
+			devlink_sb->ingress_tc_count))
+		goto nla_put_failure;
+	if (nla_put_u16(msg, DEVLINK_ATTR_SB_EGRESS_TC_COUNT,
+			devlink_sb->egress_tc_count))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_sb *devlink_sb;
+	struct sk_buff *msg;
+	int err;
+
+	devlink_sb = devlink_sb_get_from_info(devlink, info);
+	if (IS_ERR(devlink_sb))
+		return PTR_ERR(devlink_sb);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_sb_fill(msg, devlink, devlink_sb,
+				 DEVLINK_CMD_SB_NEW,
+				 info->snd_portid, info->snd_seq, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
+static int
+devlink_nl_sb_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+			   struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_sb *devlink_sb;
+	int idx = 0;
+	int err = 0;
+
+	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
+		if (idx < state->idx) {
+			idx++;
+			continue;
+		}
+		err = devlink_nl_sb_fill(msg, devlink, devlink_sb,
+					 DEVLINK_CMD_SB_NEW,
+					 NETLINK_CB(cb->skb).portid,
+					 cb->nlh->nlmsg_seq, flags);
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
+int devlink_nl_sb_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_sb_get_dump_one);
+}
+
+static int devlink_nl_sb_pool_fill(struct sk_buff *msg, struct devlink *devlink,
+				   struct devlink_sb *devlink_sb,
+				   u16 pool_index, enum devlink_command cmd,
+				   u32 portid, u32 seq, int flags)
+{
+	struct devlink_sb_pool_info pool_info;
+	void *hdr;
+	int err;
+
+	err = devlink->ops->sb_pool_get(devlink, devlink_sb->index,
+					pool_index, &pool_info);
+	if (err)
+		return err;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_SB_INDEX, devlink_sb->index))
+		goto nla_put_failure;
+	if (nla_put_u16(msg, DEVLINK_ATTR_SB_POOL_INDEX, pool_index))
+		goto nla_put_failure;
+	if (nla_put_u8(msg, DEVLINK_ATTR_SB_POOL_TYPE, pool_info.pool_type))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_SB_POOL_SIZE, pool_info.size))
+		goto nla_put_failure;
+	if (nla_put_u8(msg, DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE,
+		       pool_info.threshold_type))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_SB_POOL_CELL_SIZE,
+			pool_info.cell_size))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_sb *devlink_sb;
+	struct sk_buff *msg;
+	u16 pool_index;
+	int err;
+
+	devlink_sb = devlink_sb_get_from_info(devlink, info);
+	if (IS_ERR(devlink_sb))
+		return PTR_ERR(devlink_sb);
+
+	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
+						  &pool_index);
+	if (err)
+		return err;
+
+	if (!devlink->ops->sb_pool_get)
+		return -EOPNOTSUPP;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_sb_pool_fill(msg, devlink, devlink_sb, pool_index,
+				      DEVLINK_CMD_SB_POOL_NEW,
+				      info->snd_portid, info->snd_seq, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
+static int __sb_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
+				struct devlink *devlink,
+				struct devlink_sb *devlink_sb,
+				u32 portid, u32 seq, int flags)
+{
+	u16 pool_count = devlink_sb_pool_count(devlink_sb);
+	u16 pool_index;
+	int err;
+
+	for (pool_index = 0; pool_index < pool_count; pool_index++) {
+		if (*p_idx < start) {
+			(*p_idx)++;
+			continue;
+		}
+		err = devlink_nl_sb_pool_fill(msg, devlink,
+					      devlink_sb,
+					      pool_index,
+					      DEVLINK_CMD_SB_POOL_NEW,
+					      portid, seq, flags);
+		if (err)
+			return err;
+		(*p_idx)++;
+	}
+	return 0;
+}
+
+static int
+devlink_nl_sb_pool_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+				struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_sb *devlink_sb;
+	int err = 0;
+	int idx = 0;
+
+	if (!devlink->ops->sb_pool_get)
+		return 0;
+
+	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
+		err = __sb_pool_get_dumpit(msg, state->idx, &idx,
+					   devlink, devlink_sb,
+					   NETLINK_CB(cb->skb).portid,
+					   cb->nlh->nlmsg_seq, flags);
+		if (err == -EOPNOTSUPP) {
+			err = 0;
+		} else if (err) {
+			state->idx = idx;
+			break;
+		}
+	}
+
+	return err;
+}
+
+int devlink_nl_sb_pool_get_dumpit(struct sk_buff *skb,
+				  struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_sb_pool_get_dump_one);
+}
+
+static int devlink_sb_pool_set(struct devlink *devlink, unsigned int sb_index,
+			       u16 pool_index, u32 size,
+			       enum devlink_sb_threshold_type threshold_type,
+			       struct netlink_ext_ack *extack)
+
+{
+	const struct devlink_ops *ops = devlink->ops;
+
+	if (ops->sb_pool_set)
+		return ops->sb_pool_set(devlink, sb_index, pool_index,
+					size, threshold_type, extack);
+	return -EOPNOTSUPP;
+}
+
+int devlink_nl_cmd_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	enum devlink_sb_threshold_type threshold_type;
+	struct devlink_sb *devlink_sb;
+	u16 pool_index;
+	u32 size;
+	int err;
+
+	devlink_sb = devlink_sb_get_from_info(devlink, info);
+	if (IS_ERR(devlink_sb))
+		return PTR_ERR(devlink_sb);
+
+	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
+						  &pool_index);
+	if (err)
+		return err;
+
+	err = devlink_sb_th_type_get_from_info(info, &threshold_type);
+	if (err)
+		return err;
+
+	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_SB_POOL_SIZE))
+		return -EINVAL;
+
+	size = nla_get_u32(info->attrs[DEVLINK_ATTR_SB_POOL_SIZE]);
+	return devlink_sb_pool_set(devlink, devlink_sb->index,
+				   pool_index, size, threshold_type,
+				   info->extack);
+}
+
+static int devlink_nl_sb_port_pool_fill(struct sk_buff *msg,
+					struct devlink *devlink,
+					struct devlink_port *devlink_port,
+					struct devlink_sb *devlink_sb,
+					u16 pool_index,
+					enum devlink_command cmd,
+					u32 portid, u32 seq, int flags)
+{
+	const struct devlink_ops *ops = devlink->ops;
+	u32 threshold;
+	void *hdr;
+	int err;
+
+	err = ops->sb_port_pool_get(devlink_port, devlink_sb->index,
+				    pool_index, &threshold);
+	if (err)
+		return err;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_SB_INDEX, devlink_sb->index))
+		goto nla_put_failure;
+	if (nla_put_u16(msg, DEVLINK_ATTR_SB_POOL_INDEX, pool_index))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_SB_THRESHOLD, threshold))
+		goto nla_put_failure;
+
+	if (ops->sb_occ_port_pool_get) {
+		u32 cur;
+		u32 max;
+
+		err = ops->sb_occ_port_pool_get(devlink_port, devlink_sb->index,
+						pool_index, &cur, &max);
+		if (err && err != -EOPNOTSUPP)
+			goto sb_occ_get_failure;
+		if (!err) {
+			if (nla_put_u32(msg, DEVLINK_ATTR_SB_OCC_CUR, cur))
+				goto nla_put_failure;
+			if (nla_put_u32(msg, DEVLINK_ATTR_SB_OCC_MAX, max))
+				goto nla_put_failure;
+		}
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	err = -EMSGSIZE;
+sb_occ_get_failure:
+	genlmsg_cancel(msg, hdr);
+	return err;
+}
+
+int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink *devlink = devlink_port->devlink;
+	struct devlink_sb *devlink_sb;
+	struct sk_buff *msg;
+	u16 pool_index;
+	int err;
+
+	devlink_sb = devlink_sb_get_from_info(devlink, info);
+	if (IS_ERR(devlink_sb))
+		return PTR_ERR(devlink_sb);
+
+	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
+						  &pool_index);
+	if (err)
+		return err;
+
+	if (!devlink->ops->sb_port_pool_get)
+		return -EOPNOTSUPP;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_sb_port_pool_fill(msg, devlink, devlink_port,
+					   devlink_sb, pool_index,
+					   DEVLINK_CMD_SB_PORT_POOL_NEW,
+					   info->snd_portid, info->snd_seq, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
+static int __sb_port_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
+				     struct devlink *devlink,
+				     struct devlink_sb *devlink_sb,
+				     u32 portid, u32 seq, int flags)
+{
+	struct devlink_port *devlink_port;
+	u16 pool_count = devlink_sb_pool_count(devlink_sb);
+	unsigned long port_index;
+	u16 pool_index;
+	int err;
+
+	xa_for_each(&devlink->ports, port_index, devlink_port) {
+		for (pool_index = 0; pool_index < pool_count; pool_index++) {
+			if (*p_idx < start) {
+				(*p_idx)++;
+				continue;
+			}
+			err = devlink_nl_sb_port_pool_fill(msg, devlink,
+							   devlink_port,
+							   devlink_sb,
+							   pool_index,
+							   DEVLINK_CMD_SB_PORT_POOL_NEW,
+							   portid, seq, flags);
+			if (err)
+				return err;
+			(*p_idx)++;
+		}
+	}
+	return 0;
+}
+
+static int
+devlink_nl_sb_port_pool_get_dump_one(struct sk_buff *msg,
+				     struct devlink *devlink,
+				     struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_sb *devlink_sb;
+	int idx = 0;
+	int err = 0;
+
+	if (!devlink->ops->sb_port_pool_get)
+		return 0;
+
+	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
+		err = __sb_port_pool_get_dumpit(msg, state->idx, &idx,
+						devlink, devlink_sb,
+						NETLINK_CB(cb->skb).portid,
+						cb->nlh->nlmsg_seq, flags);
+		if (err == -EOPNOTSUPP) {
+			err = 0;
+		} else if (err) {
+			state->idx = idx;
+			break;
+		}
+	}
+
+	return err;
+}
+
+int devlink_nl_sb_port_pool_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_sb_port_pool_get_dump_one);
+}
+
+static int devlink_sb_port_pool_set(struct devlink_port *devlink_port,
+				    unsigned int sb_index, u16 pool_index,
+				    u32 threshold,
+				    struct netlink_ext_ack *extack)
+
+{
+	const struct devlink_ops *ops = devlink_port->devlink->ops;
+
+	if (ops->sb_port_pool_set)
+		return ops->sb_port_pool_set(devlink_port, sb_index,
+					     pool_index, threshold, extack);
+	return -EOPNOTSUPP;
+}
+
+int devlink_nl_cmd_sb_port_pool_set_doit(struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_sb *devlink_sb;
+	u16 pool_index;
+	u32 threshold;
+	int err;
+
+	devlink_sb = devlink_sb_get_from_info(devlink, info);
+	if (IS_ERR(devlink_sb))
+		return PTR_ERR(devlink_sb);
+
+	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
+						  &pool_index);
+	if (err)
+		return err;
+
+	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_SB_THRESHOLD))
+		return -EINVAL;
+
+	threshold = nla_get_u32(info->attrs[DEVLINK_ATTR_SB_THRESHOLD]);
+	return devlink_sb_port_pool_set(devlink_port, devlink_sb->index,
+					pool_index, threshold, info->extack);
+}
+
+static int
+devlink_nl_sb_tc_pool_bind_fill(struct sk_buff *msg, struct devlink *devlink,
+				struct devlink_port *devlink_port,
+				struct devlink_sb *devlink_sb, u16 tc_index,
+				enum devlink_sb_pool_type pool_type,
+				enum devlink_command cmd,
+				u32 portid, u32 seq, int flags)
+{
+	const struct devlink_ops *ops = devlink->ops;
+	u16 pool_index;
+	u32 threshold;
+	void *hdr;
+	int err;
+
+	err = ops->sb_tc_pool_bind_get(devlink_port, devlink_sb->index,
+				       tc_index, pool_type,
+				       &pool_index, &threshold);
+	if (err)
+		return err;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_SB_INDEX, devlink_sb->index))
+		goto nla_put_failure;
+	if (nla_put_u16(msg, DEVLINK_ATTR_SB_TC_INDEX, tc_index))
+		goto nla_put_failure;
+	if (nla_put_u8(msg, DEVLINK_ATTR_SB_POOL_TYPE, pool_type))
+		goto nla_put_failure;
+	if (nla_put_u16(msg, DEVLINK_ATTR_SB_POOL_INDEX, pool_index))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_SB_THRESHOLD, threshold))
+		goto nla_put_failure;
+
+	if (ops->sb_occ_tc_port_bind_get) {
+		u32 cur;
+		u32 max;
+
+		err = ops->sb_occ_tc_port_bind_get(devlink_port,
+						   devlink_sb->index,
+						   tc_index, pool_type,
+						   &cur, &max);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+		if (!err) {
+			if (nla_put_u32(msg, DEVLINK_ATTR_SB_OCC_CUR, cur))
+				goto nla_put_failure;
+			if (nla_put_u32(msg, DEVLINK_ATTR_SB_OCC_MAX, max))
+				goto nla_put_failure;
+		}
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
+					struct genl_info *info)
+{
+	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink *devlink = devlink_port->devlink;
+	struct devlink_sb *devlink_sb;
+	struct sk_buff *msg;
+	enum devlink_sb_pool_type pool_type;
+	u16 tc_index;
+	int err;
+
+	devlink_sb = devlink_sb_get_from_info(devlink, info);
+	if (IS_ERR(devlink_sb))
+		return PTR_ERR(devlink_sb);
+
+	err = devlink_sb_pool_type_get_from_info(info, &pool_type);
+	if (err)
+		return err;
+
+	err = devlink_sb_tc_index_get_from_info(devlink_sb, info,
+						pool_type, &tc_index);
+	if (err)
+		return err;
+
+	if (!devlink->ops->sb_tc_pool_bind_get)
+		return -EOPNOTSUPP;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_sb_tc_pool_bind_fill(msg, devlink, devlink_port,
+					      devlink_sb, tc_index, pool_type,
+					      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
+					      info->snd_portid,
+					      info->snd_seq, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
+static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
+					int start, int *p_idx,
+					struct devlink *devlink,
+					struct devlink_sb *devlink_sb,
+					u32 portid, u32 seq, int flags)
+{
+	struct devlink_port *devlink_port;
+	unsigned long port_index;
+	u16 tc_index;
+	int err;
+
+	xa_for_each(&devlink->ports, port_index, devlink_port) {
+		for (tc_index = 0;
+		     tc_index < devlink_sb->ingress_tc_count; tc_index++) {
+			if (*p_idx < start) {
+				(*p_idx)++;
+				continue;
+			}
+			err = devlink_nl_sb_tc_pool_bind_fill(msg, devlink,
+							      devlink_port,
+							      devlink_sb,
+							      tc_index,
+							      DEVLINK_SB_POOL_TYPE_INGRESS,
+							      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
+							      portid, seq,
+							      flags);
+			if (err)
+				return err;
+			(*p_idx)++;
+		}
+		for (tc_index = 0;
+		     tc_index < devlink_sb->egress_tc_count; tc_index++) {
+			if (*p_idx < start) {
+				(*p_idx)++;
+				continue;
+			}
+			err = devlink_nl_sb_tc_pool_bind_fill(msg, devlink,
+							      devlink_port,
+							      devlink_sb,
+							      tc_index,
+							      DEVLINK_SB_POOL_TYPE_EGRESS,
+							      DEVLINK_CMD_SB_TC_POOL_BIND_NEW,
+							      portid, seq,
+							      flags);
+			if (err)
+				return err;
+			(*p_idx)++;
+		}
+	}
+	return 0;
+}
+
+static int devlink_nl_sb_tc_pool_bind_get_dump_one(struct sk_buff *msg,
+						   struct devlink *devlink,
+						   struct netlink_callback *cb,
+						   int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_sb *devlink_sb;
+	int idx = 0;
+	int err = 0;
+
+	if (!devlink->ops->sb_tc_pool_bind_get)
+		return 0;
+
+	list_for_each_entry(devlink_sb, &devlink->sb_list, list) {
+		err = __sb_tc_pool_bind_get_dumpit(msg, state->idx, &idx,
+						   devlink, devlink_sb,
+						   NETLINK_CB(cb->skb).portid,
+						   cb->nlh->nlmsg_seq, flags);
+		if (err == -EOPNOTSUPP) {
+			err = 0;
+		} else if (err) {
+			state->idx = idx;
+			break;
+		}
+	}
+
+	return err;
+}
+
+int devlink_nl_sb_tc_pool_bind_get_dumpit(struct sk_buff *skb,
+					  struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb,
+				 devlink_nl_sb_tc_pool_bind_get_dump_one);
+}
+
+static int devlink_sb_tc_pool_bind_set(struct devlink_port *devlink_port,
+				       unsigned int sb_index, u16 tc_index,
+				       enum devlink_sb_pool_type pool_type,
+				       u16 pool_index, u32 threshold,
+				       struct netlink_ext_ack *extack)
+
+{
+	const struct devlink_ops *ops = devlink_port->devlink->ops;
+
+	if (ops->sb_tc_pool_bind_set)
+		return ops->sb_tc_pool_bind_set(devlink_port, sb_index,
+						tc_index, pool_type,
+						pool_index, threshold, extack);
+	return -EOPNOTSUPP;
+}
+
+int devlink_nl_cmd_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
+					    struct genl_info *info)
+{
+	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink *devlink = info->user_ptr[0];
+	enum devlink_sb_pool_type pool_type;
+	struct devlink_sb *devlink_sb;
+	u16 tc_index;
+	u16 pool_index;
+	u32 threshold;
+	int err;
+
+	devlink_sb = devlink_sb_get_from_info(devlink, info);
+	if (IS_ERR(devlink_sb))
+		return PTR_ERR(devlink_sb);
+
+	err = devlink_sb_pool_type_get_from_info(info, &pool_type);
+	if (err)
+		return err;
+
+	err = devlink_sb_tc_index_get_from_info(devlink_sb, info,
+						pool_type, &tc_index);
+	if (err)
+		return err;
+
+	err = devlink_sb_pool_index_get_from_info(devlink_sb, info,
+						  &pool_index);
+	if (err)
+		return err;
+
+	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_SB_THRESHOLD))
+		return -EINVAL;
+
+	threshold = nla_get_u32(info->attrs[DEVLINK_ATTR_SB_THRESHOLD]);
+	return devlink_sb_tc_pool_bind_set(devlink_port, devlink_sb->index,
+					   tc_index, pool_type,
+					   pool_index, threshold, info->extack);
+}
+
+int devlink_nl_cmd_sb_occ_snapshot_doit(struct sk_buff *skb,
+					struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	const struct devlink_ops *ops = devlink->ops;
+	struct devlink_sb *devlink_sb;
+
+	devlink_sb = devlink_sb_get_from_info(devlink, info);
+	if (IS_ERR(devlink_sb))
+		return PTR_ERR(devlink_sb);
+
+	if (ops->sb_occ_snapshot)
+		return ops->sb_occ_snapshot(devlink, devlink_sb->index);
+	return -EOPNOTSUPP;
+}
+
+int devlink_nl_cmd_sb_occ_max_clear_doit(struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	const struct devlink_ops *ops = devlink->ops;
+	struct devlink_sb *devlink_sb;
+
+	devlink_sb = devlink_sb_get_from_info(devlink, info);
+	if (IS_ERR(devlink_sb))
+		return PTR_ERR(devlink_sb);
+
+	if (ops->sb_occ_max_clear)
+		return ops->sb_occ_max_clear(devlink, devlink_sb->index);
+	return -EOPNOTSUPP;
+}
+
+int devl_sb_register(struct devlink *devlink, unsigned int sb_index,
+		     u32 size, u16 ingress_pools_count,
+		     u16 egress_pools_count, u16 ingress_tc_count,
+		     u16 egress_tc_count)
+{
+	struct devlink_sb *devlink_sb;
+
+	lockdep_assert_held(&devlink->lock);
+
+	if (devlink_sb_index_exists(devlink, sb_index))
+		return -EEXIST;
+
+	devlink_sb = kzalloc(sizeof(*devlink_sb), GFP_KERNEL);
+	if (!devlink_sb)
+		return -ENOMEM;
+	devlink_sb->index = sb_index;
+	devlink_sb->size = size;
+	devlink_sb->ingress_pools_count = ingress_pools_count;
+	devlink_sb->egress_pools_count = egress_pools_count;
+	devlink_sb->ingress_tc_count = ingress_tc_count;
+	devlink_sb->egress_tc_count = egress_tc_count;
+	list_add_tail(&devlink_sb->list, &devlink->sb_list);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devl_sb_register);
+
+int devlink_sb_register(struct devlink *devlink, unsigned int sb_index,
+			u32 size, u16 ingress_pools_count,
+			u16 egress_pools_count, u16 ingress_tc_count,
+			u16 egress_tc_count)
+{
+	int err;
+
+	devl_lock(devlink);
+	err = devl_sb_register(devlink, sb_index, size, ingress_pools_count,
+			       egress_pools_count, ingress_tc_count,
+			       egress_tc_count);
+	devl_unlock(devlink);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devlink_sb_register);
+
+void devl_sb_unregister(struct devlink *devlink, unsigned int sb_index)
+{
+	struct devlink_sb *devlink_sb;
+
+	lockdep_assert_held(&devlink->lock);
+
+	devlink_sb = devlink_sb_get_by_index(devlink, sb_index);
+	WARN_ON(!devlink_sb);
+	list_del(&devlink_sb->list);
+	kfree(devlink_sb);
+}
+EXPORT_SYMBOL_GPL(devl_sb_unregister);
+
+void devlink_sb_unregister(struct devlink *devlink, unsigned int sb_index)
+{
+	devl_lock(devlink);
+	devl_sb_unregister(devlink, sb_index);
+	devl_unlock(devlink);
+}
+EXPORT_SYMBOL_GPL(devlink_sb_unregister);
-- 
2.41.0


