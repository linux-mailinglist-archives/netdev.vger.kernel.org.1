Return-Path: <netdev+bounces-33458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D085C79E092
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8352E281699
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E9518C00;
	Wed, 13 Sep 2023 07:13:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194918AF2
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:13:00 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9C71728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so3303935e9.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589178; x=1695193978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndjapu7lUqG7eBQABHUGS9K2IG06doKEDZs025wsSzg=;
        b=XiLwkSRuOfNUxqLRcdacXL2qjKSbNIti5v2ws5XTltF8pxb5yp0JgggJmomV7MjtRG
         r8klTuhWdA7RqaKbYz8bVURWl4vaHK/5BbJawosrD0v8PN3qSXilbWS1Q9tvblOjBobm
         anUZv1V1/wnrDjJR/PxwxiD+nr0UmU+W7v9UOpe/h/eKr7ju/lEPp1/BLS5xL167Mb/X
         azNFFfxM9xfCy7MwYEHJHW5IikpBYem1XBfZIRtmTcdJ3G9eTwfvx8Z9ZQFwTbvy7xHN
         5GIBM1au1hLLgdDGpofB4+kHaQfo49dxhAnnI0GxlzVXsGgiUd8lzDwSSponuB5cTckH
         t4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589178; x=1695193978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndjapu7lUqG7eBQABHUGS9K2IG06doKEDZs025wsSzg=;
        b=JVH5vuEpEAz1Jqgt0HSFhnsy/M3x/4nCViQ4TXhxuE2LvuK4WSelUFkc8IQoQZUCo4
         QhGawn7vbRbxKytZrYQmdG2r9h94KuBJHAPYnqF5SXHPTZ2em/V5PINbiyu1jSdWgDmM
         Va1B4rVIy4udRocS7LcXyjnLwkSluTtVadnwYcNPXh2iAiWCxJHrFDlrnbfhGeKJI+q9
         6zFb184+0Fpewzs8HGOoxQNOpj9AYRAt7D/uzu/k/2Gw12SBQ2mFlDLWQfUHHQeFN6VK
         cWjv5UX1UQmC3aAX9YBfSnmgj0m3l4SKqA4udE1+48cJhPwONqXEN5VQpXCiT1WpvMFy
         uinA==
X-Gm-Message-State: AOJu0YzvR7u4c8A6NCTofeVOqnEznMak3y94LvzuyTo3xDhu27o1P+ao
	dn35UfDmhfthmCMxvtHjw/hcsN0RjfaGKuXjDt0=
X-Google-Smtp-Source: AGHT+IFljqo/cvtpw/cw7b+7oqZAkSzR+hGkmjKYEB1S7wiUe4BNhK5+iY8tEKcGyIQscg6bOQ0RYQ==
X-Received: by 2002:a7b:c8ce:0:b0:3fe:1fd9:bedf with SMTP id f14-20020a7bc8ce000000b003fe1fd9bedfmr1283443wml.11.1694589177742;
        Wed, 13 Sep 2023 00:12:57 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id az17-20020a05600c601100b003feea62440bsm1124161wmb.43.2023.09.13.00.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:12:57 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	petrm@nvidia.com,
	jacob.e.keller@intel.com,
	moshe@nvidia.com,
	shayd@nvidia.com,
	saeedm@nvidia.com,
	horms@kernel.org
Subject: [patch net-next v2 07/12] devlink: introduce object and nested devlink relationship infra
Date: Wed, 13 Sep 2023 09:12:38 +0200
Message-ID: <20230913071243.930265-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913071243.930265-1-jiri@resnulli.us>
References: <20230913071243.930265-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

It is a bit tricky to maintain relationship between devlink objects and
nested devlink instances due to following aspects:

1) Locking. It is necessary to lock the devlink instance that contains
   the object first, only after that to lock the nested instance.
2) Lifetimes. Objects (e.g devlink port) may be removed before
   the nested devlink instance.
3) Notifications. If nested instance changes (e.g. gets
   registered/unregistered) the nested-in object needs to send
   appropriate notifications.

Resolve this by introducing an xarray that holds 1:1 relationships
between devlink object and related nested devlink instance.
Use that xarray index to get the object/nested devlink instance on
the other side.

Provide necessary helpers:
devlink_rel_nested_in_add/clear() to add and clear the relationship.
devlink_rel_nested_in_notify() to call the nested-in object to send
	notifications during nested instance register/unregister/netns
	change.
devlink_rel_devlink_handle_put() to be used by nested-in object fill
	function to fill the nested handle.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 net/devlink/core.c          | 215 ++++++++++++++++++++++++++++++++++++
 net/devlink/dev.c           |   1 +
 net/devlink/devl_internal.h |  17 +++
 3 files changed, 233 insertions(+)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 6cec4afb01fb..2a98ff9a2f6b 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -16,6 +16,219 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
 
 DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
 
