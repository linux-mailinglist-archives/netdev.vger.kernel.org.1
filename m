Return-Path: <netdev+bounces-167807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0FA3C680
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D3E179D44
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209EB214A7F;
	Wed, 19 Feb 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaM3GKas"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181A2147F3;
	Wed, 19 Feb 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987182; cv=none; b=IS+YyTZGHmkcLLXnx34FU/k0ooSBNE7MOKBL1URoqsWIrhpHuB+QqMcdEGvsqHuFDKo/s+D/1fvVkZAyrBLLQGTiE0flScy/r8HK4XfKDap+vYR8ePuRe1fFJ3CEbHHDsQN/kg/jW3XeRhgJA81t8vcvqFeyTUFH2BvqiXeVAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987182; c=relaxed/simple;
	bh=v0mV9d9F4bC7WQnGYcrOFt0VFmgb9KQ5yKqZlvACNA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpC7n/eBqtet9rn8Aiqsi8wTTG6TYKdgfYHT7YrXlusrU0CRVpTaFoV+UXF+eazy8Q5W58MZw7ke3SXNRz1h2OSziaey4Qc0QLJDvGFXPWFOgaWZ6X4UbkDqY57fPS7xWh7j4ZeHyBSTUM5ZNKQsG835Km4cBGzyil0oTAkW09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaM3GKas; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739987180; x=1771523180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v0mV9d9F4bC7WQnGYcrOFt0VFmgb9KQ5yKqZlvACNA8=;
  b=NaM3GKasLxExeBqTyLYX113znVvUFWm/OGrHxdCkytn6ffHn3kqG8vjq
   bRDI1nE6XOsoGuGafTpOx9Juj3l2SI0mDhSsFOqn2tVvpWBq0J2nAhBnH
   MDCu8CvIoGQEttu2UhY8wmAAJwOoAQ88H0fZbY3ueT6IIGS3XBYspaO4t
   4qmlOnvHmYtrDdk5Cu8Q6VpCYliR2triLpmWgLPOERh548neJPEWxDQOL
   emeVNLbksKbpRMpe9Dr0o46mn0vDjbiFQilJxlU/Agk7PMvliCPFBaG2t
   xk7Blt19P+iCAHBksBouMFseo1qLIZ8A3c9XLRATtdm7vi0eEh+3Z9+RH
   Q==;
X-CSE-ConnectionGUID: RMpb0ihTTE2+NVygFa8K8g==
X-CSE-MsgGUID: W2F+T7wATfmkYf5/lVmmNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="50953029"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="50953029"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:46:18 -0800
X-CSE-ConnectionGUID: bQm2QqyNSUiunKFvJuH9ZQ==
X-CSE-MsgGUID: VIGPr0GVSWuUJ9IY1w87TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119427316"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 19 Feb 2025 08:44:32 -0800
Received: from pkitszel-desk.intel.com (unknown [10.245.246.109])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4F7EC34301;
	Wed, 19 Feb 2025 16:44:19 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	ITP Upstream <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC net-next v2 1/2] devlink: add whole device devlink instance
Date: Wed, 19 Feb 2025 17:32:54 +0100
Message-ID: <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a support for whole device devlink instance. Intented as a entity
over all PF devices on given physical device.

In case of ice driver we have multiple PF devices (with their devlink
dev representation), that have separate drivers loaded. However those
still do share lots of resources due to being the on same HW. Examples
include PTP clock and RSS LUT. Historically such stuff was assigned to
PF0, but that was both not clear and not working well. Now such stuff
is moved to be covered into struct ice_adapter, there is just one instance
of such per HW.

This patch adds a devlink instance that corresponds to that ice_adapter,
to allow arbitrage over resources (as RSS LUT) via it (further in the
series (RFC NOTE: stripped out so far)).

Thanks to Wojciech Drewek for very nice naming of the devlink instance:
PF0:		pci/0000:00:18.0
whole-dev:	pci/0000:00:18
But I made this a param for now (driver is free to pass just "whole-dev").

