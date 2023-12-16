Return-Path: <netdev+bounces-58226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD37815903
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4827FB23B43
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C817C18EA6;
	Sat, 16 Dec 2023 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lYilA93w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644F2C6A9
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc5d9cf766so5769871fa.2
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702729817; x=1703334617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UINFUKQqwJpfrW26h1br3k+kqi4ue0hCECbqcTFenn0=;
        b=lYilA93wVYT3eihOWk/qz4XLLp7s1skez/jx0e8l3cCHeVPg3KtvbX/nMvGl5FqMyP
         VjA/HTSLloJFlV0mmH9T2tLD7ysMZ+8JZS1IYDCS7pgjBzR+qXh82ZL1StV/Ove6/2aO
         j5slCbhqB1cqTbUYvMqlmU2AEALnP+hq3xff96ArpV55nOqFOqAm6EmRAyPzM7cwiDYt
         nTvnNBsM+JoAQJ8WCjTwFRDhO19Mbn1cE/i5yPn4eLGK5Y4lbEYxzXqtIX6D7hvICQbc
         5F59uC/NIf7umHO5lyC8Uh+M5cIGkq8K+oU3IHnKZoOErH40FOzzPbxW/ZfgaGWoNNQ4
         gL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702729817; x=1703334617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UINFUKQqwJpfrW26h1br3k+kqi4ue0hCECbqcTFenn0=;
        b=W/1dcqYCXX6Ot4oHbFV1Ng1ja1WQnqFAS7mbw01bc4LGT0+MdgSDVodTHRh4U4tpqf
         iUBb8FfSMKNgD8pZYYjtev0m8CaozHCQCGtRbnZqmVcMd0TGjvqUK2W0xiCORmzKZiIZ
         cXXtfXkfyoEavS6ZbvLv5SLpGVQ1GKVf67uJqL+Kbtxu9lwk4szgyAc2sLYtbjYQk55/
         eLqPJM48mk1umD7gpQEbJDtXYfjK+kIV6tLzVlyCCbHugWg9fBUoDd1TbMUhFJEMoweg
         Qhq/4jCIqVsXbYo0t5/93o8opCsgVgTiO79KWz7+GNJwxmFiB8eyBbs3Ecmjnw+Gm81W
         VDoQ==
X-Gm-Message-State: AOJu0YyaLLvhSzNYCeswj7uszygv+WMkTTWchPY3qiu811Qqtf/ZPuiL
	QgNGVtUAp/dlfE56kYT0BbDJ458JpydE+GhlMJU=
X-Google-Smtp-Source: AGHT+IEmQ7QWZ3tfnPtr0Lpkx20E/2KGHBsVRSK8DKXGQMiHsQPIPNowZ48F0dfEs/k8C5RUMWVhng==
X-Received: by 2002:a05:6512:2242:b0:50d:1a17:b69c with SMTP id i2-20020a056512224200b0050d1a17b69cmr6895643lfu.52.1702729816901;
        Sat, 16 Dec 2023 04:30:16 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id tp5-20020a170907c48500b00a2304386f4bsm4632349ejc.211.2023.12.16.04.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:30:16 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v8 8/9] devlink: add a command to set notification filter and use it for multicasts
Date: Sat, 16 Dec 2023 13:30:00 +0100
Message-ID: <20231216123001.1293639-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216123001.1293639-1-jiri@resnulli.us>
References: <20231216123001.1293639-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently the user listening on a socket for devlink notifications
gets always all messages for all existing instances, even if he is
interested only in one of those. That may cause unnecessary overhead
on setups with thousands of instances present.

User is currently able to narrow down the devlink objects replies
to dump commands by specifying select attributes.

Allow similar approach for notifications. Introduce a new devlink
NOTIFY_FILTER_SET which the user passes the select attributes. Store
these per-socket and use them for filtering messages
during multicast send.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v7->v8:
- rebased on top of __genl_sk_priv_get() return value change
v6->v7:
- rebased on top of *genl_sk_priv_get() args swap
v4->v5:
- rebased on top of generic netlink per sock per family pointer
  allocation code
