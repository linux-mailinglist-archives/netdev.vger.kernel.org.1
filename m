Return-Path: <netdev+bounces-212081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F2EB1DC89
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FD4727EF1
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15CE27464A;
	Thu,  7 Aug 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coLXng1a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85A273D85
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588142; cv=none; b=pmhbekFmp3LDyS5Z6dUhwwalSC3BvdahZeTB8hJz0vzgVZNTpoKwskqrYBlpvuqoJfxMAqTGRJQX2Z8kcKF1RxCNVJQWQbBZv5FVH9rLAWzoF18qnSG3hMHyTvXtZ3Vnp6kQxHLP80nOfEYGnVNe6T7girfsrpKleDOdo7sEyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588142; c=relaxed/simple;
	bh=NN+rY843FoJMfj1Bd86ftR8Vv14RG+hPN+sQ9HvfH2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vo+HCaNNhdao17zBFH7T50MExnFozU+Cw2XTLt05tkNFyOXPVqaTb0Fa/n7/f5Ti6qR2ckFGybyuqNIddiHfXTy0yq20e7jfuBWvL+qQO+v/MEVngQ971iDpa9XimIVufXtJsmQ6L0SeG4QPzBTv/a4oM8yIQ3iB58Y1w7MUVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coLXng1a; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754588141; x=1786124141;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NN+rY843FoJMfj1Bd86ftR8Vv14RG+hPN+sQ9HvfH2I=;
  b=coLXng1aovc6BdegIecHscwS4QLJ3rfcHGfS7sqKYAwM4lNei5PALOOU
   0XAvl/OP5iTRNvJyytr3iii9k1gCOIUWJ8vxx/k+kd2m8RVqeHIBf4dA9
   n0t1VsfVED/YbSPP/fPBhHyH9hSEkTIcKdOwh3jw2wKZ0ZmWN1+1XYWST
   9Xavp1p/zeELr9jt+Z40RI7UiqoYROPEj5CxPE5ZoJoAiSkdMSkxoRWyU
   YjhV+t308iNydujCbB8sy26bDPlxHwt8Y9EXiptB4rWNGvVfgrM7x+t1G
   CmFAAagmeNRiyvi1Wuwv36HncRv9qqu/jQ5C+kmtsWCyHSM1jj7rp5SjT
   g==;
X-CSE-ConnectionGUID: GA1xpcjrRlaS/ig+xmw+yQ==
X-CSE-MsgGUID: vWh7aAxCS7mAsw2btrc04g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74511376"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="74511376"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:35:37 -0700
X-CSE-ConnectionGUID: sLBBZA00Tm2TOSWUfQ8vRQ==
X-CSE-MsgGUID: mF4LqTGDQXOuXpJjRyWLaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164787191"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:35:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 07 Aug 2025 10:35:26 -0700
Subject: [PATCH iwl-net 1/2] ice: fix NULL access of tx->in_use in
 ice_ptp_ts_irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-jk-ice-fix-tx-tstamp-race-v1-1-730fe20bec11@intel.com>
References: <20250807-jk-ice-fix-tx-tstamp-race-v1-0-730fe20bec11@intel.com>
In-Reply-To: <20250807-jk-ice-fix-tx-tstamp-race-v1-0-730fe20bec11@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-c61db
X-Developer-Signature: v=1; a=openpgp-sha256; l=2390;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=NN+rY843FoJMfj1Bd86ftR8Vv14RG+hPN+sQ9HvfH2I=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowpj1/8WecakXL526pXX1m83Cf1Bknafwh4Y9Y0Idc6Y
 1XAlnlXOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZhI31mGfxZaJ5iffZaX2SHL
 d9fS7NTDGSo3Phrz2QrP5DINqVM07GD4K/qRic2vaPWvZSZbAvL/2mVsVJliwdNrOOHlKofKxgV
 KfAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The E810 device has support for a "low latency" firmware interface to
access and read the Tx timestamps. This interface does not use the standard
Tx timestamp logic, due to the latency overhead of proxying sideband
command requests over the firmware AdminQ.

The logic still makes use of the Tx timestamp tracking structure,
ice_ptp_tx, as it uses the same "ready" bitmap to track which Tx
timestamps.

Unfortunately, the ice_ptp_ts_irq() function does not check if the tracker
is initialized before its first access. This results in NULL dereference or
use-after-free bugs similar to the following:

[245977.278756] BUG: kernel NULL pointer dereference, address: 0000000000000000
[245977.278774] RIP: 0010:_find_first_bit+0x19/0x40
[245977.278796] Call Trace:
[245977.278809]  ? ice_misc_intr+0x364/0x380 [ice]

This can occur if a Tx timestamp interrupt races with the driver reset
logic.

Fix this by only checking the in_use bitmap (and other fields) if the
tracker is marked as initialized. The reset flow will clear the init field
under lock before it tears the tracker down, thus preventing any
use-after-free or NULL access.

Fixes: f9472aaabd1f ("ice: Process TSYN IRQ in a separate function")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e358eb1d719f..fb0f6365a6d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2701,16 +2701,19 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		 */
 		if (hw->dev_caps.ts_dev_info.ts_ll_int_read) {
 			struct ice_ptp_tx *tx = &pf->ptp.port.tx;
-			u8 idx;
+			u8 idx, last;
 
 			if (!ice_pf_state_is_nominal(pf))
 				return IRQ_HANDLED;
 
 			spin_lock(&tx->lock);
-			idx = find_next_bit_wrap(tx->in_use, tx->len,
-						 tx->last_ll_ts_idx_read + 1);
-			if (idx != tx->len)
-				ice_ptp_req_tx_single_tstamp(tx, idx);
+			if (tx->init) {
+				last = tx->last_ll_ts_idx_read + 1;
+				idx = find_next_bit_wrap(tx->in_use, tx->len,
+							 last);
+				if (idx != tx->len)
+					ice_ptp_req_tx_single_tstamp(tx, idx);
+			}
 			spin_unlock(&tx->lock);
 
 			return IRQ_HANDLED;

-- 
2.50.1


