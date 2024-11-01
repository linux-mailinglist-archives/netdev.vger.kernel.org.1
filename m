Return-Path: <netdev+bounces-140940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65B9B8BC9
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D12F1C20E80
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC6F156237;
	Fri,  1 Nov 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YoRJ3O6X"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B511537A8;
	Fri,  1 Nov 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445015; cv=none; b=JdO9fsy77h3G9G23fYtvNl0jtlHrSzBE1PmybX3ORneB73v7xQZILixJeY6Nm9TVtXDKyUL9GcBN7ufQQle3T48sAA8614iwaTXgK/7CZCOiq36dEfd36BklDjiG7UD05wBxfIOnDIemhqpGCD/7Y+4mxQ1Tn1R0sY9O55BImgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445015; c=relaxed/simple;
	bh=PoUpoiqh15WbBGv3obiAOp0I0e8/k6KBOM9i6jG/LjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OVaa3k/hShLlAXbNBGC5tjje/urwjvgPbOpcMDyoQX/6x9I7zwzT/OuRbueARro6DrQ31U9ipvXRWEi/2kLxXAB+lEv4pVfx6B+Ewq4xo1pcnc7Qx5Bo8C+OFjDbKekh4qTVOfAvoMyntwsdTfGvYAKgB1tqOjlhxYFCrsK0ah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YoRJ3O6X; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730445012; x=1761981012;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PoUpoiqh15WbBGv3obiAOp0I0e8/k6KBOM9i6jG/LjA=;
  b=YoRJ3O6XvFapqrl/YMUQW4e1vLJBXK19HOlFNGr6z0R1oQj0Iqob2R/0
   VDjB9p4JrQ97/djj9n4Rg+A2NGI3Ogk5gjKMcdoz9uv4wN0q/ZYmvQecR
   yFCf+Okn8Leg9JfuS5z+CVSkA0DLeP/zBHdTePCmknFBLPnUY9p27YE88
   07h/YrLndw4Swb9/fseZXuctVgInV/kR0U2WuXnHPyU+qU5Kyc1DQklj0
   k+JFrp/9LsJUU4KcAA1jIJm4N7GOlsot8h4ddu60hq3DDc79JtmkIDTHR
   7yrJ54aIBQT4hI4GHLQjmvjmPoSWcJ38KlOsLc+P+xlRf+kmCElSw96/l
   A==;
X-CSE-ConnectionGUID: NPrwf/hMSSa00KPy6thoyw==
X-CSE-MsgGUID: r7VsTCbOQcaA3FloD0sZgQ==
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="201180320"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2024 00:10:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Nov 2024 00:09:54 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 1 Nov 2024 00:09:52 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 1 Nov 2024 08:09:07 +0100
Subject: [PATCH net-next 1/6] net: sparx5: expose some sparx5 VCAP symbols
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20241101-sparx5-lan969x-switch-driver-3-v1-1-3c76f22f4bfa@microchip.com>
References: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
In-Reply-To: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>, <christophe.jaillet@wanadoo.fr>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x VCAP support, expose the following symbols for
use by the lan969x VCAP implementation:

- The symbols SPARX5_*_LOOKUPS defines the number of lookups in each
  VCAP instance.  These are the same for lan969x. Move them to the
  header file.

- The struct sparx5_vcap_inst encapsulates information about a single
  VCAP instance. Move this struct to the header file and declare the
  sparx5_vcap_inst_cfg as extern.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c    | 18 +-----------------
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.h    | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index 967c8621c250..0bdf7a378892 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -17,7 +17,6 @@
 #define SUPER_VCAP_BLK_SIZE 3072 /* addresses per Super VCAP block */
 #define STREAMSIZE (64 * 4)  /* bytes in the VCAP cache area */
 
-#define SPARX5_IS2_LOOKUPS 4
 #define VCAP_IS2_KEYSEL(_ena, _noneth, _v4_mc, _v4_uc, _v6_mc, _v6_uc, _arp) \
 	(ANA_ACL_VCAP_S2_KEY_SEL_KEY_SEL_ENA_SET(_ena) | \
 	 ANA_ACL_VCAP_S2_KEY_SEL_NON_ETH_KEY_SEL_SET(_noneth) | \
@@ -27,7 +26,6 @@
 	 ANA_ACL_VCAP_S2_KEY_SEL_IP6_UC_KEY_SEL_SET(_v6_uc) | \
 	 ANA_ACL_VCAP_S2_KEY_SEL_ARP_KEY_SEL_SET(_arp))
 
