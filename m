Return-Path: <netdev+bounces-78985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3437587734D
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 19:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FD51C20DE2
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBD482F2;
	Sat,  9 Mar 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub98/+79"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A0482DB
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009306; cv=none; b=obUKtW4TL8erkWaYg+EVo3xxUq36lPCkimjS/993uWD/ySbJoFgaiDzuO1l+ODxcil8mBmbubOeQ0MT95zoLbnFfGaR/tXsTBPgIgYx+h7chWNNQI/kCJh7PBiyA02kJDiSo6dJIJzRNEkD04j2y0B9hs4xREiPYja40QK7X1VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009306; c=relaxed/simple;
	bh=CaI6XbzfSVP/ZZNSkSOFjhFSN4voXtlNtdxFfrr0ITo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g82nJjdwK2kKGs/GhgjhCcO76aP/chj+MXvfZTNpTHA3+M6WcgxFM/GB4nXVTeYykpFV7LVMYwL2/Ibb27ZIjVDS5PmOdm8SCAzW2tb+ttsDUsLiWxLKw2nyAW0BW0BJegnurBo/AaRDndbJbFABO82b+2hdmlMAucbf1oTeHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub98/+79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85EDC433F1;
	Sat,  9 Mar 2024 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009306;
	bh=CaI6XbzfSVP/ZZNSkSOFjhFSN4voXtlNtdxFfrr0ITo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ub98/+79m+EDIF2EZVpFotXwqppx3/lmkCZNEnriQzRLs7jTC51D1ofRQB+czM+fA
	 mDdztIG70eS4k584BKdqnLEAB9eI+5HNDuT0w7fQ2Ts8jn5+ntdSCa3oUFZBwmgEcL
	 kPEAIe5p1T/9evZxHt7OMscT6x217A9VVPg9aLObmv6sHzEf7tSzEb4fikM6NtE6Vn
	 gMF1ZFm2h9Tj2aKthTVZ+bKv3UKqa7D7egT0cHi58S8RWW0OtQ9v2im+W3m0G5PRHo
	 HzoEqwQG65YGUq4WSsasZyMBHwQLYscl5tuZeD+0ebGVz76k46TsVHce3r0mokgjC2
	 JXKamOS+Ar/CQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>,
	Jason@zx2c4.com,
	mareklindner@neomailbox.ch,
	sw@simonwunderlich.de,
	a@unstable.cc,
	sven@narfation.org,
	pshelar@ovn.org,
	andriy.shevchenko@linux.intel.com,
	wireguard@lists.zx2c4.com,
	dev@openvswitch.org
Subject: [PATCH net-next 3/3] genetlink: remove linux/genetlink.h
Date: Sat,  9 Mar 2024 10:34:58 -0800
Message-ID: <20240309183458.3014713-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240309183458.3014713-1-kuba@kernel.org>
References: <20240309183458.3014713-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

genetlink.h is a shell of what used to be a combined uAPI
and kernel header over a decade ago. It has fewer than
10 lines of code. Merge it into net/genetlink.h.
In some ways it'd be better to keep the combined header
under linux/ but it would make looking through git history
harder.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Jason@zx2c4.com
CC: mareklindner@neomailbox.ch
CC: sw@simonwunderlich.de
CC: a@unstable.cc
CC: sven@narfation.org
CC: pshelar@ovn.org
CC: andriy.shevchenko@linux.intel.com
CC: wireguard@lists.zx2c4.com
CC: dev@openvswitch.org
---
 drivers/net/wireguard/main.c      |  2 +-
 include/linux/genetlink.h         | 14 --------------
 include/linux/genl_magic_struct.h |  2 +-
 include/net/genetlink.h           |  9 ++++++++-
 net/batman-adv/main.c             |  2 +-
 net/batman-adv/netlink.c          |  1 -
 net/openvswitch/datapath.c        |  1 -
 7 files changed, 11 insertions(+), 20 deletions(-)
 delete mode 100644 include/linux/genetlink.h

diff --git a/drivers/net/wireguard/main.c b/drivers/net/wireguard/main.c
index ee4da9ab8013..a00671b58701 100644
--- a/drivers/net/wireguard/main.c
+++ b/drivers/net/wireguard/main.c
@@ -14,7 +14,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/genetlink.h>
+#include <net/genetlink.h>
 #include <net/rtnetlink.h>
 
 static int __init wg_mod_init(void)
diff --git a/include/linux/genetlink.h b/include/linux/genetlink.h
deleted file mode 100644
index 9dbd7ba9b858..000000000000
--- a/include/linux/genetlink.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_GENERIC_NETLINK_H
-#define __LINUX_GENERIC_NETLINK_H
-
-#include <uapi/linux/genetlink.h>
-
-/* All generic netlink requests are serialized by a global lock.  */
-extern void genl_lock(void);
-extern void genl_unlock(void);
-
-#define MODULE_ALIAS_GENL_FAMILY(family)\
- MODULE_ALIAS_NET_PF_PROTO_NAME(PF_NETLINK, NETLINK_GENERIC, "-family-" family)
-
-#endif	/* __LINUX_GENERIC_NETLINK_H */
diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index a419d93789ff..621b87a87d74 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -15,8 +15,8 @@
 #endif
 
 #include <linux/args.h>
-#include <linux/genetlink.h>
 #include <linux/types.h>
+#include <net/genetlink.h>
 
 extern int CONCATENATE(GENL_MAGIC_FAMILY, _genl_register)(void);
 extern void CONCATENATE(GENL_MAGIC_FAMILY, _genl_unregister)(void);
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 9ece6e5a3ea8..090aa3e36ce3 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -2,12 +2,19 @@
 #ifndef __NET_GENERIC_NETLINK_H
 #define __NET_GENERIC_NETLINK_H
 
-#include <linux/genetlink.h>
+#include <uapi/linux/genetlink.h>
 #include <net/netlink.h>
 #include <net/net_namespace.h>
 
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 
+/* All generic netlink requests are serialized by a global lock.  */
+extern void genl_lock(void);
+extern void genl_unlock(void);
+
+#define MODULE_ALIAS_GENL_FAMILY(family) \
+ MODULE_ALIAS_NET_PF_PROTO_NAME(PF_NETLINK, NETLINK_GENERIC, "-family-" family)
+
 /* Binding to multicast group requires %CAP_NET_ADMIN */
 #define GENL_MCAST_CAP_NET_ADMIN	BIT(0)
 /* Binding to multicast group requires %CAP_SYS_ADMIN */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 75119f1ffccc..8e0f44c71696 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -14,7 +14,6 @@
 #include <linux/crc32c.h>
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/genetlink.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
@@ -38,6 +37,7 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
+#include <net/genetlink.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 0954757f0b8b..9362cd9d6f3d 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -15,7 +15,6 @@
 #include <linux/cache.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/genetlink.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 11c69415c605..99d72543abd3 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/etherdevice.h>
-#include <linux/genetlink.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
-- 
2.44.0


