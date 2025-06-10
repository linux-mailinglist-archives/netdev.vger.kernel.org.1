Return-Path: <netdev+bounces-196242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B45DAD4027
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428167A82A6
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D677A24469D;
	Tue, 10 Jun 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGyWcOY4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283E24467D
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575639; cv=none; b=KYhFBx4PzQcp7ZUR0gfS9z2nxqST9UqR2RT0r4E5HKoeQK1rjMqPlRrlDmWTRXpWtLgot4NtSe8NWZMU3YUZlKqQxbymCDVvTsuJdyiGDxylkJbFYV8hG6H1lzIz7TJtqrTtKXF2uLn3GwFXWazA6qCnE0UJh0fY/E2sYVFyuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575639; c=relaxed/simple;
	bh=TdetgK9QfIrQPRV2Mnzmc/BsOTM6L8ZdA4vhNnSZLAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAJJFd/YT3kjaGGSk5ApdQdH/Ni5M74A4XMppvh6xjX5LDeelN+6zLVYcQFuEQdFJVjpp9HwxlmC+xLvF4yOccohX/WvUatDaNZfq1CLQayATNgpXBxSFn3yAMjaVUGHE5QbbpXhCq+Rlx9WnImbKN7qd6JHpMFvRzLs3PuOtjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGyWcOY4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749575638; x=1781111638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TdetgK9QfIrQPRV2Mnzmc/BsOTM6L8ZdA4vhNnSZLAE=;
  b=EGyWcOY4EvlT2gAauuHVQqO+rk95ENTnjPdk6m/8vKH634VyPBzVoQb0
   2vhHlos4ISgFzGqQPxdIrItUuysBWhQRZk0ZAugvZXGJvG+gyZ9NMVtJO
   X3w+/3Ls+lhxmNtoOhmwsInQVOOt660+YH9oS0RfTvGhhsU7P1fBpJKYU
   J5irHtsHKc773IBUiVtINndG+R8NWAXNw2HQnupF0jQ6EJQdFwl2AWXzr
   vtAqGVum0698tIFYshRi3AqnlBHO9BCKz2xrGtnXvOBS2SSO1PDAaNEY8
   WVTIbfJf21BpAOnn5U51NUudeWV0e0nxKCInTPIRLNQmqngX4tEFI0O9s
   g==;
X-CSE-ConnectionGUID: 4wQiyVu+SLC8BKm5u5k9RA==
X-CSE-MsgGUID: an5emR5eSXiy15Me8ZqkTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51554669"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51554669"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:13:54 -0700
X-CSE-ConnectionGUID: SWBCq36BRe6E7mKLosMPoQ==
X-CSE-MsgGUID: JSKNluyWTuKA1ohnWxwnUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147850446"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jun 2025 10:13:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>,
	anthony.l.nguyen@intel.com,
	lakshmi.sowjanya.d@intel.com,
	tglx@linutronix.de,
	richardcochran@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 4/5] ice/ptp: fix crosstimestamp reporting
Date: Tue, 10 Jun 2025 10:13:44 -0700
Message-ID: <20250610171348.1476574-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
References: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anton Nadezhdin <anton.nadezhdin@intel.com>

Set use_nsecs=true as timestamp is reported in ns. Lack of this result
in smaller timestamp error window which cause error during phc2sys
execution on E825 NICs:
phc2sys[1768.256]: ioctl PTP_SYS_OFFSET_PRECISE: Invalid argument

This problem was introduced in the cited commit which omitted setting
use_nsecs to true when converting the ice driver to use
convert_base_to_cs().

Testing hints (ethX is PF netdev):
phc2sys -s ethX -c CLOCK_REALTIME  -O 37 -m
phc2sys[1769.256]: CLOCK_REALTIME phc offset -5 s0 freq      -0 delay    0

Fixes: d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b79a148ed0f2..55cad824c5b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2299,6 +2299,7 @@ static int ice_capture_crosststamp(ktime_t *device,
 	ts = ((u64)ts_hi << 32) | ts_lo;
 	system->cycles = ts;
 	system->cs_id = CSID_X86_ART;
+	system->use_nsecs = true;
 
 	/* Read Device source clock time */
 	ts_lo = rd32(hw, cfg->dev_time_l[tmr_idx]);
-- 
2.47.1