+static struct devlink *devlinks_xa_get(unsigned long index)
+{
+	struct devlink *devlink;
+
+	rcu_read_lock();
+	devlink = xa_find(&devlinks, &index, index, DEVLINK_REGISTERED);
+	if (!devlink || !devlink_try_get(devlink))
+		devlink = NULL;
+	rcu_read_unlock();
+	return devlink;
+}
+
+/* devlink_rels xarray contains 1:1 relationships between
+ * devlink object and related nested devlink instance.
+ * The xarray index is used to get the nested object from
+ * the nested-in object code.
+ */
+static DEFINE_XARRAY_FLAGS(devlink_rels, XA_FLAGS_ALLOC1);
+
+#define DEVLINK_REL_IN_USE XA_MARK_0
+
+struct devlink_rel {
+	u32 index;
+	refcount_t refcount;
+	u32 devlink_index;
+	struct {
+		u32 devlink_index;
+		u32 obj_index;
+		devlink_rel_notify_cb_t *notify_cb;
+		devlink_rel_cleanup_cb_t *cleanup_cb;
+		struct work_struct notify_work;
+	} nested_in;
+};
+
+static void devlink_rel_free(struct devlink_rel *rel)
+{
+	xa_erase(&devlink_rels, rel->index);
+	kfree(rel);
+}
+
+static void __devlink_rel_get(struct devlink_rel *rel)
+{
+	refcount_inc(&rel->refcount);
+}
+
+static void __devlink_rel_put(struct devlink_rel *rel)
+{
+	if (refcount_dec_and_test(&rel->refcount))
+		devlink_rel_free(rel);
+}
+
+static void devlink_rel_nested_in_notify_work(struct work_struct *work)
+{
+	struct devlink_rel *rel = container_of(work, struct devlink_rel,
+					       nested_in.notify_work);
+	struct devlink *devlink;
+
+	devlink = devlinks_xa_get(rel->nested_in.devlink_index);
+	if (!devlink)
+		goto rel_put;
+	if (!devl_trylock(devlink)) {
+		devlink_put(devlink);
+		goto reschedule_work;
+	}
+	if (!devl_is_registered(devlink)) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
+		goto rel_put;
+	}
+	if (!xa_get_mark(&devlink_rels, rel->index, DEVLINK_REL_IN_USE))
+		rel->nested_in.cleanup_cb(devlink, rel->nested_in.obj_index, rel->index);
+	rel->nested_in.notify_cb(devlink, rel->nested_in.obj_index);
+	devl_unlock(devlink);
+	devlink_put(devlink);
+
+rel_put:
+	__devlink_rel_put(rel);
+	return;
+
+reschedule_work:
+	schedule_work(&rel->nested_in.notify_work);
+}
+
+static void devlink_rel_nested_in_notify_work_schedule(struct devlink_rel *rel)
+{
+	__devlink_rel_get(rel);
+	schedule_work(&rel->nested_in.notify_work);
+}
+
+static struct devlink_rel *devlink_rel_alloc(void)
+{
+	struct devlink_rel *rel;
+	static u32 next;
+	int err;
+
+	rel = kzalloc(sizeof(*rel), GFP_KERNEL);
+	if (!rel)
+		return ERR_PTR(-ENOMEM);
+
+	err = xa_alloc_cyclic(&devlink_rels, &rel->index, rel,
+			      xa_limit_32b, &next, GFP_KERNEL);
+	if (err) {
+		kfree(rel);
+		return ERR_PTR(err);
+	}
+
+	refcount_set(&rel->refcount, 1);
+	INIT_WORK(&rel->nested_in.notify_work,
+		  &devlink_rel_nested_in_notify_work);
+	return rel;
+}
+
+static void devlink_rel_put(struct devlink *devlink)
+{
+	struct devlink_rel *rel = devlink->rel;
+
+	if (!rel)
+		return;
+	xa_clear_mark(&devlink_rels, rel->index, DEVLINK_REL_IN_USE);
+	devlink_rel_nested_in_notify_work_schedule(rel);
+	__devlink_rel_put(rel);
+	devlink->rel = NULL;
+}
+
+void devlink_rel_nested_in_clear(u32 rel_index)
+{
+	xa_clear_mark(&devlink_rels, rel_index, DEVLINK_REL_IN_USE);
+}
+
+int devlink_rel_nested_in_add(u32 *rel_index, u32 devlink_index,
+			      u32 obj_index, devlink_rel_notify_cb_t *notify_cb,
+			      devlink_rel_cleanup_cb_t *cleanup_cb,
+			      struct devlink *devlink)
+{
+	struct devlink_rel *rel = devlink_rel_alloc();
+
+	ASSERT_DEVLINK_NOT_REGISTERED(devlink);
+
+	if (IS_ERR(rel))
+		return PTR_ERR(rel);
+
+	rel->devlink_index = devlink->index;
+	rel->nested_in.devlink_index = devlink_index;
+	rel->nested_in.obj_index = obj_index;
+	rel->nested_in.notify_cb = notify_cb;
+	rel->nested_in.cleanup_cb = cleanup_cb;
+	*rel_index = rel->index;
+	xa_set_mark(&devlink_rels, rel->index, DEVLINK_REL_IN_USE);
+	devlink->rel = rel;
+	return 0;
+}
+
+void devlink_rel_nested_in_notify(struct devlink *devlink)
+{
+	struct devlink_rel *rel = devlink->rel;
+
+	if (!rel)
+		return;
+	devlink_rel_nested_in_notify_work_schedule(rel);
+}
+
+static struct devlink_rel *devlink_rel_find(unsigned long rel_index)
+{
+	return xa_find(&devlink_rels, &rel_index, rel_index,
+		       DEVLINK_REL_IN_USE);
+}
+
+static struct devlink *devlink_rel_devlink_get_lock(u32 rel_index)
+{
+	struct devlink *devlink;
+	struct devlink_rel *rel;
+	u32 devlink_index;
+
+	if (!rel_index)
+		return NULL;
+	xa_lock(&devlink_rels);
+	rel = devlink_rel_find(rel_index);
+	if (rel)
+		devlink_index = rel->devlink_index;
+	xa_unlock(&devlink_rels);
+	if (!rel)
+		return NULL;
+	devlink = devlinks_xa_get(devlink_index);
+	if (!devlink)
+		return NULL;
+	devl_lock(devlink);
+	if (!devl_is_registered(devlink)) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
+		return NULL;
+	}
+	return devlink;
+}
+
+int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
+				   u32 rel_index, int attrtype,
+				   bool *msg_updated)
+{
+	struct net *net = devlink_net(devlink);
+	struct devlink *rel_devlink;
+	int err;
+
+	rel_devlink = devlink_rel_devlink_get_lock(rel_index);
+	if (!rel_devlink)
+		return 0;
+	err = devlink_nl_put_nested_handle(msg, net, rel_devlink, attrtype);
+	devl_unlock(rel_devlink);
+	devlink_put(rel_devlink);
+	if (!err && msg_updated)
+		*msg_updated = true;
+	return err;
+}
+
 void *devlink_priv(struct devlink *devlink)
 {
 	return &devlink->priv;
@@ -142,6 +355,7 @@ int devl_register(struct devlink *devlink)
 
 	xa_set_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 	devlink_notify_register(devlink);
+	devlink_rel_nested_in_notify(devlink);
 
 	return 0;
 }
