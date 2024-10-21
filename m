Return-Path: <netdev+bounces-137519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EBC9A6C05
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8687E2826AE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E51F8EEE;
	Mon, 21 Oct 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNPmoe+3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE521D1E88;
	Mon, 21 Oct 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520684; cv=none; b=JP/QNiG32smsfTdf2Rxf+lxq4MmjrbARvgCnKT00Rvzc1xAFj6Pni3jY9pL2+/kvyZVi59B3vbbxT5Cuv3+pKGVfYeh6eSgrKKONG5wY6owD9HHV5XraMS4KCHkYw/JM7ObAUnqSGT1ety7874tZszVvHyGokwANCl6CTLP7Z7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520684; c=relaxed/simple;
	bh=pc4NBde+fXjBXx1YyOAYXQyIKmBbSnOydn+XQMOwhH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jxkhVg9L2gONpaOiNG6gtzW8DzcMu6X7FWSzjOSS5dbeKOcnfdjcxd99UM8t4/mfgRyDfCTh2PQXIafzR5HuZ7EGrIo4L6qlicwRsst4tDq5Rb29Mzi1s4rWQBRhwgo6PkPza9AmFKEhqabJ6Z0IimQ01HYl0xIzNxOF7rldmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNPmoe+3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729520682; x=1761056682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pc4NBde+fXjBXx1YyOAYXQyIKmBbSnOydn+XQMOwhH4=;
  b=XNPmoe+3EmHGOOJxVFhlOIpQupAY9fIKLa+0hmKiFVXSY3g3KVyUY0TR
   Rs6RcYFbyR4XCglaXe74pOCJ2s3jupwX+DtW9uQ9602xC68nfsTVmkXnn
   2cH/CO4wKwC/+mLmrP2Ork9XaHUUoBTKdD+8UL+JOFfmDK4hKQ9I2tcgB
   AAoXbQH5RmqNOk3FiOhNDmB46FWic9cgltin6PdHbQIdQ6Sq2ftUeZcam
   GGMCt1n3m+lAMAcW9KUtGmPO3AcOWi+I9yBdk40jOB0/k0H1gu6NRmL5Z
   nY+Aad8I5ursvQBRsU6yHwpkkT5Tde2o7+p4CfurDEFZbKVnOgDuo4Zdc
   w==;
X-CSE-ConnectionGUID: n+Q1AmMOSu2busVmZqNUrQ==
X-CSE-MsgGUID: gIT3QhIyTfC3YC6Au5au3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28781472"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28781472"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:24:40 -0700
X-CSE-ConnectionGUID: K/mVzZNPTeyWcbXabMW+6w==
X-CSE-MsgGUID: RNR/rDYxRJCBtdFcUPU2Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="102857310"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa002.fm.intel.com with ESMTP; 21 Oct 2024 07:24:38 -0700
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
Subject: [PATCH net-next 0/2] ptp: add control over HW timestamp latch point
Date: Mon, 21 Oct 2024 16:19:53 +0200
Message-Id: <20241021141955.1466979-1-arkadiusz.kubalewski@intel.com>
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

[1] https://www.ieee802.org/3/cx/public/april20/tse_3cx_01_0420.pdf

Arkadiusz Kubalewski (2):
  ptp: add control over HW timestamp latch point
  ice: ptp: add control over HW timestamp latch point

 Documentation/ABI/testing/sysfs-ptp         | 12 +++++
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 46 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 57 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
 drivers/ptp/ptp_sysfs.c                     | 44 ++++++++++++++++
 include/linux/ptp_clock_kernel.h            | 29 +++++++++++
 6 files changed, 190 insertions(+)

-- 
2.38.1