- changed the flt to be stored in family priv rcu pointer, protected by
  spin lock
- changed to use size_add() helper for kzalloc() size computation
- removed generated userspace bits
v3->v4:
- rebased on top of genl_sk_priv_*() introduction
---
 Documentation/netlink/specs/devlink.yaml |  10 +++
 include/uapi/linux/devlink.h             |   2 +
 net/devlink/devl_internal.h              |  34 ++++++-
 net/devlink/netlink.c                    | 108 +++++++++++++++++++++++
 net/devlink/netlink_gen.c                |  15 +++-
 net/devlink/netlink_gen.h                |   4 +-
 6 files changed, 169 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index c3a438197964..88bfcb3c3346 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2254,3 +2254,13 @@ operations:
             - bus-name
             - dev-name
             - selftests
+
+    -
+      name: notify-filter-set
+      doc: Set notification messages socket filter.
+      attribute-set: devlink
+      do:
+        request:
+          attributes:
+            - bus-name
+            - dev-name
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index b3c8383d342d..130cae0d3e20 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -139,6 +139,8 @@ enum devlink_command {
 	DEVLINK_CMD_SELFTESTS_GET,	/* can dump */
 	DEVLINK_CMD_SELFTESTS_RUN,
 
+	DEVLINK_CMD_NOTIFY_FILTER_SET,
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 84dc9628d3f2..82e0fb3bbebf 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -191,11 +191,41 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
 				  DEVLINK_MCGRP_CONFIG);
 }
 
+struct devlink_obj_desc {
+	struct rcu_head rcu;
+	const char *bus_name;
+	const char *dev_name;
+	long data[];
+};
+
+static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
+					    struct devlink *devlink)
+{
+	memset(desc, 0, sizeof(*desc));
+	desc->bus_name = devlink->dev->bus->name;
+	desc->dev_name = dev_name(devlink->dev);
+}
+
+int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data);
+
+static inline void devlink_nl_notify_send_desc(struct devlink *devlink,
+					       struct sk_buff *msg,
+					       struct devlink_obj_desc *desc)
+{
+	genlmsg_multicast_netns_filtered(&devlink_nl_family,
+					 devlink_net(devlink),
+					 msg, 0, DEVLINK_MCGRP_CONFIG,
+					 GFP_KERNEL,
+					 devlink_nl_notify_filter, desc);
+}
+
 static inline void devlink_nl_notify_send(struct devlink *devlink,
 					  struct sk_buff *msg)
 {
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	struct devlink_obj_desc desc;
+
+	devlink_nl_obj_desc_init(&desc, devlink);
+	devlink_nl_notify_send_desc(devlink, msg, &desc);
 }
 
 /* Notify */
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index fa9afe3e6d9b..3176be2585cb 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -17,6 +17,111 @@ static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
 };
 
