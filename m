Return-Path: <netdev+bounces-212082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C04B1DC8A
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 19:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2D218A634A
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E6527465A;
	Thu,  7 Aug 2025 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeVXaP3m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F252741C0
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588143; cv=none; b=PTW9JspaGDK98GEIO1AgoXlTy6OysvSyEPpismHTywbvHyYVv+8n0hTcmyTTHO2adSAzQvBa9wvo3u7HX36bFuG59RrbHJxWzrR26Wsv+sf8oDt0GmFD1YX95WItFQre6WIA6SDndBnu+vga3uAQDsyFVCLVBxvSud6wbj/UWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588143; c=relaxed/simple;
	bh=Ngx5yfB0xUuTqpRJe50nUtLyB9vjVE7Mtrld1SDMdcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjeVx0yqRVN+LSZbmqyrW4VfFW6rq+kQ96ieZRk2ezkvjKiP8W+aDhpPMa7pMQqFu9lituZ2Xufd+xERM1OkfLa/AkH0kbdPALqlbrS+mJfDJM//rwG6ZuqxrCrPofLFINdgvHkHCb1CVO87H32CVH1KW9IuHKn8y1dDd11JoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeVXaP3m; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754588142; x=1786124142;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ngx5yfB0xUuTqpRJe50nUtLyB9vjVE7Mtrld1SDMdcE=;
  b=JeVXaP3mRbCibiaP/ku5rW7oPJmuhuu7A+sF+n8GsW2dhpkJLKa4Y34Y
   Dz7G4GPRKggUAd+UsOvEfXJbz0shJSse2YVcrO5t+BgKUZoDczwAsBpBk
   cH26lBJxdRDLeVsOlHcNS9j6zwJ1j1olPZHTFuyk8JtOsSv4zePzs1lRv
   McG2wpLf/yScfJp7vQrSQbdbPbLK6bx0QNuBY2QbuHsQ+XJJKBk3fBQwj
   QfMlTxgGmETqUnLO0I+6B+wloregpuzpudLvkqPkbJWKUYGFBN+7p0wuc
   2rUskkCyJPLLCAQuTXbN205nsigYFFJMUe1nlwIB7lpnaup28XFlHlbuh
   A==;
X-CSE-ConnectionGUID: ELqJKA41TCG6ASssehJ+PA==
X-CSE-MsgGUID: EHQYTyDBQ6avyq8YGvEZ3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74511378"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="74511378"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:35:37 -0700
X-CSE-ConnectionGUID: DQ2CgVPQSUendbN97tedtQ==
X-CSE-MsgGUID: mMAwHP99QQCZAOfnWx3RxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164787193"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:35:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 07 Aug 2025 10:35:27 -0700
Subject: [PATCH iwl-net 2/2] ice: fix NULL access of tx->in_use in
 ice_ll_ts_intr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-jk-ice-fix-tx-tstamp-race-v1-2-730fe20bec11@intel.com>
References: <20250807-jk-ice-fix-tx-tstamp-race-v1-0-730fe20bec11@intel.com>
In-Reply-To: <20250807-jk-ice-fix-tx-tstamp-race-v1-0-730fe20bec11@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-c61db
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Ngx5yfB0xUuTqpRJe50nUtLyB9vjVE7Mtrld1SDMdcE=;
 b=kA0DAAoWapZdPm8PKOgByyZiAGiU4+iiTcR5VdKxfU6CwpwrEAZz7t2jwg7qpJ0OurfFW8EEx
 oh1BAAWCgAdFiEEIEBUqdczkFYq7EMeapZdPm8PKOgFAmiU4+gACgkQapZdPm8PKOiolQEAq3Gi
 XzhpPn1ZJSH/atNAqTY1nKT/ztrYJItMEx6LMRUBANnVbMdWaooj8oa0dC6k3EtBLZ+zJczKHRn
 T3Z+N3G0K
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

Recent versions of the E810 firmware have support for an extra interrupt to
handle report of the "low latency" Tx timestamps coming from the
specialized low latency firmware interface. Instead of polling the
registers, software can wait until the low latency interrupt is fired.

This logic makes use of the Tx timestamp tracking structure, ice_ptp_tx, as
it uses the same "ready" bitmap to track which Tx timestamps.

Unfortunately, the ice_ll_ts_intr() function does not check if the
tracker is initialized before its first access. This results in NULL
dereference or use-after-free bugs similar to the issues fixed in the
ice_ptp_ts_irq() function.

Fix this by only checking the in_use bitmap (and other fields) if the
tracker is marked as initialized. The reset flow will clear the init field
under lock before it tears the tracker down, thus preventing any
use-after-free or NULL access.

Fixes: 82e71b226e0e ("ice: Enable SW interrupt from FW for LL TS")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8e0b06c1e02b..7b002127e40d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3176,12 +3176,14 @@ static irqreturn_t ice_ll_ts_intr(int __always_unused irq, void *data)
 	hw = &pf->hw;
 	tx = &pf->ptp.port.tx;
 	spin_lock_irqsave(&tx->lock, flags);
-	ice_ptp_complete_tx_single_tstamp(tx);
+	if (tx->init) {
+		ice_ptp_complete_tx_single_tstamp(tx);
 
-	idx = find_next_bit_wrap(tx->in_use, tx->len,
-				 tx->last_ll_ts_idx_read + 1);
-	if (idx != tx->len)
-		ice_ptp_req_tx_single_tstamp(tx, idx);
+		idx = find_next_bit_wrap(tx->in_use, tx->len,
+					 tx->last_ll_ts_idx_read + 1);
+		if (idx != tx->len)
+			ice_ptp_req_tx_single_tstamp(tx, idx);
+	}
 	spin_unlock_irqrestore(&tx->lock, flags);
 
 	val = GLINT_DYN_CTL_INTENA_M | GLINT_DYN_CTL_CLEARPBA_M |

-- 
2.50.1


