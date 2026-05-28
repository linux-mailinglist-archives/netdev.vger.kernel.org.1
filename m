Return-Path: <netdev+bounces-292731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II0DHUBTGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:37:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A295F3CE5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C5EC3065F02
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1493F4136;
	Thu, 28 May 2026 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="XuReeURn"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876333BED23
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978910; cv=none; b=JjnhAtNEbKd9Q3R7/M8w6NyFczVbU82kl7cAbwilK3IFuobj0Zv4b1t3K98k+TcBfC+PaJ7XUplRIRm07siBW48Og2kA4U0fE+0YWvp7+Hk5hGjYeGJEAjZTgs4Wubr3Tkl+jVAiQJOo1MqAxD7kY9nlJFWJJP9O4pJz5Yq6iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978910; c=relaxed/simple;
	bh=XNTSkg+bBW8/pBC6yz0mPB/ASpmtLjmqGELiKKk9XtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2LgMpay1v0RRr3wKeoyYb8fl26pDxrjMHceaWr+CS4A1nYGzzL3k5WFXrd1JSefMH0DK6nS4AlGEoIIAEyceEDdnlyFwxOEmLVFFhFyLvi6BSRhpty8D0g/vm6BUPX+JYBy6L3+laxDjHlKkP6XvG7O6bb2+nFJewT2Dh2Otgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=XuReeURn; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWv8MafdPzKxu026SvAgMIOfMz0Utuf87oDhnSVFpeA=;
	b=XuReeURnPmos9GVoiIehsZ4NOFQyIXEOLSxJKjVMjf2AbmHFaOzxdtyQohk8M3YIGCC1IC
	b0ZmpNPdb+s6UMYfOisArRdF55wpoRpL4u9RBmTyS0ZCBw1nB0ixHFYnjkGj70e6vcbSlU
	LCfVdxHvLx8i203DNqu3Scr9hRAkNdMmGoMhiGs28eWgX8jpWx1CAjIBTi0bupI9LYKc1u
	Zaqgmt9k60yKwQV9fX55tJ00HkFKYVbokzXil2eC/Jqo6VuvbCDYg/o+9rcBv3WoGpD5df
	wsp9wyTkuK6Am/EKnpF8rRNij5GBkOM1LFYB73g3Pi4kXKptF2sxsNOQ4mOMbQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/15] batman-adv: drop batman-adv specific version
Date: Thu, 28 May 2026 16:29:10 +0200
Message-ID: <20260528142924.329658-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292731-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 20A295F3CE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

Bumping the version number on the first pull request after each merge
window was deemed inappropriate for an in-tree component. The version
number carries little meaningful information in the context of the Linux
kernel release model, where stable and distribution might all carry
slightly different patches (without any change to the batman-adv version).

Instead, expose a UTS_RELEASE-based string to consumers of the netlink
and ethtool interfaces. But keep it in a separate file to avoid whole
batman-adv recompilations when generated/utsrelease.h is recreated.

Link: https://lore.kernel.org/r/20210203163302.13e8a2a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
Link: https://lore.kernel.org/r/YnfjtpuAaH+Zkf9S@unreal
Link: https://lore.kernel.org/r/Y9faTA0rNSXg%2FsLD@nanopsycho
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Makefile         |  1 +
 net/batman-adv/main.c           |  4 ++--
 net/batman-adv/main.h           |  4 ----
 net/batman-adv/mesh-interface.c |  3 ++-
 net/batman-adv/netlink.c        |  3 ++-
 net/batman-adv/version.c        | 18 ++++++++++++++++++
 net/batman-adv/version.h        |  8 ++++++++
 7 files changed, 33 insertions(+), 8 deletions(-)
 create mode 100644 net/batman-adv/version.c
 create mode 100644 net/batman-adv/version.h

diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index d3c4d4143c144..5d7456f1240d7 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -30,5 +30,6 @@ batman-adv-$(CONFIG_BATMAN_ADV_TRACING) += trace.o
 batman-adv-y += tp_meter.o
 batman-adv-y += translation-table.o
 batman-adv-y += tvlv.o
