Return-Path: <netdev+bounces-148724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152549E3020
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E82AB26989
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA2720B1E6;
	Tue,  3 Dec 2024 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTnOygoU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B05205E2F
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270113; cv=none; b=oyvdEkC80ZlLbiCiZV3ubSEbcYjvkGf9jD/u3MgVfvAmucyNfy4evanMs2INdS1F4pPlPiOidS7nRM8wlC+z+ze3F3ySPwe7CHpzcbRjLneZLA5f15zk/4MAaQfQyxT+sKHmE8BBtSWXNs59mVLPg9AoCMjA6u9ZqLlQVmNo67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270113; c=relaxed/simple;
	bh=jzVsU+tttxm8IfUHHUpvkT2TCP2ifIbrzkPvui9Agp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tM3ZgI8rwMjYtya5BYVJ6J8Wkcw2gXt3KQIa9M9p3n9UlB7kRPirJeQhwoxRG5IQzRFhUpXnXtqdvOLoMUMH0mCNYC70uNIezlI6mJVrTX+D2R2Own95Md2zeGxwQaBXVliYowzBUqXElPJeD86xNTBjfTdq4ICAzG+Ruox1Gfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTnOygoU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733270112; x=1764806112;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jzVsU+tttxm8IfUHHUpvkT2TCP2ifIbrzkPvui9Agp8=;
  b=CTnOygoUjt/b/1dsMUB1ncaY1Yb+cWV/20oBVdaecZMcJEQYPby/AEvZ
   1MyYGYzBbMNxDdQpFFuLJnApEE/T892vpiTXlrS+3imQLMyKhrgz66EuT
   QZlIxwQLpNQWMO0/iaPYwvtvZmBh2VPDp9waK8LcF0TT9ek6bqXQeKnXT
   YFn5YTpxhKMGB48yEKKYLgwaXjtv4+wS7kUYNtmD6r9hDbXmkyMhQBwxn
   OD10YZ6K49Et9JLwAKc0NsxXYdnEvtcuqzC6FicNjsg3Fujd61ogMbjaB
   YbJCYDpC/emb/dR1nk4BJ3Ckk3C2e9zja3gcXNzzubxiLxZO2CruhWgP1
   A==;
X-CSE-ConnectionGUID: KUqccHmFSxmiapNVU/VJNA==
X-CSE-MsgGUID: VJmOUltqSQ+4eburyc/Pjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58918429"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="58918429"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:09 -0800
X-CSE-ConnectionGUID: QBevreATSYmYdPQIq9RRzA==
X-CSE-MsgGUID: w2KC6j7RQTq0fnyWpusdmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93679045"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:08 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 03 Dec 2024 15:53:51 -0800
Subject: [PATCH net-next v8 05/10] ice: remove int_q_state from
 ice_tlan_ctx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-packing-pack-fields-and-ice-implementation-v8-5-2ed68edfe583@intel.com>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
In-Reply-To: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
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


