Return-Path: <netdev+bounces-195944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F9AD2DA0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126DF3B1742
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 06:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F970261399;
	Tue, 10 Jun 2025 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxfMBQPC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7DB2609FC;
	Tue, 10 Jun 2025 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749535184; cv=none; b=vBKMPBNfGcNFdQBru1jevWbvosjUk+3SCgShjWx72KTs9mB3MhzudjHbsVTp+iJ16sarCf/bkmpAXgKBD8gtWmsjN3n3WQrttSow+SRlMmjvB0pzP6OwQjtoyPEv5CynsBtroOXiXOV64yr6yrIHxs3mJGWdLS3nCTzYJqj1D7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749535184; c=relaxed/simple;
	bh=5aPNiAVtA0B5JM8WU8pbN4yqUUgB6lt7a3r7PD8w20E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIDyTPbD6BVksEZ569DvaKvj5xW4/bLCcqqvajDPME9Rvz+V8jMh4Gk9DXzn95Nzsy+ZUlt4gUrh/wKA7zo0hpXzwiv5dvOl/NAHPyJFl7qlnqYnLRHI02SUFymTU0W9Abaxtx0tmqReUxruAJRUvIAOH/lzYxvhvLc8gZCB/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxfMBQPC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749535182; x=1781071182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5aPNiAVtA0B5JM8WU8pbN4yqUUgB6lt7a3r7PD8w20E=;
  b=CxfMBQPCLJ1/4L+DiqJpoCVbjumDqaoAdTVudGHu1/gcmYeL5rdPSMdY
   nAVLDNSSQH8p5ucDMQwLj9sBw9AjcYlBqtAXexx1YMsh/uWwHjvUZcQ9R
   Wksn0BMhg9Guey8g5cjGtI/CKEruYJvppNrIrt1OTPnlEFsedXMMggJ6V
   sQZ0snNIsybx1SlYLxcePbvGdIGCSMzh02fXBwQF0+CjK/RcZrJUkfGyc
   Vwret/dfopXBBQg/cvggxoO1qk3x8XoC8NTojHX5zLG4wZc33IGTAPMN9
   lhqgzNHqxBcZUAUQT6Yr/qcWqWnNxjAUdT3PH9dpa5bEtsr5KVR6yn5ya
   g==;
X-CSE-ConnectionGUID: E3rSpPvLRjC3OmjV7I02XA==
X-CSE-MsgGUID: z3flmaezSYKuRPTs88/VRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="54259762"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="54259762"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 22:59:42 -0700
X-CSE-ConnectionGUID: mtmqVBNEQ0aNan+Bsc3L4Q==
X-CSE-MsgGUID: 5gGubQzbSGSNGKDd7PFGWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147241767"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa010.fm.intel.com with ESMTP; 09 Jun 2025 22:59:38 -0700
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
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v5 2/3] dpll: add phase_offset_monitor_get/set callback ops
Date: Tue, 10 Jun 2025 07:53:37 +0200
Message-Id: <20250610055338.1679463-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250610055338.1679463-1-arkadiusz.kubalewski@intel.com>
References: <20250610055338.1679463-1-arkadiusz.kubalewski@intel.com>
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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v5:
- rebase.
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


