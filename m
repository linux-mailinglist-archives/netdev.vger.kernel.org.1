Return-Path: <netdev+bounces-223511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D5AB59641
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7463B3F97
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43B2D73BA;
	Tue, 16 Sep 2025 12:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C428506C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025956; cv=none; b=IOzgFOE+xeZO+poX4ALsNwYFbOLeh7t+/YNdypXYTVP/bQRuUW5IoJ/MvIZCXziwthQmzIThoThl5ra8GaFu4AhbL6ojEjJ63CTp8pVumm4ufhiYVfribby7bjXzN5/R6WsKe3p2VNc7D4AKgMDIycRubY1VE0zQozBy0WYsOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025956; c=relaxed/simple;
	bh=eqasl4Gulv2tyL8V2MQuYRKQ8E4bI4e0PVmQe5uf65U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tByQz9M/cJZa66sqaLXHtAByZoInMPoPNFpsoV7Yvdj20SRzdlYB7bgMWJGu0jyJvOonp/JW68wj2Fxa/k7Qv0xiE7Bf0RjkrdrbiLDvC8mPILPZnM+f/VZewFbHnwnSzlLBfyHwBpLUNOmTHVG4ji/n5fpChEHvxYQTIBqH3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5972536D8604E0A64d0d3AAD8.dip0.t-ipconnect.de [IPv6:2003:c5:9725:36d8:604e:a64:d0d3:aad8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 81448FA1AE;
	Tue, 16 Sep 2025 14:24:52 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 4/4] batman-adv: remove includes for extern declarations
Date: Tue, 16 Sep 2025 14:24:41 +0200
Message-ID: <20250916122441.89246-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916122441.89246-1-sw@simonwunderlich.de>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

It is not necessary to include the header for the struct definition for an
"extern " declaration. It can simply be dropped from the headers to reduce
the number of includes the preprocessor has to process. If needed, it can
be added to the actual C source file.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 1 +
 net/batman-adv/hard-interface.h | 1 -
 net/batman-adv/mesh-interface.c | 1 +
 net/batman-adv/mesh-interface.h | 1 -
 net/batman-adv/netlink.h        | 1 -
 5 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bace57e4f9a51..5113f879736b5 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -22,6 +22,7 @@
 #include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
+#include <linux/notifier.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/rtnetlink.h>
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 262a783647427..9db8a310961ea 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -12,7 +12,6 @@
 #include <linux/compiler.h>
 #include <linux/kref.h>
 #include <linux/netdevice.h>
-#include <linux/notifier.h>
 #include <linux/rcupdate.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index be55d8d87348c..df7e95811ef56 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -37,6 +37,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <net/netlink.h>
+#include <net/rtnetlink.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
diff --git a/net/batman-adv/mesh-interface.h b/net/batman-adv/mesh-interface.h
index 7ba055b2bc269..53756c5a45e04 100644
--- a/net/batman-adv/mesh-interface.h
+++ b/net/batman-adv/mesh-interface.h
@@ -13,7 +13,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
-#include <net/rtnetlink.h>
 
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *mesh_iface,
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index fe4548b974bb0..4eae9e5ff1354 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -11,7 +11,6 @@
 
 #include <linux/netlink.h>
 #include <linux/types.h>
-#include <net/genetlink.h>
 
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
-- 
2.47.3


