Return-Path: <netdev+bounces-131782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718ED98F913
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250AE1F2280F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC661BF7E9;
	Thu,  3 Oct 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F73ADI3F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9021AC429;
	Thu,  3 Oct 2024 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991761; cv=none; b=Pyz0hPjldq7RyAmfLm7jLW2oWADrPw6l8IJv7PEs8zN8ARlckIR7BErJjh/4iZ9pgJc/dVPAShwUU3tP3nb6feAWUDu7K1xAseuxpetaCDs8cLpnzPLFNGtpV8LZSyg0f6KjAfotT7DLk8ZBR9YSYlwOxKcWRp+OdMycQhkn7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991761; c=relaxed/simple;
	bh=TJiRZ1KiEkFkyQI8bb1tW621Tath3UYQnH3N2XGvdVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RNJrIoU1c2JW/gzmgE9K6iaEkRvwxy7ZwDYADDyQxUGNz/cqYVrgkhhdwuMIIrzefUowpIa6fpAH1kxQSW2sc5jR8563X2QOpqGP7cR4a6W3xB7T7BGCEJdC/M99PCogrGW4IrHF+8S5W5BMIRHYGTSV6KRmpeRQRAmR5igqNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F73ADI3F; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727991759; x=1759527759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TJiRZ1KiEkFkyQI8bb1tW621Tath3UYQnH3N2XGvdVQ=;
  b=F73ADI3F5B7E/lGLexEY53T73u3ep1DX6p3rAoDt56B0ku2DeKzL9AoB
   cdxa12nLFYqyS0Q0DzBYtUjG6n23wzckPql//FfO5K5WKUfVef4STp37Z
   PjOwTUImRC8G1Fw/nrhJCAQreT+mt6d67tCxcfO2sT778oPm7/C3xQsM/
   46u5qK0VaRbULlIoGJC3Ka/qxAGOzQw0WSUeC6kJBgk+BBPJszWkNSIDO
   ZybAlG4aUquTUhUaOkFXRVcybOuj+9Ak95M5/b86aIKrhi3GaqeS/+dap
   5UnBZLHU2L+x0k2rr8557wPpUuDHGFfhMt8wLG3Jep25KHKZpZYCE4272
   A==;
X-CSE-ConnectionGUID: ShAHKB5MT8OCc6POFz41NQ==
X-CSE-MsgGUID: 6PeuvsiHRp+deKPkFC87Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27379817"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27379817"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 14:42:38 -0700
X-CSE-ConnectionGUID: XuuXMZiPTki47129Ddd60g==
X-CSE-MsgGUID: oEvwIaxaSq+e5GR0owYtNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="111952979"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa001.jf.intel.com with ESMTP; 03 Oct 2024 14:42:36 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [RFC PATCH 0/2] ptp: add control over HW timestamp latch point
Date: Thu,  3 Oct 2024 23:37:52 +0200
Message-Id: <20241003213754.926691-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HW support of PTP/timesync solutions in network PHY chips can be
achieved with two different approaches, the timestamp maybe latched
either in the beginning or after the Start of Frame Delimiter (SFD) [1].

Allow ptp device drivers to provide user with control over the timestamp
latch point.

Arkadiusz Kubalewski (2):
  ptp: add control over HW timestamp latch point
  ice: ptp: add control over HW timestamp latch point

 drivers/net/ethernet/intel/ice/ice_ptp.c    | 48 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 52 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  3 +-
 drivers/ptp/ptp_sysfs.c                     | 44 +++++++++++++++++
 include/linux/ptp_clock_kernel.h            | 26 +++++++++++
 5 files changed, 172 insertions(+), 1 deletion(-)

-- 
2.38.1


