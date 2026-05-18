Return-Path: <netdev+bounces-289031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA1ZKUgHC2oI/gQAu9opvQ
	(envelope-from <netdev+bounces-289031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:34:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19056CBEF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD2FD302AE2E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0601840756F;
	Mon, 18 May 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SHSbRG3o"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9123F99F0;
	Mon, 18 May 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107203; cv=none; b=sp1Emsg0WBTM7VLSWcIX7wJlAnu2kgy7eS3c69waod9iU+19H8gQl5oLsBRJRTqZD3HFQelfUc4lVvtBaZp62MS3muWpvcYnYPkfFZs3dL/fA1ZdEMbGF7x7cMQyZLdlb4n/zSd4eo82ZUjU+HJG9hfu91CUtz8BUubIClBsL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107203; c=relaxed/simple;
	bh=jaXGboPqwmmjI89xEBnW8nPhaa27K640WG9+V/+94Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dndShfAwXC+HfHS0pZ7ZUxDi4P5UbqjTKIq7E9iIbAZH7IAZO/pp0eCN6r/ovqZZ9o6l5u6Mt6MkK82WS9ZcYusgi6l16qJK+i//lm4d1d5RIWStr6/8s2JsTEsfisccUkKAcJyj+k00psXjAKZ/UQun9ayenvEd9XIJzz7K4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SHSbRG3o; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779107202; x=1810643202;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jaXGboPqwmmjI89xEBnW8nPhaa27K640WG9+V/+94Hs=;
  b=SHSbRG3oPrEr86EY69zg/0Yhkbmw7d3jg1RKLoHXmH8Z3BIdzLKg7ker
   Lb7I6pKJrq0b0o3Gb94KflnGdSbEC+rvhdjKznZnN7IonNmNB+DO5S4OS
   H3lgQIK83iWfdYbwTqRL0EiaJE1QxeYFDdo34mk1P6wF3Bc5gD5lXvNjE
   7FGx4LmVJ2+XFMqRSR1r2o68PYTyqq8s7HXECYKaa7jX0qnv2mD5qs8GF
   pSbBUZDtV+cfgnP147ffAYOkRV3TqkA0xWXwHL7Jcu792wKXJTmtO45kT
   FHI4VFPI8PjNfifD9zDSKucJWRYF5q/c7X73US7fd9JiB0/l9lgDchfTG
   g==;
X-CSE-ConnectionGUID: yHTwJIOvRTe+p6hciE3zQA==
X-CSE-MsgGUID: sIjPfCVrSIq0l/APgNMpDQ==
X-IronPort-AV: E=Sophos;i="6.23,241,1770620400"; 
   d="scan'208";a="58072641"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 05:26:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 18 May 2026 05:26:40 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 18 May 2026 05:26:37 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Mon, 18 May 2026 14:24:56 +0200
Subject: [PATCH net-next v5 1/9] net: dsa: add tag driver for LAN9645X
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260518-dsa_lan9645x_switch_driver_base-v5-1-968fbf34ffa3@microchip.com>
References: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
In-Reply-To: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Russell King
	<linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Queue-Id: BE19056CBEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289031-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Add tag driver for LAN9645x using a front port as CPU port. This mode
is called an NPI port in the datasheet.
Use long prefix on extraction (RX) and no prefix on injection (TX). A
long prefix on extraction helps get through the conduit port on host
side, since it will see a broadcast MAC.

The LAN9645x chip is in the same design architecture family as ocelot
and lan966x. The tagging protocol has the same structure as these chips,
but the particular fields are different or have different sizes.
Therefore, this tag driver is similar to tag_ocelot.c, but the
differences in fields makes it hard to reuse.

LAN9645x supports 3 different tag formats for extraction/injection of
frames from a CPU port: long prefix, short prefix and no prefix.

The tag is prepended to the frame. The critical data for the chip is
contained in an internal frame header (IFH) which is 28 bytes. The
prefix formats look like this:

Long prefix (16 bytes) + IFH:
- DMAC    = 0xffffffffffff on extraction.
- SMAC    = 0xfeffffffffff on extraction.
- ETYPE   = 0x8880
- payload = 0x0011
- IFH

Short prefix (4 bytes) + IFH:
- 0x8880
- 0x0011
- IFH

No prefix:
- IFH

The format can be configured asymmetrically on RX and TX.

The IFH get/set functions are declared as inline. All the field
constants are compile-time known, so when these calls are inlined
efficient code is generated with branches pruned and loops unrolled.
During testing it was observed that without explicit inlining GCC would
have trouble inlining the functions, which hurt performance.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v5:
- Undo offset fix in postpull_rcsum. The original logic was correct for
  CHECKSUM_COMPLETE host NICs
- Use __always_inline in lan9645x_ifh_{get,set}
- remove double space after = in set_merge_mask

Changes in v4:
- Fix offset in postpull_rcsum so prefix eth header is cleared, not
  actual eth header, so tag driver works with CHECKSUM_COMPLETE host
  NICs
- Fix untagged rx on vlan aware port with pvid

Changes in v3:
- guard vlan_remove_tag behind skb_headlen(skb) >= VLAN_ETH_HLEN on xmit
- add pskb_may_pull checks in rx path

Changes in v2:
- sorting in net/dsa/Kconfig
- sorting in net/dsa/Makefile
- remove default zero promisc_on_conduit
- move functions to to .c file
- add justification for inline usage to commit message
- add __skb_put_padto on xmit path
- fix hwaccel_put_tag
---
 MAINTAINERS                  |   8 ++
 include/linux/dsa/lan9645x.h | 134 +++++++++++++++++++
 include/net/dsa.h            |   2 +
 net/dsa/Kconfig              |  11 ++
 net/dsa/Makefile             |   1 +
 net/dsa/tag_lan9645x.c       | 300 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 456 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index edd161f2c62d..c0d8ab962f1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17418,6 +17418,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/microchip_t1.c
 
+MICROCHIP LAN9645X ETHERNET SWITCH DRIVER
+M:	Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
+M:	UNGLinuxDriver@microchip.com
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	include/linux/dsa/lan9645x.h
+F:	net/dsa/tag_lan9645x.c
+
 MICROCHIP LAN966X ETHERNET DRIVER
 M:	Horatiu Vultur <horatiu.vultur@microchip.com>
 M:	UNGLinuxDriver@microchip.com
diff --git a/include/linux/dsa/lan9645x.h b/include/linux/dsa/lan9645x.h
new file mode 100644
index 000000000000..34c18bf975d0
--- /dev/null
+++ b/include/linux/dsa/lan9645x.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#ifndef _NET_DSA_TAG_LAN9645X_H_
+#define _NET_DSA_TAG_LAN9645X_H_
+
+#include <net/dsa.h>
+
+/* LAN9645x supports 3 different formats on an NPI port, long prefix, short
+ * prefix and no prefix. The format can be configured asymmetrically on RX and
+ * TX. We use long prefix on extraction (RX), and no prefix on injection.
+ * The long prefix on extraction helps get through the conduit port on host
+ * side, since it will see a broadcast MAC.
+ *
+ * The internal frame header (IFH) is 28 bytes, and the fields are documented
+ * below.
+ *
+ * Long prefix, 16 bytes + IFH:
+ * - DMAC    = 0xFFFFFFFFFFFF on extraction.
+ * - SMAC    = 0xFEFFFFFFFFFF on extraction.
+ * - ETYPE   = 0x8880
+ * - payload = 0x0011
+ * - IFH
+ *
+ * Short prefix, 4 bytes + IFH:
+ * - 0x8880
+ * - 0x0011
+ * - IFH
+ *
+ * No prefix:
+ * - IFH
+ *
+ */
+#define LAN9645X_IFH_TAG_TYPE_C	0
+#define LAN9645X_IFH_TAG_TYPE_S	1
+#define LAN9645X_IFH_LEN_U32		7
+#define LAN9645X_IFH_LEN		(LAN9645X_IFH_LEN_U32 * sizeof(u32))
+#define LAN9645X_IFH_BITS		(LAN9645X_IFH_LEN * BITS_PER_BYTE)
+#define LAN9645X_SHORT_PREFIX_LEN	4
+#define LAN9645X_LONG_PREFIX_LEN	16
+#define LAN9645X_TOTAL_TAG_LEN (LAN9645X_LONG_PREFIX_LEN + LAN9645X_IFH_LEN)
+
+#define IFH_INJ_TIMESTAMP		192
+#define IFH_BYPASS			191
+#define IFH_MASQ			190
+#define IFH_TIMESTAMP			186
+#define IFH_TIMESTAMP_NS		194
+#define IFH_TIMESTAMP_SUBNS		186
+#define IFH_MASQ_PORT			186
+#define IFH_RCT_INJ			185
+#define IFH_LEN				171
+#define IFH_WRDMODE			169
+#define IFH_RTAGD			167
+#define IFH_CUTTHRU			166
+#define IFH_REW_CMD			156
+#define IFH_REW_OAM			155
+#define IFH_PDU_TYPE			151
+#define IFH_FCS_UPD			150
+#define IFH_DP				149
+#define IFH_RTE_INB_UPDATE		148
+#define IFH_POP_CNT			146
+#define IFH_ETYPE_OFS			144
+#define IFH_SRCPORT			140
+#define IFH_SEQ_NUM			120
+#define IFH_TAG_TYPE			119
+#define IFH_TCI				103
+#define IFH_DSCP			97
+#define IFH_QOS_CLASS			94
+#define IFH_CPUQ			86
+#define IFH_LEARN_FLAGS			84
+#define IFH_SFLOW_ID			80
+#define IFH_ACL_HIT			79
+#define IFH_ACL_IDX			73
+#define IFH_ISDX			65
+#define IFH_DSTS			55
+#define IFH_FLOOD			53
+#define IFH_SEQ_OP			51
+#define IFH_IPV				48
+#define IFH_AFI				47
+#define IFH_RTP_ID			37
+#define IFH_RTP_SUBID			36
+#define IFH_PN_DATA_STATUS		28
+#define IFH_PN_TRANSF_STATUS_ZERO	27
+#define IFH_PN_CC			11
+#define IFH_DUPL_DISC_ENA		10
+#define IFH_RCT_AVAIL			9
+
+#define IFH_INJ_TIMESTAMP_SZ		32
+#define IFH_BYPASS_SZ			1
+#define IFH_MASQ_SZ			1
+#define IFH_TIMESTAMP_SZ		38
+#define IFH_TIMESTAMP_NS_SZ		30
+#define IFH_TIMESTAMP_SUBNS_SZ		8
+#define IFH_MASQ_PORT_SZ		4
+#define IFH_RCT_INJ_SZ			1
+#define IFH_LEN_SZ			14
+#define IFH_WRDMODE_SZ			2
+#define IFH_RTAGD_SZ			2
+#define IFH_CUTTHRU_SZ			1
+#define IFH_REW_CMD_SZ			10
+#define IFH_REW_OAM_SZ			1
+#define IFH_PDU_TYPE_SZ			4
+#define IFH_FCS_UPD_SZ			1
+#define IFH_DP_SZ			1
+#define IFH_RTE_INB_UPDATE_SZ		1
+#define IFH_POP_CNT_SZ			2
+#define IFH_ETYPE_OFS_SZ		2
+#define IFH_SRCPORT_SZ			4
+#define IFH_SEQ_NUM_SZ			16
+#define IFH_TAG_TYPE_SZ			1
+#define IFH_TCI_SZ			16
+#define IFH_DSCP_SZ			6
+#define IFH_QOS_CLASS_SZ		3
+#define IFH_CPUQ_SZ			8
+#define IFH_LEARN_FLAGS_SZ		2
+#define IFH_SFLOW_ID_SZ			4
+#define IFH_ACL_HIT_SZ			1
+#define IFH_ACL_IDX_SZ			6
+#define IFH_ISDX_SZ			8
+#define IFH_DSTS_SZ			10
+#define IFH_FLOOD_SZ			2
+#define IFH_SEQ_OP_SZ			2
+#define IFH_IPV_SZ			3
+#define IFH_AFI_SZ			1
+#define IFH_RTP_ID_SZ			10
+#define IFH_RTP_SUBID_SZ		1
+#define IFH_PN_DATA_STATUS_SZ		8
+#define IFH_PN_TRANSF_STATUS_ZERO_SZ	1
+#define IFH_PN_CC_SZ			16
+#define IFH_DUPL_DISC_ENA_SZ		1
+#define IFH_RCT_AVAIL_SZ		1
+
+#endif /* _NET_DSA_TAG_LAN9645X_H_ */
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4cc67469cf2e..e612aa101b0e 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
+#define DSA_TAG_PROTO_LAN9645X_VALUE		33
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
+	DSA_TAG_PROTO_LAN9645X		= DSA_TAG_PROTO_LAN9645X_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 5ed8c704636d..f3facb12e96e 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -75,6 +75,17 @@ config NET_DSA_TAG_HELLCREEK
 	  Say Y or M if you want to enable support for tagging frames
 	  for the Hirschmann Hellcreek TSN switches.
 
+config NET_DSA_TAG_LAN9645X
+	tristate "Tag driver for Lan9645x switches"
+	help
+	  Say Y or M if you want to enable NPI tagging for the Lan9645x switches.
+	  In this mode, the frames over the Ethernet CPU port are prepended with
+	  a hardware-defined injection/extraction frame header.
+	  On injection a 28 byte internal frame header (IFH) is used. On
+	  extraction a 16 byte prefix is prepended before the internal frame
+	  header. This prefix starts with a broadcast MAC, to ease passage
+	  through the host side RX filter.
+
 config NET_DSA_TAG_GSWIP
 	tristate "Tag driver for Lantiq / Intel GSWIP switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index bf7247759a64..ca1e2dc90b80 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
+obj-$(CONFIG_NET_DSA_TAG_LAN9645X) += tag_lan9645x.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) += tag_mxl862xx.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
new file mode 100644
index 000000000000..0b639228215e
--- /dev/null
+++ b/net/dsa/tag_lan9645x.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include <linux/dsa/lan9645x.h>
+
+#include "tag.h"
+
+#define LAN9645X_NAME "lan9645x"
+
+#define BTM_MSK(n)	((u8)GENMASK(n, 0))
+#define TOP_MSK(n)	((u8)GENMASK(7, n))
+
+static inline void set_merge_mask(u8 *on_zero, u8 on_one, u8 mask)
+{
+	*on_zero = *on_zero ^ ((*on_zero ^ on_one) & mask);
+}
+
+/* The internal frame header (IFH) is a big-endian 28 byte unpadded bit array.
+ * Frames can be prepended with an IFH on injection and extraction. There
+ * are two field layouts, one for extraction and one for injection.
+ *
+ *    IFH bits go from high to low, for instance
+ *    ifh[0]  = [223:216]
+ *    ifh[27] = [7:0]
+ *
+ * Here is an example of setting a value starting at bit 13 of bit length 17.
+ *
+ * val    = 0x1ff
+ * pos    = 13
+ * length = 17
+ *
+ *
+ * IFH[]   0                         23       24       25        26      27
+ *
+ *                                           end_u8           start_u8
+ *      +--------+----------------+--------+--------+--------+--------+--------+
+ *      |        |                |        |        |        |        |        |
+ * IFH  |        | ....           |        |  vvvvvvvvvvvvvvvvvvv     |        |
+ *      |        |                |        |  |     |        |  |     |        |
+ *      +--------+----------------+--------+--+-----+--------+--+-----+--------+
+ * Bits  223                       39    32 31|   24 23    16 15|    8 7      0
+ *                                            |                 |
+ *                                            |                 |
+ *                                            |                 |
+ *                                            v                 v
+ *                                        end       = 29       pos        = 13
+ *                                        end_rem   = 5        pos_rem    = 5
+ *                                        end_u8    = 3        start_u8   = 1
+ *                                        BTM_MSK(5)= 0x3f     TOP_MSK(5) = 0xe0
+ *
+ *
+ * In end_u8 and start_u8 we must merge the existing IFH byte with the new
+ * value. In the 'middle' bytes of the value we can overwrite the corresponding
+ * IFH byte.
+ */
+static __always_inline void lan9645x_ifh_set(u8 *ifh, u32 val, size_t pos,
+					     size_t length)
+{
+	size_t end = (pos + length) - 1;
+	size_t end_rem = end & 0x7;
+	size_t pos_rem = pos & 0x7;
+	size_t start_u8 = pos >> 3;
+	size_t end_u8 = end >> 3;
+	u8 end_mask, start_mask;
+	size_t vshift;
+	u8 *ptr;
+
+	BUILD_BUG_ON_MSG(length > 32, "IFH field size wider than 32.");
+	BUILD_BUG_ON_MSG(length == 0, "IFH field size of 0.");
+	BUILD_BUG_ON_MSG(pos + length > LAN9645X_IFH_BITS,
+			 "IFH field overflows IFH");
+
+	end_mask = BTM_MSK(end_rem);
+	start_mask = TOP_MSK(pos_rem);
+
+	ptr = &ifh[LAN9645X_IFH_LEN - 1 - end_u8];
+
+	if (end_u8 == start_u8)
+		return set_merge_mask(ptr, val << pos_rem,
+				      end_mask & start_mask);
+
+	vshift = length - end_rem - 1;
+	set_merge_mask(ptr++, val >> vshift, end_mask);
+
+	for (size_t j = 1; j < end_u8 - start_u8; j++) {
+		vshift -= 8;
+		*ptr++ = val >> vshift;
+	}
+
+	set_merge_mask(ptr, val << pos_rem, start_mask);
+}
+
+static __always_inline u32 lan9645x_ifh_get(const u8 *ifh, size_t pos,
+					    size_t length)
+{
+	size_t end = (pos + length) - 1;
+	size_t end_rem = end & 0x7;
+	size_t pos_rem = pos & 0x7;
+	size_t start_u8 = pos >> 3;
+	size_t end_u8 = end >> 3;
+	u8 end_mask, start_mask;
+	const u8 *ptr;
+	u32 val;
+
+	BUILD_BUG_ON_MSG(length > 32, "IFH field size wider than 32.");
+	BUILD_BUG_ON_MSG(length == 0, "IFH field size of 0.");
+	BUILD_BUG_ON_MSG(pos + length > LAN9645X_IFH_BITS,
+			 "IFH field overflows IFH");
+
+	end_mask = BTM_MSK(end_rem);
+	start_mask = TOP_MSK(pos_rem);
+
+	ptr = &ifh[LAN9645X_IFH_LEN - 1 - end_u8];
+
+	if (end_u8 == start_u8)
+		return (*ptr & end_mask & start_mask) >> pos_rem;
+
+	val = *ptr++ & end_mask;
+
+	for (size_t j = 1; j < end_u8 - start_u8; j++)
+		val = val << 8 | *ptr++;
+
+	return val << (8 - pos_rem) | (*ptr & start_mask) >> pos_rem;
+}
+
+static void lan9645x_xmit_get_vlan_info(struct sk_buff *skb,
+					struct net_device *br,
+					u32 *vlan_tci, u32 *tag_type)
+{
+	struct vlan_ethhdr *hdr;
+	u16 proto, tci;
+
+	if (!br || !br_vlan_enabled(br)) {
+		*vlan_tci = 0;
+		*tag_type = LAN9645X_IFH_TAG_TYPE_C;
+		return;
+	}
+
+	hdr = (struct vlan_ethhdr *)skb_mac_header(skb);
+	br_vlan_get_proto(br, &proto);
+
+	if (skb_headlen(skb) >= VLAN_ETH_HLEN &&
+	    ntohs(hdr->h_vlan_proto) == proto) {
+		vlan_remove_tag(skb, &tci);
+		*vlan_tci = tci;
+	} else {
+		rcu_read_lock();
+		br_vlan_get_pvid_rcu(br, &tci);
+		rcu_read_unlock();
+		*vlan_tci = tci;
+	}
+
+	*tag_type = (proto != ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
+					     LAN9645X_IFH_TAG_TYPE_C;
+}
+
+static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
+				     struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	struct dsa_switch *ds = dp->ds;
+	u32 cpu_port = ds->num_ports;
+	u32 vlan_tci, tag_type;
+	u32 qos_class;
+	void *ifh;
+
+	lan9645x_xmit_get_vlan_info(skb, dsa_port_bridge_dev_get(dp), &vlan_tci,
+				    &tag_type);
+
+	/* We need to make sure frame has the proper size after IFH is stripped
+	 * by hw.
+	 */
+	if (__skb_put_padto(skb, ETH_ZLEN, false))
+		return NULL;
+
+	qos_class = netdev_get_num_tc(ndev) ?
+		    netdev_get_prio_tc_map(ndev, skb->priority) :
+		    skb->priority;
+
+	/* Make room for IFH */
+	ifh = skb_push(skb, LAN9645X_IFH_LEN);
+	memset(ifh, 0, LAN9645X_IFH_LEN);
+
+	lan9645x_ifh_set(ifh, 1, IFH_BYPASS, IFH_BYPASS_SZ);
+	lan9645x_ifh_set(ifh, cpu_port, IFH_SRCPORT, IFH_SRCPORT_SZ);
+	lan9645x_ifh_set(ifh, tag_type, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ);
+	lan9645x_ifh_set(ifh, vlan_tci, IFH_TCI, IFH_TCI_SZ);
+	lan9645x_ifh_set(ifh, qos_class, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
+	lan9645x_ifh_set(ifh, BIT(dp->index), IFH_DSTS, IFH_DSTS_SZ);
+
+	return skb;
+}
+
+static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
+				    struct net_device *ndev)
+{
+	u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs;
+	struct dsa_port *dp;
+	u32 ifh_gap_len = 0;
+	u16 vlan_tpid;
+	u8 *ifh;
+
+	/* DSA master already consumed DMAC,SMAC,ETYPE from long prefix. Go back
+	 * to beginning of frame.
+	 */
+	skb_push(skb, ETH_HLEN);
+
+	if (unlikely(!pskb_may_pull(skb, LAN9645X_TOTAL_TAG_LEN)))
+		return NULL;
+
+	/* IFH starts after our long prefix */
+	ifh = skb_pull(skb, LAN9645X_LONG_PREFIX_LEN);
+
+	popcnt = lan9645x_ifh_get(ifh, IFH_POP_CNT, IFH_POP_CNT_SZ);
+	etype_ofs = lan9645x_ifh_get(ifh, IFH_ETYPE_OFS, IFH_ETYPE_OFS_SZ);
+	src_port = lan9645x_ifh_get(ifh, IFH_SRCPORT, IFH_SRCPORT_SZ);
+	tag_type = lan9645x_ifh_get(ifh, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ);
+	vlan_tci = lan9645x_ifh_get(ifh, IFH_TCI, IFH_TCI_SZ);
+	qos_class = lan9645x_ifh_get(ifh, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
+
+	/* Set skb->data at start of real header
+	 *
+	 * Since REW_PORT_NO_REWRITE=0 is required on the NPI port, we need to
+	 * account for any tags popped by the hardware, as that will leave a gap
+	 * between the IFH and DMAC.
+	 */
+	if (popcnt == 0 && etype_ofs == 0)
+		ifh_gap_len = 2 * VLAN_HLEN;
+	else if (popcnt == 3)
+		ifh_gap_len = VLAN_HLEN;
+
+	skb_pull(skb, LAN9645X_IFH_LEN);
+
+	if (unlikely(!pskb_may_pull(skb, ifh_gap_len + ETH_HLEN)))
+		return NULL;
+
+	skb_pull(skb, ifh_gap_len);
+	skb_reset_mac_header(skb);
+	skb_set_network_header(skb, ETH_HLEN);
+	skb_reset_mac_len(skb);
+
+	/* Reset skb->data past the actual ethernet header. */
+	skb_pull(skb, ETH_HLEN);
+
+	/* We must deliver the skb so skb->csum only covers the data beyond the
+	 * real ethernet header. The fake ethernet header in the prefix is
+	 * not part of skb->csum already. We must subtract what remains of the
+	 * prefix, the ifh and the gap.
+	 */
+	skb_postpull_rcsum(skb,
+			   skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_len,
+			   LAN9645X_TOTAL_TAG_LEN + ifh_gap_len);
+
+	skb->dev = dsa_conduit_find_user(ndev, 0, src_port);
+	if (WARN_ON_ONCE(!skb->dev)) {
+		/* This should never happen since we have disabled reflection
+		 * back to CPU_PORT.
+		 */
+		return NULL;
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+
+	skb->priority = qos_class;
+
+	/* While we have REW_PORT_NO_REWRITE=0 on the NPI port, we still disable
+	 * port VLAN tagging with REW_TAG_CFG. Any classified VID, different
+	 * from a VID in the frame, will not be written to the frame, but is
+	 * only communicated via the IFH. So for VLAN-aware ports we add the IFH
+	 * vlan to the skb.
+	 */
+	dp = dsa_user_to_port(skb->dev);
+	vlan_tpid = tag_type ? ETH_P_8021AD : ETH_P_8021Q;
+
+	if (dsa_port_is_vlan_filtering(dp) && vlan_tci) {
+		u16 port_pvid = 0;
+
+		br_vlan_get_pvid_rcu(skb->dev, &port_pvid);
+
+		if ((vlan_tci & VLAN_VID_MASK) != port_pvid)
+			__vlan_hwaccel_put_tag(skb, htons(vlan_tpid), vlan_tci);
+	}
+
+	return skb;
+}
+
+static const struct dsa_device_ops lan9645x_netdev_ops = {
+	.name = LAN9645X_NAME,
+	.proto = DSA_TAG_PROTO_LAN9645X,
+	.xmit = lan9645x_xmit,
+	.rcv = lan9645x_rcv,
+	.needed_headroom = LAN9645X_TOTAL_TAG_LEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for LAN9645x family of switches, using NPI port");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_LAN9645X, LAN9645X_NAME);
+
+module_dsa_tag_driver(lan9645x_netdev_ops);

-- 
2.52.0


