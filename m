Return-Path: <netdev+bounces-181695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638ECA8633C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BE317637A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680421B9D3;
	Fri, 11 Apr 2025 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ipf26ffV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E322367DD
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388950; cv=none; b=W+lUKQt5h21TNbbL/vYIp94BJG9q34kZY27xVfjTUPms/+LFRhAw93F72Du6n+ipCCWXSrIXxZkT8O1W2IIX8kRrsEpedxqeAHcLQo/yqL5ndTtKDxv8NBtXIoIrAUswUZbUldbVSS1uE1vrA7DzXl/qKJ+u6BcjGkgGd7w5JoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388950; c=relaxed/simple;
	bh=v8bB1PRYznkD5aDxXMWD1FLhoAkfkV0ZYHTAI2pWT6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DazaM3ut6iBAxSZ0ncb8JGRc1qCUGoGKmIjZtg3ezoluS9nMGG76sZD+Q5YXBzmfF/ARi2NeDEaHSfVk8eeXYzYDayY+VTIwOTtXlDG40WD4LYjkVMf3bulb3rDaMEiJ+xPWMb7ovEB80w6YJcHH1ZmhrNEHuX/r8n/Pv5Co+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ipf26ffV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744388948; x=1775924948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v8bB1PRYznkD5aDxXMWD1FLhoAkfkV0ZYHTAI2pWT6k=;
  b=Ipf26ffVPX8KeSzihDkjwixBZsP0fNpc+9HWHMAWgmF2bDq6fsbJPMvz
   Ty0bhGAIGa5r3cdlG1WRg0Na39tjiKsXetuSojaUHgSMxqQTMXx3lOJvz
   t+6Emtahrj0d21Elr2PM6mNAungeou1C72vOClLX0LeiRsGs1PdNpgoN/
   vDHWwCTJvGfLqPGVtyKP4fRjPXpchULgWiJJiBXQAo4E3lzzJJ59KYBWv
   NLW8g9pbWwxDfvlEDHGwjiKbzjge5Tz78RYYrfX5CZynpfpKP1KHkgG0a
   OHbEianW+LH/Qn2y4LQhDoEcETU6fBRNoimgTmCCtMQduvRhCCGELmgTE
   A==;
X-CSE-ConnectionGUID: Gd0Zi15JTuyqvn4+m0rrlw==
X-CSE-MsgGUID: Kl7zDLXNThCl2tg5bWiT/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56610933"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56610933"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 09:29:07 -0700
X-CSE-ConnectionGUID: ZQGaHFdCSj+KAln/ZHV+oQ==
X-CSE-MsgGUID: mYcLYH3ZTH2Jb5UIWqgqbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="133343128"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 11 Apr 2025 09:29:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	christopher.s.hall@intel.com,
	jacob.e.keller@intel.com,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	michal.swiatkowski@linux.intel.com,
	richardcochran@gmail.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com
Subject: [PATCH net 0/6][pull request] igc: Fix PTM timeout
Date: Fri, 11 Apr 2025 09:28:49 -0700
Message-ID: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christopher S M Hall says:

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
---
IWL: https://lore.kernel.org/intel-wired-lan/20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com/

The following are changes since commit cfe82469a00f0c0983bf4652de3a2972637dfc56:
  ipv6: add exception routes to GC list in rt6_insert_exception
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

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
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 113 ++++++++++++-------
 4 files changed, 81 insertions(+), 40 deletions(-)

-- 
2.47.1


