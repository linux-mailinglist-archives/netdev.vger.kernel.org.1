Return-Path: <netdev+bounces-12749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39337738C8B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D71A1C20F42
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552819E50;
	Wed, 21 Jun 2023 17:02:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1581992A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 17:02:56 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6110D
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 10:02:54 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-666ecb21f16so4194288b3a.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366974; x=1689958974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kb0kUssv+VWESwpyJ8lyZP4iXH/Vyyf0wzg9dJXmkwg=;
        b=skFLAHaedAMGEp/yTMVy1WbRiNPdv1HPQOq0/d5yOnGWq6mW7/MQYrRI/yyYJDUhqV
         r2fFbYAdOnjg6V8Mr/wpJZMEa3mh0LJc+A7imaDn7kPeqATJm2MYyv/BaycLeAnvEIrR
         YRZnXxNrjBSfYuH5ByEPOiv8U1FSq5U3HYGivJtYbys7sTW15HH2tYsKEsCrw3kDUW0q
         nkch99E3HqQdPhAzOkLRjvMj3u88OK/JRgCs7ZDDT5u2QfS+dZnMQIWhRP/zzBzHxT6p
         5kjbHM55oQu5eXGZpvTREJWYBs0Odgf1msSbuguMXgAQBL4h/YDe2NfZnRfrZxvE5h2F
         f0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366974; x=1689958974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kb0kUssv+VWESwpyJ8lyZP4iXH/Vyyf0wzg9dJXmkwg=;
        b=VQO4NJ2YIHldAKThp3o6P4v7x9tvRvMHz6RR22Cpx5yNUvEbbu3jAmXcsTfUeYcLXm
         7GNCc/WHlnXC7yumOocYjvZTES7KokEcw4TaF5oF8X7hzVtVARQfhR3kTGoxQRfzicx+
         xNXsWoklJ2w3Vuz7t93kphtB9yzqjiRpfjxuVVmEqptbg0/EZB/cKhK+wt0k2GQbMKe7
         0+GlIOOVTT/pqCUVQJOnj1fEu207gAxc1erCdf9X1YoYxXtMEwMhpO6lCzxX6jv9rzq7
         bvlkzD9qSIzkVTg9JqoTzW5GMqWI+pt3Jnvyy1p0ix6lWcyD20iVD1Ngq4jLHF9U6w/v
         FMLw==
X-Gm-Message-State: AC+VfDyT7ImxAjvsAS2V4QCZ8CV3AzyJhAsfRsduImvza9Bj7bKlxpNI
	rGF0qk/fIuw7TyCBYEztx/NKAwg=
X-Google-Smtp-Source: ACHHUZ4x4MJ1Z8wsvz6uZJLGxCK1rGj58yr2mKPdAMupvayjOLNnP7W82YSYrvPghax0fnrlfOA+nJY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:b4e:b0:668:63ee:7706 with SMTP id
 p14-20020a056a000b4e00b0066863ee7706mr3579259pfo.3.1687366973471; Wed, 21 Jun
 2023 10:02:53 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:37 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-5-sdf@google.com>
Subject: [RFC bpf-next v2 04/11] bpf: Implement devtx hook points
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

devtx is a lightweight set of hooks before and after packet transmission.
The hook is supposed to work for both skb and xdp paths by exposing
a light-weight packet wrapper via devtx_frame (header portion + frags).

devtx is implemented as a tracing program which has access to the
XDP-metadata-like kfuncs. The initial set of kfuncs is implemented
in the next patch, but the idea is similar to XDP metadata:
the kfuncs have netdev-specific implementation, but common
interface. Upon loading, the kfuncs are resolved to direct
calls against per-netdev implementation. This can be achieved
by marking devtx-tracing programs as dev-bound (largely
reusing xdp-dev-bound program infrastructure).

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 MAINTAINERS          |  2 ++
 include/net/devtx.h  | 71 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/offload.c | 15 +++++++++
 net/core/Makefile    |  1 +
 net/core/dev.c       |  1 +
 net/core/devtx.c     | 76 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 166 insertions(+)
 create mode 100644 include/net/devtx.h
 create mode 100644 net/core/devtx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c904dba1733b..516529b42e66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22976,11 +22976,13 @@ L:	bpf@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/*/*/*/*/*xdp*
 F:	drivers/net/ethernet/*/*/*xdp*
+F:	include/net/devtx.h
 F:	include/net/xdp.h
 F:	include/net/xdp_priv.h
 F:	include/trace/events/xdp.h
 F:	kernel/bpf/cpumap.c
 F:	kernel/bpf/devmap.c
+F:	net/core/devtx.c
 F:	net/core/xdp.c
 F:	samples/bpf/xdp*
 F:	tools/testing/selftests/bpf/*/*xdp*
