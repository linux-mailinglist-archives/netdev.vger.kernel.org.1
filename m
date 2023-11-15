Return-Path: <netdev+bounces-48148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C6F7ECA35
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9061B28150D
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F623DBAC;
	Wed, 15 Nov 2023 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4E5D44
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:05:27 -0800 (PST)
Received: from kero.packetmixer.de (p200300FA2706340047BD8a14B9c54dBB.dip0.t-ipconnect.de [IPv6:2003:fa:2706:3400:47bd:8a14:b9c5:4dbb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 08D8BFB606;
	Wed, 15 Nov 2023 18:59:49 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 6/6] batman-adv: Switch to linux/array_size.h
Date: Wed, 15 Nov 2023 18:59:32 +0100
Message-Id: <20231115175932.127605-7-sw@simonwunderlich.de>
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

The commit 3cd39bc3b11b ("kernel.h: Move ARRAY_SIZE() to a separate
header") introduced a new header for the ARRAY_SIZE macro which was
previously exposed via linux/kernel.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c    | 2 +-
 net/batman-adv/netlink.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e8c25583a127..5fc754b0b3f7 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -6,6 +6,7 @@
 
 #include "main.h"
 
+#include <linux/array_size.h>
 #include <linux/atomic.h>
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
@@ -20,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/list.h>
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 0c64d81a7761..1f7ed9d4f6fd 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -7,6 +7,7 @@
 #include "netlink.h"
 #include "main.h"
 
+#include <linux/array_size.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -20,7 +21,6 @@
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/minmax.h>
-- 
2.39.2


