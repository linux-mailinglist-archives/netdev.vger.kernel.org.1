Return-Path: <netdev+bounces-244731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9018BCBDC04
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 617F1305C4D2
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E732F756;
	Mon, 15 Dec 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6YQJWAl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF0C2E5B32
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800680; cv=none; b=bohUFy2lUjYyKJm8NkYnc3fgJujMH/JrGkMsbSlThH1PKKGVEdYSxboM7CvcDFjF1D47UeekutHmUeY+oJ+003oZWr3LeXriaUpCqoJ4Icrd9J9C0GdZp3EoOsp6opimsEO2ZddomS2wyKUCWPNJKruYpTARm8dANmnua5G6tsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800680; c=relaxed/simple;
	bh=d7iob4gGau0WK+LVToF1McoKKdAcKi6dxyGl5gt9KNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtGeOt3/ddg6KBNMar6x2EH/ccKd2a5bXG2jG4FWi1OSyf3Ztz/SkrACxpk4pu5HtFZ/NrTM+1nsoVMZ43dGvooWfZne4nU5eAL7+DTEwZikhrqa0aRthXafHlu6CEK9ni83okYcVYLjebLhylIUn/bXZqcVe2xXD4GJz3xKrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6YQJWAl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765800678; x=1797336678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d7iob4gGau0WK+LVToF1McoKKdAcKi6dxyGl5gt9KNk=;
  b=Z6YQJWAlzBuUrEp+oLQSXaHIq1IIRx2ahXNI8VKQpcF7tcMIlSAdP0T0
   mCRbxpDJPEFp+EkHvT3SX4ym5l2NKEETjixRXrYksi79we/V7drIuurKw
   ZDcP61FnmR87KrpuNhjUPCuLwQwBV7nX99zKwzK6c49ogT3nbUAMUwtRy
   BB7p30oa0jZlo3bD96ajQWVz/o5FiBeZwFbHT8X6jB6plvbdN/JNf2fxs
   r5KnkeXcOj+TjaRuOrpfUiwIL0J45lnx+3DilJ+wA3CW7BDLmwaZfLdog
   NsF/VBiiUC++VxSuXKwUFF4bOBbOFW3TNL5gH0YBwM4ux4z+OMfCmrrk0
   A==;
X-CSE-ConnectionGUID: a6HXQjUyTZyE7/s/2ETNQw==
X-CSE-MsgGUID: txRHE61IRNmd5o7l2fthjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78815372"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="78815372"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:11:13 -0800
X-CSE-ConnectionGUID: bzS/E5SXRHWDsPXdoHV+zA==
X-CSE-MsgGUID: W7Ooh8qpQi+R8Yd3A9ucbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202214141"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 15 Dec 2025 04:11:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6EFF993; Mon, 15 Dec 2025 13:11:09 +0100 (CET)
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
Subject: [PATCH net-next v2 0/5] net: thunderbolt: Various improvements
Date: Mon, 15 Dec 2025 13:11:04 +0100
Message-ID: <20251215121109.4042218-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


