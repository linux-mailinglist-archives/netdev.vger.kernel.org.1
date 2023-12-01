Return-Path: <netdev+bounces-53146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20793801757
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B4A1C20D23
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364163F8EA;
	Fri,  1 Dec 2023 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRj7i84I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CEC103
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701472353; x=1733008353;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Nlyed4XFlTv67lfHLoS9CqN6KELMzNwok+1xyOd4dw=;
  b=dRj7i84IIshEA7f4+0gL2YVSWu3PFQ5zGeOQTlbNNwAMEh7+CEPiAjOe
   X4ViAykNIWP1BGVh8di5GHPe1gn1T7Yp+z+06u5Q+B+BxBVpwPvmua+kJ
   k0pyJrg4t+BxC7GYoH5RQNkoGhqHI6O9AAQs7G5OuiEb+j2U4LpgA33En
   ZsomanYe1lZOTWa8feSklAY8pxcx1VB2mgVlxE51FouXWyU6Tvt/MLE3d
   lwluUP1hrs0qR/ENT4KDi/YHH2wr1Ct4Fmj6W8VN8Hs6N+lBBetp3QNFX
   3D7mBww2dbZIA+Elvlh8iAalgHl8xGxdg4479Yb3m/I+re2RgxQ/7+JrW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="413050"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="413050"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 15:12:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="798893878"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="798893878"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2023 15:12:34 -0800
Subject: [net-next PATCH v11 07/11] netdev-genl: spec: Add irq in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 01 Dec 2023 15:29:02 -0800
Message-ID: <170147334210.5260.18178387869057516983.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
References: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
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
index 76d6b2e15b67..a3a1c6ad521b 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -226,6 +226,10 @@ attribute-sets:
         name: id
         doc: ID of the NAPI instance.
         type: u32
+      -
+        name: irq
+        doc: The associated interrupt vector number for the napi
+        type: u32
   -
     name: queue
     attributes:
@@ -384,6 +388,7 @@ operations:
           attributes:
             - id
             - ifindex
+            - irq
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e7bdbcb01f22..30fea409b71e 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -112,6 +112,7 @@ enum {
 enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
+	NETDEV_A_NAPI_IRQ,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e7bdbcb01f22..30fea409b71e 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -112,6 +112,7 @@ enum {
 enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
+	NETDEV_A_NAPI_IRQ,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 906b61554698..58e5196da4bd 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -164,6 +164,7 @@ struct ynl_policy_nest netdev_queue_nest = {
 struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
 	[NETDEV_A_NAPI_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_ID] = { .name = "id", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_nest = {
@@ -210,6 +211,11 @@ int netdev_page_pool_info_parse(struct ynl_parse_arg *yarg,
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
index 481c9e45b689..0c3224017c12 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -387,10 +387,12 @@ struct netdev_napi_get_rsp {
 	struct {
 		__u32 id:1;
 		__u32 ifindex:1;
+		__u32 irq:1;
 	} _present;
 
 	__u32 id;
 	__u32 ifindex;
+	__u32 irq;
 };
 
 void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);


