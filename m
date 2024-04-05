Return-Path: <netdev+bounces-85340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4789A53D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59EC1F22EFB
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111A017334B;
	Fri,  5 Apr 2024 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kt0aKmZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20285174EC9
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346689; cv=none; b=iEbKli5TAqym5wmie4Qv+RjrZxYxeJ2nYCUAG6wy8Y1XEpCIOF4mACtMCLSK9oOOGaPmpdZ4NI8UkH/W0NIufa1iNohuHNH7ahgtH7r5C1qMq1qRAs5rtvnkTxLU0+D1ayTVzzbjtn9eECCMr2lfOAkiFeiAev1SnkMl6rUjvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346689; c=relaxed/simple;
	bh=btLhHHI4hiXypA42yiLY7DA6UrcImaLMmUGCmN1HOoM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pjjbbi2oK2inb2lTP8YICw/G397amT3WAupSu8697QtOd06cZuzoKf+Pgb+md5f2RIFjfi7PgQxSqfsNZJXTo1yWesi1Lb/alA16zW9qkkBsE3SVeHATaWxlfZLMhcSe5fJ1BYr5rHb0JwRGahQGsCP2w6jEpKHh7xX23pINE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kt0aKmZ5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712346687; x=1743882687;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btLhHHI4hiXypA42yiLY7DA6UrcImaLMmUGCmN1HOoM=;
  b=Kt0aKmZ5YGkhksfJ9qMVs0eYNzai2cHr24Y9pcicIKfwUUssZ6NJ3BoH
   kc06moMWttuSG9Ovmscum8UBvAm+aTuoRERIeVVYuXE5ONhHF4an2x9/n
   mgRwc5PZjYEDyIphpKNdg9r+gsjTA7mKqI2XcCO1R/8MWikDPJJA1WRfl
   kfSd9HZrUI0ju6ImRGMEdE2ADS6Hv2HQ03/XW/338gpTCr4SLAf9luCGJ
   /eCS/Rg1V0P3OLAzLAVBpiuF9BrzB/WE8vzcDbmp2N8+3aKyOj5FnaZuS
   oLZrx5o1dL6uPkpBF/gbJZAu3Jqr5R3ySQxUUk4vA3Ry8JjCZC+0/bHRh
   g==;
X-CSE-ConnectionGUID: ZP80f42TQMWGWU5mVXfwFA==
X-CSE-MsgGUID: bFog157xQEaz2CAaikzXCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7785899"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7785899"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:51:26 -0700
X-CSE-ConnectionGUID: 7f1iVORdTWG9D7ehJwR8ng==
X-CSE-MsgGUID: Pz5dNaSSQVON/K7q41OImA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19289581"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmviesa006.fm.intel.com with ESMTP; 05 Apr 2024 12:51:25 -0700
Subject: [net-next,
 RFC PATCH 1/5] netdev-genl: spec: Extend netdev netlink spec in
 YAML for queue-set
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: edumazet@google.com, pabeni@redhat.com, ast@kernel.org, sdf@google.com,
 lorenzo@kernel.org, tariqt@nvidia.com, daniel@iogearbox.net,
 anthony.l.nguyen@intel.com, lucien.xin@gmail.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 05 Apr 2024 13:09:33 -0700
Message-ID: <171234777309.5075.4038375383551870109.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add support in netlink spec(netdev.yaml) for queue-set command. Currently,
the set command enables associating a NAPI ID for a queue, but can also
be extended to support configuring other attributes.
Also, add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |   20 ++++++++++++++++++++
 include/uapi/linux/netdev.h             |    1 +
 net/core/netdev-genl-gen.c              |   15 +++++++++++++++
 net/core/netdev-genl-gen.h              |    1 +
 net/core/netdev-genl.c                  |    5 +++++
 tools/include/uapi/linux/netdev.h       |    1 +
 6 files changed, 43 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 76352dbd2be4..eda45ae31077 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -457,6 +457,26 @@ operations:
           attributes:
             - ifindex
         reply: *queue-get-op
+    -
+      name: queue-set
+      doc: User configuration of queue attributes.
+           The id, type and ifindex forms the queue header/identifier. Example,
+           to configure the NAPI instance associated with the queue, the napi-id
+           is the configurable attribute.
+      attribute-set: queue
+      do:
+        request:
+          attributes:
+            - ifindex
+            - type
+            - id
+            - napi-id
+        reply: &queue-set-op
+          attributes:
+            - id
+            - type
+            - napi-id
+            - ifindex
     -
       name: napi-get
       doc: Get information about NAPI instances configured on the system.
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index bb65ee840cda..80fac72da8b2 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -162,6 +162,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
 	NETDEV_CMD_PAGE_POOL_STATS_GET,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_QUEUE_SET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8d8ace9ef87f..cb5485dc5843 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -58,6 +58,14 @@ static const struct nla_policy netdev_queue_get_dump_nl_policy[NETDEV_A_QUEUE_IF
 	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_QUEUE_SET - do */
+static const struct nla_policy netdev_queue_set_nl_policy[NETDEV_A_QUEUE_NAPI_ID + 1] = {
+	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_QUEUE_ID] = { .type = NLA_U32, },
+	[NETDEV_A_QUEUE_NAPI_ID] = { .type = NLA_U32, },
+};
+
 /* NETDEV_CMD_NAPI_GET - do */
 static const struct nla_policy netdev_napi_get_do_nl_policy[NETDEV_A_NAPI_ID + 1] = {
 	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
@@ -129,6 +137,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_QUEUE_IFINDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_QUEUE_SET,
+		.doit		= netdev_nl_queue_set_doit,
+		.policy		= netdev_queue_set_nl_policy,
+		.maxattr	= NETDEV_A_QUEUE_NAPI_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 	{
 		.cmd		= NETDEV_CMD_NAPI_GET,
 		.doit		= netdev_nl_napi_get_doit,
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 4db40fd5b4a9..be136c5ea5ad 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -26,6 +26,7 @@ int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
 int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
 			       struct netlink_callback *cb);
+int netdev_nl_queue_set_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 7004b3399c2b..d5b2e90e5709 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -674,6 +674,11 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
+int netdev_nl_queue_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
 				       unsigned long event, void *ptr)
 {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index bb65ee840cda..80fac72da8b2 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -162,6 +162,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
 	NETDEV_CMD_PAGE_POOL_STATS_GET,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_QUEUE_SET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 


