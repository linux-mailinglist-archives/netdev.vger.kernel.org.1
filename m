Return-Path: <netdev+bounces-33462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD1C79E0A6
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F2D1C20B9F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55719BC4;
	Wed, 13 Sep 2023 07:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7B119BB4
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:13:07 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CEF1728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500913779f5so11197774e87.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589184; x=1695193984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBqvdbgG+OuMZGz3SuzPn/48+McVPXoSIJdlbfzUxxE=;
        b=Sy0g6DqXW9ITBZMZ5xEXqKdX7zeZnqP5wz2Ku/UlTmpEwfKcNuDoU5Yf9X4Yrl0TSh
         cGp1xtv7cRuJFfDgXVs1cu0b6Qmsxp3y8IiHYmywE6VkbgNTMlYrK4e0X3X9sASwK5tI
         5P9kpjIhjd6DGiOleFHB2BJ5geKAjOCXCARWQ5pFrbxPACboxkAcAQFBRNhqyB3UwTa6
         yQ1o9mHBb7gY8AmX4NxHGNumzK0kU0V9UV7yi/SIkcCqwleyi+7kaRsrALVAk9MFHfV+
         CUlyagIkZAoKswc8TR2rFaC97BHw+KbYEYLNvwFJJ4e7lH+zo9uDDympz4Xr49QtBN+P
         dkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589184; x=1695193984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBqvdbgG+OuMZGz3SuzPn/48+McVPXoSIJdlbfzUxxE=;
        b=gmxDFkKvtW4RwHDPnJodBA3kuES5jaxXgAAJLe2rPzOBQch3TXNIW59sa/gfvJ0Pjw
         CGWRHZGyj+OJ4kXgCq0Q7Sw0kgTnKG8p9TFlg7/cpFbsYXW+Wjv1zgPZrnFRhw8Ffkw/
         u1h7siAH1KwoFo5AYE0cmI1306aA5h02T3gYmttXfbpzJKooqfGFeriVNu46LpJch3eV
         Xre9p0AEEXRqV3ig+/e2Pvp6MxGceAFmy4me3EiDjDyILpospg6lBsQhjPgBHnsmqiBs
         c82S4Fmd99SkpKLRNd5HIrfqi5I0ces3dg+u7mHFAFQ91U+TlnOuHC2hoZL/UhgSw01E
         4fBQ==
X-Gm-Message-State: AOJu0Yx7Bm9itV0jU7NpXIhZxda+EI39qIoj9vMtYgLBv9lgMvoUGoyT
	kzDQwUgnYdcMao6wWCBqfCt/dtOV0kBqRwvKUao=
X-Google-Smtp-Source: AGHT+IEk6QWgP7q/TNtYWnv7h9ZKSg/+NYrM1AFysI7TaaM9WPbTB8jkJtxNS5dvf1yH7z2pVkAMAA==
X-Received: by 2002:a05:6512:3d17:b0:500:7f71:e46b with SMTP id d23-20020a0565123d1700b005007f71e46bmr1815498lfv.1.1694589184581;
        Wed, 13 Sep 2023 00:13:04 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bc042000000b00401bbfb9b2bsm659107wmc.0.2023.09.13.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:13:04 -0700 (PDT)
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
Subject: [patch net-next v2 11/12] devlink: introduce possibility to expose info about nested devlinks
Date: Wed, 13 Sep 2023 09:12:42 +0200
Message-ID: <20230913071243.930265-12-jiri@resnulli.us>
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

In mlx5, there is a devlink instance created for PCI device. Also, one
separate devlink instance is created for auxiliary device that
represents the netdev of uplink port. This relation is currently
invisible to the devlink user.