@@ -166,6 +380,7 @@ void devl_unregister(struct devlink *devlink)
 
 	devlink_notify_unregister(devlink);
 	xa_clear_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
+	devlink_rel_put(devlink);
 }
 EXPORT_SYMBOL_GPL(devl_unregister);
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index bba4ace7d22b..3ae26d9088ab 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -372,6 +372,7 @@ static void devlink_reload_netns_change(struct devlink *devlink,
 	devlink_notify_unregister(devlink);
 	write_pnet(&devlink->_net, dest_net);
 	devlink_notify_register(devlink);
+	devlink_rel_nested_in_notify(devlink);
 }
 
 int devlink_reload(struct devlink *devlink, struct net *dest_net,
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 53449dbd6545..4cb534aff44d 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -17,6 +17,8 @@
 
 #include "netlink_gen.h"
 
+struct devlink_rel;
+
 #define DEVLINK_REGISTERED XA_MARK_1
 
 #define DEVLINK_RELOAD_STATS_ARRAY_SIZE \
@@ -55,6 +57,7 @@ struct devlink {
 	u8 reload_failed:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
+	struct devlink_rel *rel;
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
@@ -92,6 +95,20 @@ static inline bool devl_is_registered(struct devlink *devlink)
 	return xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 }
 
+typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
+typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
+				      u32 rel_index);
+
+void devlink_rel_nested_in_clear(u32 rel_index);
+int devlink_rel_nested_in_add(u32 *rel_index, u32 devlink_index,
+			      u32 obj_index, devlink_rel_notify_cb_t *notify_cb,
+			      devlink_rel_cleanup_cb_t *cleanup_cb,
+			      struct devlink *devlink);
+void devlink_rel_nested_in_notify(struct devlink *devlink);
+int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
+				   u32 rel_index, int attrtype,
+				   bool *msg_updated);
+
 /* Netlink */
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
-- 
2.41.0


