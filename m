Return-Path: <netdev+bounces-298634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UKs2AYj+K2rGJAQAu9opvQ
	(envelope-from <netdev+bounces-298634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:41:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB726796AC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:41:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=Y4B0lLLv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298634-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298634-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8490E31F68C6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C03E717A;
	Fri, 12 Jun 2026 12:38:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD13DD85E;
	Fri, 12 Jun 2026 12:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267934; cv=none; b=jGPS9ciUqWdiiGSn4kiIOBZo6BVAOCefN5M3VkLYR535EwJWGieIQWwCq/M6u0iAPj3MqYEu4nHrjHxhbuBjSG0ZcFiKZVbpR8pEkPo8ph2IJqiwu/hYqWPXa04+QIxQcf4A7YoKVmOOOa/HyrZZvPx2TTx58RdtICqPYg5D9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267934; c=relaxed/simple;
	bh=Fmza45PAcYYJ0E8tkpI3HuE5XGe0Zx6TcXJnaOW3cfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qhS4zgJI7P+WHKaeTemDgee7wlp8xxLWk4MDlQXryvCVZnBcuNcOKZeYlWYEwmwlKooYjyGxStb+zdodAdEKOxqTL8lraJNyLMTKIH/uMzOCgHx3ITQ/S7gu/2JEHeZ56A2Kb4M4t5RCy838d1/bqPd5L49U9h2zrLnTRfzI6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y4B0lLLv; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781267932; x=1812803932;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Fmza45PAcYYJ0E8tkpI3HuE5XGe0Zx6TcXJnaOW3cfg=;
  b=Y4B0lLLvFuqbcWsUBpSUpDXqPYFCyAWjvakgqHJT+E3K6l5HhZtdOUF7
   Lmj97t2muM7fmSNwlHLjQdTyS2//cYKeq2wS784sVsQs8AzPe+5ItqQJc
   kbQ0NrRUpQXPPehAoErA0KSi02BHrC/mx9KHp9WM7MPuPtHIxxSkLdLuq
   odzQfKDeu/ZswMvKHupZdDRVWCnQs3/XZWcYgwIosv7q5AsJLSGZKsSuB
   fek7qxYSVAq2NS0gQsewTr0PcHVBJVg/We4ZHBYNSeTuu2BM3mhE7Do1+
   brHIFsUl3OkLf8XovStTulVucpO27mb9RfydiEmFsT9EmzlpmxwZ/kBCG
   Q==;
X-CSE-ConnectionGUID: 5dU3PhwiRhGp4hyunzs8ew==
X-CSE-MsgGUID: bGCf5OiOTUOAaGXE/cYyDQ==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="59023673"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2026 05:38:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 12 Jun 2026 05:38:50 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 05:38:47 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 12 Jun 2026 14:37:14 +0200
Subject: [PATCH net-next 5/9] net: sparx5: add l3 routing registers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-sparx5_l3_routing-v1-5-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
In-Reply-To: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298634-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:jensemil.schulzostergaard@microchip.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EB726796AC

Add autogenerated register macros for L3 routing on lan969x and sparx5.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_regs.c        |  20 +-
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 691 ++++++++++++++++++++-
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  20 +-
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  20 +-
 4 files changed, 739 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
index ace4ba21eec4..63a6253a1218 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Microchip lan969x Switch driver
  *
- * Copyright (c) 2024 Microchip Technology Inc.
+ * Copyright (c) 2026 Microchip Technology Inc.
  */
 
-/* This file is autogenerated by cml-utils 2024-09-30 11:48:29 +0200.
- * Commit ID: 9d07b8d19363f3cd3590ddb3f7a2e2768e16524b
+/* This file is autogenerated by cml-utils 2026-02-16 21:50:29 +0100.
+ * Commit ID: 09d52195beeeb9682063ef0bd6eec50eebc137e2
  */
 
 #include "lan969x.h"
@@ -77,12 +77,16 @@ const unsigned int lan969x_gaddr[GADDR_LAST] = {
 	[GA_ANA_CL_COMMON] = 87040,
 	[GA_ANA_L2_COMMON] = 561928,
 	[GA_ANA_L3_COMMON] = 370752,
+	[GA_ANA_L3_VMID] = 360448,
+	[GA_ANA_L3_ARP_PTR_REMAP] = 370944,
+	[GA_ANA_L3_ARP] = 294912,
 	[GA_ANA_L3_VLAN_ARP_L3MC_STICKY] = 368580,
 	[GA_ASM_CFG] = 18304,
 	[GA_ASM_PFC_TIMER_CFG] = 15568,
 	[GA_ASM_LBK_WM_CFG] = 15596,
 	[GA_ASM_LBK_MISC_CFG] = 15608,
 	[GA_ASM_RAM_CTRL] = 15684,
+	[GA_EACL_COMMON] = 37408,
 	[GA_EACL_ES2_KEY_SELECT_PROFILE] = 36864,
 	[GA_EACL_CNT_TBL] = 30720,
 	[GA_EACL_POL_CFG] = 38400,
@@ -102,6 +106,7 @@ const unsigned int lan969x_gaddr[GADDR_LAST] = {
 	[GA_QSYS_RAM_CTRL] = 2204,
 	[GA_REW_COMMON] = 98304,
 	[GA_REW_PORT] = 49152,
+	[GA_REW_VMID] = 96768,
 	[GA_REW_VOE_PORT_LM_CNT] = 90112,
 	[GA_REW_RAM_CTRL] = 93992,
 	[GA_VOP_RAM_CTRL] = 16368,
@@ -123,6 +128,8 @@ const unsigned int lan969x_gcnt[GCNT_LAST] = {
 	[GC_ANA_L2_ISDX_LIMIT] = 256,
 	[GC_ANA_L2_ISDX] = 1024,
 	[GC_ANA_L3_VLAN] = 4608,
+	[GC_ANA_L3_VMID] = 127,
+	[GC_ANA_L3_ARP] = 1024,
 	[GC_ASM_DEV_STATISTICS] = 30,
 	[GC_EACL_ES2_KEY_SELECT_PROFILE] = 68,
 	[GC_EACL_CNT_TBL] = 512,
@@ -132,6 +139,7 @@ const unsigned int lan969x_gcnt[GCNT_LAST] = {
 	[GC_PTP_PTP_PINS] = 8,
 	[GC_PTP_PHASE_DETECTOR_CTRL] = 8,
 	[GC_REW_PORT] = 35,
+	[GC_REW_VMID] = 127,
 	[GC_REW_VOE_PORT_LM_CNT] = 240,
 };
 
@@ -188,7 +196,12 @@ const unsigned int lan969x_fsize[FSIZE_LAST] = {
 	[FW_ANA_L2_AUTO_LRN_CFG_AUTO_LRN_ENA] = 30,
 	[FW_ANA_L2_DLB_CFG_DLB_IDX] = 9,
 	[FW_ANA_L2_TSN_CFG_TSN_SFID] = 8,
+	[FW_ANA_L3_L3_UC_ENA_L3_UC_ENA] = 30,
+	[FW_ANA_L3_SIP_SECURE_ENA1_SIP_CMP_ENA1] = 3,
+	[FW_ANA_L3_DIP_SECURE_ENA_DIP_CMP_ENA] = 30,
+	[FW_ANA_L3_VMID_CFG_VMID] = 7,
 	[FW_ANA_L3_VLAN_MASK_CFG_VLAN_PORT_MASK] = 30,
+	[FW_ANA_L3_ARP_CFG_0_ARP_VMID] = 7,
 	[FW_FDMA_CH_CFG_CH_DCB_DB_CNT] = 2,
 	[FW_GCB_HW_SGPIO_TO_SD_MAP_CFG_SGPIO_TO_SD_SEL] = 7,
 	[FW_HSCH_SE_CFG_SE_DWRR_CNT] = 5,
@@ -214,6 +227,7 @@ const unsigned int lan969x_fsize[FSIZE_LAST] = {
 	[FW_QSYS_ATOP_ATOP] = 11,
 	[FW_QSYS_ATOP_TOT_CFG_ATOP_TOT] = 11,
 	[FW_REW_RTAG_ETAG_CTRL_IPE_TBL] = 6,
+	[FW_REW_RLEG_CTRL_DECAP_IRLEG] = 7,
 	[FW_XQS_STAT_CFG_STAT_VIEW] = 10,
 	[FW_XQS_QLIMIT_SHR_TOP_CFG_QLIMIT_SHR_TOP] = 14,
 	[FW_XQS_QLIMIT_SHR_ATOP_CFG_QLIMIT_SHR_ATOP] = 14,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index d9ef4ef137b8..9d34750416eb 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0+
  * Microchip Sparx5 Switch driver
  *
- * Copyright (c) 2024 Microchip Technology Inc.
+ * Copyright (c) 2026 Microchip Technology Inc.
  */
 
-/* This file is autogenerated by cml-utils 2024-10-04 10:40:40 +0200.
- * Commit ID: 9d07b8d19363f3cd3590ddb3f7a2e2768e16524b
+/* This file is autogenerated by cml-utils 2026-02-16 21:50:30 +0100.
+ * Commit ID: 09d52195beeeb9682063ef0bd6eec50eebc137e2
  */
 
 #ifndef _SPARX5_MAIN_REGS_H_
@@ -711,6 +711,124 @@ extern const struct sparx5_regs *regs;
 #define ANA_ACL_SWAP_IP_CTRL_IP_SWAP_IP4_TTL_ENA_GET(x)\
 	FIELD_GET(ANA_ACL_SWAP_IP_CTRL_IP_SWAP_IP4_TTL_ENA, x)
 
+/* ANA_ACL:COMMON:VCAP_S2_MISC_CTRL */
+#define ANA_ACL_VCAP_S2_MISC_CTRL                                              \
+	__REG(TARGET_ANA_ACL, 0, 1, regs->gaddr[GA_ANA_ACL_COMMON], 0, 1, 592, \
+	      416, 0, 1, 4)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA GENMASK(27, 24)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA GENMASK(23, 20)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA GENMASK(19, 16)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA GENMASK(15, 12)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA BIT(11)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE BIT(10)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE BIT(9)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA BIT(8)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA BIT(7)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL     GENMASK(6, 5)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA BIT(4)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA BIT(3)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA BIT(2)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA BIT(1)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA BIT(0)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA, x)
+
+/* ANA_ACL:COMMON:VCAP_S2_MISC_CTRL2 */
+#define ANA_ACL_VCAP_S2_MISC_CTRL2                                             \
+	__REG(TARGET_ANA_ACL, 0, 1, regs->gaddr[GA_ANA_ACL_COMMON], 0, 1, 592, \
+	      420, 0, 1, 4)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL2_TWAMP_PIPELINE_PT GENMASK(12, 8)
+#define ANA_ACL_VCAP_S2_MISC_CTRL2_TWAMP_PIPELINE_PT_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL2_TWAMP_PIPELINE_PT, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL2_TWAMP_PIPELINE_PT_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL2_TWAMP_PIPELINE_PT, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_ACTION_ENA GENMASK(7, 4)
+#define ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_ACTION_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_ACTION_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_ACTION_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_ACTION_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_KEY_ENA   GENMASK(3, 0)
+#define ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_KEY_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_KEY_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_KEY_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL2_EGR_KEY_ENA, x)
+
 /* ANA_ACL:COMMON:VCAP_S2_RLEG_STAT */
 #define ANA_ACL_VCAP_S2_RLEG_STAT(r)                                           \
 	__REG(TARGET_ANA_ACL, 0, 1, regs->gaddr[GA_ANA_ACL_COMMON], 0, 1, 592, \
@@ -1812,6 +1930,338 @@ extern const struct sparx5_regs *regs;
 #define ANA_L3_VLAN_CTRL_VLAN_ENA_GET(x)\
 	FIELD_GET(ANA_L3_VLAN_CTRL_VLAN_ENA, x)
 
+/* ANA_L3:COMMON:L3_UC_ENA */
+#define ANA_L3_L3_UC_ENA                                                       \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184, 8,\
+	      0, 1, 4)
+
+/* SPARX5 ONLY */
+/* ANA_L3:COMMON:L3_UC_ENA1 */
+#define ANA_L3_L3_UC_ENA1                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      12, 0, 1, 4)
+
+/* SPARX5 ONLY */
+/* ANA_L3:COMMON:L3_UC_ENA2 */
+#define ANA_L3_L3_UC_ENA2                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      16, 0, 1, 4)
+
+#define ANA_L3_L3_UC_ENA2_L3_UC_ENA2             BIT(0)
+#define ANA_L3_L3_UC_ENA2_L3_UC_ENA2_SET(x)\
+	FIELD_PREP(ANA_L3_L3_UC_ENA2_L3_UC_ENA2, x)
+#define ANA_L3_L3_UC_ENA2_L3_UC_ENA2_GET(x)\
+	FIELD_GET(ANA_L3_L3_UC_ENA2_L3_UC_ENA2, x)
+
+/* ANA_L3:COMMON:ROUTING_CFG */
+#define ANA_L3_ROUTING_CFG                                                     \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      104, 0, 1, 4)
+
+#define ANA_L3_ROUTING_CFG_L3_ENA_MODE           BIT(30)
+#define ANA_L3_ROUTING_CFG_L3_ENA_MODE_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_L3_ENA_MODE, x)
+#define ANA_L3_ROUTING_CFG_L3_ENA_MODE_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_L3_ENA_MODE, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA    BIT(29)
+#define ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA    BIT(28)
+#define ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA    BIT(27)
+#define ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA, x)
+#define ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE GENMASK(26, 25)
+#define ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE, x)
+#define ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_LEN_REDIR         BIT(22)
+#define ANA_L3_ROUTING_CFG_IP6_LEN_REDIR_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_LEN_REDIR, x)
+#define ANA_L3_ROUTING_CFG_IP6_LEN_REDIR_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_LEN_REDIR, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_LEN_REDIR         BIT(21)
+#define ANA_L3_ROUTING_CFG_IP4_LEN_REDIR_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_LEN_REDIR, x)
+#define ANA_L3_ROUTING_CFG_IP4_LEN_REDIR_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_LEN_REDIR, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA    BIT(20)
+#define ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA    BIT(19)
+#define ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA BIT(18)
+#define ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA BIT(17)
+#define ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA GENMASK(16, 15)
+#define ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA GENMASK(13, 11)
+#define ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA GENMASK(10, 8)
+#define ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA GENMASK(7, 5)
+#define ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA BIT(4)
+#define ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA BIT(3)
+#define ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA BIT(2)
+#define ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA      BIT(1)
+#define ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA     BIT(0)
+#define ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA, x)
+
+/* ANA_L3:COMMON:ROUTING_CFG2 */
+#define ANA_L3_ROUTING_CFG2                                                    \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      108, 0, 1, 4)
+
+#define ANA_L3_ROUTING_CFG2_IP6_SIP_LOOKUP_ENA   BIT(4)
+#define ANA_L3_ROUTING_CFG2_IP6_SIP_LOOKUP_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG2_IP6_SIP_LOOKUP_ENA, x)
+#define ANA_L3_ROUTING_CFG2_IP6_SIP_LOOKUP_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG2_IP6_SIP_LOOKUP_ENA, x)
+
+#define ANA_L3_ROUTING_CFG2_IP4_SIP_LOOKUP_ENA   BIT(3)
+#define ANA_L3_ROUTING_CFG2_IP4_SIP_LOOKUP_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG2_IP4_SIP_LOOKUP_ENA, x)
+#define ANA_L3_ROUTING_CFG2_IP4_SIP_LOOKUP_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG2_IP4_SIP_LOOKUP_ENA, x)
+
+#define ANA_L3_ROUTING_CFG2_SIP_IP6PFX_ENA       BIT(1)
+#define ANA_L3_ROUTING_CFG2_SIP_IP6PFX_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG2_SIP_IP6PFX_ENA, x)
+#define ANA_L3_ROUTING_CFG2_SIP_IP6PFX_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG2_SIP_IP6PFX_ENA, x)
+
+#define ANA_L3_ROUTING_CFG2_DIP_IP6PFX_ENA       BIT(0)
+#define ANA_L3_ROUTING_CFG2_DIP_IP6PFX_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG2_DIP_IP6PFX_ENA, x)
+#define ANA_L3_ROUTING_CFG2_DIP_IP6PFX_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG2_DIP_IP6PFX_ENA, x)
+
+#define ANA_L3_ROUTING_CFG2_IP4_DECAP_REDIR_ENA  BIT(2)
+#define ANA_L3_ROUTING_CFG2_IP4_DECAP_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG2_IP4_DECAP_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG2_IP4_DECAP_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG2_IP4_DECAP_REDIR_ENA, x)
+
+/* ANA_L3:COMMON:RLEG_CFG_0 */
+#define ANA_L3_RLEG_CFG_0                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      112, 0, 1, 4)
+
+#define ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB           GENMASK(31, 8)
+#define ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB, x)
+#define ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB, x)
+
+/* ANA_L3:COMMON:RLEG_CFG_1 */
+#define ANA_L3_RLEG_CFG_1                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      116, 0, 1, 4)
+
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL      GENMASK(25, 24)
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB           GENMASK(23, 0)
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB, x)
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB, x)
+
+/* ANA_L3:COMMON:CPU_QU_CFG */
+#define ANA_L3_CPU_QU_CFG                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      120, 0, 1, 4)
+
+#define ANA_L3_CPU_QU_CFG_CPU_RLEG_QU            GENMASK(30, 28)
+#define ANA_L3_CPU_QU_CFG_CPU_RLEG_QU_SET(x)\
+	FIELD_PREP(ANA_L3_CPU_QU_CFG_CPU_RLEG_QU, x)
+#define ANA_L3_CPU_QU_CFG_CPU_RLEG_QU_GET(x)\
+	FIELD_GET(ANA_L3_CPU_QU_CFG_CPU_RLEG_QU, x)
+
+#define ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_OPT_QU     GENMASK(26, 24)
+#define ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_OPT_QU_SET(x)\
+	FIELD_PREP(ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_OPT_QU, x)
+#define ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_OPT_QU_GET(x)\
+	FIELD_GET(ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_OPT_QU, x)
+
+#define ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_HDR_FAIL_QU GENMASK(22, 20)
+#define ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_HDR_FAIL_QU_SET(x)\
+	FIELD_PREP(ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_HDR_FAIL_QU, x)
+#define ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_HDR_FAIL_QU_GET(x)\
+	FIELD_GET(ANA_L3_CPU_QU_CFG_CPU_RLEG_IP_HDR_FAIL_QU, x)
+
+#define ANA_L3_CPU_QU_CFG_CPU_SIP_RPF_QU         GENMASK(18, 16)
+#define ANA_L3_CPU_QU_CFG_CPU_SIP_RPF_QU_SET(x)\
+	FIELD_PREP(ANA_L3_CPU_QU_CFG_CPU_SIP_RPF_QU, x)
+#define ANA_L3_CPU_QU_CFG_CPU_SIP_RPF_QU_GET(x)\
+	FIELD_GET(ANA_L3_CPU_QU_CFG_CPU_SIP_RPF_QU, x)
+
+#define ANA_L3_CPU_QU_CFG_CPU_IP_LEN_QU          GENMASK(14, 12)
+#define ANA_L3_CPU_QU_CFG_CPU_IP_LEN_QU_SET(x)\
+	FIELD_PREP(ANA_L3_CPU_QU_CFG_CPU_IP_LEN_QU, x)
+#define ANA_L3_CPU_QU_CFG_CPU_IP_LEN_QU_GET(x)\
+	FIELD_GET(ANA_L3_CPU_QU_CFG_CPU_IP_LEN_QU, x)
+
+#define ANA_L3_CPU_QU_CFG_CPU_MC_FAIL_QU         GENMASK(10, 8)
+#define ANA_L3_CPU_QU_CFG_CPU_MC_FAIL_QU_SET(x)\
+	FIELD_PREP(ANA_L3_CPU_QU_CFG_CPU_MC_FAIL_QU, x)
+#define ANA_L3_CPU_QU_CFG_CPU_MC_FAIL_QU_GET(x)\
+	FIELD_GET(ANA_L3_CPU_QU_CFG_CPU_MC_FAIL_QU, x)
+
+#define ANA_L3_CPU_QU_CFG_CPU_UC_FAIL_QU         GENMASK(6, 4)
+#define ANA_L3_CPU_QU_CFG_CPU_UC_FAIL_QU_SET(x)\
+	FIELD_PREP(ANA_L3_CPU_QU_CFG_CPU_UC_FAIL_QU, x)
+#define ANA_L3_CPU_QU_CFG_CPU_UC_FAIL_QU_GET(x)\
+	FIELD_GET(ANA_L3_CPU_QU_CFG_CPU_UC_FAIL_QU, x)
+
+#define ANA_L3_CPU_QU_CFG_CPU_IP_TTL_FAIL_QU     GENMASK(2, 0)
+#define ANA_L3_CPU_QU_CFG_CPU_IP_TTL_FAIL_QU_SET(x)\
+	FIELD_PREP(ANA_L3_CPU_QU_CFG_CPU_IP_TTL_FAIL_QU, x)
+#define ANA_L3_CPU_QU_CFG_CPU_IP_TTL_FAIL_QU_GET(x)\
+	FIELD_GET(ANA_L3_CPU_QU_CFG_CPU_IP_TTL_FAIL_QU, x)
+
+/* ANA_L3:COMMON:CPU_QU_CFG2 */
+#define ANA_L3_CPU_QU_CFG2                                                     \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      124, 0, 1, 4)
+
+#define ANA_L3_CPU_QU_CFG2_CPU_IP_DECAP_QU       GENMASK(2, 0)
+#define ANA_L3_CPU_QU_CFG2_CPU_IP_DECAP_QU_SET(x)\
+	FIELD_PREP(ANA_L3_CPU_QU_CFG2_CPU_IP_DECAP_QU, x)
+#define ANA_L3_CPU_QU_CFG2_CPU_IP_DECAP_QU_GET(x)\
+	FIELD_GET(ANA_L3_CPU_QU_CFG2_CPU_IP_DECAP_QU, x)
+
+/* ANA_L3:COMMON:SIP_SECURE_ENA */
+#define ANA_L3_SIP_SECURE_ENA                                                  \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      144, 0, 1, 4)
+
+/* ANA_L3:COMMON:SIP_SECURE_ENA1 */
+#define ANA_L3_SIP_SECURE_ENA1                                                 \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      148, 0, 1, 4)
+
+/* SPARX5 ONLY */
+/* ANA_L3:COMMON:SIP_SECURE_ENA2 */
+#define ANA_L3_SIP_SECURE_ENA2                                                 \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      152, 0, 1, 4)
+
+#define ANA_L3_SIP_SECURE_ENA2_SIP_CMP_ENA2      GENMASK(5, 0)
+#define ANA_L3_SIP_SECURE_ENA2_SIP_CMP_ENA2_SET(x)\
+	FIELD_PREP(ANA_L3_SIP_SECURE_ENA2_SIP_CMP_ENA2, x)
+#define ANA_L3_SIP_SECURE_ENA2_SIP_CMP_ENA2_GET(x)\
+	FIELD_GET(ANA_L3_SIP_SECURE_ENA2_SIP_CMP_ENA2, x)
+
+/* ANA_L3:COMMON:DIP_SECURE_ENA */
+#define ANA_L3_DIP_SECURE_ENA                                                  \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      156, 0, 1, 4)
+
+/* SPARX5 ONLY */
+/* ANA_L3:COMMON:DIP_SECURE_ENA1 */
+#define ANA_L3_DIP_SECURE_ENA1                                                 \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      160, 0, 1, 4)
+
+/* SPARX5 ONLY */
+/* ANA_L3:COMMON:DIP_SECURE_ENA2 */
+#define ANA_L3_DIP_SECURE_ENA2                                                 \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      164, 0, 1, 4)
+
+#define ANA_L3_DIP_SECURE_ENA2_DIP_CMP_ENA2      BIT(0)
+#define ANA_L3_DIP_SECURE_ENA2_DIP_CMP_ENA2_SET(x)\
+	FIELD_PREP(ANA_L3_DIP_SECURE_ENA2_DIP_CMP_ENA2, x)
+#define ANA_L3_DIP_SECURE_ENA2_DIP_CMP_ENA2_GET(x)\
+	FIELD_GET(ANA_L3_DIP_SECURE_ENA2_DIP_CMP_ENA2, x)
+
+/* ANA_L3:VLAN:VMID_CFG */
+#define ANA_L3_VMID_CFG(g)                                                     \
+	__REG(TARGET_ANA_L3, 0, 1, 0, g, regs->gcnt[GC_ANA_L3_VLAN], 64, 0, 0, \
+	      1, 4)
+
+#define ANA_L3_VMID_CFG_VMID\
+	GENMASK(regs->fsize[FW_ANA_L3_VMID_CFG_VMID] + 0 - 1, 0)
+#define ANA_L3_VMID_CFG_VMID_SET(x)\
+	spx5_field_prep(ANA_L3_VMID_CFG_VMID, x)
+#define ANA_L3_VMID_CFG_VMID_GET(x)\
+	spx5_field_get(ANA_L3_VMID_CFG_VMID, x)
+
 /* ANA_L3:VLAN:VLAN_CFG */
 #define ANA_L3_VLAN_CFG(g)                                                     \
 	__REG(TARGET_ANA_L3, 0, 1, 0, g, regs->gcnt[GC_ANA_L3_VLAN], 64, 8, 0, \
@@ -1871,6 +2321,13 @@ extern const struct sparx5_regs *regs;
 #define ANA_L3_VLAN_CFG_VLAN_MIRROR_ENA_GET(x)\
 	FIELD_GET(ANA_L3_VLAN_CFG_VLAN_MIRROR_ENA, x)
 
+/* LAN969X ONLY */
+#define ANA_L3_VLAN_CFG_VLAN_PGID_CPU_DIS        BIT(31)
+#define ANA_L3_VLAN_CFG_VLAN_PGID_CPU_DIS_SET(x)\
+	FIELD_PREP(ANA_L3_VLAN_CFG_VLAN_PGID_CPU_DIS, x)
+#define ANA_L3_VLAN_CFG_VLAN_PGID_CPU_DIS_GET(x)\
+	FIELD_GET(ANA_L3_VLAN_CFG_VLAN_PGID_CPU_DIS, x)
+
 /* ANA_L3:VLAN:VLAN_MASK_CFG */
 #define ANA_L3_VLAN_MASK_CFG(g)                                                \
 	__REG(TARGET_ANA_L3, 0, 1, 0, g, regs->gcnt[GC_ANA_L3_VLAN], 64, 16, 0,\
@@ -1894,6 +2351,154 @@ extern const struct sparx5_regs *regs;
 #define ANA_L3_VLAN_MASK_CFG2_VLAN_PORT_MASK2_GET(x)\
 	FIELD_GET(ANA_L3_VLAN_MASK_CFG2_VLAN_PORT_MASK2, x)
 
+/* ANA_L3:VMID:RLEG_CTRL */
+#define ANA_L3_RLEG_CTRL(g)                                                    \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_VMID], g,             \
+	      regs->gcnt[GC_ANA_L3_VMID], 64, 0, 0, 1, 4)
+
+#define ANA_L3_RLEG_CTRL_RLEG_EVID               GENMASK(31, 19)
+#define ANA_L3_RLEG_CTRL_RLEG_EVID_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_EVID, x)
+#define ANA_L3_RLEG_CTRL_RLEG_EVID_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_EVID, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA BIT(18)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA BIT(17)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE   GENMASK(15, 14)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE   GENMASK(13, 12)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS   BIT(9)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS   BIT(8)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA         BIT(7)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA         BIT(6)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA         BIT(5)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA         BIT(4)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA BIT(3)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA BIT(2)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA       BIT(1)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA       BIT(0)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA, x)
+
+/* ANA_L3:ARP:ARP_CFG_0 */
+#define ANA_L3_ARP_CFG_0(g)                                                    \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_ARP], g,              \
+	      regs->gcnt[GC_ANA_L3_ARP], 32, 0, 0, 1, 4)
+
+#define ANA_L3_ARP_CFG_0_MAC_MSB                 GENMASK(31, 16)
+#define ANA_L3_ARP_CFG_0_MAC_MSB_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_MAC_MSB, x)
+#define ANA_L3_ARP_CFG_0_MAC_MSB_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_MAC_MSB, x)
+
+#define ANA_L3_ARP_CFG_0_ARP_VMID\
+	GENMASK(regs->fsize[FW_ANA_L3_ARP_CFG_0_ARP_VMID] + 7 - 1, 7)
+#define ANA_L3_ARP_CFG_0_ARP_VMID_SET(x)\
+	spx5_field_prep(ANA_L3_ARP_CFG_0_ARP_VMID, x)
+#define ANA_L3_ARP_CFG_0_ARP_VMID_GET(x)\
+	spx5_field_get(ANA_L3_ARP_CFG_0_ARP_VMID, x)
+
+#define ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU        GENMASK(6, 4)
+#define ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU, x)
+#define ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU, x)
+
+#define ANA_L3_ARP_CFG_0_SIP_RPF_ENA             BIT(3)
+#define ANA_L3_ARP_CFG_0_SIP_RPF_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_SIP_RPF_ENA, x)
+#define ANA_L3_ARP_CFG_0_SIP_RPF_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_SIP_RPF_ENA, x)
+
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA    BIT(2)
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA, x)
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA, x)
+
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA     BIT(1)
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA, x)
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA, x)
+
+#define ANA_L3_ARP_CFG_0_ARP_ENA                 BIT(0)
+#define ANA_L3_ARP_CFG_0_ARP_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_ARP_ENA, x)
+#define ANA_L3_ARP_CFG_0_ARP_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_ARP_ENA, x)
+
+/* ANA_L3:ARP:ARP_CFG_1 */
+#define ANA_L3_ARP_CFG_1(g)                                                    \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_ARP], g,              \
+	      regs->gcnt[GC_ANA_L3_ARP], 32, 4, 0, 1, 4)
+
 /* ASM:DEV_STATISTICS:RX_IN_BYTES_CNT */
 #define ASM_RX_IN_BYTES_CNT(g)                                                 \
 	__REG(TARGET_ASM, 0, 1, 0, g, regs->gcnt[GC_ASM_DEV_STATISTICS], 512,  \
@@ -4515,6 +5120,34 @@ extern const struct sparx5_regs *regs;
 #define DSM_TAXI_CAL_CFG_CAL_PGM_SEL_GET(x)\
 	FIELD_GET(DSM_TAXI_CAL_CFG_CAL_PGM_SEL, x)
 
+/* EACL:COMMON:RLEG_CFG_0 */
+#define EACL_RLEG_CFG_0                                                        \
+	__REG(TARGET_EACL, 0, 1, regs->gaddr[GA_EACL_COMMON], 0, 1, 216, 64, 0,\
+	      1, 4)
+
+#define EACL_RLEG_CFG_0_RLEG_MAC_LSB             GENMASK(23, 0)
+#define EACL_RLEG_CFG_0_RLEG_MAC_LSB_SET(x)\
+	FIELD_PREP(EACL_RLEG_CFG_0_RLEG_MAC_LSB, x)
+#define EACL_RLEG_CFG_0_RLEG_MAC_LSB_GET(x)\
+	FIELD_GET(EACL_RLEG_CFG_0_RLEG_MAC_LSB, x)
+
+/* EACL:COMMON:RLEG_CFG_1 */
+#define EACL_RLEG_CFG_1                                                        \
+	__REG(TARGET_EACL, 0, 1, regs->gaddr[GA_EACL_COMMON], 0, 1, 216, 68, 0,\
+	      1, 4)
+
+#define EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL        GENMASK(25, 24)
+#define EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(x)\
+	FIELD_PREP(EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+#define EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_GET(x)\
+	FIELD_GET(EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+
+#define EACL_RLEG_CFG_1_RLEG_MAC_MSB             GENMASK(23, 0)
+#define EACL_RLEG_CFG_1_RLEG_MAC_MSB_SET(x)\
+	FIELD_PREP(EACL_RLEG_CFG_1_RLEG_MAC_MSB, x)
+#define EACL_RLEG_CFG_1_RLEG_MAC_MSB_GET(x)\
+	FIELD_GET(EACL_RLEG_CFG_1_RLEG_MAC_MSB, x)
+
 /* EACL:ES2_KEY_SELECT_PROFILE:VCAP_ES2_KEY_SEL */
 #define EACL_VCAP_ES2_KEY_SEL(g, r)                                            \
 	__REG(TARGET_EACL, 0, 1, regs->gaddr[GA_EACL_ES2_KEY_SELECT_PROFILE],  \
@@ -7341,6 +7974,34 @@ extern const struct sparx5_regs *regs;
 #define REW_ES0_CTRL_ES0_LU_ENA_GET(x)\
 	FIELD_GET(REW_ES0_CTRL_ES0_LU_ENA, x)
 
+/* REW:COMMON:RLEG_CFG_0 */
+#define REW_RLEG_CFG_0                                                         \
+	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_COMMON], 0, 1, 1232, 1156,  \
+	      0, 1, 4)
+
+#define REW_RLEG_CFG_0_RLEG_MAC_LSB              GENMASK(23, 0)
+#define REW_RLEG_CFG_0_RLEG_MAC_LSB_SET(x)\
+	FIELD_PREP(REW_RLEG_CFG_0_RLEG_MAC_LSB, x)
+#define REW_RLEG_CFG_0_RLEG_MAC_LSB_GET(x)\
+	FIELD_GET(REW_RLEG_CFG_0_RLEG_MAC_LSB, x)
+
+/* REW:COMMON:RLEG_CFG_1 */
+#define REW_RLEG_CFG_1                                                         \
+	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_COMMON], 0, 1, 1232, 1160,  \
+	      0, 1, 4)
+
+#define REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL         GENMASK(25, 24)
+#define REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(x)\
+	FIELD_PREP(REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+#define REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_GET(x)\
+	FIELD_GET(REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+
+#define REW_RLEG_CFG_1_RLEG_MAC_MSB              GENMASK(23, 0)
+#define REW_RLEG_CFG_1_RLEG_MAC_MSB_SET(x)\
+	FIELD_PREP(REW_RLEG_CFG_1_RLEG_MAC_MSB, x)
+#define REW_RLEG_CFG_1_RLEG_MAC_MSB_GET(x)\
+	FIELD_GET(REW_RLEG_CFG_1_RLEG_MAC_MSB, x)
+
 /* REW:PORT:PORT_VLAN_CFG */
 #define REW_PORT_VLAN_CFG(g)                                                   \
 	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_PORT], g,                   \
@@ -7567,6 +8228,30 @@ extern const struct sparx5_regs *regs;
 #define REW_PTP_GEN_STAMP_FMT_RT_FMT_GET(x)\
 	FIELD_GET(REW_PTP_GEN_STAMP_FMT_RT_FMT, x)
 
+/* REW:VMID:RLEG_CTRL */
+#define REW_RLEG_CTRL(g)                                                       \
+	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_VMID], g,                   \
+	      regs->gcnt[GC_REW_VMID], 4, 0, 0, 1, 4)
+
+#define REW_RLEG_CTRL_DECAP_IRLEG\
+	GENMASK(regs->fsize[FW_REW_RLEG_CTRL_DECAP_IRLEG] + 13 - 1, 13)
+#define REW_RLEG_CTRL_DECAP_IRLEG_SET(x)\
+	spx5_field_prep(REW_RLEG_CTRL_DECAP_IRLEG, x)
+#define REW_RLEG_CTRL_DECAP_IRLEG_GET(x)\
+	spx5_field_get(REW_RLEG_CTRL_DECAP_IRLEG, x)
+
+#define REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED     BIT(12)
+#define REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED_SET(x)\
+	FIELD_PREP(REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED, x)
+#define REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED_GET(x)\
+	FIELD_GET(REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED, x)
+
+#define REW_RLEG_CTRL_RLEG_EVID                  GENMASK(11, 0)
+#define REW_RLEG_CTRL_RLEG_EVID_SET(x)\
+	FIELD_PREP(REW_RLEG_CTRL_RLEG_EVID, x)
+#define REW_RLEG_CTRL_RLEG_EVID_GET(x)\
+	FIELD_GET(REW_RLEG_CTRL_RLEG_EVID, x)
+
 /* REW:RAM_CTRL:RAM_INIT */
 #define REW_RAM_INIT                                                           \
 	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_RAM_CTRL], 0, 1, 4, 0, 0, 1,\
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
index 220e81b714d4..5fc11403ddf6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Microchip Sparx5 Switch driver
  *
