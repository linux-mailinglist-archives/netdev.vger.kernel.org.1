Return-Path: <netdev+bounces-293737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHvAHrZ+HWpDbQkAu9opvQ
	(envelope-from <netdev+bounces-293737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:44:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEB461F798
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4821306FC37
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0CF37B402;
	Mon,  1 Jun 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="bujwBLA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8558B379987
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317413; cv=none; b=Owf6S8O3Q66XUDpwUIK3h0vXoNqpENzH6yc7wYonQonH5/sG4kIBKR2MKLC/mrTL9E9q8F2+r3JEv5mXjuK1hzFfgcpM93b/clspjQ58/uDJGuMOYmqAiCHXNwE8NH7nbz8sd6znAjYfSOjLgv+qn1qUEe6/LAa+eQ7MTKpdPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317413; c=relaxed/simple;
	bh=ktMH8V694H6OZCOj4QnG+XzZn3Q7+vcPL5I3PX05EG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmiY0/61Y3F2fl7lft5ez4NKWnAE0cErNjG+Ej85aBWUEHlzKs6T7wVQwgU3UhOp57xcisoo4VPvbst6SDZXWDmiEHczi5LYYaYNv3tkqLMrZ4obgH1YLrdcn7KgA0BsqiDQV5kLb9FLpuIt6K9oq8xNe0KeRNGnxf6DRKx1FTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=bujwBLA2; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yp/Xnj4hCfTUVqMv2VJy6JybAPXxCdd9ZKa9fvVgolM=;
	b=bujwBLA22/4J4QnCYH51HUFM8LWsbe6Us+QFp+ZJZNUgkOPu8zgaxTOyHo/Y5xOfv+41fF
	lnJolyiSOIQXjq3sQ3jfyRipdtmAxQxMhPxPMNfyQRg65AlDy3oSPKp6uNlrHD2A5ej7h8
	F38StW6+IgdNyMTy8eGU+cU4R3ls5iHpzyUtjcR68v3TZjCkXXFBSlVYGWKBu7TrpV8Fjq
	Nil27il2VARGyODLmO5ItKWQbIx6Y8QUACIOQQYjLN7gkDZ322DAg35ODDe+WydPfC/eaN
	lNk9QQ8ZCV/5OApDA0zhQmFryLQbLx2oPpmIRjpwcnv+8hEdxYidLV4vuqekSg==
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
Subject: [PATCH net-next v2 01/15] batman-adv: drop batman-adv specific version
Date: Mon,  1 Jun 2026 14:36:15 +0200
Message-ID: <20260601123629.707089-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293737-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Queue-Id: EDEB461F798
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

Bumping the version number on the first pull request after each merge
window was deemed inappropriate for an in-tree component. The version
number carries little meaningful information in the context of the Linux
kernel release model, where stable and distribution might all carry
slightly different patches (without any change to the batman-adv version).

Instead, expose a UTS_RELEASE-based string to consumers of the netlink and
ethtool interfaces. To avoid recompilation for each (re)generate of
generated/utsrelease.h, init_utsname()->release is used in code which can
dynamically retrieve the version string. The MODULE_VERSION is moved to a
separate file because it doesn't support dynamic retrieval of the version
string (but constant "at compile time" string) and it is required for the
/sys/module/batman_adv/version. The latter is unfortunately still required
by userspace tools.

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
 net/batman-adv/version.c        | 12 ++++++++++++
 6 files changed, 19 insertions(+), 8 deletions(-)
 create mode 100644 net/batman-adv/version.c

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
index a4d33ee0fda59..82bba34893788 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -33,6 +33,7 @@
 #include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/utsname.h>
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
 #include <net/genetlink.h>
@@ -112,7 +113,7 @@ static int __init batadv_init(void)
 	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
-		BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
+		init_utsname()->release, BATADV_COMPAT_VERSION);
 
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
index e7aa45bc6b7ad..f25b861029575 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -36,6 +36,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/utsname.h>
 #include <net/netlink.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/batadv_packet.h>
@@ -892,7 +893,7 @@ static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
 	strscpy(info->driver, "B.A.T.M.A.N. advanced", sizeof(info->driver));
-	strscpy(info->version, BATADV_SOURCE_VERSION, sizeof(info->version));
+	strscpy(info->version, init_utsname()->release, sizeof(info->version));
 	strscpy(info->fw_version, "N/A", sizeof(info->fw_version));
 	strscpy(info->bus_info, "batman", sizeof(info->bus_info));
 }
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 78c651f634cd3..b30f018740fcc 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -28,6 +28,7 @@
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/utsname.h>
 #include <net/genetlink.h>
 #include <net/net_namespace.h>
 #include <net/netlink.h>
@@ -233,7 +234,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (!hdr)
 		return -ENOBUFS;
 
-	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
+	if (nla_put_string(msg, BATADV_ATTR_VERSION, init_utsname()->release) ||
 	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
 			   bat_priv->algo_ops->name) ||
 	    nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, mesh_iface->ifindex) ||
diff --git a/net/batman-adv/version.c b/net/batman-adv/version.c
new file mode 100644
index 0000000000000..2b8006fe85b56
--- /dev/null
+++ b/net/batman-adv/version.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <generated/utsrelease.h>
+#include <linux/module.h>
+
+/* WARNING userspace tools like batctl were relying on
+ * /sys/module/batman_adv/version to check if the module was loaded. If it
+ * isn't present, they usually error out before finishing setup of the batadv
+ * interface. It should be kept until it is unlikely that there are active
+ * installations of these "broken" versions of these tools with recent kernels.
+ */
+MODULE_VERSION(UTS_RELEASE);
-- 
2.47.3


