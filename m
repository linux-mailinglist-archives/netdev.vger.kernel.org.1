Return-Path: <netdev+bounces-166343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF7A359C5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EB16D834
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1922D799;
	Fri, 14 Feb 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaebvQ2y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAD22D7BB;
	Fri, 14 Feb 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524140; cv=none; b=tKQ0fo+ayOFcFjuoSZvpR1tLmgchDUbfWVR1zXEuIRDUFmC97PjEHIKhraOgKMhXAfMJ8llV7bvoWQjnR4OJqXZ71z9EsR+S9se/IeYU5eSMuc3s5IMo2sOINYMI/rzHALLUvEgR/4y4Apzq0zEXDml0WwqZIQUyGtOHQdmTANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524140; c=relaxed/simple;
	bh=M2eCGgxLh5c6cE335IWn+xf91G0/3FE3wsl1N+36ZVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmfmhJLV6z/Gjt0g/UEbngYwkpkrVPLCHkrgT62SWd3XVIiR106TC3RzvJT8SfclK92UX1Rr/yI8XYXViehGNQIgfwXiiCp/VIMTwIVquX6mrt5cBXGEApp7Oha3hg5Fz1YEga+kctybkNdkS6cfUy+yM2bL79S1COfvjU/tyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaebvQ2y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524139; x=1771060139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M2eCGgxLh5c6cE335IWn+xf91G0/3FE3wsl1N+36ZVc=;
  b=UaebvQ2y/XpqpZ4aKvKMes7IXmOwINX+u3XesDIPDW1hyYGRIJLR1xtc
   ooUh2eXdIxvXE8L8ekI+O1nZg2KZkmkF0ZBcghLU35fnB+5+Dr8LhBrwM
   lTia30lLIvpm1cgF5iggqpn8qkv3w3fVESJZECNfpxJA2sH3yTQo1a6jB
   OQ5eITQEKxJAIAdHz5kglbZS4HE0a/olL8Z0HNBkVZCeb4NZmcRqi2g0C
   bNNI3UVVFknu1GsCxPs9eLaEQ9VHQg1Z0riNWLYmcOzzUHKGDAn3dTNg/
   OtB+VhlFy5FmAQ1uy4fA6hvEuSvvBaxvpkuUdPUdjehNVsRDhCr7ymeS7
   Q==;
X-CSE-ConnectionGUID: GQM9hxZgTbiPvRvYkT4yRg==
X-CSE-MsgGUID: LUutf25hRhqAqx96hr3aWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65617705"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="65617705"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:08:59 -0800
X-CSE-ConnectionGUID: osL7uY4NRsKOi/ixC+mtrw==
X-CSE-MsgGUID: yztXSPljToqFwWttdT9xRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="113145437"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 14 Feb 2025 01:08:56 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DF0C837B80;
	Fri, 14 Feb 2025 09:08:54 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: [PATCH iwl-next v4 1/6] ice: fix check for existing switch rule
Date: Fri, 14 Feb 2025 09:50:35 +0100
Message-ID: <20250214085215.2846063-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214085215.2846063-1-larysa.zaremba@intel.com>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>

In case the rule already exists and another VSI wants to subscribe to it
new VSI list is being created and both VSIs are moved to it.
Currently, the check for already existing VSI with the same rule is done
based on fdw_id.hw_vsi_id, which applies only to LOOKUP_RX flag.
Change it to vsi_handle. This is software VSI ID, but it can be applied
here, because vsi_map itself is also based on it.

Additionally change return status in case the VSI already exists in the
VSI map to "Already exists". Such case should be handled by the caller.

Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 4a91e0aaf0a5..9d9a7edd3618 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3146,7 +3146,7 @@ ice_add_update_vsi_list(struct ice_hw *hw,
 		u16 vsi_handle_arr[2];
 
 		/* A rule already exists with the new VSI being added */
-		if (cur_fltr->fwd_id.hw_vsi_id == new_fltr->fwd_id.hw_vsi_id)
+		if (cur_fltr->vsi_handle == new_fltr->vsi_handle)
 			return -EEXIST;
 
 		vsi_handle_arr[0] = cur_fltr->vsi_handle;
@@ -5978,7 +5978,7 @@ ice_adv_add_update_vsi_list(struct ice_hw *hw,
 
 		/* A rule already exists with the new VSI being added */
 		if (test_bit(vsi_handle, m_entry->vsi_list_info->vsi_map))
-			return 0;
+			return -EEXIST;
 
 		/* Update the previously created VSI list set with
 		 * the new VSI ID passed in
-- 
2.43.0


