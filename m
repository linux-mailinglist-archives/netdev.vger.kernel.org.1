Return-Path: <netdev+bounces-142500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865F59BF5D8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B4D2840F7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02120899A;
	Wed,  6 Nov 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzSjLNqV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582B208969
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919534; cv=none; b=QOf6sD3DS3PFXLCUtvpbZAyWWFtuJQeSLbv2sclkShLeTHvqgij3li59ntKKmIAD6mhJqa+wwOZYAErXmlo8CCQF9180Gulf0z4kFLZzfv87LIRDMiwMB3n9xPNrgGeiVXD2M+sPHqTCYYhioPBkuudrCaXsmlX8UKzw80YNQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919534; c=relaxed/simple;
	bh=d6MJXY8r+YDwnf7zHOEKRdN3xmfWj9TjbhzFbGNbzYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dk7+y0fNcHz2SjUWXK/zczHzsE9DkEd39ZaZ+10ZK4kGhuCeZlNMT6YMbw5MGozacnr+Rx9U1lvX6GeI/kUHEGFseLTlfgvXafgb4bwm7WdybQ0ioxq5wU+gMralq3FudNGa2oknmG4oIpyf7R1HLav6OOEWQjLPy/La+63wJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzSjLNqV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730919533; x=1762455533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6MJXY8r+YDwnf7zHOEKRdN3xmfWj9TjbhzFbGNbzYI=;
  b=CzSjLNqVgB2vXNGY05hRux+UfcAgRXa1J0mUZmamO9d1UZ/CrjPY5x3g
   hMEie3tV8np15FIQIeK7bvapjVQ6Na9EeK8HXmMB7k5r17EA50hklR248
   cUqQvHD0Pe90TB7xt3aE1NJObuIvMuWUyBY46wVbfbldgrCI6qL0x5Srn
   BwsEp32FmbIvWpwXlPmbq33/dMKm4ZcMC1zGo2rg5JMb1kWf76tjzyJBR
   ffzoBpuF04fYrh7VdiaMbCsY8uJI2+udq9wSmddPD16VlxBGUHne7GpKO
   x8gwdQ28wpKsi9o0mIXcGuSFyoxpp12Hl59jLMlNZwjJAFVgL73SGeOHl
   Q==;
X-CSE-ConnectionGUID: e8WNJmvWTZOgwtrVyyTLZw==
X-CSE-MsgGUID: Y12tbDMNTMeR735Hy+rBug==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30959465"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="30959465"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:58:51 -0800
X-CSE-ConnectionGUID: haNYpsmXQmKJfBHLZBqipw==
X-CSE-MsgGUID: TtrAAlTeTyibe/GALJxpFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89813795"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by orviesa004.jf.intel.com with ESMTP; 06 Nov 2024 10:56:40 -0800
From: Christopher S M Hall <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH iwl-net v3 3/6] igc: Move ktime snapshot into PTM retry loop
Date: Wed,  6 Nov 2024 18:47:19 +0000
Message-Id: <20241106184722.17230-4-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106184722.17230-1-christopher.s.hall@intel.com>
References: <20241106184722.17230-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ktime_get_snapshot() into the loop. If a retry does occur, a more
recent snapshot will result in a more accurate cross-timestamp.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index c640e346342b..516abe7405de 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1011,16 +1011,16 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 	int err, count = 100;
 	ktime_t t1, t2_curr;
 
-	/* Get a snapshot of system clocks to use as historic value. */
-	ktime_get_snapshot(&adapter->snapshot);
-
+	/* Doing this in a loop because in the event of a
+	 * badly timed (ha!) system clock adjustment, we may
+	 * get PTM errors from the PCI root, but these errors
+	 * are transitory. Repeating the process returns valid
+	 * data eventually.
+	 */
 	do {
-		/* Doing this in a loop because in the event of a
-		 * badly timed (ha!) system clock adjustment, we may
-		 * get PTM errors from the PCI root, but these errors
-		 * are transitory. Repeating the process returns valid
-		 * data eventually.
-		 */
+		/* Get a snapshot of system clocks to use as historic value. */
+		ktime_get_snapshot(&adapter->snapshot);
+
 		igc_ptm_trigger(hw);
 
 		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
-- 
2.34.1


