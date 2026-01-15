Return-Path: <netdev+bounces-250151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FF0D2455D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9BEA30150E4
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D2394474;
	Thu, 15 Jan 2026 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPYDSRyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A7394463
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478215; cv=none; b=sFB899Ufmhju9KGtUs34SNhh3FSN0Cvk8bcLfiMDBo3IaQByXEUn+qZ13xKmgRbi7k+mJdRd7W+kaWSotTxSujDZjpjrIDjwd3okLv17jjxv4r2QyKoniht7ChKSUzdqAS11HWacZ+w8rIR3DPSYY+07rzeb4ekv/ZSR6ZzOjcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478215; c=relaxed/simple;
	bh=5kclX+p3ga+gWYDULD0Tckau8mQuj4sOrK0Tm9zfluQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJguhpMQXRvGxZL+fjTuhzyT40p8ZgIF38QXYzuwHO6bol7vne78FUPPPjzPJxdR2kHV5/nX5CXNp62acD4g6N8twqnGkuWf7bRvCLUt3zYDxcFsnWXiTz6rRru174RjMFfgpQ1kQUuQfxO1rNRL54l61gvxBVM7xusxxdd8uZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPYDSRyJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768478213; x=1800014213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5kclX+p3ga+gWYDULD0Tckau8mQuj4sOrK0Tm9zfluQ=;
  b=YPYDSRyJ5bq1D20zvXP5NhExOshwYMBrXTPOhp8n+aw4YiJBZ88Nk+YN
   q/nFQ/OkDKQkWzBycITo8b7JqszX9k2YIP5Bz9tKoSUcenmKDLfd+i4Ki
   +Kh6x1BIWsm0m8mtcKN1UAztqSm/DLW9489XQ1H02ufZUltlSLnySIemW
   uMti/vQ61+uCX8L1KG42ZlNUnCJPGEyriZnBGHnpmtorI4q4tfDi4dHeA
   8mgjpxHnMZg+YuaI39pxFbFPz9rL8zf5lSuKijaNnp3Xu98dcUMHmf8/n
   bUlym9Tl/okTUa5mL9bXCJOpZ6twHShgYHpwjNaVehKKJPLZ+FOozul54
   Q==;
X-CSE-ConnectionGUID: /DV1zIYCQn2ji6fsQ0+lbQ==
X-CSE-MsgGUID: i749Wd3lTuCijWIjV4L0/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="95258945"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="95258945"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 03:56:51 -0800
X-CSE-ConnectionGUID: M1zpoQTwTXmObavj27/nhw==
X-CSE-MsgGUID: TTF3gDQjQmKt2OYNvJp1gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="209413881"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2026 03:56:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F0B4C99; Thu, 15 Jan 2026 12:56:46 +0100 (CET)
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
Subject: [PATCH net-next v3 1/4] net: thunderbolt: Allow changing MAC address of the device
Date: Thu, 15 Jan 2026 12:56:43 +0100
Message-ID: <20260115115646.328898-2-mika.westerberg@linux.intel.com>
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

The MAC address we use is based on a suggestion in the USB4 Inter-domain
spec but it is not really used in the USB4NET protocol. It is more
targeted for the upper layers of the network stack. There is no reason
why it should not be changed by the userspace for example if needed for
bonding.

Reported-by: Ian MacDonald <ian@netstatz.com>
Closes: https://lore.kernel.org/netdev/CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com/
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index dcaa62377808..57b226afeb84 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1261,6 +1261,7 @@ static const struct net_device_ops tbnet_netdev_ops = {
 	.ndo_open = tbnet_open,
 	.ndo_stop = tbnet_stop,
 	.ndo_start_xmit = tbnet_start_xmit,
+	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_get_stats64 = tbnet_get_stats64,
 };
 
@@ -1281,6 +1282,9 @@ static void tbnet_generate_mac(struct net_device *dev)
 	hash = jhash2((u32 *)xd->local_uuid, 4, hash);
 	addr[5] = hash & 0xff;
 	eth_hw_addr_set(dev, addr);
+
+	/* Allow changing it if needed */
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 }
 
 static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
-- 
2.50.1


