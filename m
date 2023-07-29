Return-Path: <netdev+bounces-22483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E776799C
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3AB1C219B8
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235917E3;
	Sat, 29 Jul 2023 00:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731617D3
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:36 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95877E48
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590755; x=1722126755;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pN86Nb9ofYrUeAEZEQ/+GNk9EIeYvGrgheIHarCI7CA=;
  b=LeYiuKhYPMX3Aoh8MhCRSMtTCm1cM3u1I9LrxJHEkKBqurXrC9Bl4iCo
   XeksfQMUf1U53XzxkTI072p7CfYwF08+txo8bcV78DHhgGYvEHpQlozRA
   mWVY4b2XMpkHi1bb6KP2CFVwW97mVNId9/mx8te1tH4gqCiHj1JyUx8s5
   V8w7FiqM5Rev0V5f5I1Zt296HHf2qhLv8sxOp+mV3SE6YTdV49ZuzbvJv
   MSOKLDDwINxAce8ilRH/Jt7k8Gb8L2DnLjCvYqlFGu6hrQm0ReAcz7ZgW
   0RsWebcNK8OxHvILZOvsddMnkBCHSMb/M4FRyZ1FtKy3DFNmgGTM4FzyZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358742160"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358742160"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="851403913"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851403913"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 17:32:35 -0700
Subject: [net-next PATCH v1 6/9] netdev-genl: spec: Add irq in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:47:22 -0700
Message-ID: <169059164289.3736.17134833730695570684.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support in netlink spec(netdev.yaml) for interrupt number
among the NAPI attributes. Add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |    4 ++++
 include/uapi/linux/netdev.h             |    1 +
 tools/include/uapi/linux/netdev.h       |    1 +
 tools/net/ynl/generated/netdev-user.c   |    6 ++++++
 tools/net/ynl/generated/netdev-user.h   |    2 ++
 5 files changed, 14 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 507cea4f2319..c7f72038184d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -85,6 +85,10 @@ attribute-sets:
         doc: list of tx queues associated with a napi
         type: u32
         multi-attr: true
+      -
+        name: irq
+        doc: The associated interrupt vector number for the napi
+        type: u32
   -
     name: napi
     attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index bc06f692d9fd..17782585be72 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -52,6 +52,7 @@ enum {
 	NETDEV_A_NAPI_INFO_ENTRY_NAPI_ID = 1,
 	NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES,
 	NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES,
+	NETDEV_A_NAPI_INFO_ENTRY_IRQ,
 
 	__NETDEV_A_NAPI_INFO_ENTRY_MAX,
 	NETDEV_A_NAPI_INFO_ENTRY_MAX = (__NETDEV_A_NAPI_INFO_ENTRY_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index bc06f692d9fd..17782585be72 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -52,6 +52,7 @@ enum {
 	NETDEV_A_NAPI_INFO_ENTRY_NAPI_ID = 1,
 	NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES,
 	NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES,
+	NETDEV_A_NAPI_INFO_ENTRY_IRQ,
 
 	__NETDEV_A_NAPI_INFO_ENTRY_MAX,
 	NETDEV_A_NAPI_INFO_ENTRY_MAX = (__NETDEV_A_NAPI_INFO_ENTRY_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index e9a6c8cb5c68..74c24be5641c 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -51,6 +51,7 @@ struct ynl_policy_attr netdev_napi_info_entry_policy[NETDEV_A_NAPI_INFO_ENTRY_MA
 	[NETDEV_A_NAPI_INFO_ENTRY_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES] = { .name = "rx-queues", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES] = { .name = "tx-queues", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_INFO_ENTRY_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_info_entry_nest = {
@@ -113,6 +114,11 @@ int netdev_napi_info_entry_parse(struct ynl_parse_arg *yarg,
 			n_rx_queues++;
 		} else if (type == NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES) {
 			n_tx_queues++;
+		} else if (type == NETDEV_A_NAPI_INFO_ENTRY_IRQ) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.irq = 1;
+			dst->irq = mnl_attr_get_u32(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 9274711bd862..a0833eb9a52f 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -23,6 +23,7 @@ const char *netdev_xdp_act_str(enum netdev_xdp_act value);
 struct netdev_napi_info_entry {
 	struct {
 		__u32 napi_id:1;
+		__u32 irq:1;
 	} _present;
 
 	__u32 napi_id;
@@ -30,6 +31,7 @@ struct netdev_napi_info_entry {
 	__u32 *rx_queues;
 	unsigned int n_tx_queues;
 	__u32 *tx_queues;
+	__u32 irq;
 };
 
 /* ============== NETDEV_CMD_DEV_GET ============== */