Benefit from the rel infrastructure and allow for nested devlink
instance to set the relationship for the nested-in devlink instance.
Note that there may be many nested instances, therefore use xarray to
hold the list of rel_indexes for individual nested instances.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 include/net/devlink.h       |  2 ++
 net/devlink/core.c          |  2 ++
 net/devlink/dev.c           | 49 +++++++++++++++++++++++++++++++++++++
 net/devlink/devl_internal.h |  1 +
 4 files changed, 54 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0dfcd7d7fa18..fad8e36e3d98 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1921,6 +1921,8 @@ devlink_health_reporter_state_update(struct devlink_health_reporter *reporter,
 void
 devlink_health_reporter_recovery_done(struct devlink_health_reporter *reporter);
 
+int devl_nested_devlink_set(struct devlink *devlink,
+			    struct devlink *nested_devlink);
 bool devlink_is_reload_failed(const struct devlink *devlink);
 void devlink_remote_reload_actions_performed(struct devlink *devlink,
 					     enum devlink_reload_limit limit,
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 2a98ff9a2f6b..bcbbb952569f 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -430,6 +430,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
+	xa_init_flags(&devlink->nested_rels, XA_FLAGS_ALLOC);
 	write_pnet(&devlink->_net, net);
 	INIT_LIST_HEAD(&devlink->rate_list);
 	INIT_LIST_HEAD(&devlink->linecard_list);
@@ -476,6 +477,7 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
+	xa_destroy(&devlink->nested_rels);
 	xa_destroy(&devlink->snapshot_ids);
 	xa_destroy(&devlink->params);
 	xa_destroy(&devlink->ports);
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 3ae26d9088ab..dc8039ca2b38 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -138,6 +138,23 @@ devlink_reload_stats_put(struct sk_buff *msg, struct devlink *devlink, bool is_r
 	return -EMSGSIZE;
 }
 
+static int devlink_nl_nested_fill(struct sk_buff *msg, struct devlink *devlink)
+{
+	unsigned long rel_index;
+	void *unused;
+	int err;
+
+	xa_for_each(&devlink->nested_rels, rel_index, unused) {
+		err = devlink_rel_devlink_handle_put(msg, devlink,
+						     rel_index,
+						     DEVLINK_ATTR_NESTED_DEVLINK,
+						     NULL);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 static int devlink_nl_fill(struct sk_buff *msg, struct devlink *devlink,
 			   enum devlink_command cmd, u32 portid,
 			   u32 seq, int flags)
@@ -164,6 +181,10 @@ static int devlink_nl_fill(struct sk_buff *msg, struct devlink *devlink,
 		goto dev_stats_nest_cancel;
 
 	nla_nest_end(msg, dev_stats);
+
+	if (devlink_nl_nested_fill(msg, devlink))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -230,6 +251,34 @@ int devlink_nl_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
 	return devlink_nl_dumpit(msg, cb, devlink_nl_get_dump_one);
 }
 
+static void devlink_rel_notify_cb(struct devlink *devlink, u32 obj_index)
+{
+	devlink_notify(devlink, DEVLINK_CMD_NEW);
+}
+
+static void devlink_rel_cleanup_cb(struct devlink *devlink, u32 obj_index,
+				   u32 rel_index)
+{
+	xa_erase(&devlink->nested_rels, rel_index);
+}
+
+int devl_nested_devlink_set(struct devlink *devlink,
+			    struct devlink *nested_devlink)
+{
+	u32 rel_index;
+	int err;
+
+	err = devlink_rel_nested_in_add(&rel_index, devlink->index, 0,
+					devlink_rel_notify_cb,
+					devlink_rel_cleanup_cb,
+					nested_devlink);
+	if (err)
+		return err;
+	return xa_insert(&devlink->nested_rels, rel_index,
+			 xa_mk_value(0), GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(devl_nested_devlink_set);
+
 void devlink_notify_register(struct devlink *devlink)
 {
 	devlink_notify(devlink, DEVLINK_CMD_NEW);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 4cb534aff44d..741d1bf1bec8 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -58,6 +58,7 @@ struct devlink {
 	refcount_t refcount;
 	struct rcu_work rwork;
 	struct devlink_rel *rel;
+	struct xarray nested_rels;
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
-- 
2.41.0


