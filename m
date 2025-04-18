Return-Path: <netdev+bounces-184008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C3A92F15
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867CD4670EA
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428126AF6;
	Fri, 18 Apr 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GEKxZxYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383BBE49;
	Fri, 18 Apr 2025 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744938931; cv=none; b=Zyx1lrrs1hdpRWH68nYUUjrsvvrFXPu4tFVhahYLDGgj6wJEeQRA8pfUKjJtWHPatTZQemNWVBHhs3Ii9Ayd6tAdwPV+jXsnFtEnOYj/kuSOc8DA4KfJQ+Dwk1Jazn1DbiORIKyZ2Zn70kQCO0Qj53aWAJ71jaTkv73fyLBn5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744938931; c=relaxed/simple;
	bh=VHf8JfBG6AIoLMfm+JSl6V4eo0qP+ziJCJ0wLtn4u/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XesswhwZG2nTfATEuakCsTVhLdXW32THPEjfXKKcUuQs9Y4yvDFrg+WchVK2V9aGXxF2fJLP5qddRzYELjunn9w4a7l5l9w/Klc5GF8ivPt0vluCKJj/NWyJ2L/EejeIiQGE79ZC4cDdH6B6VpIi5awKYvNUCiQUG6KRnlhqcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GEKxZxYJ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Ji+yj+AT7eFH1RjLEA2qeCEdj1vp5fWP0T4sC6IhspM=; b=GEKxZxYJ95tenjTs
	BTjgOaQ1XLlaOmFqRAaWhYuh3j9LK8pp73IfCRf6Y2y7y7MtukjdgN8Wb8623r0GmaFu337S1CdKo
	o3LBBVE7pPbvA9Ile9f/X6K3ER1q9tck86S2W5PBdmpQsoI4aQbonwKeRscR0qby0CsxJAaB0NPqq
	HtlIYsN8N+Vx440c0TaakWjrfCx9DqdgE9940rfw3QXID94h80XIFpepOuJOPFOdVWB2EevKH2khr
	2RaxwFBLpwq/QcmmnF+ncdC2gitfXb9Wum01g7HJbjKA4ZBXYtVqER4yeA2xqrwZW+d0QgE7VYxwP
	ziGR6z/6TC+ZmvkZ4g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u5aKA-00CQ62-13;
	Fri, 18 Apr 2025 01:15:22 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net: 802: Remove unused p8022 code
Date: Fri, 18 Apr 2025 02:15:19 +0100
Message-ID: <20250418011519.145320-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

p8022.c defines two external functions, register_8022_client()
and unregister_8022_client(), the last use of which was removed in
2018 by
commit 7a2e838d28cf ("staging: ipx: delete it from the tree")

Remove the p8022.c file, it's corresponding header, and glue
surrounding it.  There was one place the header was included in vlan.c
but it didn't use the functions it declared.

There was a comment in net/802/Makefile about checking
against net/core/Makefile, but that's at least 20 years old and
there's no sign of net/core/Makefile mentioning it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/p8022.h | 16 ------------
 net/802/Makefile    |  5 ++--
 net/802/p8022.c     | 64 ---------------------------------------------
 net/8021q/vlan.c    |  1 -
 4 files changed, 2 insertions(+), 84 deletions(-)
 delete mode 100644 include/net/p8022.h
 delete mode 100644 net/802/p8022.c

diff --git a/include/net/p8022.h b/include/net/p8022.h
deleted file mode 100644
index a29e224ac498..000000000000
--- a/include/net/p8022.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NET_P8022_H
-#define _NET_P8022_H
-
-struct net_device;
-struct packet_type;
-struct sk_buff;
-
-struct datalink_proto *
-register_8022_client(unsigned char type,
-		     int (*func)(struct sk_buff *skb,
-				 struct net_device *dev,
-				 struct packet_type *pt,
-				 struct net_device *orig_dev));
-void unregister_8022_client(struct datalink_proto *proto);
-#endif
diff --git a/net/802/Makefile b/net/802/Makefile
index bfed80221b8b..99abc29d537c 100644
--- a/net/802/Makefile
+++ b/net/802/Makefile
@@ -3,12 +3,11 @@
 # Makefile for the Linux 802.x protocol layers.
 #
 
-# Check the p8022 selections against net/core/Makefile.
-obj-$(CONFIG_LLC)	+= p8022.o psnap.o
+obj-$(CONFIG_LLC)	+= psnap.o
 obj-$(CONFIG_NET_FC)	+=                 fc.o
 obj-$(CONFIG_FDDI)	+=                 fddi.o
 obj-$(CONFIG_HIPPI)	+=                 hippi.o
-obj-$(CONFIG_ATALK)	+= p8022.o psnap.o
+obj-$(CONFIG_ATALK)	+= psnap.o
 obj-$(CONFIG_STP)	+= stp.o
 obj-$(CONFIG_GARP)	+= garp.o
 obj-$(CONFIG_MRP)	+= mrp.o
diff --git a/net/802/p8022.c b/net/802/p8022.c
deleted file mode 100644
index 78c25168d7c9..000000000000
--- a/net/802/p8022.c
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *	NET3:	Support for 802.2 demultiplexing off Ethernet
- *
- *		Demultiplex 802.2 encoded protocols. We match the entry by the
- *		SSAP/DSAP pair and then deliver to the registered datalink that
- *		matches. The control byte is ignored and handling of such items
- *		is up to the routine passed the frame.
- *
- *		Unlike the 802.3 datalink we have a list of 802.2 entries as
- *		there are multiple protocols to demux. The list is currently
- *		short (3 or 4 entries at most). The current demux assumes this.
- */
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <linux/slab.h>
-#include <net/datalink.h>
-#include <linux/mm.h>
-#include <linux/in.h>
-#include <linux/init.h>
-#include <net/llc.h>
-#include <net/p8022.h>
-
-static int p8022_request(struct datalink_proto *dl, struct sk_buff *skb,
-			 const unsigned char *dest)
-{
-	llc_build_and_send_ui_pkt(dl->sap, skb, dest, dl->sap->laddr.lsap);
-	return 0;
-}
-
-struct datalink_proto *register_8022_client(unsigned char type,
-					    int (*func)(struct sk_buff *skb,
-							struct net_device *dev,
-							struct packet_type *pt,
-							struct net_device *orig_dev))
-{
-	struct datalink_proto *proto;
-
-	proto = kmalloc(sizeof(*proto), GFP_ATOMIC);
-	if (proto) {
-		proto->type[0]		= type;
-		proto->header_length	= 3;
-		proto->request		= p8022_request;
-		proto->sap = llc_sap_open(type, func);
-		if (!proto->sap) {
-			kfree(proto);
-			proto = NULL;
-		}
-	}
-	return proto;
-}
-
-void unregister_8022_client(struct datalink_proto *proto)
-{
-	llc_sap_put(proto->sap);
-	kfree(proto);
-}
-
-EXPORT_SYMBOL(register_8022_client);
-EXPORT_SYMBOL(unregister_8022_client);
-
-MODULE_DESCRIPTION("Support for 802.2 demultiplexing off Ethernet");
-MODULE_LICENSE("GPL");
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 41be38264493..06908e37c3d9 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
-#include <net/p8022.h>
 #include <net/arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/notifier.h>
-- 
2.49.0


