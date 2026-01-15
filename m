Return-Path: <netdev+bounces-250155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7678D2456A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31837305D8B9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242EC393DE3;
	Thu, 15 Jan 2026 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGzcMde4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEEE39446C
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478220; cv=none; b=hAtE3/dlcYX8uvUTJA//VQmDRbsOwokY3w9Vaw9x6qUxzHZXboCnJz5Hr1GFS828118obiASxf0xcYBK8cpvhOWOYfExdlGM5z9knkJL5+8I2FecTdClUBmrcv7mBSUY/6phBlmiZbbrjaa9f7s4pY99DNqx8PaaqH9/tDKkp7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478220; c=relaxed/simple;
	bh=0+S70uDu8MQa0SKUiPhcF4BG83Mz6D8Cx411R2DVh9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwKEGa49amOtFgDJbsrRbVnC2K9hhc+ZM5oJ6EjwrbUbUb9GVVOAmZzrAUNAar2c3ZeLSzmJfPmOBqzuu0qZAwqxml6X6HC53dbT+knP6nsdh3qRbeC0hUNm9dsGMYM5YQIoE0E5xcpkgtETLNBOWE7s2ehJva5vqQc/pG+Deps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGzcMde4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768478217; x=1800014217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0+S70uDu8MQa0SKUiPhcF4BG83Mz6D8Cx411R2DVh9g=;
  b=PGzcMde4MTEgaTc4k7vF0VpMlGVlZrf8721lJcYg5X3LYpvXkRabBQTR
   ivAe+K7X1m4Ns31wX3OpPSzECT6gMwlPkbn+f6smLdAZrtrscECGTh8fO
   LmhVCjn7KyotI2qBqgcDI5TWPurZzLOBiE/mGCnk9t+rYlpZWmCDIglnO
   gbhGDm5TN/WaSvDA3mXKlBV2zv+Jci785xZ1wfFHX1cR5aY2YqT5Xey2s
   E56zSlmPWOciAU0M8//qteqopI5/PNcm7R4fjtVQ8jqUQ7ArBpJcRbutu
   V401EQSl6vPJ0XthM6TVEnrltIxbtV9LOiqpvmnq8+PBK0oL8mb44dex3
   g==;
X-CSE-ConnectionGUID: 0pxE9Qy0TN6FguumT7kbRg==
X-CSE-MsgGUID: 1jyw6Db3TE29Nj/GlHJrow==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="95258957"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="95258957"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 03:56:51 -0800
X-CSE-ConnectionGUID: bPRuGqwsQ2C7kDFAcuOl4A==
X-CSE-MsgGUID: LIqjvCdPRx2v/O3HiRO8bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="209413879"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2026 03:56:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F423F9B; Thu, 15 Jan 2026 12:56:46 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Ian MacDonald <ian@netstatz.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH net-next v3 2/4] net: ethtool: Add support for 80Gbps speed
Date: Thu, 15 Jan 2026 12:56:44 +0100
Message-ID: <20260115115646.328898-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
References: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

