Return-Path: <netdev+bounces-193078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA44CAC26C6
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831DD1C07379
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFEB296FB5;
	Fri, 23 May 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mp/aIVAX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624A5296FAC;
	Fri, 23 May 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015333; cv=none; b=aeiBrLJAm5N77eiGWFyQEsSQcI/JBKFVu1RDpr/S1mh+xK0ed3x0KhS0wUVpszkQdDbdOfAKeFCsptnVxsf25Ir2YQfdo4sa5Lo0zUMpkWCO7xONsW96dPsgC3oyH9ABKHxu3KbdNBIQ3rBS4iKmokRxJDb+KHMtBwl/74NI9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015333; c=relaxed/simple;
	bh=1v3TVLgWVZRrrSaNlHi5RrFHBxEp82AnPKpbcQ99aFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=actpUwlwZAq1xcnUlU2VFhAsuEZOMu7Lq4Xaf9blWZ8e3eSh6tdlIEtynRq4mYS4kDiCF87gfqt9IDIcSpO04WthvqskQw09I7TfCNvbNcKd0Brk0j5zShgS/tFl3eeDRRlm6jvLkFtQnxacj4UiD7l79RlYP7w8efe9+mxPJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mp/aIVAX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748015331; x=1779551331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1v3TVLgWVZRrrSaNlHi5RrFHBxEp82AnPKpbcQ99aFc=;
  b=mp/aIVAX7q5e2e2ogJNnKsyWsX1/B8y+N79IABZLtV21uE0jQ0ziLek3
   l3qCqxl6SM9/LyDZ+CRcEK6jLRrrYCfOGzCP8Idh/OCtGSvREftkX4P6M
   SIIupggI2vixkAZtyO6DSBIhisI9ckfXpqlPk6yJHG9NtvfyZyhy/W07P
   0gyMBy0KSZBsoimv0cUJE28OyBBDQFZ+AhHj00znNPJwJ/Q7X4kcfHIN8
   1g6zrCeLNXMTpmQWKQ0kmdYh5IxxLeoGJac2ddcEKejpBAFpFVu3rc3Ls
   bjPBQw0PI4uPwLq4BjYBcCcj32XUWs+Mw2SGKplT6vJm7j909twgqCIdC
   g==;
X-CSE-ConnectionGUID: 3oB7imQWQU67+8DUpYCSWg==
X-CSE-MsgGUID: 0vn5id7zTTeCOLAhwdU0sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49958847"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="49958847"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 08:48:51 -0700
X-CSE-ConnectionGUID: TQg/HnRqRRSEnGY2pMNyUw==
X-CSE-MsgGUID: j9EJu8riQvKuJBhbUoGHqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141036226"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa009.jf.intel.com with ESMTP; 23 May 2025 08:48:47 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	aleksandr.loktionov@intel.com,
	milena.olech@intel.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v4 2/3] dpll: add phase_offset_monitor_get/set callback ops
Date: Fri, 23 May 2025 17:42:23 +0200
Message-Id: <20250523154224.1510987-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
References: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new callback operations for a dpll device:
- phase_offset_monitor_get(..) - to obtain current state of phase offset
  monitor feature from dpll device,
- phase_offset_monitor_set(..) - to allow feature configuration.

Obtain the feature state value using the get callback and provide it to
the user if the device driver implements callbacks.

Execute the set callback upon user requests.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v4:
- propagete return value from callbacks,
- use info->attrs instead of manual parse,
- update --to= and --cc= with current maintainers.
---
 drivers/dpll/dpll_netlink.c | 69 +++++++++++++++++++++++++++++++++++--
 include/linux/dpll.h        |  8 +++++
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index c130f87147fa..4619aaa18b9c 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -126,6 +126,26 @@ dpll_msg_add_mode_supported(struct sk_buff *msg, struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+dpll_msg_add_phase_offset_monitor(struct sk_buff *msg, struct dpll_device *dpll,
+				  struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_feature_state state;
+	int ret;
+
+	if (ops->phase_offset_monitor_set && ops->phase_offset_monitor_get) {
+		ret = ops->phase_offset_monitor_get(dpll, dpll_priv(dpll),
+						    &state, extack);
+		if (ret)
+			return ret;
+		if (nla_put_u32(msg, DPLL_A_PHASE_OFFSET_MONITOR, state))
+			return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
 static int
 dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
 			 struct netlink_ext_ack *extack)
@@ -591,6 +611,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 		return ret;
 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
 		return -EMSGSIZE;
+	ret = dpll_msg_add_phase_offset_monitor(msg, dpll, extack);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -746,6 +769,31 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
 }
 EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
 
+static int
+dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a,
+			      struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_feature_state state = nla_get_u32(a), old_state;
+	int ret;
+
+	if (!(ops->phase_offset_monitor_set && ops->phase_offset_monitor_get)) {
+		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of phase offset monitor");
+		return -EOPNOTSUPP;
+	}
+	ret = ops->phase_offset_monitor_get(dpll, dpll_priv(dpll), &old_state,
+					    extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get current state of phase offset monitor");
+		return ret;
+	}
+	if (state == old_state)
+		return 0;
+
+	return ops->phase_offset_monitor_set(dpll, dpll_priv(dpll), state,
+					     extack);
+}
+
 static int
 dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		  struct netlink_ext_ack *extack)
@@ -1533,10 +1581,27 @@ int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+static int
+dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
+{
+	int ret;
+
+	if (info->attrs[DPLL_A_PHASE_OFFSET_MONITOR]) {
+		struct nlattr *a = info->attrs[DPLL_A_PHASE_OFFSET_MONITOR];
+
+		ret = dpll_phase_offset_monitor_set(dpll, a, info->extack);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int dpll_nl_device_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	/* placeholder for set command */
-	return 0;
+	struct dpll_device *dpll = info->user_ptr[0];
+
+	return dpll_set_from_nlattr(dpll, info);
 }
 
 int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 5e4f9ab1cf75..6ad6c2968a28 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -30,6 +30,14 @@ struct dpll_device_ops {
 				       void *dpll_priv,
 				       unsigned long *qls,
 				       struct netlink_ext_ack *extack);
+	int (*phase_offset_monitor_set)(const struct dpll_device *dpll,
+					void *dpll_priv,
+					enum dpll_feature_state state,
+					struct netlink_ext_ack *extack);
+	int (*phase_offset_monitor_get)(const struct dpll_device *dpll,
+					void *dpll_priv,
+					enum dpll_feature_state *state,
+					struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_ops {
-- 
2.38.1


