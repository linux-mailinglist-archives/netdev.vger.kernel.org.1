Return-Path: <netdev+bounces-148953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E9F9E3984
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1B22813E7
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5D21B414E;
	Wed,  4 Dec 2024 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVA1Pf+O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903A1ADFF1
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314152; cv=none; b=YU4zkp7xz7IzbYOb/fZu6icuEvFfFB5/VVmWuQiXnY+83KVQr2+u529WjjqrEo1C08LUyUJAEv9GEeyiS3TSQ00U8h2NfwcMc48GIma0Y92btY7ehY5mNpwrCHxvdpI4BtJDJcENTnvT7Jq6jRqbk+9Xt42WXY7q4r2kowsZAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314152; c=relaxed/simple;
	bh=KQfHFQ/ZYKUlItWNvsZBVoWc70S6XVSP9gazTBBIOPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFBYTs1EAU0zwujgrXKWqrpkHtWj06afh9J9fMQk7sSVtLf7UuTX4mPHZKYR9IQg69Ot8xJ5+uu0pv7P3VYIGVk06X1/7cx9n1PGsNdXnZp1b2Cg8KtjD3c5V6xRy6X093ZMvgUFEkzCRKcpmHNIN/tmEfRtdX+/5gQp2yWlZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVA1Pf+O; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733314150; x=1764850150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KQfHFQ/ZYKUlItWNvsZBVoWc70S6XVSP9gazTBBIOPc=;
  b=RVA1Pf+O8mR1sMmgogVSC2zeadMhqBn20qaa1yA51zbsEGo8PqBLAC0Y
   hoO/FO8lYhS5P+MDpSwXS/UlduEj6NVmzGem1aqOHxGI12pwBGNRYcW9d
   brrZZs36lFEPVDqM4CwMNs92SEmsftp2vu6+WkHGG+Rk7U8T4SSlr+L5/
   c9jOB/gHZiTeXmCvdPEVlxY6ROF9arWAqcvbiug4/TTEHrt/HJnmbDf6+
   WOPQuzFhhRQCqON0I8W6HC9K7OwX37kJxjzSml8DztIdLWgEYPupPJTm2
   5PjUL7iEZcgbNJpkWmD6Ll0eGxOrLmWupse3uCm6z5Pmd2sJan7TdQPLc
   Q==;
X-CSE-ConnectionGUID: Z9IkRDWzRpuI3rng19rfjg==
X-CSE-MsgGUID: OYLDecVxShSiEAXQIyL2mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32918419"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32918419"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:09:10 -0800
X-CSE-ConnectionGUID: RJyuXgfkQo2ZP1iYoQfWvg==
X-CSE-MsgGUID: nD4U9YSqRYCe2haYPR+6xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="116994549"
Received: from host61.igk.intel.com ([10.123.220.61])
  by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2024 04:09:08 -0800
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Anton Nadezhdin <anton.nadezhdin@intel.com>
Subject: [PATCH iwl-next 0/5] ice: implement low latency PHY timer updates
Date: Wed,  4 Dec 2024 13:03:43 -0500
Message-ID: <20241204180709.307607-1-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Programming the PHY registers in preparation for an increment value change
or a timer adjustment on E810 requires issuing Admin Queue commands for
each PHY register. It has been found that the firmware Admin Queue
processing occasionally has delays of tens or rarely up to hundreds of
milliseconds. This delay cascades to failures in the PTP applications which
depend on these updates being low latency.

Consider a standard PTP profile with a sync rate of 16 times per second.
This means there is ~62 milliseconds between sync messages. A complete
cycle of the PTP algorithm

1) Sync message (with Tx timestamp) from source
2) Follow-up message from source
3) Delay request (with Tx timestamp) from sink
4) Delay response (with Rx timestamp of request) from source
5) measure instantaneous clock offset
6) request time adjustment via CLOCK_ADJTIME systemcall

The Tx timestamps have a default maximum timeout of 10 milliseconds. If we
assume that the maximum possible time is used, this leaves us with ~42
milliseconds of processing time for a complete cycle.

The CLOCK_ADJTIME system call is synchronous and will block until the
driver completes its timer adjustment or frequency change.

If the writes to prepare the PHY timers get hit by a latency spike of 50
milliseconds, then the PTP application will be delayed past the point where
the next cycle should start. Packets from the next cycle may have already
arrived and are waiting on the socket.

In particular, LinuxPTP ptp4l may start complaining about missing an
announce message from the source, triggering a fault. In addition, the
clockcheck logic it uses may trigger. This clockcheck failure occurs
because the timestamp captured by hardware is compared against a reading of
CLOCK_MONOTONIC. It is assumed that the time when the Rx timestamp is
captured and the read from CLOCK_MONOTONIC are relatively close together.
This is not the case if there is a significant delay to processing the Rx
packet.

Newer firmware supports programming the PHY registers over a low latency
interface which bypasses the Admin Queue. Instead, software writes to the
REG_LL_PROXY_H and REG_LL_PROXY_L registers. Firmware reads these registers and
then programs the PHY timers.

Implement functions to use this interface when available to program the PHY
timers instead of using the Admin Queue. This avoids the Admin Queue
latency and ensures that adjustments happen within acceptable latency
bounds.

Jacob Keller (5):
  ice: use rd32_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
  ice: rename TS_LL_READ* macros to REG_LL_PROXY_H_*
  ice: add lock to protect low latency interface
  ice: check low latency PHY timer update firmware capability
  ice: implement low latency PHY timer updates

 drivers/net/ethernet/intel/ice/ice_common.c |   3 +
 drivers/net/ethernet/intel/ice/ice_osdep.h  |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  48 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 155 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  17 ++-
 drivers/net/ethernet/intel/ice/ice_type.h   |  12 ++
 6 files changed, 204 insertions(+), 34 deletions(-)


base-commit: 4376b34cf49c2f38e761beacd173d1dc15a255fd
-- 
2.42.0


