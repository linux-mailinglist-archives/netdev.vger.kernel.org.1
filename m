Return-Path: <netdev+bounces-196082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF0AD3789
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CD217CF37
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D2D29C32B;
	Tue, 10 Jun 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TgUHf5+1"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA029B8F0;
	Tue, 10 Jun 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559814; cv=none; b=fpasnMm5oFk7RSS5DgWUQigAaJKjsEzaR29EZnzCCUe5tK9KnUA5ZZ2ztBtyZ+u6ZpFdH7+Jdaqkr4+EOl7jWx3CcfWedo/XlKa2GmS2jm6eM22yux34IPhCULpShe1tgIrky1Dsjy0x7mcWz6fksWF/LSO+kWqcWx0cNWd4IIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559814; c=relaxed/simple;
	bh=hSXQAL/XYDhVoGXc2TfWBd6ly2i9wLtIu2FFpqXGOqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=RuP7PIOA5Py8skq5fqPFbX4cVPnmrHW+MCx0o++MX6FJkuk8CkM6L/vVrJGzzUWf+GdskcvSgHSBdqir3tFnEhqbZeAu4e6shYx/f1UjOkq41OUH/vrYRKmoL/9+OuEbiCBjzO/W6queOJV1bMKJVpu0hhMiOdh4M+8DEfOPSuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TgUHf5+1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C629C439F5;
	Tue, 10 Jun 2025 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749559804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WX69fvV8Iim/TSycnvKfKVMX/kLs1V7zftTFLEqf1Kc=;
	b=TgUHf5+1N4WnDePx4pztNYq7+Bg+q6TTtLPTY+rz88O3Fw06Fw+/iMMImMiWee2T5trt82
	RaK0ynLcQjEtDWInMv8LH9L44+3iUL9a3b+RpnNG8Nt/jz9jtcJQ0S33/o4MN04RclGdj5
	flGP5+X3YZQYQ5GgCgfx1OaI6vUc0FhQdHS7XVAsOw4wixSDBQSRPnR5d3OJjcpovB4xp5
	L04tSr7Hp1Cfu30V19rWaX2HaHcatw46dtq/my/uJLm/Gv6MCp2P+zAxgUPvGV8vzE3kDW
	idjpx9QKrnmDqzfEfTCWboakopOAQQkeu3fmy8Uu8Ds0Gk28RNq5+mRy1XiVVA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 10 Jun 2025 14:50:01 +0200
Subject: [PATCH ethtool 1/2] update UAPI header copies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-feature_phc_source-v1-1-cbd1adef12aa@bootlin.com>
References: <20250610-feature_phc_source-v1-0-cbd1adef12aa@bootlin.com>
In-Reply-To: <20250610-feature_phc_source-v1-0-cbd1adef12aa@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, Russell King <linux@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeefteeifeefheevheefhffgveduffeltdeivdethedtieegveehuefgffduheektdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtp
 hhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhk
X-GND-Sasl: kory.maincent@bootlin.com

Update to kernel commit 2c7e4a2663a1.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 uapi/linux/ethtool.h                   | 134 +++++++++++++++++----------------
 uapi/linux/ethtool_netlink_generated.h |  19 +++--
 uapi/linux/if_link.h                   |  15 ++++
 3 files changed, 98 insertions(+), 70 deletions(-)

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
index fa0522b..fb973c3 100644
--- a/uapi/linux/ethtool_netlink_generated.h
+++ b/uapi/linux/ethtool_netlink_generated.h
@@ -31,17 +31,24 @@ enum ethtool_header_flags {
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
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -406,6 +413,8 @@ enum {
 	ETHTOOL_A_TSINFO_PHC_INDEX,
 	ETHTOOL_A_TSINFO_STATS,
 	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER,
+	ETHTOOL_A_TSINFO_HWTSTAMP_SOURCE,
+	ETHTOOL_A_TSINFO_HWTSTAMP_PHYINDEX,
 
 	__ETHTOOL_A_TSINFO_CNT,
 	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
diff --git a/uapi/linux/if_link.h b/uapi/linux/if_link.h
index ceff2f2..bb94d88 100644
--- a/uapi/linux/if_link.h
+++ b/uapi/linux/if_link.h
@@ -1984,4 +1984,19 @@ enum {
 
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