diff --git a/include/net/devtx.h b/include/net/devtx.h
new file mode 100644
index 000000000000..d1c75fd9b377
--- /dev/null
+++ b/include/net/devtx.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_NET_DEVTX_H__
+#define __LINUX_NET_DEVTX_H__
+
+#include <linux/jump_label.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/btf_ids.h>
+#include <net/xdp.h>
+
+struct devtx_frame {
+	void *data;
+	u16 len;
+	u8 meta_len;
+	struct skb_shared_info *sinfo; /* for frags */
+	struct net_device *netdev;
+};
+
+#ifdef CONFIG_NET
+void devtx_hooks_enable(void);
+void devtx_hooks_disable(void);
+bool devtx_hooks_match(u32 attach_btf_id, const struct xdp_metadata_ops *xmo);
+int devtx_hooks_register(struct btf_id_set8 *set, const struct xdp_metadata_ops *xmo);
+void devtx_hooks_unregister(struct btf_id_set8 *set);
+
+static inline void devtx_frame_from_skb(struct devtx_frame *ctx, struct sk_buff *skb,
+					struct net_device *netdev)
+{
+	ctx->data = skb->data;
+	ctx->len = skb_headlen(skb);
+	ctx->meta_len = skb_metadata_len(skb);
+	ctx->sinfo = skb_shinfo(skb);
+	ctx->netdev = netdev;
+}
+
+static inline void devtx_frame_from_xdp(struct devtx_frame *ctx, struct xdp_frame *xdpf,
+					struct net_device *netdev)
+{
+	ctx->data = xdpf->data;
+	ctx->len = xdpf->len;
+	ctx->meta_len = xdpf->metasize & 0xff;
+	ctx->sinfo = xdp_frame_has_frags(xdpf) ? xdp_get_shared_info_from_frame(xdpf) : NULL;
+	ctx->netdev = netdev;
+}
+
+DECLARE_STATIC_KEY_FALSE(devtx_enabled_key);
+
+static inline bool devtx_enabled(void)
+{
+	return static_branch_unlikely(&devtx_enabled_key);
+}
+#else
+static inline void devtx_hooks_enable(void) {}
+static inline void devtx_hooks_disable(void) {}
+static inline bool devtx_hooks_match(u32 attach_btf_id, const struct xdp_metadata_ops *xmo) {}
+static inline int devtx_hooks_register(struct btf_id_set8 *set,
+				       const struct xdp_metadata_ops *xmo) {}
+static inline void devtx_hooks_unregister(struct btf_id_set8 *set) {}
+
+static inline void devtx_frame_from_skb(struct devtx_frame *ctx, struct sk_buff *skb,
+					struct net_device *netdev) {}
+static inline void devtx_frame_from_xdp(struct devtx_frame *ctx, struct xdp_frame *xdpf,
+					struct net_device *netdev) {}
+
+static inline bool devtx_enabled(void)
+{
+	return false;
+}
+#endif
+
+#endif /* __LINUX_NET_DEVTX_H__ */
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 235d81f7e0ed..f01a1aa0f627 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -25,6 +25,7 @@
 #include <linux/rhashtable.h>
 #include <linux/rtnetlink.h>
 #include <linux/rwsem.h>
