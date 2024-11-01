Return-Path: <netdev+bounces-140967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294299B8EC6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF931F21AF9
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10815ADB4;
	Fri,  1 Nov 2024 10:09:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411D14F9F8;
	Fri,  1 Nov 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455790; cv=none; b=dRGOB1WUZ1wXYtUB+PnnwHIULUdHqjv5M707rt54zmKTcvKWIj1Z1Q/BP5jHWQ4FYNcOe04/r0Lmk6uF/mT6Vtk2hhxDe5i+ZPQMTcUbkxWYJAop/Tvz6+vIn5Z6WPEHajCo+uCO0FnsKeY1ezaXY+60348tnrMbLeaSB2xtm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455790; c=relaxed/simple;
	bh=gOgjR4pn1Vgnh0u4Npu7ubOgJ8CxsZVlhsvri9yRZDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DTTCi8ejrtI+rkADdSS6SM4wsx6Nf6CWjWG/FDKHDUpMgCXRFNwJ/0mFaZLlPsHTRR4YB2L8Gy2NU1q54nCRSEapNfrL8aaqUwBbYit0WF7Yos4uBN7pcShyzloAqVaf4Pju5mnyCtKAKA4JVogRUZqDlOGhwEK0d3xi/7+yZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so233386866b.0;
        Fri, 01 Nov 2024 03:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730455786; x=1731060586;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJlgJbZEXlcchXzKG2MyfYbvfgDGckfDgkmTxpW9aW8=;
        b=AL6/+a8GjByqxJ2mb73tXNmHQ8QWXGyhFmE6ZY2dBLruPcMx7S/lvb/Il317gAdvU6
         34vPMrOL/hGTcmHq0IzcPYeahIlsldqpWdfoEK6zXmZtNWSZmtBVGuZc1qaWte66KTp2
         /taGgjBBihNSUV7FA0XNZbvNYLP5a2PO+imsYMJg9A6OyIxfNF0umfA0bax8obhZwDgx
         xTQhZQsfySMwoUNFiD5N5ZILqO32gmATVqpgUuNUsA3Hb+Wfac9pw/X19IaLVECjlYoE
         ilHfR5tZiNtwVQkeI/yDV4ymp9AKys3UKhNWBgiMQm0ZARJ7PoDgIeHhtL8WefNLGI5f
         Cs6w==
X-Forwarded-Encrypted: i=1; AJvYcCUovIelLwM1FUqleaODWf4cPcmSZokmq/Wlav937mZu5So8La8Vn4LIfSDCEQ0beN01GAQI8G1x@vger.kernel.org, AJvYcCW8aNb+jiK1VDeN2tTWaXJg6EBALO6dIZvqBM4ZPKco4V9i8/75FH8CbLg3HfHbUyS+Bkviak8JALCaGTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5yb3rvHxYdAg/6QXwJq0PXcHr6nKYJF8qzbgRN4xPPVmROog+
	JP+oKiPduoz5W07VJd74iaZ5zjgRz3lkxKeyITpzpCPb0gTQdbr9
X-Google-Smtp-Source: AGHT+IEqS/nwPmK/Gwkqt1/l6AVIgvYtIeHArZRnzZlffBJHi31CcmSMnXEqnQtd1vhzZGXOMq9TLw==
X-Received: by 2002:a17:907:6ea2:b0:a9a:f0e:cd4 with SMTP id a640c23a62f3a-a9e50b9e38cmr621326966b.55.1730455785432;
        Fri, 01 Nov 2024 03:09:45 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564cdb00sm163746166b.87.2024.11.01.03.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 03:09:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 01 Nov 2024 03:09:33 -0700
Subject: [PATCH net-next v5] net: Implement fault injection forcing skb
 reallocation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-skb_fault_injection_v5-v5-1-a99696f0a853@debian.org>
X-B4-Tracking: v=1; b=H4sIANyoJGcC/x3M4QqDIBQG0FeR73dCtgzmq4whZtd2t3EbahFE7
 z7oPMA5UCgzFTh1INPGhReBU7ZRiK8gM2me4BS6tuuNaY0un9GnsH6rZ3lTrLyI36we0m0cgk3
 9FO9oFH6ZEu9X/IBQ1UJ7xfM8/8A0p1ByAAAA
