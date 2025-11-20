Return-Path: <netdev+bounces-240479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92064C75670
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C58C35ED33
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD2936C0A4;
	Thu, 20 Nov 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8fWQRZo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8836A00C;
	Thu, 20 Nov 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656104; cv=none; b=KfVuiBuD7Nxro5Y8wgReWRIYx1pebrNfZJb3QmPczuHi8/v/cFan7DHh0KxjlJEmu9ASbi8dqsFPuDk2HLgYXGbJpR4CuiTvD1tteNft+SXywPrvOo9DffAVerMg5iamT3l90AIkOZEAWzk+fonSvEsWNyMzwxbiBKwKvQy5vdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656104; c=relaxed/simple;
	bh=yNUqfimTfWaJ6b/2VGkU2qDZPeNFpXbHnaViLdbaEHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLcopRBV9PDz00qQkTciQ57bgSY9PnNK+IEAI5KuRlKc1cRmApIicLRZzF7eQD1geAyhOiFqebIL+sYMw2mKVl9Je6jW77BullGBsuYKdLiYpdJ/purOmMv9z7eqzxRv5IpiLKJqTtbTH7BMDP4CKktXfbtfNcSdNry7YunOsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8fWQRZo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763656103; x=1795192103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yNUqfimTfWaJ6b/2VGkU2qDZPeNFpXbHnaViLdbaEHo=;
  b=h8fWQRZorWm3/7w+A11PBr3GPyH+FsXjf/FXSsiAbAb5Lv643QIEhUr7
   qsgeGhapWhzat/kj0j7aE/T3YY5Nli80T4gdYUQvhK8Bh6rMSrkrJFSsh
   pI4fgN/ze4MCWBpuLCd1DUOFbGLK3Gk2ICBcNruJdDKhf2/BzxHUCBQ34
   OW5jbEemFi12AXnUzgNThZK3sue7p0er0YXAJduVLYbX2R7QYrtXUaIZo
   24tvz9lRTzrdCRZlgjugzLJVHfus1D4DQmA1fesS74xheDUcs/ZKcynVM
   8fJyVP6v3OJToRzKtBZXUc5X8eVrrMY6jR1QS0aM4vVjpTO+Ykb7r8NLp
   A==;
X-CSE-ConnectionGUID: V+Wu2bVfQym/3XIvflX13w==
X-CSE-MsgGUID: B06Dob1dTCG+Y9P4HyejSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69599295"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="69599295"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:28:22 -0800
X-CSE-ConnectionGUID: CWRQ7mu5QoalPH489aGJlg==
X-CSE-MsgGUID: 1MwQ0+q8QB6T/ylMquaRkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191531288"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2025 08:28:21 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com
Subject: [PATCH iwl-next 3/8] ice: do not check for zero mac when creating mac filters
Date: Thu, 20 Nov 2025 17:28:08 +0100
Message-ID: <20251120162813.37942-4-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120162813.37942-1-jakub.slepecki@intel.com>
References: <20251120162813.37942-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

A zero MAC address was considered a special case while creating a new
MAC filter.  There is no particular reason for that other than the fact
that the union containing it was assumed to be zeroed out.  Now, address
is pulled out of the union by ice_fltr_mac_address which checks all of
the previously assumed zero-address cases and returns an error if they
are hit.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 0275e2910c6b..04e5d653efce 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3648,7 +3648,7 @@ int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 		u16 hw_vsi_id;
 
 		err = ice_fltr_mac_address(addr, &m_list_itr->fltr_info);
-		if (err || is_zero_ether_addr(addr))
+		if (err)
 			return -EINVAL;
 		m_list_itr->fltr_info.flag = ICE_FLTR_TX;
 		vsi_handle = m_list_itr->fltr_info.vsi_handle;
-- 
2.43.0


