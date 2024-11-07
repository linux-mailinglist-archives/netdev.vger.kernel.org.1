Return-Path: <netdev+bounces-142915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A7E9C0B11
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28E3B23413
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA9215F7F;
	Thu,  7 Nov 2024 16:11:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BE21501C;
	Thu,  7 Nov 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995916; cv=none; b=ImFHgNoo3wsh20XxFghLhCMS9roCzYGnzSDp7HrDdLUqUxKEBc/TaO8rJTXGbnQQJpxZ/IeLLp2O2VJ0DDzt6VVmrsszx6kUPP7NrPFZ7KGe18paeEJX2Go62ga74BYYuVKI2GmE5a81tgF7FHdsfllPz/CnM52jbtVN+g96lmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995916; c=relaxed/simple;
	bh=/9/uPu49+3bnF3DTFhGcMAkEWYVn7vqC5ihaYh6ApOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aWvbGWSbsKU848XfRJBiqVK3M8eixrPYLdMh523jWzEzijOKGbsNlcIBFZ3k7escdFP/z9XyepeGuNHcvKksazWH1LG9MeK8rboB8kREHtaulUtB9OHF+7/Ys3iVrniYWmn/uQf5i9g9n3sS/Dj5PyagKkFSvjj1sOORUp1FLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso153251966b.3;
        Thu, 07 Nov 2024 08:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995912; x=1731600712;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRiNAhT0N6yrPc48KsEAEvdVNmHALy/E7lcYQPYMppM=;
        b=o8YmgcGptovhaR1tHUoIehPom+ANw/KfY2U4t7Sd3kf8S2k56lXkf6uITe3WzHwmNa
         b2i/n/92IMx4R3UgXKhCW+fuTlxDkFXJ8pS8FQlLcHeAi6d5fBi1qlXGKNEIUA6h/vNM
         O3g8xb4mBWcsv3Y81tc3iSwba32oVVU38fTcVvrJ6UA5AY9t28kzzsab38yi4PHBhkD7
         jK6AhDLcnyAkTTuJh3CQg9Td/U9TN5m27wt0ktQugpXPuppdXv8I83+0vBahcAXOlU/b
         iD4Wa2ubn1bvH1bMpZJPFGmE2i+gvbHcKBMCROGeruXk/OIypZwCC1FoE/2R5tJt1aes
         qx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBMmI6jmPEQIe5VSugKiWDQ3NcHFfhuq9oxp13tKQ5CWlqIQRCz056nY9sQ2PmJ6OBIUfqkoSl@vger.kernel.org, AJvYcCUSEZY+e5m6/rbMPOjMQeqMOZbGni63KALRBAKQqtG3w04jBddQP4T71wpvtmfwZo2ylRqF7HMWUyLEwlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpEEuww8Dg4UWY4yAVGz7inkUAI4QEm1r7h+7+HSHRqioPC34
	+/OHlj0dQdgJG7CB3hxnMEnekr6eQanD7sQfCpTzXP5tAobAS4yW
X-Google-Smtp-Source: AGHT+IFXkJ+OtQt8oVoREFJGTjA0Az+TLLfu3cZdz92n9MR/nXyLT37AvTd4B4rdHz1aGJRevT/xJg==
X-Received: by 2002:a17:907:3e95:b0:a9e:b281:a55d with SMTP id a640c23a62f3a-a9eeb00b950mr55909566b.56.1730995912009;
        Thu, 07 Nov 2024 08:11:52 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a18b15sm111333166b.18.2024.11.07.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:11:51 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 Nov 2024 08:11:44 -0800
Subject: [PATCH net-next v6] net: Implement fault injection forcing skb
 reallocation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-fault_v6-v6-1-1b82cb6ecacd@debian.org>
X-B4-Tracking: v=1; b=H4sIAMDmLGcC/13OUYrCMBCA4auEee4sSWtTkyfvIVKmdqKzq6kmM
 Qji3Rd2RZa9wPf/D8ichDN49YDEVbIsEbyyjYL9keKBUWbwClrdrozRAwa6ncpYLZJmE5ymodM
 tNAouiYPcf6gtRC4Y+V5g1ygIaTljOSamv5TB/DWNv5zET94XWeJYe6w9GiTnrLNB07rvNjNPQ
 vFjSYdXKPH1JlnKq/Y+9erf5xvGwUxumGk16bX11cDu+fwGHWsqcv0AAAA=