USB4 v2 link used in peer-to-peer networking is symmetric 80Gbps so in
order to support reading this link speed, add support for it to ethtool.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
I had to update include/linux/phylink.h as well, I hope it's fine to just
put it into middle and changing all the following bits accordingly. These
does not seem to be user-facing.

 drivers/net/phy/phy-caps.h   | 1 +
 drivers/net/phy/phy-core.c   | 2 ++
 drivers/net/phy/phy_caps.c   | 2 ++
 drivers/net/phy/phylink.c    | 1 +
 include/linux/phylink.h      | 7 ++++---
 include/uapi/linux/ethtool.h | 1 +
 6 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 4951a39f3828..fdc489fe3a2a 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -25,6 +25,7 @@ enum {
 	LINK_CAPA_40000FD,
 	LINK_CAPA_50000FD,
 	LINK_CAPA_56000FD,
+	LINK_CAPA_80000FD,
 	LINK_CAPA_100000FD,
 	LINK_CAPA_200000FD,
 	LINK_CAPA_400000FD,
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 277c034bc32f..4fd264ece09e 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -47,6 +47,8 @@ const char *phy_speed_to_str(int speed)
 		return "50Gbps";
 	case SPEED_56000:
 		return "56Gbps";
+	case SPEED_80000:
+		return "80Gbps";
 	case SPEED_100000:
 		return "100Gbps";
 	case SPEED_200000:
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 3a05982b39bf..3c53d3a746f2 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -21,6 +21,7 @@ static struct link_capabilities link_caps[__LINK_CAPA_MAX] __ro_after_init = {
 	{ SPEED_40000, DUPLEX_FULL, {0} }, /* LINK_CAPA_40000FD */
 	{ SPEED_50000, DUPLEX_FULL, {0} }, /* LINK_CAPA_50000FD */
 	{ SPEED_56000, DUPLEX_FULL, {0} }, /* LINK_CAPA_56000FD */
+	{ SPEED_80000, DUPLEX_FULL, {0} }, /* LINK_CAPA_80000FD */
 	{ SPEED_100000, DUPLEX_FULL, {0} }, /* LINK_CAPA_100000FD */
 	{ SPEED_200000, DUPLEX_FULL, {0} }, /* LINK_CAPA_200000FD */
 	{ SPEED_400000, DUPLEX_FULL, {0} }, /* LINK_CAPA_400000FD */
@@ -49,6 +50,7 @@ static int speed_duplex_to_capa(int speed, unsigned int duplex)
 	case SPEED_40000: return LINK_CAPA_40000FD;
 	case SPEED_50000: return LINK_CAPA_50000FD;
 	case SPEED_56000: return LINK_CAPA_56000FD;
+	case SPEED_80000: return LINK_CAPA_80000FD;
 	case SPEED_100000: return LINK_CAPA_100000FD;
 	case SPEED_200000: return LINK_CAPA_200000FD;
 	case SPEED_400000: return LINK_CAPA_400000FD;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 43d8380aaefb..c8fd6b91cdd4 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -311,6 +311,7 @@ static struct {
 	{ MAC_400000FD, SPEED_400000, DUPLEX_FULL, BIT(LINK_CAPA_400000FD) },
 	{ MAC_200000FD, SPEED_200000, DUPLEX_FULL, BIT(LINK_CAPA_200000FD) },
 	{ MAC_100000FD, SPEED_100000, DUPLEX_FULL, BIT(LINK_CAPA_100000FD) },
+	{ MAC_80000FD,  SPEED_80000,  DUPLEX_FULL, BIT(LINK_CAPA_80000FD) },
 	{ MAC_56000FD,  SPEED_56000,  DUPLEX_FULL, BIT(LINK_CAPA_56000FD) },
 	{ MAC_50000FD,  SPEED_50000,  DUPLEX_FULL, BIT(LINK_CAPA_50000FD) },
 	{ MAC_40000FD,  SPEED_40000,  DUPLEX_FULL, BIT(LINK_CAPA_40000FD) },
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 38363e566ac3..20996f5778d1 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -90,9 +90,10 @@ enum {
 	MAC_40000FD	= BIT(13),
 	MAC_50000FD	= BIT(14),
 	MAC_56000FD	= BIT(15),
-	MAC_100000FD	= BIT(16),
-	MAC_200000FD	= BIT(17),
-	MAC_400000FD	= BIT(18),
+	MAC_80000FD	= BIT(16),
+	MAC_100000FD	= BIT(17),
+	MAC_200000FD	= BIT(18),
+	MAC_400000FD	= BIT(19),
 };
 
 static inline bool phylink_autoneg_inband(unsigned int mode)
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index eb7ff2602fbb..181243a2d700 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2190,6 +2190,7 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_40000		40000
 #define SPEED_50000		50000
 #define SPEED_56000		56000
+#define SPEED_80000		80000
 #define SPEED_100000		100000
 #define SPEED_200000		200000
 #define SPEED_400000		400000
-- 
2.50.1


