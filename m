Return-Path: <netdev+bounces-149529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC9B9E61F9
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CDD2822E9
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574771A269;
	Fri,  6 Dec 2024 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDZ+mTpq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E57A927
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443942; cv=none; b=FSyRbq0WmWZQ8Jdl3lxU5hJ1OJ/r5udz7i/6EzAfd3JDsxyLo/K4JYLl0Et4FX2Gkjq4yU/n6ycu4eONiPDA1ZKENqEkO/yPd7OyPOaMOfLRPaHOxwmkMjdxxykZzm4oHTCtYuiipoHYW6J4rXrlNEVlsnh7nNvyZk8ALD+Sn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443942; c=relaxed/simple;
	bh=Y0bK+z9quarTgGyece9m9dp3o0lhPnL0tt2CAtvKZgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUdzKdM6lFotDUNKkrb/Pilz+kBF+Wmg7a3IjXB0+BjFqLuYVi/tov/B9W1tNWQSOlY2EraUYw+k8LxaWQuBBWiuRnkF9EUCODHGWTMaUZFFmeCQkPR+UYQqOm8zXblpotW+90pUyIf43LNF+7fXmIwYMdetMAQbe/8jnkguCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDZ+mTpq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733443940; x=1764979940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y0bK+z9quarTgGyece9m9dp3o0lhPnL0tt2CAtvKZgw=;
  b=TDZ+mTpqvC4HZVxU48xrewxSe17W0/yTNqyE93lev4jyBHcS7ahQYIu4
   0VRPIVTdw3rMtuph81ZkdxMTIWe6JiVIV/6Qh13gPiMfs+b+qtaQQoDMA
   +p8laTHPeST/7csDJRtQIRngGCM/s8+O3O4XzSySboWGOkb6O1MiOlMGl
   3B6epZ3Ludqb3xS9h/NNukay198WSCw/+vs/imrN7AsZxREpRwKg0Eq2A
   M879CSuvx8PNu0o2LEMDsvPGo45yt5HTkRRtBfHQKaejHwIV8Y7PGcy4H
   ilm7vJU76rIAAs9Oka4JF6bdcckTmc1cEReo758K+FEHnKsltt+auQoUv
   w==;
X-CSE-ConnectionGUID: DVdPCxEPRbinBJVvRWW3Lg==
X-CSE-MsgGUID: OhadLSDMTiyr3/xhF9mvqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="45162752"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="45162752"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:12:20 -0800
X-CSE-ConnectionGUID: PezlXTMJQNeCngxy3fSxsA==
X-CSE-MsgGUID: B8EGLPjnSKWaQ0FJB1Vbyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="98694929"
Received: from ibganev-mobl.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.131])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:12:18 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH RFC net-next 1/2] net: napi: add CPU affinity to napi->config
Date: Thu,  5 Dec 2024 17:12:08 -0700
Message-ID: <20241206001209.213168-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206001209.213168-1-ahmed.zaki@intel.com>
References: <20241206001209.213168-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common task for most drivers is to remember the user's CPU affinity to
its IRQs. On each netdev reset, the driver must then re-assign the
user's setting to the IRQs.

Add CPU affinity mask to napi->config. To delegate the CPU affinity
management to the core, drivers must:
 1 - add a persistent napi config:     netif_napi_add_config()
 2 - bind an IRQ to the napi instance: netif_napi_set_irq()

the core will then make sure to use re-assign affinity to the napi's
IRQ.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 include/linux/netdevice.h | 22 ++++++++++++++++++++++
 net/core/dev.c            |  7 ++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ecc686409161..8660de791a1a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -350,6 +350,7 @@ struct napi_config {
 	u64 gro_flush_timeout;
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
+	cpumask_t affinity_mask;
 	unsigned int napi_id;
 };
 
@@ -393,6 +394,7 @@ struct napi_struct {
 	int			irq;
 	int			index;
 	struct napi_config	*config;
+	struct irq_affinity_notify affinity_notify;
 };
 
 enum {
@@ -2666,10 +2668,30 @@ static inline void *netdev_priv(const struct net_device *dev)
 void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 			  enum netdev_queue_type type,
 			  struct napi_struct *napi);
+static inline void
+netif_napi_affinity_notify(struct irq_affinity_notify *notify,
+			   const cpumask_t *mask)
+{
+	struct napi_struct *napi =
+		container_of(notify, struct napi_struct, affinity_notify);
+
+	if (napi->config)
+		cpumask_copy(&napi->config->affinity_mask, mask);
+}
+
+static inline void
+netif_napi_affinity_release(struct kref __always_unused *ref) {}
 
 static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
 {
 	napi->irq = irq;
+
+	if (irq > 0 && napi->config) {
+		napi->affinity_notify.notify = netif_napi_affinity_notify;
+		napi->affinity_notify.release = netif_napi_affinity_release;
+		irq_set_affinity_notifier(irq, &napi->affinity_notify);
+		irq_set_affinity(irq, &napi->config->affinity_mask);
+	}
 }
 
 /* Default NAPI poll() weight
diff --git a/net/core/dev.c b/net/core/dev.c
index 13d00fc10f55..d58779d57994 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6843,6 +6843,8 @@ void __netif_napi_del(struct napi_struct *napi)
 		return;
 
 	if (napi->config) {
+		if (napi->irq > 0)
+			irq_set_affinity_notifier(napi->irq, NULL);
 		napi->index = -1;
 		napi->config = NULL;
 	}
@@ -11184,7 +11186,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 {
 	struct net_device *dev;
 	size_t napi_config_sz;
-	unsigned int maxqs;
+	unsigned int maxqs, i;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11280,6 +11282,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
 	if (!dev->napi_config)
 		goto free_all;
+	for (i = 0; i < maxqs; i++)
+		cpumask_copy(&dev->napi_config[i].affinity_mask,
+			     cpu_online_mask);
 
 	strscpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
-- 
2.47.0


