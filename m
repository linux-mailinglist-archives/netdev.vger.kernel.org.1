Return-Path: <netdev+bounces-130385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBCF98A50D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF581C214C9
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4F18FDCE;
	Mon, 30 Sep 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ELXANkFh"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B02AE8E;
	Mon, 30 Sep 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703004; cv=none; b=Vf2jFPl2vZb/uYokeOTvOiAwxY54ru7w+9JJ8l6ER9646CPMWbaJ5Mp5lzEZ/qpfMglVszIkrixcAL73IUi0wQN/T3F9voW27S44R83lHnxcLr4Jh2BBv4KLVuu5MO31sCTZz1PVRGNOWwqxQIw97voMbXQLTQXuN50ZF3dgOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703004; c=relaxed/simple;
	bh=1L/OdZOYzihyBZ8iWjDHXXTLkYr0K1ESnol75f87IN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udd7xhdiRmzAnBoYGI8Z9xZQjXk1saPyKdHF6QWzPl9H/wpqc2Ks3h3b/kb5KjfTUH53a8lxsQcxCDVFc/9NfxltvofTS0y02pjlRzhWN5AgUZMlYoRD+idK/CQUYiJMbjFqUxn5uLj6IcOKxY2Tc47HCj2/sRktUMgIpUlIzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ELXANkFh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=d2J3hptl9JSPtcZnGVTo57UhG3UXBHxQTz1e3Wd4U+U=; b=ELXANkFhQxiEp8Ao
	GHMW9fUKy/KNYqv+gbaQr/s/PYSNPc84PAgSRSRZR0mQ/QqZH27k7wKZdriU2yxC3jf1hsKV3HyAL
	hpcI0wf2NL8jqGeLEQgsl8QYy44pPzpBlafkvop0ZTfEiBXgT5IBBjjoFSsBveRFWxX5EMXjFrJ41
	I9851esQO3NW7q45sHPQ++eifCqBRerDdPYHE/7jwhorJgRCkS4epNwDm68Q3NFEDwrb/t1qpASvD
	HAYYLPGj8nrmTWBj0It1GEjt9q6S+zSYO+oiIgqzz8u12RQyFYQelcJdXOGqHd7CE2flgxzvYDJC6
	tGVSVJL3er3XY9RXww==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1svGTL-007ylV-2b;
	Mon, 30 Sep 2024 13:29:55 +0000
From: linux@treblig.org
To: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] appletalk: Remove deadcode
Date: Mon, 30 Sep 2024 14:29:53 +0100
Message-ID: <20240930132953.46962-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

alloc_ltalkdev in net/appletalk/dev.c is dead since
commit 00f3696f7555 ("net: appletalk: remove cops support")

Removing it (and it's helper) leaves dev.c and if_ltalk.h empty;
remove them and the Makefile entry.

tun.c was including that if_ltalk.h but actually wanted
the uapi version for LTALK_ALEN, fix up the path.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c        |  2 +-
 include/linux/if_ltalk.h |  8 -------
 net/appletalk/Makefile   |  2 +-
 net/appletalk/dev.c      | 46 ----------------------------------------
 4 files changed, 2 insertions(+), 56 deletions(-)
 delete mode 100644 include/linux/if_ltalk.h
 delete mode 100644 net/appletalk/dev.c

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9a0f6eb32016..d7a865ef370b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -71,7 +71,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/mutex.h>
 #include <linux/ieee802154.h>
-#include <linux/if_ltalk.h>
+#include <uapi/linux/if_ltalk.h>
 #include <uapi/linux/if_fddi.h>
 #include <uapi/linux/if_hippi.h>
 #include <uapi/linux/if_fc.h>
diff --git a/include/linux/if_ltalk.h b/include/linux/if_ltalk.h
deleted file mode 100644
index 4cc1c0b77870..000000000000
--- a/include/linux/if_ltalk.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_LTALK_H
-#define __LINUX_LTALK_H
-
-#include <uapi/linux/if_ltalk.h>
-
-extern struct net_device *alloc_ltalkdev(int sizeof_priv);
-#endif
diff --git a/net/appletalk/Makefile b/net/appletalk/Makefile
index 33164d972d37..152312a15180 100644
--- a/net/appletalk/Makefile
+++ b/net/appletalk/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_ATALK) += appletalk.o
 
-appletalk-y			:= aarp.o ddp.o dev.o
+appletalk-y			:= aarp.o ddp.o
 appletalk-$(CONFIG_PROC_FS)	+= atalk_proc.o
 appletalk-$(CONFIG_SYSCTL)	+= sysctl_net_atalk.o
diff --git a/net/appletalk/dev.c b/net/appletalk/dev.c
deleted file mode 100644
index 284c8e585533..000000000000
--- a/net/appletalk/dev.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Moved here from drivers/net/net_init.c, which is:
- *	Written 1993,1994,1995 by Donald Becker.
- */
-
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/if_arp.h>
-#include <linux/if_ltalk.h>
-
-static void ltalk_setup(struct net_device *dev)
-{
-	/* Fill in the fields of the device structure with localtalk-generic values. */
-
-	dev->type		= ARPHRD_LOCALTLK;
-	dev->hard_header_len 	= LTALK_HLEN;
-	dev->mtu		= LTALK_MTU;
-	dev->addr_len		= LTALK_ALEN;
-	dev->tx_queue_len	= 10;
-
-	dev->broadcast[0]	= 0xFF;
-
-	dev->flags		= IFF_BROADCAST|IFF_MULTICAST|IFF_NOARP;
-}
-
-/**
- * alloc_ltalkdev - Allocates and sets up an localtalk device
- * @sizeof_priv: Size of additional driver-private structure to be allocated
- *	for this localtalk device
- *
- * Fill in the fields of the device structure with localtalk-generic
- * values. Basically does everything except registering the device.
- *
- * Constructs a new net device, complete with a private data area of
- * size @sizeof_priv.  A 32-byte (not bit) alignment is enforced for
- * this private data area.
- */
-
-struct net_device *alloc_ltalkdev(int sizeof_priv)
-{
-	return alloc_netdev(sizeof_priv, "lt%d", NET_NAME_UNKNOWN,
-			    ltalk_setup);
-}
-EXPORT_SYMBOL(alloc_ltalkdev);
-- 
2.46.2