X-Change-ID: 20241101-skb_fault_injection_v5-6f3b6a5f4dc9
To: Jonathan Corbet <corbet@lwn.net>, Akinobu Mita <akinobu.mita@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11855; i=leitao@debian.org;
 h=from:subject:message-id; bh=gOgjR4pn1Vgnh0u4Npu7ubOgJ8CxsZVlhsvri9yRZDc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnJKjn2rFhLIJc5PVdL2sdAnS7HuTt1KT36QpXE
 CuJ/uG5AfOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZySo5wAKCRA1o5Of/Hh3
 bfaZD/9s+Bun2o3N2/z0bXn4G3gt7fHVIzW3f0pLi47OXeZXdsQYH+oLDHWI0SKaEgOP9JLNath
 gcmzeayHwKlKP4LHX+XPsrT2ITU3nLyh8xInynfEFRblvAJKFMwLrXN/LVYjX77P4VQYHHpADhe
 imcah+LlNjAF8hjLS/QSpxYEcdrtOlqjdupQkmy0SktJLUmv2aUIlWN7iW24hHgvI4ZDUVJUF9v
 sTAfgWPvrhxQL2W9MMc+5qqomuqPo/jVoMWlTaO1nM7RKJ7GlYaQOsoAk6HCZ0s9PwQ5CJSohaG
 ByiZrbvglTQY2DsfwdqG2KCt0mkbaY2o34P3D8jcI/I4JsXrYSbQBUWFH9S4PxAVzfBQN3f0tN8
 IrCLgBB3D5Fby0LeAxavdjbRK+SphVAO16lDw5Kie1FLToNx2Mqa04mrjbI4pxPGA0hBCnN7Q6/
 d78flUJVTAYG615S4I5U1QYWVvO45j0Lso+bknkK6geZ6peZgm7w4+nLmdoNAEpRqQ/ogsTRHty
 zdEpm3YYZquin6sFBF8+BQMSD7cQt1WEIJ3Hlx6wzqjv0Pa4TdMcJDr6HiFuB0JtJ6aERYb/OPz
 YjPezmypXsQYn+wXdBEoqWmmqPEdAa1gmc647XAILZTQ+uGdoF+psurqvtxkYQxcy/EADaN1uFd
 9X6wMlTRAD+0how==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

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
called CONFIG_FAIL_SKB_REALLOC.

This patch was *heavily* inspired by Jakub's proposal from:
https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/

CC: Akinobu Mita <akinobu.mita@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
Changelog:

v5:
 * Updated the documentation to clarify the effectiveness of KASAN when
   used in conjunction with this feature (Jakub)
 * Fixed a typo in a comment (Jakub)
 * Reordered the imports in skb_fault_injection.c (Jakub)
 * Moved from memzero_explicit() to memset() (Jakub)
 * Zeroing skb_realloc.devname() at IFNAMSIZ-1 (Jakub)

v4:
 * Add entry in kernel-parameters.txt (Paolo)
 * Renamed the config to fail_skb_realloc (Akinobu)
 * Fixed the documentation format (Bagas)
 * https://lore.kernel.org/all/20241023113819.3395078-1-leitao@debian.org/

v3:
 * Remove decision part of skb_might_realloc() into a new function
   should_fail_net_realloc_skb(). Marked it as ALLOW_ERROR_INJECTION,
   so it could be controlled by fail_function and BPF (Paolo)
 * https://lore.kernel.org/all/20241014135015.3506392-1-leitao@debian.org/

v2:
 * Moved the CONFIG_FAIL_SKB_FORCE_REALLOC Kconfig entry closer to other
   fault injection Kconfigs.  (Kuniyuki Iwashima)
 * Create a filter mechanism (Akinobu Mita)
 * https://lore.kernel.org/all/20241008111358.1691157-1-leitao@debian.org/

v1:
 * https://lore.kernel.org/all/20241002113316.2527669-1-leitao@debian.org/
---
 Documentation/admin-guide/kernel-parameters.txt   |   1 +
 Documentation/fault-injection/fault-injection.rst |  40 ++++++++
 include/linux/skbuff.h                            |   9 ++
 lib/Kconfig.debug                                 |  10 ++
 net/core/Makefile                                 |   1 +
 net/core/skb_fault_injection.c                    | 106 ++++++++++++++++++++++
 6 files changed, 167 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe2237f1d577df5656339d6224b769be..2fb830453dcc8633ad8c48ea666daa1bd4186f25 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1546,6 +1546,7 @@
 	failslab=
 	fail_usercopy=
 	fail_page_alloc=
+	fail_skb_realloc=
 	fail_make_request=[KNL]
 			General fault injection mechanism.
 			Format: <interval>,<probability>,<space>,<times>
diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 8b8aeea71c685b358dfebb419ae74277e729298a..880237dca4ff78e7f11dac3cca70969a18a70cc3 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -45,6 +45,32 @@ Available fault injection capabilities
   ALLOW_ERROR_INJECTION() macro, by setting debugfs entries
   under /sys/kernel/debug/fail_function. No boot option supported.
 
