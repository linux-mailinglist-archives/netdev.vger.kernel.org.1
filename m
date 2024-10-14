Return-Path: <netdev+bounces-135201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0BB99CBDF
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFB4283ACB
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D301EF1D;
	Mon, 14 Oct 2024 13:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FF4A24;
	Mon, 14 Oct 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913826; cv=none; b=n31LeqYNAawwU1edMrPMcluXv2p6OWFdhx1+jP1QGJ/dF1G8qs+zrOJPmvHDHVOjLp7Tsa0itfYPyLpWEfF0CxYIDW9LXOJwsKEMhTvzIAFPb/GLhjj3NCGqb9lSId/neEq8B5gAJQl8Lp29gWnXDrE9mwrRT0w53c8dOQ/Ky2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913826; c=relaxed/simple;
	bh=YM3jE6uO5zbzS6uUAjTQGkZ/PQcX27KI0Q9AH3cHfwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceFdpaXLqWfdO/+Pg59wZQp0n9Wv4CirJGss49aUMla8BLTFuChhLWq1uMdSJpbaKY/qn3MqAf8nw7LMgyfbgUtsPR4eu4ABm/dPETygXxnCviVA8nA0/yuaNv4bKafFVyo5SMykcd+8SHaDYZ9di8yfvyqWeCHARKvtY0MT0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d518f9abcso2324194f8f.2;
        Mon, 14 Oct 2024 06:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728913822; x=1729518622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qewEKJ9t1V9rZ0obD8eIxk5ts6msWZv2OXjyGUHdW8=;
        b=T01oqrb9X4a/iwrqvhckyzMnH3UZnxRKJBFtTLYcl/GPDcZokXe387tnS3yzh9Wouh
         Dqq0J0kqeW1/M+CG6Z8+C4tmqred6HyaQJhxBpFrRYIdHB53CkTt+LrJPiUgik6FDu28
         V52PFcNy5UyIjWkEw8BoXS8mjpcm83yRcxrdtFqavFnleVv3tgsWQ3sH2KZfEvEkwWzX
         5llos9zOg+XiwIK28vzYAgIcl7OZk13/oOE8O7pfxiZ3pICcMDnhjIOC11ohahPLNfA3
         q5rK+g1iv9qXos23GxrZNB4WKGI+omQa9Z9XDsNyFmVEKaGsDk6y+uWdX0Pkw6U3adVl
         EWaA==
X-Forwarded-Encrypted: i=1; AJvYcCU0xQ1DB9MdGNieCInnX6yZOSJINZ6gzjwiQJgAlrpuCDs5siUSoUpR2YJBNuIaeGCJKh0jg9x+@vger.kernel.org, AJvYcCUPkunEFRrO5wP6BSkGORm2NIW0JShciVpBl27Ny9LZZtAm9hgq6bf4ZV5WAXYFXDU4fRmvTUcT1+0=@vger.kernel.org, AJvYcCVYXHyC7RIvhwbAFYQknpPr/D6697ec9gh1+rQzm6l/E8Jma7kHZR1rQQ3jZC+feLITohTLjqm8Hwi18y1e@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/lHfYjfQbHSXObXtzPngaT+NuxlaJ3rYSjiCw9DmPXK4UGcq
	pqV3fqrkQUYp5PbnZs5dE5rk0k9o49HkaVIrEb0A+p3SLKRmsQDP
X-Google-Smtp-Source: AGHT+IEzSIe7EocxWLvavDStYPgdbg7K6/S9hiSWSwMG8bpMDlXj/jQoc8iwn3IWd3D5ooUzbZBvGg==
X-Received: by 2002:a5d:4acc:0:b0:37d:54a0:d0a1 with SMTP id ffacd0b85a97d-37d552cdd6dmr7349113f8f.56.1728913822021;
        Mon, 14 Oct 2024 06:50:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8666sm11390320f8f.22.2024.10.14.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:50:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@meta.com,
	Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH net-next v3] net: Implement fault injection forcing skb reallocation
Date: Mon, 14 Oct 2024 06:50:00 -0700
Message-ID: <20241014135015.3506392-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a fault injection mechanism to force skb reallocation. The
primary goal is to catch bugs related to pointer invalidation after
potential skb reallocation.

The fault injection mechanism aims to identify scenarios where callers
retain pointers to various headers in the skb but fail to reload these
pointers after calling a function that may reallocate the data. This
type of bug can lead to memory corruption or crashes if the old,
now-invalid pointers are used.

By forcing reallocation through fault injection, we can stress-test code
paths and ensure proper pointer management after potential skb
reallocations.

