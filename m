Return-Path: <netdev+bounces-298631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1oc7NfX9K2qXJAQAu9opvQ
	(envelope-from <netdev+bounces-298631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:39:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6877A67965B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:39:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b="Leo/L/kZ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298631-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298631-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93D2A300D37F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942CB3E2763;
	Fri, 12 Jun 2026 12:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15D3E1D19;
	Fri, 12 Jun 2026 12:38:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267925; cv=none; b=lcfXOUybPUVccwUB3rKIJq6PR0v54/d4peSBrvBBvJ3+TRanFeEclVLx0Lh667kLU4CY6SU1RbukMayWA6HXDdx8RQFIZSioqb4XMgweMDgWjljF1TSWQ99NgZ3Z8MviBk2uS66l6fRBLAc3GJjI/48cVo3ACU8kW8f88yIQUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267925; c=relaxed/simple;
	bh=Nn2DOQcfRMeVSJAePSj9gemQ1U/m2ZgFI/VZ3VyW07U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ebZLCFBlluIwpD7YtHls80psRRn1ph/JOPeOFXic7ao5Wte4pxXYIUXclrG5R9f5xONBASQoZJXH5BYEB81uxO5oHPx2Dq2Q697EUKtNT5/gzVo2X/hnkvqyfDPzgmKvIj3Jy3rTMeo2+Z70Ry+YY+3OmupU0l8TSmLPnyymXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Leo/L/kZ; arc=none smtp.client-ip=68.232.154.123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781267922; x=1812803922;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Nn2DOQcfRMeVSJAePSj9gemQ1U/m2ZgFI/VZ3VyW07U=;
  b=Leo/L/kZZFoVCJNXOvgRD/BDlop4V8kV5RKY+7o11eXVqziKTuXZMY+Y
   wEd8spwDfL2RqRItsA7ANFFVR4sPD3jV5LnvQm2DBbawlJ8TDDXGuV9fo
   Oe8zkxCoCdiafnDZ95TjVjIWhBMyh3IWX1P8h9BRctE2jmVXP0Ng6IaYO
   cZ6ek+yqYIL6lzc3t3TGyAjLl341PqEjZ1AX7Hy3qwGZRpSBAV0uD8dDv
   Q8IikywP4EAbXIpu5AM84ys/eIQqSuh0cHCHkfrFjsIWQzXz2HpwH9Tex
   E/8fpaHjEiz5ZWqgck5Tybwa842oax/DDQdM0TiM60qcqgqstN62Ol5jj
   Q==;
X-CSE-ConnectionGUID: se6h7meMQ3G7ytxgB+zeiw==
X-CSE-MsgGUID: r0ZZLPdOSYupvGQfVchyBQ==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="59410169"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2026 05:38:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 12 Jun 2026 05:38:40 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 05:38:38 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 12 Jun 2026 14:37:11 +0200
Subject: [PATCH net-next 2/9] net: microchip: vcap: add lpm vcap to autogen
 vcap api
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-sparx5_l3_routing-v1-2-fc3c10160f49@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298631-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6877A67965B

Add autogenerated VCAP rule encoding metadata, and VCAP parameters for
the LPM VCAP used for L3 routing.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_vcap_ag_api.c | 373 ++++++++++++++++++++-
 .../ethernet/microchip/sparx5/sparx5_vcap_ag_api.c | 373 ++++++++++++++++++++-
 .../ethernet/microchip/sparx5/sparx5_vcap_ag_api.h |   6 +-
 drivers/net/ethernet/microchip/vcap/vcap_ag_api.h  |  94 +++++-
 .../net/ethernet/microchip/vcap/vcap_model_kunit.c |   6 +-
 5 files changed, 832 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_ag_api.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_ag_api.c
index 7acc5bcf337a..e623b1dbe9cb 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_ag_api.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_ag_api.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause
-/* Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries.
+/* Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries.
  * Microchip VCAP API
  */
 
-/* This file is autogenerated by cml-utils 2024-10-07 11:10:56 +0200.
- * Commit ID: b5ddc8e244eb2481a9524f1ddc630a8b41e7c391
+/* This file is autogenerated by cml-utils 2026-04-28 13:55:50 +0200.
+ * Commit ID: cd2494df16a1d3b14f650f720f6a8126b88b553a
  */
 
 #include <linux/types.h>
@@ -1380,6 +1380,83 @@ static const struct vcap_field es0_isdx_keyfield[] = {
 	},
 };
 
