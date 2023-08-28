Return-Path: <netdev+bounces-30988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E6F78A5A3
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21EB1C20852
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FBE1850;
	Mon, 28 Aug 2023 06:17:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29FF17E4
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:17:38 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA34130
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31dca134c83so537018f8f.3
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693203430; x=1693808230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnNJFNWZ8/vEsZe24suIaLj8rywmyeemTqxOS9bHcok=;
        b=huS250etNh1chswATrb7Nu78CrwBzV90BAribdzHDIJ2nIm7xB8RJmMnehEr7a2VMU
         QSg7TaWpVZKHX8g8AgUqiB7YpcD9PctwmW4yRcknNMEgriR26h+axwCXd1Q6HKy8w84J
         zRb13daOwSdvDPRgBFst1XnLK/gbrfy30j1aR1+hfSeECynky39rI+HqrQXVOY1jgLyx
         fgs0oGIW7l6ItNDVsr3UKe8zNYwCGfASePypqoq4BdjUIjCQw7P75ja3Z98hub9oRwKP
         lJfnEwAyl+r2n3AJpf9xHnWNJDlDJFlUZHiKA25xSERjZy6tUWmUJbIRENlj9c+/31lD
         2NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203430; x=1693808230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnNJFNWZ8/vEsZe24suIaLj8rywmyeemTqxOS9bHcok=;
        b=ULV4SxIJPqwiB5pckMC6MapEOrfjZbqNq7GGahNZF1VcAiPZ3iQIMWseTb0stOhQhL
         ezR0soGjDL14FwQSz6ZNGZjnbAXQl2TSFypK3q2fP5s9u7FosHJ183bBh4d1BjNtV3uV
         eoHmz5E1a3Vtxdldm5EzSHdR/rsomWavXJZTImCi5lLhX2BucS/vmaTyWc06OhY6Gv5w
         LvQ46wq2sGml/c02vWtY682dNPW1Q+F6ktSqUtSLkTu677sLkXpvDhPl1VzKHYDHWuqQ
         7w/6ObOMC+kaqoyLpa4fOsfoHTWueJBQFQwFuvdwVJk+yYHoM27YbdTpIYJQHx48vos5
         2TNA==
X-Gm-Message-State: AOJu0YxAcTz5nZsZjnFvw6245H2HVkuEGTIfTzUrJkGWoDCnNdYDxygJ
	As3lxiruvNdRRFMJ2WS9L1aojsFEyMl7n4gv44XdNw==
X-Google-Smtp-Source: AGHT+IG8efrJM+06QlndU1wJ0TByL7S9hwfg7Zaxo9hHXUS0+f7WUK/GcJAFBcrzxUHNZQ7vTgkAGw==
X-Received: by 2002:adf:decc:0:b0:319:76ce:32ba with SMTP id i12-20020adfdecc000000b0031976ce32bamr17368702wrn.21.1693203429818;
        Sun, 27 Aug 2023 23:17:09 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id b5-20020adfee85000000b003180fdf5589sm9492141wro.6.2023.08.27.23.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:17:09 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next v2 06/15] devlink: push resource related code into separate file
Date: Mon, 28 Aug 2023 08:16:48 +0200
Message-ID: <20230828061657.300667-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828061657.300667-1-jiri@resnulli.us>
References: <20230828061657.300667-1-jiri@resnulli.us>
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

Cut out another chunk from leftover.c and put resource related code
into a separate file.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/Makefile        |   2 +-
 net/devlink/devl_internal.h |   2 +
 net/devlink/leftover.c      | 574 -----------------------------------
 net/devlink/resource.c      | 579 ++++++++++++++++++++++++++++++++++++
 4 files changed, 582 insertions(+), 575 deletions(-)
 create mode 100644 net/devlink/resource.c

diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 122de1d565d2..8864cd933acb 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := leftover.o core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 health.o
+	 resource.o health.o
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 72653e1dae80..e5c0acf7a758 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -238,6 +238,8 @@ int devlink_nl_cmd_dpipe_headers_get(struct sk_buff *skb,
 				     struct genl_info *info);
 int devlink_nl_cmd_dpipe_table_counters_set(struct sk_buff *skb,
 					    struct genl_info *info);
+int devlink_nl_cmd_resource_set(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_resource_dump(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
 					    struct genl_info *info);
 int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index f71201e6b5e1..1c65449f2252 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -33,35 +33,6 @@
 
 #include "devl_internal.h"
 
-/**
- * struct devlink_resource - devlink resource
- * @name: name of the resource
- * @id: id, per devlink instance
- * @size: size of the resource
- * @size_new: updated size of the resource, reload is needed
- * @size_valid: valid in case the total size of the resource is valid
- *              including its children
- * @parent: parent resource
- * @size_params: size parameters
- * @list: parent list
- * @resource_list: list of child resources
- * @occ_get: occupancy getter callback
- * @occ_get_priv: occupancy getter callback priv
- */
-struct devlink_resource {
-	const char *name;
-	u64 id;
-	u64 size;
-	u64 size_new;
-	bool size_valid;
-	struct devlink_resource *parent;
-	struct devlink_resource_size_params size_params;
-	struct list_head list;
-	struct list_head resource_list;
-	devlink_resource_occ_get_t *occ_get;
-	void *occ_get_priv;
-};
-
 EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwmsg);
 EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwerr);
 EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
