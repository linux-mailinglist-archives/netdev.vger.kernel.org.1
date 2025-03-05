Return-Path: <netdev+bounces-172165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F7A506BD
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D26173341
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B9D2512FE;
	Wed,  5 Mar 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UOg9JKBN"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61DD1AAE2E;
	Wed,  5 Mar 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196891; cv=none; b=UC6zRxQ4kP3udFYpzAi1whO4QTvUGu4CZkmYzyv6TNGwubFA8acqZX/d6EO3LegQGX2bUNuSdfvV8l7rMyEBflGJenA3UZRz42WvwOdNrjKqGTKVMPWJNzM+HQeuVzf8TwJUYxv+cNDFBBUzZh123Pnd6akbU7/X3Ro+MoYXzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196891; c=relaxed/simple;
	bh=AAA/DxOB+dkT7IPzhSTlVPKyf1c90xoaoCQSgj9dM3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTm8pf+aAxCDvtYIuhxYazQsaQT9+wNLFDnKr7VM1REvW3G75DRie3HuEM2DSUwADEd6Krtwskh0717ji0kHDJiCxUUzCMBDYYSRw+rZR+i3LPJRpmNb5/TwT5oLmZct+VUiZ+D10ggGgxqqUfRfRxrdW3J4askHDEHEEEt21Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UOg9JKBN; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7DFDD582EF9;
	Wed,  5 Mar 2025 17:34:06 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A25E4443AA;
	Wed,  5 Mar 2025 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741196044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oh1JZeocuIBcU+Y7a+NvLM3Q3tomPJP6vEaL38nAsw=;
	b=UOg9JKBNi52SVNVBCgjgztBWncTCvigq0ITLXLBmq0IGJ5LuhoifeFJOVrycW3C/pY36QK
	5tQWh5UFUREd5Qw90FJUSWCdiPKYqmkdmsfdLwXc1JPY5vo8HesU1zC1WR7mVq020hZjMY
	JUKtsvj6XnS4dZqn60FYrBOYGG5ZIHSxPamj4Aphnv2zoETp1E3gPM/WpPONqmMPseyZN7
	/hmHcN0jnoxL9jhouqRuT39w4/96ayu0gCQSDl6omWtHH+CTYsE/F1ZPwleQCnKq+KqFEU
	WdWFZDjnWFPPPuiEPeqowGjJPWNAAcqdaEbn8CWW/wsv8RhLaSX9hjdUQVNt+g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 05 Mar 2025 18:33:37 +0100
Subject: [PATCH ethtool-next 1/3] update UAPI header copies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-feature_ptp-v1-1-f36f64f69aaa@bootlin.com>
References: <20250305-feature_ptp-v1-0-f36f64f69aaa@bootlin.com>
In-Reply-To: <20250305-feature_ptp-v1-0-f36f64f69aaa@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhigihhnghesthgvnhgtvghnthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtl
 hhinhdrtghomhdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Update to kernel commit af08cc40ea61.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 uapi/linux/ethtool.h                   |  31 ++
 uapi/linux/ethtool_netlink.h           | 899 +--------------------------------
 uapi/linux/ethtool_netlink_generated.h | 821 ++++++++++++++++++++++++++++++
 uapi/linux/if_link.h                   |  26 +
 uapi/linux/net_tstamp.h                |  11 +
 uapi/linux/rtnetlink.h                 |  22 +-
 uapi/linux/stddef.h                    |  13 +-
 uapi/linux/types.h                     |   1 +
 8 files changed, 930 insertions(+), 894 deletions(-)

diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 7022fcc5628a0cc3d7eaf7969a7302fb4e376ec7..506e0866cbb2771bc0bd6c00dac5a8b0770e4b40 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -679,6 +679,8 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_ETH_MAC: names of IEEE 802.3 MAC statistics
  * @ETH_SS_STATS_ETH_CTRL: names of IEEE 802.3 MAC Control statistics
  * @ETH_SS_STATS_RMON: names of RMON statistics
