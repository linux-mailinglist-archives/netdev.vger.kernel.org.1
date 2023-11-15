Return-Path: <netdev+bounces-48147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E97ECA34
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861DD1F27F85
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D77E3DBA7;
	Wed, 15 Nov 2023 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 10:05:27 PST
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D2BD41
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:05:27 -0800 (PST)
Received: from kero.packetmixer.de (p200300fa2706340047Bd8a14b9C54dbb.dip0.t-ipconnect.de [IPv6:2003:fa:2706:3400:47bd:8a14:b9c5:4dbb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C51C4FB602;
	Wed, 15 Nov 2023 18:59:47 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5/6] batman-adv: Switch to linux/sprintf.h
Date: Wed, 15 Nov 2023 18:59:31 +0100
Message-Id: <20231115175932.127605-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115175932.127605-1-sw@simonwunderlich.de>
References: <20231115175932.127605-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The commit 39ced19b9e60 ("lib/vsprintf: split out sprintf() and friends")
introduced a new header for the sprintf related functions which were
previously exposed via linux/kernel.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 net/batman-adv/gateway_client.c        | 2 +-
 net/batman-adv/main.c                  | 1 +
 net/batman-adv/multicast.c             | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 37ce6cfb3520..5f46ca3d4bb8 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -20,7 +20,6 @@
 #include <linux/if_vlan.h>
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -31,6 +30,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index d26124bc27e1..0ddd8b4b3f4c 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -18,7 +18,6 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -29,6 +28,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/udp.h>
 #include <net/sock.h>
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 50b2bf2b748c..e8c25583a127 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -33,6 +33,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 62288afdad49..d982daea8329 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -25,7 +25,6 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -36,6 +35,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
-- 
2.39.2


