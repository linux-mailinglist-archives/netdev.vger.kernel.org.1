Return-Path: <netdev+bounces-47553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614697EA753
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF618B20AC8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505657F7;
	Tue, 14 Nov 2023 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+4cn79B"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBE17D1
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:14:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54221A6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699920847; x=1731456847;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BKep+s9MchmIZhAM4rZQQNTbbn/t7XGW4FfJyjbRBhc=;
  b=L+4cn79BTEQJuvuBFZdfX0AXcmzNxaqNtmJtIJXjheZfLXkuZSEsa1XN
   kL735kz0rufi5kRFotq61zL6xruKghpbrvlWsQifL/8d+d1ICWHsddOeT
   FO4QOVGHz6Q2+KJuAjIsdVtNMy0gDEoW8wE+TeqqvjH4DXFDxGYLjctMH
   qFeXh1345Bk8F4ef2MPvi0mH/ajQuYyFsHSo3rO4VjJ4dAbxEYbbaFukC
   WD301smOtyef/dKHNJ9YRrmwMaBLnZqhD6r2ft/aV+3rrG9ZN1k5FpwvJ
   5KohgvOvqbxy9sMW5aUXzReFvl4Yyv1CddfRwYEARRnQ9eTjAqfCs9Sk/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421640882"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421640882"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 16:14:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888065204"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888065204"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 16:14:06 -0800
Subject: [net-next PATCH v7 09/10] netdev-genl: spec: Add PID in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 13 Nov 2023 16:30:22 -0800
Message-ID: <169992182242.3867.5222784720149099153.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
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
 Documentation/netlink/specs/netdev.yaml |    7 +++++++
 include/uapi/linux/netdev.h             |    1 +
 tools/include/uapi/linux/netdev.h       |    1 +
 tools/net/ynl/generated/netdev-user.c   |    6 ++++++
 tools/net/ynl/generated/netdev-user.h   |    2 ++
 5 files changed, 17 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 7e0de0f928c7..aa15bb7449f9 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -108,6 +108,12 @@ attribute-sets:
         name: irq
         doc: The associated interrupt vector number for the napi
         type: u32
+      -
+        name: pid
+        doc: PID of the napi thread, if NAPI is configured to operate in
+             threaded mode. If NAPI is not in threaded mode (i.e. uses normal
+             softirq context), the attribute will be absent.
+        type: u32
   -
     name: queue
     attributes:
@@ -202,6 +208,7 @@ operations:
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


