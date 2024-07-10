Return-Path: <netdev+bounces-110552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6DF92D0B3
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DDB1F23263
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39B19046C;
	Wed, 10 Jul 2024 11:31:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5F18FDBE;
	Wed, 10 Jul 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611097; cv=none; b=TYGmC2NuMlwN9DKbXYS8kTndluVKu7Swa0MTfukLc9pnYbAGOKmENNtb1HlazrEc3doGuvUlIM5JM8nyYVdcuYKkXgBrZFNG7yteYPFbbfyEIVsw9yH7ERQQDHVb/cTc0TGUKEh+fyEU0/HyUVgqDc9UAmbNo9cFsyBAXA+fKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611097; c=relaxed/simple;
	bh=5TQFKVFfQMADyoYW5OYay34kHYVc5jDpImdXFMwwtGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCFzTwBPhOY+S65Qco/11t5zntxUnPoniRIQmFc0US4ke4cC/HmlIGDSZ5uaxRxxYOWgrJzYJf6kC/Wg1sBVtqEHuMMkaRh6T3y4QIUgvgyqHgbnjlQ9S4+Nvmq0p8hPClZbh8SYqscch0j4bNHCdduWR7i+GJlvXB2tAXnjZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so54093331fa.1;
        Wed, 10 Jul 2024 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611094; x=1721215894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hq37breb3Xyz68YYRuqL9+m4BKbjJP6SxqbBXu+nd/A=;
        b=P0ziHXTjNE/vFEpfg1WLEBN1LWaAlHe6/RLiv3BSC5zrE6R5ebiRtH+AIfWRSK0l7F
         QM8CrngQ3LwnZyMPa6y+VG3T4zQiWtNogOydWIktkaVCWif02mHWSVCkhk8n4LXp6hfC
         vZ2uoE4XrkIRtSZb5CguzPL4sasRYY2fJwIVo4SUvmQvDlBvIwAl2MuMzGjmMyL3kjlz
         02QOF9bayPIg8e9+HXH8fhE8NLRx1QqUFSk4KMq7VRtwfhGG5sMqdOiebWGEhSxDV+jm
         SAc5NIBN7BbcabQzzY1vPhhDVFtmuUh16OS2b3ah0AdUxBEle6r7QkZbK10kmXGL6suj
         blfA==
X-Forwarded-Encrypted: i=1; AJvYcCWDBoRtUeJkDiz8qLMQqztfd+dISIQIK3m8MeSfonDuQ3VA6Sw4TOUEXg/2iJ1h+qpAcwh/dp6j1iO3BA25gdnliGdT1GycUX4fjVUvPSYqbHxzv6yCBQCfl2u/AaIdno+CQCPHW85BVDxn0gEZJXe6DEh+AjAxht8y88allKY9na2kj0+A
X-Gm-Message-State: AOJu0YzBO1+gGmtNKQrh4AQorGzL16Xq8LGoBrQmlU9/nmGQtMfpk0AO
	SWuThj5WC0RPFFdzs1eqN7Yhzlj6oEAWn8fwqLcG2ytPOptaX3TViOovOg==
X-Google-Smtp-Source: AGHT+IF5yMUA3nqWqzzDQw/bCql3VIw1T+oWK0dmnFiKwxRgRbPJXn6TY7CNigfGgcjewBERd+mxyw==
X-Received: by 2002:a05:651c:a09:b0:2ec:4d8a:785a with SMTP id 38308e7fff4ca-2eeb30ba739mr55633091fa.4.1720611093907;
        Wed, 10 Jul 2024 04:31:33 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a85459fsm148364166b.160.2024.07.10.04.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:31:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: keescook@chromium.org,
	horms@kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3] netdevice: define and allocate &net_device _properly_
Date: Wed, 10 Jul 2024 04:30:28 -0700
Message-ID: <20240710113036.2125584-1-leitao@debian.org>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kees Cook <kees@kernel.org>

---
Changelog

v3:
 * Fix kernel-doc documentation for the new fields (Simon)

v2:
 * Rebased Alexander's patch on top of f750dfe825b90 ("ethtool: provide
   customized dim profile management").
 * Removed the ALIGN() of SMP_CACHE_BYTES for sizeof_priv.

v1:
 * https://lore.kernel.org/netdev/90fd7cd7-72dc-4df6-88ec-fbc8b64735ad@intel.com

 include/linux/netdevice.h | 15 +++++++++------
 net/core/dev.c            | 30 ++++++------------------------
 net/core/net-sysfs.c      |  2 +-
 3 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 93558645c6d0..9ba9552e4af6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1819,7 +1819,8 @@ enum netdev_reg_state {
  *	@priv_flags:	Like 'flags' but invisible to userspace,
  *			see if.h for the definitions
  *	@gflags:	Global flags ( kept as legacy )
- *	@padded:	How much padding added by alloc_netdev()
+ *	@priv_len:	Size of the ->priv flexible array
+ *	@priv:		Flexible array containing private data
  *	@operstate:	RFC2863 operstate
  *	@link_mode:	Mapping policy to operstate
  *	@if_port:	Selectable AUI, TP, ...
@@ -2199,10 +2200,10 @@ struct net_device {
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
@@ -2406,7 +2407,10 @@ struct net_device {
 
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
-};
+
+	u8			priv[] ____cacheline_aligned
+				       __counted_by(priv_len);
+} ____cacheline_aligned;
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
 /*
@@ -2596,7 +2600,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
  */
 static inline void *netdev_priv(const struct net_device *dev)
 {
-	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
+	return (void *)dev->priv;
 }
 
 /* Set the sysfs physical device reference for the network logical device
@@ -3127,7 +3131,6 @@ static inline void unregister_netdevice(struct net_device *dev)
 
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


