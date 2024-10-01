Return-Path: <netdev+bounces-131027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5340698C69A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C2DB20FE7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377821CCB58;
	Tue,  1 Oct 2024 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9rH1lOi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689971925B8
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813835; cv=none; b=dz+WYN50Nydg6wmTsvo9RrT2ZNrNNxIf3dOwUhPIZu6ZkcFdIui3seEer43O/Znw+4iGKAiQ+dqKqoQ73dMAIaY5tXndnSTPwvZ0Ahc+gwgN0iiZrYTl7jKWKDimgQ9KJIcdHAjwYIJLcT8ULYJO5Qa8X7xm9hudg4fsElH4Yy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813835; c=relaxed/simple;
	bh=x4ng3obJmkkd4KaDjRymyxrudC+EeVhPb9AttZ0rddQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUhbPh6qF0Yq5h/UUUgDB/6Gmij9upMnocZgFX2UM1TdZocJqZ6cBQUuf21HYegIHKRUBkClN/KEk8UYFV7+wlBLA/DXoQ0bDhE5+2RB41EpWWSGrbI37dbba8bdCkb8iGOaz59T/lQPbRjmzDGaPP7cRoUavDin2SbGGkJWDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9rH1lOi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727813833; x=1759349833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x4ng3obJmkkd4KaDjRymyxrudC+EeVhPb9AttZ0rddQ=;
  b=W9rH1lOiP+F6rNfz/LSpmKDWERvSl5gwnxcYXwrsZ8EIRSljVQpI84MF
   irGcISeY+iMRDKplQ+aFcfAiZyBqmnAZITPjp2AQwOXoZR7ibqH4fXI5e
   1nIbCOmnWaZGL/SNPus6hTvlM6ZHDt6lDD/nx8LEMxgGrqVlmdnXPuniU
   fDqE3BjM9K0i8Cb5xoZs90LlaiE067HrdV4JRTQdoDBHOMPAdnXwT/qqQ
   FWpPNTHdGMHW+E1V9Fs40qQ6LJ0608Ov8iN1FWIZpqiYYca4y2CbZMJOu
   MD1tcF4tZk5MzF5lQlgSI+U/RjcXzxJ00E024PFQWsrJNDlUB0obBQq+/
   w==;
X-CSE-ConnectionGUID: BhcDrnOZSDaeIjcoVH21wg==
X-CSE-MsgGUID: j7V2EajXStuSV5CeN01FsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27063047"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27063047"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 13:17:12 -0700
X-CSE-ConnectionGUID: 5PWuqg7WShqzlVI4CtkClA==
X-CSE-MsgGUID: vbXqIcqrQemaF8IHOwHZMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73761837"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Oct 2024 13:17:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	richardcochran@gmail.com
Subject: [PATCH net-next 00/12][pull request] Intel Wired LAN Driver Updates 2024-10-01 (ice)
Date: Tue,  1 Oct 2024 13:16:47 -0700
Message-ID: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Karol cleans up current PTP GPIO pin handling, fixes minor bugs,
refactors implementation for all products, introduces SDP (Software
Definable Pins) for E825C and implements reading SDP section from NVM
for E810 products.

Sergey replaces multiple aux buses and devices used in the PTP support
code with struct ice_adapter holding the necessary shared data.

The following are changes since commit 44badc908f2c85711cb18e45e13119c10ad3a05f:
  tcp: Fix spelling mistake "emtpy" -> "empty"
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Karol Kolacinski (5):
  ice: Implement ice_ptp_pin_desc
  ice: Add SDPs support for E825C
  ice: Align E810T GPIO to other products
  ice: Cache perout/extts requests and check flags
  ice: Disable shared pin on E810 on setfunc

Sergey Temerkhanov (6):
  ice: Enable 1PPS out from CGU for E825C products
  ice: Introduce ice_get_phy_model() wrapper
  ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
  ice: Initial support for E825C hardware in ice_adapter
  ice: Use ice_adapter for PTP shared data instead of auxdev
  ice: Drop auxbus use for PTP to finalize ice_adapter move

Yochai Hagvi (1):
  ice: Read SDP section from NVM for pin definitions

 drivers/net/ethernet/intel/ice/ice.h          |    5 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  |   22 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   22 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    9 +
 drivers/net/ethernet/intel/ice/ice_gnss.c     |    4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 1455 ++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  143 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  125 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   77 +-
 10 files changed, 910 insertions(+), 954 deletions(-)

-- 
2.42.0


