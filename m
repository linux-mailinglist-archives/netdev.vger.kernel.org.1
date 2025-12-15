Return-Path: <netdev+bounces-244730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D39FCBDBFF
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26FA1305A3DE
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A932938B;
	Mon, 15 Dec 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqqUx3rD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BCC2BDC0A
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800679; cv=none; b=g9w/32QcUwAcG753q/BeGt5NUpL52/5kfZXrR1Y1eAZ6GPf2R5IxYbb90KVLT8YcbdWimfaqJzrBXzMrFifdKOcdaJfKW13uiVbzCz+GeRG4ODeQhhOH67oHo8u/M0fAjpeSxWrLFqeTz62BGmSMoJP+ZX7eiowcCBlw/862sYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800679; c=relaxed/simple;
	bh=4x3rxTdPKMdDQfKbJXC39mIXbE5u9GGrZhMysH1lItA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnSKoZj8WeqKLhbo4DF3v2ZP9uZ7gEARvb3258ZIBT1JZSAxoGBCYHP8R47qolxuQzjF4qy/0zlo6HjGllQo7YlDMisNV3sLqI452fK9zxNF3CaTra7zYjX906Vu2zig20CPmcq8twoirYCBPdCMZmnBuAqbj429AomZZ+SlmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqqUx3rD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765800677; x=1797336677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4x3rxTdPKMdDQfKbJXC39mIXbE5u9GGrZhMysH1lItA=;
  b=DqqUx3rDZQ4bRwFpwPsU47DiQVc+D4dWk6N9PivdhGruUKHI6e7ESyxy
   +YrZxIvmk3rQ8OpXE1clJ0zduz0MEg1S5exDytOzoe4C1ED9eYIpw4bZe
   d0tbN5rRENp0q76vmQN4FuqL6q8ksKQ5gZHmnUQYbMO9khA2kXfFwd2O2
   25ica3QaGni5u0F8hmHSkjtCUZWnTSQ1w7YIH3NZ0lh9eNlKKj2QkhgJs
   sFGeh1pMUY9m7aFBpGmAJCiUkc+VbGG6/KrH0lgttkBO0EvC3D9KxauNj
   t29RlawFq0cbXijBEtWQmbGpYlIl+U8cOBOGZn24nQIoYVFSQ3T6kF1N4
   Q==;
X-CSE-ConnectionGUID: vM8xrpWpS42yWl8o67/m9A==
X-CSE-MsgGUID: kZtGSnsDSqS5lhwJex7oqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78815382"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="78815382"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:11:13 -0800
X-CSE-ConnectionGUID: ark2N0WXQrStW5t2w7BHig==
X-CSE-MsgGUID: Ik3GP92aR7iD31lx5FO90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202214139"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 15 Dec 2025 04:11:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 77B959B; Mon, 15 Dec 2025 13:11:09 +0100 (CET)
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
Subject: [PATCH net-next v2 3/5] net: ethtool: Add define for SPEED_80000
Date: Mon, 15 Dec 2025 13:11:07 +0100
Message-ID: <20251215121109.4042218-4-mika.westerberg@linux.intel.com>
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

USB4 v2 link used in peer-to-peer networking is symmetric 80 Gbps so in
order to support reading this link speed, add it to ethtool.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/uapi/linux/ethtool.h | 1 +
 1 file changed, 1 insertion(+)

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