+- fail_skb_realloc
+
+  inject skb (socket buffer) reallocation events into the network path. The
+  primary goal is to identify and prevent issues related to pointer
+  mismanagement in the network subsystem.  By forcing skb reallocation at
+  strategic points, this feature creates scenarios where existing pointers to
+  skb headers become invalid.
+
+  When the fault is injected and the reallocation is triggered, cached pointers
+  to skb headers and data no longer reference valid memory locations. This
+  deliberate invalidation helps expose code paths where proper pointer updating
+  is neglected after a reallocation event.
+
+  By creating these controlled fault scenarios, the system can catch instances
+  where stale pointers are used, potentially leading to memory corruption or
+  system instability.
+
+  To select the interface to act on, write the network name to the following file:
+  `/sys/kernel/debug/fail_skb_realloc/devname`
+  If this field is left empty (which is the default value), skb reallocation
+  will be forced on all network interfaces.
+
+  The effectiveness of this fault detection is enhanced when KASAN is
+  enabled, as it helps identify invalid memory references and use-after-free
+  (UAF) issues.
+
 - NVMe fault injection
 
   inject NVMe status code and retry flag on devices permitted by setting
@@ -216,6 +242,19 @@ configuration of fault-injection capabilities.
 	use a negative errno, you better use 'printf' instead of 'echo', e.g.:
 	$ printf %#x -12 > retval
 
+- /sys/kernel/debug/fail_skb_realloc/devname:
+
+        Specifies the network interface on which to force SKB reallocation.  If
+        left empty, SKB reallocation will be applied to all network interfaces.
+
+        Example usage::
+
+          # Force skb reallocation on eth0
+          echo "eth0" > /sys/kernel/debug/fail_skb_realloc/devname
+
+          # Clear the selection and force skb reallocation on all interfaces
+          echo "" > /sys/kernel/debug/fail_skb_realloc/devname
+
 Boot option
 ^^^^^^^^^^^
 
@@ -227,6 +266,7 @@ use the boot option::
 	fail_usercopy=
 	fail_make_request=
 	fail_futex=
+	fail_skb_realloc=
 	mmc_core.fail_request=<interval>,<probability>,<space>,<times>
 
 proc entries
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 48f1e0fa2a13619e41dfba40f2593dd61f9b9a06..285e36a5e5d7806113a5eb8459ff4f32de5d1248 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2681,6 +2681,12 @@ static inline void skb_assert_len(struct sk_buff *skb)
 #endif /* CONFIG_DEBUG_NET */
 }
 
+#if defined(CONFIG_FAIL_SKB_REALLOC)
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
index 7312ae7c3cc57b9d7e12286b4218206811d9705b..67b669d2e70eb5ec5b956794ff2bccfe698db64a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2115,6 +2115,16 @@ config FAIL_SUNRPC
 	  Provide fault-injection capability for SunRPC and
 	  its consumers.
 
+config FAIL_SKB_REALLOC
+	bool "Fault-injection capability forcing skb to reallocate"
+	depends on FAULT_INJECTION_DEBUG_FS
+	help
+	  Provide fault-injection capability that forces the skb to be
+	  reallocated, catching possible invalid pointers to the skb.
+
+	  For more information, check
+	  Documentation/dev-tools/fault-injection/fault-injection.rst
+
 config FAULT_INJECTION_CONFIGFS
 	bool "Configfs interface for fault-injection capabilities"
 	depends on FAULT_INJECTION
diff --git a/net/core/Makefile b/net/core/Makefile
index 5a72a87ee0f1defed67a4f40f58553e592265279..d9326600e289beb83d98ab2652130c9e7a1a005e 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -46,3 +46,4 @@ obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
 obj-$(CONFIG_DEBUG_NET_SMALL_RTNL) += rtnl_net_debug.o
+obj-$(CONFIG_FAIL_SKB_REALLOC) += skb_fault_injection.o
diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
new file mode 100644
index 0000000000000000000000000000000000000000..4235db6bdfad55a9d7ed814542888b8319356c8e
--- /dev/null
+++ b/net/core/skb_fault_injection.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/debugfs.h>
+#include <linux/fault-inject.h>
+#include <linux/netdevice.h>
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
+static int __init fail_skb_realloc_setup(char *str)
+{
+	return setup_fault_attr(&skb_realloc.attr, str);
+}
+__setup("fail_skb_realloc=", fail_skb_realloc_setup);
+
+static void reset_settings(void)
+{
+	skb_realloc.filtered = false;
+	memset(&skb_realloc.devname, 0, IFNAMSIZ);
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
+
+	skb_realloc.devname[IFNAMSIZ - 1] = '\0';
+	/* Remove a possible \n at the end of devname */
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
+static int __init fail_skb_realloc_debugfs(void)
+{
+	umode_t mode = S_IFREG | 0600;
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_skb_realloc", NULL,
+					&skb_realloc.attr);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	debugfs_create_file("devname", mode, dir, NULL, &devname_ops);
+
+	return 0;
+}
+
+late_initcall(fail_skb_realloc_debugfs);

---
base-commit: dbb9a7ef347828870df3e5e6ddf19469a3277fc9
change-id: 20241101-skb_fault_injection_v5-6f3b6a5f4dc9

Best regards,
-- 
Breno Leitao <leitao@debian.org>