+struct devlink_nl_sock_priv {
+	struct devlink_obj_desc __rcu *flt;
+	spinlock_t flt_lock; /* Protects flt. */
+};
+
+static void devlink_nl_sock_priv_init(void *priv)
+{
+	struct devlink_nl_sock_priv *sk_priv = priv;
+
+	spin_lock_init(&sk_priv->flt_lock);
+}
+
+static void devlink_nl_sock_priv_destroy(void *priv)
+{
+	struct devlink_nl_sock_priv *sk_priv = priv;
+	struct devlink_obj_desc *flt;
+
+	flt = rcu_dereference_protected(sk_priv->flt, true);
+	kfree_rcu(flt, rcu);
+}
+
+int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	struct devlink_nl_sock_priv *sk_priv;
+	struct nlattr **attrs = info->attrs;
+	struct devlink_obj_desc *flt;
+	size_t data_offset = 0;
+	size_t data_size = 0;
+	char *pos;
+
+	if (attrs[DEVLINK_ATTR_BUS_NAME])
+		data_size = size_add(data_size,
+				     nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1);
+	if (attrs[DEVLINK_ATTR_DEV_NAME])
+		data_size = size_add(data_size,
+				     nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1);
+
+	flt = kzalloc(size_add(sizeof(*flt), data_size), GFP_KERNEL);
+	if (!flt)
+		return -ENOMEM;
+
+	pos = (char *) flt->data;
+	if (attrs[DEVLINK_ATTR_BUS_NAME]) {
+		data_offset += nla_strscpy(pos,
+					   attrs[DEVLINK_ATTR_BUS_NAME],
+					   data_size) + 1;
+		flt->bus_name = pos;
+		pos += data_offset;
+	}
+	if (attrs[DEVLINK_ATTR_DEV_NAME]) {
+		nla_strscpy(pos, attrs[DEVLINK_ATTR_DEV_NAME],
+			    data_size - data_offset);
+		flt->dev_name = pos;
+	}
+
+	/* Don't attach empty filter. */
+	if (!flt->bus_name && !flt->dev_name) {
+		kfree(flt);
+		flt = NULL;
+	}
+
+	sk_priv = genl_sk_priv_get(&devlink_nl_family, NETLINK_CB(skb).sk);
+	if (IS_ERR(sk_priv)) {
+		kfree(flt);
+		return PTR_ERR(sk_priv);
+	}
+	spin_lock(&sk_priv->flt_lock);
+	flt = rcu_replace_pointer(sk_priv->flt, flt,
+				  lockdep_is_held(&sk_priv->flt_lock));
+	spin_unlock(&sk_priv->flt_lock);
+	kfree_rcu(flt, rcu);
+	return 0;
+}
+
+static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
+				   const struct devlink_obj_desc *flt)
+{
+	if (desc->bus_name && flt->bus_name &&
+	    strcmp(desc->bus_name, flt->bus_name))
+		return false;
+	if (desc->dev_name && flt->dev_name &&
+	    strcmp(desc->dev_name, flt->dev_name))
+		return false;
+	return true;
+}
+
+int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data)
+{
+	struct devlink_obj_desc *desc = data;
+	struct devlink_nl_sock_priv *sk_priv;
+	struct devlink_obj_desc *flt;
+	int ret = 0;
+
+	rcu_read_lock();
+	sk_priv = __genl_sk_priv_get(&devlink_nl_family, dsk);
+	if (!IS_ERR_OR_NULL(sk_priv)) {
+		flt = rcu_dereference(sk_priv->flt);
+		if (flt)
+			ret = !devlink_obj_desc_match(desc, flt);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
 int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 				 struct devlink *devlink, int attrtype)
 {
@@ -256,4 +361,7 @@ struct genl_family devlink_nl_family __ro_after_init = {
 	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
 	.mcgrps		= devlink_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
+	.sock_priv_size		= sizeof(struct devlink_nl_sock_priv),
+	.sock_priv_init		= devlink_nl_sock_priv_init,
+	.sock_priv_destroy	= devlink_nl_sock_priv_destroy,
 };
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 95f9b4350ab7..1cb0e05305d2 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -560,8 +560,14 @@ static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_SELF
 	[DEVLINK_ATTR_SELFTESTS] = NLA_POLICY_NESTED(devlink_dl_selftest_id_nl_policy),
 };
 
+/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
+static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[73] = {
+const struct genl_split_ops devlink_nl_ops[74] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -1233,4 +1239,11 @@ const struct genl_split_ops devlink_nl_ops[73] = {
 		.maxattr	= DEVLINK_ATTR_SELFTESTS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_NOTIFY_FILTER_SET,
+		.doit		= devlink_nl_notify_filter_set_doit,
+		.policy		= devlink_notify_filter_set_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 02f3c0bfae0e..8f2bd50ddf5e 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -16,7 +16,7 @@ extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_F
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
-extern const struct genl_split_ops devlink_nl_ops[73];
+extern const struct genl_split_ops devlink_nl_ops[74];
 
 int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
@@ -142,5 +142,7 @@ int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
 				    struct netlink_callback *cb);
 int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
+				      struct genl_info *info);
 
 #endif /* _LINUX_DEVLINK_GEN_H */
-- 
2.43.0