$ devlink dev # (Interesting part of output only)
pci/0000:af:00:
  nested_devlink:
    pci/0000:af:00.0
    pci/0000:af:00.1
    pci/0000:af:00.2
    pci/0000:af:00.3
    pci/0000:af:00.4
    pci/0000:af:00.5
    pci/0000:af:00.6
    pci/0000:af:00.7

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/devlink/devl_internal.h | 14 +++++----
 net/devlink/core.c          | 58 +++++++++++++++++++++++++++++--------
 net/devlink/netlink.c       |  4 +--
 net/devlink/port.c          |  4 +--
 4 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 14eaad9cfe35..073afe02ce2f 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -49,6 +49,8 @@ struct devlink {
 	struct xarray snapshot_ids;
 	struct devlink_dev_stats stats;
 	struct device *dev;
+	const char *dev_name;
+	const char *bus_name;
 	possible_net_t _net;
 	/* Serializes access to devlink instance specific objects such as
 	 * port, sb, dpipe, resource, params, region, traps and more.
@@ -104,15 +106,15 @@ static inline bool devl_is_registered(struct devlink *devlink)
 
 static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
 {
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_lock(devlink->dev);
 	devl_lock(devlink);
 }
 
 static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
 {
 	devl_unlock(devlink);
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_unlock(devlink->dev);
 }
 
@@ -174,9 +176,9 @@ devlink_dump_state(struct netlink_callback *cb)
 static inline int
 devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 {
-	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink->dev->bus->name))
+	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink->bus_name))
 		return -EMSGSIZE;
-	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
+	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, devlink->dev_name))
 		return -EMSGSIZE;
 	return 0;
 }
@@ -209,8 +211,8 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 					    struct devlink *devlink)
 {
 	memset(desc, 0, sizeof(*desc));
-	desc->bus_name = devlink->dev->bus->name;
-	desc->dev_name = dev_name(devlink->dev);
+	desc->bus_name = devlink->bus_name;
+	desc->dev_name = devlink->dev_name;
 }
 
 static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
diff --git a/net/devlink/core.c b/net/devlink/core.c
index f49cd83f1955..f4960074b845 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -397,26 +397,25 @@ void devlink_unregister(struct devlink *devlink)
 EXPORT_SYMBOL_GPL(devlink_unregister);
 
 /**
- *	devlink_alloc_ns - Allocate new devlink instance resources
- *	in specific namespace
+ *	devlink_alloc_wrapper - Allocate a new devlink instance resources
+ *	for a SW wrapper over multiple HW devlink instances
  *
  *	@ops: ops
  *	@priv_size: size of user private data
- *	@net: net namespace
- *	@dev: parent device
+ *	@bus_name: user visible bus name
+ *	@dev_name: user visible device name
  *
- *	Allocate new devlink instance resources, including devlink index
- *	and name.
+ *	Allocate new devlink instance resources, including devlink index.
  */
-struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
-				 size_t priv_size, struct net *net,
-				 struct device *dev)
+struct devlink *devlink_alloc_wrapper(const struct devlink_ops *ops,
+				      size_t priv_size, const char *bus_name,
+				      const char *dev_name)
 {
 	struct devlink *devlink;
 	static u32 last_id;
 	int ret;
 
-	WARN_ON(!ops || !dev);
+	WARN_ON(!ops);
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
@@ -429,13 +428,14 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (ret < 0)
 		goto err_xa_alloc;
 
-	devlink->dev = get_device(dev);
 	devlink->ops = ops;
+	devlink->bus_name = bus_name;
+	devlink->dev_name = dev_name;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->nested_rels, XA_FLAGS_ALLOC);
-	write_pnet(&devlink->_net, net);
+	write_pnet(&devlink->_net, &init_net);
 	INIT_LIST_HEAD(&devlink->rate_list);
 	INIT_LIST_HEAD(&devlink->linecard_list);
 	INIT_LIST_HEAD(&devlink->sb_list);
@@ -458,6 +458,40 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	kvfree(devlink);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(devlink_alloc_wrapper);
+
+/**
+ *	devlink_alloc_ns - Allocate new devlink instance resources
+ *	in specific namespace
+ *
+ *	@ops: ops
+ *	@priv_size: size of user private data
+ *	@net: net namespace
+ *	@dev: parent device
+ *
+ *	Allocate new devlink instance resources, including devlink index
+ *	and name.
+ */
+struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
+				 size_t priv_size, struct net *net,
+				 struct device *dev)
+{
+	struct devlink *devlink;
+
+	if (WARN_ON(!dev))
+		return NULL;
+
+	dev = get_device(dev);
+	devlink = devlink_alloc_wrapper(ops, priv_size, dev->bus->name,
+					dev_name(dev));
+	if (!devlink) {
+		put_device(dev);
+		return NULL;
+	}
+	devlink->dev = dev;
+	write_pnet(&devlink->_net, net);
+	return devlink;
+}
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
 
 /**
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..3f73ced2d879 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -193,8 +193,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
-		    strcmp(dev_name(devlink->dev), devname) == 0) {
+		if (strcmp(devlink->bus_name, busname) == 0 &&
+		    strcmp(devlink->dev_name, devname) == 0) {
 			devl_dev_lock(devlink, dev_lock);
 			if (devl_is_registered(devlink))
 				return devlink;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..508ecf34d41a 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -220,8 +220,8 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 {
 	struct devlink *devlink = devlink_port->devlink;
 
-	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
-	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	return nla_total_size(strlen(devlink->bus_name) + 1) /* DEVLINK_ATTR_BUS_NAME */
+	     + nla_total_size(strlen(devlink->dev_name) + 1) /* DEVLINK_ATTR_DEV_NAME */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
 
-- 
2.46.0