+#include <net/devtx.h>
 
 /* Protects offdevs, members of bpf_offload_netdev and offload members
  * of all progs.
@@ -228,6 +229,7 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
 	int err;
 
 	if (attr->prog_type != BPF_PROG_TYPE_SCHED_CLS &&
+	    attr->prog_type != BPF_PROG_TYPE_TRACING &&
 	    attr->prog_type != BPF_PROG_TYPE_XDP)
 		return -EINVAL;
 
@@ -242,6 +244,15 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
 	if (!netdev)
 		return -EINVAL;
 
+	/* Make sure device-bound tracing programs are being attached
+	 * to the appropriate netdev.
+	 */
+	if (attr->prog_type == BPF_PROG_TYPE_TRACING &&
+	    !devtx_hooks_match(prog->aux->attach_btf_id, netdev->xdp_metadata_ops)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = bpf_dev_offload_check(netdev);
 	if (err)
 		goto out;
@@ -252,6 +263,9 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
 	err = __bpf_prog_dev_bound_init(prog, netdev);
 	up_write(&bpf_devs_lock);
 
+	if (!err)
+		devtx_hooks_enable();
+
 out:
 	dev_put(netdev);
 	return err;
@@ -384,6 +398,7 @@ void bpf_prog_dev_bound_destroy(struct bpf_prog *prog)
 		ondev = bpf_offload_find_netdev(netdev);
 		if (!ondev->offdev && list_empty(&ondev->progs))
 			__bpf_offload_dev_netdev_unregister(NULL, netdev);
+		devtx_hooks_disable();
 	}
 	up_write(&bpf_devs_lock);
 	rtnl_unlock();
diff --git a/net/core/Makefile b/net/core/Makefile
index 8f367813bc68..c1db05ccfac7 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -39,4 +39,5 @@ obj-$(CONFIG_FAILOVER) += failover.o
 obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
 obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
+obj-$(CONFIG_BPF_SYSCALL) += devtx.o
 obj-$(CONFIG_OF)	+= of_net.o
diff --git a/net/core/dev.c b/net/core/dev.c
index 3393c2f3dbe8..e2f4618ee1c5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -150,6 +150,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
+#include <net/devtx.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
diff --git a/net/core/devtx.c b/net/core/devtx.c
new file mode 100644
index 000000000000..bad694439ae3
--- /dev/null
+++ b/net/core/devtx.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <net/devtx.h>
+#include <linux/filter.h>
+
+DEFINE_STATIC_KEY_FALSE(devtx_enabled_key);
+EXPORT_SYMBOL_GPL(devtx_enabled_key);
+
+struct devtx_hook_entry {
+	struct list_head devtx_hooks;
+	struct btf_id_set8 *set;
+	const struct xdp_metadata_ops *xmo;
+};
+
+static LIST_HEAD(devtx_hooks);
+static DEFINE_MUTEX(devtx_hooks_lock);
+
+void devtx_hooks_enable(void)
+{
+	static_branch_inc(&devtx_enabled_key);
+}
+
+void devtx_hooks_disable(void)
+{
+	static_branch_dec(&devtx_enabled_key);
+}
+
+bool devtx_hooks_match(u32 attach_btf_id, const struct xdp_metadata_ops *xmo)
+{
+	struct devtx_hook_entry *entry, *tmp;
+	bool match = false;
+
+	mutex_lock(&devtx_hooks_lock);
+	list_for_each_entry_safe(entry, tmp, &devtx_hooks, devtx_hooks) {
+		if (btf_id_set8_contains(entry->set, attach_btf_id)) {
+			match = entry->xmo == xmo;
+			break;
+		}
+	}
+	mutex_unlock(&devtx_hooks_lock);
+
+	return match;
+}
+
+int devtx_hooks_register(struct btf_id_set8 *set, const struct xdp_metadata_ops *xmo)
+{
+	struct devtx_hook_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->set = set;
+	entry->xmo = xmo;
+
+	mutex_lock(&devtx_hooks_lock);
+	list_add(&entry->devtx_hooks, &devtx_hooks);
+	mutex_unlock(&devtx_hooks_lock);
+
+	return 0;
+}
+
+void devtx_hooks_unregister(struct btf_id_set8 *set)
+{
+	struct devtx_hook_entry *entry, *tmp;
+
+	mutex_lock(&devtx_hooks_lock);
+	list_for_each_entry_safe(entry, tmp, &devtx_hooks, devtx_hooks) {
+		if (entry->set == set) {
+			list_del(&entry->devtx_hooks);
+			kfree(entry);
+			break;
+		}
+	}
+	mutex_unlock(&devtx_hooks_lock);
+}
-- 
2.41.0.162.gfafddb0af9-goog


