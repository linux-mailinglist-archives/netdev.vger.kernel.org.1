Return-Path: <netdev+bounces-288097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOMfCkNVBmqnigIAu9opvQ
	(envelope-from <netdev+bounces-288097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:05:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82186547AC1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B6063021732
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B83859C2;
	Thu, 14 May 2026 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOR37i4i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02238E106;
	Thu, 14 May 2026 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799863; cv=none; b=uK/AcWYbK5QRQuqOWVbgONLbGytYzFw/l8tsa2y8oT/YjAfPRPLYDJ4HqSdZJK13EFt1GZ491F3zQfv4OOkpyJGVlEfgcEYdvfvNZkKuEDoNJOd+6HWmmjB77XH48wQz6n5gYcCVv6ztk2jSVaPttQvW676BJ2sC04LRBGd6f/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799863; c=relaxed/simple;
	bh=U67s9Jpy1wudPcC2bDMEHN5UNJQejW8vXm/VkGPnCWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9IHQNPIretvfMcqyJ5C5h1F3WnWIsWNKzoP26AMw1/W2ibosPrN7H1sqBmIVfKV4LjD6UpOx0NbiBZp2+OFscysaE+k7Z9zgb19ABACtTAI4jauaY3lFrpUZze5R8HgTF8s6WOVARAnC/26R3F+ucNYgzskbGocRZMJu9wZnqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOR37i4i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778799863; x=1810335863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U67s9Jpy1wudPcC2bDMEHN5UNJQejW8vXm/VkGPnCWE=;
  b=VOR37i4iz+8Ut8GqqcLAJTfFlCVmLB3U0AgQKJKYc/b8M/5vssVmpJLF
   soMkDx28t3RwO2v42TlhR8LCcljV0p0WSOKvTndPSYMYiKfGn9Pxf76Wy
   NcqkLNWA8POeu15eUMq9svjIFh+5zUxQCJDnMxtbapMm62jTb2bm+ZP8A
   2ceeqTr54SVshd5k8Kpt1YyiAA+3cCudw5CAdN2JltYISNPwaZRaHwKjf
   /eMSGi5bhUjKuShkGq3uGY+EIaLFMDGCjX4/emTKvDkEM532Y8sabcvzQ
   ux8OEarLB5572n6Sw2/ihv0mxrvtxjUwek7pHRtwKyEJDRNi5VNfsPcs7
   Q==;
X-CSE-ConnectionGUID: JIurjlWUSMek9C1LL0eQkw==
X-CSE-MsgGUID: yxW5AVaMQQi8stSJmt0kZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79924551"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79924551"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 16:04:22 -0700
X-CSE-ConnectionGUID: 5A6jVMixTd6OKbdUGFb9LQ==
X-CSE-MsgGUID: 1iY0420cTaKnt68G5ITr4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="262275849"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa001.fm.intel.com with ESMTP; 14 May 2026 16:04:17 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v9 net-next 2/8] dpll: allow registering FW-identified pin with a different DPLL
Date: Fri, 15 May 2026 00:59:40 +0200
Message-Id: <20260514225946.2885623-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
References: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82186547AC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288097-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Relax the (module, clock_id) equality requirement when registering a
pin identified by firmware (pin->fwnode). Some platforms associate a
FW-described pin with a DPLL instance that differs from the pin's
(module, clock_id) tuple. For such pins, permit registration without
requiring the strict match. Non-FW pins still require equality.

Keep netlink pin module reporting/filtering safe for this relaxed
registration model by caching the module name in the pin object at
allocation time and using the cached string in netlink paths.
This avoids dereferencing pin->module after provider module teardown.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c    | 20 ++++++++++++++++----
 drivers/dpll/dpll_core.h    |  2 ++
 drivers/dpll/dpll_netlink.c |  6 +++---
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 20a54728549c..6dc7e93ece75 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/idr.h>
+#include <linux/module.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -652,6 +653,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	pin->pin_idx = pin_idx;
 	pin->clock_id = clock_id;
 	pin->module = module;
+	strscpy(pin->module_name, module_name(module));
 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
 		    prop->type > DPLL_PIN_TYPE_MAX)) {
 		ret = -EINVAL;
@@ -884,11 +886,21 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
-	if (WARN_ON(!(dpll->module == pin->module &&
-		      dpll->clock_id == pin->clock_id)))
+
+	/*
+	 * For pins identified via firmware (pin->fwnode), allow registration
+	 * even if the pin's (module, clock_id) differs from the target DPLL.
+	 * For non-fwnode pins, require a strict (module, clock_id) match.
+	 */
+	if (!pin->fwnode &&
+	    WARN_ON_ONCE(dpll->module != pin->module ||
+			 dpll->clock_id != pin->clock_id)) {
 		ret = -EINVAL;
-	else
-		ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
+		goto out_unlock;
+	}
+
+	ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
+out_unlock:
 	mutex_unlock(&dpll_lock);
 
 	return ret;
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 71ac88ef2017..26d1537ada82 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -45,6 +45,7 @@ struct dpll_device {
  * @pin_idx:		index of a pin given by dev driver
  * @clock_id:		clock_id of creator
  * @module:		module of creator
+ * @module_name:	module name of creator
  * @fwnode:		optional reference to firmware node
  * @dpll_refs:		hold referencees to dplls pin was registered with
  * @parent_refs:	hold references to parent pins pin was registered with
@@ -59,6 +60,7 @@ struct dpll_pin {
 	u32 pin_idx;
 	u64 clock_id;
 	struct module *module;
+	char module_name[MODULE_NAME_LEN];
 	struct fwnode_handle *fwnode;
 	struct xarray dpll_refs;
 	struct xarray parent_refs;
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 53ca24d0f191..04cf48c2cac8 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -714,7 +714,7 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	if (ret)
 		return ret;
 	if (nla_put_string(msg, DPLL_A_PIN_MODULE_NAME,
-			   module_name(pin->module)))
+			   pin->module_name))
 		return -EMSGSIZE;
 	if (nla_put_64bit(msg, DPLL_A_PIN_CLOCK_ID, sizeof(pin->clock_id),
 			  &pin->clock_id, DPLL_A_PIN_PAD))
@@ -1652,9 +1652,9 @@ dpll_pin_find(u64 clock_id, struct nlattr *mod_name_attr,
 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
 		prop = &pin->prop;
 		cid_match = clock_id ? pin->clock_id == clock_id : true;
-		mod_match = mod_name_attr && module_name(pin->module) ?
+		mod_match = mod_name_attr && pin->module_name[0] ?
 			!nla_strcmp(mod_name_attr,
-				    module_name(pin->module)) : true;
+				    pin->module_name) : true;
 		type_match = type ? prop->type == type : true;
 		board_match = board_label ? (prop->board_label ?
 			!nla_strcmp(board_label, prop->board_label) : false) :
-- 
2.39.3


