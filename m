Return-Path: <netdev+bounces-150197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B69529E967C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76446283674
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1977222D77;
	Mon,  9 Dec 2024 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIZMjCkL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749D222D64
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750148; cv=none; b=RwM1UTLtpXnO9nwLj2GiNk+L1VgSfnfQJE1+6ILwiUB82FdvB5E0Use1TZJOwVKkYPDeNSGT2jV9s/89R2iV2XPvTn4TmTIoeyeV/uMXnma7XAOYfNsXYJE/8Bd7liAOMvIv0t5T1SNjxaOGqtnyWIzo4aHbkJNKD7Be66HFoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750148; c=relaxed/simple;
	bh=o57EDAoNco0z5xP4oDUg/FTLA9YTPNTs5M4lwaRDGnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym1aGr6SGIPhg+5nbLZR8nAD5lr2YYlGEEDcCTURc49LFSTqZk5ztc1xkLLOyJnlC+//XsYrW/vWXf20JgjQRM8d4pkKRADaeR4cNHUDxstpz7PE8XQ00GB2M6TE17KM9aavj/t7jpYFPWBEBak6zXFnilE1WI1J5IKyjeTzc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIZMjCkL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733750147; x=1765286147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o57EDAoNco0z5xP4oDUg/FTLA9YTPNTs5M4lwaRDGnM=;
  b=XIZMjCkLF5h6cAKewr4eW3MEAiQQj0/s917JmucoqT44gbvkMAMAjFv1
   AsnHx7RtjXVvsOZtMEeBlS2Y00jdH9FnLi9XoQTLEtAY+CuEhWpwBbrPD
   buNasruBCMCVIMSvBp0dAu17QaAC9l+YJIz30L0iU7P5TyWaPz32UVURs
   TS41I2RMpm04JH1QNpI03UPux+YTyA1He58lAnzSR9QcT9ghV0fnj8DQo
   RcwiC4iwa0edgnLB307VkMVJ6MHnPphPjvctCcq0H2WCbQ56L4xFKj7kN
   BCVTYvuCjxs76RIhzfz1P/XhvFFfdIvZE/O562SEqEUZg+dlIu0AwUl0T
   A==;
X-CSE-ConnectionGUID: UMsXk/NSQTud2Ux1iHvhhw==
X-CSE-MsgGUID: d0fzCDrFSLKQeddMS1I+7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33387398"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="33387398"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:15:41 -0800
X-CSE-ConnectionGUID: UKfRcj1bRry421aJgA28cw==
X-CSE-MsgGUID: IcJA3SvdRdqnR91lDfBr9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94934936"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa009.jf.intel.com with ESMTP; 09 Dec 2024 05:15:38 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org
Cc: anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [RFC 1/1] devlink: add new devlink lock-firmware command
Date: Mon,  9 Dec 2024 14:14:52 +0100
Message-ID: <20241209131450.137317-4-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209131450.137317-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20241209131450.137317-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new lock-firmware command to the devlink API,
providing a mechanism to enforce secure firmware versions at the user's request.
The lock-firmware command invokes a driver-implemented callback,
allowing hardware vendors to implement a mechanism for the specific
hardware to block undesirable firmware downgrades possibilities.
This ensures that firmware downgrades, which could expose devices
to known vulnerabilities, are prevented in security-sensitive deployments.

Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
Note: This is only RFC draft. As expected, the code that should be
automatically generated will eventually not be manually entered here.
Documentation will be added.
---
 include/net/devlink.h        |  2 ++
 include/uapi/linux/devlink.h |  2 ++
 net/devlink/dev.c            | 13 +++++++++++++
 net/devlink/netlink_gen.c    | 18 +++++++++++++++++-
 net/devlink/netlink_gen.h    |  4 +++-
 5 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index d5da362ea321..1b19f7c4550b 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1354,6 +1354,8 @@ struct devlink_ops {
 	int (*flash_update)(struct devlink *devlink,
 			    struct devlink_flash_update_params *params,
 			    struct netlink_ext_ack *extack);
+	int (*lock_firmware)(struct devlink *devlink,
+				   struct netlink_ext_ack *extack);
 	/**
 	 * @trap_init: Trap initialization function.
 	 *
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..8f37cef858e2 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -141,6 +141,8 @@ enum devlink_command {
 
 	DEVLINK_CMD_NOTIFY_FILTER_SET,
 
+	DEVLINK_CMD_LOCK_FIRMWARE,
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index d6e3db300acb..7bb7617a8080 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -1440,3 +1440,16 @@ int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(msg);
 	return err;
 }
+
+int devlink_nl_lock_firmware_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	int ret;
+
+	if (!devlink->ops->lock_firmware)
+		return -EOPNOTSUPP;
+
+	ret = devlink->ops->lock_firmware(devlink, info->extack);
+
+	return ret;
+}
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..2d12fb09ad48 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -567,8 +567,14 @@ static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
+/* DEVLINK_CMD_LOCK_FIRMWARE - do */
+static const struct nla_policy devlink_lock_firmware_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[74] = {
+const struct genl_split_ops devlink_nl_ops[75] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -1247,4 +1253,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_LOCK_FIRMWARE,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.pre_doit	= devlink_nl_pre_doit,
+		.doit		= devlink_nl_lock_firmware_doit,
+		.post_doit	= devlink_nl_post_doit,
+		.policy		= devlink_lock_firmware_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50ddf5e..f0129da6a81b 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -16,7 +16,7 @@ extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_F
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
-extern const struct genl_split_ops devlink_nl_ops[74];
+extern const struct genl_split_ops devlink_nl_ops[75];
 
 int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
@@ -144,5 +144,7 @@ int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
 int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_lock_firmware_doit(struct sk_buff *skb,
+				  struct genl_info *info);
 
 #endif /* _LINUX_DEVLINK_GEN_H */
-- 
2.47.0