-#define SPARX5_IS0_LOOKUPS 6
 #define VCAP_IS0_KEYSEL(_ena, _etype, _ipv4, _ipv6, _mpls_uc, _mpls_mc, _mlbs) \
 	(ANA_CL_ADV_CL_CFG_LOOKUP_ENA_SET(_ena) | \
 	ANA_CL_ADV_CL_CFG_ETYPE_CLM_KEY_SEL_SET(_etype) | \
@@ -37,31 +35,17 @@
 	ANA_CL_ADV_CL_CFG_MPLS_MC_CLM_KEY_SEL_SET(_mpls_mc) | \
 	ANA_CL_ADV_CL_CFG_MLBS_CLM_KEY_SEL_SET(_mlbs))
 
-#define SPARX5_ES0_LOOKUPS 1
 #define VCAP_ES0_KEYSEL(_key) (REW_RTAG_ETAG_CTRL_ES0_ISDX_KEY_ENA_SET(_key))
 #define SPARX5_STAT_ESDX_GRN_PKTS  0x300
 #define SPARX5_STAT_ESDX_YEL_PKTS  0x301
 
-#define SPARX5_ES2_LOOKUPS 2
 #define VCAP_ES2_KEYSEL(_ena, _arp, _ipv4, _ipv6) \
 	(EACL_VCAP_ES2_KEY_SEL_KEY_ENA_SET(_ena) | \
 	EACL_VCAP_ES2_KEY_SEL_ARP_KEY_SEL_SET(_arp) | \
 	EACL_VCAP_ES2_KEY_SEL_IP4_KEY_SEL_SET(_ipv4) | \
 	EACL_VCAP_ES2_KEY_SEL_IP6_KEY_SEL_SET(_ipv6))
 
-static struct sparx5_vcap_inst {
-	enum vcap_type vtype; /* type of vcap */
-	int vinst; /* instance number within the same type */
-	int lookups; /* number of lookups in this vcap type */
-	int lookups_per_instance; /* number of lookups in this instance */
-	int first_cid; /* first chain id in this vcap */
-	int last_cid; /* last chain id in this vcap */
-	int count; /* number of available addresses, not in super vcap */
-	int map_id; /* id in the super vcap block mapping (if applicable) */
-	int blockno; /* starting block in super vcap (if applicable) */
-	int blocks; /* number of blocks in super vcap (if applicable) */
-	bool ingress; /* is vcap in the ingress path */
-} sparx5_vcap_inst_cfg[] = {
+const struct sparx5_vcap_inst sparx5_vcap_inst_cfg[] = {
 	{
 		.vtype = VCAP_TYPE_IS0, /* CLM-0 */
 		.vinst = 0,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.h b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.h
index 2684d9199b05..d0a42406bf26 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.h
@@ -16,6 +16,11 @@
 #include "vcap_api.h"
 #include "vcap_api_client.h"
 
+#define SPARX5_IS2_LOOKUPS 4
+#define SPARX5_IS0_LOOKUPS 6
+#define SPARX5_ES0_LOOKUPS 1
+#define SPARX5_ES2_LOOKUPS 2
+
 #define SPARX5_VCAP_CID_IS0_L0 VCAP_CID_INGRESS_L0 /* IS0/CLM lookup 0 */
 #define SPARX5_VCAP_CID_IS0_L1 VCAP_CID_INGRESS_L1 /* IS0/CLM lookup 1 */
 #define SPARX5_VCAP_CID_IS0_L2 VCAP_CID_INGRESS_L2 /* IS0/CLM lookup 2 */
@@ -40,6 +45,22 @@
 #define SPARX5_VCAP_CID_ES2_MAX \
 	(VCAP_CID_EGRESS_STAGE2_L1 + VCAP_CID_LOOKUP_SIZE - 1) /* ES2 Max */
 
+struct sparx5_vcap_inst {
+	enum vcap_type vtype; /* type of vcap */
+	int vinst; /* instance number within the same type */
+	int lookups; /* number of lookups in this vcap type */
+	int lookups_per_instance; /* number of lookups in this instance */
+	int first_cid; /* first chain id in this vcap */
+	int last_cid; /* last chain id in this vcap */
+	int count; /* number of available addresses, not in super vcap */
+	int map_id; /* id in the super vcap block mapping (if applicable) */
+	int blockno; /* starting block in super vcap (if applicable) */
+	int blocks; /* number of blocks in super vcap (if applicable) */
+	bool ingress; /* is vcap in the ingress path */
+};
+
+extern const struct sparx5_vcap_inst sparx5_vcap_inst_cfg[];
+
 /* IS0 port keyset selection control */
 
 /* IS0 ethernet, IPv4, IPv6 traffic type keyset generation */

-- 
2.34.1