Add a hook for fault injection in the following functions:

 * pskb_trim_rcsum()
 * pskb_may_pull_reason()
 * pskb_trim()

As the other fault injection mechanism, protect it under a debug Kconfig
called CONFIG_FAIL_SKB_FORCE_REALLOC.

This patch was *heavily* inspired by Jakub's proposal from:
https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/

CC: Akinobu Mita <akinobu.mita@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:
v3:
 * Remove decision part of skb_might_realloc() into a new function
   should_fail_net_realloc_skb(). Marked it as ALLOW_ERROR_INJECTION,
   so it could be controlled by fail_function and BPF (Paolo)

v2:
 * Moved the CONFIG_FAIL_SKB_FORCE_REALLOC Kconfig entry closer to other
   fault injection Kconfigs.  (Kuniyuki Iwashima)
 * Create a filter mechanism (Akinobu Mita)
 * https://lore.kernel.org/all/20241008111358.1691157-1-leitao@debian.org/

v1:
 * https://lore.kernel.org/all/20241002113316.2527669-1-leitao@debian.org/

 .../fault-injection/fault-injection.rst       |  35 ++++++
 include/linux/skbuff.h                        |   9 ++
 lib/Kconfig.debug                             |  10 ++
 net/core/Makefile                             |   1 +
 net/core/skb_fault_injection.c                | 103 ++++++++++++++++++
 5 files changed, 158 insertions(+)
 create mode 100644 net/core/skb_fault_injection.c

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 8b8aeea71c68..bb19638d5317 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -45,6 +45,28 @@ Available fault injection capabilities
   ALLOW_ERROR_INJECTION() macro, by setting debugfs entries
   under /sys/kernel/debug/fail_function. No boot option supported.
 
+- fail_net_force_skb_realloc
+
+  inject skb (socket buffer) reallocation events into the network path. The
+  primary goal is to identify and prevent issues related to pointer
+  mismanagement in the network subsystem.  By forcing skb reallocation at
+  strategic points, this feature creates scenarios where existing pointers to
+  skb headers become invalid.
+
+  When the fault is injected and the reallocation is triggered, these pointers
+  no longer reference valid memory locations. This deliberate invalidation
+  helps expose code paths where proper pointer updating is neglected after a
+  reallocation event.
+
+  By creating these controlled fault scenarios, the system can catch instances
+  where stale pointers are used, potentially leading to memory corruption or
+  system instability.
+
+  To select the interface to act on, write the network name to the following file:
+  `/sys/kernel/debug/fail_net_force_skb_realloc/devname`
+  If this field is left empty (which is the default value), skb reallocation
+  will be forced on all network interfaces.
+
 - NVMe fault injection
 
   inject NVMe status code and retry flag on devices permitted by setting
@@ -216,6 +238,18 @@ configuration of fault-injection capabilities.
 	use a negative errno, you better use 'printf' instead of 'echo', e.g.:
 	$ printf %#x -12 > retval
 
+- /sys/kernel/debug/fail_net_force_skb_realloc/devname:
+
+        Specifies the network interface on which to force SKB reallocation.  If
+        left empty, SKB reallocation will be applied to all network interfaces.
+
+        Example usage:
+        # Force skb reallocation on eth0
+        echo "eth0" > /sys/kernel/debug/fail_net_force_skb_realloc/devname
+
+        # Clear the selection and force skb reallocation on all interfaces
+        echo "" > /sys/kernel/debug/fail_net_force_skb_realloc/devname
+
 Boot option
 ^^^^^^^^^^^
 
@@ -227,6 +261,7 @@ use the boot option::
 	fail_usercopy=
 	fail_make_request=
 	fail_futex=
+	fail_net_force_skb_realloc=
 	mmc_core.fail_request=<interval>,<probability>,<space>,<times>
 
 proc entries
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 48f1e0fa2a13..6a77dabd86c3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2681,6 +2681,12 @@ static inline void skb_assert_len(struct sk_buff *skb)
 #endif /* CONFIG_DEBUG_NET */
 }
 
+#if defined(CONFIG_FAIL_SKB_FORCE_REALLOC)
+void skb_might_realloc(struct sk_buff *skb);
+#else
+static inline void skb_might_realloc(struct sk_buff *skb) {}
+#endif
+
 /*
  *	Add data to an sk_buff
  */
