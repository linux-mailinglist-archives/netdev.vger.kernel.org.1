Return-Path: <netdev+bounces-42749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD77D0097
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E191F23E88
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D0D3551C;
	Thu, 19 Oct 2023 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpcoSRRW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400F354E9
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780AC12F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736758; x=1729272758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1bUBFusw89T2F0gI4g1bkvJ2JvxL6dCiJizDonuc3o=;
  b=KpcoSRRWuza8gcoKEV/1rqrx9vgnGeiYcTIujbTlwT9Dc0yBjf+FymoA
   AYL6tPe3RYb9UdJqpYg/LhUeBzLuNHNWU2nYlJwc2fdu5smjn951eHfqy
   0FL9P5DbOOovrWp61jfYypxxFuHE3Pq+8WAsWWE0pzTl8xuCN90ml8ZK2
   eI41U6k6ZrzIRk2FPNoipM1Q6RFqoEve87WQg7FDrdUwjd0MepkfC4rJz
   DbG0ry01mJCo3NCB7i4D5bABaz0czworRSXCTbT+2fViwz/nVPpKThylI
   77ler49p4PsTZriWlknWrJaNfGD2pxooV/zKrgQzms7vs/38pDRrx91gs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183711"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183711"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722700"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722700"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:36 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 08/11] ice: make ice_get_pf_c827_idx static
Date: Thu, 19 Oct 2023 10:32:24 -0700
Message-ID: <20231019173227.3175575-9-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019173227.3175575-1-jacob.e.keller@intel.com>
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ice_get_pf_c827_idx function is only called inside of ice_ptp_hw.c, so
there is no reason to export it. Mark it static and remove the declaration
from ice_ptp_hw.h

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index de16cf14c4b2..6d573908de7a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -3564,7 +3564,7 @@ int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
  * * 0 - success
  * * negative - failure
  */
-int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx)
+static int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx)
 {
 	struct ice_aqc_get_link_topo cmd;
 	u8 node_part_number;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 18a993134826..36aeeef99ec0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -271,7 +271,6 @@ int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data);
 bool ice_is_pca9575_present(struct ice_hw *hw);
-int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
 ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num);
-- 
2.41.0