@@ -1090,290 +1061,6 @@ int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 	return 0;
 }
 
-static struct devlink_resource *
-devlink_resource_find(struct devlink *devlink,
-		      struct devlink_resource *resource, u64 resource_id)
-{
-	struct list_head *resource_list;
-
-	if (resource)
-		resource_list = &resource->resource_list;
-	else
-		resource_list = &devlink->resource_list;
-
-	list_for_each_entry(resource, resource_list, list) {
-		struct devlink_resource *child_resource;
-
-		if (resource->id == resource_id)
-			return resource;
-
-		child_resource = devlink_resource_find(devlink, resource,
-						       resource_id);
-		if (child_resource)
-			return child_resource;
-	}
-	return NULL;
-}
-
-static void
-devlink_resource_validate_children(struct devlink_resource *resource)
-{
-	struct devlink_resource *child_resource;
-	bool size_valid = true;
-	u64 parts_size = 0;
-
-	if (list_empty(&resource->resource_list))
-		goto out;
-
-	list_for_each_entry(child_resource, &resource->resource_list, list)
-		parts_size += child_resource->size_new;
-
-	if (parts_size > resource->size_new)
-		size_valid = false;
-out:
-	resource->size_valid = size_valid;
-}
-
-static int
-devlink_resource_validate_size(struct devlink_resource *resource, u64 size,
-			       struct netlink_ext_ack *extack)
-{
-	u64 reminder;
-	int err = 0;
-
-	if (size > resource->size_params.size_max) {
-		NL_SET_ERR_MSG(extack, "Size larger than maximum");
-		err = -EINVAL;
-	}
-
-	if (size < resource->size_params.size_min) {
-		NL_SET_ERR_MSG(extack, "Size smaller than minimum");
-		err = -EINVAL;
-	}
-
-	div64_u64_rem(size, resource->size_params.size_granularity, &reminder);
-	if (reminder) {
-		NL_SET_ERR_MSG(extack, "Wrong granularity");
-		err = -EINVAL;
-	}
-
-	return err;
-}
-
-static int devlink_nl_cmd_resource_set(struct sk_buff *skb,
-				       struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_resource *resource;
-	u64 resource_id;
-	u64 size;
-	int err;
-
-	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_RESOURCE_ID) ||
-	    GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_RESOURCE_SIZE))
-		return -EINVAL;
-	resource_id = nla_get_u64(info->attrs[DEVLINK_ATTR_RESOURCE_ID]);
-
-	resource = devlink_resource_find(devlink, NULL, resource_id);
-	if (!resource)
-		return -EINVAL;
-
-	size = nla_get_u64(info->attrs[DEVLINK_ATTR_RESOURCE_SIZE]);
-	err = devlink_resource_validate_size(resource, size, info->extack);
-	if (err)
-		return err;
-
-	resource->size_new = size;
-	devlink_resource_validate_children(resource);
-	if (resource->parent)
-		devlink_resource_validate_children(resource->parent);
-	return 0;
-}
-
-static int
-devlink_resource_size_params_put(struct devlink_resource *resource,
-				 struct sk_buff *skb)
-{
-	struct devlink_resource_size_params *size_params;
-
-	size_params = &resource->size_params;
-	if (nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_GRAN,
-			      size_params->size_granularity, DEVLINK_ATTR_PAD) ||
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_MAX,
-			      size_params->size_max, DEVLINK_ATTR_PAD) ||
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_MIN,
-			      size_params->size_min, DEVLINK_ATTR_PAD) ||
-	    nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_UNIT, size_params->unit))
-		return -EMSGSIZE;
-	return 0;
-}
-
-static int devlink_resource_occ_put(struct devlink_resource *resource,
-				    struct sk_buff *skb)
-{
-	if (!resource->occ_get)
-		return 0;
-	return nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_OCC,
-				 resource->occ_get(resource->occ_get_priv),
-				 DEVLINK_ATTR_PAD);
-}
-
-static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
-				struct devlink_resource *resource)
-{
-	struct devlink_resource *child_resource;
-	struct nlattr *child_resource_attr;
-	struct nlattr *resource_attr;
-
-	resource_attr = nla_nest_start_noflag(skb, DEVLINK_ATTR_RESOURCE);
-	if (!resource_attr)
-		return -EMSGSIZE;
-
-	if (nla_put_string(skb, DEVLINK_ATTR_RESOURCE_NAME, resource->name) ||
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size,
-			      DEVLINK_ATTR_PAD) ||
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_ID, resource->id,
-			      DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-	if (resource->size != resource->size_new &&
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
-			      resource->size_new, DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-	if (devlink_resource_occ_put(resource, skb))
-		goto nla_put_failure;
-	if (devlink_resource_size_params_put(resource, skb))
-		goto nla_put_failure;
-	if (list_empty(&resource->resource_list))
-		goto out;
-
-	if (nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_SIZE_VALID,
-		       resource->size_valid))
-		goto nla_put_failure;
-
-	child_resource_attr = nla_nest_start_noflag(skb,
-						    DEVLINK_ATTR_RESOURCE_LIST);
-	if (!child_resource_attr)
-		goto nla_put_failure;
-
-	list_for_each_entry(child_resource, &resource->resource_list, list) {
-		if (devlink_resource_put(devlink, skb, child_resource))
-			goto resource_put_failure;
-	}
-
-	nla_nest_end(skb, child_resource_attr);
-out:
-	nla_nest_end(skb, resource_attr);
-	return 0;
-
-resource_put_failure:
-	nla_nest_cancel(skb, child_resource_attr);
-nla_put_failure:
-	nla_nest_cancel(skb, resource_attr);
-	return -EMSGSIZE;
-}
-
-static int devlink_resource_fill(struct genl_info *info,
-				 enum devlink_command cmd, int flags)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_resource *resource;
-	struct nlattr *resources_attr;
-	struct sk_buff *skb = NULL;
-	struct nlmsghdr *nlh;
-	bool incomplete;
-	void *hdr;
-	int i;
-	int err;
-
-	resource = list_first_entry(&devlink->resource_list,
-				    struct devlink_resource, list);
-start_again:
-	err = devlink_nl_msg_reply_and_new(&skb, info);
-	if (err)
-		return err;
-
-	hdr = genlmsg_put(skb, info->snd_portid, info->snd_seq,
-			  &devlink_nl_family, NLM_F_MULTI, cmd);
-	if (!hdr) {
-		nlmsg_free(skb);
-		return -EMSGSIZE;
-	}
-
-	if (devlink_nl_put_handle(skb, devlink))
-		goto nla_put_failure;
-
-	resources_attr = nla_nest_start_noflag(skb,
-					       DEVLINK_ATTR_RESOURCE_LIST);
-	if (!resources_attr)
-		goto nla_put_failure;
-
-	incomplete = false;
-	i = 0;
-	list_for_each_entry_from(resource, &devlink->resource_list, list) {
-		err = devlink_resource_put(devlink, skb, resource);
-		if (err) {
-			if (!i)
-				goto err_resource_put;
-			incomplete = true;
-			break;
-		}
-		i++;
-	}
-	nla_nest_end(skb, resources_attr);
-	genlmsg_end(skb, hdr);
-	if (incomplete)
-		goto start_again;
-send_done:
-	nlh = nlmsg_put(skb, info->snd_portid, info->snd_seq,
-			NLMSG_DONE, 0, flags | NLM_F_MULTI);
-	if (!nlh) {
-		err = devlink_nl_msg_reply_and_new(&skb, info);
-		if (err)
-			return err;
-		goto send_done;
-	}
-	return genlmsg_reply(skb, info);
-
-nla_put_failure:
-	err = -EMSGSIZE;
-err_resource_put:
-	nlmsg_free(skb);
-	return err;
-}
-
-static int devlink_nl_cmd_resource_dump(struct sk_buff *skb,
-					struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-
-	if (list_empty(&devlink->resource_list))
-		return -EOPNOTSUPP;
-
-	return devlink_resource_fill(info, DEVLINK_CMD_RESOURCE_DUMP, 0);
-}
-
-int devlink_resources_validate(struct devlink *devlink,
-			       struct devlink_resource *resource,
-			       struct genl_info *info)
-{
-	struct list_head *resource_list;
-	int err = 0;
-
-	if (resource)
-		resource_list = &resource->resource_list;
-	else
-		resource_list = &devlink->resource_list;
-
-	list_for_each_entry(resource, resource_list, list) {
-		if (!resource->size_valid)
-			return -EINVAL;
-		err = devlink_resources_validate(devlink, resource, info);
-		if (err)
-			return err;
-	}
-	return err;
-}
-
 static const struct devlink_param devlink_param_generic[] = {
 	{
 		.id = DEVLINK_PARAM_GENERIC_ID_INT_ERR_RESET,
@@ -4529,267 +4216,6 @@ void devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
 }
 EXPORT_SYMBOL_GPL(devlink_linecard_nested_dl_set);
 
-/**
- * devl_resource_register - devlink resource register
- *
- * @devlink: devlink
- * @resource_name: resource's name
- * @resource_size: resource's size
- * @resource_id: resource's id
- * @parent_resource_id: resource's parent id
- * @size_params: size parameters
- *
- * Generic resources should reuse the same names across drivers.
- * Please see the generic resources list at:
- * Documentation/networking/devlink/devlink-resource.rst
- */
-int devl_resource_register(struct devlink *devlink,
-			   const char *resource_name,
-			   u64 resource_size,
-			   u64 resource_id,
-			   u64 parent_resource_id,
-			   const struct devlink_resource_size_params *size_params)
-{
-	struct devlink_resource *resource;
-	struct list_head *resource_list;
-	bool top_hierarchy;
-
-	lockdep_assert_held(&devlink->lock);
-
-	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
-
-	resource = devlink_resource_find(devlink, NULL, resource_id);
-	if (resource)
-		return -EINVAL;
-
-	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
-	if (!resource)
-		return -ENOMEM;
-
-	if (top_hierarchy) {
-		resource_list = &devlink->resource_list;
-	} else {
-		struct devlink_resource *parent_resource;
-
-		parent_resource = devlink_resource_find(devlink, NULL,
-							parent_resource_id);
-		if (parent_resource) {
-			resource_list = &parent_resource->resource_list;
-			resource->parent = parent_resource;
-		} else {
-			kfree(resource);
-			return -EINVAL;
-		}
-	}
-
-	resource->name = resource_name;
-	resource->size = resource_size;
-	resource->size_new = resource_size;
-	resource->id = resource_id;
-	resource->size_valid = true;
-	memcpy(&resource->size_params, size_params,
-	       sizeof(resource->size_params));
-	INIT_LIST_HEAD(&resource->resource_list);
-	list_add_tail(&resource->list, resource_list);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devl_resource_register);
-
-/**
- *	devlink_resource_register - devlink resource register
- *
- *	@devlink: devlink
- *	@resource_name: resource's name
- *	@resource_size: resource's size
- *	@resource_id: resource's id
- *	@parent_resource_id: resource's parent id
- *	@size_params: size parameters
- *
- *	Generic resources should reuse the same names across drivers.
- *	Please see the generic resources list at:
- *	Documentation/networking/devlink/devlink-resource.rst
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-int devlink_resource_register(struct devlink *devlink,
-			      const char *resource_name,
-			      u64 resource_size,
-			      u64 resource_id,
-			      u64 parent_resource_id,
-			      const struct devlink_resource_size_params *size_params)
-{
-	int err;
-
-	devl_lock(devlink);
-	err = devl_resource_register(devlink, resource_name, resource_size,
-				     resource_id, parent_resource_id, size_params);
-	devl_unlock(devlink);
-	return err;
-}
-EXPORT_SYMBOL_GPL(devlink_resource_register);
-
-static void devlink_resource_unregister(struct devlink *devlink,
-					struct devlink_resource *resource)
-{
-	struct devlink_resource *tmp, *child_resource;
-
-	list_for_each_entry_safe(child_resource, tmp, &resource->resource_list,
-				 list) {
-		devlink_resource_unregister(devlink, child_resource);
-		list_del(&child_resource->list);
-		kfree(child_resource);
-	}
-}
-
-/**
- * devl_resources_unregister - free all resources
- *
- * @devlink: devlink
- */
-void devl_resources_unregister(struct devlink *devlink)
-{
-	struct devlink_resource *tmp, *child_resource;
-
-	lockdep_assert_held(&devlink->lock);
-
-	list_for_each_entry_safe(child_resource, tmp, &devlink->resource_list,
-				 list) {
-		devlink_resource_unregister(devlink, child_resource);
-		list_del(&child_resource->list);
-		kfree(child_resource);
-	}
-}
-EXPORT_SYMBOL_GPL(devl_resources_unregister);
-
-/**
- *	devlink_resources_unregister - free all resources
- *
- *	@devlink: devlink
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-void devlink_resources_unregister(struct devlink *devlink)
-{
-	devl_lock(devlink);
-	devl_resources_unregister(devlink);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_resources_unregister);
-
-/**
- * devl_resource_size_get - get and update size
- *
- * @devlink: devlink
- * @resource_id: the requested resource id
- * @p_resource_size: ptr to update
- */
-int devl_resource_size_get(struct devlink *devlink,
-			   u64 resource_id,
-			   u64 *p_resource_size)
-{
-	struct devlink_resource *resource;
-
-	lockdep_assert_held(&devlink->lock);
-
-	resource = devlink_resource_find(devlink, NULL, resource_id);
-	if (!resource)
-		return -EINVAL;
-	*p_resource_size = resource->size_new;
-	resource->size = resource->size_new;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devl_resource_size_get);
-
-/**
- * devl_resource_occ_get_register - register occupancy getter
- *
- * @devlink: devlink
- * @resource_id: resource id
- * @occ_get: occupancy getter callback
- * @occ_get_priv: occupancy getter callback priv
- */
-void devl_resource_occ_get_register(struct devlink *devlink,
-				    u64 resource_id,
-				    devlink_resource_occ_get_t *occ_get,
-				    void *occ_get_priv)
-{
-	struct devlink_resource *resource;
-
-	lockdep_assert_held(&devlink->lock);
-
-	resource = devlink_resource_find(devlink, NULL, resource_id);
-	if (WARN_ON(!resource))
-		return;
-	WARN_ON(resource->occ_get);
-
-	resource->occ_get = occ_get;
-	resource->occ_get_priv = occ_get_priv;
-}
-EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
-
-/**
- *	devlink_resource_occ_get_register - register occupancy getter
- *
- *	@devlink: devlink
- *	@resource_id: resource id
- *	@occ_get: occupancy getter callback
- *	@occ_get_priv: occupancy getter callback priv
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-void devlink_resource_occ_get_register(struct devlink *devlink,
-				       u64 resource_id,
-				       devlink_resource_occ_get_t *occ_get,
-				       void *occ_get_priv)
-{
-	devl_lock(devlink);
-	devl_resource_occ_get_register(devlink, resource_id,
-				       occ_get, occ_get_priv);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_resource_occ_get_register);
-
-/**
- * devl_resource_occ_get_unregister - unregister occupancy getter
- *
- * @devlink: devlink
- * @resource_id: resource id
- */
-void devl_resource_occ_get_unregister(struct devlink *devlink,
-				      u64 resource_id)
-{
-	struct devlink_resource *resource;
-
-	lockdep_assert_held(&devlink->lock);
-
-	resource = devlink_resource_find(devlink, NULL, resource_id);
-	if (WARN_ON(!resource))
-		return;
-	WARN_ON(!resource->occ_get);
-
-	resource->occ_get = NULL;
-	resource->occ_get_priv = NULL;
-}
-EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
-
-/**
- *	devlink_resource_occ_get_unregister - unregister occupancy getter
- *
- *	@devlink: devlink
- *	@resource_id: resource id
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-void devlink_resource_occ_get_unregister(struct devlink *devlink,
-					 u64 resource_id)
-{
-	devl_lock(devlink);
-	devl_resource_occ_get_unregister(devlink, resource_id);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_resource_occ_get_unregister);
-
 static int devlink_param_verify(const struct devlink_param *param)
 {
 	if (!param || !param->name || !param->supported_cmodes)
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
new file mode 100644
index 000000000000..c8b615e4c385
--- /dev/null
+++ b/net/devlink/resource.c
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
+ */
+
+#include "devl_internal.h"
+
+/**
+ * struct devlink_resource - devlink resource
+ * @name: name of the resource
+ * @id: id, per devlink instance
+ * @size: size of the resource
+ * @size_new: updated size of the resource, reload is needed
+ * @size_valid: valid in case the total size of the resource is valid
+ *              including its children
+ * @parent: parent resource
+ * @size_params: size parameters
+ * @list: parent list
+ * @resource_list: list of child resources
+ * @occ_get: occupancy getter callback
+ * @occ_get_priv: occupancy getter callback priv
+ */
+struct devlink_resource {
+	const char *name;
+	u64 id;
+	u64 size;
+	u64 size_new;
+	bool size_valid;
+	struct devlink_resource *parent;
+	struct devlink_resource_size_params size_params;
+	struct list_head list;
+	struct list_head resource_list;
+	devlink_resource_occ_get_t *occ_get;
+	void *occ_get_priv;
+};
+
+static struct devlink_resource *
+devlink_resource_find(struct devlink *devlink,
+		      struct devlink_resource *resource, u64 resource_id)
+{
+	struct list_head *resource_list;
+
+	if (resource)
+		resource_list = &resource->resource_list;
+	else
+		resource_list = &devlink->resource_list;
+
+	list_for_each_entry(resource, resource_list, list) {
+		struct devlink_resource *child_resource;
+
+		if (resource->id == resource_id)
+			return resource;
+
+		child_resource = devlink_resource_find(devlink, resource,
+						       resource_id);
+		if (child_resource)
+			return child_resource;
+	}
+	return NULL;
+}
+
+static void
+devlink_resource_validate_children(struct devlink_resource *resource)
+{
+	struct devlink_resource *child_resource;
+	bool size_valid = true;
+	u64 parts_size = 0;
+
+	if (list_empty(&resource->resource_list))
+		goto out;
+
+	list_for_each_entry(child_resource, &resource->resource_list, list)
+		parts_size += child_resource->size_new;
+
+	if (parts_size > resource->size_new)
+		size_valid = false;
+out:
+	resource->size_valid = size_valid;
+}
+
+static int
+devlink_resource_validate_size(struct devlink_resource *resource, u64 size,
+			       struct netlink_ext_ack *extack)
+{
+	u64 reminder;
+	int err = 0;
+
+	if (size > resource->size_params.size_max) {
+		NL_SET_ERR_MSG(extack, "Size larger than maximum");
+		err = -EINVAL;
+	}
+
+	if (size < resource->size_params.size_min) {
+		NL_SET_ERR_MSG(extack, "Size smaller than minimum");
+		err = -EINVAL;
+	}
+
+	div64_u64_rem(size, resource->size_params.size_granularity, &reminder);
+	if (reminder) {
+		NL_SET_ERR_MSG(extack, "Wrong granularity");
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+int devlink_nl_cmd_resource_set(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_resource *resource;
+	u64 resource_id;
+	u64 size;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_RESOURCE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_RESOURCE_SIZE))
+		return -EINVAL;
+	resource_id = nla_get_u64(info->attrs[DEVLINK_ATTR_RESOURCE_ID]);
+
+	resource = devlink_resource_find(devlink, NULL, resource_id);
+	if (!resource)
+		return -EINVAL;
+
+	size = nla_get_u64(info->attrs[DEVLINK_ATTR_RESOURCE_SIZE]);
+	err = devlink_resource_validate_size(resource, size, info->extack);
+	if (err)
+		return err;
+
+	resource->size_new = size;
+	devlink_resource_validate_children(resource);
+	if (resource->parent)
+		devlink_resource_validate_children(resource->parent);
+	return 0;
+}
+
+static int
+devlink_resource_size_params_put(struct devlink_resource *resource,
+				 struct sk_buff *skb)
+{
+	struct devlink_resource_size_params *size_params;
+
+	size_params = &resource->size_params;
+	if (nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_GRAN,
+			      size_params->size_granularity, DEVLINK_ATTR_PAD) ||
+	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_MAX,
+			      size_params->size_max, DEVLINK_ATTR_PAD) ||
+	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_MIN,
+			      size_params->size_min, DEVLINK_ATTR_PAD) ||
+	    nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_UNIT, size_params->unit))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int devlink_resource_occ_put(struct devlink_resource *resource,
+				    struct sk_buff *skb)
+{
+	if (!resource->occ_get)
+		return 0;
+	return nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_OCC,
+				 resource->occ_get(resource->occ_get_priv),
+				 DEVLINK_ATTR_PAD);
+}
+
+static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
+				struct devlink_resource *resource)
+{
+	struct devlink_resource *child_resource;
+	struct nlattr *child_resource_attr;
+	struct nlattr *resource_attr;
+
+	resource_attr = nla_nest_start_noflag(skb, DEVLINK_ATTR_RESOURCE);
+	if (!resource_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_string(skb, DEVLINK_ATTR_RESOURCE_NAME, resource->name) ||
+	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size,
+			      DEVLINK_ATTR_PAD) ||
+	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_ID, resource->id,
+			      DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+	if (resource->size != resource->size_new &&
+	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
+			      resource->size_new, DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+	if (devlink_resource_occ_put(resource, skb))
+		goto nla_put_failure;
+	if (devlink_resource_size_params_put(resource, skb))
+		goto nla_put_failure;
+	if (list_empty(&resource->resource_list))
+		goto out;
+
+	if (nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_SIZE_VALID,
+		       resource->size_valid))
+		goto nla_put_failure;
+
+	child_resource_attr = nla_nest_start_noflag(skb,
+						    DEVLINK_ATTR_RESOURCE_LIST);
+	if (!child_resource_attr)
+		goto nla_put_failure;
+
+	list_for_each_entry(child_resource, &resource->resource_list, list) {
+		if (devlink_resource_put(devlink, skb, child_resource))
+			goto resource_put_failure;
+	}
+
+	nla_nest_end(skb, child_resource_attr);
+out:
+	nla_nest_end(skb, resource_attr);
+	return 0;
+
+resource_put_failure:
+	nla_nest_cancel(skb, child_resource_attr);
+nla_put_failure:
+	nla_nest_cancel(skb, resource_attr);
+	return -EMSGSIZE;
+}
+
+static int devlink_resource_fill(struct genl_info *info,
+				 enum devlink_command cmd, int flags)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_resource *resource;
+	struct nlattr *resources_attr;
+	struct sk_buff *skb = NULL;
+	struct nlmsghdr *nlh;
+	bool incomplete;
+	void *hdr;
+	int i;
+	int err;
+
+	resource = list_first_entry(&devlink->resource_list,
+				    struct devlink_resource, list);
+start_again:
+	err = devlink_nl_msg_reply_and_new(&skb, info);
+	if (err)
+		return err;
+
+	hdr = genlmsg_put(skb, info->snd_portid, info->snd_seq,
+			  &devlink_nl_family, NLM_F_MULTI, cmd);
+	if (!hdr) {
+		nlmsg_free(skb);
+		return -EMSGSIZE;
+	}
+
+	if (devlink_nl_put_handle(skb, devlink))
+		goto nla_put_failure;
+
+	resources_attr = nla_nest_start_noflag(skb,
+					       DEVLINK_ATTR_RESOURCE_LIST);
+	if (!resources_attr)
+		goto nla_put_failure;
+
+	incomplete = false;
+	i = 0;
+	list_for_each_entry_from(resource, &devlink->resource_list, list) {
+		err = devlink_resource_put(devlink, skb, resource);
+		if (err) {
+			if (!i)
+				goto err_resource_put;
+			incomplete = true;
+			break;
+		}
+		i++;
+	}
+	nla_nest_end(skb, resources_attr);
+	genlmsg_end(skb, hdr);
+	if (incomplete)
+		goto start_again;
+send_done:
+	nlh = nlmsg_put(skb, info->snd_portid, info->snd_seq,
+			NLMSG_DONE, 0, flags | NLM_F_MULTI);
+	if (!nlh) {
+		err = devlink_nl_msg_reply_and_new(&skb, info);
+		if (err)
+			return err;
+		goto send_done;
+	}
+	return genlmsg_reply(skb, info);
+
+nla_put_failure:
+	err = -EMSGSIZE;
+err_resource_put:
+	nlmsg_free(skb);
+	return err;
+}
+
+int devlink_nl_cmd_resource_dump(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+
+	if (list_empty(&devlink->resource_list))
+		return -EOPNOTSUPP;
+
+	return devlink_resource_fill(info, DEVLINK_CMD_RESOURCE_DUMP, 0);
+}
+
+int devlink_resources_validate(struct devlink *devlink,
+			       struct devlink_resource *resource,
+			       struct genl_info *info)
+{
+	struct list_head *resource_list;
+	int err = 0;
+
+	if (resource)
+		resource_list = &resource->resource_list;
+	else
+		resource_list = &devlink->resource_list;
+
+	list_for_each_entry(resource, resource_list, list) {
+		if (!resource->size_valid)
+			return -EINVAL;
+		err = devlink_resources_validate(devlink, resource, info);
+		if (err)
+			return err;
+	}
+	return err;
+}
+
+/**
+ * devl_resource_register - devlink resource register
+ *
+ * @devlink: devlink
+ * @resource_name: resource's name
+ * @resource_size: resource's size
+ * @resource_id: resource's id
+ * @parent_resource_id: resource's parent id
+ * @size_params: size parameters
+ *
+ * Generic resources should reuse the same names across drivers.
+ * Please see the generic resources list at:
+ * Documentation/networking/devlink/devlink-resource.rst
+ */
+int devl_resource_register(struct devlink *devlink,
+			   const char *resource_name,
+			   u64 resource_size,
+			   u64 resource_id,
+			   u64 parent_resource_id,
+			   const struct devlink_resource_size_params *size_params)
+{
+	struct devlink_resource *resource;
+	struct list_head *resource_list;
+	bool top_hierarchy;
+
+	lockdep_assert_held(&devlink->lock);
+
+	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
+
+	resource = devlink_resource_find(devlink, NULL, resource_id);
+	if (resource)
+		return -EINVAL;
+
+	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
+	if (!resource)
+		return -ENOMEM;
+
+	if (top_hierarchy) {
+		resource_list = &devlink->resource_list;
+	} else {
+		struct devlink_resource *parent_resource;
+
+		parent_resource = devlink_resource_find(devlink, NULL,
+							parent_resource_id);
+		if (parent_resource) {
+			resource_list = &parent_resource->resource_list;
+			resource->parent = parent_resource;
+		} else {
+			kfree(resource);
+			return -EINVAL;
+		}
+	}
+
+	resource->name = resource_name;
+	resource->size = resource_size;
+	resource->size_new = resource_size;
+	resource->id = resource_id;
+	resource->size_valid = true;
+	memcpy(&resource->size_params, size_params,
+	       sizeof(resource->size_params));
+	INIT_LIST_HEAD(&resource->resource_list);
+	list_add_tail(&resource->list, resource_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devl_resource_register);
+
+/**
+ *	devlink_resource_register - devlink resource register
+ *
+ *	@devlink: devlink
+ *	@resource_name: resource's name
+ *	@resource_size: resource's size
+ *	@resource_id: resource's id
+ *	@parent_resource_id: resource's parent id
+ *	@size_params: size parameters
+ *
+ *	Generic resources should reuse the same names across drivers.
+ *	Please see the generic resources list at:
+ *	Documentation/networking/devlink/devlink-resource.rst
+ *
+ *	Context: Takes and release devlink->lock <mutex>.
+ */
+int devlink_resource_register(struct devlink *devlink,
+			      const char *resource_name,
+			      u64 resource_size,
+			      u64 resource_id,
+			      u64 parent_resource_id,
+			      const struct devlink_resource_size_params *size_params)
+{
+	int err;
+
+	devl_lock(devlink);
+	err = devl_resource_register(devlink, resource_name, resource_size,
+				     resource_id, parent_resource_id, size_params);
+	devl_unlock(devlink);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devlink_resource_register);
+
+static void devlink_resource_unregister(struct devlink *devlink,
+					struct devlink_resource *resource)
+{
+	struct devlink_resource *tmp, *child_resource;
+
+	list_for_each_entry_safe(child_resource, tmp, &resource->resource_list,
+				 list) {
+		devlink_resource_unregister(devlink, child_resource);
+		list_del(&child_resource->list);
+		kfree(child_resource);
+	}
+}
+
+/**
+ * devl_resources_unregister - free all resources
+ *
+ * @devlink: devlink
+ */
+void devl_resources_unregister(struct devlink *devlink)
+{
+	struct devlink_resource *tmp, *child_resource;
+
+	lockdep_assert_held(&devlink->lock);
+
+	list_for_each_entry_safe(child_resource, tmp, &devlink->resource_list,
+				 list) {
+		devlink_resource_unregister(devlink, child_resource);
+		list_del(&child_resource->list);
+		kfree(child_resource);
+	}
+}
+EXPORT_SYMBOL_GPL(devl_resources_unregister);
+
+/**
+ *	devlink_resources_unregister - free all resources
+ *
+ *	@devlink: devlink
+ *
+ *	Context: Takes and release devlink->lock <mutex>.
+ */
+void devlink_resources_unregister(struct devlink *devlink)
+{
+	devl_lock(devlink);
+	devl_resources_unregister(devlink);
+	devl_unlock(devlink);
+}
+EXPORT_SYMBOL_GPL(devlink_resources_unregister);
+
+/**
+ * devl_resource_size_get - get and update size
+ *
+ * @devlink: devlink
+ * @resource_id: the requested resource id
+ * @p_resource_size: ptr to update
+ */
+int devl_resource_size_get(struct devlink *devlink,
+			   u64 resource_id,
+			   u64 *p_resource_size)
+{
+	struct devlink_resource *resource;
+
+	lockdep_assert_held(&devlink->lock);
+
+	resource = devlink_resource_find(devlink, NULL, resource_id);
+	if (!resource)
+		return -EINVAL;
+	*p_resource_size = resource->size_new;
+	resource->size = resource->size_new;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devl_resource_size_get);
+
+/**
+ * devl_resource_occ_get_register - register occupancy getter
+ *
+ * @devlink: devlink
+ * @resource_id: resource id
+ * @occ_get: occupancy getter callback
+ * @occ_get_priv: occupancy getter callback priv
+ */
+void devl_resource_occ_get_register(struct devlink *devlink,
+				    u64 resource_id,
+				    devlink_resource_occ_get_t *occ_get,
+				    void *occ_get_priv)
+{
+	struct devlink_resource *resource;
+
+	lockdep_assert_held(&devlink->lock);
+
+	resource = devlink_resource_find(devlink, NULL, resource_id);
+	if (WARN_ON(!resource))
+		return;
+	WARN_ON(resource->occ_get);
+
+	resource->occ_get = occ_get;
+	resource->occ_get_priv = occ_get_priv;
+}
+EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
+
+/**
+ *	devlink_resource_occ_get_register - register occupancy getter
+ *
+ *	@devlink: devlink
+ *	@resource_id: resource id
+ *	@occ_get: occupancy getter callback
+ *	@occ_get_priv: occupancy getter callback priv
+ *
+ *	Context: Takes and release devlink->lock <mutex>.
+ */
+void devlink_resource_occ_get_register(struct devlink *devlink,
+				       u64 resource_id,
+				       devlink_resource_occ_get_t *occ_get,
+				       void *occ_get_priv)
+{
+	devl_lock(devlink);
+	devl_resource_occ_get_register(devlink, resource_id,
+				       occ_get, occ_get_priv);
+	devl_unlock(devlink);
+}
+EXPORT_SYMBOL_GPL(devlink_resource_occ_get_register);
+
+/**
+ * devl_resource_occ_get_unregister - unregister occupancy getter
+ *
+ * @devlink: devlink
+ * @resource_id: resource id
+ */
+void devl_resource_occ_get_unregister(struct devlink *devlink,
+				      u64 resource_id)
+{
+	struct devlink_resource *resource;
+
+	lockdep_assert_held(&devlink->lock);
+
+	resource = devlink_resource_find(devlink, NULL, resource_id);
+	if (WARN_ON(!resource))
+		return;
+	WARN_ON(!resource->occ_get);
+
+	resource->occ_get = NULL;
+	resource->occ_get_priv = NULL;
+}
+EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
+
+/**
+ *	devlink_resource_occ_get_unregister - unregister occupancy getter
+ *
+ *	@devlink: devlink
+ *	@resource_id: resource id
+ *
+ *	Context: Takes and release devlink->lock <mutex>.
+ */
+void devlink_resource_occ_get_unregister(struct devlink *devlink,
+					 u64 resource_id)
+{
+	devl_lock(devlink);
+	devl_resource_occ_get_unregister(devlink, resource_id);
+	devl_unlock(devlink);
+}
+EXPORT_SYMBOL_GPL(devlink_resource_occ_get_unregister);
-- 
2.41.0


