Return-Path: <netdev+bounces-47551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89147EA751
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F25D280F96
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF22A3B;
	Tue, 14 Nov 2023 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lt7iVU0R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47FB800
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:13:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC71A6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699920837; x=1731456837;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pejQjwgQ+LnVV2EgneVC+CLoxQbEiCirv1eESuUOXQ=;
  b=lt7iVU0RTEBrTWckMhviEnFAP4QwHKseMh9+KbOHKfpD9qJJ5P2nyB6k
   vmQu+VssGmCllyW+M7FFc9c5dsHFGP9ylp19tKVoyeQAn89XCIX9Wamk1
   9P7hcn+Pb2hzPlpN3FmkLkSdDYIy6mh3XOWyqmlVqlUyOp7ta6YxtqcA8
   tntPsUvFZyz5cRmX+ExvmqQbxxvht+0COJNjcTIg3YY9ni4voSz5JR3fT
   XuW5vZsVBvkurF9oTTR1xdshit1xsNFGSaPzW6gMUMacaCv+96NsiiKQt
   LizvDKVj25Eo+8FkvzlcmDu82wtatQ2A/8RlGG5grBby/6XY3o3wl0rCZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393397529"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393397529"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 16:13:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011697884"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1011697884"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 13 Nov 2023 16:13:56 -0800
Subject: [net-next PATCH v7 07/10] netdev-genl: spec: Add irq in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 13 Nov 2023 16:30:11 -0800
Message-ID: <169992181139.3867.10042677304239840726.stgit@anambiarhost.jf.intel.com>
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
index 3f50d7c40baf..7e0de0f928c7 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -104,6 +104,10 @@ attribute-sets:
         name: napi-id
         doc: ID of the NAPI instance.
         type: u32
+      -
+        name: irq
+        doc: The associated interrupt vector number for the napi
+        type: u32
   -
     name: queue
     attributes:
@@ -197,6 +201,7 @@ operations:
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


