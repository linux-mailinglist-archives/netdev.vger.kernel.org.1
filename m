Return-Path: <netdev+bounces-248483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C094AD09ACC
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641D1303E43B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D804B3590DC;
	Fri,  9 Jan 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWIdemc9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF8334374
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961572; cv=none; b=kJ/m7aRDJUGCsb1yO+3uFBIYIjV6eYkMpvc0MzeBPVcgbDtLWKj5VHFXI4xyQdvGPbmhjr2QW/+AE3JPBKPJj357oW8/77WwI+qqrioxN+9QhBAPmV6+r3W6IJY6ogNladI7pBvZIZnEc2qfnz1FqdyiYYwTeGFNUBPzX8G+Npg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961572; c=relaxed/simple;
	bh=7jM1UtncRIoXqwjpezsk+5Fa42ngJjTjGo1vsyQ0C/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elH7Y6iyLckB865Jj8+jlQB9qHOs3/WVjGuNFKfoMXdpgBbe8gWvzx81+/hRRdjQXPcNr788GbXFff0PxJK8lLLZHMMjgIZSbVhlY49aU07fS0Ph8RhiOwhK/QgHmUP4RtP+30RUiWLZdb64Jqx7zI8sKOG95JmUfQuG8M0I7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWIdemc9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767961572; x=1799497572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jM1UtncRIoXqwjpezsk+5Fa42ngJjTjGo1vsyQ0C/o=;
  b=mWIdemc96ZqSKoO6/i45ZYungCCIUQwWoF2YQFnSOiFy6EwTOYB+e8jS
   QldgnWoE+Y3H7LqU/e4KWI7Nr0Viml/LvuzWtPOtB7feLqTuWaX3hG8aj
   wXN44xzLbPfNigGZLMFTr+FCdh2a22BXgejQdrNCCIG1m3ZGSNLkbJf+7
   tugFlJ3OzkyLbFu+eWZFDAm8gh4GMXWGEiDLRiKzb4JhVWyB+0h8XTEpr
   wx64D6qBK/ME9x8SIJ2y/59+R8B5ilD7Mt7grbH5Yq1VKVZ6t/8Bcoq/a
   LrWF5XJrWbajQV6pNRiSmdbnarbiELwLOhJxWCnDljLoj4aBv6qIsdeID
   A==;
X-CSE-ConnectionGUID: /l0hTCYwSzOTVRuIqb1hkg==
X-CSE-MsgGUID: j/1HEXb9TkWquCjMxq17kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="73188984"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="73188984"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 04:26:11 -0800
X-CSE-ConnectionGUID: kUdHPCKhSzq4wCKkQyq7RQ==
X-CSE-MsgGUID: kgx8MIOQTg+X1xa/vIKtnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="234169174"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 09 Jan 2026 04:26:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id DF94B9B; Fri, 09 Jan 2026 13:26:06 +0100 (CET)
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
Subject: [PATCH RESEND net-next v2 2/5] net: thunderbolt: Allow changing MTU of the device
Date: Fri,  9 Jan 2026 13:26:03 +0100
Message-ID: <20260109122606.3586895-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
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


