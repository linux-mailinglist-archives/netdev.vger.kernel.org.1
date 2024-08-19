Return-Path: <netdev+bounces-119908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD0C957776
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21321C210A4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9915DBC1;
	Mon, 19 Aug 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9R8kFSm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774F157484
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106891; cv=none; b=q9LtGqwIKSnjA/gpJtPO1hGsrsTjFtHuzclHWEBOPV2xsjGEgpQ+sCKKP2Mn44OoRKBW0XXNzeXVMxrf0aVdBq704Y2/aZrh/CGc8GqnAEJ9ZgGwg2R9gH3bq0GlXCGRLnbEyzmoeBX1MMg5vfLh6IanKAYfZSWnUx9wjhmY7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106891; c=relaxed/simple;
	bh=HQYgitqrqxrEYFp2CjDBnooCR1A6xFTOA7a/Hofs33E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SudI5NKHNRWaGJHeNDiUC+L0Pik7UqEXR7m1BWeS7QhoW/gI5WA334vf57Ff3c+/AElvspXFhxsY936SYyNo+SSepIlmu21rrNyrSerHSOOgqPwpQFg5ZN4NCCHNwDuAdc31PkCIZskpTChTPUXNAcglyvHZFpFvlOPjcUDuO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9R8kFSm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724106890; x=1755642890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HQYgitqrqxrEYFp2CjDBnooCR1A6xFTOA7a/Hofs33E=;
  b=a9R8kFSmVcqMBfKttgT724e18O4GY+CMrBXYUqNqqoaCmAlfnYv/ojm2
   HkXw0Bm+JQE6LAnDXhtFLkzg7FVirVT0iHgO5yuNt7rh3FLWKdWhEQyL2
   OEFbt11mve18imCYepWqx4qR4P6s4mINtYZv4QcKE0Q8nq9KJCjqWNbtW
   OtoFvlyDIlKyQxVAsTjCj8hDbizzV7qmccrQRws+Hdqqnd+a29sYDLXBJ
   HQ3GoKV/H53lioBcHSokirEmcNb3TSZTKU57ADr2m+XWp2BYCtpMKuSNM
   56ZRJb/NHUYFLIzG2rNoZbyfB+q3zJxZbJKeAMDFSllDatCWo1k1fAvLv
   g==;
X-CSE-ConnectionGUID: Raha2oi7RgGzNjBvk64SfA==
X-CSE-MsgGUID: iSoh9U2JTUKSGrQOWQ1fmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33535145"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33535145"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:34:49 -0700
X-CSE-ConnectionGUID: tYlSd9tYQEiASb4B95iGOw==
X-CSE-MsgGUID: BvPng5IbROyQ1/ApivPzUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="64700497"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 15:34:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	joshua.a.hay@intel.com,
	michal.kubiak@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com
Subject: [PATCH net-next v2 0/9][pull request] idpf: XDP chapter II: convert Tx completion to libeth
Date: Mon, 19 Aug 2024 15:34:32 -0700
Message-ID: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin says:

XDP for idpf is currently 5 chapters:
* convert Rx to libeth;
* convert Tx completion and stats to libeth (this);
* generic XDP and XSk code changes;
* actual XDP for idpf via libeth_xdp;
* XSk for idpf (^).

Part II does the following:
* introduces generic libeth per-queue stats infra;
* adds generic libeth Tx completion routines;
* converts idpf to use generic libeth Tx comp routines;
* fixes Tx queue timeouts and robustifies Tx completion in general;
* fixes Tx event/descriptor flushes (writebacks);
* fully switches idpf per-queue stats to libeth.

Most idpf patches again remove more lines than adds.
The perf difference is not visible by eye in common scenarios, but
the stats are now more complete and reliable, and also survive
ifups-ifdowns.
---
v1: https://lore.kernel.org/netdev/20240814173309.4166149-1-anthony.l.nguyen@intel.com/
- Rebased

iwl: https://lore.kernel.org/intel-wired-lan/20240806131240.800259-1-aleksander.lobakin@intel.com/

The following are changes since commit 1bf8e07c382bd4f04ede81ecc05267a8ffd60999:
  dt-binding: ptp: fsl,ptp: add pci1957,ee02 compatible string for fsl,enetc-ptp
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alexander Lobakin (6):
  unroll: add generic loop unroll helpers
  libeth: add common queue stats
  libie: add Tx buffer completion helpers
  idpf: convert to libie Tx buffer completion
  netdevice: add netdev_tx_reset_subqueue() shorthand
  idpf: switch to libeth generic statistics

Joshua Hay (2):
  idpf: refactor Tx completion routines
  idpf: enable WB_ON_ITR

Michal Kubiak (1):
  idpf: fix netdev Tx queue stop/wake

 drivers/net/ethernet/intel/idpf/idpf.h        |  21 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   2 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 498 ++--------------
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  32 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 172 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 539 +++++++++---------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 144 ++---
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  37 +-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  33 +-
 drivers/net/ethernet/intel/libeth/Makefile    |   4 +-
 drivers/net/ethernet/intel/libeth/netdev.c    | 157 +++++
 drivers/net/ethernet/intel/libeth/priv.h      |  21 +
 drivers/net/ethernet/intel/libeth/rx.c        |   5 -
 drivers/net/ethernet/intel/libeth/stats.c     | 360 ++++++++++++
 include/linux/netdevice.h                     |  13 +-
 include/linux/unroll.h                        |  50 ++
 include/net/libeth/netdev.h                   |  31 +
 include/net/libeth/stats.h                    | 141 +++++
 include/net/libeth/tx.h                       | 127 +++++
 include/net/libeth/types.h                    | 247 ++++++++
 21 files changed, 1634 insertions(+), 1002 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libeth/netdev.c
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 drivers/net/ethernet/intel/libeth/stats.c
 create mode 100644 include/linux/unroll.h
 create mode 100644 include/net/libeth/netdev.h
 create mode 100644 include/net/libeth/stats.h
 create mode 100644 include/net/libeth/tx.h
 create mode 100644 include/net/libeth/types.h

-- 
2.42.0


