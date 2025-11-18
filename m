Return-Path: <netdev+bounces-239745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A31C6C0DF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FE823506C5
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7E627E1D5;
	Tue, 18 Nov 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsbjjtlW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54153702E3
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509938; cv=none; b=guhHFat+QeXeOqdFXfh1dtu5AvyJDcLSxT3xDQfqIKXDSCcI2T3vCBOoH/b/7svt9de5gB6O5Kj4yGdQFAiP6zPXLZRGDA8DHptLcycWdL0b2l4hPHgNxGFz2TRU9HPxjOgGLoVgWr6cxsuhr/Xb1LyOD1FEhoFMV0ZpQ0UoAO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509938; c=relaxed/simple;
	bh=llTwzqOrpOj83fdTFxHIxJ8MUpS2HCqqZScBVC+1YHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnNkwMYvs/+h308gut8rQn2xS0UAVFPjWEp6Z1XV85CG4AoYVxF/1tQzUfoKAGOlS684dEs0SUVaJ6Dh9rGLTCs05JnAeNF4w7QvVRCadNfqWFAMAWEk2+miXI1jvH+8t7VaRWZgfFJXQ1opLxQyD86gOCLYRzuUdoGLYxDuPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsbjjtlW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763509937; x=1795045937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=llTwzqOrpOj83fdTFxHIxJ8MUpS2HCqqZScBVC+1YHY=;
  b=nsbjjtlWHNt5MPUxmYMR6ZNREyK2wpiiX40S8/AD032FDHQM+Y4mxijA
   jGN9cf2+QUFSKRSMnjWzMOz5/wmQs2luJai5sIeeoMXCZKKiGko4C9duo
   ygcwK3aC97/L1H3LhoN9YSs7TkoZGjmP9adbMDT+sRDC9bVT6dsqEPwCg
   lTYz8QJDoWm2ZPZ6UhaWUrFVtdbE4qJLUcwC56o9+Qp0L26YVrhWweNVr
   at5CmEqwYAbx/eghXX6X8IE9c1hu8EW8ygHyWj8g04XSntkDSwPDzzCDI
   aBj5BIijbpZza695cCeL/8NyGwDaubwLWBAHRd8VFkMmDZomds0snGwFk
   Q==;
X-CSE-ConnectionGUID: CTJo09+hQhCGSx4/6HpTrg==
X-CSE-MsgGUID: 8M/YZ3GoToyA8jDtoYGrGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76225829"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76225829"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:52:16 -0800
X-CSE-ConnectionGUID: 5uy7lFuPQNqPowPgeBCPsg==
X-CSE-MsgGUID: ShqZACPhSM2L4y0iI5CYNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190699489"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Nov 2025 15:52:16 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2025-11-18 (idpf, ice)
Date: Tue, 18 Nov 2025 15:52:03 -0800
Message-ID: <20251118235207.2165495-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to idpf and ice drivers.

Emil adds a check for NULL vport_config during removal to avoid NULL
pointer dereference in idpf.

Grzegorz fixes PTP teardown paths to account for some missed cleanups
for ice driver.

The following are changes since commit 0f08f0b0fb5e674b48f30e86c103760204a1d3f3:
  net: ps3_gelic_net: handle skb allocation failures
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Emil Tantilov (1):
  idpf: fix possible vport_config NULL pointer deref in remove

Grzegorz Nitka (1):
  ice: fix PTP cleanup on driver removal in error path

 drivers/net/ethernet/intel/ice/ice_ptp.c    | 22 ++++++++++++++++++---
 drivers/net/ethernet/intel/idpf/idpf_main.c |  2 ++
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.47.1


