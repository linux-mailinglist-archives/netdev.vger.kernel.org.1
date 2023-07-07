Return-Path: <netdev+bounces-16119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F0D74B71C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2BA28185A
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076E17AAA;
	Fri,  7 Jul 2023 19:30:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343217AA1
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:30:33 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E978F2D62
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:30:15 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6826902bc8dso4834378b3a.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758215; x=1691350215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebCFN4kvmp0fJHVry9ZNXr0b2a76EZGRumAZp4zFQ58=;
        b=QxtHBizse4IIpZbzsfMayss1q8qZxxXZKHI09o/ls7IAXdZM2ybrPRUfHAyww3ITIw
         DFW/VT0tmoQKotdq1EorkHwkQZrBQtBZABm1IyGonB2KZxkLoTp0kWfIkTdoTUhU+GR2
         1LchVOsg7yWibqiPeiOAz+biQx94UCuoG4YnQLs/oUdaXDTV/yalTTqTLgAkHAvmHD9P
         Ko5OoRuEKHp5rWf4hfjW2z2MYzZfVe7r2DeI4onvXVBou64PmWh/aS8VwTsm+YfonL4Z
         IMsJ9wp73oMJnfUq0OPLrugaJhDeN9d2yJxtL4lpyg+zL/+fmWps3hjDOex23WTkwiSA
         ++3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758215; x=1691350215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebCFN4kvmp0fJHVry9ZNXr0b2a76EZGRumAZp4zFQ58=;
        b=BrEAb2IjtczC+sBK36KnILE5Sl1Iu9h9bfMFMNLxPjIt+e0g5BCnipuYAwkcQilPGg
         ybJA5WdC0pNs5Yu4ujG0X3gj8H12BfSUI2cEkacnN+rpVTRz30fAAydiR4YaeMsjB9j9
         ErH1C/1MwGO7XFPwHFQafG1dvdpASaTrSUQ/2wHCeGIUzud+UNK3i7iTVBSUOf870BJd
         pMJ+H6wkJnCqf/T8UJcnPQcL+DVvaN4LRUtcIMQaJTTHao/IqNMZjJmJjTfdfsO7O+TL
         wZCbvikioIfZ3PM4KVeh8vEjhGWWLNDAAYl8B47bCGlPvGdVx6q7VNkKpFWc1FjErJwT
         UuuA==
X-Gm-Message-State: ABy/qLaJD85PS3a6pfX8AdqnsNkEvj7Qh/NOlhCm2qiTZTh/oWywI8L3
	sDPdChH/F69gLmDjywxDGjy5Dqo=
X-Google-Smtp-Source: APBJJlEqPQGVYO2Z4YF3Q3Th6qs2JWFrIG3eZT1fEgx2rigKiKvx51KpsYyHFnhmnc4VLIAwUCvcvBk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:14c5:b0:67c:bfb:884f with SMTP id
 w5-20020a056a0014c500b0067c0bfb884fmr8525475pfu.2.1688758215343; Fri, 07 Jul
 2023 12:30:15 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:29:56 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-5-sdf@google.com>
Subject: [RFC bpf-next v3 04/14] bpf: Implement devtx hook points
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

devtx is a lightweight set of hooks before and after packet transmission.
The hooks are implemented as a tracing program which has access to the
XDP-metadata-like kfuncs. The initial set of kfuncs is implemented
in the next patch, but the idea is similar to XDP metadata:
the kfuncs have netdev-specific implementation, but common
interface. Upon loading, the kfuncs are resolved to direct
calls against per-netdev implementation. This can be achieved
by marking devtx-tracing programs as dev-bound (largely
reusing xdp-dev-bound program infrastructure).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 MAINTAINERS          |  2 ++
 include/net/devtx.h  | 66 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/offload.c | 15 +++++++++
 net/core/Makefile    |  1 +
 net/core/dev.c       |  1 +
 net/core/devtx.c     | 78 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 163 insertions(+)
 create mode 100644 include/net/devtx.h
 create mode 100644 net/core/devtx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index acbe54087d1c..de6a2430d49a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23063,11 +23063,13 @@ L:	bpf@vger.kernel.org
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
index 000000000000..88127ca87b9a
--- /dev/null
+++ b/include/net/devtx.h
@@ -0,0 +1,66 @@
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
+struct devtx_ctx {
+	struct net_device *netdev;
+	struct skb_shared_info *sinfo; /* for frags */
+};
+
+#define DECLARE_DEVTX_HOOKS(PREFIX) \
+void PREFIX ## _devtx_submit_skb(struct devtx_ctx *ctx, struct sk_buff *skb); \
+void PREFIX ## _devtx_complete_skb(struct devtx_ctx *ctx, struct sk_buff *skb); \
+void PREFIX ## _devtx_submit_xdp(struct devtx_ctx *ctx, struct xdp_frame *xdpf); \
+void PREFIX ## _devtx_complete_xdp(struct devtx_ctx *ctx, struct xdp_frame *xdpf)
+
+#define DEFINE_DEVTX_HOOKS(PREFIX) \
+__weak noinline void PREFIX ## _devtx_submit_skb(struct devtx_ctx *ctx, \
+						 struct sk_buff *skb) {} \
+__weak noinline void PREFIX ## _devtx_complete_skb(struct devtx_ctx *ctx, \
+						   struct sk_buff *skb) {} \
+__weak noinline void PREFIX ## _devtx_submit_xdp(struct devtx_ctx *ctx, \
+						 struct xdp_frame *xdpf) {} \
+__weak noinline void PREFIX ## _devtx_complete_xdp(struct devtx_ctx *ctx, \
+						   struct xdp_frame *xdpf) {} \
+\
+BTF_SET8_START(PREFIX ## _devtx_hook_ids) \
+BTF_ID_FLAGS(func, PREFIX ## _devtx_submit_skb) \
+BTF_ID_FLAGS(func, PREFIX ## _devtx_complete_skb) \
+BTF_ID_FLAGS(func, PREFIX ## _devtx_submit_xdp) \
+BTF_ID_FLAGS(func, PREFIX ## _devtx_complete_xdp) \
+BTF_SET8_END(PREFIX ## _devtx_hook_ids)
+
+#ifdef CONFIG_NET
+void devtx_hooks_enable(void);
+void devtx_hooks_disable(void);
+bool devtx_hooks_match(u32 attach_btf_id, const struct xdp_metadata_ops *xmo);
+int devtx_hooks_register(struct btf_id_set8 *set, const struct xdp_metadata_ops *xmo);
+void devtx_hooks_unregister(struct btf_id_set8 *set);
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
+static inline bool devtx_enabled(void)
+{
+	return false;
+}
+#endif
+
+#endif /* __LINUX_NET_DEVTX_H__ */
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index cec63c76dce5..a4423803b3dd 100644
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
index 731db2eaa610..97b4d6703a77 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -39,4 +39,5 @@ obj-$(CONFIG_FAILOVER) += failover.o
 obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
 obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
+obj-$(CONFIG_BPF_SYSCALL) += devtx.o
 obj-$(CONFIG_OF)	+= of_net.o
diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c..b9500a722591 100644
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
index 000000000000..6ae1aecce2c5
--- /dev/null
+++ b/net/core/devtx.c
@@ -0,0 +1,78 @@
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
+EXPORT_SYMBOL_GPL(devtx_hooks_register);
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
+EXPORT_SYMBOL_GPL(devtx_hooks_unregister);
-- 
2.41.0.255.g8b1d071c50-goog


