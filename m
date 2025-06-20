Return-Path: <netdev+bounces-199744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E498BAE1B02
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792D94A78AA
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F828B7F8;
	Fri, 20 Jun 2025 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FPND23I+"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E228B51F;
	Fri, 20 Jun 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422803; cv=none; b=LYzZ+vnL2KSfDsda+9vBXSBeezUMaqtz4BvSM/h7OVrev8q017FoCrr/0vT1YPCIPpbD6Z0RkYPG3Iwsle2XMSYjbB/HEKQOBVViHOQzrpI5Og/hzMi9J6CsYas3EfZWIt4wcq2SlnA/XZgKpHMbAdESBBSHxiSfKhC+x4lZBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422803; c=relaxed/simple;
	bh=Tx2iuY7WTJRCRdb+By+4+ha12rfjdgsCr5BbtyuNaEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKJOWxvA+yckV6tfFZxx44FxFJNtdV7dnp2OioBKTsRTMuO6TvXZDcjtCPR6X2yViVgEW7OpAyjSJWt93/oA82dYaJgmp+UEAuXCpJJDJXegqTED2tSKlu/o9d/tfkyGE5xt5TdHr23cxZ0jzZs+omFoZa8JqOVcyEjaVHg/mrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FPND23I+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A828205B9;
	Fri, 20 Jun 2025 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750422799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKo/BXWI1JK7r7b6qKlGabXnKQxUEGpnUcQ7be9VQt4=;
	b=FPND23I+ipXsNjvUPgVayjt19E3l0E5S4mKTTnS9Wur3jcq3f9ynjVT0NA3NMwJfw3tsTa
	vcii14E7UAssczzZ9k48cOAbH78vQ7ku15hrtyB1pDDXBd2nhSgNlqWvjyVbXlnenR97HR
	2hCLfI1R6lg9ulLkrm5tA9liDjH03oz4Y3cWyWFiFC8UsX47ZFpgGVIi1l/WP8Zir4ZVjD
	ryV5NWcvEkLeXLT9ZVmvV5jo/nd8foZwrk7RxWk+hmsorrbysf41kHezZvd12216a6hnMu
	yxPzMxrarX38TJJkxh2WJSvIiUSXFGQJzsKxK/nhPDwDo9PC5i2u94XC4Pp2xA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 20 Jun 2025 14:33:06 +0200
Subject: [PATCH ethtool-next 1/2] update UAPI header copies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-b4-feature_poe_pw_budget-v1-1-0bdb7d2b9c8f@bootlin.com>
References: <20250620-b4-feature_poe_pw_budget-v1-0-0bdb7d2b9c8f@bootlin.com>
In-Reply-To: <20250620-b4-feature_poe_pw_budget-v1-0-0bdb7d2b9c8f@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghhpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepn
 hgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtii
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Update to kernel commit 757639ac608e.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 uapi/linux/ethtool.h                   | 134 +++++++++++++++++----------------
 uapi/linux/ethtool_netlink_generated.h |  59 +++++++++++++--
 uapi/linux/if_link.h                   |  16 ++++
 3 files changed, 139 insertions(+), 70 deletions(-)

diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 506e086..253df22 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -2293,71 +2293,75 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
 #define	RXH_XFRM_NO_CHANGE	0xff
 