+batman-adv-y += version.o
 
 CFLAGS_trace.o := -I$(src)
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a4d33ee0fda59..b7acccdf3ce05 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -57,6 +57,7 @@
 #include "send.h"
 #include "tp_meter.h"
 #include "translation-table.h"
+#include "version.h"
 
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
  * list traversals just rcu-locked
@@ -112,7 +113,7 @@ static int __init batadv_init(void)
 	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
-		BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
+		batadv_version, BATADV_COMPAT_VERSION);
 
 	return 0;
 
@@ -684,6 +685,5 @@ MODULE_LICENSE("GPL");
 
 MODULE_AUTHOR(BATADV_DRIVER_AUTHOR);
 MODULE_DESCRIPTION(BATADV_DRIVER_DESC);
-MODULE_VERSION(BATADV_SOURCE_VERSION);
 MODULE_ALIAS_RTNL_LINK("batadv");
 MODULE_ALIAS_GENL_FAMILY(BATADV_NL_NAME);
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index af230b017bc17..f68fc8b7239cd 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -12,10 +12,6 @@
 #define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
-#ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2025.5"
-#endif
-
 /* B.A.T.M.A.N. parameters */
 
 #define BATADV_TQ_MAX_VALUE 255
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e7aa45bc6b7ad..a244f5425406b 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -49,6 +49,7 @@
 #include "multicast.h"
 #include "send.h"
 #include "translation-table.h"
+#include "version.h"
 
 /**
  * batadv_skb_head_push() - Increase header size and move (push) head pointer
@@ -892,7 +893,7 @@ static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
 	strscpy(info->driver, "B.A.T.M.A.N. advanced", sizeof(info->driver));
-	strscpy(info->version, BATADV_SOURCE_VERSION, sizeof(info->version));
+	strscpy(info->version, batadv_version, sizeof(info->version));
 	strscpy(info->fw_version, "N/A", sizeof(info->fw_version));
 	strscpy(info->bus_info, "batman", sizeof(info->bus_info));
 }
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 78c651f634cd3..8db29afeaa40b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -47,6 +47,7 @@
 #include "originator.h"
 #include "tp_meter.h"
 #include "translation-table.h"
+#include "version.h"
 
 struct genl_family batadv_netlink_family;
 
@@ -233,7 +234,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (!hdr)
 		return -ENOBUFS;
 
-	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
+	if (nla_put_string(msg, BATADV_ATTR_VERSION, batadv_version) ||
 	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
 			   bat_priv->algo_ops->name) ||
 	    nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, mesh_iface->ifindex) ||
diff --git a/net/batman-adv/version.c b/net/batman-adv/version.c
new file mode 100644
index 0000000000000..6a7c26e4bc945
--- /dev/null
+++ b/net/batman-adv/version.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "version.h"
+
+#include <generated/utsrelease.h>
+#include <linux/module.h>
+
+#define BATADV_SOURCE_VERSION "linux-" UTS_RELEASE
+
+const char *batadv_version = BATADV_SOURCE_VERSION;
+
+/* WARNING userspace tools like batctl were relying on
+ * /sys/module/batman_adv/version to check if the module was loaded. If it
+ * isn't present, they usually error out before finishing setup of the batadv
+ * interface. It should be kept until it is unlikely that there are active
+ * installations of these "broken" versions of these tools with recent kernels.
+ */
+MODULE_VERSION(BATADV_SOURCE_VERSION);
diff --git a/net/batman-adv/version.h b/net/batman-adv/version.h
new file mode 100644
index 0000000000000..d8af91f365ff9
--- /dev/null
+++ b/net/batman-adv/version.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _NET_BATMAN_ADV_VERSION_H_
+#define _NET_BATMAN_ADV_VERSION_H_
+
+extern const char *batadv_version;
+
+#endif /* _NET_BATMAN_ADV_VERSION_H_ */
-- 
2.47.3