- * Copyright (c) 2024 Microchip Technology Inc.
+ * Copyright (c) 2026 Microchip Technology Inc.
  */
 
-/* This file is autogenerated by cml-utils 2024-09-30 11:48:29 +0200.
- * Commit ID: 9d07b8d19363f3cd3590ddb3f7a2e2768e16524b
+/* This file is autogenerated by cml-utils 2026-02-16 21:50:29 +0100.
+ * Commit ID: 09d52195beeeb9682063ef0bd6eec50eebc137e2
  */
 
 #include "sparx5_regs.h"
@@ -77,12 +77,16 @@ const unsigned int sparx5_gaddr[GADDR_LAST] = {
 	[GA_ANA_CL_COMMON] = 166912,
 	[GA_ANA_L2_COMMON] = 566024,
 	[GA_ANA_L3_COMMON] = 493632,
+	[GA_ANA_L3_VMID] = 458752,
+	[GA_ANA_L3_ARP_PTR_REMAP] = 493824,
+	[GA_ANA_L3_ARP] = 327680,
 	[GA_ANA_L3_VLAN_ARP_L3MC_STICKY] = 491460,
 	[GA_ASM_CFG] = 33280,
 	[GA_ASM_PFC_TIMER_CFG] = 34716,
 	[GA_ASM_LBK_WM_CFG] = 34744,
 	[GA_ASM_LBK_MISC_CFG] = 34756,
 	[GA_ASM_RAM_CTRL] = 34832,
+	[GA_EACL_COMMON] = 118480,
 	[GA_EACL_ES2_KEY_SELECT_PROFILE] = 149504,
 	[GA_EACL_CNT_TBL] = 122880,
 	[GA_EACL_POL_CFG] = 150608,
@@ -102,6 +106,7 @@ const unsigned int sparx5_gaddr[GADDR_LAST] = {
 	[GA_QSYS_RAM_CTRL] = 2344,
 	[GA_REW_COMMON] = 387264,
 	[GA_REW_PORT] = 360448,
+	[GA_REW_VMID] = 389120,
 	[GA_REW_VOE_PORT_LM_CNT] = 393216,
 	[GA_REW_RAM_CTRL] = 378696,
 	[GA_VOP_RAM_CTRL] = 279176,
@@ -123,6 +128,8 @@ const unsigned int sparx5_gcnt[GCNT_LAST] = {
 	[GC_ANA_L2_ISDX_LIMIT] = 1536,
 	[GC_ANA_L2_ISDX] = 4096,
 	[GC_ANA_L3_VLAN] = 5120,
+	[GC_ANA_L3_VMID] = 511,
+	[GC_ANA_L3_ARP] = 2048,
 	[GC_ASM_DEV_STATISTICS] = 65,
 	[GC_EACL_ES2_KEY_SELECT_PROFILE] = 138,
 	[GC_EACL_CNT_TBL] = 2048,
@@ -132,6 +139,7 @@ const unsigned int sparx5_gcnt[GCNT_LAST] = {
 	[GC_PTP_PTP_PINS] = 5,
 	[GC_PTP_PHASE_DETECTOR_CTRL] = 5,
 	[GC_REW_PORT] = 70,
+	[GC_REW_VMID] = 511,
 	[GC_REW_VOE_PORT_LM_CNT] = 520,
 };
 
@@ -188,7 +196,12 @@ const unsigned int sparx5_fsize[FSIZE_LAST] = {
 	[FW_ANA_L2_AUTO_LRN_CFG_AUTO_LRN_ENA] = 32,
 	[FW_ANA_L2_DLB_CFG_DLB_IDX] = 13,
 	[FW_ANA_L2_TSN_CFG_TSN_SFID] = 10,
+	[FW_ANA_L3_L3_UC_ENA_L3_UC_ENA] = 32,
+	[FW_ANA_L3_SIP_SECURE_ENA1_SIP_CMP_ENA1] = 32,
+	[FW_ANA_L3_DIP_SECURE_ENA_DIP_CMP_ENA] = 32,
+	[FW_ANA_L3_VMID_CFG_VMID] = 9,
 	[FW_ANA_L3_VLAN_MASK_CFG_VLAN_PORT_MASK] = 32,
+	[FW_ANA_L3_ARP_CFG_0_ARP_VMID] = 9,
 	[FW_FDMA_CH_CFG_CH_DCB_DB_CNT] = 4,
 	[FW_GCB_HW_SGPIO_TO_SD_MAP_CFG_SGPIO_TO_SD_SEL] = 9,
 	[FW_HSCH_SE_CFG_SE_DWRR_CNT] = 7,
@@ -214,6 +227,7 @@ const unsigned int sparx5_fsize[FSIZE_LAST] = {
 	[FW_QSYS_ATOP_ATOP] = 12,
 	[FW_QSYS_ATOP_TOT_CFG_ATOP_TOT] = 12,
 	[FW_REW_RTAG_ETAG_CTRL_IPE_TBL] = 7,
+	[FW_REW_RLEG_CTRL_DECAP_IRLEG] = 9,
 	[FW_XQS_STAT_CFG_STAT_VIEW] = 13,
 	[FW_XQS_QLIMIT_SHR_TOP_CFG_QLIMIT_SHR_TOP] = 15,
 	[FW_XQS_QLIMIT_SHR_ATOP_CFG_QLIMIT_SHR_ATOP] = 15,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
index ea28130c2341..28dca1ed4ea7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /* Microchip Sparx5 Switch driver
  *
- * Copyright (c) 2024 Microchip Technology Inc.
+ * Copyright (c) 2026 Microchip Technology Inc.
  */
 
-/* This file is autogenerated by cml-utils 2024-09-30 11:48:29 +0200.
- * Commit ID: 9d07b8d19363f3cd3590ddb3f7a2e2768e16524b
+/* This file is autogenerated by cml-utils 2026-02-16 21:50:30 +0100.
+ * Commit ID: 09d52195beeeb9682063ef0bd6eec50eebc137e2
  */
 
 #ifndef _SPARX5_REGS_H_
@@ -86,12 +86,16 @@ enum sparx5_gaddr_enum {
 	GA_ANA_CL_COMMON,
 	GA_ANA_L2_COMMON,
 	GA_ANA_L3_COMMON,
+	GA_ANA_L3_VMID,
+	GA_ANA_L3_ARP_PTR_REMAP,
+	GA_ANA_L3_ARP,
 	GA_ANA_L3_VLAN_ARP_L3MC_STICKY,
 	GA_ASM_CFG,
 	GA_ASM_PFC_TIMER_CFG,
 	GA_ASM_LBK_WM_CFG,
 	GA_ASM_LBK_MISC_CFG,
 	GA_ASM_RAM_CTRL,
+	GA_EACL_COMMON,
 	GA_EACL_ES2_KEY_SELECT_PROFILE,
 	GA_EACL_CNT_TBL,
 	GA_EACL_POL_CFG,
@@ -111,6 +115,7 @@ enum sparx5_gaddr_enum {
 	GA_QSYS_RAM_CTRL,
 	GA_REW_COMMON,
 	GA_REW_PORT,
+	GA_REW_VMID,
 	GA_REW_VOE_PORT_LM_CNT,
 	GA_REW_RAM_CTRL,
 	GA_VOP_RAM_CTRL,
@@ -133,6 +138,8 @@ enum sparx5_gcnt_enum {
 	GC_ANA_L2_ISDX_LIMIT,
 	GC_ANA_L2_ISDX,
 	GC_ANA_L3_VLAN,
+	GC_ANA_L3_VMID,
+	GC_ANA_L3_ARP,
 	GC_ASM_DEV_STATISTICS,
 	GC_EACL_ES2_KEY_SELECT_PROFILE,
 	GC_EACL_CNT_TBL,
@@ -142,6 +149,7 @@ enum sparx5_gcnt_enum {
 	GC_PTP_PTP_PINS,
 	GC_PTP_PHASE_DETECTOR_CTRL,
 	GC_REW_PORT,
+	GC_REW_VMID,
 	GC_REW_VOE_PORT_LM_CNT,
 	GCNT_LAST,
 };
@@ -201,7 +209,12 @@ enum sparx5_fsize_enum {
 	FW_ANA_L2_AUTO_LRN_CFG_AUTO_LRN_ENA,
 	FW_ANA_L2_DLB_CFG_DLB_IDX,
 	FW_ANA_L2_TSN_CFG_TSN_SFID,
+	FW_ANA_L3_L3_UC_ENA_L3_UC_ENA,
+	FW_ANA_L3_SIP_SECURE_ENA1_SIP_CMP_ENA1,
+	FW_ANA_L3_DIP_SECURE_ENA_DIP_CMP_ENA,
+	FW_ANA_L3_VMID_CFG_VMID,
 	FW_ANA_L3_VLAN_MASK_CFG_VLAN_PORT_MASK,
+	FW_ANA_L3_ARP_CFG_0_ARP_VMID,
 	FW_FDMA_CH_CFG_CH_DCB_DB_CNT,
 	FW_GCB_HW_SGPIO_TO_SD_MAP_CFG_SGPIO_TO_SD_SEL,
 	FW_HSCH_SE_CFG_SE_DWRR_CNT,
@@ -227,6 +240,7 @@ enum sparx5_fsize_enum {
 	FW_QSYS_ATOP_ATOP,
 	FW_QSYS_ATOP_TOT_CFG_ATOP_TOT,
 	FW_REW_RTAG_ETAG_CTRL_IPE_TBL,
+	FW_REW_RLEG_CTRL_DECAP_IRLEG,
 	FW_XQS_STAT_CFG_STAT_VIEW,
 	FW_XQS_QLIMIT_SHR_TOP_CFG_QLIMIT_SHR_TOP,
 	FW_XQS_QLIMIT_SHR_ATOP_CFG_QLIMIT_SHR_ATOP,

-- 
2.52.0