@@ -2781,6 +2787,7 @@ static inline enum skb_drop_reason
 pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 {
 	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_might_realloc(skb);
 
 	if (likely(len <= skb_headlen(skb)))
 		return SKB_NOT_DROPPED_YET;
@@ -3216,6 +3223,7 @@ static inline int __pskb_trim(struct sk_buff *skb, unsigned int len)
 
 static inline int pskb_trim(struct sk_buff *skb, unsigned int len)
 {
+	skb_might_realloc(skb);
 	return (len < skb->len) ? __pskb_trim(skb, len) : 0;
 }
 
@@ -3970,6 +3978,7 @@ int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len);
 
 static inline int pskb_trim_rcsum(struct sk_buff *skb, unsigned int len)
 {
+	skb_might_realloc(skb);
 	if (likely(len >= skb->len))
 		return 0;
 	return pskb_trim_rcsum_slow(skb, len);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..fa65e14f7c61 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2115,6 +2115,16 @@ config FAIL_SUNRPC
 	  Provide fault-injection capability for SunRPC and
 	  its consumers.
 
+config FAIL_SKB_FORCE_REALLOC
+	bool "Fault-injection capability forcing skb to reallocate"
+	depends on FAULT_INJECTION_DEBUG_FS
+	help
+	  Provide fault-injection capability that forces the skb to be
+	  reallocated, caughting possible invalid pointers to the skb.
+
+	  For more information, check
+	  Documentation/dev-tools/fault-injection/fault-injection.rst
+
 config FAULT_INJECTION_CONFIGFS
 	bool "Configfs interface for fault-injection capabilities"
 	depends on FAULT_INJECTION
diff --git a/net/core/Makefile b/net/core/Makefile
index 5a72a87ee0f1..14bdc63e4b71 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -46,3 +46,4 @@ obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
 obj-$(CONFIG_DEBUG_NET_SMALL_RTNL) += rtnl_net_debug.o
+obj-$(CONFIG_FAIL_SKB_FORCE_REALLOC) += skb_fault_injection.o
diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
new file mode 100644
index 000000000000..7839519a0a5f
--- /dev/null
+++ b/net/core/skb_fault_injection.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/fault-inject.h>
+#include <linux/netdevice.h>
+#include <linux/debugfs.h>
+#include <linux/skbuff.h>
+
+static struct {
+	struct fault_attr attr;
+	char devname[IFNAMSIZ];
+	bool filtered;
+} skb_realloc = {
+	.attr = FAULT_ATTR_INITIALIZER,
+	.filtered = false,
+};
+
+static bool should_fail_net_realloc_skb(struct sk_buff *skb)
+{
+	struct net_device *net = skb->dev;
+
+	if (skb_realloc.filtered &&
+	    strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
+		/* device name filter set, but names do not match */
+		return false;
+
+	if (!should_fail(&skb_realloc.attr, 1))
+		return false;
+
+	return true;
+}
+ALLOW_ERROR_INJECTION(should_fail_net_realloc_skb, TRUE);
+
+void skb_might_realloc(struct sk_buff *skb)
+{
+	if (!should_fail_net_realloc_skb(skb))
+		return;
+
+	pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
+}
+EXPORT_SYMBOL(skb_might_realloc);
+
+static int __init skb_realloc_setup(char *str)
+{
+	return setup_fault_attr(&skb_realloc.attr, str);
+}
+__setup("skb_realloc=", skb_realloc_setup);
+
+static void reset_settings(void)
+{
+	skb_realloc.filtered = false;
+	memzero_explicit(&skb_realloc.devname, IFNAMSIZ);
+}
+
+static ssize_t devname_write(struct file *file, const char __user *buffer,
+			     size_t count, loff_t *ppos)
+{
+	ssize_t ret;
+
+	reset_settings();
+	ret = simple_write_to_buffer(&skb_realloc.devname, IFNAMSIZ,
+				     ppos, buffer, count);
+	if (ret < 0)
+		return ret;
+	strim(skb_realloc.devname);
+
+	if (strnlen(skb_realloc.devname, IFNAMSIZ))
+		skb_realloc.filtered = true;
+
+	return count;
+}
+
+static ssize_t devname_read(struct file *file,
+			    char __user *buffer,
+			    size_t size, loff_t *ppos)
+{
+	if (!skb_realloc.filtered)
+		return 0;
+
+	return simple_read_from_buffer(buffer, size, ppos, &skb_realloc.devname,
+				       strlen(skb_realloc.devname));
+}
+
+static const struct file_operations devname_ops = {
+	.write = devname_write,
+	.read = devname_read,
+};
+
+static int __init fail_net_force_skb_realloc_debugfs(void)
+{
+	umode_t mode = S_IFREG | 0600;
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_net_force_skb_realloc", NULL,
+					&skb_realloc.attr);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	debugfs_create_file("devname", mode, dir, NULL, &devname_ops);
+
+	return 0;
+}
+
+late_initcall(fail_net_force_skb_realloc_debugfs);
-- 
2.43.5


