Return-Path: <netdev+bounces-244733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13540CBDC0B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A4043014B41
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FCA33032F;
	Mon, 15 Dec 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvFr0kBx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01032ABC1
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800681; cv=none; b=SjdC7CmBRyAu1IlYgGka8pQEeqRFC8r2+1kULpBEqsStE71J8+7RcB1Bzc/aRfyOvDBLipvvlKYivC5+1eeAamq1n8t9ybSsp6kfDQoE0eOzW+3VNmeHXna+Dfinc7bU1UqV3PqW12ZqqUmfVr2RwXxY3tQAuOxXZhaliP+XwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800681; c=relaxed/simple;
	bh=obuskN0VLM0RsO7b1MxxqOgZpp++YKGXBy4gGTPNifQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPvq2ndRN8V1uxXdQl+3sXeNKe3sRU/3/3ADPKDSLOwf/sGhVsDXHOdEC/n9XP+t1M0oey5cKNwYRCbhEyvBDKlqK3vPHolrd/9/1S4FheAaPW3imwZUcKekrZN2Qox0P7nEfHCd9Qw7kj8Zrg2823krpEaAHn8TDuqapDIf268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvFr0kBx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765800679; x=1797336679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obuskN0VLM0RsO7b1MxxqOgZpp++YKGXBy4gGTPNifQ=;
  b=JvFr0kBxawJlWrBubZ3dXBKhs3MpoozKicj0pDRy3YcSJjuKbLvqVW0j
   9dECX4l4oNxuBUrORjY1zrebY8FZ+rhKgK1OotQvqE1/HJktJrdu7WGX1
   8UOFoR1CcsAHOQBaZSdvwavW5SHqvVlp9D1YSl7Wvs11S9RYbXZ3o4bka
   AHCnxP+Ly6cHNu9Vl3dSajgbNYAezPYnkKiRmvzR/pnMhSMS3YtnklL8f
   FW0BHO0eJHgTy1PbZn5ScZpdcoS46QDR470SfMLGpcv/CPh/B5M2HjeE1
   HQE8NSDeRD8FqnAgqGpEa2GfERQuD+hUc5yEBAwLAwXKvDaq60/dowO31
   A==;
X-CSE-ConnectionGUID: ormU6e7SSwWsXp4gSsCMLw==
X-CSE-MsgGUID: +Nf/B7gzQIaFQQ6FRp32jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78815396"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="78815396"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:11:13 -0800
X-CSE-ConnectionGUID: SLQFCu9pTIWGaYF/4F6fUw==
X-CSE-MsgGUID: IzgaerHyTPy5TWsLr18/tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202214143"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 15 Dec 2025 04:11:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7AF3E9E; Mon, 15 Dec 2025 13:11:09 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH net-next v2 4/5] bonding: 3ad: Add support for SPEED_80000
Date: Mon, 15 Dec 2025 13:11:08 +0100
Message-ID: <20251215121109.4042218-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215121109.4042218-1-mika.westerberg@linux.intel.com>
References: <20251215121109.4042218-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ethtool SPEED_80000. This is needed to allow
Thunderbolt/USB4 networking driver to be used with the bonding driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/bonding/bond_3ad.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 1a8de2bf8655..e5e9c7207309 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -72,6 +72,7 @@ enum ad_link_speed_type {
 	AD_LINK_SPEED_40000MBPS,
 	AD_LINK_SPEED_50000MBPS,
 	AD_LINK_SPEED_56000MBPS,
+	AD_LINK_SPEED_80000MBPS,
 	AD_LINK_SPEED_100000MBPS,
 	AD_LINK_SPEED_200000MBPS,
 	AD_LINK_SPEED_400000MBPS,
@@ -297,6 +298,7 @@ static inline int __check_agg_selection_timer(struct port *port)
  *     %AD_LINK_SPEED_40000MBPS
  *     %AD_LINK_SPEED_50000MBPS
  *     %AD_LINK_SPEED_56000MBPS
+ *     %AD_LINK_SPEED_80000MBPS
  *     %AD_LINK_SPEED_100000MBPS
  *     %AD_LINK_SPEED_200000MBPS
  *     %AD_LINK_SPEED_400000MBPS
@@ -365,6 +367,10 @@ static u16 __get_link_speed(struct port *port)
 			speed = AD_LINK_SPEED_56000MBPS;
 			break;
 
+		case SPEED_80000:
+			speed = AD_LINK_SPEED_80000MBPS;
+			break;
+
 		case SPEED_100000:
 			speed = AD_LINK_SPEED_100000MBPS;
 			break;
-- 
2.50.1


