Return-Path: <netdev+bounces-178697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57063A78539
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F513AB414
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B18204F6B;
	Tue,  1 Apr 2025 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHqZ9cgg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8EF4ED
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743550567; cv=none; b=ecjaYz7oUylBPh0x4shXEzLPmwagaCcQZZTawqYhPavusEThtVTdCPBNNdMfVsMFb8gI7MOcij7U450tLECcti6F8nnNRgNJ8QxsUFm/ylOnhxq14FSV2Vx+auI9GpjRe83iL31MonqSdrMLCmOVzEeu93Vv5oZtVkpPuwmNgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743550567; c=relaxed/simple;
	bh=kC1I+DQ5xHIKKVFC8T8O8KDCldfT9BKibYcTcSjaVOY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VGHseu5+Lk5FQiF68hC0jk1nlCDSmgXzZRgGqqUib3nMsDyjKD35HZHLn5w6ZixdcmGmspy435xQ4XoFAjAG0Dp62Y6fE9ubFsG78u2xjL/i5jaE3oR41ZKljTWFxecZTrQcbli/hZ/lE5jzrjjKWPVr3lKBnfKmxavAeIu/b4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHqZ9cgg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743550566; x=1775086566;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=kC1I+DQ5xHIKKVFC8T8O8KDCldfT9BKibYcTcSjaVOY=;
  b=aHqZ9cgglDA8A9xrFUq3WuvalaweUxogrvpppHW5I0N3MunlyHin0Xst
   ymCj7OwMb40puW5Qj8IsXae/KSULze7y8ZfHri8gYwkAMMKIAtPM3ajDu
   6JNRyOTtK1SMPU5ZFgNBno8jc+WLaU6UHwggD85d9MIs8RMPlgAqQTWfK
   6yG5vtS2SYuVx4QuoTfpE0O4qgOxGrpDZ/RQK2fx9RXTeKzL4Jc8848DJ
   xAk7xFrlh0E0pPA7k/V8MgidwNqqurQjBbiIa6CsWPIXfcVlRAFF5lBYP
   lz9iMtRGK7sSvkWDWCirrZE09Rzcgfw/OeERWXunMP5du+DbiDcHNHmma
   w==;
X-CSE-ConnectionGUID: O6LivBerSMK8YJck1PwOiA==
X-CSE-MsgGUID: 2UwCA57jQNWscLOxYhIaSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55527590"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="55527590"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:05 -0700
X-CSE-ConnectionGUID: eMnUMbQOTdKkAb4e7kRn2Q==
X-CSE-MsgGUID: 48m0ly3sSX6WaxTdtX3NSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="127354838"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net v4 0/6] igc: Fix PTM timeout
Date: Tue, 01 Apr 2025 16:35:28 -0700
Message-Id: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEB47GcC/x2NwQ6CMBBEf4Xs2SVtqQKe/A/DodSFrkIhLUEN4
 d+tHCdv3swGkQJThGu2QaCVI08+BX3KwDrje0J+pAxKqLPQQuLzhdxbnJcRO/5QxFVjXdWtoY5
 MKzUkcw50sCTegd8DelqgScBxXKbwPd7W4sBpWEspLrLSpVK5LFUhUKJ14d+dHYU85s4Mw439Q
 kNupxGafd9/rXXraLoAAAA=
X-Change-ID: 20250401-jk-igc-ptm-fixes-v4-989baefeab14
To: Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: david.zage@intel.com, vinicius.gomes@intel.com, 
 rodrigo.cadore@l-acoustics.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Christopher S M Hall <christopher.s.hall@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Mor Bar-Gabay <morx.bar.gabay@intel.com>, 
 Avigail Dahan <avigailx.dahan@intel.com>, 
 Corinna Vinschen <vinschen@redhat.com>
X-Mailer: b4 0.14.2

There have been sporadic reports of PTM timeouts using i225/i226 devices

These timeouts have been root caused to:

1) Manipulating the PTM status register while PTM is enabled and triggered
2) The hardware retrying too quickly when an inappropriate response is
   received from the upstream device

The issue can be reproduced with the following:

$ sudo phc2sys -R 1000 -O 0 -i tsn0 -m

Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
quickly reproduce the issue.

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
  fails

The first patch in this series also resolves an issue reported by Corinna
Vinschen relating to kdump:

  This patch also fixes a hang in igc_probe() when loading the igc
  driver in the kdump kernel on systems supporting PTM.

  The igc driver running in the base kernel enables PTM trigger in
  igc_probe().  Therefore the driver is always in PTM trigger mode,
  except in brief periods when manually triggering a PTM cycle.

  When a crash occurs, the NIC is reset while PTM trigger is enabled.
  Due to a hardware problem, the NIC is subsequently in a bad busmaster
  state and doesn't handle register reads/writes.  When running
  igc_probe() in the kdump kernel, the first register access to a NIC
  register hangs driver probing and ultimately breaks kdump.

  With this patch, igc has PTM trigger disabled most of the time,
  and the trigger is only enabled for very brief (10 - 100 us) periods
  when manually triggering a PTM cycle.  Chances that a crash occurs
  during a PTM trigger are not zero, but extremly reduced.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v4:
- Jacob taking over sending v4 due to lack of time on Chris's part.
- Updated commit messages based on review feedback from v3
- Updated commit titles to slightly more imperative wording
- Link to v3: https://lore.kernel.org/r/20241106184722.17230-1-christopher.s.hall@intel.com
Changes in v3:
- Added mutex_destroy() to clean up PTM lock.
- Added missing checks for PTP enabled flag called from igc_main.c.
- Cleanup PTP module if probe fails.
- Wrap all access to PTM registers with PTM lock/unlock.
- Link to v2: https://lore.kernel.org/netdev/20241023023040.111429-1-christopher.s.hall@intel.com/
Changes in v2:
- Removed patch modifying PTM retry loop count.
- Moved PTM mutex initialization from igc_reset() to igc_ptp_init(), called
  once during igc_probe().
- Link to v1: https://lore.kernel.org/netdev/20240807003032.10300-1-christopher.s.hall@intel.com/

---
Christopher S M Hall (6):
      igc: fix PTM cycle trigger logic
      igc: increase wait time before retrying PTM
      igc: move ktime snapshot into PTM retry loop
      igc: handle the IGC_PTP_ENABLED flag correctly
      igc: cleanup PTP module if probe fails
      igc: add lock preventing multiple simultaneous PTM transactions

 drivers/net/ethernet/intel/igc/igc.h         |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h |   6 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 113 ++++++++++++++++++---------
 4 files changed, 81 insertions(+), 40 deletions(-)
---
base-commit: f278b6d5bb465c7fd66f3d103812947e55b376ed
change-id: 20250401-jk-igc-ptm-fixes-v4-989baefeab14

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


