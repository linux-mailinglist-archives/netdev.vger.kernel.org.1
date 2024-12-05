Return-Path: <netdev+bounces-149197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E809E4BC0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0832D188145D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CB1130A7D;
	Thu,  5 Dec 2024 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/m1JtV5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959ED78C6D
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361784; cv=none; b=ZVPYAW2Oy/oTnyg9kzw8HJfJaw2hOyzBL2VdC9b15xVQDyahZzOeq/VZNgGm3mdnBsD+YN0AdClzsbNFGM6c5qGoLgbfh9jrtDtYfugAbOKewuq6XKlHQapDd9qCB55YrJdtzL9yfm2+5L9EC+JBcTckHKJ+lFNmxfnvPQ4/Ne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361784; c=relaxed/simple;
	bh=jzVsU+tttxm8IfUHHUpvkT2TCP2ifIbrzkPvui9Agp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sz7x9e7H3wBTBbEFbV/JFH/40bnecr28ZEire8G8tjYYbvpxaXXA0t3OCo4xlweRMixrRva8n/zQHjcQY2CyKAogf1qZmQVGrF0jyAfqljilkpUol1K5hxg8frGGdGibQyC7tgIuI89tUqa2YqL1053iJGe957wXOfc3V+fZLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/m1JtV5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733361783; x=1764897783;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jzVsU+tttxm8IfUHHUpvkT2TCP2ifIbrzkPvui9Agp8=;
  b=c/m1JtV5zSuC+CuoQFGcdd+qPZXF0JVWiv8UtXU2QF+1k/Qjscgti7xu
   rLWfEIqn+MbzItk06BTIKnEO0sk8gdAL4cem1nDDkmdJ+BEsUOzjHAe2F
   dXW0jyQ6/2kJHrZvMPWykqi1r+N9GNFLscee1D/6VDaSGF3mOCiD0MvGW
   WKy8Ksr2qAh972IyMl6jnkmxDnvCPCT+PnyKMDareAY3ST+YYNKAaMVkQ
   jXpxABy2A4GLGgWlQe4HHjO9/t6+4ncUXuhzICV1/H9IGK0LYpvz5E/Ok
   z1leRZ6V8WR8HD4PHjGAfNKV9AyJkud+mq8jsRo2q00UNxBS8F9VNAGKH
   w==;
X-CSE-ConnectionGUID: Hpbwuiy+T+edX3K5FJ7hYw==
X-CSE-MsgGUID: CVUYsk+lSCOrb74qBuU0hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32993841"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="32993841"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:00 -0800
X-CSE-ConnectionGUID: rRTC2YfzR/+g2pFAr6oh7A==
X-CSE-MsgGUID: 7P4G5vf9RWm8GS7+WOE1qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98905974"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:00 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 04 Dec 2024 17:22:51 -0800
Subject: [PATCH net-next v9 05/10] ice: remove int_q_state from
 ice_tlan_ctx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-packing-pack-fields-and-ice-implementation-v9-5-81c8f2bd7323@intel.com>
References: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
In-Reply-To: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The int_q_state field of the ice_tlan_ctx structure represents the internal
queue state. However, we never actually need to assign this or read this
during normal operation. In fact, trying to unpack it would not be possible
as it is larger than a u64. Remove this field from the ice_tlan_ctx
structure, and remove its packing field from the ice_tlan_ctx_info array.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 1 -
 drivers/net/ethernet/intel/ice/ice_common.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 611577ebc29d8250c8cce85f58f3477ff3b51a66..0e8ed8c226e68988664d64c1fd3297cee32af020 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -590,7 +590,6 @@ struct ice_tlan_ctx {
 	u8 drop_ena;
 	u8 cache_prof_idx;
 	u8 pkt_shaper_prof_idx;
-	u8 int_q_state;	/* width not needed - internal - DO NOT WRITE!!! */
 };
 
 #endif /* _ICE_LAN_TX_RX_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b22e71dc59d4e4ec0efea96e5afd812859a98bdd..0f5a80269a7be0a302d4229a42bb8bbfc500905a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1467,7 +1467,6 @@ const struct ice_ctx_ele ice_tlan_ctx_info[] = {
 	ICE_CTX_STORE(ice_tlan_ctx, drop_ena,			1,	165),
 	ICE_CTX_STORE(ice_tlan_ctx, cache_prof_idx,		2,	166),
 	ICE_CTX_STORE(ice_tlan_ctx, pkt_shaper_prof_idx,	3,	168),
-	ICE_CTX_STORE(ice_tlan_ctx, int_q_state,		122,	171),
 	{ 0 }
 };
 

-- 
2.47.0.265.g4ca455297942


