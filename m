Return-Path: <netdev+bounces-248484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15338D09ADC
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C383303D6B9
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688A35A92E;
	Fri,  9 Jan 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTJedhTR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9733C526
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961572; cv=none; b=LGPJeQxd/0TMUhMBoquEUKanU69I/HIawUCW4pjnCWAUwyh9z+hVlF93EwPukV1GnH+jxdiwcpb1fYEFcMxpDaYdu8UraxQhQ1vsIi0ViwNsmipriPfc+RQJEn1eIgTyReNd67e6ofjyfHAi5YmSuSY73SB8BvoQuIDFgcp+A1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961572; c=relaxed/simple;
	bh=pDCBhTYfTFE6+ErajN6jp3ubxB+7ArCc6Qhokq7WPqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B291AAowqJXpH5/t4RXwSbnTRASezUdyjsGHFgEHTx7xRwwkJg9p2RZj7ON/5NFp1I23z7DkSQ8LqoPq39XMj6nxCvQhS+PRwEeGavY5YBDCnX9k0eizGvQNJgu4qfiQZLI0ZDxZ06k0Y25mv/36SRChOLRWJ/TNG8qpzthPJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTJedhTR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767961572; x=1799497572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pDCBhTYfTFE6+ErajN6jp3ubxB+7ArCc6Qhokq7WPqI=;
  b=HTJedhTRe33M9uXtY7uRCvV+oplimcOwSUZkMwsGa6zpKpYkyy4TXAZE
   0wwlihxT4zHkzHs1wuRsZPvm4ZwHqQmlcKgvPu4h/uvU8aHsqxam/Kueb
   2Mp1N+QvgnqYVuxnUzqJeqPAcuzhXiQL5U7cVfqOLIrtUIWRGU/VT2ZLq
   5K3/E2nGz3Zuef4VtW7bNLbOqQdCbPgX1aW+j9OnSqTZzL3kn4Laf6iAB
   nscj9QPUDA6r7d3SdYh1+Bq4GGyPCfCwL/HYluABnglkWhBUFqGvH4cSJ
   9/i8XbhyZUrPVGC7pUUMyMKrOHVK+yFY20XInS1CmYkRFw5jer2mF3g7v
   Q==;
X-CSE-ConnectionGUID: LBJf/+bnT8m+uGGJmWvIAA==
X-CSE-MsgGUID: 2e80nNYfST2u7Vd0S98sHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="79981325"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="79981325"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 04:26:11 -0800
X-CSE-ConnectionGUID: 1AxsmOZ2QHeEgpTMkA0SbA==
X-CSE-MsgGUID: Fap86jTTROWcgUCuMxJg4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="208516493"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 09 Jan 2026 04:26:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D9AD198; Fri, 09 Jan 2026 13:26:06 +0100 (CET)
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
	Simon Horman <horms@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND net-next v2 0/5] net: thunderbolt: Various improvements
Date: Fri,  9 Jan 2026 13:26:01 +0100
Message-ID: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Resending now as the net-next tree should be open again].

Hi all,

This series improves the Thunderbolt networking driver so that it should
work with the bonding driver. I added also possibility of channing MTU
which is sometimes needed, and was part of the original driver.

The discussion that started this patch series can be read below:

  https://lore.kernel.org/netdev/CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com/

The previous version of the series can be seen here:

  v1: https://lore.kernel.org/netdev/20251127131521.2580237-1-mika.westerberg@linux.intel.com/

Changes from the previous version:

  - Add SPEED_80000
  - Add support for SPEED_80000 for ethtool and 3ad bonding driver
  - Use SPEED_80000 with the USB4 v2 symmetric link
  - Fill blank for supported and advertising.

Ian MacDonald (1):
  net: thunderbolt: Allow reading link settings

Mika Westerberg (4):
  net: thunderbolt: Allow changing MAC address of the device
  net: thunderbolt: Allow changing MTU of the device
  net: ethtool: Add define for SPEED_80000
  bonding: 3ad: Add support for SPEED_80000

 drivers/net/bonding/bond_3ad.c |  6 ++++
 drivers/net/thunderbolt/main.c | 64 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ethtool.h   |  1 +
 3 files changed, 71 insertions(+)

-- 
2.50.1


