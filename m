Return-Path: <netdev+bounces-116261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46891949AF6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B5A280E5B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC3165F08;
	Tue,  6 Aug 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2wfgLvj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189368249F
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982179; cv=none; b=LxYzxkOIVYu0/t+LOnc1RVIBtS4aS1tI7wIFyCCZqb86qj443yag2J0iNsDF15YHyUWVqwrkaQjK8B+TS331VWQ89TazsxNVz78/cMzBErMjym65rTFlt3IQk5KLjClPqGq0qy94GTCLskb1Fszvl57tHIs4LowyqLl/ykUJAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982179; c=relaxed/simple;
	bh=lCnonmhX7dOMs1Jp3nN+brnLKDArm0AjbgIADIUdERg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2m8w6o6bLBxTX0mXpNmaR61KBYgrCmJyrLiOiQWKpnbeUp4fIgAPY/gtJh82qIvAR/lkNm1PoY2+vThBBjRvvgJxPxUkRzwahv7FvC0Ujb8snTeQ+8pmd2EpMa3+HhZsvsVHaH/GGB1ivUPUWny2PZaxAQeTTIvODvcIeyDI/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2wfgLvj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982178; x=1754518178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lCnonmhX7dOMs1Jp3nN+brnLKDArm0AjbgIADIUdERg=;
  b=f2wfgLvj7B7wNM1QxcDvydrw3sGJ+saf/DeSh8QxkORR+dTv0ZBbfU1z
   6AlmZR5P47YwBzU5UuWUjtEnNw6UhD/GLFiQ5tUHU1SMYEF4xnNs2Lxkn
   qB3p4OLcYF5vEqhmHxnwY74h68xSYx9c3KyXkFm3sPFV1pHCghnFV1jIc
   Rk96VedBQ0ebEw6W/ChI+lTgB+R+fHdJU0UCmFbPsCohSjXOAfz/FONxM
   cTg8BauX/zeGDHTYClotmT1R7m0432tcRpxzfzKHJYJ103CsqUvaHUWWa
   +8baAIgRdWT/zsLGO/sEAL0fQ5gqCIVUOpdxrGfaUxDRcriPS92eZ1lg2
   g==;
X-CSE-ConnectionGUID: 3aXcR2HMTYeYveHbJUuhBw==
X-CSE-MsgGUID: xFNpbtQQTym9gx3mTytm9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21172185"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21172185"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:09:37 -0700
X-CSE-ConnectionGUID: w9YvLfaKQ4emSSQstFh/0g==
X-CSE-MsgGUID: JBbekgjgS42TzT23i0Kl5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56297902"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Aug 2024 15:09:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Subject: [PATCH net 0/3][pull request] idpf: fix 3 bugs revealed by the Chapter I
Date: Tue,  6 Aug 2024 15:09:19 -0700
Message-ID: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin says:

The libeth conversion revealed 2 serious issues which lead to sporadic
crashes or WARNs under certain configurations. Additional one was found
while debugging these two with kmemleak.
This one is targeted stable, the rest can be backported manually later
if needed. They can be reproduced only after the conversion is applied
anyway.
---
iwl-net: https://lore.kernel.org/intel-wired-lan/20240724134024.2182959-1-aleksander.lobakin@intel.com/

The following are changes since commit 3e7917c0cdad835a5121520fc5686d954b7a61ab:
  net: linkwatch: use system_unbound_wq
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Alexander Lobakin (2):
  idpf: fix memory leaks and crashes while performing a soft reset
  idpf: fix UAFs when destroying the queues

Michal Kubiak (1):
  idpf: fix memleak in vport interrupt configuration

 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 48 ++++++++++-----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 43 ++++--------------
 2 files changed, 33 insertions(+), 58 deletions(-)

-- 
2.42.0


