Return-Path: <netdev+bounces-110257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EDB92BA03
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792BAB26D67
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1015D5A6;
	Tue,  9 Jul 2024 12:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE815B115;
	Tue,  9 Jul 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529701; cv=none; b=b65CEOlzISOOun3831uGhAy3SvCufjWlpjDxU/o9oRdFiq/hNM+EC+5YCCPvQrVmieqD5ohjX5fYQ1DcTpZGRFzVYUDj7vQ0rXKRXG8BrHbrybeynCJHmz+ubUCOrUIO/R1ldvhWNR+EOhah/Swvw0jPJjL9xySgO+oqV5iIjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529701; c=relaxed/simple;
	bh=9PO3TWvq+waQ74u3npd7fq5+Cw0Zco4GaDHQdeBV0Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZXTBwyYq6RJfn64S7H+DmFfjS0buwOu3zDbharMRRksmSfhmkjEyU76r+oU367RSqjzlMhBlUNYRJZXgyWSIvHWmay9p3uH8gYwTro3E5qa/pYxxQL3bmVJcA4JmCPPUAIqJUCOTegX8nbmT0ISKJFOAfxOnjB5q2fFAfbuWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so70411001fa.2;
        Tue, 09 Jul 2024 05:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529697; x=1721134497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYRK+lWxc+A6Zv3ZqTk81Q6ZiXhb7j50T+TrH+WeHaE=;
        b=d4NzGO6xS4ApRQmhMJwCCCQpKGpI8ObQnMflBkpdCM0NwoCAJAgdK9cZXZG2cuOcYv
         XtCbxygYCahQq8Ai/S57OahdH4bcCMlqvXFmS692uh8PomighMgssJupzfGbuD5HZ9Dv
         sZgDxfgW3KjbN0Mej70VZntdBBObmHMR7T9wjYX6X1ggww1MN7fX+HZfiR+7gr2KUK1G
         Eg5dW/iZoxkRx1Ul36oUSJbflk5tVP5FsnPK7d1yytIdCWmwkfFhdHffvt4MHz+TRwWA
         JpDyLE93rjJXhCZdi2wtsdswbvUvBX5L5Iy0B7ZncVW7Rcyh2poyftY2M+lyHdsHUQrz
         w9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCX157WklpbOVIwGwZ5qJRWehoUfPH3R4fkCLxL7gkBLfZYhSo6Y55STsoqHiZvCtkELjUut978IoxTycYmffoQFuIce2fJa4VYX3SwUBAiNDWKkPoH/n4nm2oPT/VtB+MuQcGGLdH6A5/G/lFjL3x5MtrNl4Pm9pkndFzPUCqZh/3YqbIoB
X-Gm-Message-State: AOJu0YyFYRoZ++CcKP+nQSMCkx2KZVb+ZZZBp/l8CTdhyUOt3HaM6L5b
	LxuF09H71Y2uDTQByo72LqkHk4hKRleMRrmmx3qhC9XFFg7GBKcr
X-Google-Smtp-Source: AGHT+IGUIUE8izYvb7NUGi91NFWWGNLL6W16JszYvLUzOoMkkOlxPTldAWE3Wghrd/STmPVD3c0d0g==
X-Received: by 2002:a2e:9b0f:0:b0:2ee:8dce:2f92 with SMTP id 38308e7fff4ca-2eeb30ba7acmr21073781fa.1.1720529697040;
        Tue, 09 Jul 2024 05:54:57 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e157bsm76326766b.80.2024.07.09.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:54:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: keescook@chromium.org,
	horms@kernel.org,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] netdevice: define and allocate &net_device _properly_
Date: Tue,  9 Jul 2024 05:54:25 -0700
Message-ID: <20240709125433.4026177-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

In fact, this structure contains a flexible array at the end, but
historically its size, alignment etc., is calculated manually.
There are several instances of the structure embedded into other
structures, but also there's ongoing effort to remove them and we
could in the meantime declare &net_device properly.
Declare the array explicitly, use struct_size() and store the array
size inside the structure, so that __counted_by() can be applied.
Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
allocated buffer is aligned to what the user expects.
Also, change its alignment from %NETDEV_ALIGN to the cacheline size
as per several suggestions on the netdev ML.

bloat-o-meter for vmlinux:

free_netdev                                  445     440      -5
netdev_freemem                                24       -     -24
alloc_netdev_mqs                            1481    1450     -31

