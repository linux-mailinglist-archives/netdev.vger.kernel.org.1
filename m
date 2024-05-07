Return-Path: <netdev+bounces-94109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5D38BE258
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A0C1C239D7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE21215D5A1;
	Tue,  7 May 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBZ7dYSB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F56CDB1;
	Tue,  7 May 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085615; cv=none; b=ep+ZaE8DmVlz8HlmVNVqc73KWqMR4ROtGcdFFP9LSHelVHAcSBfXABzk1r4UgFYOiqHQHQTPaVFJ3zxxWgGN3zohnxiFT3RjTKH/nJsBEwcwDCWNS06HxhaNFjj82zWyYxhqzMGCdX/Cg/3Xw7X4wohiHs4caucavl3VJT0muAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085615; c=relaxed/simple;
	bh=m6vmFvUAC306G57ZtHT7Z0FTVplNYdcA1oCBDijt3C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcbRL6/UUony4ZJYD9wHsAer6UMH+sNF2okxiXDeHyMu2RXoXMBydodAWLFCvTuNV2RChaF9e/e1jf6QgmyBdZX1DGQ5AIwBdytTqQvEy65AvHEXzJU1DA6VtUiFSifoBxH8xgEKYgtT263r+IDoxrdAqxO4W5guHPSYGtybQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBZ7dYSB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715085614; x=1746621614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m6vmFvUAC306G57ZtHT7Z0FTVplNYdcA1oCBDijt3C8=;
  b=BBZ7dYSBYJK9cTxPtb/VS+zpaRlTm9EsRM8QTY/o4FIbC/W61tc/xwJg
   CNfSbkqASVmJ/U5Npc9jyyDPc+stu5DXpArP2IkkyRTKAH+KFOymChExf
   zZaSgb9INj1y5QMTjKRRX5h+pTZrxotqQCBBXon3oidKbYLf80UxH9bMJ
   N62nG83T/Tka+35k6+0Y60HFJbfgBIxI9DicU/A6GTR5jlJjL6AT7B0Ff
   Xn3REZEN5JWsXhQrsjEZg9LsRz6A66GLJ/wd+MQHEm2ib5wWOG9pAPXsE
   /U05oj2INjX3J2IJfvTiUihu5i0Nx4lzRfd0RUyt6LReph9okZx2sEVVs
   g==;
X-CSE-ConnectionGUID: uiZ8wSb6SIiepOcMNr++tg==
X-CSE-MsgGUID: rNufxRGWQtuCGXhTl4q8Ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11407721"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="11407721"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 05:40:13 -0700
X-CSE-ConnectionGUID: 2o0ommHuSKCVMv3q6Pheag==
X-CSE-MsgGUID: NWIEIjJ4SpmBbSVo3mJiNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33020096"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa003.fm.intel.com with ESMTP; 07 May 2024 05:40:10 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] netdevice: define and allocate &net_device _properly_
Date: Tue,  7 May 2024 14:39:37 +0200
Message-ID: <20240507123937.15364-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 include/linux/netdevice.h | 12 +++++++-----
 net/core/dev.c            | 31 +++++++------------------------
 net/core/net-sysfs.c      |  2 +-
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf261fb89d73..171d70618a70 100644
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
@@ -2403,7 +2403,10 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
-};
+
+	u8			priv[] ____cacheline_aligned
+				       __counted_by(priv_len);
+} ____cacheline_aligned;
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
 /*
@@ -2593,7 +2596,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
  */
 static inline void *netdev_priv(const struct net_device *dev)
 {
-	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
+	return (void *)dev->priv;
 }
 
 /* Set the sysfs physical device reference for the network logical device
@@ -3123,7 +3126,6 @@ static inline void unregister_netdevice(struct net_device *dev)
 
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
-void netdev_freemem(struct net_device *dev);
 void init_dummy_netdev(struct net_device *dev);
 
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
diff --git a/net/core/dev.c b/net/core/dev.c
index d6b24749eb2e..38c2e3c2df86 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10889,13 +10889,6 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
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
@@ -10915,8 +10908,6 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
-	unsigned int alloc_size;
-	struct net_device *p;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -10930,21 +10921,13 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
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
+	sizeof_priv = ALIGN(sizeof_priv, SMP_CACHE_BYTES);
+	dev = kvzalloc(struct_size(dev, priv, sizeof_priv),
+		       GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
+	if (!dev)
 		return NULL;
 
-	dev = PTR_ALIGN(p, NETDEV_ALIGN);
-	dev->padded = (char *)dev - (char *)p;
+	dev->priv_len = sizeof_priv;
 
 	ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);
 #ifdef CONFIG_PCPU_DEV_REFCNT
@@ -11034,7 +11017,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	free_percpu(dev->pcpu_refcnt);
 free_dev:
 #endif
-	netdev_freemem(dev);
+	kvfree(dev);
 	return NULL;
 }
 EXPORT_SYMBOL(alloc_netdev_mqs);
@@ -11090,7 +11073,7 @@ void free_netdev(struct net_device *dev)
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
2.45.0