-/* L2-L4 network traffic flow types */
-#define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
-#define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
-#define	SCTP_V4_FLOW	0x03	/* hash or spec (sctp_ip4_spec) */
-#define	AH_ESP_V4_FLOW	0x04	/* hash only */
-#define	TCP_V6_FLOW	0x05	/* hash or spec (tcp_ip6_spec; nfc only) */
-#define	UDP_V6_FLOW	0x06	/* hash or spec (udp_ip6_spec; nfc only) */
-#define	SCTP_V6_FLOW	0x07	/* hash or spec (sctp_ip6_spec; nfc only) */
-#define	AH_ESP_V6_FLOW	0x08	/* hash only */
-#define	AH_V4_FLOW	0x09	/* hash or spec (ah_ip4_spec) */
-#define	ESP_V4_FLOW	0x0a	/* hash or spec (esp_ip4_spec) */
-#define	AH_V6_FLOW	0x0b	/* hash or spec (ah_ip6_spec; nfc only) */
-#define	ESP_V6_FLOW	0x0c	/* hash or spec (esp_ip6_spec; nfc only) */
-#define	IPV4_USER_FLOW	0x0d	/* spec only (usr_ip4_spec) */
-#define	IP_USER_FLOW	IPV4_USER_FLOW
-#define	IPV6_USER_FLOW	0x0e	/* spec only (usr_ip6_spec; nfc only) */
-#define	IPV4_FLOW	0x10	/* hash only */
-#define	IPV6_FLOW	0x11	/* hash only */
-#define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
-
-/* Used for GTP-U IPv4 and IPv6.
- * The format of GTP packets only includes
- * elements such as TEID and GTP version.
- * It is primarily intended for data communication of the UE.
- */
-#define GTPU_V4_FLOW 0x13	/* hash only */
-#define GTPU_V6_FLOW 0x14	/* hash only */
-
-/* Use for GTP-C IPv4 and v6.
- * The format of these GTP packets does not include TEID.
- * Primarily expected to be used for communication
- * to create sessions for UE data communication,
- * commonly referred to as CSR (Create Session Request).
- */
-#define GTPC_V4_FLOW 0x15	/* hash only */
-#define GTPC_V6_FLOW 0x16	/* hash only */
-
-/* Use for GTP-C IPv4 and v6.
- * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
- * After session creation, it becomes this packet.
- * This is mainly used for requests to realize UE handover.
- */
-#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
-#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
-
-/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
- * The format of these GTP packets includes TEID and QFI.
- * In 5G communication using UPF (User Plane Function),
- * data communication with this extended header is performed.
- */
-#define GTPU_EH_V4_FLOW 0x19	/* hash only */
-#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
-
-/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
- * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
- * UL/DL included in the PSC.
- * There are differences in the data included based on Downlink/Uplink,
- * and can be used to distinguish packets.
- * The functions described so far are useful when you want to
- * handle communication from the mobile network in UPF, PGW, etc.
- */
-#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
-#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
-#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
-#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
+enum {
+	/* L2-L4 network traffic flow types */
+	TCP_V4_FLOW	= 0x01,	/* hash or spec (tcp_ip4_spec) */
+	UDP_V4_FLOW	= 0x02,	/* hash or spec (udp_ip4_spec) */
+	SCTP_V4_FLOW	= 0x03,	/* hash or spec (sctp_ip4_spec) */
+	AH_ESP_V4_FLOW	= 0x04,	/* hash only */
+	TCP_V6_FLOW	= 0x05,	/* hash or spec (tcp_ip6_spec; nfc only) */
+	UDP_V6_FLOW	= 0x06,	/* hash or spec (udp_ip6_spec; nfc only) */
+	SCTP_V6_FLOW	= 0x07,	/* hash or spec (sctp_ip6_spec; nfc only) */
+	AH_ESP_V6_FLOW	= 0x08,	/* hash only */
+	AH_V4_FLOW	= 0x09,	/* hash or spec (ah_ip4_spec) */
+	ESP_V4_FLOW	= 0x0a,	/* hash or spec (esp_ip4_spec) */
+	AH_V6_FLOW	= 0x0b,	/* hash or spec (ah_ip6_spec; nfc only) */
+	ESP_V6_FLOW	= 0x0c,	/* hash or spec (esp_ip6_spec; nfc only) */
+	IPV4_USER_FLOW	= 0x0d,	/* spec only (usr_ip4_spec) */
+	IP_USER_FLOW	= IPV4_USER_FLOW,
+	IPV6_USER_FLOW	= 0x0e, /* spec only (usr_ip6_spec; nfc only) */
+	IPV4_FLOW	= 0x10, /* hash only */
+	IPV6_FLOW	= 0x11, /* hash only */
+	ETHER_FLOW	= 0x12, /* spec only (ether_spec) */
+
+	/* Used for GTP-U IPv4 and IPv6.
+	 * The format of GTP packets only includes
+	 * elements such as TEID and GTP version.
+	 * It is primarily intended for data communication of the UE.
+	 */
+	GTPU_V4_FLOW	= 0x13,	/* hash only */
+	GTPU_V6_FLOW	= 0x14,	/* hash only */
+
+	/* Use for GTP-C IPv4 and v6.
+	 * The format of these GTP packets does not include TEID.
+	 * Primarily expected to be used for communication
+	 * to create sessions for UE data communication,
+	 * commonly referred to as CSR (Create Session Request).
+	 */
+	GTPC_V4_FLOW	= 0x15,	/* hash only */
+	GTPC_V6_FLOW	= 0x16,	/* hash only */
+
+	/* Use for GTP-C IPv4 and v6.
+	 * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
+	 * After session creation, it becomes this packet.
+	 * This is mainly used for requests to realize UE handover.
+	 */
+	GTPC_TEID_V4_FLOW	= 0x17,	/* hash only */
+	GTPC_TEID_V6_FLOW	= 0x18,	/* hash only */
+
+	/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
+	 * The format of these GTP packets includes TEID and QFI.
+	 * In 5G communication using UPF (User Plane Function),
+	 * data communication with this extended header is performed.
+	 */
+	GTPU_EH_V4_FLOW	= 0x19,	/* hash only */
+	GTPU_EH_V6_FLOW	= 0x1a,	/* hash only */
+
+	/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
+	 * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
+	 * UL/DL included in the PSC.
+	 * There are differences in the data included based on Downlink/Uplink,
+	 * and can be used to distinguish packets.
+	 * The functions described so far are useful when you want to
+	 * handle communication from the mobile network in UPF, PGW, etc.
+	 */
+	GTPU_UL_V4_FLOW	= 0x1b,	/* hash only */
+	GTPU_UL_V6_FLOW	= 0x1c,	/* hash only */
+	GTPU_DL_V4_FLOW	= 0x1d,	/* hash only */
+	GTPU_DL_V6_FLOW	= 0x1e,	/* hash only */
+
+	__FLOW_TYPE_COUNT,
+};
 
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
diff --git a/uapi/linux/ethtool_netlink_generated.h b/uapi/linux/ethtool_netlink_generated.h
index fa0522b..c06721f 100644
--- a/uapi/linux/ethtool_netlink_generated.h
+++ b/uapi/linux/ethtool_netlink_generated.h
@@ -31,17 +31,52 @@ enum ethtool_header_flags {
 	ETHTOOL_FLAG_STATS = 4,
 };
 