On x86_64 with several NICs of different vendors, I was never able to
get a &net_device pointer not aligned to the cacheline size after the
change.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
Changelog:

v2:
 * Rebased Alexander's patch on top of f750dfe825b90 ("ethtool: provide
   customized dim profile management").
 * Removed the ALIGN() of SMP_CACHE_BYTES for sizeof_priv.

v1:
 * https://lore.kernel.org/netdev/90fd7cd7-72dc-4df6-88ec-fbc8b64735ad@intel.com

 include/linux/netdevice.h | 12 +++++++-----
 net/core/dev.c            | 30 ++++++------------------------
 net/core/net-sysfs.c      |  2 +-
 3 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 93558645c6d0..f0dd499244d4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2199,10 +2199,10 @@ struct net_device {
 	unsigned short		neigh_priv_len;
 	unsigned short          dev_id;
 	unsigned short          dev_port;
-	unsigned short		padded;
+	int			irq;
+	u32			priv_len;
 
 	spinlock_t		addr_list_lock;
-	int			irq;
 
 	struct netdev_hw_addr_list	uc;
 	struct netdev_hw_addr_list	mc;
@@ -2406,7 +2406,10 @@ struct net_device {
 
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
-};
+
+	u8			priv[] ____cacheline_aligned
+				       __counted_by(priv_len);
+} ____cacheline_aligned;
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
 /*
@@ -2596,7 +2599,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
  */
 static inline void *netdev_priv(const struct net_device *dev)
 {
-	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
+	return (void *)dev->priv;
 }
 
 /* Set the sysfs physical device reference for the network logical device
@@ -3127,7 +3130,6 @@ static inline void unregister_netdevice(struct net_device *dev)
 
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
-void netdev_freemem(struct net_device *dev);
 void init_dummy_netdev(struct net_device *dev);
 
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
diff --git a/net/core/dev.c b/net/core/dev.c
index 73e5af6943c3..6ea1d20676fb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11006,13 +11006,6 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(netdev_sw_irq_coalesce_default_on);
 
-void netdev_freemem(struct net_device *dev)
-{
-	char *addr = (char *)dev - dev->padded;
-
-	kvfree(addr);
-}
-
 /**
  * alloc_netdev_mqs - allocate network device
  * @sizeof_priv: size of private data to allocate space for
@@ -11032,8 +11025,6 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
-	unsigned int alloc_size;
-	struct net_device *p;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11047,21 +11038,12 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		return NULL;
 	}
 
-	alloc_size = sizeof(struct net_device);
-	if (sizeof_priv) {
-		/* ensure 32-byte alignment of private area */
-		alloc_size = ALIGN(alloc_size, NETDEV_ALIGN);
-		alloc_size += sizeof_priv;
-	}
-	/* ensure 32-byte alignment of whole construct */
-	alloc_size += NETDEV_ALIGN - 1;
-
-	p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
-	if (!p)
+	dev = kvzalloc(struct_size(dev, priv, sizeof_priv),
+		       GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
+	if (!dev)
 		return NULL;
 
-	dev = PTR_ALIGN(p, NETDEV_ALIGN);
-	dev->padded = (char *)dev - (char *)p;
+	dev->priv_len = sizeof_priv;
 
 	ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);
 #ifdef CONFIG_PCPU_DEV_REFCNT
@@ -11148,7 +11130,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	free_percpu(dev->pcpu_refcnt);
 free_dev:
 #endif
-	netdev_freemem(dev);
+	kvfree(dev);
 	return NULL;
 }
 EXPORT_SYMBOL(alloc_netdev_mqs);
@@ -11203,7 +11185,7 @@ void free_netdev(struct net_device *dev)
 	/*  Compatibility with error handling in drivers */
 	if (dev->reg_state == NETREG_UNINITIALIZED ||
 	    dev->reg_state == NETREG_DUMMY) {
-		netdev_freemem(dev);
+		kvfree(dev);
 		return;
 	}
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 4c27a360c294..0e2084ce7b75 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -2028,7 +2028,7 @@ static void netdev_release(struct device *d)
 	 * device is dead and about to be freed.
 	 */
 	kfree(rcu_access_pointer(dev->ifalias));
-	netdev_freemem(dev);
+	kvfree(dev);
 }
 
 static const void *net_namespace(const struct device *d)
-- 
2.43.0


