Return-Path: <netdev+bounces-244732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 842ECCBDC0A
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D77F303F810
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA433032E;
	Mon, 15 Dec 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MINotp2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE626315775
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800681; cv=none; b=Jz6Wmf6d6/OFgDAveY1bVb0q28hkuwz5B4c7Ly44qtPQD/JxXos0eJZX/NWtT0H1vOIK/YXJPtTiaHbz6m0jGEuMQ5BJ6jxjDRUWsd4PoDaQHSu4dV5nK8ACEkOh+WhUusxIf/4VM9gNi9DGRyBZ9Bk4hkDESUoAkw+1gddImhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800681; c=relaxed/simple;
	bh=7jM1UtncRIoXqwjpezsk+5Fa42ngJjTjGo1vsyQ0C/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBkwOEuIH9OGeWz+klDoXiPqrbM9KlF7MBq0tSwNh29A1nUzKR8+w3vyklSwB6kOzUXjia2JeDUBXg7EZ4QN/diYMl70zhb6y0LujVNxmA97/GngcYA/PHAQcDghXvcQtsPdTAvSsNezF2kc9SC5rYPCkmQPZIEk44oED2/wciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MINotp2Q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765800679; x=1797336679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jM1UtncRIoXqwjpezsk+5Fa42ngJjTjGo1vsyQ0C/o=;
  b=MINotp2QFMvv3AcGjfKAGO9sOTsN/ZYSWGMUkDuf66VDYxZtN0lUlmxt
   Sz6x4AKtFaQL3GCQMx6SbYMr4MnXKmSwGLRDTwJ47IRn7q4mlovqdpYqk
   wBr47B5SQFdHgaQgCDO1/BN7Po9yiVNSi15A/mGEzQrCne+wbsWwAtsGG
   awk72e1twTDXDe1Icc24IGrTyL91PR//U/USQdhFhZACAUnNFoRUoGq7B
   C8lzlLLealAMxcNmsglO+4WN4jXwmWJcg2XFKRp7cn+WKT9Ly0jhw5uty
   1wPdJfc0w5krrXsA4eRlWec51x5EhIkLgdsXnCCLjvJa9eFT+9M8b56g6
   Q==;
X-CSE-ConnectionGUID: 7Pyi8fasSl6WUZP4WrbWDw==
X-CSE-MsgGUID: nABu7FdAQNe+zpeMBCK5cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78815386"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="78815386"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:11:13 -0800
X-CSE-ConnectionGUID: ucXlneWlQdmgpT/I0+y/SQ==
X-CSE-MsgGUID: ZsJmH6MKTkmDwTgqKWRYqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202214142"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 15 Dec 2025 04:11:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7442C99; Mon, 15 Dec 2025 13:11:09 +0100 (CET)
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
Subject: [PATCH net-next v2 2/5] net: thunderbolt: Allow changing MTU of the device
Date: Mon, 15 Dec 2025 13:11:06 +0100
Message-ID: <20251215121109.4042218-3-mika.westerberg@linux.intel.com>
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

In some cases it is useful to be able to use different MTU than the
default one. Especially when dealing against non-Linux networking stack.
For this reason add possibility to change the MTU of the device.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 57b226afeb84..20bac55a3e20 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1257,12 +1257,23 @@ static void tbnet_get_stats64(struct net_device *dev,
 	stats->rx_missed_errors = net->stats.rx_missed_errors;
 }
 
+static int tbnet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	/* Keep the MTU within supported range */
+	if (new_mtu < 68 || new_mtu > (TBNET_MAX_MTU - ETH_HLEN))
+		return -EINVAL;
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
 static const struct net_device_ops tbnet_netdev_ops = {
 	.ndo_open = tbnet_open,
 	.ndo_stop = tbnet_stop,
 	.ndo_start_xmit = tbnet_start_xmit,
 	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_get_stats64 = tbnet_get_stats64,
+	.ndo_change_mtu	= tbnet_change_mtu,
 };
 
 static void tbnet_generate_mac(struct net_device *dev)
-- 
2.50.1


