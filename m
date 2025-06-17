Return-Path: <netdev+bounces-198753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C6ADDA9F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA9B161F59
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDD23AE84;
	Tue, 17 Jun 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lL8A7OyG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C71AAA1B
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181090; cv=none; b=arnhan2Hva7B/8Za5zJd7/ULvSqrEJZmJYp+8QFuYnoTDFnxiW+BLjjpcS+T/c83p631I3P0N6XgL6qUP4z8ujiVpmV7CmULFvJmuhQVLbIIVkzybh932BFXDdRx/LF6GrROFysEQQc2JoeFRgMs8O9Sek8zvAMC2NaIGxqu4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181090; c=relaxed/simple;
	bh=zlUfgntvOmmtXy+oBL60u2DJq6qE35FbZYNT2x4Unes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/GAKUu6mQZmS53aAvNh9kCKBvnfZP7dmM3Kl5dRYlT6uAR+EloOWDCXneTKn7xGgtqMu7O1h0crvrW55LHPOpKmcArscgimHX60/4/ds4s5FQnCcpiVbNIQSt9TCIGTR4so09GKWgZGx4aT1c5xVAmHehAiz/ElAiUxeF+ress=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lL8A7OyG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750181089; x=1781717089;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zlUfgntvOmmtXy+oBL60u2DJq6qE35FbZYNT2x4Unes=;
  b=lL8A7OyG/bNPrUX4aUaG2mKncSbu3Mx1Zjl7MGcVmUm+OSdlTtqND1nS
   r7Q+wjyOuS1wLAXNsJbm2QPPYbQuY1QwZvZWtilLtZu9WUp5ncR//Qbr3
   xZqvb4HqjRdK3xwalWvFg6oRm59tpk8mzsfy6KjVyEcMMMn5X9ORbiuec
   doWZHBm+eR1uqDEm+pxNRQtH+GzNXPVz4bKboHH42PVoeFJnPbh/ZJ4m5
   mdjeu+UoLohezBOswN9ckQ06a4bSmnNTZR0XD2s7Fy2rh1sB5cWfD2xfc
   uNy1Q3Hejwmxkyd6INHX61WrB/2tW68UiSZhtxPPRPUtfrs8e7hEGGNy6
   A==;
X-CSE-ConnectionGUID: jPZ2QYcoR9O2JQkaSjn2/g==
X-CSE-MsgGUID: OLIyU4tgRqCvCVorcoa9Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="69820111"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="69820111"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 10:24:49 -0700
X-CSE-ConnectionGUID: JAvfwKtBRTCzl6GrkwDHKQ==
X-CSE-MsgGUID: fdMN0n7yQamPnFOrU++/xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="152741160"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jun 2025 10:24:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2025-06-17 (ice, e1000e)
Date: Tue, 17 Jun 2025 10:24:40 -0700
Message-ID: <20250617172444.1419560-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Krishna Kumar modifies aRFS match criteria to correctly identify
matching filters.

Grzegorz fixes a memory leak in eswitch legacy mode.

For e1000e:
Vitaly sets clock frequency on some Nahum systems which may misreport
their value.

The following are changes since commit 7b4ac12cc929e281cf7edc22203e0533790ebc2b:
  openvswitch: Allocate struct ovs_pcpu_storage dynamically
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Grzegorz Nitka (1):
  ice: fix eswitch code memory leak in reset scenario

Krishna Kumar (1):
  net: ice: Perform accurate aRFS flow match

Vitaly Lifshits (1):
  e1000e: set fixed clock frequency indication for Nahum 11 and Nahum 13

 drivers/net/ethernet/intel/e1000e/netdev.c   | 14 ++++--
 drivers/net/ethernet/intel/e1000e/ptp.c      |  8 ++--
 drivers/net/ethernet/intel/ice/ice_arfs.c    | 48 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  6 ++-
 4 files changed, 69 insertions(+), 7 deletions(-)

-- 
2.47.1