X-Change-ID: 20241107-fault_v6-a0e1f90a7302
To: Jonathan Corbet <corbet@lwn.net>, Akinobu Mita <akinobu.mita@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12019; i=leitao@debian.org;
 h=from:subject:message-id; bh=/9/uPu49+3bnF3DTFhGcMAkEWYVn7vqC5ihaYh6ApOs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnLObGlVFCXohKunoUsQyNXh5+gMlbojbOnn4Kx
 OWIfvoyCPCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyzmxgAKCRA1o5Of/Hh3
 bZKRD/4ujXp3t07YDk3E647/PYvECpae5S9V8c18wB6jms9Iq6ZgVvYz8zSVDCwMZnTeqrNLSga
 22MrMIwbSNpFbDVdHG9rkrUG2Zzu5GrKK/F+m2K1IaWIKL+lP7cTi2qtL77b8VsiXl1DjjaB9YB
 9s6juOcxGvEucNnwNoBGsowEWsBX/P4wnDtWU/NzoBAHJj5KpvAlAB9F6TResFJYvwzcLvAZrRE
 v6Wtg+RbU6ANnHY6fF9a3GawCqKg7PdBBBaCXVuBDzkpfBGNL2MJ81lnJ6JyN0mVSO4GK1HRK6+
 yUeUNI3TJaW8VuBsehApeo+NlmNIfEsIsg8mPkO4yK09rumwMGvNat06NtRFvdpaHElhgnADpsX
 3ws9YvtGdaS/hvIiYbenosisyoYlPCtnDGX+zoV1lGSXMRQfRmXSvuGQDVUL2Gg+l8Hg0W88Y2A
 gBCgHgwlfiRR8AbzwdgdADIYgac3ZKXnduZtZdCPsiTuKb145hR3tUXroc+KIJzvDdNBfJsDvL9
 pjuaXXjKzsyZ5oI+R5CYMynE/ZXgV7SEq3BGQjAIiuaqkPtPgy8vH9m6s2HlphwbM/EH5XsXubi
 CfLI8zJDeAcA7LsH9J4M3YXlOEyZ+0CUyVieoyrOwW2mmJIW8F3ntiw/jZqfdPv1hLOAk86mxj1
 aq5akjNNdg8PTUg==
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
v6:
 * Improve the documentation (Bagas Sanjaya)

v5:
 * Updated the documentation to clarify the effectiveness of KASAN when
   used in conjunction with this feature (Jakub)
 * Fixed a typo in a comment (Jakub)
 * Reordered the imports in skb_fault_injection.c (Jakub)
 * Moved from memzero_explicit() to memset() (Jakub)
 * Zeroing skb_realloc.devname() at IFNAMSIZ-1 (Jakub)
 * https://lore.kernel.org/all/20241101-skb_fault_injection_v5-v5-1-a99696f0a853@debian.org/

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
index 9d6abbf8c3bec2db7cbd27a5f8871fdca71a865d..fca785176129fdc209848a25f138f38bb6d6a3a2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1553,6 +1553,7 @@
 	failslab=
 	fail_usercopy=
 	fail_page_alloc=
+	fail_skb_realloc=
 	fail_make_request=[KNL]
 			General fault injection mechanism.
 			Format: <interval>,<probability>,<space>,<times>
diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 8b8aeea71c685b358dfebb419ae74277e729298a..1c14ba08fbfc21e95e0dfb10af8e99324c5f4aca 100644
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
+  To select the interface to act on, write the network name to
+  /sys/kernel/debug/fail_skb_realloc/devname.
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
index 8899e70baf2a4bc36b299a7ccc3786b233163d9a..079aaa8034280fda5113148d81b2550f4e786d2a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2095,6 +2095,16 @@ config FAIL_SUNRPC
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
base-commit: 166d0a944094f53c74baafe48a119934c66854fa
change-id: 20241107-fault_v6-a0e1f90a7302
prerequisite-change-id: 20241107-fault_injection-71b97da4b086:v1

Best regards,
-- 
Breno Leitao <leitao@debian.org>


