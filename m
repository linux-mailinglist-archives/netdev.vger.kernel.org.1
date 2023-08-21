Return-Path: <netdev+bounces-29476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AD7783626
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14B51C20A06
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0EE1BB3F;
	Mon, 21 Aug 2023 23:10:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323EC1BF12
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:10:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D64131
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692659435; x=1724195435;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Cr6/BKjF3eEWPCCiSVuHxvx1dcwMdTGe+K4Ej2eW8A=;
  b=Jsn+XcPoj92uvbtmsGaCgUzME8jMYhdaZvdw6nrE8lbavm46inkKoPz0
   XpojIbgUNnSdDHF2tYglCBgpOqzOYAfnuxh5h1El5kk0F5P5GPhg3Zag8
   juNgoam10DzSeka3MGP5HeS/X1XHwa+h4Fh+OHAo/GCVMLQOH2fOK5Fmf
   FoEA+/29xuFI7GVi9pzDJe1hs16+yef0RyAGUj5VSsZ823K1MxRVcKJF1
   RVFR6c84MIxqI6x2jocF6FiAya/ly5I9Uubli+g5MO/jU/BFxpvHHGzrD
   Qz82sTrKXIp5AS3lv94uXNumO7QlnPIq85irnnsg8EmJZgjaLLqFNLrcZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437645846"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="437645846"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685829271"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="685829271"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2023 16:10:34 -0700
Subject: [net-next PATCH v2 6/9] netdev-genl: spec: Add irq in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 21 Aug 2023 16:25:41 -0700
Message-ID: <169266034176.10199.356738804708103335.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support in netlink spec(netdev.yaml) for interrupt number
among the NAPI attributes. Add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |    5 +++++
 include/uapi/linux/netdev.h             |    1 +
 tools/include/uapi/linux/netdev.h       |    1 +
 tools/net/ynl/generated/netdev-user.c   |    6 ++++++
 tools/net/ynl/generated/netdev-user.h   |    2 ++
 5 files changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index a068cf3b5a7e..aef40397b026 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -91,6 +91,10 @@ attribute-sets:
         doc: list of tx queues associated with a napi
         type: u32
         multi-attr: true
+      -
+        name: irq
+        doc: The associated interrupt vector number for the napi
+        type: u32
 
 operations:
   list:
@@ -138,6 +142,7 @@ operations:
             - ifindex
             - rx-queues
             - tx-queues
+            - irq
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 28f6bad7c48e..d31241e155b9 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -53,6 +53,7 @@ enum {
 	NETDEV_A_NAPI_NAPI_ID,
 	NETDEV_A_NAPI_RX_QUEUES,
 	NETDEV_A_NAPI_TX_QUEUES,
+	NETDEV_A_NAPI_IRQ,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 28f6bad7c48e..d31241e155b9 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -53,6 +53,7 @@ enum {
 	NETDEV_A_NAPI_NAPI_ID,
 	NETDEV_A_NAPI_RX_QUEUES,
 	NETDEV_A_NAPI_TX_QUEUES,
+	NETDEV_A_NAPI_IRQ,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 0cc8c0151b36..a59377c70503 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -64,6 +64,7 @@ struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
 	[NETDEV_A_NAPI_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_RX_QUEUES] = { .name = "rx-queues", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_TX_QUEUES] = { .name = "tx-queues", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_nest = {
@@ -238,6 +239,11 @@ int netdev_napi_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 			n_rx_queues++;
 		} else if (type == NETDEV_A_NAPI_TX_QUEUES) {
 			n_tx_queues++;
+		} else if (type == NETDEV_A_NAPI_IRQ) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.irq = 1;
+			dst->irq = mnl_attr_get_u32(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 742cb37b6844..9edc5828ca89 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -111,6 +111,7 @@ struct netdev_napi_get_rsp {
 	struct {
 		__u32 napi_id:1;
 		__u32 ifindex:1;
+		__u32 irq:1;
 	} _present;
 
 	__u32 napi_id;
@@ -119,6 +120,7 @@ struct netdev_napi_get_rsp {
 	__u32 *rx_queues;
 	unsigned int n_tx_queues;
 	__u32 *tx_queues;
+	__u32 irq;
 };
 
 void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);


