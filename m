Return-Path: <netdev+bounces-210174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57414B12406
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89993166C39
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DC5258CD3;
	Fri, 25 Jul 2025 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6pu5GV8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58F2550AF
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468492; cv=none; b=tUQmd2igext8rGQta2psdpGv3NVsf53LpO5+SfBomF4gaZIBcz9J8DMnLdWXGsDUC3r2dCPZ84Obi2Puen7nwIO/Xr3h3YOyMnpYkhkv/V6VRYANIFGmvuPiGmg6v+XR6DbrrYyw0mwo4farx+L/d8SLZEyjhuhgS+9ZDqCBKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468492; c=relaxed/simple;
	bh=YTbYY2bm7XH8SBLFJ+M84jk1vGPJeS0Rcpzvb0M8XqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fyZcLAEIAZwcSJLuAT8fV+53iOhd5SKQ5FxScSZ3zK4Ao9EJDsVgt0xjVnac0r3U2xnQLg3mcE4izHiRzUVHKctGJcrXp/vlOVLOVpr4oo3LIui5cCmSWMsW8EftdYjnd0i7hozCgO8o/2bXpvntq0P96X+h6mqqtbJS5s/0wEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6pu5GV8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753468490; x=1785004490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YTbYY2bm7XH8SBLFJ+M84jk1vGPJeS0Rcpzvb0M8XqM=;
  b=I6pu5GV8u0nf8pr+Uka9p5VhIIaS+917hgnDt+ra/rUUoO0ft7Crjyqc
   ilNw8v5jAXSVrw8cuBWTeUYbLeHh8OcxugcvihDiMgRiVfuhMvq2I83Fb
   EDsxs9tJaF52rfM6HIm7vBWp8z2t2otzuRJtxNRxFHjgiL7jnUROYRE46
   LVyCS/tUcwXUWhXG/aR2oLMVrbNwNMdxcMwLGcqOXm8OxNUTYcozDeUEO
   VT8DwWaXuaZc9Om2uzOI8cJaDhccmUiwz0kFnxdh22/YwQzV6LqZQzqAj
   Pg58sZTdtiwjbrfU+OJmRHb4UmGBEt3PQqg0CV6YG9aq7Gi7ZaVlNYMrC
   g==;
X-CSE-ConnectionGUID: uwotw0KMTHOwQGA5koSAmA==
X-CSE-MsgGUID: Jb6Wsfr+QnKWoFHVQ44hCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="81252334"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="81252334"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 11:34:49 -0700
X-CSE-ConnectionGUID: ylsHY4aGSha1zb4ZC/5cPw==
X-CSE-MsgGUID: 0eG/o7oHTO+htGAzRgtL3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="160803940"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by orviesa009.jf.intel.com with ESMTP; 25 Jul 2025 11:34:50 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net v3 0/6] idpf: replace Tx flow scheduling buffer ring with buffer pool
Date: Fri, 25 Jul 2025 11:42:17 -0700
Message-Id: <20250725184223.4084821-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a stability issue in the flow scheduling Tx send/clean
path that results in a Tx timeout.

The existing guardrails in the Tx path were not sufficient to prevent
the driver from reusing completion tags that were still in flight (held
by the HW).  This collision would cause the driver to erroneously clean
the wrong packet thus leaving the descriptor ring in a bad state.

The main point of this fix is to replace the flow scheduling buffer ring
with a large pool/array of buffers.  The completion tag then simply is
the index into this array.  The driver tracks the free tags and pulls
the next free one from a refillq.  The cleaning routines simply use the
completion tag from the completion descriptor to index into the array to
quickly find the buffers to clean.

All of the code to support the refactor is added first to ensure traffic
still passes with each patch.  The final patch then removes all of the
obsolete stashing code.

---
v3:
- Remove unreachable code in patch 4
- Update comment format

v2:
https://lore.kernel.org/intel-wired-lan/20250718002150.2724409-1-joshua.a.hay@intel.com/T/#t

v1:
https://lore.kernel.org/intel-wired-lan/c6444d15-bc20-41a8-9230-9bb266cb2ac6@molgen.mpg.de/T/#maf9f464c598951ee860e5dd24ef8a451a488c5a0


Joshua Hay (6):
  idpf: add support for Tx refillqs in flow scheduling mode
  idpf: improve when to set RE bit logic
  idpf: simplify and fix splitq Tx packet rollback error path
  idpf: replace flow scheduling buffer ring with buffer pool
  idpf: stop Tx if there are insufficient buffer resources
  idpf: remove obsolete stashing code

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  61 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 722 +++++++-----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  87 +--
 3 files changed, 355 insertions(+), 515 deletions(-)

-- 
2.39.2


