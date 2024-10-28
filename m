Return-Path: <netdev+bounces-139669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86DF9B3C50
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD381F240D1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119D1DFE20;
	Mon, 28 Oct 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXS/iS/9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41718E74D;
	Mon, 28 Oct 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148770; cv=none; b=G/qpkXJyq65dUvXIs6j9BeqLqvj75UfE9L5jNzUdF1Gn15RB728PHoP84ZDcO/MAd4Mv3a62EL9viNbKDnXZDWw+FClkx0APNiv2PcOcon0Pweoi8UnOB/vw0TWpqXKbFrlrp9y1ejbOm0tKEaUN9GLixcYsb70DPCI2DWcmXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148770; c=relaxed/simple;
	bh=YVZg364ptJ72Fklhh29w8DZbzdTPXGbfqRhiLiXk/xI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVxHFlSNSvaTObMoOo9VicN9ED0Psihm0ZAPXAx3Zwre1KYoscz66q29mQ8IKK8xNxOrQPPcvlIcLuMy/vI1wznDrOt4xKFK6H8MnXBVb7Y852PfdXAVY816rVmyvLzmzLqjjijMCWjA2r87X51VNI51MNur0MlRQvMq7t80Wek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXS/iS/9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730148766; x=1761684766;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YVZg364ptJ72Fklhh29w8DZbzdTPXGbfqRhiLiXk/xI=;
  b=DXS/iS/9qPK/hcqljU8DVAO77av/2LtdmwzCyTLwdRqiduloBZrHBT7g
   rrJ/tVJ+f8fz6yHZpJTOiFVU/pnZU7ABieCXSHxNOha2GXgqcMgLliEgn
   PIjTG4teMtzEjkm1AbxLDuMk2Sb4Jkk7OfIF/1FIq5M/Vtx4d0IjKXyfV
   3wz1dJbValdoSsKb/YWeTqKam4/YkNlXYExPDaZfSYwTB45h3s4PhvlFQ
   mpv4LZ9xfe5TwHtNzcClQepff2Vk68aiZvVEdLVAn4t9PQvPfIAL+y5m0
   dwYGrx6Erd3M2mGI/ELfC92Z4D5Aywq3kDt8eJekGKlGQBQ6qk2byaMNm
   g==;
X-CSE-ConnectionGUID: 3YtJGQ9tQWWssIDJTKg5tg==
X-CSE-MsgGUID: r4Q3nA61SGixuUO5wdFVGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="40343535"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="40343535"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:52:45 -0700
X-CSE-ConnectionGUID: gJu44IRbQICm3vla+aOuxQ==
X-CSE-MsgGUID: gmvpQjH2SQOQVNio/Cey/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="81358537"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2024 13:52:42 -0700
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
Subject: [PATCH net-next v2 0/2] ptp: add control over HW timestamp latch point
Date: Mon, 28 Oct 2024 21:47:53 +0100
Message-Id: <20241028204755.1514189-1-arkadiusz.kubalewski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 44 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 59 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
 drivers/ptp/ptp_sysfs.c                     | 44 +++++++++++++++
 include/linux/ptp_clock_kernel.h            | 30 +++++++++++
 6 files changed, 191 insertions(+)

-- 
2.38.1


