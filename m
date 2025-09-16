Return-Path: <netdev+bounces-223525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB4AB59668
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261164E0EBD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE73090FB;
	Tue, 16 Sep 2025 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Abw9u3am"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774B30E0CD;
	Tue, 16 Sep 2025 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026602; cv=none; b=ZDHNNoE/uaZ0/6fI2mdgq0x/zgItbi8Ukhhcgf5JmtZXDn73kB+/jmpi0dy1ZPBU3ERFfL0Asb2cvQNK/zKmXbfw9DTHiCJtKyBDC+urbWiw2mN9ECr5FXN6Aj20Emd+fKRlEN6ccROP9dnZOpTfrR+QKP7+UfmrQ1Nw54cPpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026602; c=relaxed/simple;
	bh=a2g51RqxqAs5N7O2K7ul82m3FpPbeyFhxNQODFhCkEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTxu5DaV7+e3UdvSckQGYVVfWvMx9t4j5pBi8nyTIHss7j1VNEAGCohyDNeE39EKwdeHlgWWtbKEsYf7kkvu2CtJ2I9HMOTvh4uq99bChhcO7Lhew5LpbgeI5ygL8CcmD8kz7NJ+mRV7Bz/fQ6KhR0hdZnrd7T3Xy41eptkJZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Abw9u3am; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758026601; x=1789562601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a2g51RqxqAs5N7O2K7ul82m3FpPbeyFhxNQODFhCkEw=;
  b=Abw9u3amOoP1rRnXW2mDYN8yTL3hS9EUiQF1pz3BVG9ZCFDlkzsW7+at
   lLGfecfvuSW0/mWBwKkfr7DO654Ff98UMEwLa1pjyCoJTXsvq0dEFtvhN
   hx5nEckXwR593QeUfe48hMBbas0xjazsfJ85gRR139PKszTIOTPtV53y8
   L20xmMFyBoEc/SuFvSZ0poso0WaHlzLWs1aN0jMh4qZPKTukSKs4k+kyC
   hBs4ERt1iXjd3jBybSLkGNgfCE8UmRX9zZkAQPvlUK46m6fxfPjKef+s4
   7RA7VRvzk+xcvz+/FQf3CITNtqjlkCc5FvF9ShpYPbjgEjpNG5ANbuq6L
   A==;
X-CSE-ConnectionGUID: VqMHmfrrQiyRrvAxPTC2rg==
X-CSE-MsgGUID: xPZbkxOoTmCd30pYq4nblw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="85741996"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="85741996"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:43:20 -0700
X-CSE-ConnectionGUID: 2B9ToNttQi+1/GknYfeQCw==
X-CSE-MsgGUID: Q8CfMI/yTCSorqhABQ27cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174043160"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa006.jf.intel.com with ESMTP; 16 Sep 2025 05:43:17 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next v3 0/3] net: stmmac: new features
Date: Tue, 16 Sep 2025 14:48:05 +0200
Message-Id: <20250916124808.218514-1-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds three new patches which introduce features such as VLAN
protocol detection, TC flower filter support and enhanced descriptor
printing.

Patchset has been created as a result of discussion at [1].

v2 can be found at [2].

[1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/
[2] https://lore.kernel.org/netdev/20250828144558.304304-1-konrad.leszczynski@intel.com/

v2 -> v3:
- removed ARP offload patches
- add patch for enhanced descriptor printing

v1 -> v2:
- add missing SoB lines
- place ifa_list under RCU protection

Karol Jurczenia (1):
  net: stmmac: add TC flower filter support for IP EtherType

Piotr Warpechowski (2):
  net: stmmac: enhance VLAN protocol detection for GRO
  net: stmmac: correct Tx descriptors debugfs prints

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 40 +++++++++++++------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 ++++++++-
 3 files changed, 47 insertions(+), 13 deletions(-)

-- 
2.34.1


