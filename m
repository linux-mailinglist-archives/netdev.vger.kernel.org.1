Return-Path: <netdev+bounces-232700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C3C081DF
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D6364F1D76
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3E2FBDE9;
	Fri, 24 Oct 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MisALXzz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707B2FAC06
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338876; cv=none; b=Q2GvYgTSEWtK5xbydTzR6rP566kmhaLDd+1qsrnspcIh+tspNvPMvtCW4PaEj7f7kFD2XulKtjCrAXGGb6Wi+FB1lht2yYO9l+EFKc2dlFtW96M5uDuBL3lyl/OHKGNp3TLUeBVh3QC8egmdUlaCxmitUtwocnAi7elpoxbIoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338876; c=relaxed/simple;
	bh=/MWFgmcE+INYPPEeFcsFF31G/JQ7SAmsuLVWj0ncEEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjfFmNFMXMuxrtYrf55cVJ7vaekiHF1OmDb2d4kad4G7m/YZ2smAlStpfxX7ZYCN2xy8CR5/hRUgHlOqiV6XiQbYlsp7FDtuieIhSoOunh9SCMjCm0KLaQXlmZu4shkFxipFnLitV2aH6WGalVz3HiCBr1YxwOE5Mgq1oA8DG7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MisALXzz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338874; x=1792874874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/MWFgmcE+INYPPEeFcsFF31G/JQ7SAmsuLVWj0ncEEg=;
  b=MisALXzzlf8euQMmkJhEfnvRj0abiDPVSdayw3FVGwZNDxmWfuvXOPfo
   8w+cs+u9KSF7RO2u5QRhBj5qRSEG8Ullv1SexOKtrjOE1f/kVUdWyMdjG
   oPkWspflFxQVYRr5l+xbKwzQcSxIsQ3SzDG6iEvuyPSW8+tcqQpATKEts
   nNPi+oXDJM93AyPZWSA0OWDelEPT34KxeFmeYZehQ08dmTd9bZ3mPfeqI
   Wm7DqWmCXo54l9MIQC3mO6ckZ0vQTJwx1UVIOcLf61DDqWB1xSOphXAEm
   FLKFbjYH4Uc6hldkLuWg+cCVivkzQvJCvCom1F8/hO97Fb4iD6vk+Hd7M
   g==;
X-CSE-ConnectionGUID: k2ycrk91SA6qJSeqjIT/4g==
X-CSE-MsgGUID: Rxg8DBe+SYm+e0SipGMsPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139503"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139503"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:53 -0700
X-CSE-ConnectionGUID: Y3xtWTPLTkOLg7nzMk3fQg==
X-CSE-MsgGUID: vFxihc5VR5u9oAivnYqBmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821514"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 13:47:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 1/9] ice: enforce RTNL assumption of queue NAPI manipulation
Date: Fri, 24 Oct 2025 13:47:36 -0700
Message-ID: <20251024204746.3092277-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
References: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Instead of making assumptions in comments move them into code.
Be also more precise, RTNL must be locked only when there is
NAPI, and we have VSIs w/o NAPI that call ice_vsi_clear_napi_queues()
during rmmod.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4479c824561e..69cb0381c460 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2769,7 +2769,6 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
  * @vsi: VSI pointer
  *
  * Associate queue[s] with napi for all vectors.
- * The caller must hold rtnl_lock.
  */
 void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 {
@@ -2779,6 +2778,7 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 	if (!netdev)
 		return;
 
+	ASSERT_RTNL();
 	ice_for_each_rxq(vsi, q_idx)
 		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
 				     &vsi->rx_rings[q_idx]->q_vector->napi);
@@ -2799,7 +2799,6 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
  * @vsi: VSI pointer
  *
  * Clear the association between all VSI queues queue[s] and napi.
- * The caller must hold rtnl_lock.
  */
 void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
 {
@@ -2809,6 +2808,7 @@ void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
 	if (!netdev)
 		return;
 
+	ASSERT_RTNL();
 	/* Clear the NAPI's interrupt number */
 	ice_for_each_q_vector(vsi, v_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
-- 
2.47.1


