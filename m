Return-Path: <netdev+bounces-249571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351BD1B136
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40DD93017EDB
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75A36AB45;
	Tue, 13 Jan 2026 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hs35PnxA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88435E527
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333115; cv=none; b=AU8I3q0+91wclZwUuQGAuBG69TwQJ6hNlI8k+IDKT7duejtFIIUr9b+L2VrNDsJkBBNgrlB49rzx9Esa1H3XpH/1xZxP1+U6nhpwSyDbwhFhOBIlzDwaE/dFoHPUpRPbB0Ll3m7emJF2BC86yP/bKnvbulTtp6PLGIZaByGOC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333115; c=relaxed/simple;
	bh=2gbzhVuNwRNOd9dlkUNSoRgPuCM89j0AQ4uN19D6hAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIfi8cB3CZYZTcAqZW213HXN5yxPvkkEAdV1oE73a0PBdvq1gg5H2x3CI47euAI8x7cZdqKPqnOcgGMWzwHSHErktCICI5PAiTUpWwqirG+o6GsyS4gYw+Un+dDt5byUQ7Wb2IRkfum/HseemeOmHytZV9vjLJHR4bUXOL1jMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hs35PnxA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768333114; x=1799869114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2gbzhVuNwRNOd9dlkUNSoRgPuCM89j0AQ4uN19D6hAc=;
  b=hs35PnxAH9RtqPJKzTo/4OynvULR/kDk/Tp8HUv6244II3K2g0nHH/D9
   nKWfzlM7TcQ6QGtv8tWA/qjNm+pzv7rlbH0qZ5DNVRXTAuTdoKwoqJAVD
   m3uhg3l8ZokrbneLdrPjh4fLZWIUs0v7APxDjZGB3cU7a8dbsj789g0ON
   m2D2QHyK3006F9ZyKTyz4KnCj8glzZ+W3U9THDvs/3PwGxdH9Z5iYzRf9
   72IzHrcL677+mSW/TlQldCJoObZOXdA0z/PKTobcNevynGoVKqmnLyZTq
   t04fJmDdfBCcVxI1Ln/B62F387sIdBJfTgbdU2UlLGGzat1PHjgbV/Dtv
   A==;
X-CSE-ConnectionGUID: 6Zm9JV/MT8CQi2Xs157smQ==
X-CSE-MsgGUID: WQs9MZSQQxKJJp1wGQSz4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80993457"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80993457"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 11:38:33 -0800
X-CSE-ConnectionGUID: dqbogUP1SDWLHc3Tc6vOxA==
X-CSE-MsgGUID: 6+zm8e20QCatRrFaKjpMhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="208628974"
Received: from kasadzad-mobl.ger.corp.intel.com (HELO soc-5CG4396XFB.clients.intel.com) ([10.94.252.226])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 11:38:33 -0800
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH iwl-net 0/2] ice: fix AQ command 0x06EE usage by retrying
Date: Tue, 13 Jan 2026 20:38:15 +0100
Message-ID: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

The Admin Queue (AQ) command 0x06EE can return EBUSY when firmware link
management holds the i2c bus used to communicate with the module.

According to Intel(R) Ethernet Controller E810 Datasheet Rev 2.8 [1]
Section 3.3.10.4 Read/Write SFF EEPROM (0x06EE)
request should be retried upon receiving EBUSY from firmware.

Instead of relying on the caller of ice_aq_sff_eeprom() to implement
retrying, use the existing retry infrastructure in ice_sq_send_cmd_retry()
to always attempt retry on receiving EBUSY.

Reproduction steps
------------------
	# ethtool -m <interface_name>
	netlink error: Input/output error

Link: https://www.intel.com/content/www/us/en/content-details/613875/intel-ethernet-controller-e810-datasheet.html [1]

Jakub Staniszewski (2):
  ice: reintroduce retry mechanism for indirect AQ
  ice: fix retry for AQ command 0x06EE

 drivers/net/ethernet/intel/ice/ice_common.c  | 13 ++++++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 35 ++++++++------------
 2 files changed, 24 insertions(+), 24 deletions(-)


base-commit: 855e576f30278714c7ca067005f46807aca2e6d4
-- 
2.51.0


