Return-Path: <netdev+bounces-133063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A69B99464E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E6B2872AB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ACF1CDA26;
	Tue,  8 Oct 2024 11:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217816EB42;
	Tue,  8 Oct 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386072; cv=none; b=M6L9mM/6gFfgyLBHJVioMyBkKygApaafvQPOb+UGfRYaVOB7jWhMlqIeKvxl70L2VB+ofm+SdxVm97W0tYlJfQUXdEWi9I17JNSOPZS0HkdfWiLM6UwsfXowi9MbePv6xtp1HgxwLUIOv8VSxCuNrAMZfSTFXbUMb1XCPOstLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386072; c=relaxed/simple;
	bh=ot0AMcrLmz5uhZ4+SV5LBkr8+ixd49O2Iu3QZusUki0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBcCagbOlJ4CczNcqr+VAKZ0DljeJR+kjSIAV+I5fVnCqCAHjTnQ4Iv+MtFpsLdai7Lf7NfZZOFNvElcV1GkgyG7CkaTmI8YFy0u3seKZ4Y0G4JMqOFVPEdhYdpnwgoqugx+CK4YqGBrRB0xe8ndyoPajMoLcvdIU/ZV/Wdz7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so6226268e87.1;
        Tue, 08 Oct 2024 04:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728386068; x=1728990868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P49/aqnFeGhK0JHnT6oL1HTdVou7U5WzZzZVhN5T5As=;
        b=sX/gJNybGtK8Hp/pqt4TdNHiSdv5fM4XszthMWUlJR1VR3lCjSX944jSUTA8rTUea0
         o6S149Y+XTMfBAOnrkToUkMisAjnJR6hfQUj+cXtMVIclTW0lG0xtcf3Fhaiiaij9xTx
         KPqd4S8BdOOy2hY+vcwFx1lgB6wodcRnYjklbUtE+JOQI5QEEw+KTKpMh8rvip+sL+ph
         kpBe0lL5C04ve5qeGvFz4Bv3LZeMhIL+LiJY0fRLGb5KOkcpMbJYRYCFLy4USsQKW7sc
         tSdRXOAV0pJiMTbaDbE0vfGvKVPmIPrzCm7bm0fMPV7oh52/Ako16ydqVer8CKO4XAAo
         yeOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3mzgzkfN+wjsurz+CKB2O0UQK2iSqwV/O6fbUqEixxlc6o/a/2e8v70y0WnvowKk1a/NeVbkRk3YRfoIs@vger.kernel.org, AJvYcCWFgLgG8dzk6atprkWtvnehRkhL5+NnULGvAsFyDhq1rYsvc0dE6YaJlVVqGqPRfXC0nR+Bivj6@vger.kernel.org, AJvYcCWQs1Hy/rcA+dpo5317qpZ/vBFKARTEeG9Rd8mPKBu5O9V4KN5vJoKtMyJmSi4rRguWu+AHIto6Y+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlqEYfmNaq1GSSKP42cSL3kuRkUf40IFWFQ43esCMKXJdYT9Z
	4dhfXEQcXgud3eiehjBmZ2HbXXUzXFsCgeNCDQk0lqT3wWx0l/rg
X-Google-Smtp-Source: AGHT+IG9JKoIOuQG3c56tZ2srx6cmx2FrWqGR96EfuHT/vTAun99vCIp2v2w3qOAUkCFcdqwA3jCLA==
X-Received: by 2002:a05:6512:1250:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-539ab86b120mr8820594e87.29.1728386067955;
        Tue, 08 Oct 2024 04:14:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994062660csm414327066b.21.2024.10.08.04.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 04:14:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@meta.com,
	kuniyu@amazon.com,
	asml.silence@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH net-next v2] net: Implement fault injection forcing skb reallocation
Date: Tue,  8 Oct 2024 04:13:43 -0700
Message-ID: <20241008111358.1691157-1-leitao@debian.org>
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

v2:
 * Moved the CONFIG_FAIL_SKB_FORCE_REALLOC Kconfig entry closer to other
   fault injection Kconfigs.  (Kuniyuki Iwashima)
 * Create a filter mechanism (Akinobu Mita)

v1:
 * https://lore.kernel.org/all/20241002113316.2527669-1-leitao@debian.org/

 .../fault-injection/fault-injection.rst       | 35 +++++++
 include/linux/skbuff.h                        |  9 ++
 lib/Kconfig.debug                             | 10 ++
 net/core/Makefile                             |  1 +
 net/core/skb_fault_injection.c                | 95 +++++++++++++++++++
 5 files changed, 150 insertions(+)
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
index 39f1d16f3628..d9ee756a64fc 100644
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
@@ -3210,6 +3217,7 @@ static inline int __pskb_trim(struct sk_buff *skb, unsigned int len)
 
 static inline int pskb_trim(struct sk_buff *skb, unsigned int len)
 {
+	skb_might_realloc(skb);
 	return (len < skb->len) ? __pskb_trim(skb, len) : 0;
 }
 
@@ -3964,6 +3972,7 @@ int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len);
 
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
index c3ebbaf9c81e..02658807242b 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
 obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
+obj-$(CONFIG_FAIL_SKB_FORCE_REALLOC) += skb_fault_injection.o
diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
new file mode 100644
index 000000000000..b6e7a99292cc
--- /dev/null
+++ b/net/core/skb_fault_injection.c
@@ -0,0 +1,95 @@
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
+void skb_might_realloc(struct sk_buff *skb)
+{
+	struct net_device *net = skb->dev;
+
+	if (skb_realloc.filtered &&
+	    strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
+		/* device name filter set, but names do not match */
+		return;
+
+	if (!should_fail(&skb_realloc.attr, 1))
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
+	/* Remove the \n */
+	skb_realloc.devname[strlen(skb_realloc.devname) - 1] = '\0';
+	if (ret < 0)
+		return ret;
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


