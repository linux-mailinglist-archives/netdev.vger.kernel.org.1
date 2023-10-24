Return-Path: <netdev+bounces-43711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AAB7D44D2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E07A1C20B2B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729BA523D;
	Tue, 24 Oct 2023 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkLyBCPY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A014C8B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:18:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0048E8
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698110297; x=1729646297;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WyaUgENSa9BmK1pn7y5XdHSh1gP1vlmSdRQXEapRPqY=;
  b=dkLyBCPY55v45lJlcwt5mHGEARXbCdZDp569dlhaUV75Q2ck+gEHybwK
   ZSblLBRJTP3UJMir/gNqLQhlwMF1clhGCQEfheXRGrwU9Qsxprb/hLcKH
   J++0Hgg1KVRRBLMtNqJ7xO1EnffJ66qkP0paOG2fKBsa8nahgz9a/R0zr
   5m3GZ8TiFUp4nb/yywZOo1WoeMIhA5a+N9KyEr/64qPmVNygJ6l3ILEA/
   +a8eSUpQ3ZSaJtoOwpwdFCNDkR1H6wkNhgp+mCTfpIrrg5v9p6/mjhn1X
   ISSLwe1knpFSu0e+t//+6RRUj47JUWn9pVBJeey3/rZpaX9ceIo3SDJjJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389810619"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="389810619"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:18:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758309205"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="758309205"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2023 18:18:17 -0700
Subject: [net-next PATCH v6 07/10] netdev-genl: spec: Add irq in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 23 Oct 2023 18:33:56 -0700
Message-ID: <169811123614.59034.16476418463466341690.stgit@anambiarhost.jf.intel.com>
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

Add support in netlink spec(netdev.yaml) for interrupt number
among the NAPI attributes. Add code generated from the spec.

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
index b6c99189a8de..2faa69d5752f 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -104,6 +104,10 @@ attribute-sets:
         name: napi-id
         doc: napi id
         type: u32
+      -
+        name: irq
+        doc: The associated interrupt vector number for the napi
+        type: u32
   -
     name: queue
     attributes:
@@ -193,6 +197,7 @@ operations:
           attributes:
             - napi-id
             - ifindex
+            - irq
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 02e6594d0666..d461915aa514 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -72,6 +72,7 @@ enum {
 enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_NAPI_ID,
+	NETDEV_A_NAPI_IRQ,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 02e6594d0666..d461915aa514 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -72,6 +72,7 @@ enum {
 enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_NAPI_ID,
+	NETDEV_A_NAPI_IRQ,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 32d8972f1569..a3060531b42e 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -101,6 +101,7 @@ struct ynl_policy_nest netdev_queue_nest = {
 struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
 	[NETDEV_A_NAPI_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_nest = {
@@ -394,6 +395,11 @@ int netdev_napi_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.ifindex = 1;
 			dst->ifindex = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_NAPI_IRQ) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.irq = 1;
+			dst->irq = mnl_attr_get_u32(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 7491af619e6f..947932a9359b 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -214,10 +214,12 @@ struct netdev_napi_get_rsp {
 	struct {
 		__u32 napi_id:1;
 		__u32 ifindex:1;
+		__u32 irq:1;
 	} _present;
 
 	__u32 napi_id;
 	__u32 ifindex;
+	__u32 irq;
 };
 
 void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);


