Return-Path: <netdev+bounces-142165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391539BDAFD
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42791F22E3A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE417BB03;
	Wed,  6 Nov 2024 01:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6bpjMOT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE57DA6A;
	Wed,  6 Nov 2024 01:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855564; cv=none; b=BqzPVof2LB3b3/Q/KH4M124BbdOz+Y9K7VBK86kBiNSQl8QDYxINO92qheKxOMrwznQwvd7GKKA0ler0mIbPuSB5r+8gjyKil3yv0h18EEbKhmU2EAuDjHsj8WqfCoxjQGGdcqmzekqmbGhoDL8HsfcHgRjNx4Jn1K29tap8TXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855564; c=relaxed/simple;
	bh=7uHxj0fPg50Fn1ZMXOTIZG4UKkbE2jcY9ppYJOvo7Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEytQfXVH6jypZONefpwqC5zjIWL3/sUARYL/J2g2qDqSoWv4v8jLEcJ54xsmewh+aa0w0uCljiPhWsg+vKXaA4mBtMTdRV9K6PuxytGm0GyD8KyBWgwmKpVJD+hcl2d7dW/et+Ts74+uFQwvNlnFgRxltoWrurP07YKRV2JmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6bpjMOT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730855563; x=1762391563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7uHxj0fPg50Fn1ZMXOTIZG4UKkbE2jcY9ppYJOvo7Ic=;
  b=B6bpjMOTObs8SaoxzBuIPBPC7wi3fzqcSAZujU52eVs5cLiZwt0i3xWs
   wbl5p9IBFFN3FmjUP1lOBqIcyBkYU9PqW20O/25INb6UpicaCOt16uyN7
   TLixDoi1wQPXXzy2SkJ191trACyzXRvAXtjFCpHnIR9XyAmBYaRDhMe/1
   d/Dfha5E4WkH/EIBxLBsGzoxpJZ6qcXrjdHfnsnyN4UOG2tNQGI8YAPn5
   Gqo5mE7qe76Uizad1h2f8a9V6BOc6LRqJ24xwmgoq0i6rc4K8QM5szW6/
   kU5Ar+qCb2dphwKAYAMrlsQW9IrLOopgpbQtH7SYm2iTZCg7WX3/4hKI3
   Q==;
X-CSE-ConnectionGUID: 8eyd4vdAS5qTeVW2uTZV8g==
X-CSE-MsgGUID: TR2awBmPTQmZuzhPM2bwLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="18254707"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="18254707"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 17:12:40 -0800
X-CSE-ConnectionGUID: FTH7TveFTraT53GM97VNFA==
X-CSE-MsgGUID: sSRzoFA0TqeVnj31oFVmxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84362754"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa008.fm.intel.com with ESMTP; 05 Nov 2024 17:12:38 -0800
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
Subject: [PATCH net-next v3 0/2] ptp: add control over HW timestamp latch point
Date: Wed,  6 Nov 2024 02:07:54 +0100
Message-Id: <20241106010756.1588973-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HW support of ptp/timesync solutions in network PHY chips can be
achieved with two different approaches, the timestamp maybe latched
either in the beginning or after the Start of Frame Delimiter (SFD) [1].

Allow ptp device drivers to provide user with control over the timestamp
latch point.

[1] https://www.ieee802.org/3/cx/public/april20/tse_3cx_01_0420.pdf

v3:
- move new enum ptp_ts_point to uapi ptp_clock.h and add NONE value to
  indicate that the timestamp latch point was not provided by the HW,
  allow further changes to ethtool netlink interface exstensions.

Arkadiusz Kubalewski (2):
  ptp: add control over HW timestamp latch point
  ice: ptp: add control over HW timestamp latch point

 Documentation/ABI/testing/sysfs-ptp         | 12 +++++
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 44 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 60 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
 drivers/ptp/ptp_sysfs.c                     | 44 +++++++++++++++
 include/linux/ptp_clock_kernel.h            | 12 +++++
 include/uapi/linux/ptp_clock.h              | 18 +++++++
 7 files changed, 192 insertions(+)

base-commit: 0452a2d8b8b98a5b1a9139c1a9ed98bccee356cc
-- 
2.38.1