-enum {
-	ETHTOOL_PHY_UPSTREAM_TYPE_MAC,
-	ETHTOOL_PHY_UPSTREAM_TYPE_PHY,
-};
-
 enum ethtool_tcp_data_split {
 	ETHTOOL_TCP_DATA_SPLIT_UNKNOWN,
 	ETHTOOL_TCP_DATA_SPLIT_DISABLED,
 	ETHTOOL_TCP_DATA_SPLIT_ENABLED,
 };
 
+/**
+ * enum hwtstamp_source - Source of the hardware timestamp
+ * @HWTSTAMP_SOURCE_NETDEV: Hardware timestamp comes from a MAC or a device
+ *   which has MAC and PHY integrated
+ * @HWTSTAMP_SOURCE_PHYLIB: Hardware timestamp comes from one PHY device of the
+ *   network topology
+ */
+enum hwtstamp_source {
+	HWTSTAMP_SOURCE_NETDEV = 1,
+	HWTSTAMP_SOURCE_PHYLIB,
+};
+
+/**
+ * enum ethtool_pse_event - PSE event list for the PSE controller
+ * @ETHTOOL_PSE_EVENT_OVER_CURRENT: PSE output current is too high
+ * @ETHTOOL_PSE_EVENT_OVER_TEMP: PSE in over temperature state
+ * @ETHTOOL_C33_PSE_EVENT_DETECTION: detection process occur on the PSE. IEEE
+ *   802.3-2022 33.2.5 and 145.2.6 PSE detection of PDs. IEEE 802.3-202
+ *   30.9.1.1.5 aPSEPowerDetectionStatus
+ * @ETHTOOL_C33_PSE_EVENT_CLASSIFICATION: classification process occur on the
+ *   PSE. IEEE 802.3-2022 33.2.6 and 145.2.8 classification of PDs mutual
+ *   identification. IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification.
+ * @ETHTOOL_C33_PSE_EVENT_DISCONNECTION: PD has been disconnected on the PSE.
+ *   IEEE 802.3-2022 33.3.8 and 145.3.9 PD Maintain Power Signature. IEEE
+ *   802.3-2022 33.5.1.2.9 MPS Absent. IEEE 802.3-2022 30.9.1.1.20
+ *   aPSEMPSAbsentCounter.
+ * @ETHTOOL_PSE_EVENT_OVER_BUDGET: PSE turned off due to over budget situation
+ * @ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR: PSE faced an error managing the
+ *   power control from software
+ */
+enum ethtool_pse_event {
+	ETHTOOL_PSE_EVENT_OVER_CURRENT = 1,
+	ETHTOOL_PSE_EVENT_OVER_TEMP = 2,
+	ETHTOOL_C33_PSE_EVENT_DETECTION = 4,
+	ETHTOOL_C33_PSE_EVENT_CLASSIFICATION = 8,
+	ETHTOOL_C33_PSE_EVENT_DISCONNECTION = 16,
+	ETHTOOL_PSE_EVENT_OVER_BUDGET = 32,
+	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -406,6 +441,8 @@ enum {
 	ETHTOOL_A_TSINFO_PHC_INDEX,
 	ETHTOOL_A_TSINFO_STATS,
 	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER,
+	ETHTOOL_A_TSINFO_HWTSTAMP_SOURCE,
+	ETHTOOL_A_TSINFO_HWTSTAMP_PHYINDEX,
 
 	__ETHTOOL_A_TSINFO_CNT,
 	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
@@ -633,6 +670,9 @@ enum {
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
+	ETHTOOL_A_PSE_PW_D_ID,
+	ETHTOOL_A_PSE_PRIO_MAX,
+	ETHTOOL_A_PSE_PRIO,
 
 	__ETHTOOL_A_PSE_CNT,
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
@@ -709,6 +749,14 @@ enum {
 	ETHTOOL_A_TSCONFIG_MAX = (__ETHTOOL_A_TSCONFIG_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PSE_NTF_HEADER = 1,
+	ETHTOOL_A_PSE_NTF_EVENTS,
+
+	__ETHTOOL_A_PSE_NTF_CNT,
+	ETHTOOL_A_PSE_NTF_MAX = (__ETHTOOL_A_PSE_NTF_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -813,6 +861,7 @@ enum {
 	ETHTOOL_MSG_PHY_NTF,
 	ETHTOOL_MSG_TSCONFIG_GET_REPLY,
 	ETHTOOL_MSG_TSCONFIG_SET_REPLY,
+	ETHTOOL_MSG_PSE_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/uapi/linux/if_link.h b/uapi/linux/if_link.h
index ceff2f2..cdb5acc 100644
--- a/uapi/linux/if_link.h
+++ b/uapi/linux/if_link.h
@@ -1396,6 +1396,7 @@ enum {
 	IFLA_VXLAN_LOCALBYPASS,
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
 	IFLA_VXLAN_RESERVED_BITS,
+	IFLA_VXLAN_MC_ROUTE,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -1984,4 +1985,19 @@ enum {
 
 #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
 
+/* OVPN section */
+
+enum ovpn_mode {
+	OVPN_MODE_P2P,
+	OVPN_MODE_MP,
+};
+
+enum {
+	IFLA_OVPN_UNSPEC,
+	IFLA_OVPN_MODE,
+	__IFLA_OVPN_MAX,
+};
+
+#define IFLA_OVPN_MAX	(__IFLA_OVPN_MAX - 1)
+
 #endif /* _LINUX_IF_LINK_H */

-- 
2.43.0