+ * @ETH_SS_STATS_PHY: names of PHY(dev) statistics
+ * @ETH_SS_TS_FLAGS: hardware timestamping flags
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -704,6 +706,8 @@ enum ethtool_stringset {
 	ETH_SS_STATS_ETH_MAC,
 	ETH_SS_STATS_ETH_CTRL,
 	ETH_SS_STATS_RMON,
+	ETH_SS_STATS_PHY,
+	ETH_SS_TS_FLAGS,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
@@ -2053,6 +2057,24 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
 	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 = 102,
+	ETHTOOL_LINK_MODE_200000baseCR_Full_BIT		 = 103,
+	ETHTOOL_LINK_MODE_200000baseKR_Full_BIT		 = 104,
+	ETHTOOL_LINK_MODE_200000baseDR_Full_BIT		 = 105,
+	ETHTOOL_LINK_MODE_200000baseDR_2_Full_BIT	 = 106,
+	ETHTOOL_LINK_MODE_200000baseSR_Full_BIT		 = 107,
+	ETHTOOL_LINK_MODE_200000baseVR_Full_BIT		 = 108,
+	ETHTOOL_LINK_MODE_400000baseCR2_Full_BIT	 = 109,
+	ETHTOOL_LINK_MODE_400000baseKR2_Full_BIT	 = 110,
+	ETHTOOL_LINK_MODE_400000baseDR2_Full_BIT	 = 111,
+	ETHTOOL_LINK_MODE_400000baseDR2_2_Full_BIT	 = 112,
+	ETHTOOL_LINK_MODE_400000baseSR2_Full_BIT	 = 113,
+	ETHTOOL_LINK_MODE_400000baseVR2_Full_BIT	 = 114,
+	ETHTOOL_LINK_MODE_800000baseCR4_Full_BIT	 = 115,
+	ETHTOOL_LINK_MODE_800000baseKR4_Full_BIT	 = 116,
+	ETHTOOL_LINK_MODE_800000baseDR4_Full_BIT	 = 117,
+	ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT	 = 118,
+	ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT	 = 119,
+	ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT	 = 120,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
@@ -2265,6 +2287,10 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
  * be exploited to reduce the RSS queue spread.
  */
 #define	RXH_XFRM_SYM_XOR	(1 << 0)
+/* Similar to SYM_XOR, except that one copy of the XOR'ed fields is replaced by
+ * an OR of the same fields
+ */
+#define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
 #define	RXH_XFRM_NO_CHANGE	0xff
 
 /* L2-L4 network traffic flow types */
@@ -2524,6 +2550,11 @@ struct ethtool_link_settings {
 	__u8	master_slave_state;
 	__u8	rate_matching;
 	__u32	reserved[7];
+	/* Linux builds with -Wflex-array-member-not-at-end but does
+	 * not use the "link_mode_masks" member. Leave it defined for
+	 * userspace for now, and when userspace wants to start using
+	 * -Wfamnae, we'll need a new solution.
+	 */
 	__u32	link_mode_masks[];
 	/* layout of link_mode_masks fields:
 	 * __u32 map_supported[link_mode_masks_nwords];
diff --git a/uapi/linux/ethtool_netlink.h b/uapi/linux/ethtool_netlink.h
index 5d2bdd36fb9f8c21c7462152be1f68c312e6768e..fc8bcf8bf5c0b26fe3252b63e36fb1aeb8f5aa51 100644
--- a/uapi/linux/ethtool_netlink.h
+++ b/uapi/linux/ethtool_netlink.h
@@ -10,545 +10,12 @@
 #define _LINUX_ETHTOOL_NETLINK_H_
 
 #include <linux/ethtool.h>
-
-/* message types - userspace to kernel */
-enum {
-	ETHTOOL_MSG_USER_NONE,
-	ETHTOOL_MSG_STRSET_GET,
-	ETHTOOL_MSG_LINKINFO_GET,
-	ETHTOOL_MSG_LINKINFO_SET,
-	ETHTOOL_MSG_LINKMODES_GET,
-	ETHTOOL_MSG_LINKMODES_SET,
-	ETHTOOL_MSG_LINKSTATE_GET,
-	ETHTOOL_MSG_DEBUG_GET,
-	ETHTOOL_MSG_DEBUG_SET,
-	ETHTOOL_MSG_WOL_GET,
-	ETHTOOL_MSG_WOL_SET,
-	ETHTOOL_MSG_FEATURES_GET,
-	ETHTOOL_MSG_FEATURES_SET,
-	ETHTOOL_MSG_PRIVFLAGS_GET,
-	ETHTOOL_MSG_PRIVFLAGS_SET,
-	ETHTOOL_MSG_RINGS_GET,
-	ETHTOOL_MSG_RINGS_SET,
-	ETHTOOL_MSG_CHANNELS_GET,
-	ETHTOOL_MSG_CHANNELS_SET,
-	ETHTOOL_MSG_COALESCE_GET,
-	ETHTOOL_MSG_COALESCE_SET,
-	ETHTOOL_MSG_PAUSE_GET,
-	ETHTOOL_MSG_PAUSE_SET,
-	ETHTOOL_MSG_EEE_GET,
-	ETHTOOL_MSG_EEE_SET,
-	ETHTOOL_MSG_TSINFO_GET,
-	ETHTOOL_MSG_CABLE_TEST_ACT,
-	ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
-	ETHTOOL_MSG_TUNNEL_INFO_GET,
-	ETHTOOL_MSG_FEC_GET,
-	ETHTOOL_MSG_FEC_SET,
-	ETHTOOL_MSG_MODULE_EEPROM_GET,
-	ETHTOOL_MSG_STATS_GET,
-	ETHTOOL_MSG_PHC_VCLOCKS_GET,
-	ETHTOOL_MSG_MODULE_GET,
-	ETHTOOL_MSG_MODULE_SET,
-	ETHTOOL_MSG_PSE_GET,
-	ETHTOOL_MSG_PSE_SET,
-	ETHTOOL_MSG_RSS_GET,
-	ETHTOOL_MSG_PLCA_GET_CFG,
-	ETHTOOL_MSG_PLCA_SET_CFG,
-	ETHTOOL_MSG_PLCA_GET_STATUS,
-	ETHTOOL_MSG_MM_GET,
-	ETHTOOL_MSG_MM_SET,
-	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
-	ETHTOOL_MSG_PHY_GET,
-
-	/* add new constants above here */
-	__ETHTOOL_MSG_USER_CNT,
-	ETHTOOL_MSG_USER_MAX = __ETHTOOL_MSG_USER_CNT - 1
-};
-
-/* message types - kernel to userspace */
-enum {
-	ETHTOOL_MSG_KERNEL_NONE,
-	ETHTOOL_MSG_STRSET_GET_REPLY,
-	ETHTOOL_MSG_LINKINFO_GET_REPLY,
-	ETHTOOL_MSG_LINKINFO_NTF,
-	ETHTOOL_MSG_LINKMODES_GET_REPLY,
-	ETHTOOL_MSG_LINKMODES_NTF,
-	ETHTOOL_MSG_LINKSTATE_GET_REPLY,
-	ETHTOOL_MSG_DEBUG_GET_REPLY,
-	ETHTOOL_MSG_DEBUG_NTF,
-	ETHTOOL_MSG_WOL_GET_REPLY,
-	ETHTOOL_MSG_WOL_NTF,
-	ETHTOOL_MSG_FEATURES_GET_REPLY,
-	ETHTOOL_MSG_FEATURES_SET_REPLY,
-	ETHTOOL_MSG_FEATURES_NTF,
-	ETHTOOL_MSG_PRIVFLAGS_GET_REPLY,
-	ETHTOOL_MSG_PRIVFLAGS_NTF,
-	ETHTOOL_MSG_RINGS_GET_REPLY,
-	ETHTOOL_MSG_RINGS_NTF,
-	ETHTOOL_MSG_CHANNELS_GET_REPLY,
-	ETHTOOL_MSG_CHANNELS_NTF,
-	ETHTOOL_MSG_COALESCE_GET_REPLY,
-	ETHTOOL_MSG_COALESCE_NTF,
-	ETHTOOL_MSG_PAUSE_GET_REPLY,
-	ETHTOOL_MSG_PAUSE_NTF,
-	ETHTOOL_MSG_EEE_GET_REPLY,
-	ETHTOOL_MSG_EEE_NTF,
-	ETHTOOL_MSG_TSINFO_GET_REPLY,
-	ETHTOOL_MSG_CABLE_TEST_NTF,
-	ETHTOOL_MSG_CABLE_TEST_TDR_NTF,
-	ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY,
-	ETHTOOL_MSG_FEC_GET_REPLY,
-	ETHTOOL_MSG_FEC_NTF,
-	ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY,
-	ETHTOOL_MSG_STATS_GET_REPLY,
-	ETHTOOL_MSG_PHC_VCLOCKS_GET_REPLY,
-	ETHTOOL_MSG_MODULE_GET_REPLY,
-	ETHTOOL_MSG_MODULE_NTF,
-	ETHTOOL_MSG_PSE_GET_REPLY,
-	ETHTOOL_MSG_RSS_GET_REPLY,
-	ETHTOOL_MSG_PLCA_GET_CFG_REPLY,
-	ETHTOOL_MSG_PLCA_GET_STATUS_REPLY,
-	ETHTOOL_MSG_PLCA_NTF,
-	ETHTOOL_MSG_MM_GET_REPLY,
-	ETHTOOL_MSG_MM_NTF,
-	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
-	ETHTOOL_MSG_PHY_GET_REPLY,
-	ETHTOOL_MSG_PHY_NTF,
-
-	/* add new constants above here */
-	__ETHTOOL_MSG_KERNEL_CNT,
-	ETHTOOL_MSG_KERNEL_MAX = __ETHTOOL_MSG_KERNEL_CNT - 1
-};
-
-/* request header */
-
-enum ethtool_header_flags {
-	ETHTOOL_FLAG_COMPACT_BITSETS	= 1 << 0,	/* use compact bitsets in reply */
-	ETHTOOL_FLAG_OMIT_REPLY		= 1 << 1,	/* provide optional reply for SET or ACT requests */
-	ETHTOOL_FLAG_STATS		= 1 << 2,	/* request statistics, if supported by the driver */
-};
+#include <linux/ethtool_netlink_generated.h>
 
 #define ETHTOOL_FLAG_ALL (ETHTOOL_FLAG_COMPACT_BITSETS | \
 			  ETHTOOL_FLAG_OMIT_REPLY | \
 			  ETHTOOL_FLAG_STATS)
 
-enum {
-	ETHTOOL_A_HEADER_UNSPEC,
-	ETHTOOL_A_HEADER_DEV_INDEX,		/* u32 */
-	ETHTOOL_A_HEADER_DEV_NAME,		/* string */
-	ETHTOOL_A_HEADER_FLAGS,			/* u32 - ETHTOOL_FLAG_* */
-	ETHTOOL_A_HEADER_PHY_INDEX,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_HEADER_CNT,
-	ETHTOOL_A_HEADER_MAX = __ETHTOOL_A_HEADER_CNT - 1
-};
-
-/* bit sets */
-
-enum {
-	ETHTOOL_A_BITSET_BIT_UNSPEC,
-	ETHTOOL_A_BITSET_BIT_INDEX,		/* u32 */
-	ETHTOOL_A_BITSET_BIT_NAME,		/* string */
-	ETHTOOL_A_BITSET_BIT_VALUE,		/* flag */
-
-	/* add new constants above here */
-	__ETHTOOL_A_BITSET_BIT_CNT,
-	ETHTOOL_A_BITSET_BIT_MAX = __ETHTOOL_A_BITSET_BIT_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_BITSET_BITS_UNSPEC,
-	ETHTOOL_A_BITSET_BITS_BIT,		/* nest - _A_BITSET_BIT_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_BITSET_BITS_CNT,
-	ETHTOOL_A_BITSET_BITS_MAX = __ETHTOOL_A_BITSET_BITS_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_BITSET_UNSPEC,
-	ETHTOOL_A_BITSET_NOMASK,		/* flag */
-	ETHTOOL_A_BITSET_SIZE,			/* u32 */
-	ETHTOOL_A_BITSET_BITS,			/* nest - _A_BITSET_BITS_* */
-	ETHTOOL_A_BITSET_VALUE,			/* binary */
-	ETHTOOL_A_BITSET_MASK,			/* binary */
-
-	/* add new constants above here */
-	__ETHTOOL_A_BITSET_CNT,
-	ETHTOOL_A_BITSET_MAX = __ETHTOOL_A_BITSET_CNT - 1
-};
-
-/* string sets */
-
-enum {
-	ETHTOOL_A_STRING_UNSPEC,
-	ETHTOOL_A_STRING_INDEX,			/* u32 */
-	ETHTOOL_A_STRING_VALUE,			/* string */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRING_CNT,
-	ETHTOOL_A_STRING_MAX = __ETHTOOL_A_STRING_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_STRINGS_UNSPEC,
-	ETHTOOL_A_STRINGS_STRING,		/* nest - _A_STRINGS_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRINGS_CNT,
-	ETHTOOL_A_STRINGS_MAX = __ETHTOOL_A_STRINGS_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_STRINGSET_UNSPEC,
-	ETHTOOL_A_STRINGSET_ID,			/* u32 */
-	ETHTOOL_A_STRINGSET_COUNT,		/* u32 */
-	ETHTOOL_A_STRINGSET_STRINGS,		/* nest - _A_STRINGS_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRINGSET_CNT,
-	ETHTOOL_A_STRINGSET_MAX = __ETHTOOL_A_STRINGSET_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_STRINGSETS_UNSPEC,
-	ETHTOOL_A_STRINGSETS_STRINGSET,		/* nest - _A_STRINGSET_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRINGSETS_CNT,
-	ETHTOOL_A_STRINGSETS_MAX = __ETHTOOL_A_STRINGSETS_CNT - 1
-};
-
-/* STRSET */
-
-enum {
-	ETHTOOL_A_STRSET_UNSPEC,
-	ETHTOOL_A_STRSET_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_STRSET_STRINGSETS,		/* nest - _A_STRINGSETS_* */
-	ETHTOOL_A_STRSET_COUNTS_ONLY,		/* flag */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRSET_CNT,
-	ETHTOOL_A_STRSET_MAX = __ETHTOOL_A_STRSET_CNT - 1
-};
-
-/* LINKINFO */
-
-enum {
-	ETHTOOL_A_LINKINFO_UNSPEC,
-	ETHTOOL_A_LINKINFO_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_LINKINFO_PORT,		/* u8 */
-	ETHTOOL_A_LINKINFO_PHYADDR,		/* u8 */
-	ETHTOOL_A_LINKINFO_TP_MDIX,		/* u8 */
-	ETHTOOL_A_LINKINFO_TP_MDIX_CTRL,	/* u8 */
-	ETHTOOL_A_LINKINFO_TRANSCEIVER,		/* u8 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_LINKINFO_CNT,
-	ETHTOOL_A_LINKINFO_MAX = __ETHTOOL_A_LINKINFO_CNT - 1
-};
-
-/* LINKMODES */
-
-enum {
-	ETHTOOL_A_LINKMODES_UNSPEC,
-	ETHTOOL_A_LINKMODES_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_LINKMODES_AUTONEG,		/* u8 */
-	ETHTOOL_A_LINKMODES_OURS,		/* bitset */
-	ETHTOOL_A_LINKMODES_PEER,		/* bitset */
-	ETHTOOL_A_LINKMODES_SPEED,		/* u32 */
-	ETHTOOL_A_LINKMODES_DUPLEX,		/* u8 */
-	ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG,	/* u8 */
-	ETHTOOL_A_LINKMODES_MASTER_SLAVE_STATE,	/* u8 */
-	ETHTOOL_A_LINKMODES_LANES,		/* u32 */
-	ETHTOOL_A_LINKMODES_RATE_MATCHING,	/* u8 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_LINKMODES_CNT,
-	ETHTOOL_A_LINKMODES_MAX = __ETHTOOL_A_LINKMODES_CNT - 1
-};
-
-/* LINKSTATE */
-
-enum {
-	ETHTOOL_A_LINKSTATE_UNSPEC,
-	ETHTOOL_A_LINKSTATE_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_LINKSTATE_LINK,		/* u8 */
-	ETHTOOL_A_LINKSTATE_SQI,		/* u32 */
-	ETHTOOL_A_LINKSTATE_SQI_MAX,		/* u32 */
-	ETHTOOL_A_LINKSTATE_EXT_STATE,		/* u8 */
-	ETHTOOL_A_LINKSTATE_EXT_SUBSTATE,	/* u8 */
-	ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT,	/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_LINKSTATE_CNT,
-	ETHTOOL_A_LINKSTATE_MAX = __ETHTOOL_A_LINKSTATE_CNT - 1
-};
-
-/* DEBUG */
-
-enum {
-	ETHTOOL_A_DEBUG_UNSPEC,
-	ETHTOOL_A_DEBUG_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_DEBUG_MSGMASK,		/* bitset */
-
-	/* add new constants above here */
-	__ETHTOOL_A_DEBUG_CNT,
-	ETHTOOL_A_DEBUG_MAX = __ETHTOOL_A_DEBUG_CNT - 1
-};
-
-/* WOL */
-
-enum {
-	ETHTOOL_A_WOL_UNSPEC,
-	ETHTOOL_A_WOL_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_WOL_MODES,			/* bitset */
-	ETHTOOL_A_WOL_SOPASS,			/* binary */
-
-	/* add new constants above here */
-	__ETHTOOL_A_WOL_CNT,
-	ETHTOOL_A_WOL_MAX = __ETHTOOL_A_WOL_CNT - 1
-};
-
-/* FEATURES */
-
-enum {
-	ETHTOOL_A_FEATURES_UNSPEC,
-	ETHTOOL_A_FEATURES_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_FEATURES_HW,				/* bitset */
-	ETHTOOL_A_FEATURES_WANTED,			/* bitset */
-	ETHTOOL_A_FEATURES_ACTIVE,			/* bitset */
-	ETHTOOL_A_FEATURES_NOCHANGE,			/* bitset */
-
-	/* add new constants above here */
-	__ETHTOOL_A_FEATURES_CNT,
-	ETHTOOL_A_FEATURES_MAX = __ETHTOOL_A_FEATURES_CNT - 1
-};
-
-/* PRIVFLAGS */
-
-enum {
-	ETHTOOL_A_PRIVFLAGS_UNSPEC,
-	ETHTOOL_A_PRIVFLAGS_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PRIVFLAGS_FLAGS,			/* bitset */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PRIVFLAGS_CNT,
-	ETHTOOL_A_PRIVFLAGS_MAX = __ETHTOOL_A_PRIVFLAGS_CNT - 1
-};
-
-/* RINGS */
-
-enum {
-	ETHTOOL_TCP_DATA_SPLIT_UNKNOWN = 0,
-	ETHTOOL_TCP_DATA_SPLIT_DISABLED,
-	ETHTOOL_TCP_DATA_SPLIT_ENABLED,
-};
-
-enum {
-	ETHTOOL_A_RINGS_UNSPEC,
-	ETHTOOL_A_RINGS_HEADER,				/* nest - _A_HEADER_* */
-	ETHTOOL_A_RINGS_RX_MAX,				/* u32 */
-	ETHTOOL_A_RINGS_RX_MINI_MAX,			/* u32 */
-	ETHTOOL_A_RINGS_RX_JUMBO_MAX,			/* u32 */
-	ETHTOOL_A_RINGS_TX_MAX,				/* u32 */
-	ETHTOOL_A_RINGS_RX,				/* u32 */
-	ETHTOOL_A_RINGS_RX_MINI,			/* u32 */
-	ETHTOOL_A_RINGS_RX_JUMBO,			/* u32 */
-	ETHTOOL_A_RINGS_TX,				/* u32 */
-	ETHTOOL_A_RINGS_RX_BUF_LEN,                     /* u32 */
-	ETHTOOL_A_RINGS_TCP_DATA_SPLIT,			/* u8 */
-	ETHTOOL_A_RINGS_CQE_SIZE,			/* u32 */
-	ETHTOOL_A_RINGS_TX_PUSH,			/* u8 */
-	ETHTOOL_A_RINGS_RX_PUSH,			/* u8 */
-	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,		/* u32 */
-	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_RINGS_CNT,
-	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
-};
-
-/* CHANNELS */
-
-enum {
-	ETHTOOL_A_CHANNELS_UNSPEC,
-	ETHTOOL_A_CHANNELS_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_CHANNELS_RX_MAX,			/* u32 */
-	ETHTOOL_A_CHANNELS_TX_MAX,			/* u32 */
-	ETHTOOL_A_CHANNELS_OTHER_MAX,			/* u32 */
-	ETHTOOL_A_CHANNELS_COMBINED_MAX,		/* u32 */
-	ETHTOOL_A_CHANNELS_RX_COUNT,			/* u32 */
-	ETHTOOL_A_CHANNELS_TX_COUNT,			/* u32 */
-	ETHTOOL_A_CHANNELS_OTHER_COUNT,			/* u32 */
-	ETHTOOL_A_CHANNELS_COMBINED_COUNT,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CHANNELS_CNT,
-	ETHTOOL_A_CHANNELS_MAX = (__ETHTOOL_A_CHANNELS_CNT - 1)
-};
-
-/* COALESCE */
-
-enum {
-	ETHTOOL_A_COALESCE_UNSPEC,
-	ETHTOOL_A_COALESCE_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_COALESCE_RX_USECS,			/* u32 */
-	ETHTOOL_A_COALESCE_RX_MAX_FRAMES,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_USECS_IRQ,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_IRQ,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_USECS,			/* u32 */
-	ETHTOOL_A_COALESCE_TX_MAX_FRAMES,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_USECS_IRQ,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_IRQ,		/* u32 */
-	ETHTOOL_A_COALESCE_STATS_BLOCK_USECS,		/* u32 */
-	ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX,		/* u8 */
-	ETHTOOL_A_COALESCE_USE_ADAPTIVE_TX,		/* u8 */
-	ETHTOOL_A_COALESCE_PKT_RATE_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_USECS_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_USECS_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_PKT_RATE_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_USECS_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_USECS_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_RATE_SAMPLE_INTERVAL,	/* u32 */
-	ETHTOOL_A_COALESCE_USE_CQE_MODE_TX,		/* u8 */
-	ETHTOOL_A_COALESCE_USE_CQE_MODE_RX,		/* u8 */
-	ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,		/* u32 */
-	/* nest - _A_PROFILE_IRQ_MODERATION */
-	ETHTOOL_A_COALESCE_RX_PROFILE,
-	/* nest - _A_PROFILE_IRQ_MODERATION */
-	ETHTOOL_A_COALESCE_TX_PROFILE,
-
-	/* add new constants above here */
-	__ETHTOOL_A_COALESCE_CNT,
-	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_PROFILE_UNSPEC,
-	/* nest, _A_IRQ_MODERATION_* */
-	ETHTOOL_A_PROFILE_IRQ_MODERATION,
-	__ETHTOOL_A_PROFILE_CNT,
-	ETHTOOL_A_PROFILE_MAX = (__ETHTOOL_A_PROFILE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_IRQ_MODERATION_UNSPEC,
-	ETHTOOL_A_IRQ_MODERATION_USEC,			/* u32 */
-	ETHTOOL_A_IRQ_MODERATION_PKTS,			/* u32 */
-	ETHTOOL_A_IRQ_MODERATION_COMPS,			/* u32 */
-
-	__ETHTOOL_A_IRQ_MODERATION_CNT,
-	ETHTOOL_A_IRQ_MODERATION_MAX = (__ETHTOOL_A_IRQ_MODERATION_CNT - 1)
-};
-
-/* PAUSE */
-
-enum {
-	ETHTOOL_A_PAUSE_UNSPEC,
-	ETHTOOL_A_PAUSE_HEADER,				/* nest - _A_HEADER_* */
-	ETHTOOL_A_PAUSE_AUTONEG,			/* u8 */
-	ETHTOOL_A_PAUSE_RX,				/* u8 */
-	ETHTOOL_A_PAUSE_TX,				/* u8 */
-	ETHTOOL_A_PAUSE_STATS,				/* nest - _PAUSE_STAT_* */
-	ETHTOOL_A_PAUSE_STATS_SRC,			/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PAUSE_CNT,
-	ETHTOOL_A_PAUSE_MAX = (__ETHTOOL_A_PAUSE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_PAUSE_STAT_UNSPEC,
-	ETHTOOL_A_PAUSE_STAT_PAD,
-
-	ETHTOOL_A_PAUSE_STAT_TX_FRAMES,
-	ETHTOOL_A_PAUSE_STAT_RX_FRAMES,
-
-	/* add new constants above here
-	 * adjust ETHTOOL_PAUSE_STAT_CNT if adding non-stats!
-	 */
-	__ETHTOOL_A_PAUSE_STAT_CNT,
-	ETHTOOL_A_PAUSE_STAT_MAX = (__ETHTOOL_A_PAUSE_STAT_CNT - 1)
-};
-
-/* EEE */
-
-enum {
-	ETHTOOL_A_EEE_UNSPEC,
-	ETHTOOL_A_EEE_HEADER,				/* nest - _A_HEADER_* */
-	ETHTOOL_A_EEE_MODES_OURS,			/* bitset */
-	ETHTOOL_A_EEE_MODES_PEER,			/* bitset */
-	ETHTOOL_A_EEE_ACTIVE,				/* u8 */
-	ETHTOOL_A_EEE_ENABLED,				/* u8 */
-	ETHTOOL_A_EEE_TX_LPI_ENABLED,			/* u8 */
-	ETHTOOL_A_EEE_TX_LPI_TIMER,			/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_EEE_CNT,
-	ETHTOOL_A_EEE_MAX = (__ETHTOOL_A_EEE_CNT - 1)
-};
-
-/* TSINFO */
-
-enum {
-	ETHTOOL_A_TSINFO_UNSPEC,
-	ETHTOOL_A_TSINFO_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_TSINFO_TIMESTAMPING,			/* bitset */
-	ETHTOOL_A_TSINFO_TX_TYPES,			/* bitset */
-	ETHTOOL_A_TSINFO_RX_FILTERS,			/* bitset */
-	ETHTOOL_A_TSINFO_PHC_INDEX,			/* u32 */
-	ETHTOOL_A_TSINFO_STATS,				/* nest - _A_TSINFO_STAT */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TSINFO_CNT,
-	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_TS_STAT_UNSPEC,
-
-	ETHTOOL_A_TS_STAT_TX_PKTS,			/* uint */
-	ETHTOOL_A_TS_STAT_TX_LOST,			/* uint */
-	ETHTOOL_A_TS_STAT_TX_ERR,			/* uint */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TS_STAT_CNT,
-	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
-
-};
-
-/* PHC VCLOCKS */
-
-enum {
-	ETHTOOL_A_PHC_VCLOCKS_UNSPEC,
-	ETHTOOL_A_PHC_VCLOCKS_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PHC_VCLOCKS_NUM,			/* u32 */
-	ETHTOOL_A_PHC_VCLOCKS_INDEX,			/* array, s32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PHC_VCLOCKS_CNT,
-	ETHTOOL_A_PHC_VCLOCKS_MAX = (__ETHTOOL_A_PHC_VCLOCKS_CNT - 1)
-};
-
-/* CABLE TEST */
-
-enum {
-	ETHTOOL_A_CABLE_TEST_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_HEADER,		/* nest - _A_HEADER_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CABLE_TEST_CNT,
-	ETHTOOL_A_CABLE_TEST_MAX = __ETHTOOL_A_CABLE_TEST_CNT - 1
-};
-
 /* CABLE TEST NOTIFY */
 enum {
 	ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC,
@@ -582,74 +49,12 @@ enum {
 	ETHTOOL_A_CABLE_INF_SRC_ALCD,
 };
 
-enum {
-	ETHTOOL_A_CABLE_RESULT_UNSPEC,
-	ETHTOOL_A_CABLE_RESULT_PAIR,		/* u8 ETHTOOL_A_CABLE_PAIR_ */
-	ETHTOOL_A_CABLE_RESULT_CODE,		/* u8 ETHTOOL_A_CABLE_RESULT_CODE_ */
-	ETHTOOL_A_CABLE_RESULT_SRC,		/* u32 ETHTOOL_A_CABLE_INF_SRC_ */
-
-	__ETHTOOL_A_CABLE_RESULT_CNT,
-	ETHTOOL_A_CABLE_RESULT_MAX = (__ETHTOOL_A_CABLE_RESULT_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC,
-	ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR,	/* u8 ETHTOOL_A_CABLE_PAIR_ */
-	ETHTOOL_A_CABLE_FAULT_LENGTH_CM,	/* u32 */
-	ETHTOOL_A_CABLE_FAULT_LENGTH_SRC,	/* u32 ETHTOOL_A_CABLE_INF_SRC_ */
-
-	__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT,
-	ETHTOOL_A_CABLE_FAULT_LENGTH_MAX = (__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT - 1)
-};
-
 enum {
 	ETHTOOL_A_CABLE_TEST_NTF_STATUS_UNSPEC,
 	ETHTOOL_A_CABLE_TEST_NTF_STATUS_STARTED,
 	ETHTOOL_A_CABLE_TEST_NTF_STATUS_COMPLETED
 };
 
-enum {
-	ETHTOOL_A_CABLE_NEST_UNSPEC,
-	ETHTOOL_A_CABLE_NEST_RESULT,		/* nest - ETHTOOL_A_CABLE_RESULT_ */
-	ETHTOOL_A_CABLE_NEST_FAULT_LENGTH,	/* nest - ETHTOOL_A_CABLE_FAULT_LENGTH_ */
-	__ETHTOOL_A_CABLE_NEST_CNT,
-	ETHTOOL_A_CABLE_NEST_MAX = (__ETHTOOL_A_CABLE_NEST_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_CABLE_TEST_NTF_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_NTF_HEADER,	/* nest - ETHTOOL_A_HEADER_* */
-	ETHTOOL_A_CABLE_TEST_NTF_STATUS,	/* u8 - _STARTED/_COMPLETE */
-	ETHTOOL_A_CABLE_TEST_NTF_NEST,		/* nest - of results: */
-
-	__ETHTOOL_A_CABLE_TEST_NTF_CNT,
-	ETHTOOL_A_CABLE_TEST_NTF_MAX = (__ETHTOOL_A_CABLE_TEST_NTF_CNT - 1)
-};
-
-/* CABLE TEST TDR */
-
-enum {
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_FIRST,		/* u32 */
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_LAST,		/* u32 */
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_STEP,		/* u32 */
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_PAIR,		/* u8 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT,
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_MAX = __ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_CABLE_TEST_TDR_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_TDR_HEADER,	/* nest - _A_HEADER_* */
-	ETHTOOL_A_CABLE_TEST_TDR_CFG,		/* nest - *_TDR_CFG_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CABLE_TEST_TDR_CNT,
-	ETHTOOL_A_CABLE_TEST_TDR_MAX = __ETHTOOL_A_CABLE_TEST_TDR_CNT - 1
-};
-
 /* CABLE TEST TDR NOTIFY */
 
 enum {
@@ -689,163 +94,17 @@ enum {
 	ETHTOOL_A_CABLE_TDR_NEST_MAX = (__ETHTOOL_A_CABLE_TDR_NEST_CNT - 1)
 };
 
-enum {
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_HEADER,	/* nest - ETHTOOL_A_HEADER_* */
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_STATUS,	/* u8 - _STARTED/_COMPLETE */
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_NEST,	/* nest - of results: */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT,
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_MAX = __ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT - 1
-};
-
-/* TUNNEL INFO */
-
-enum {
-	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN,
-	ETHTOOL_UDP_TUNNEL_TYPE_GENEVE,
-	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN_GPE,
-
-	__ETHTOOL_UDP_TUNNEL_TYPE_CNT
-};
-
-enum {
-	ETHTOOL_A_TUNNEL_UDP_ENTRY_UNSPEC,
-
-	ETHTOOL_A_TUNNEL_UDP_ENTRY_PORT,		/* be16 */
-	ETHTOOL_A_TUNNEL_UDP_ENTRY_TYPE,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TUNNEL_UDP_ENTRY_CNT,
-	ETHTOOL_A_TUNNEL_UDP_ENTRY_MAX = (__ETHTOOL_A_TUNNEL_UDP_ENTRY_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_TUNNEL_UDP_TABLE_UNSPEC,
-
-	ETHTOOL_A_TUNNEL_UDP_TABLE_SIZE,		/* u32 */
-	ETHTOOL_A_TUNNEL_UDP_TABLE_TYPES,		/* bitset */
-	ETHTOOL_A_TUNNEL_UDP_TABLE_ENTRY,		/* nest - _UDP_ENTRY_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TUNNEL_UDP_TABLE_CNT,
-	ETHTOOL_A_TUNNEL_UDP_TABLE_MAX = (__ETHTOOL_A_TUNNEL_UDP_TABLE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_TUNNEL_UDP_UNSPEC,
-
-	ETHTOOL_A_TUNNEL_UDP_TABLE,			/* nest - _UDP_TABLE_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TUNNEL_UDP_CNT,
-	ETHTOOL_A_TUNNEL_UDP_MAX = (__ETHTOOL_A_TUNNEL_UDP_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_TUNNEL_INFO_UNSPEC,
-	ETHTOOL_A_TUNNEL_INFO_HEADER,			/* nest - _A_HEADER_* */
-
-	ETHTOOL_A_TUNNEL_INFO_UDP_PORTS,		/* nest - _UDP_TABLE */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TUNNEL_INFO_CNT,
-	ETHTOOL_A_TUNNEL_INFO_MAX = (__ETHTOOL_A_TUNNEL_INFO_CNT - 1)
-};
-
-/* FEC */
-
-enum {
-	ETHTOOL_A_FEC_UNSPEC,
-	ETHTOOL_A_FEC_HEADER,				/* nest - _A_HEADER_* */
-	ETHTOOL_A_FEC_MODES,				/* bitset */
-	ETHTOOL_A_FEC_AUTO,				/* u8 */
-	ETHTOOL_A_FEC_ACTIVE,				/* u32 */
-	ETHTOOL_A_FEC_STATS,				/* nest - _A_FEC_STAT */
-
-	__ETHTOOL_A_FEC_CNT,
-	ETHTOOL_A_FEC_MAX = (__ETHTOOL_A_FEC_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_FEC_STAT_UNSPEC,
-	ETHTOOL_A_FEC_STAT_PAD,
-
-	ETHTOOL_A_FEC_STAT_CORRECTED,			/* array, u64 */
-	ETHTOOL_A_FEC_STAT_UNCORR,			/* array, u64 */
-	ETHTOOL_A_FEC_STAT_CORR_BITS,			/* array, u64 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_FEC_STAT_CNT,
-	ETHTOOL_A_FEC_STAT_MAX = (__ETHTOOL_A_FEC_STAT_CNT - 1)
-};
-
-/* MODULE EEPROM */
-
-enum {
-	ETHTOOL_A_MODULE_EEPROM_UNSPEC,
-	ETHTOOL_A_MODULE_EEPROM_HEADER,			/* nest - _A_HEADER_* */
-
-	ETHTOOL_A_MODULE_EEPROM_OFFSET,			/* u32 */
-	ETHTOOL_A_MODULE_EEPROM_LENGTH,			/* u32 */
-	ETHTOOL_A_MODULE_EEPROM_PAGE,			/* u8 */
-	ETHTOOL_A_MODULE_EEPROM_BANK,			/* u8 */
-	ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS,		/* u8 */
-	ETHTOOL_A_MODULE_EEPROM_DATA,			/* binary */
-
-	__ETHTOOL_A_MODULE_EEPROM_CNT,
-	ETHTOOL_A_MODULE_EEPROM_MAX = (__ETHTOOL_A_MODULE_EEPROM_CNT - 1)
-};
-
-/* STATS */
-
-enum {
-	ETHTOOL_A_STATS_UNSPEC,
-	ETHTOOL_A_STATS_PAD,
-	ETHTOOL_A_STATS_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_STATS_GROUPS,			/* bitset */
-
-	ETHTOOL_A_STATS_GRP,			/* nest - _A_STATS_GRP_* */
-
-	ETHTOOL_A_STATS_SRC,			/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STATS_CNT,
-	ETHTOOL_A_STATS_MAX = (__ETHTOOL_A_STATS_CNT - 1)
-};
-
 enum {
 	ETHTOOL_STATS_ETH_PHY,
 	ETHTOOL_STATS_ETH_MAC,
 	ETHTOOL_STATS_ETH_CTRL,
 	ETHTOOL_STATS_RMON,
+	ETHTOOL_STATS_PHY,
 
 	/* add new constants above here */
 	__ETHTOOL_STATS_CNT
 };
 
-enum {
-	ETHTOOL_A_STATS_GRP_UNSPEC,
-	ETHTOOL_A_STATS_GRP_PAD,
-
-	ETHTOOL_A_STATS_GRP_ID,			/* u32 */
-	ETHTOOL_A_STATS_GRP_SS_ID,		/* u32 */
-
-	ETHTOOL_A_STATS_GRP_STAT,		/* nest */
-
-	ETHTOOL_A_STATS_GRP_HIST_RX,		/* nest */
-	ETHTOOL_A_STATS_GRP_HIST_TX,		/* nest */
-
-	ETHTOOL_A_STATS_GRP_HIST_BKT_LOW,	/* u32 */
-	ETHTOOL_A_STATS_GRP_HIST_BKT_HI,	/* u32 */
-	ETHTOOL_A_STATS_GRP_HIST_VAL,		/* u64 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STATS_GRP_CNT,
-	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_GRP_CNT - 1)
-};
-
 enum {
 	/* 30.3.2.1.5 aSymbolErrorDuringCarrier */
 	ETHTOOL_A_STATS_ETH_PHY_5_SYM_ERR,
@@ -935,154 +194,18 @@ enum {
 	ETHTOOL_A_STATS_RMON_MAX = (__ETHTOOL_A_STATS_RMON_CNT - 1)
 };
 
-/* MODULE */
-
-enum {
-	ETHTOOL_A_MODULE_UNSPEC,
-	ETHTOOL_A_MODULE_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_MODULE_POWER_MODE_POLICY,	/* u8 */
-	ETHTOOL_A_MODULE_POWER_MODE,		/* u8 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_MODULE_CNT,
-	ETHTOOL_A_MODULE_MAX = (__ETHTOOL_A_MODULE_CNT - 1)
-};
-
-/* Power Sourcing Equipment */
-enum {
-	ETHTOOL_A_C33_PSE_PW_LIMIT_UNSPEC,
-	ETHTOOL_A_C33_PSE_PW_LIMIT_MIN,	/* u32 */
-	ETHTOOL_A_C33_PSE_PW_LIMIT_MAX,	/* u32 */
-};
-
-enum {
-	ETHTOOL_A_PSE_UNSPEC,
-	ETHTOOL_A_PSE_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PODL_PSE_ADMIN_STATE,		/* u32 */
-	ETHTOOL_A_PODL_PSE_ADMIN_CONTROL,	/* u32 */
-	ETHTOOL_A_PODL_PSE_PW_D_STATUS,		/* u32 */
-	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
-	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
-	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
-	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
-	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
-	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u32 */
-	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u32 */
-	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,	/* u32 */
-	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,	/* nest - _C33_PSE_PW_LIMIT_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PSE_CNT,
-	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_RSS_UNSPEC,
-	ETHTOOL_A_RSS_HEADER,
-	ETHTOOL_A_RSS_CONTEXT,		/* u32 */
-	ETHTOOL_A_RSS_HFUNC,		/* u32 */
-	ETHTOOL_A_RSS_INDIR,		/* binary */
-	ETHTOOL_A_RSS_HKEY,		/* binary */
-	ETHTOOL_A_RSS_INPUT_XFRM,	/* u32 */
-	ETHTOOL_A_RSS_START_CONTEXT,	/* u32 */
-
-	__ETHTOOL_A_RSS_CNT,
-	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1),
-};
-
-/* PLCA */
-
-enum {
-	ETHTOOL_A_PLCA_UNSPEC,
-	ETHTOOL_A_PLCA_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PLCA_VERSION,			/* u16 */
-	ETHTOOL_A_PLCA_ENABLED,			/* u8  */
-	ETHTOOL_A_PLCA_STATUS,			/* u8  */
-	ETHTOOL_A_PLCA_NODE_CNT,		/* u32 */
-	ETHTOOL_A_PLCA_NODE_ID,			/* u32 */
-	ETHTOOL_A_PLCA_TO_TMR,			/* u32 */
-	ETHTOOL_A_PLCA_BURST_CNT,		/* u32 */
-	ETHTOOL_A_PLCA_BURST_TMR,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PLCA_CNT,
-	ETHTOOL_A_PLCA_MAX = (__ETHTOOL_A_PLCA_CNT - 1)
-};
-
-/* MAC Merge (802.3) */
-
-enum {
-	ETHTOOL_A_MM_STAT_UNSPEC,
-	ETHTOOL_A_MM_STAT_PAD,
-
-	/* aMACMergeFrameAssErrorCount */
-	ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS,	/* u64 */
-	/* aMACMergeFrameSmdErrorCount */
-	ETHTOOL_A_MM_STAT_SMD_ERRORS,		/* u64 */
-	/* aMACMergeFrameAssOkCount */
-	ETHTOOL_A_MM_STAT_REASSEMBLY_OK,	/* u64 */
-	/* aMACMergeFragCountRx */
-	ETHTOOL_A_MM_STAT_RX_FRAG_COUNT,	/* u64 */
-	/* aMACMergeFragCountTx */
-	ETHTOOL_A_MM_STAT_TX_FRAG_COUNT,	/* u64 */
-	/* aMACMergeHoldCount */
-	ETHTOOL_A_MM_STAT_HOLD_COUNT,		/* u64 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_MM_STAT_CNT,
-	ETHTOOL_A_MM_STAT_MAX = (__ETHTOOL_A_MM_STAT_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_MM_UNSPEC,
-	ETHTOOL_A_MM_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_MM_PMAC_ENABLED,		/* u8 */
-	ETHTOOL_A_MM_TX_ENABLED,		/* u8 */
-	ETHTOOL_A_MM_TX_ACTIVE,			/* u8 */
-	ETHTOOL_A_MM_TX_MIN_FRAG_SIZE,		/* u32 */
-	ETHTOOL_A_MM_RX_MIN_FRAG_SIZE,		/* u32 */
-	ETHTOOL_A_MM_VERIFY_ENABLED,		/* u8 */
-	ETHTOOL_A_MM_VERIFY_STATUS,		/* u8 */
-	ETHTOOL_A_MM_VERIFY_TIME,		/* u32 */
-	ETHTOOL_A_MM_MAX_VERIFY_TIME,		/* u32 */
-	ETHTOOL_A_MM_STATS,			/* nest - _A_MM_STAT_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_MM_CNT,
-	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
-};
-
-/* MODULE_FW_FLASH */
-
-enum {
-	ETHTOOL_A_MODULE_FW_FLASH_UNSPEC,
-	ETHTOOL_A_MODULE_FW_FLASH_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,		/* string */
-	ETHTOOL_A_MODULE_FW_FLASH_PASSWORD,		/* u32 */
-	ETHTOOL_A_MODULE_FW_FLASH_STATUS,		/* u32 */
-	ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,		/* string */
-	ETHTOOL_A_MODULE_FW_FLASH_DONE,			/* uint */
-	ETHTOOL_A_MODULE_FW_FLASH_TOTAL,		/* uint */
-
-	/* add new constants above here */
-	__ETHTOOL_A_MODULE_FW_FLASH_CNT,
-	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
-};
-
 enum {
-	ETHTOOL_A_PHY_UNSPEC,
-	ETHTOOL_A_PHY_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PHY_INDEX,			/* u32 */
-	ETHTOOL_A_PHY_DRVNAME,			/* string */
-	ETHTOOL_A_PHY_NAME,			/* string */
-	ETHTOOL_A_PHY_UPSTREAM_TYPE,		/* u32 */
-	ETHTOOL_A_PHY_UPSTREAM_INDEX,		/* u32 */
-	ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,	/* string */
-	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,	/* string */
+	/* Basic packet counters if PHY has separate counters from the MAC */
+	ETHTOOL_A_STATS_PHY_RX_PKTS,
+	ETHTOOL_A_STATS_PHY_RX_BYTES,
+	ETHTOOL_A_STATS_PHY_RX_ERRORS,
+	ETHTOOL_A_STATS_PHY_TX_PKTS,
+	ETHTOOL_A_STATS_PHY_TX_BYTES,
+	ETHTOOL_A_STATS_PHY_TX_ERRORS,
 
 	/* add new constants above here */
-	__ETHTOOL_A_PHY_CNT,
-	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
+	__ETHTOOL_A_STATS_PHY_CNT,
+	ETHTOOL_A_STATS_PHY_MAX = (__ETHTOOL_A_STATS_PHY_CNT - 1)
 };
 
 /* generic netlink info */
diff --git a/uapi/linux/ethtool_netlink_generated.h b/uapi/linux/ethtool_netlink_generated.h
new file mode 100644
index 0000000000000000000000000000000000000000..fa0522b1e9089f2d71e1199af9c5c41f688f254c
--- /dev/null
+++ b/uapi/linux/ethtool_netlink_generated.h
@@ -0,0 +1,821 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ethtool.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _LINUX_ETHTOOL_NETLINK_GENERATED_H
+#define _LINUX_ETHTOOL_NETLINK_GENERATED_H
+
+#define ETHTOOL_FAMILY_NAME	"ethtool"
+#define ETHTOOL_FAMILY_VERSION	1
+
+enum {
+	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN,
+	ETHTOOL_UDP_TUNNEL_TYPE_GENEVE,
+	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN_GPE,
+
+	/* private: */
+	__ETHTOOL_UDP_TUNNEL_TYPE_CNT,
+	ETHTOOL_UDP_TUNNEL_TYPE_MAX = (__ETHTOOL_UDP_TUNNEL_TYPE_CNT - 1)
+};
+
+/**
+ * enum ethtool_header_flags - common ethtool header flags
+ * @ETHTOOL_FLAG_COMPACT_BITSETS: use compact bitsets in reply
+ * @ETHTOOL_FLAG_OMIT_REPLY: provide optional reply for SET or ACT requests
+ * @ETHTOOL_FLAG_STATS: request statistics, if supported by the driver
+ */
+enum ethtool_header_flags {
+	ETHTOOL_FLAG_COMPACT_BITSETS = 1,
+	ETHTOOL_FLAG_OMIT_REPLY = 2,
+	ETHTOOL_FLAG_STATS = 4,
+};
+
+enum {
+	ETHTOOL_PHY_UPSTREAM_TYPE_MAC,
+	ETHTOOL_PHY_UPSTREAM_TYPE_PHY,
+};
+
+enum ethtool_tcp_data_split {
+	ETHTOOL_TCP_DATA_SPLIT_UNKNOWN,
+	ETHTOOL_TCP_DATA_SPLIT_DISABLED,
+	ETHTOOL_TCP_DATA_SPLIT_ENABLED,
+};
+
+enum {
+	ETHTOOL_A_HEADER_UNSPEC,
+	ETHTOOL_A_HEADER_DEV_INDEX,
+	ETHTOOL_A_HEADER_DEV_NAME,
+	ETHTOOL_A_HEADER_FLAGS,
+	ETHTOOL_A_HEADER_PHY_INDEX,
+
+	__ETHTOOL_A_HEADER_CNT,
+	ETHTOOL_A_HEADER_MAX = (__ETHTOOL_A_HEADER_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_BITSET_BIT_UNSPEC,
+	ETHTOOL_A_BITSET_BIT_INDEX,
+	ETHTOOL_A_BITSET_BIT_NAME,
+	ETHTOOL_A_BITSET_BIT_VALUE,
+
+	__ETHTOOL_A_BITSET_BIT_CNT,
+	ETHTOOL_A_BITSET_BIT_MAX = (__ETHTOOL_A_BITSET_BIT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_BITSET_BITS_UNSPEC,
+	ETHTOOL_A_BITSET_BITS_BIT,
+
+	__ETHTOOL_A_BITSET_BITS_CNT,
+	ETHTOOL_A_BITSET_BITS_MAX = (__ETHTOOL_A_BITSET_BITS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_BITSET_UNSPEC,
+	ETHTOOL_A_BITSET_NOMASK,
+	ETHTOOL_A_BITSET_SIZE,
+	ETHTOOL_A_BITSET_BITS,
+	ETHTOOL_A_BITSET_VALUE,
+	ETHTOOL_A_BITSET_MASK,
+
+	__ETHTOOL_A_BITSET_CNT,
+	ETHTOOL_A_BITSET_MAX = (__ETHTOOL_A_BITSET_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_STRING_UNSPEC,
+	ETHTOOL_A_STRING_INDEX,
+	ETHTOOL_A_STRING_VALUE,
+
+	__ETHTOOL_A_STRING_CNT,
+	ETHTOOL_A_STRING_MAX = (__ETHTOOL_A_STRING_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_STRINGS_UNSPEC,
+	ETHTOOL_A_STRINGS_STRING,
+
+	__ETHTOOL_A_STRINGS_CNT,
+	ETHTOOL_A_STRINGS_MAX = (__ETHTOOL_A_STRINGS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_STRINGSET_UNSPEC,
+	ETHTOOL_A_STRINGSET_ID,
+	ETHTOOL_A_STRINGSET_COUNT,
+	ETHTOOL_A_STRINGSET_STRINGS,
+
+	__ETHTOOL_A_STRINGSET_CNT,
+	ETHTOOL_A_STRINGSET_MAX = (__ETHTOOL_A_STRINGSET_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_STRINGSETS_UNSPEC,
+	ETHTOOL_A_STRINGSETS_STRINGSET,
+
+	__ETHTOOL_A_STRINGSETS_CNT,
+	ETHTOOL_A_STRINGSETS_MAX = (__ETHTOOL_A_STRINGSETS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_STRSET_UNSPEC,
+	ETHTOOL_A_STRSET_HEADER,
+	ETHTOOL_A_STRSET_STRINGSETS,
+	ETHTOOL_A_STRSET_COUNTS_ONLY,
+
+	__ETHTOOL_A_STRSET_CNT,
+	ETHTOOL_A_STRSET_MAX = (__ETHTOOL_A_STRSET_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PRIVFLAGS_UNSPEC,
+	ETHTOOL_A_PRIVFLAGS_HEADER,
+	ETHTOOL_A_PRIVFLAGS_FLAGS,
+
+	__ETHTOOL_A_PRIVFLAGS_CNT,
+	ETHTOOL_A_PRIVFLAGS_MAX = (__ETHTOOL_A_PRIVFLAGS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_RINGS_UNSPEC,
+	ETHTOOL_A_RINGS_HEADER,
+	ETHTOOL_A_RINGS_RX_MAX,
+	ETHTOOL_A_RINGS_RX_MINI_MAX,
+	ETHTOOL_A_RINGS_RX_JUMBO_MAX,
+	ETHTOOL_A_RINGS_TX_MAX,
+	ETHTOOL_A_RINGS_RX,
+	ETHTOOL_A_RINGS_RX_MINI,
+	ETHTOOL_A_RINGS_RX_JUMBO,
+	ETHTOOL_A_RINGS_TX,
+	ETHTOOL_A_RINGS_RX_BUF_LEN,
+	ETHTOOL_A_RINGS_TCP_DATA_SPLIT,
+	ETHTOOL_A_RINGS_CQE_SIZE,
+	ETHTOOL_A_RINGS_TX_PUSH,
+	ETHTOOL_A_RINGS_RX_PUSH,
+	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
+	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
+	ETHTOOL_A_RINGS_HDS_THRESH,
+	ETHTOOL_A_RINGS_HDS_THRESH_MAX,
+
+	__ETHTOOL_A_RINGS_CNT,
+	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MM_STAT_UNSPEC,
+	ETHTOOL_A_MM_STAT_PAD,
+	ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS,
+	ETHTOOL_A_MM_STAT_SMD_ERRORS,
+	ETHTOOL_A_MM_STAT_REASSEMBLY_OK,
+	ETHTOOL_A_MM_STAT_RX_FRAG_COUNT,
+	ETHTOOL_A_MM_STAT_TX_FRAG_COUNT,
+	ETHTOOL_A_MM_STAT_HOLD_COUNT,
+
+	__ETHTOOL_A_MM_STAT_CNT,
+	ETHTOOL_A_MM_STAT_MAX = (__ETHTOOL_A_MM_STAT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MM_UNSPEC,
+	ETHTOOL_A_MM_HEADER,
+	ETHTOOL_A_MM_PMAC_ENABLED,
+	ETHTOOL_A_MM_TX_ENABLED,
+	ETHTOOL_A_MM_TX_ACTIVE,
+	ETHTOOL_A_MM_TX_MIN_FRAG_SIZE,
+	ETHTOOL_A_MM_RX_MIN_FRAG_SIZE,
+	ETHTOOL_A_MM_VERIFY_ENABLED,
+	ETHTOOL_A_MM_VERIFY_STATUS,
+	ETHTOOL_A_MM_VERIFY_TIME,
+	ETHTOOL_A_MM_MAX_VERIFY_TIME,
+	ETHTOOL_A_MM_STATS,
+
+	__ETHTOOL_A_MM_CNT,
+	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_LINKINFO_UNSPEC,
+	ETHTOOL_A_LINKINFO_HEADER,
+	ETHTOOL_A_LINKINFO_PORT,
+	ETHTOOL_A_LINKINFO_PHYADDR,
+	ETHTOOL_A_LINKINFO_TP_MDIX,
+	ETHTOOL_A_LINKINFO_TP_MDIX_CTRL,
+	ETHTOOL_A_LINKINFO_TRANSCEIVER,
+
+	__ETHTOOL_A_LINKINFO_CNT,
+	ETHTOOL_A_LINKINFO_MAX = (__ETHTOOL_A_LINKINFO_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_LINKMODES_UNSPEC,
+	ETHTOOL_A_LINKMODES_HEADER,
+	ETHTOOL_A_LINKMODES_AUTONEG,
+	ETHTOOL_A_LINKMODES_OURS,
+	ETHTOOL_A_LINKMODES_PEER,
+	ETHTOOL_A_LINKMODES_SPEED,
+	ETHTOOL_A_LINKMODES_DUPLEX,
+	ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG,
+	ETHTOOL_A_LINKMODES_MASTER_SLAVE_STATE,
+	ETHTOOL_A_LINKMODES_LANES,
+	ETHTOOL_A_LINKMODES_RATE_MATCHING,
+
+	__ETHTOOL_A_LINKMODES_CNT,
+	ETHTOOL_A_LINKMODES_MAX = (__ETHTOOL_A_LINKMODES_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_LINKSTATE_UNSPEC,
+	ETHTOOL_A_LINKSTATE_HEADER,
+	ETHTOOL_A_LINKSTATE_LINK,
+	ETHTOOL_A_LINKSTATE_SQI,
+	ETHTOOL_A_LINKSTATE_SQI_MAX,
+	ETHTOOL_A_LINKSTATE_EXT_STATE,
+	ETHTOOL_A_LINKSTATE_EXT_SUBSTATE,
+	ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT,
+
+	__ETHTOOL_A_LINKSTATE_CNT,
+	ETHTOOL_A_LINKSTATE_MAX = (__ETHTOOL_A_LINKSTATE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_DEBUG_UNSPEC,
+	ETHTOOL_A_DEBUG_HEADER,
+	ETHTOOL_A_DEBUG_MSGMASK,
+
+	__ETHTOOL_A_DEBUG_CNT,
+	ETHTOOL_A_DEBUG_MAX = (__ETHTOOL_A_DEBUG_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_WOL_UNSPEC,
+	ETHTOOL_A_WOL_HEADER,
+	ETHTOOL_A_WOL_MODES,
+	ETHTOOL_A_WOL_SOPASS,
+
+	__ETHTOOL_A_WOL_CNT,
+	ETHTOOL_A_WOL_MAX = (__ETHTOOL_A_WOL_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_FEATURES_UNSPEC,
+	ETHTOOL_A_FEATURES_HEADER,
+	ETHTOOL_A_FEATURES_HW,
+	ETHTOOL_A_FEATURES_WANTED,
+	ETHTOOL_A_FEATURES_ACTIVE,
+	ETHTOOL_A_FEATURES_NOCHANGE,
+
+	__ETHTOOL_A_FEATURES_CNT,
+	ETHTOOL_A_FEATURES_MAX = (__ETHTOOL_A_FEATURES_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CHANNELS_UNSPEC,
+	ETHTOOL_A_CHANNELS_HEADER,
+	ETHTOOL_A_CHANNELS_RX_MAX,
+	ETHTOOL_A_CHANNELS_TX_MAX,
+	ETHTOOL_A_CHANNELS_OTHER_MAX,
+	ETHTOOL_A_CHANNELS_COMBINED_MAX,
+	ETHTOOL_A_CHANNELS_RX_COUNT,
+	ETHTOOL_A_CHANNELS_TX_COUNT,
+	ETHTOOL_A_CHANNELS_OTHER_COUNT,
+	ETHTOOL_A_CHANNELS_COMBINED_COUNT,
+
+	__ETHTOOL_A_CHANNELS_CNT,
+	ETHTOOL_A_CHANNELS_MAX = (__ETHTOOL_A_CHANNELS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_IRQ_MODERATION_UNSPEC,
+	ETHTOOL_A_IRQ_MODERATION_USEC,
+	ETHTOOL_A_IRQ_MODERATION_PKTS,
+	ETHTOOL_A_IRQ_MODERATION_COMPS,
+
+	__ETHTOOL_A_IRQ_MODERATION_CNT,
+	ETHTOOL_A_IRQ_MODERATION_MAX = (__ETHTOOL_A_IRQ_MODERATION_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PROFILE_UNSPEC,
+	ETHTOOL_A_PROFILE_IRQ_MODERATION,
+
+	__ETHTOOL_A_PROFILE_CNT,
+	ETHTOOL_A_PROFILE_MAX = (__ETHTOOL_A_PROFILE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_COALESCE_UNSPEC,
+	ETHTOOL_A_COALESCE_HEADER,
+	ETHTOOL_A_COALESCE_RX_USECS,
+	ETHTOOL_A_COALESCE_RX_MAX_FRAMES,
+	ETHTOOL_A_COALESCE_RX_USECS_IRQ,
+	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_IRQ,
+	ETHTOOL_A_COALESCE_TX_USECS,
+	ETHTOOL_A_COALESCE_TX_MAX_FRAMES,
+	ETHTOOL_A_COALESCE_TX_USECS_IRQ,
+	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_IRQ,
+	ETHTOOL_A_COALESCE_STATS_BLOCK_USECS,
+	ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX,
+	ETHTOOL_A_COALESCE_USE_ADAPTIVE_TX,
+	ETHTOOL_A_COALESCE_PKT_RATE_LOW,
+	ETHTOOL_A_COALESCE_RX_USECS_LOW,
+	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_LOW,
+	ETHTOOL_A_COALESCE_TX_USECS_LOW,
+	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_LOW,
+	ETHTOOL_A_COALESCE_PKT_RATE_HIGH,
+	ETHTOOL_A_COALESCE_RX_USECS_HIGH,
+	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_HIGH,
+	ETHTOOL_A_COALESCE_TX_USECS_HIGH,
+	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_HIGH,
+	ETHTOOL_A_COALESCE_RATE_SAMPLE_INTERVAL,
+	ETHTOOL_A_COALESCE_USE_CQE_MODE_TX,
+	ETHTOOL_A_COALESCE_USE_CQE_MODE_RX,
+	ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES,
+	ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,
+	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,
+	ETHTOOL_A_COALESCE_RX_PROFILE,
+	ETHTOOL_A_COALESCE_TX_PROFILE,
+
+	__ETHTOOL_A_COALESCE_CNT,
+	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PAUSE_STAT_UNSPEC,
+	ETHTOOL_A_PAUSE_STAT_PAD,
+	ETHTOOL_A_PAUSE_STAT_TX_FRAMES,
+	ETHTOOL_A_PAUSE_STAT_RX_FRAMES,
+
+	__ETHTOOL_A_PAUSE_STAT_CNT,
+	ETHTOOL_A_PAUSE_STAT_MAX = (__ETHTOOL_A_PAUSE_STAT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PAUSE_UNSPEC,
+	ETHTOOL_A_PAUSE_HEADER,
+	ETHTOOL_A_PAUSE_AUTONEG,
+	ETHTOOL_A_PAUSE_RX,
+	ETHTOOL_A_PAUSE_TX,
+	ETHTOOL_A_PAUSE_STATS,
+	ETHTOOL_A_PAUSE_STATS_SRC,
+
+	__ETHTOOL_A_PAUSE_CNT,
+	ETHTOOL_A_PAUSE_MAX = (__ETHTOOL_A_PAUSE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_EEE_UNSPEC,
+	ETHTOOL_A_EEE_HEADER,
+	ETHTOOL_A_EEE_MODES_OURS,
+	ETHTOOL_A_EEE_MODES_PEER,
+	ETHTOOL_A_EEE_ACTIVE,
+	ETHTOOL_A_EEE_ENABLED,
+	ETHTOOL_A_EEE_TX_LPI_ENABLED,
+	ETHTOOL_A_EEE_TX_LPI_TIMER,
+
+	__ETHTOOL_A_EEE_CNT,
+	ETHTOOL_A_EEE_MAX = (__ETHTOOL_A_EEE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TS_STAT_UNSPEC,
+	ETHTOOL_A_TS_STAT_TX_PKTS,
+	ETHTOOL_A_TS_STAT_TX_LOST,
+	ETHTOOL_A_TS_STAT_TX_ERR,
+	ETHTOOL_A_TS_STAT_TX_ONESTEP_PKTS_UNCONFIRMED,
+
+	__ETHTOOL_A_TS_STAT_CNT,
+	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TS_HWTSTAMP_PROVIDER_UNSPEC,
+	ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX,
+	ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER,
+
+	__ETHTOOL_A_TS_HWTSTAMP_PROVIDER_CNT,
+	ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX = (__ETHTOOL_A_TS_HWTSTAMP_PROVIDER_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TSINFO_UNSPEC,
+	ETHTOOL_A_TSINFO_HEADER,
+	ETHTOOL_A_TSINFO_TIMESTAMPING,
+	ETHTOOL_A_TSINFO_TX_TYPES,
+	ETHTOOL_A_TSINFO_RX_FILTERS,
+	ETHTOOL_A_TSINFO_PHC_INDEX,
+	ETHTOOL_A_TSINFO_STATS,
+	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER,
+
+	__ETHTOOL_A_TSINFO_CNT,
+	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_RESULT_UNSPEC,
+	ETHTOOL_A_CABLE_RESULT_PAIR,
+	ETHTOOL_A_CABLE_RESULT_CODE,
+	ETHTOOL_A_CABLE_RESULT_SRC,
+
+	__ETHTOOL_A_CABLE_RESULT_CNT,
+	ETHTOOL_A_CABLE_RESULT_MAX = (__ETHTOOL_A_CABLE_RESULT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC,
+	ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR,
+	ETHTOOL_A_CABLE_FAULT_LENGTH_CM,
+	ETHTOOL_A_CABLE_FAULT_LENGTH_SRC,
+
+	__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT,
+	ETHTOOL_A_CABLE_FAULT_LENGTH_MAX = (__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_NEST_UNSPEC,
+	ETHTOOL_A_CABLE_NEST_RESULT,
+	ETHTOOL_A_CABLE_NEST_FAULT_LENGTH,
+
+	__ETHTOOL_A_CABLE_NEST_CNT,
+	ETHTOOL_A_CABLE_NEST_MAX = (__ETHTOOL_A_CABLE_NEST_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_TEST_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_HEADER,
+
+	__ETHTOOL_A_CABLE_TEST_CNT,
+	ETHTOOL_A_CABLE_TEST_MAX = (__ETHTOOL_A_CABLE_TEST_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_TEST_NTF_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_NTF_HEADER,
+	ETHTOOL_A_CABLE_TEST_NTF_STATUS,
+	ETHTOOL_A_CABLE_TEST_NTF_NEST,
+
+	__ETHTOOL_A_CABLE_TEST_NTF_CNT,
+	ETHTOOL_A_CABLE_TEST_NTF_MAX = (__ETHTOOL_A_CABLE_TEST_NTF_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_FIRST,
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_LAST,
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_STEP,
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_PAIR,
+
+	__ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT,
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_MAX = (__ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_HEADER,
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_STATUS,
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_NEST,
+
+	__ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT,
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_MAX = (__ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_TEST_TDR_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_TDR_HEADER,
+	ETHTOOL_A_CABLE_TEST_TDR_CFG,
+
+	__ETHTOOL_A_CABLE_TEST_TDR_CNT,
+	ETHTOOL_A_CABLE_TEST_TDR_MAX = (__ETHTOOL_A_CABLE_TEST_TDR_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TUNNEL_UDP_ENTRY_UNSPEC,
+	ETHTOOL_A_TUNNEL_UDP_ENTRY_PORT,
+	ETHTOOL_A_TUNNEL_UDP_ENTRY_TYPE,
+
+	__ETHTOOL_A_TUNNEL_UDP_ENTRY_CNT,
+	ETHTOOL_A_TUNNEL_UDP_ENTRY_MAX = (__ETHTOOL_A_TUNNEL_UDP_ENTRY_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TUNNEL_UDP_TABLE_UNSPEC,
+	ETHTOOL_A_TUNNEL_UDP_TABLE_SIZE,
+	ETHTOOL_A_TUNNEL_UDP_TABLE_TYPES,
+	ETHTOOL_A_TUNNEL_UDP_TABLE_ENTRY,
+
+	__ETHTOOL_A_TUNNEL_UDP_TABLE_CNT,
+	ETHTOOL_A_TUNNEL_UDP_TABLE_MAX = (__ETHTOOL_A_TUNNEL_UDP_TABLE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TUNNEL_UDP_UNSPEC,
+	ETHTOOL_A_TUNNEL_UDP_TABLE,
+
+	__ETHTOOL_A_TUNNEL_UDP_CNT,
+	ETHTOOL_A_TUNNEL_UDP_MAX = (__ETHTOOL_A_TUNNEL_UDP_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TUNNEL_INFO_UNSPEC,
+	ETHTOOL_A_TUNNEL_INFO_HEADER,
+	ETHTOOL_A_TUNNEL_INFO_UDP_PORTS,
+
+	__ETHTOOL_A_TUNNEL_INFO_CNT,
+	ETHTOOL_A_TUNNEL_INFO_MAX = (__ETHTOOL_A_TUNNEL_INFO_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_FEC_STAT_UNSPEC,
+	ETHTOOL_A_FEC_STAT_PAD,
+	ETHTOOL_A_FEC_STAT_CORRECTED,
+	ETHTOOL_A_FEC_STAT_UNCORR,
+	ETHTOOL_A_FEC_STAT_CORR_BITS,
+
+	__ETHTOOL_A_FEC_STAT_CNT,
+	ETHTOOL_A_FEC_STAT_MAX = (__ETHTOOL_A_FEC_STAT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_FEC_UNSPEC,
+	ETHTOOL_A_FEC_HEADER,
+	ETHTOOL_A_FEC_MODES,
+	ETHTOOL_A_FEC_AUTO,
+	ETHTOOL_A_FEC_ACTIVE,
+	ETHTOOL_A_FEC_STATS,
+
+	__ETHTOOL_A_FEC_CNT,
+	ETHTOOL_A_FEC_MAX = (__ETHTOOL_A_FEC_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MODULE_EEPROM_UNSPEC,
+	ETHTOOL_A_MODULE_EEPROM_HEADER,
+	ETHTOOL_A_MODULE_EEPROM_OFFSET,
+	ETHTOOL_A_MODULE_EEPROM_LENGTH,
+	ETHTOOL_A_MODULE_EEPROM_PAGE,
+	ETHTOOL_A_MODULE_EEPROM_BANK,
+	ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS,
+	ETHTOOL_A_MODULE_EEPROM_DATA,
+
+	__ETHTOOL_A_MODULE_EEPROM_CNT,
+	ETHTOOL_A_MODULE_EEPROM_MAX = (__ETHTOOL_A_MODULE_EEPROM_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_STATS_GRP_UNSPEC,
+	ETHTOOL_A_STATS_GRP_PAD,
+	ETHTOOL_A_STATS_GRP_ID,
+	ETHTOOL_A_STATS_GRP_SS_ID,
+	ETHTOOL_A_STATS_GRP_STAT,
+	ETHTOOL_A_STATS_GRP_HIST_RX,
+	ETHTOOL_A_STATS_GRP_HIST_TX,
+	ETHTOOL_A_STATS_GRP_HIST_BKT_LOW,
+	ETHTOOL_A_STATS_GRP_HIST_BKT_HI,
+	ETHTOOL_A_STATS_GRP_HIST_VAL,
+
+	__ETHTOOL_A_STATS_GRP_CNT,
+	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_GRP_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_STATS_UNSPEC,
+	ETHTOOL_A_STATS_PAD,
+	ETHTOOL_A_STATS_HEADER,
+	ETHTOOL_A_STATS_GROUPS,
+	ETHTOOL_A_STATS_GRP,
+	ETHTOOL_A_STATS_SRC,
+
+	__ETHTOOL_A_STATS_CNT,
+	ETHTOOL_A_STATS_MAX = (__ETHTOOL_A_STATS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PHC_VCLOCKS_UNSPEC,
+	ETHTOOL_A_PHC_VCLOCKS_HEADER,
+	ETHTOOL_A_PHC_VCLOCKS_NUM,
+	ETHTOOL_A_PHC_VCLOCKS_INDEX,
+
+	__ETHTOOL_A_PHC_VCLOCKS_CNT,
+	ETHTOOL_A_PHC_VCLOCKS_MAX = (__ETHTOOL_A_PHC_VCLOCKS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MODULE_UNSPEC,
+	ETHTOOL_A_MODULE_HEADER,
+	ETHTOOL_A_MODULE_POWER_MODE_POLICY,
+	ETHTOOL_A_MODULE_POWER_MODE,
+
+	__ETHTOOL_A_MODULE_CNT,
+	ETHTOOL_A_MODULE_MAX = (__ETHTOOL_A_MODULE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_C33_PSE_PW_LIMIT_UNSPEC,
+	ETHTOOL_A_C33_PSE_PW_LIMIT_MIN,
+	ETHTOOL_A_C33_PSE_PW_LIMIT_MAX,
+
+	__ETHTOOL_A_C33_PSE_PW_LIMIT_CNT,
+	__ETHTOOL_A_C33_PSE_PW_LIMIT_MAX = (__ETHTOOL_A_C33_PSE_PW_LIMIT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PSE_UNSPEC,
+	ETHTOOL_A_PSE_HEADER,
+	ETHTOOL_A_PODL_PSE_ADMIN_STATE,
+	ETHTOOL_A_PODL_PSE_ADMIN_CONTROL,
+	ETHTOOL_A_PODL_PSE_PW_D_STATUS,
+	ETHTOOL_A_C33_PSE_ADMIN_STATE,
+	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,
+	ETHTOOL_A_C33_PSE_PW_D_STATUS,
+	ETHTOOL_A_C33_PSE_PW_CLASS,
+	ETHTOOL_A_C33_PSE_ACTUAL_PW,
+	ETHTOOL_A_C33_PSE_EXT_STATE,
+	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
+	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
+	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
+
+	__ETHTOOL_A_PSE_CNT,
+	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_RSS_UNSPEC,
+	ETHTOOL_A_RSS_HEADER,
+	ETHTOOL_A_RSS_CONTEXT,
+	ETHTOOL_A_RSS_HFUNC,
+	ETHTOOL_A_RSS_INDIR,
+	ETHTOOL_A_RSS_HKEY,
+	ETHTOOL_A_RSS_INPUT_XFRM,
+	ETHTOOL_A_RSS_START_CONTEXT,
+
+	__ETHTOOL_A_RSS_CNT,
+	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PLCA_UNSPEC,
+	ETHTOOL_A_PLCA_HEADER,
+	ETHTOOL_A_PLCA_VERSION,
+	ETHTOOL_A_PLCA_ENABLED,
+	ETHTOOL_A_PLCA_STATUS,
+	ETHTOOL_A_PLCA_NODE_CNT,
+	ETHTOOL_A_PLCA_NODE_ID,
+	ETHTOOL_A_PLCA_TO_TMR,
+	ETHTOOL_A_PLCA_BURST_CNT,
+	ETHTOOL_A_PLCA_BURST_TMR,
+
+	__ETHTOOL_A_PLCA_CNT,
+	ETHTOOL_A_PLCA_MAX = (__ETHTOOL_A_PLCA_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MODULE_FW_FLASH_UNSPEC,
+	ETHTOOL_A_MODULE_FW_FLASH_HEADER,
+	ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,
+	ETHTOOL_A_MODULE_FW_FLASH_PASSWORD,
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS,
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,
+	ETHTOOL_A_MODULE_FW_FLASH_DONE,
+	ETHTOOL_A_MODULE_FW_FLASH_TOTAL,
+
+	__ETHTOOL_A_MODULE_FW_FLASH_CNT,
+	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PHY_UNSPEC,
+	ETHTOOL_A_PHY_HEADER,
+	ETHTOOL_A_PHY_INDEX,
+	ETHTOOL_A_PHY_DRVNAME,
+	ETHTOOL_A_PHY_NAME,
+	ETHTOOL_A_PHY_UPSTREAM_TYPE,
+	ETHTOOL_A_PHY_UPSTREAM_INDEX,
+	ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,
+	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,
+
+	__ETHTOOL_A_PHY_CNT,
+	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TSCONFIG_UNSPEC,
+	ETHTOOL_A_TSCONFIG_HEADER,
+	ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER,
+	ETHTOOL_A_TSCONFIG_TX_TYPES,
+	ETHTOOL_A_TSCONFIG_RX_FILTERS,
+	ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS,
+
+	__ETHTOOL_A_TSCONFIG_CNT,
+	ETHTOOL_A_TSCONFIG_MAX = (__ETHTOOL_A_TSCONFIG_CNT - 1)
+};
+
+enum {
+	ETHTOOL_MSG_USER_NONE = 0,
+	ETHTOOL_MSG_STRSET_GET = 1,
+	ETHTOOL_MSG_LINKINFO_GET,
+	ETHTOOL_MSG_LINKINFO_SET,
+	ETHTOOL_MSG_LINKMODES_GET,
+	ETHTOOL_MSG_LINKMODES_SET,
+	ETHTOOL_MSG_LINKSTATE_GET,
+	ETHTOOL_MSG_DEBUG_GET,
+	ETHTOOL_MSG_DEBUG_SET,
+	ETHTOOL_MSG_WOL_GET,
+	ETHTOOL_MSG_WOL_SET,
+	ETHTOOL_MSG_FEATURES_GET,
+	ETHTOOL_MSG_FEATURES_SET,
+	ETHTOOL_MSG_PRIVFLAGS_GET,
+	ETHTOOL_MSG_PRIVFLAGS_SET,
+	ETHTOOL_MSG_RINGS_GET,
+	ETHTOOL_MSG_RINGS_SET,
+	ETHTOOL_MSG_CHANNELS_GET,
+	ETHTOOL_MSG_CHANNELS_SET,
+	ETHTOOL_MSG_COALESCE_GET,
+	ETHTOOL_MSG_COALESCE_SET,
+	ETHTOOL_MSG_PAUSE_GET,
+	ETHTOOL_MSG_PAUSE_SET,
+	ETHTOOL_MSG_EEE_GET,
+	ETHTOOL_MSG_EEE_SET,
+	ETHTOOL_MSG_TSINFO_GET,
+	ETHTOOL_MSG_CABLE_TEST_ACT,
+	ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
+	ETHTOOL_MSG_TUNNEL_INFO_GET,
+	ETHTOOL_MSG_FEC_GET,
+	ETHTOOL_MSG_FEC_SET,
+	ETHTOOL_MSG_MODULE_EEPROM_GET,
+	ETHTOOL_MSG_STATS_GET,
+	ETHTOOL_MSG_PHC_VCLOCKS_GET,
+	ETHTOOL_MSG_MODULE_GET,
+	ETHTOOL_MSG_MODULE_SET,
+	ETHTOOL_MSG_PSE_GET,
+	ETHTOOL_MSG_PSE_SET,
+	ETHTOOL_MSG_RSS_GET,
+	ETHTOOL_MSG_PLCA_GET_CFG,
+	ETHTOOL_MSG_PLCA_SET_CFG,
+	ETHTOOL_MSG_PLCA_GET_STATUS,
+	ETHTOOL_MSG_MM_GET,
+	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
+	ETHTOOL_MSG_PHY_GET,
+	ETHTOOL_MSG_TSCONFIG_GET,
+	ETHTOOL_MSG_TSCONFIG_SET,
+
+	__ETHTOOL_MSG_USER_CNT,
+	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
+};
+
+enum {
+	ETHTOOL_MSG_KERNEL_NONE = 0,
+	ETHTOOL_MSG_STRSET_GET_REPLY = 1,
+	ETHTOOL_MSG_LINKINFO_GET_REPLY,
+	ETHTOOL_MSG_LINKINFO_NTF,
+	ETHTOOL_MSG_LINKMODES_GET_REPLY,
+	ETHTOOL_MSG_LINKMODES_NTF,
+	ETHTOOL_MSG_LINKSTATE_GET_REPLY,
+	ETHTOOL_MSG_DEBUG_GET_REPLY,
+	ETHTOOL_MSG_DEBUG_NTF,
+	ETHTOOL_MSG_WOL_GET_REPLY,
+	ETHTOOL_MSG_WOL_NTF,
+	ETHTOOL_MSG_FEATURES_GET_REPLY,
+	ETHTOOL_MSG_FEATURES_SET_REPLY,
+	ETHTOOL_MSG_FEATURES_NTF,
+	ETHTOOL_MSG_PRIVFLAGS_GET_REPLY,
+	ETHTOOL_MSG_PRIVFLAGS_NTF,
+	ETHTOOL_MSG_RINGS_GET_REPLY,
+	ETHTOOL_MSG_RINGS_NTF,
+	ETHTOOL_MSG_CHANNELS_GET_REPLY,
+	ETHTOOL_MSG_CHANNELS_NTF,
+	ETHTOOL_MSG_COALESCE_GET_REPLY,
+	ETHTOOL_MSG_COALESCE_NTF,
+	ETHTOOL_MSG_PAUSE_GET_REPLY,
+	ETHTOOL_MSG_PAUSE_NTF,
+	ETHTOOL_MSG_EEE_GET_REPLY,
+	ETHTOOL_MSG_EEE_NTF,
+	ETHTOOL_MSG_TSINFO_GET_REPLY,
+	ETHTOOL_MSG_CABLE_TEST_NTF,
+	ETHTOOL_MSG_CABLE_TEST_TDR_NTF,
+	ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY,
+	ETHTOOL_MSG_FEC_GET_REPLY,
+	ETHTOOL_MSG_FEC_NTF,
+	ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY,
+	ETHTOOL_MSG_STATS_GET_REPLY,
+	ETHTOOL_MSG_PHC_VCLOCKS_GET_REPLY,
+	ETHTOOL_MSG_MODULE_GET_REPLY,
+	ETHTOOL_MSG_MODULE_NTF,
+	ETHTOOL_MSG_PSE_GET_REPLY,
+	ETHTOOL_MSG_RSS_GET_REPLY,
+	ETHTOOL_MSG_PLCA_GET_CFG_REPLY,
+	ETHTOOL_MSG_PLCA_GET_STATUS_REPLY,
+	ETHTOOL_MSG_PLCA_NTF,
+	ETHTOOL_MSG_MM_GET_REPLY,
+	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
+	ETHTOOL_MSG_PHY_GET_REPLY,
+	ETHTOOL_MSG_PHY_NTF,
+	ETHTOOL_MSG_TSCONFIG_GET_REPLY,
+	ETHTOOL_MSG_TSCONFIG_SET_REPLY,
+
+	__ETHTOOL_MSG_KERNEL_CNT,
+	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
+};
+
+#endif /* _LINUX_ETHTOOL_NETLINK_GENERATED_H */
diff --git a/uapi/linux/if_link.h b/uapi/linux/if_link.h
index 987efeddc30e987e1fd1b2d39dfc2024c644645f..9330d5b763e24087f0715a1a67f1755eaf4204e3 100644
--- a/uapi/linux/if_link.h
+++ b/uapi/linux/if_link.h
@@ -377,6 +377,7 @@ enum {
 	IFLA_GSO_IPV4_MAX_SIZE,
 	IFLA_GRO_IPV4_MAX_SIZE,
 	IFLA_DPLL_PIN,
+	IFLA_MAX_PACING_OFFLOAD_HORIZON,
 	__IFLA_MAX
 };
 
@@ -1290,6 +1291,19 @@ enum netkit_mode {
 	NETKIT_L3,
 };
 
+/* NETKIT_SCRUB_NONE leaves clearing skb->{mark,priority} up to
+ * the BPF program if attached. This also means the latter can
+ * consume the two fields if they were populated earlier.
+ *
+ * NETKIT_SCRUB_DEFAULT zeroes skb->{mark,priority} fields before
+ * invoking the attached BPF program when the peer device resides
+ * in a different network namespace. This is the default behavior.
+ */
+enum netkit_scrub {
+	NETKIT_SCRUB_NONE,
+	NETKIT_SCRUB_DEFAULT,
+};
+
 enum {
 	IFLA_NETKIT_UNSPEC,
 	IFLA_NETKIT_PEER_INFO,
@@ -1297,6 +1311,10 @@ enum {
 	IFLA_NETKIT_POLICY,
 	IFLA_NETKIT_PEER_POLICY,
 	IFLA_NETKIT_MODE,
+	IFLA_NETKIT_SCRUB,
+	IFLA_NETKIT_PEER_SCRUB,
+	IFLA_NETKIT_HEADROOM,
+	IFLA_NETKIT_TAILROOM,
 	__IFLA_NETKIT_MAX,
 };
 #define IFLA_NETKIT_MAX	(__IFLA_NETKIT_MAX - 1)
@@ -1376,6 +1394,7 @@ enum {
 	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
 	IFLA_VXLAN_LOCALBYPASS,
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
+	IFLA_VXLAN_RESERVED_BITS,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -1417,6 +1436,7 @@ enum {
 	IFLA_GENEVE_TTL_INHERIT,
 	IFLA_GENEVE_DF,
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
+	IFLA_GENEVE_PORT_RANGE,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
@@ -1429,6 +1449,11 @@ enum ifla_geneve_df {
 	GENEVE_DF_MAX = __GENEVE_DF_END - 1,
 };
 
+struct ifla_geneve_port_range {
+	__be16 low;
+	__be16 high;
+};
+
 /* Bareudp section  */
 enum {
 	IFLA_BAREUDP_UNSPEC,
@@ -1940,6 +1965,7 @@ struct ifla_rmnet_flags {
 enum {
 	IFLA_MCTP_UNSPEC,
 	IFLA_MCTP_NET,
+	IFLA_MCTP_PHYS_BINDING,
 	__IFLA_MCTP_MAX,
 };
 
diff --git a/uapi/linux/net_tstamp.h b/uapi/linux/net_tstamp.h
index 858339d1c1c4c1967c0ec76390719dec61e04a3c..55b0ab51096c153c6e1f81d0b0c231dddfa13494 100644
--- a/uapi/linux/net_tstamp.h
+++ b/uapi/linux/net_tstamp.h
@@ -13,6 +13,17 @@
 #include <linux/types.h>
 #include <linux/socket.h>   /* for SO_TIMESTAMPING */
 
+/*
+ * Possible type of hwtstamp provider. Mainly "precise" the default one
+ * is for IEEE 1588 quality and "approx" is for NICs DMA point.
+ */
+enum hwtstamp_provider_qualifier {
+	HWTSTAMP_PROVIDER_QUALIFIER_PRECISE,
+	HWTSTAMP_PROVIDER_QUALIFIER_APPROX,
+
+	HWTSTAMP_PROVIDER_QUALIFIER_CNT,
+};
+
 /* SO_TIMESTAMPING flags */
 enum {
 	SOF_TIMESTAMPING_TX_HARDWARE = (1<<0),
diff --git a/uapi/linux/rtnetlink.h b/uapi/linux/rtnetlink.h
index 4e6c8e14cc300a5e14bfe06481bc349de0f9bb6e..085bb13970307852ae754e7a4ac27d7ca3fecd7b 100644
--- a/uapi/linux/rtnetlink.h
+++ b/uapi/linux/rtnetlink.h
@@ -93,10 +93,18 @@ enum {
 	RTM_NEWPREFIX	= 52,
 #define RTM_NEWPREFIX	RTM_NEWPREFIX
 
-	RTM_GETMULTICAST = 58,
+	RTM_NEWMULTICAST = 56,
+#define RTM_NEWMULTICAST RTM_NEWMULTICAST
+	RTM_DELMULTICAST,
+#define RTM_DELMULTICAST RTM_DELMULTICAST
+	RTM_GETMULTICAST,
 #define RTM_GETMULTICAST RTM_GETMULTICAST
 
-	RTM_GETANYCAST	= 62,
+	RTM_NEWANYCAST	= 60,
+#define RTM_NEWANYCAST RTM_NEWANYCAST
+	RTM_DELANYCAST,
+#define RTM_DELANYCAST RTM_DELANYCAST
+	RTM_GETANYCAST,
 #define RTM_GETANYCAST	RTM_GETANYCAST
 
 	RTM_NEWNEIGHTBL	= 64,
@@ -174,7 +182,7 @@ enum {
 #define RTM_GETLINKPROP	RTM_GETLINKPROP
 
 	RTM_NEWVLAN = 112,
-#define RTM_NEWNVLAN	RTM_NEWVLAN
+#define RTM_NEWVLAN	RTM_NEWVLAN
 	RTM_DELVLAN,
 #define RTM_DELVLAN	RTM_DELVLAN
 	RTM_GETVLAN,
@@ -299,6 +307,7 @@ enum {
 #define RTPROT_MROUTED		17	/* Multicast daemon */
 #define RTPROT_KEEPALIVED	18	/* Keepalived daemon */
 #define RTPROT_BABEL		42	/* Babel daemon */
+#define RTPROT_OVN		84	/* OVN daemon */
 #define RTPROT_OPENR		99	/* Open Routing (Open/R) Routes */
 #define RTPROT_BGP		186	/* BGP Routes */
 #define RTPROT_ISIS		187	/* ISIS Routes */
@@ -389,6 +398,7 @@ enum rtattr_type_t {
 	RTA_SPORT,
 	RTA_DPORT,
 	RTA_NH_ID,
+	RTA_FLOWLABEL,
 	__RTA_MAX
 };
 
@@ -772,6 +782,12 @@ enum rtnetlink_groups {
 #define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
 	RTNLGRP_STATS,
 #define RTNLGRP_STATS		RTNLGRP_STATS
+	RTNLGRP_IPV4_MCADDR,
+#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
+	RTNLGRP_IPV6_MCADDR,
+#define RTNLGRP_IPV6_MCADDR	RTNLGRP_IPV6_MCADDR
+	RTNLGRP_IPV6_ACADDR,
+#define RTNLGRP_IPV6_ACADDR	RTNLGRP_IPV6_ACADDR
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
diff --git a/uapi/linux/stddef.h b/uapi/linux/stddef.h
index 96aa341942b05003e605c05d69bc68b0eb528b2e..e1416f793738f56beb5b47447f1c422eb103da72 100644
--- a/uapi/linux/stddef.h
+++ b/uapi/linux/stddef.h
@@ -8,6 +8,13 @@
 #define __always_inline __inline__
 #endif
 
+/* Not all C++ standards support type declarations inside an anonymous union */
+#ifndef __cplusplus
+#define __struct_group_tag(TAG)		TAG
+#else
+#define __struct_group_tag(TAG)
+#endif
+
 /**
  * __struct_group() - Create a mirrored named and anonyomous struct
  *
@@ -20,13 +27,13 @@
  * and size: one anonymous and one named. The former's members can be used
  * normally without sub-struct naming, and the latter can be used to
  * reason about the start, end, and size of the group of struct members.
- * The named struct can also be explicitly tagged for layer reuse, as well
- * as both having struct attributes appended.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
  */
 #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
 	union { \
 		struct { MEMBERS } ATTRS; \
-		struct TAG { MEMBERS } ATTRS NAME; \
+		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
 	} ATTRS
 
 #ifdef __cplusplus
diff --git a/uapi/linux/types.h b/uapi/linux/types.h
index e6700138c2096dc31452ba87d12c19a905101cae..251874108e6a37cdb7d421f7c9fe8f0d2a780fc1 100644
--- a/uapi/linux/types.h
+++ b/uapi/linux/types.h
@@ -48,6 +48,7 @@ typedef __u32 __bitwise __wsum;
  * No conversions are necessary between 32-bit user-space and a 64-bit kernel.
  */
 #define __aligned_u64 __u64 __attribute__((aligned(8)))
+#define __aligned_s64 __s64 __attribute__((aligned(8)))
 #define __aligned_be64 __be64 __attribute__((aligned(8)))
 #define __aligned_le64 __le64 __attribute__((aligned(8)))
 

-- 
2.34.1


