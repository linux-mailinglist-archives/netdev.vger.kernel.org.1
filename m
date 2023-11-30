Return-Path: <netdev+bounces-52330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE77FE4A0
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6994FB20C6E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B56387;
	Thu, 30 Nov 2023 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyhsblNc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9475ECA
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701303105; x=1732839105;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAopPp8F+TSD/k/tI5dXfXcf2aJO9wAamZ5z0Ns+WJ8=;
  b=TyhsblNcKsA3g725GuDaf8oazOcM58646Dbns63HM5OCfQ2zBHQnFzm8
   smciR6Kf6eof5o4jHI2GSBMcAChGZ2jUCnt8kz3lHMTEi8Du6gX6yL1Zz
   ppFSvqoikgI8mhQwynKhVoLVfUbPA5Uy/pU0+VDHaadxORK+PIBqT1PF1
   n2xsoEsww63dt4vFvIJVSqybUqbsXB/ginb6ydjoVqSFfxlYUenKxE1tC
   vq2rJnWL1HikARDd/7bj9P6/qW9KMLAKCeZTtzqNBSqyCjPrx5du5e+QG
   CVekq7Ec8tjCzkrY13u6JmL1AiDggYSE7f0P4jrhZDQuIdBpBzKrxW2x+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="112119"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="112119"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 16:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772863996"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="772863996"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2023 16:11:44 -0800
Subject: [net-next PATCH v10 09/11] netdev-genl: spec: Add PID in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, sridhar.samudrala@intel.com,
 amritha.nambiar@intel.com
Date: Wed, 29 Nov 2023 16:28:13 -0800
Message-ID: <170130409305.5198.16333345635103665952.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
References: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
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
index 4b7d799bc51c..e0f19b072f4e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -214,6 +214,12 @@ attribute-sets:
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
@@ -372,6 +378,7 @@ operations:
             - id
             - ifindex
             - irq
+            - pid
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index edb46c800ce1..d815bb47321b 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -103,6 +103,7 @@ enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
+	NETDEV_A_NAPI_PID,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index edb46c800ce1..d815bb47321b 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -103,6 +103,7 @@ enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
+	NETDEV_A_NAPI_PID,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index e4680c939c66..726f5b29fdcb 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -151,6 +151,7 @@ struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
 	[NETDEV_A_NAPI_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_ID] = { .name = "id", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_PID] = { .name = "pid", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_nest = {
@@ -202,6 +203,11 @@ int netdev_page_pool_info_parse(struct ynl_parse_arg *yarg,
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
index 33d5f8706fcb..41d811e3eef6 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -385,11 +385,13 @@ struct netdev_napi_get_rsp {
 		__u32 id:1;
 		__u32 ifindex:1;
 		__u32 irq:1;
+		__u32 pid:1;
 	} _present;
 
 	__u32 id;
 	__u32 ifindex;
 	__u32 irq;
+	__u32 pid;
 };
 
 void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);


