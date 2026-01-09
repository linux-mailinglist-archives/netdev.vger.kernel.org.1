Return-Path: <netdev+bounces-248486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C75D09A87
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F39D830501C8
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1935B146;
	Fri,  9 Jan 2026 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPNKHFtM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCC35A933
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961574; cv=none; b=S5XOsHAsalx3ZbObIWUdVMUVz0d0p0rhO5tTK6SO7QFibMZxs8J5yCKN3FvOxt2gxx7cmr/NqYVqUj+qo84p4ng+aUFjidqPr9XXN4Yss75LtytKxqYf5P4lVMbOj7WPhtZvjf5cdOac6A42cCxnBBfhUE16s88IIpdO8St3TCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961574; c=relaxed/simple;
	bh=JeNVMxLNQksaOSVxvp7aogxutMh6uMS78QpCd3Tk+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7csfvCs+uM3ZK7zJH6/mcZKmkC9t2LnJh+hY2uUQIOf2Xfg9ytWvB16c55mmDqBZqYbIQGhqDoAJ5HqWJQgJQtrHZxDIAyB2liQvb5w6PxNOsGzectQPyWztBbMs1Lq/AVA9W+xMGgALCLzbb65rYQD+Ef1mPVzbFUOu5ci2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPNKHFtM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767961573; x=1799497573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JeNVMxLNQksaOSVxvp7aogxutMh6uMS78QpCd3Tk+Mk=;
  b=GPNKHFtMYCaQnRGtdS8yEy7anrZCSfNT+IEP3C6sWV3ymlrRUseWDdvM
   5Bi717MIVQXkipsU261yPhjqPIVVO3Wutrq7thqMFm/Pc2KFBTfN3QR5b
   +I1iQrO2Po1kktBSGURtuzDpiMEyil0E+6P+HJPgm6FsgINEeAl1lCSiF
   eRt4Pnucg0HT24bLaYrwnQHcdq+gSy4H6aZCMdK494WX5hoKbw/F3sobR
   7F15yOVRv+pW2qav1lHLf0EOViMkN4y1RCHIghsMa39C5YHwjNRNWqmSV
   KsyxkBsrxcZPvgYUQwupMWN06M7bnW4q0zFhJLr24/rnFhL/t87nqk3GI
   g==;
X-CSE-ConnectionGUID: gONIepJrTPy3Hws6DjZ/qg==
X-CSE-MsgGUID: eIvb3exdQ4C2R4S/e5q8dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="79981335"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="79981335"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 04:26:11 -0800
X-CSE-ConnectionGUID: BHoYYmCFSsSsI6aOmUKxuA==
X-CSE-MsgGUID: 0e7xFy62SHW3dgV+jrj6Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="208516494"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 09 Jan 2026 04:26:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id DC1CD99; Fri, 09 Jan 2026 13:26:06 +0100 (CET)
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
Subject: [PATCH RESEND net-next v2 1/5] net: thunderbolt: Allow changing MAC address of the device
Date: Fri,  9 Jan 2026 13:26:02 +0100
Message-ID: <20260109122606.3586895-2-mika.westerberg@linux.intel.com>
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


