Return-Path: <netdev+bounces-222589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7CFB54F29
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0A07BE5FB
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D2309DCB;
	Fri, 12 Sep 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tm+gETZE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772D257827
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683035; cv=none; b=IqOr8WBLMMIoYiuLia4pz/dwL4P8DmUH4mQdxQcn0J7h+FYOCZ6uKqIGQshrAt2M4tlA5EPIIzNxuo/Tua934+Q6Y1BdhWc93BhDh1kL0e/+LoLmjrvRnXOJD1zCX+6PriT3hBhraE7k6zIJK9P3woSabEYSKijWlGyF52C45so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683035; c=relaxed/simple;
	bh=Qmp/sVrKPtWZYE32eNYZrLxUcCXTL+w4Rquv9L6eNds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zykui7mA9SDC9KdaaGZc5QMo+kCP/08IkuPbXjnaChO7sqz8nogPZAoc3zS4DEE57J8Es2XFYARsIGdRekocSU/lSXlQKPQ5oP/PvdErX6WeaI7KhL4wkBAPgQmPrjqXZIzvbsz5LjDy2NCeQA+RxcZfqH0/7wHpIxiRRBbNku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tm+gETZE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683033; x=1789219033;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qmp/sVrKPtWZYE32eNYZrLxUcCXTL+w4Rquv9L6eNds=;
  b=Tm+gETZE2JohBW7eYWsQ1AuXi37+PT9eO4ZqQsX5GLydr3fH5GLZZNud
   Kr2LGpUw09IR54Cgdj6c+ylnGUikrk69aYeovtrbkGRA+QY2MS7Q+gmzD
   Yhh1QHLhlAGX7COGnqoz46r/MkSeF7I/fvilrVJh0zTVJIJ+LGVHaBb9r
   r3pqeWpL8Ag3KiTi/mv288FvdOmcH4Fd+YA3Sj7zCvMCP1W8tL4mdBP2t
   SLDIGGmMQuxgO3ULkQQXdFDt+7x4VyQ3WuDMmKPdQGo3mBDG5l7ubvNhy
   BEii3PTEVRU9VtoExh352G97ybUmWo+KLHL+/J5+qqHRjjHPKeZF8jiwt
   A==;
X-CSE-ConnectionGUID: IyEDVAWFS96wQBpHFFhdcw==
X-CSE-MsgGUID: 7Dj4XkB0SQ2KRPL/T15URA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461397"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461397"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:12 -0700
X-CSE-ConnectionGUID: jAmMynUMS+iiQ33zQpcMmQ==
X-CSE-MsgGUID: dozrqj/ARvOLvhPTPLceOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131203"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:10 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9DF1D2FC6E;
	Fri, 12 Sep 2025 14:17:08 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 0/9] ice: pospone service task disabling
Date: Fri, 12 Sep 2025 15:06:18 +0200
Message-Id: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move service task shutdown to the very end of driver teardown procedure.
This is needed (or at least beneficial) for all unwinding functions that
talk to FW/HW via Admin Queue (so, most of top-level functions, like
ice_deinit_hw()).

Most of the patches move stuff around (I believe it makes it much easier
to review/proof when kept separate) in preparation to defer stopping the
service task to the very end of ice_remove() (and other unwinding flows).
Then last patch fixes duplicate call to ice_init_hw() (actual, but
unlikely to encounter, so -next, given the size of the changes).

First patch is not much related, only by that it was developed together
with the rest, and is so small, that there is no point for separate thread

--
changes vs internal review:
Expanded cover letter (Jake).

Przemek Kitszel (9):
  ice: enforce RTNL assumption of queue NAPI manipulation
  ice: move service task start out of ice_init_pf()
  ice: move ice_init_interrupt_scheme() prior ice_init_pf()
  ice: ice_init_pf: destroy mutexes and xarrays on memory alloc failure
  ice: move udp_tunnel_nic and misc IRQ setup into ice_init_pf()
  ice: move ice_init_pf() out of ice_init_dev()
  ice: extract ice_init_dev() from ice_init()
  ice: move ice_deinit_dev() to the end of deinit paths
  ice: remove duplicate call to ice_deinit_hw() on error paths

 drivers/net/ethernet/intel/ice/ice.h          |   4 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  21 ++-
 drivers/net/ethernet/intel/ice/ice_common.c   |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 159 +++++++++---------
 5 files changed, 109 insertions(+), 82 deletions(-)

-- 
2.39.3