+static const struct vcap_field lpm_sgl_ip4_keyfield[] = {
+	[VCAP_KF_DST_FLAG] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 0,
+		.width = 1,
+	},
+	[VCAP_KF_AFFIX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 1,
+		.width = 10,
+	},
+	[VCAP_KF_IP4_XIP] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 11,
+		.width = 32,
+	},
+};
+
+static const struct vcap_field lpm_dbl_ip4_keyfield[] = {
+	[VCAP_KF_TYPE] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 0,
+		.width = 1,
+	},
+	[VCAP_KF_AFFIX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 1,
+		.width = 10,
+	},
+	[VCAP_KF_IP4_SIP] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 11,
+		.width = 32,
+	},
+	[VCAP_KF_IP4_DIP] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 43,
+		.width = 32,
+	},
+};
+
+static const struct vcap_field lpm_sgl_ip6_keyfield[] = {
+	[VCAP_KF_DST_FLAG] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 0,
+		.width = 1,
+	},
+	[VCAP_KF_AFFIX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 1,
+		.width = 10,
+	},
+	[VCAP_KF_IP6_XIP] = {
+		.type = VCAP_FIELD_U128,
+		.offset = 11,
+		.width = 128,
+	},
+};
+
+static const struct vcap_field lpm_dbl_ip6_keyfield[] = {
+	[VCAP_KF_AFFIX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 0,
+		.width = 10,
+	},
+	[VCAP_KF_IP6_SIP] = {
+		.type = VCAP_FIELD_U128,
+		.offset = 10,
+		.width = 128,
+	},
+	[VCAP_KF_IP6_DIP] = {
+		.type = VCAP_FIELD_U128,
+		.offset = 138,
+		.width = 128,
+	},
+};
+
 static const struct vcap_field es2_mac_etype_keyfield[] = {
 	[VCAP_KF_TYPE] = {
 		.type = VCAP_FIELD_U32,
@@ -2338,6 +2415,29 @@ static const struct vcap_set es0_keyfield_set[] = {
 	},
 };
 
+static const struct vcap_set lpm_keyfield_set[] = {
+	[VCAP_KFS_SGL_IP4] = {
+		.type_id = -1,
+		.sw_per_item = 1,
+		.sw_cnt = 12,
+	},
+	[VCAP_KFS_DBL_IP4] = {
+		.type_id = 0,
+		.sw_per_item = 2,
+		.sw_cnt = 6,
+	},
+	[VCAP_KFS_SGL_IP6] = {
+		.type_id = -1,
+		.sw_per_item = 3,
+		.sw_cnt = 4,
+	},
+	[VCAP_KFS_DBL_IP6] = {
+		.type_id = -1,
+		.sw_per_item = 6,
+		.sw_cnt = 2,
+	},
+};
+
 static const struct vcap_set es2_keyfield_set[] = {
 	[VCAP_KFS_MAC_ETYPE] = {
 		.type_id = 0,
@@ -2390,6 +2490,13 @@ static const struct vcap_field *es0_keyfield_set_map[] = {
 	[VCAP_KFS_ISDX] = es0_isdx_keyfield,
 };
 
+static const struct vcap_field *lpm_keyfield_set_map[] = {
+	[VCAP_KFS_SGL_IP4] = lpm_sgl_ip4_keyfield,
+	[VCAP_KFS_DBL_IP4] = lpm_dbl_ip4_keyfield,
+	[VCAP_KFS_SGL_IP6] = lpm_sgl_ip6_keyfield,
+	[VCAP_KFS_DBL_IP6] = lpm_dbl_ip6_keyfield,
+};
+
 static const struct vcap_field *es2_keyfield_set_map[] = {
 	[VCAP_KFS_MAC_ETYPE] = es2_mac_etype_keyfield,
 	[VCAP_KFS_ARP] = es2_arp_keyfield,
@@ -2418,6 +2525,13 @@ static int es0_keyfield_set_map_size[] = {
 	[VCAP_KFS_ISDX] = ARRAY_SIZE(es0_isdx_keyfield),
 };
 
+static int lpm_keyfield_set_map_size[] = {
+	[VCAP_KFS_SGL_IP4] = ARRAY_SIZE(lpm_sgl_ip4_keyfield),
+	[VCAP_KFS_DBL_IP4] = ARRAY_SIZE(lpm_dbl_ip4_keyfield),
+	[VCAP_KFS_SGL_IP6] = ARRAY_SIZE(lpm_sgl_ip6_keyfield),
+	[VCAP_KFS_DBL_IP6] = ARRAY_SIZE(lpm_dbl_ip6_keyfield),
+};
+
 static int es2_keyfield_set_map_size[] = {
 	[VCAP_KFS_MAC_ETYPE] = ARRAY_SIZE(es2_mac_etype_keyfield),
 	[VCAP_KFS_ARP] = ARRAY_SIZE(es2_arp_keyfield),
@@ -2993,6 +3107,92 @@ static const struct vcap_field es0_es0_actionfield[] = {
 	},
 };
 
+static const struct vcap_field lpm_arp_ptr_actionfield[] = {
+	[VCAP_AF_TYPE] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 0,
+		.width = 2,
+	},
+	[VCAP_AF_ARP_PTR] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 2,
+		.width = 10,
+	},
+	[VCAP_AF_ARP_PTR_REMAP_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 12,
+		.width = 1,
+	},
+	[VCAP_AF_ECMP_CNT] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 13,
+		.width = 4,
+	},
+	[VCAP_AF_RGID] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 17,
+		.width = 3,
+	},
+};
+
+static const struct vcap_field lpm_arp_entry_actionfield[] = {
+	[VCAP_AF_TYPE] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 0,
+		.width = 2,
+	},
+	[VCAP_AF_MAC_MSB] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 2,
+		.width = 16,
+	},
+	[VCAP_AF_MAC_LSB] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 18,
+		.width = 32,
+	},
+	[VCAP_AF_ARP_VMID] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 50,
+		.width = 7,
+	},
+	[VCAP_AF_ZERO_DMAC_CPU_QU] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 57,
+		.width = 3,
+	},
+	[VCAP_AF_SIP_RPF_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 60,
+		.width = 1,
+	},
+	[VCAP_AF_SECUR_MATCH_VMID_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 61,
+		.width = 1,
+	},
+	[VCAP_AF_SECUR_MATCH_MAC_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 62,
+		.width = 1,
+	},
+	[VCAP_AF_ARP_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 63,
+		.width = 1,
+	},
+	[VCAP_AF_ENCAP_ID] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 64,
+		.width = 8,
+	},
+	[VCAP_AF_RSDX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 72,
+		.width = 10,
+	},
+};
+
 static const struct vcap_field es2_base_type_actionfield[] = {
 	[VCAP_AF_HIT_ME_ONCE] = {
 		.type = VCAP_FIELD_BIT,
@@ -3101,6 +3301,19 @@ static const struct vcap_set es0_actionfield_set[] = {
 	},
 };
 
+static const struct vcap_set lpm_actionfield_set[] = {
+	[VCAP_AFS_ARP_PTR] = {
+		.type_id = 0,
+		.sw_per_item = 1,
+		.sw_cnt = 12,
+	},
+	[VCAP_AFS_ARP_ENTRY] = {
+		.type_id = 2,
+		.sw_per_item = 1,
+		.sw_cnt = 12,
+	},
+};
+
 static const struct vcap_set es2_actionfield_set[] = {
 	[VCAP_AFS_BASE_TYPE] = {
 		.type_id = -1,
@@ -3124,6 +3337,11 @@ static const struct vcap_field *es0_actionfield_set_map[] = {
 	[VCAP_AFS_ES0] = es0_es0_actionfield,
 };
 
+static const struct vcap_field *lpm_actionfield_set_map[] = {
+	[VCAP_AFS_ARP_PTR] = lpm_arp_ptr_actionfield,
+	[VCAP_AFS_ARP_ENTRY] = lpm_arp_entry_actionfield,
+};
+
 static const struct vcap_field *es2_actionfield_set_map[] = {
 	[VCAP_AFS_BASE_TYPE] = es2_base_type_actionfield,
 };
@@ -3143,6 +3361,11 @@ static int es0_actionfield_set_map_size[] = {
 	[VCAP_AFS_ES0] = ARRAY_SIZE(es0_es0_actionfield),
 };
 
+static int lpm_actionfield_set_map_size[] = {
+	[VCAP_AFS_ARP_PTR] = ARRAY_SIZE(lpm_arp_ptr_actionfield),
+	[VCAP_AFS_ARP_ENTRY] = ARRAY_SIZE(lpm_arp_entry_actionfield),
+};
+
 static int es2_actionfield_set_map_size[] = {
 	[VCAP_AFS_BASE_TYPE] = ARRAY_SIZE(es2_base_type_actionfield),
 };
@@ -3308,6 +3531,82 @@ static const struct vcap_typegroup es0_x1_keyfield_set_typegroups[] = {
 	{}
 };
 
+static const struct vcap_typegroup lpm_x6_keyfield_set_typegroups[] = {
+	{
+		.offset = 0,
+		.width = 4,
+		.value = 8,
+	},
+	{
+		.offset = 52,
+		.width = 1,
+		.value = 0,
+	},
+	{
+		.offset = 104,
+		.width = 2,
+		.value = 0,
+	},
+	{
+		.offset = 156,
+		.width = 3,
+		.value = 0,
+	},
+	{
+		.offset = 208,
+		.width = 2,
+		.value = 0,
+	},
+	{
+		.offset = 260,
+		.width = 1,
+		.value = 0,
+	},
+	{}
+};
+
+static const struct vcap_typegroup lpm_x3_keyfield_set_typegroups[] = {
+	{
+		.offset = 0,
+		.width = 3,
+		.value = 4,
+	},
+	{
+		.offset = 52,
+		.width = 2,
+		.value = 0,
+	},
+	{
+		.offset = 104,
+		.width = 2,
+		.value = 0,
+	},
+	{}
+};
+
+static const struct vcap_typegroup lpm_x2_keyfield_set_typegroups[] = {
+	{
+		.offset = 0,
+		.width = 2,
+		.value = 2,
+	},
+	{
+		.offset = 52,
+		.width = 1,
+		.value = 0,
+	},
+	{}
+};
+
+static const struct vcap_typegroup lpm_x1_keyfield_set_typegroups[] = {
+	{
+		.offset = 0,
+		.width = 1,
+		.value = 1,
+	},
+	{}
+};
+
 static const struct vcap_typegroup es2_x12_keyfield_set_typegroups[] = {
 	{
 		.offset = 0,
@@ -3376,6 +3675,14 @@ static const struct vcap_typegroup *es0_keyfield_set_typegroups[] = {
 	[2] = NULL,
 };
 
+static const struct vcap_typegroup *lpm_keyfield_set_typegroups[] = {
+	[6] = lpm_x6_keyfield_set_typegroups,
+	[3] = lpm_x3_keyfield_set_typegroups,
+	[2] = lpm_x2_keyfield_set_typegroups,
+	[1] = lpm_x1_keyfield_set_typegroups,
+	[13] = NULL,
+};
+
 static const struct vcap_typegroup *es2_keyfield_set_typegroups[] = {
 	[12] = es2_x12_keyfield_set_typegroups,
 	[6] = es2_x6_keyfield_set_typegroups,
@@ -3453,6 +3760,10 @@ static const struct vcap_typegroup es0_x1_actionfield_set_typegroups[] = {
 	{}
 };
 
+static const struct vcap_typegroup lpm_x1_actionfield_set_typegroups[] = {
+	{}
+};
+
 static const struct vcap_typegroup es2_x3_actionfield_set_typegroups[] = {
 	{
 		.offset = 0,
@@ -3494,6 +3805,11 @@ static const struct vcap_typegroup *es0_actionfield_set_typegroups[] = {
 	[2] = NULL,
 };
 
+static const struct vcap_typegroup *lpm_actionfield_set_typegroups[] = {
+	[1] = lpm_x1_actionfield_set_typegroups,
+	[13] = NULL,
+};
+
 static const struct vcap_typegroup *es2_actionfield_set_typegroups[] = {
 	[3] = es2_x3_actionfield_set_typegroups,
 	[1] = es2_x1_actionfield_set_typegroups,
@@ -3504,6 +3820,8 @@ static const struct vcap_typegroup *es2_actionfield_set_typegroups[] = {
 static const char * const vcap_keyfield_set_names[] = {
 	[VCAP_KFS_NO_VALUE]                      =  "(None)",
 	[VCAP_KFS_ARP]                           =  "VCAP_KFS_ARP",
+	[VCAP_KFS_DBL_IP4]                       =  "VCAP_KFS_DBL_IP4",
+	[VCAP_KFS_DBL_IP6]                       =  "VCAP_KFS_DBL_IP6",
 	[VCAP_KFS_ETAG]                          =  "VCAP_KFS_ETAG",
 	[VCAP_KFS_IP4_OTHER]                     =  "VCAP_KFS_IP4_OTHER",
 	[VCAP_KFS_IP4_TCP_UDP]                   =  "VCAP_KFS_IP4_TCP_UDP",
@@ -3522,6 +3840,8 @@ static const char * const vcap_keyfield_set_names[] = {
 	[VCAP_KFS_NORMAL_7TUPLE]                 =  "VCAP_KFS_NORMAL_7TUPLE",
 	[VCAP_KFS_OAM]                           =  "VCAP_KFS_OAM",
 	[VCAP_KFS_PURE_5TUPLE_IP4]               =  "VCAP_KFS_PURE_5TUPLE_IP4",
+	[VCAP_KFS_SGL_IP4]                       =  "VCAP_KFS_SGL_IP4",
+	[VCAP_KFS_SGL_IP6]                       =  "VCAP_KFS_SGL_IP6",
 	[VCAP_KFS_SMAC_SIP4]                     =  "VCAP_KFS_SMAC_SIP4",
 	[VCAP_KFS_SMAC_SIP6]                     =  "VCAP_KFS_SMAC_SIP6",
 };
@@ -3529,6 +3849,8 @@ static const char * const vcap_keyfield_set_names[] = {
 /* Actionfieldset names */
 static const char * const vcap_actionfield_set_names[] = {
 	[VCAP_AFS_NO_VALUE]                      =  "(None)",
+	[VCAP_AFS_ARP_ENTRY]                     =  "VCAP_AFS_ARP_ENTRY",
+	[VCAP_AFS_ARP_PTR]                       =  "VCAP_AFS_ARP_PTR",
 	[VCAP_AFS_BASE_TYPE]                     =  "VCAP_AFS_BASE_TYPE",
 	[VCAP_AFS_CLASSIFICATION]                =  "VCAP_AFS_CLASSIFICATION",
 	[VCAP_AFS_CLASS_REDUCED]                 =  "VCAP_AFS_CLASS_REDUCED",
@@ -3565,6 +3887,7 @@ static const char * const vcap_keyfield_names[] = {
 	[VCAP_KF_8021Q_VLAN_TAGGED_IS]           =  "8021Q_VLAN_TAGGED_IS",
 	[VCAP_KF_8021Q_VLAN_TAGS]                =  "8021Q_VLAN_TAGS",
 	[VCAP_KF_ACL_GRP_ID]                     =  "ACL_GRP_ID",
+	[VCAP_KF_AFFIX]                          =  "AFFIX",
 	[VCAP_KF_ARP_ADDR_SPACE_OK_IS]           =  "ARP_ADDR_SPACE_OK_IS",
 	[VCAP_KF_ARP_LEN_OK_IS]                  =  "ARP_LEN_OK_IS",
 	[VCAP_KF_ARP_OPCODE]                     =  "ARP_OPCODE",
@@ -3573,6 +3896,7 @@ static const char * const vcap_keyfield_names[] = {
 	[VCAP_KF_ARP_SENDER_MATCH_IS]            =  "ARP_SENDER_MATCH_IS",
 	[VCAP_KF_ARP_TGT_MATCH_IS]               =  "ARP_TGT_MATCH_IS",
 	[VCAP_KF_COSID_CLS]                      =  "COSID_CLS",
+	[VCAP_KF_DST_FLAG]                       =  "DST_FLAG",
 	[VCAP_KF_ES0_ISDX_KEY_ENA]               =  "ES0_ISDX_KEY_ENA",
 	[VCAP_KF_ETYPE]                          =  "ETYPE",
 	[VCAP_KF_ETYPE_LEN_IS]                   =  "ETYPE_LEN_IS",
@@ -3586,7 +3910,13 @@ static const char * const vcap_keyfield_names[] = {
 	[VCAP_KF_IF_IGR_PORT_MASK_RNG]           =  "IF_IGR_PORT_MASK_RNG",
 	[VCAP_KF_IF_IGR_PORT_MASK_SEL]           =  "IF_IGR_PORT_MASK_SEL",
 	[VCAP_KF_IF_IGR_PORT_SEL]                =  "IF_IGR_PORT_SEL",
+	[VCAP_KF_IP4_DIP]                        =  "IP4_DIP",
 	[VCAP_KF_IP4_IS]                         =  "IP4_IS",
+	[VCAP_KF_IP4_SIP]                        =  "IP4_SIP",
+	[VCAP_KF_IP4_XIP]                        =  "IP4_XIP",
+	[VCAP_KF_IP6_DIP]                        =  "IP6_DIP",
+	[VCAP_KF_IP6_SIP]                        =  "IP6_SIP",
+	[VCAP_KF_IP6_XIP]                        =  "IP6_XIP",
 	[VCAP_KF_IP_MC_IS]                       =  "IP_MC_IS",
 	[VCAP_KF_IP_PAYLOAD_5TUPLE]              =  "IP_PAYLOAD_5TUPLE",
 	[VCAP_KF_IP_SNAP_IS]                     =  "IP_SNAP_IS",
@@ -3659,6 +3989,10 @@ static const char * const vcap_keyfield_names[] = {
 static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_NO_VALUE]                       =  "(None)",
 	[VCAP_AF_ACL_ID]                         =  "ACL_ID",
+	[VCAP_AF_ARP_ENA]                        =  "ARP_ENA",
+	[VCAP_AF_ARP_PTR]                        =  "ARP_PTR",
+	[VCAP_AF_ARP_PTR_REMAP_ENA]              =  "ARP_PTR_REMAP_ENA",
+	[VCAP_AF_ARP_VMID]                       =  "ARP_VMID",
 	[VCAP_AF_CLS_VID_SEL]                    =  "CLS_VID_SEL",
 	[VCAP_AF_CNT_ID]                         =  "CNT_ID",
 	[VCAP_AF_COPY_PORT_NUM]                  =  "COPY_PORT_NUM",
@@ -3676,6 +4010,8 @@ static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_DSCP_ENA]                       =  "DSCP_ENA",
 	[VCAP_AF_DSCP_SEL]                       =  "DSCP_SEL",
 	[VCAP_AF_DSCP_VAL]                       =  "DSCP_VAL",
+	[VCAP_AF_ECMP_CNT]                       =  "ECMP_CNT",
+	[VCAP_AF_ENCAP_ID]                       =  "ENCAP_ID",
 	[VCAP_AF_ES2_REW_CMD]                    =  "ES2_REW_CMD",
 	[VCAP_AF_ESDX]                           =  "ESDX",
 	[VCAP_AF_FWD_KILL_ENA]                   =  "FWD_KILL_ENA",
@@ -3690,6 +4026,8 @@ static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_ISDX_VAL]                       =  "ISDX_VAL",
 	[VCAP_AF_LOOP_ENA]                       =  "LOOP_ENA",
 	[VCAP_AF_LRN_DIS]                        =  "LRN_DIS",
+	[VCAP_AF_MAC_LSB]                        =  "MAC_LSB",
+	[VCAP_AF_MAC_MSB]                        =  "MAC_MSB",
 	[VCAP_AF_MAP_IDX]                        =  "MAP_IDX",
 	[VCAP_AF_MAP_KEY]                        =  "MAP_KEY",
 	[VCAP_AF_MAP_LOOKUP_SEL]                 =  "MAP_LOOKUP_SEL",
@@ -3723,7 +4061,12 @@ static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_QOS_ENA]                        =  "QOS_ENA",
 	[VCAP_AF_QOS_VAL]                        =  "QOS_VAL",
 	[VCAP_AF_REW_OP]                         =  "REW_OP",
+	[VCAP_AF_RGID]                           =  "RGID",
+	[VCAP_AF_RSDX]                           =  "RSDX",
 	[VCAP_AF_RT_DIS]                         =  "RT_DIS",
+	[VCAP_AF_SECUR_MATCH_MAC_ENA]            =  "SECUR_MATCH_MAC_ENA",
+	[VCAP_AF_SECUR_MATCH_VMID_ENA]           =  "SECUR_MATCH_VMID_ENA",
+	[VCAP_AF_SIP_RPF_ENA]                    =  "SIP_RPF_ENA",
 	[VCAP_AF_SWAP_MACS_ENA]                  =  "SWAP_MACS_ENA",
 	[VCAP_AF_TAG_A_DEI_SEL]                  =  "TAG_A_DEI_SEL",
 	[VCAP_AF_TAG_A_PCP_SEL]                  =  "TAG_A_PCP_SEL",
@@ -3743,6 +4086,7 @@ static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_VID_B_VAL]                      =  "VID_B_VAL",
 	[VCAP_AF_VID_C_VAL]                      =  "VID_C_VAL",
 	[VCAP_AF_VID_VAL]                        =  "VID_VAL",
+	[VCAP_AF_ZERO_DMAC_CPU_QU]               =  "ZERO_DMAC_CPU_QU",
 };
 
 /* VCAPs */
@@ -3810,6 +4154,27 @@ const struct vcap_info lan969x_vcaps[] = {
 		.keyfield_set_typegroups = es0_keyfield_set_typegroups,
 		.actionfield_set_typegroups = es0_actionfield_set_typegroups,
 	},
+	[VCAP_TYPE_LPM] = {
+		.name = "lpm",
+		.rows = 512,
+		.sw_count = 12,
+		.sw_width = 52,
+		.sticky_width = 1,
+		.act_width = 83,
+		.default_cnt = 0,
+		.require_cnt_dis = 0,
+		.version = 1,
+		.keyfield_set = lpm_keyfield_set,
+		.keyfield_set_size = ARRAY_SIZE(lpm_keyfield_set),
+		.actionfield_set = lpm_actionfield_set,
+		.actionfield_set_size = ARRAY_SIZE(lpm_actionfield_set),
+		.keyfield_set_map = lpm_keyfield_set_map,
+		.keyfield_set_map_size = lpm_keyfield_set_map_size,
+		.actionfield_set_map = lpm_actionfield_set_map,
+		.actionfield_set_map_size = lpm_actionfield_set_map_size,
+		.keyfield_set_typegroups = lpm_keyfield_set_typegroups,
+		.actionfield_set_typegroups = lpm_actionfield_set_typegroups,
+	},
 	[VCAP_TYPE_ES2] = {
 		.name = "es2",
 		.rows = 256,
@@ -3835,7 +4200,7 @@ const struct vcap_info lan969x_vcaps[] = {
 
 const struct vcap_statistics lan969x_vcap_stats = {
 	.name = "lan969x",
-	.count = 4,
+	.count = 5,
 	.keyfield_set_names = vcap_keyfield_set_names,
 	.actionfield_set_names = vcap_actionfield_set_names,
 	.keyfield_names = vcap_keyfield_names,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.c
index 556d6ea0acd1..7bc8b29757b1 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause
-/* Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries.
+/* Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries.
  * Microchip VCAP API
  */
 
-/* This file is autogenerated by cml-utils 2023-02-10 11:15:56 +0100.
- * Commit ID: c30fb4bf0281cd4a7133bdab6682f9e43c872ada
+/* This file is autogenerated by cml-utils 2026-04-28 13:55:50 +0200.
+ * Commit ID: cd2494df16a1d3b14f650f720f6a8126b88b553a
  */
 
 #include <linux/types.h>
@@ -1381,6 +1381,83 @@ static const struct vcap_field es0_isdx_keyfield[] = {
 	},
 };
 
+static const struct vcap_field lpm_sgl_ip4_keyfield[] = {
+	[VCAP_KF_DST_FLAG] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 0,
+		.width = 1,
+	},
+	[VCAP_KF_AFFIX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 1,
+		.width = 10,
+	},
+	[VCAP_KF_IP4_XIP] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 11,
+		.width = 32,
+	},
+};
+
+static const struct vcap_field lpm_dbl_ip4_keyfield[] = {
+	[VCAP_KF_TYPE] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 0,
+		.width = 1,
+	},
+	[VCAP_KF_AFFIX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 1,
+		.width = 10,
+	},
+	[VCAP_KF_IP4_SIP] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 11,
+		.width = 32,
+	},
+	[VCAP_KF_IP4_DIP] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 43,
+		.width = 32,
+	},
+};
+
+static const struct vcap_field lpm_sgl_ip6_keyfield[] = {
+	[VCAP_KF_DST_FLAG] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 0,
+		.width = 1,
+	},
+	[VCAP_KF_AFFIX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 1,
+		.width = 10,
+	},
+	[VCAP_KF_IP6_XIP] = {
+		.type = VCAP_FIELD_U128,
+		.offset = 11,
+		.width = 128,
+	},
+};
+
+static const struct vcap_field lpm_dbl_ip6_keyfield[] = {
+	[VCAP_KF_AFFIX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 0,
+		.width = 10,
+	},
+	[VCAP_KF_IP6_SIP] = {
+		.type = VCAP_FIELD_U128,
+		.offset = 10,
+		.width = 128,
+	},
+	[VCAP_KF_IP6_DIP] = {
+		.type = VCAP_FIELD_U128,
+		.offset = 138,
+		.width = 128,
+	},
+};
+
 static const struct vcap_field es2_mac_etype_keyfield[] = {
 	[VCAP_KF_TYPE] = {
 		.type = VCAP_FIELD_U32,
@@ -2339,6 +2416,29 @@ static const struct vcap_set es0_keyfield_set[] = {
 	},
 };
 
+static const struct vcap_set lpm_keyfield_set[] = {
+	[VCAP_KFS_SGL_IP4] = {
+		.type_id = -1,
+		.sw_per_item = 1,
+		.sw_cnt = 12,
+	},
+	[VCAP_KFS_DBL_IP4] = {
+		.type_id = 0,
+		.sw_per_item = 2,
+		.sw_cnt = 6,
+	},
+	[VCAP_KFS_SGL_IP6] = {
+		.type_id = -1,
+		.sw_per_item = 3,
+		.sw_cnt = 4,
+	},
+	[VCAP_KFS_DBL_IP6] = {
+		.type_id = -1,
+		.sw_per_item = 6,
+		.sw_cnt = 2,
+	},
+};
+
 static const struct vcap_set es2_keyfield_set[] = {
 	[VCAP_KFS_MAC_ETYPE] = {
 		.type_id = 0,
@@ -2391,6 +2491,13 @@ static const struct vcap_field *es0_keyfield_set_map[] = {
 	[VCAP_KFS_ISDX] = es0_isdx_keyfield,
 };
 
+static const struct vcap_field *lpm_keyfield_set_map[] = {
+	[VCAP_KFS_SGL_IP4] = lpm_sgl_ip4_keyfield,
+	[VCAP_KFS_DBL_IP4] = lpm_dbl_ip4_keyfield,
+	[VCAP_KFS_SGL_IP6] = lpm_sgl_ip6_keyfield,
+	[VCAP_KFS_DBL_IP6] = lpm_dbl_ip6_keyfield,
+};
+
 static const struct vcap_field *es2_keyfield_set_map[] = {
 	[VCAP_KFS_MAC_ETYPE] = es2_mac_etype_keyfield,
 	[VCAP_KFS_ARP] = es2_arp_keyfield,
@@ -2419,6 +2526,13 @@ static int es0_keyfield_set_map_size[] = {
 	[VCAP_KFS_ISDX] = ARRAY_SIZE(es0_isdx_keyfield),
 };
 
+static int lpm_keyfield_set_map_size[] = {
+	[VCAP_KFS_SGL_IP4] = ARRAY_SIZE(lpm_sgl_ip4_keyfield),
+	[VCAP_KFS_DBL_IP4] = ARRAY_SIZE(lpm_dbl_ip4_keyfield),
+	[VCAP_KFS_SGL_IP6] = ARRAY_SIZE(lpm_sgl_ip6_keyfield),
+	[VCAP_KFS_DBL_IP6] = ARRAY_SIZE(lpm_dbl_ip6_keyfield),
+};
+
 static int es2_keyfield_set_map_size[] = {
 	[VCAP_KFS_MAC_ETYPE] = ARRAY_SIZE(es2_mac_etype_keyfield),
 	[VCAP_KFS_ARP] = ARRAY_SIZE(es2_arp_keyfield),
@@ -2994,6 +3108,92 @@ static const struct vcap_field es0_es0_actionfield[] = {
 	},
 };
 
+static const struct vcap_field lpm_arp_ptr_actionfield[] = {
+	[VCAP_AF_TYPE] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 0,
+		.width = 2,
+	},
+	[VCAP_AF_ARP_PTR] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 2,
+		.width = 11,
+	},
+	[VCAP_AF_ARP_PTR_REMAP_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 13,
+		.width = 1,
+	},
+	[VCAP_AF_ECMP_CNT] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 14,
+		.width = 4,
+	},
+	[VCAP_AF_RGID] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 18,
+		.width = 3,
+	},
+};
+
+static const struct vcap_field lpm_arp_entry_actionfield[] = {
+	[VCAP_AF_TYPE] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 0,
+		.width = 2,
+	},
+	[VCAP_AF_MAC_MSB] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 2,
+		.width = 16,
+	},
+	[VCAP_AF_MAC_LSB] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 18,
+		.width = 32,
+	},
+	[VCAP_AF_ARP_VMID] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 50,
+		.width = 9,
+	},
+	[VCAP_AF_ZERO_DMAC_CPU_QU] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 59,
+		.width = 3,
+	},
+	[VCAP_AF_SIP_RPF_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 62,
+		.width = 1,
+	},
+	[VCAP_AF_SECUR_MATCH_VMID_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 63,
+		.width = 1,
+	},
+	[VCAP_AF_SECUR_MATCH_MAC_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 64,
+		.width = 1,
+	},
+	[VCAP_AF_ARP_ENA] = {
+		.type = VCAP_FIELD_BIT,
+		.offset = 65,
+		.width = 1,
+	},
+	[VCAP_AF_ENCAP_ID] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 66,
+		.width = 10,
+	},
+	[VCAP_AF_RSDX] = {
+		.type = VCAP_FIELD_U32,
+		.offset = 76,
+		.width = 12,
+	},
+};
+
 static const struct vcap_field es2_base_type_actionfield[] = {
 	[VCAP_AF_HIT_ME_ONCE] = {
 		.type = VCAP_FIELD_BIT,
@@ -3102,6 +3302,19 @@ static const struct vcap_set es0_actionfield_set[] = {
 	},
 };
 
+static const struct vcap_set lpm_actionfield_set[] = {
+	[VCAP_AFS_ARP_PTR] = {
+		.type_id = 0,
+		.sw_per_item = 1,
+		.sw_cnt = 12,
+	},
+	[VCAP_AFS_ARP_ENTRY] = {
+		.type_id = 2,
+		.sw_per_item = 1,
+		.sw_cnt = 12,
+	},
+};
+
 static const struct vcap_set es2_actionfield_set[] = {
 	[VCAP_AFS_BASE_TYPE] = {
 		.type_id = -1,
@@ -3125,6 +3338,11 @@ static const struct vcap_field *es0_actionfield_set_map[] = {
 	[VCAP_AFS_ES0] = es0_es0_actionfield,
 };
 
+static const struct vcap_field *lpm_actionfield_set_map[] = {
+	[VCAP_AFS_ARP_PTR] = lpm_arp_ptr_actionfield,
+	[VCAP_AFS_ARP_ENTRY] = lpm_arp_entry_actionfield,
+};
+
 static const struct vcap_field *es2_actionfield_set_map[] = {
 	[VCAP_AFS_BASE_TYPE] = es2_base_type_actionfield,
 };
@@ -3144,6 +3362,11 @@ static int es0_actionfield_set_map_size[] = {
 	[VCAP_AFS_ES0] = ARRAY_SIZE(es0_es0_actionfield),
 };
 
+static int lpm_actionfield_set_map_size[] = {
+	[VCAP_AFS_ARP_PTR] = ARRAY_SIZE(lpm_arp_ptr_actionfield),
+	[VCAP_AFS_ARP_ENTRY] = ARRAY_SIZE(lpm_arp_entry_actionfield),
+};
+
 static int es2_actionfield_set_map_size[] = {
 	[VCAP_AFS_BASE_TYPE] = ARRAY_SIZE(es2_base_type_actionfield),
 };
@@ -3334,6 +3557,82 @@ static const struct vcap_typegroup es0_x1_keyfield_set_typegroups[] = {
 	{}
 };
 
+static const struct vcap_typegroup lpm_x6_keyfield_set_typegroups[] = {
+	{
+		.offset = 0,
+		.width = 4,
+		.value = 8,
+	},
+	{
+		.offset = 52,
+		.width = 1,
+		.value = 0,
+	},
+	{
+		.offset = 104,
+		.width = 2,
+		.value = 0,
+	},
+	{
+		.offset = 156,
+		.width = 3,
+		.value = 0,
+	},
+	{
+		.offset = 208,
+		.width = 2,
+		.value = 0,
+	},
+	{
+		.offset = 260,
+		.width = 1,
+		.value = 0,
+	},
+	{}
+};
+
+static const struct vcap_typegroup lpm_x3_keyfield_set_typegroups[] = {
+	{
+		.offset = 0,
+		.width = 3,
+		.value = 4,
+	},
+	{
+		.offset = 52,
+		.width = 2,
+		.value = 0,
+	},
+	{
+		.offset = 104,
+		.width = 2,
+		.value = 0,
+	},
+	{}
+};
+
+static const struct vcap_typegroup lpm_x2_keyfield_set_typegroups[] = {
+	{
+		.offset = 0,
+		.width = 2,
+		.value = 2,
+	},
+	{
+		.offset = 52,
+		.width = 1,
+		.value = 0,
+	},
+	{}
+};
+
+static const struct vcap_typegroup lpm_x1_keyfield_set_typegroups[] = {
+	{
+		.offset = 0,
+		.width = 1,
+		.value = 1,
+	},
+	{}
+};
+
 static const struct vcap_typegroup es2_x12_keyfield_set_typegroups[] = {
 	{
 		.offset = 0,
@@ -3407,6 +3706,14 @@ static const struct vcap_typegroup *es0_keyfield_set_typegroups[] = {
 	[2] = NULL,
 };
 
+static const struct vcap_typegroup *lpm_keyfield_set_typegroups[] = {
+	[6] = lpm_x6_keyfield_set_typegroups,
+	[3] = lpm_x3_keyfield_set_typegroups,
+	[2] = lpm_x2_keyfield_set_typegroups,
+	[1] = lpm_x1_keyfield_set_typegroups,
+	[13] = NULL,
+};
+
 static const struct vcap_typegroup *es2_keyfield_set_typegroups[] = {
 	[12] = es2_x12_keyfield_set_typegroups,
 	[6] = es2_x6_keyfield_set_typegroups,
@@ -3484,6 +3791,10 @@ static const struct vcap_typegroup es0_x1_actionfield_set_typegroups[] = {
 	{}
 };
 
+static const struct vcap_typegroup lpm_x1_actionfield_set_typegroups[] = {
+	{}
+};
+
 static const struct vcap_typegroup es2_x3_actionfield_set_typegroups[] = {
 	{
 		.offset = 0,
@@ -3525,6 +3836,11 @@ static const struct vcap_typegroup *es0_actionfield_set_typegroups[] = {
 	[2] = NULL,
 };
 
+static const struct vcap_typegroup *lpm_actionfield_set_typegroups[] = {
+	[1] = lpm_x1_actionfield_set_typegroups,
+	[13] = NULL,
+};
+
 static const struct vcap_typegroup *es2_actionfield_set_typegroups[] = {
 	[3] = es2_x3_actionfield_set_typegroups,
 	[1] = es2_x1_actionfield_set_typegroups,
@@ -3535,6 +3851,8 @@ static const struct vcap_typegroup *es2_actionfield_set_typegroups[] = {
 static const char * const vcap_keyfield_set_names[] = {
 	[VCAP_KFS_NO_VALUE]                      =  "(None)",
 	[VCAP_KFS_ARP]                           =  "VCAP_KFS_ARP",
+	[VCAP_KFS_DBL_IP4]                       =  "VCAP_KFS_DBL_IP4",
+	[VCAP_KFS_DBL_IP6]                       =  "VCAP_KFS_DBL_IP6",
 	[VCAP_KFS_ETAG]                          =  "VCAP_KFS_ETAG",
 	[VCAP_KFS_IP4_OTHER]                     =  "VCAP_KFS_IP4_OTHER",
 	[VCAP_KFS_IP4_TCP_UDP]                   =  "VCAP_KFS_IP4_TCP_UDP",
@@ -3553,6 +3871,8 @@ static const char * const vcap_keyfield_set_names[] = {
 	[VCAP_KFS_NORMAL_7TUPLE]                 =  "VCAP_KFS_NORMAL_7TUPLE",
 	[VCAP_KFS_OAM]                           =  "VCAP_KFS_OAM",
 	[VCAP_KFS_PURE_5TUPLE_IP4]               =  "VCAP_KFS_PURE_5TUPLE_IP4",
+	[VCAP_KFS_SGL_IP4]                       =  "VCAP_KFS_SGL_IP4",
+	[VCAP_KFS_SGL_IP6]                       =  "VCAP_KFS_SGL_IP6",
 	[VCAP_KFS_SMAC_SIP4]                     =  "VCAP_KFS_SMAC_SIP4",
 	[VCAP_KFS_SMAC_SIP6]                     =  "VCAP_KFS_SMAC_SIP6",
 };
@@ -3560,6 +3880,8 @@ static const char * const vcap_keyfield_set_names[] = {
 /* Actionfieldset names */
 static const char * const vcap_actionfield_set_names[] = {
 	[VCAP_AFS_NO_VALUE]                      =  "(None)",
+	[VCAP_AFS_ARP_ENTRY]                     =  "VCAP_AFS_ARP_ENTRY",
+	[VCAP_AFS_ARP_PTR]                       =  "VCAP_AFS_ARP_PTR",
 	[VCAP_AFS_BASE_TYPE]                     =  "VCAP_AFS_BASE_TYPE",
 	[VCAP_AFS_CLASSIFICATION]                =  "VCAP_AFS_CLASSIFICATION",
 	[VCAP_AFS_CLASS_REDUCED]                 =  "VCAP_AFS_CLASS_REDUCED",
@@ -3596,6 +3918,7 @@ static const char * const vcap_keyfield_names[] = {
 	[VCAP_KF_8021Q_VLAN_TAGGED_IS]           =  "8021Q_VLAN_TAGGED_IS",
 	[VCAP_KF_8021Q_VLAN_TAGS]                =  "8021Q_VLAN_TAGS",
 	[VCAP_KF_ACL_GRP_ID]                     =  "ACL_GRP_ID",
+	[VCAP_KF_AFFIX]                          =  "AFFIX",
 	[VCAP_KF_ARP_ADDR_SPACE_OK_IS]           =  "ARP_ADDR_SPACE_OK_IS",
 	[VCAP_KF_ARP_LEN_OK_IS]                  =  "ARP_LEN_OK_IS",
 	[VCAP_KF_ARP_OPCODE]                     =  "ARP_OPCODE",
@@ -3604,6 +3927,7 @@ static const char * const vcap_keyfield_names[] = {
 	[VCAP_KF_ARP_SENDER_MATCH_IS]            =  "ARP_SENDER_MATCH_IS",
 	[VCAP_KF_ARP_TGT_MATCH_IS]               =  "ARP_TGT_MATCH_IS",
 	[VCAP_KF_COSID_CLS]                      =  "COSID_CLS",
+	[VCAP_KF_DST_FLAG]                       =  "DST_FLAG",
 	[VCAP_KF_ES0_ISDX_KEY_ENA]               =  "ES0_ISDX_KEY_ENA",
 	[VCAP_KF_ETYPE]                          =  "ETYPE",
 	[VCAP_KF_ETYPE_LEN_IS]                   =  "ETYPE_LEN_IS",
@@ -3617,7 +3941,13 @@ static const char * const vcap_keyfield_names[] = {
 	[VCAP_KF_IF_IGR_PORT_MASK_RNG]           =  "IF_IGR_PORT_MASK_RNG",
 	[VCAP_KF_IF_IGR_PORT_MASK_SEL]           =  "IF_IGR_PORT_MASK_SEL",
 	[VCAP_KF_IF_IGR_PORT_SEL]                =  "IF_IGR_PORT_SEL",
+	[VCAP_KF_IP4_DIP]                        =  "IP4_DIP",
 	[VCAP_KF_IP4_IS]                         =  "IP4_IS",
+	[VCAP_KF_IP4_SIP]                        =  "IP4_SIP",
+	[VCAP_KF_IP4_XIP]                        =  "IP4_XIP",
+	[VCAP_KF_IP6_DIP]                        =  "IP6_DIP",
+	[VCAP_KF_IP6_SIP]                        =  "IP6_SIP",
+	[VCAP_KF_IP6_XIP]                        =  "IP6_XIP",
 	[VCAP_KF_IP_MC_IS]                       =  "IP_MC_IS",
 	[VCAP_KF_IP_PAYLOAD_5TUPLE]              =  "IP_PAYLOAD_5TUPLE",
 	[VCAP_KF_IP_SNAP_IS]                     =  "IP_SNAP_IS",
@@ -3690,6 +4020,10 @@ static const char * const vcap_keyfield_names[] = {
 static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_NO_VALUE]                       =  "(None)",
 	[VCAP_AF_ACL_ID]                         =  "ACL_ID",
+	[VCAP_AF_ARP_ENA]                        =  "ARP_ENA",
+	[VCAP_AF_ARP_PTR]                        =  "ARP_PTR",
+	[VCAP_AF_ARP_PTR_REMAP_ENA]              =  "ARP_PTR_REMAP_ENA",
+	[VCAP_AF_ARP_VMID]                       =  "ARP_VMID",
 	[VCAP_AF_CLS_VID_SEL]                    =  "CLS_VID_SEL",
 	[VCAP_AF_CNT_ID]                         =  "CNT_ID",
 	[VCAP_AF_COPY_PORT_NUM]                  =  "COPY_PORT_NUM",
@@ -3707,6 +4041,8 @@ static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_DSCP_ENA]                       =  "DSCP_ENA",
 	[VCAP_AF_DSCP_SEL]                       =  "DSCP_SEL",
 	[VCAP_AF_DSCP_VAL]                       =  "DSCP_VAL",
+	[VCAP_AF_ECMP_CNT]                       =  "ECMP_CNT",
+	[VCAP_AF_ENCAP_ID]                       =  "ENCAP_ID",
 	[VCAP_AF_ES2_REW_CMD]                    =  "ES2_REW_CMD",
 	[VCAP_AF_ESDX]                           =  "ESDX",
 	[VCAP_AF_FWD_KILL_ENA]                   =  "FWD_KILL_ENA",
@@ -3721,6 +4057,8 @@ static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_ISDX_VAL]                       =  "ISDX_VAL",
 	[VCAP_AF_LOOP_ENA]                       =  "LOOP_ENA",
 	[VCAP_AF_LRN_DIS]                        =  "LRN_DIS",
+	[VCAP_AF_MAC_LSB]                        =  "MAC_LSB",
+	[VCAP_AF_MAC_MSB]                        =  "MAC_MSB",
 	[VCAP_AF_MAP_IDX]                        =  "MAP_IDX",
 	[VCAP_AF_MAP_KEY]                        =  "MAP_KEY",
 	[VCAP_AF_MAP_LOOKUP_SEL]                 =  "MAP_LOOKUP_SEL",
@@ -3754,7 +4092,12 @@ static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_QOS_ENA]                        =  "QOS_ENA",
 	[VCAP_AF_QOS_VAL]                        =  "QOS_VAL",
 	[VCAP_AF_REW_OP]                         =  "REW_OP",
+	[VCAP_AF_RGID]                           =  "RGID",
+	[VCAP_AF_RSDX]                           =  "RSDX",
 	[VCAP_AF_RT_DIS]                         =  "RT_DIS",
+	[VCAP_AF_SECUR_MATCH_MAC_ENA]            =  "SECUR_MATCH_MAC_ENA",
+	[VCAP_AF_SECUR_MATCH_VMID_ENA]           =  "SECUR_MATCH_VMID_ENA",
+	[VCAP_AF_SIP_RPF_ENA]                    =  "SIP_RPF_ENA",
 	[VCAP_AF_SWAP_MACS_ENA]                  =  "SWAP_MACS_ENA",
 	[VCAP_AF_TAG_A_DEI_SEL]                  =  "TAG_A_DEI_SEL",
 	[VCAP_AF_TAG_A_PCP_SEL]                  =  "TAG_A_PCP_SEL",
@@ -3774,6 +4117,7 @@ static const char * const vcap_actionfield_names[] = {
 	[VCAP_AF_VID_B_VAL]                      =  "VID_B_VAL",
 	[VCAP_AF_VID_C_VAL]                      =  "VID_C_VAL",
 	[VCAP_AF_VID_VAL]                        =  "VID_VAL",
+	[VCAP_AF_ZERO_DMAC_CPU_QU]               =  "ZERO_DMAC_CPU_QU",
 };
 
 /* VCAPs */
@@ -3841,6 +4185,27 @@ const struct vcap_info sparx5_vcaps[] = {
 		.keyfield_set_typegroups = es0_keyfield_set_typegroups,
 		.actionfield_set_typegroups = es0_actionfield_set_typegroups,
 	},
+	[VCAP_TYPE_LPM] = {
+		.name = "lpm",
+		.rows = 512,
+		.sw_count = 12,
+		.sw_width = 52,
+		.sticky_width = 1,
+		.act_width = 89,
+		.default_cnt = 0,
+		.require_cnt_dis = 0,
+		.version = 1,
+		.keyfield_set = lpm_keyfield_set,
+		.keyfield_set_size = ARRAY_SIZE(lpm_keyfield_set),
+		.actionfield_set = lpm_actionfield_set,
+		.actionfield_set_size = ARRAY_SIZE(lpm_actionfield_set),
+		.keyfield_set_map = lpm_keyfield_set_map,
+		.keyfield_set_map_size = lpm_keyfield_set_map_size,
+		.actionfield_set_map = lpm_actionfield_set_map,
+		.actionfield_set_map_size = lpm_actionfield_set_map_size,
+		.keyfield_set_typegroups = lpm_keyfield_set_typegroups,
+		.actionfield_set_typegroups = lpm_actionfield_set_typegroups,
+	},
 	[VCAP_TYPE_ES2] = {
 		.name = "es2",
 		.rows = 1024,
@@ -3866,7 +4231,7 @@ const struct vcap_info sparx5_vcaps[] = {
 
 const struct vcap_statistics sparx5_vcap_stats = {
 	.name = "sparx5",
-	.count = 4,
+	.count = 5,
 	.keyfield_set_names = vcap_keyfield_set_names,
 	.actionfield_set_names = vcap_actionfield_set_names,
 	.keyfield_names = vcap_keyfield_names,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.h b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.h
index e68f5639a40a..22bb416f433d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: BSD-3-Clause */
-/* Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries.
+/* Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries.
  * Microchip VCAP API
  */
 
-/* This file is autogenerated by cml-utils 2022-10-13 10:04:41 +0200.
- * Commit ID: fd7cafd175899f0672c73afb3a30fc872500ae86
+/* This file is autogenerated by cml-utils 2026-04-28 13:55:50 +0200.
+ * Commit ID: cd2494df16a1d3b14f650f720f6a8126b88b553a
  */
 
 #ifndef __SPARX5_VCAP_AG_API_H__
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_ag_api.h b/drivers/net/ethernet/microchip/vcap/vcap_ag_api.h
index 4735fad05708..487d56440936 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_ag_api.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_ag_api.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: BSD-3-Clause */
-/* Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries.
+/* Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries.
  * Microchip VCAP API
  */
 
-/* This file is autogenerated by cml-utils 2023-03-13 10:16:42 +0100.
- * Commit ID: 259f0efd6d6d91bfbf62858de153cc757b6bffa3 (dirty)
+/* This file is autogenerated by cml-utils 2026-04-28 13:55:50 +0200.
+ * Commit ID: cd2494df16a1d3b14f650f720f6a8126b88b553a
  */
 
 #ifndef __VCAP_AG_API__
@@ -16,6 +16,7 @@ enum vcap_type {
 	VCAP_TYPE_IS0,
 	VCAP_TYPE_IS1,
 	VCAP_TYPE_IS2,
+	VCAP_TYPE_LPM,
 	VCAP_TYPE_MAX
 };
 
@@ -26,6 +27,8 @@ enum vcap_keyfield_set {
 	VCAP_KFS_5TUPLE_IP6,        /* lan966x is1 X4 */
 	VCAP_KFS_7TUPLE,            /* lan966x is1 X4 */
 	VCAP_KFS_ARP,               /* sparx5 is2 X6, sparx5 es2 X6, lan966x is2 X2 */
+	VCAP_KFS_DBL_IP4,           /* sparx5 lpm X2 */
+	VCAP_KFS_DBL_IP6,           /* sparx5 lpm X6 */
 	VCAP_KFS_DBL_VID,           /* lan966x is1 X1 */
 	VCAP_KFS_DMAC_VID,          /* lan966x is1 X1 */
 	VCAP_KFS_ETAG,              /* sparx5 is0 X2 */
@@ -49,6 +52,8 @@ enum vcap_keyfield_set {
 	VCAP_KFS_OAM,               /* lan966x is2 X2 */
 	VCAP_KFS_PURE_5TUPLE_IP4,   /* sparx5 is0 X3 */
 	VCAP_KFS_RT,                /* lan966x is1 X1 */
+	VCAP_KFS_SGL_IP4,           /* sparx5 lpm X1 */
+	VCAP_KFS_SGL_IP6,           /* sparx5 lpm X3 */
 	VCAP_KFS_SMAC_SIP4,         /* lan966x is2 X1 */
 	VCAP_KFS_SMAC_SIP6,         /* lan966x is2 X2 */
 	VCAP_KFS_VID,               /* lan966x es0 X1 */
@@ -117,6 +122,10 @@ enum vcap_keyfield_set {
  *   tagged, 7: Triple tagged
  * VCAP_KF_ACL_GRP_ID: W8, sparx5: es2
  *   Used in interface map table
+ * VCAP_KF_AFFIX: W10, sparx5: lpm
+ *   LPM affix. Defaults to 0. Using the LPM affix, the VCAP LPM can be split into
+ *   multiple logically separate routing tables, e.g. to support features such as
+ *   VRF-lite.
  * VCAP_KF_ARP_ADDR_SPACE_OK_IS: W1, sparx5: is2/es2, lan966x: is2
  *   Set if hardware address is Ethernet
  * VCAP_KF_ARP_LEN_OK_IS: W1, sparx5: is2/es2, lan966x: is2
@@ -133,6 +142,9 @@ enum vcap_keyfield_set {
  *   Target Hardware Address = SMAC (RARP)
  * VCAP_KF_COSID_CLS: W3, sparx5: es0/es2
  *   Class of service
+ * VCAP_KF_DST_FLAG: W1, sparx5: lpm
+ *   0: IP4_XIP/IP6_XIP is only to be used for SIP matching, 1: IP4_XIP/IP6_XIP is
+ *   only to be used for DIP matching
  * VCAP_KF_ES0_ISDX_KEY_ENA: W1, sparx5: es2
  *   The value taken from the IFH .FWD.ES0_ISDX_KEY_ENA
  * VCAP_KF_ETYPE: W16, sparx5: is0/is2/es2, lan966x: is1/is2
@@ -167,8 +179,22 @@ enum vcap_keyfield_set {
  *   Mapping: 0: DEFAULT 1: LOOPBACK 2: MASQUERADE 3: CPU_VD
  * VCAP_KF_IF_IGR_PORT_SEL: W1, sparx5: es2
  *   Selector for IF_IGR_PORT: physical port number or ERLEG
+ * VCAP_KF_IP4_DIP: W32, sparx5: lpm
+ *   IPv4 destination address. Used for IPv4 MC routing.
  * VCAP_KF_IP4_IS: W1, sparx5: is0/is2/es2, lan966x: is1/is2
  *   Set if frame has EtherType = 0x800 and IP version = 4
+ * VCAP_KF_IP4_SIP: W32, sparx5: lpm
+ *   IPv4 source address. Used for IPv4 MC routing.
+ * VCAP_KF_IP4_XIP: W32, sparx5: lpm
+ *   IPv4 address. Used for IPv4 UC routing as well as IPv4 Source/Destination
+ *   Guard.
+ * VCAP_KF_IP6_DIP: W128, sparx5: lpm
+ *   IPv6 destination address. Used for IPv6 MC routing.
+ * VCAP_KF_IP6_SIP: W128, sparx5: lpm
+ *   IPv6 source address. Used for IPv6 MC routing.
+ * VCAP_KF_IP6_XIP: W128, sparx5: lpm
+ *   IPv6 address. Used for IPv6 UC routing as well as IPv6 Source/Destination
+ *   Guard.
  * VCAP_KF_IP_MC_IS: W1, sparx5: is0, lan966x: is1
  *   Set if frame is IPv4 frame and frame's destination MAC address is an IPv4
  *   multicast address (0x01005E0 /25). Set if frame is IPv6 frame and frame's
@@ -352,8 +378,8 @@ enum vcap_keyfield_set {
  *   Set if frame is IPv4/IPv6 TCP or UDP frame (IP protocol/next header equals 6
  *   or 17)
  * VCAP_KF_TYPE: sparx5 is0 W2, sparx5 is0 W1, sparx5 is2 W4, sparx5 is2 W2,
- *   sparx5 es0 W1, sparx5 es2 W3, lan966x is1 W1, lan966x is1 W2, lan966x is2 W4,
- *   lan966x is2 W2
+ *   sparx5 es0 W1, sparx5 lpm W1, sparx5 es2 W3, lan966x is1 W1, lan966x is1 W2,
+ *   lan966x is2 W4, lan966x is2 W2
  *   Keyset type id - set by the API
  */
 
@@ -387,6 +413,7 @@ enum vcap_key_field {
 	VCAP_KF_8021Q_VLAN_TAGGED_IS,
 	VCAP_KF_8021Q_VLAN_TAGS,
 	VCAP_KF_ACL_GRP_ID,
+	VCAP_KF_AFFIX,
 	VCAP_KF_ARP_ADDR_SPACE_OK_IS,
 	VCAP_KF_ARP_LEN_OK_IS,
 	VCAP_KF_ARP_OPCODE,
@@ -395,6 +422,7 @@ enum vcap_key_field {
 	VCAP_KF_ARP_SENDER_MATCH_IS,
 	VCAP_KF_ARP_TGT_MATCH_IS,
 	VCAP_KF_COSID_CLS,
+	VCAP_KF_DST_FLAG,
 	VCAP_KF_ES0_ISDX_KEY_ENA,
 	VCAP_KF_ETYPE,
 	VCAP_KF_ETYPE_LEN_IS,
@@ -408,7 +436,13 @@ enum vcap_key_field {
 	VCAP_KF_IF_IGR_PORT_MASK_RNG,
 	VCAP_KF_IF_IGR_PORT_MASK_SEL,
 	VCAP_KF_IF_IGR_PORT_SEL,
+	VCAP_KF_IP4_DIP,
 	VCAP_KF_IP4_IS,
+	VCAP_KF_IP4_SIP,
+	VCAP_KF_IP4_XIP,
+	VCAP_KF_IP6_DIP,
+	VCAP_KF_IP6_SIP,
+	VCAP_KF_IP6_XIP,
 	VCAP_KF_IP_MC_IS,
 	VCAP_KF_IP_PAYLOAD_5TUPLE,
 	VCAP_KF_IP_PAYLOAD_S1_IP6,
@@ -490,6 +524,8 @@ enum vcap_key_field {
 /* Actionset names with origin information */
 enum vcap_actionfield_set {
 	VCAP_AFS_NO_VALUE,          /* initial value */
+	VCAP_AFS_ARP_ENTRY,         /* sparx5 lpm X1 */
+	VCAP_AFS_ARP_PTR,           /* sparx5 lpm X1 */
 	VCAP_AFS_BASE_TYPE,         /* sparx5 is2 X3, sparx5 es2 X3, lan966x is2 X2 */
 	VCAP_AFS_CLASSIFICATION,    /* sparx5 is0 X2 */
 	VCAP_AFS_CLASS_REDUCED,     /* sparx5 is0 X1 */
@@ -506,6 +542,15 @@ enum vcap_actionfield_set {
  *   Logical ID for the entry. This ID is extracted together with the frame in the
  *   CPU extraction header. Only applicable to actions with CPU_COPY_ENA or
  *   HIT_ME_ONCE set.
+ * VCAP_AF_ARP_ENA: W1, sparx5: lpm
+ *   Enable entry for address resolution usage.
+ * VCAP_AF_ARP_PTR: W11, sparx5: lpm
+ *   Pointer to entry in ARP Table.
+ * VCAP_AF_ARP_PTR_REMAP_ENA: W1, sparx5: lpm
+ *   If this bit is set, ARP_PTR is used to point to an entry in the ARP pointer
+ *   remap table.
+ * VCAP_AF_ARP_VMID: W9, sparx5: lpm
+ *   Routing lookup. Egress router leg (EVMID).
  * VCAP_AF_CLS_VID_SEL: W3, sparx5: is0
  *   Controls the classified VID: 0: VID_NONE: No action. 1: VID_ADD: New VID =
  *   old VID + VID_VAL. 2: VID_REPLACE: New VID = VID_VAL. 3: VID_FIRST_TAG: New
@@ -562,6 +607,11 @@ enum vcap_actionfield_set {
  *   7: Mapped using mapping table 3, otherwise use mapping table 2
  * VCAP_AF_DSCP_VAL: W6, sparx5: is0/es0, lan966x: is1
  *   See DSCP_ENA.
+ * VCAP_AF_ECMP_CNT: W4, sparx5: lpm
+ *   Number of equal cost, multiple paths routes to DIP.
+ * VCAP_AF_ENCAP_ID: W10, sparx5: lpm
+ *   Index into REW:ENCAP_IP4 when encapsulating IP packet in IPv4. Disabled when
+ *   set to 0.
  * VCAP_AF_ES2_REW_CMD: W3, sparx5: es2
  *   Command forwarded to REW: 0: No action. 1: SWAP MAC addresses. 2: Do L2CP
  *   DMAC translation when entering or leaving a tunnel.
@@ -610,6 +660,12 @@ enum vcap_actionfield_set {
  *   0: Forward based on PIPELINE_PT and FWD_SEL
  * VCAP_AF_LRN_DIS: W1, sparx5: is2, lan966x: is2
  *   Setting this bit to 1 disables learning of frames hitting this action.
+ * VCAP_AF_MAC_LSB: W32, sparx5: lpm
+ *   32 least significant bits of MAC address. Used for ARP entry and/or
+ *   (SMAC,SIP)/(DMAC,DIP) check.
+ * VCAP_AF_MAC_MSB: W16, sparx5: lpm
+ *   16 most significant bits of MAC address. Used for ARP entry and/or
+ *   (SMAC,SIP)/(DMAC,DIP) check.
  * VCAP_AF_MAP_IDX: W9, sparx5: is0
  *   Index for QoS mapping table lookup
  * VCAP_AF_MAP_KEY: W3, sparx5: is0
@@ -715,9 +771,17 @@ enum vcap_actionfield_set {
  *   See QOS_ENA.
  * VCAP_AF_REW_OP: W16, lan966x: is2
  *   Rewriter operation command.
+ * VCAP_AF_RGID: W3, sparx5: lpm
+ *   Route Group ID. Used for SIP RPF check.
+ * VCAP_AF_RSDX: W12, sparx5: lpm
+ *   Router Leg Service Index for ARP table entry.
  * VCAP_AF_RT_DIS: W1, sparx5: is2
  *   If set, routing is disallowed. Only applies when IS_INNER_ACL is 0. See also
  *   IGR_ACL_ENA, EGR_ACL_ENA, and RLEG_STAT_IDX.
+ * VCAP_AF_SECUR_MATCH_MAC_ENA: W1, sparx5: lpm
+ *   Enable Security MAC check.
+ * VCAP_AF_SECUR_MATCH_VMID_ENA: W1, sparx5: lpm
+ *   Enable Security VMID check.
  * VCAP_AF_SFID_ENA: W1, lan966x: is1
  *   If set, SFID_VAL is used to lookup ANA::SFID.
  * VCAP_AF_SFID_VAL: W8, lan966x: is1
@@ -726,6 +790,8 @@ enum vcap_actionfield_set {
  *   If set, SGID_VAL is used to lookup ANA::SGID.
  * VCAP_AF_SGID_VAL: W8, lan966x: is1
  *   Stream gate identifier.
+ * VCAP_AF_SIP_RPF_ENA: W1, sparx5: lpm
+ *   Enable use for SIP RPF check.
  * VCAP_AF_SWAP_MACS_ENA: W1, sparx5: es0
  *   This setting is only active when FWD_SEL = 1 or FWD_SEL = 2 and PIPELINE_ACT
  *   = LBK_ASM. 0: No action. 1: Swap MACs and clear bit 40 in new SMAC.
@@ -774,7 +840,7 @@ enum vcap_actionfield_set {
  * VCAP_AF_TAG_C_VID_SEL: W2, sparx5: es0
  *   Selects VID for ES0 tag C. The resulting VID is termed C-TAG.VID. 0:
  *   Classified VID. 1: VID_C_VAL. 2: IFH.ENCAP.GVID. 3: Reserved.
- * VCAP_AF_TYPE: W1, sparx5: is0, lan966x: is1
+ * VCAP_AF_TYPE: sparx5 is0 W1, sparx5 lpm W2, lan966x is1 W1
  *   Actionset type id - Set by the API
  * VCAP_AF_UNTAG_VID_ENA: W1, sparx5: es0
  *   Controls insertion of tag C. Untag or insert mode can be selected. See
@@ -798,12 +864,18 @@ enum vcap_actionfield_set {
  *   If set, use VLAN_POP_CNT as the number of VLAN tags to pop from the incoming
  *   frame. This number is used by the Rewriter. Otherwise, VLAN_POP_CNT from
  *   ANA:PORT:VLAN_CFG.VLAN_POP_CNT is used
+ * VCAP_AF_ZERO_DMAC_CPU_QU: W3, sparx5: lpm
+ *   CPU queue used for CPU redirect if MAC address in ARP entry is all-zeros.
  */
 
 /* Actionfield names */
 enum vcap_action_field {
 	VCAP_AF_NO_VALUE,  /* initial value */
 	VCAP_AF_ACL_ID,
+	VCAP_AF_ARP_ENA,
+	VCAP_AF_ARP_PTR,
+	VCAP_AF_ARP_PTR_REMAP_ENA,
+	VCAP_AF_ARP_VMID,
 	VCAP_AF_CLS_VID_SEL,
 	VCAP_AF_CNT_ID,
 	VCAP_AF_COPY_PORT_NUM,
@@ -823,6 +895,8 @@ enum vcap_action_field {
 	VCAP_AF_DSCP_ENA,
 	VCAP_AF_DSCP_SEL,
 	VCAP_AF_DSCP_VAL,
+	VCAP_AF_ECMP_CNT,
+	VCAP_AF_ENCAP_ID,
 	VCAP_AF_ES2_REW_CMD,
 	VCAP_AF_ESDX,
 	VCAP_AF_FWD_KILL_ENA,
@@ -839,6 +913,8 @@ enum vcap_action_field {
 	VCAP_AF_ISDX_VAL,
 	VCAP_AF_LOOP_ENA,
 	VCAP_AF_LRN_DIS,
+	VCAP_AF_MAC_LSB,
+	VCAP_AF_MAC_MSB,
 	VCAP_AF_MAP_IDX,
 	VCAP_AF_MAP_KEY,
 	VCAP_AF_MAP_LOOKUP_SEL,
@@ -874,11 +950,16 @@ enum vcap_action_field {
 	VCAP_AF_QOS_ENA,
 	VCAP_AF_QOS_VAL,
 	VCAP_AF_REW_OP,
+	VCAP_AF_RGID,
+	VCAP_AF_RSDX,
 	VCAP_AF_RT_DIS,
+	VCAP_AF_SECUR_MATCH_MAC_ENA,
+	VCAP_AF_SECUR_MATCH_VMID_ENA,
 	VCAP_AF_SFID_ENA,
 	VCAP_AF_SFID_VAL,
 	VCAP_AF_SGID_ENA,
 	VCAP_AF_SGID_VAL,
+	VCAP_AF_SIP_RPF_ENA,
 	VCAP_AF_SWAP_MACS_ENA,
 	VCAP_AF_TAG_A_DEI_SEL,
 	VCAP_AF_TAG_A_PCP_SEL,
@@ -901,6 +982,7 @@ enum vcap_action_field {
 	VCAP_AF_VID_VAL,
 	VCAP_AF_VLAN_POP_CNT,
 	VCAP_AF_VLAN_POP_CNT_ENA,
+	VCAP_AF_ZERO_DMAC_CPU_QU,
 };
 
 #endif /* __VCAP_AG_API__ */
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_model_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_model_kunit.c
index 5dbfc0d0c369..75819b49e110 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_model_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_model_kunit.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause
-/* Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries.
+/* Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries.
  * Microchip VCAP test model interface for kunit testing
  */
 
-/* This file is autogenerated by cml-utils 2023-02-10 11:16:00 +0100.
- * Commit ID: c30fb4bf0281cd4a7133bdab6682f9e43c872ada
+/* This file is autogenerated by cml-utils 2026-04-28 13:55:50 +0200.
+ * Commit ID: cd2494df16a1d3b14f650f720f6a8126b88b553a
  */
 
 #include <linux/types.h>

-- 
2.52.0


