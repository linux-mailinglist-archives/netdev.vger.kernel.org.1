Return-Path: <netdev+bounces-113842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA3E94011A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713751F230C9
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD918FC87;
	Mon, 29 Jul 2024 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnnqL+3B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC118FC68
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292487; cv=none; b=lWb71H+mTWrPZ+xBqp8q3Os9r9+8h2GbcGIlCCLbheS9acdE79QrZGFPtwezR3xEdIXL0uVwVfzyERWjjTHOoIrKfolWLJ7nfMyj7otxzAJU2R106lNUVB5wAsvdjr7psyIyYaaSUqknnwoiatcgkUDC46PHuLuajBPaW8mUGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292487; c=relaxed/simple;
	bh=BH4L0+tMMWCgvCrdfLAm4J6UMqouKKpq+c9ei35AcDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWaxnZayyiXqbhhtqd2JhlpDrncf+pkgEdChW0HByr7bJay9u1fqXcnu6DZJy6cRIWw4iu4MAgXm8PXUZKtbHIcdcnAHvyDzKWI2ZRk4alaG9S1SRF6/Zdwar7G/uJ2E1ohXxEBzKf2xmEYEbw3HM7s3MX9sr8zczmi9YhKW5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnnqL+3B; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722292486; x=1753828486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BH4L0+tMMWCgvCrdfLAm4J6UMqouKKpq+c9ei35AcDA=;
  b=NnnqL+3B5MhO9GCLJmdJG+U12YfX4Pf/SNtoDKKDbjMK4htx1+moHc5h
   QixBsp9MyGp1CDV6wmv5hsxjvJheYICdhU6yXtfWH04tI3MgG41tpp0lV
   DOFyfm5tacDP7Xt6cqPuIVnLcuBaYdOTRyqKTgDPO5rRkVtrDRH5CFqa4
   f5Y5HR5Lu/yGIK6+zCLa7G+5Z2SH+uIkSq4Z9aThfCViBtwHfzC3RgU5r
   TY50FQLtSM60Hbr8O72vRPiP16YTC82P8aPhMq53NV4Ww7Po5mfrAhOoa
   Jlzb0I1ke98tASNzstdqBBQ0Dq9a2yB2W2ISTIQiLyEE6roE8JxC6/jND
   A==;
X-CSE-ConnectionGUID: MYDIMxfASAGk0QB9wedpAg==
X-CSE-MsgGUID: fOwo2u+KQkGuRbW3R95Utw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20216833"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="20216833"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 15:34:41 -0700
X-CSE-ConnectionGUID: PM7G7gy3Sry21TeckCdHBQ==
X-CSE-MsgGUID: 2OLlh9oAQMOMXuPYnUiFww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="77344583"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 15:34:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 10/15] ice: don't set target VSI for subfunction
Date: Mon, 29 Jul 2024 15:34:25 -0700
Message-ID: <20240729223431.681842-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
References: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Add check for subfunction before setting target VSI. It is needed for PF
in switchdev mode but not for subfunction (even in switchdev mode).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8bb743f78fcb..fe96af89509b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2405,7 +2405,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 					ICE_TXD_CTX_QW1_CMD_S);
 
 	ice_tstamp(tx_ring, skb, first, &offload);
-	if (ice_is_switchdev_running(vsi->back))
+	if (ice_is_switchdev_running(vsi->back) && vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
-- 
2.42.0


