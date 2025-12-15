Return-Path: <netdev+bounces-244729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A54CBDB87
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 027403002FC4
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7662BDC00;
	Mon, 15 Dec 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwvmKZEX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45A24A067
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800677; cv=none; b=pSiIi8/YVws1zZiDZmjL0v6+7WyTbuf5VLl/Uq0KFkuLwGSVJrepbQ3W107jAdf4Q8MhuvoDlGc6u7hxabSNqn0svDnd/YyYuOt+iBKTYmugq4qUu18FXeralMIKpAGbIANGT4r/POdSfR9gUOI6TxBaKogbLBoHZyzFqEEgCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800677; c=relaxed/simple;
	bh=JeNVMxLNQksaOSVxvp7aogxutMh6uMS78QpCd3Tk+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DecgbAOTOV0+HBguPiEtQ3bWPZ8RcIQIZhQGet8z0L4Mk2aXh/CeJmfajuVyBGEbs+Uf/kfACEmO/Q9Xi3FJD9TNlG/3qkLKgtLg8pmV8+2nKoHvvHBJyq0aMnOR3LJQOuzvKRn1/5azJrbaQjSFaL+PLWWnzlTJP7DFCKan9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwvmKZEX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765800676; x=1797336676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JeNVMxLNQksaOSVxvp7aogxutMh6uMS78QpCd3Tk+Mk=;
  b=iwvmKZEXFLeBEcQbS3LkmLOKVMuepVl7TRjfiNQHKWk0Ip0tSWY/pYM3
   jCKh3JgSNqBy+2cifB6jXNWv+/kYZ35e9k/Ci8vPbu8AiwBH5xyQ3fhTP
   nMRKItaSJjlo/I1mpFZKV+pYC6k0YuHK/1YUMcuoKuouLo18fBpfGljSh
   rjM82VnN38kr5lLMv8Y1OSxJjNacjFhAipKg17X5byvDnFmXlyw6Atu7T
   bS2w4zmNw5EPn97ACkevW02D8XdCesh6TqqXO10hdWGMDCKKAFBF66tfu
   8ZOC3HOYe3oeYrATtbfUzI8V4YBsoc6ZtGvFs/5aNuXj1rNxwGlBKvZaY
   Q==;
X-CSE-ConnectionGUID: dge57whJTpSvJ2TLo3Mrlg==
X-CSE-MsgGUID: xEmxOf0oSKCLmZf6ODaSCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78815362"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="78815362"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:11:13 -0800
X-CSE-ConnectionGUID: OGV+SUJxTIS4qKWyCgP6TA==
X-CSE-MsgGUID: vl37yJHqQgis4VyuzbxnKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202214140"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 15 Dec 2025 04:11:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7110198; Mon, 15 Dec 2025 13:11:09 +0100 (CET)
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
Subject: [PATCH net-next v2 1/5] net: thunderbolt: Allow changing MAC address of the device
Date: Mon, 15 Dec 2025 13:11:05 +0100
Message-ID: <20251215121109.4042218-2-mika.westerberg@linux.intel.com>
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

The MAC address we use is based on a suggestion in the USB4 Inter-domain
spec but it is not really used in the USB4NET protocol. It is more
targeted for the upper layers of the network stack. There is no reason
why it should not be changed by the userspace for example if needed for
bonding.

Reported-by: Ian MacDonald <ian@netstatz.com>
Closes: https://lore.kernel.org/netdev/CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com/
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


