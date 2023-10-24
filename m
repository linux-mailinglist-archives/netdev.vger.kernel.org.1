Return-Path: <netdev+bounces-43713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F8A7D44D4
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90EEB20D91
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F54C92;
	Tue, 24 Oct 2023 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dz4M7w1S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E24538B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:18:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47047E8
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698110314; x=1729646314;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a9LVXHurYKFCbDSAuLWms+xCRHwWjM8hzWSV2F6+5Zw=;
  b=dz4M7w1SiSD/IeNHuWaHmgsvDbZ2BX0II3o/iuegfwAnrFZOIvon7YOY
   dvJKZ0l+GInKa//2kI0ieBGGZ86b1dbfD1i6bBZr/skAIAl1NUQ5LCNmK
   RAg9VJiICCPLaNEWccdDQgi8zTvR3OnhGhrphai1ykkJnrS6P3wWz5NZK
   1LRniGsAAJr1JFW6Jf4sY7pEI2GEFhHgJhNUITRNY3Yu0kn6TAyAu6zvR
   AVqYEfiTq6ME8d0Ig8qyI9LRtwCovRe8pQkFdHS4Btivm6IbjXb98bQVs
   UhLX7OTnO+zkrc/cu499DCwcgnzXaSVTKonzp5R5ABaoNXOulCVKcS2RD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366305815"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="366305815"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="761938458"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="761938458"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga007.fm.intel.com with ESMTP; 23 Oct 2023 18:18:27 -0700
Subject: [net-next PATCH v6 09/10] netdev-genl: spec: Add PID in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 23 Oct 2023 18:34:06 -0700
Message-ID: <169811124667.59034.10304395300563829113.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add support in netlink spec(netdev.yaml) for PID of the
NAPI thread. Add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |    5 +++++
 include/uapi/linux/netdev.h             |    1 +
 tools/include/uapi/linux/netdev.h       |    1 +
 tools/net/ynl/generated/netdev-user.c   |    6 ++++++
 tools/net/ynl/generated/netdev-user.h   |    2 ++
 5 files changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 2faa69d5752f..9ddb1d0b37dc 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -108,6 +108,10 @@ attribute-sets:
         name: irq
         doc: The associated interrupt vector number for the napi
         type: u32
+      -
+        name: pid
+        doc: PID of the napi thread
+        type: s32
   -
     name: queue
     attributes:
@@ -198,6 +202,7 @@ operations:
             - napi-id
             - ifindex
             - irq
+            - pid
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index d461915aa514..a13fb55b2dde 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -73,6 +73,7 @@ enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
+	NETDEV_A_NAPI_PID,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index d461915aa514..a13fb55b2dde 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -73,6 +73,7 @@ enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
+	NETDEV_A_NAPI_PID,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index a3060531b42e..ca9a68f6bd72 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -102,6 +102,7 @@ struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
 	[NETDEV_A_NAPI_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_PID] = { .name = "pid", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_nest = {
@@ -400,6 +401,11 @@ int netdev_napi_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.irq = 1;
 			dst->irq = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_NAPI_PID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.pid = 1;
+			dst->pid = mnl_attr_get_u32(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 947932a9359b..6836633cf6da 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -215,11 +215,13 @@ struct netdev_napi_get_rsp {
 		__u32 napi_id:1;
 		__u32 ifindex:1;
 		__u32 irq:1;
+		__u32 pid:1;
 	} _present;
 
 	__u32 napi_id;
 	__u32 ifindex;
 	__u32 irq;
+	__s32 pid;
 };
 
 void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);


