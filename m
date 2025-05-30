Return-Path: <netdev+bounces-194425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BCAC96E5
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52601C02B1B
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1262367CA;
	Fri, 30 May 2025 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+SCgGSw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7B517BD3
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639547; cv=none; b=hhkf7ROLa/lHxBHfceCSulVS7Vn9jiCNkP9kD8d/oV/Ff9DS47HUDkAIDmfwQwzAjKu7f92IP66MCm78oxnv5Ji42mfzgyzfii2RAdfsdQVznilNYz0jBOSmmzXp4JMvqe2lPEXVf1hWn0inyR7Wgh6Sw9xYA10ADoHhOue1TO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639547; c=relaxed/simple;
	bh=vhNtsPlnrgj8dv5G8ecLNisX57jn+IeFQ4j4vNlF7vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkxIdTWMwyvIgiV7wxKLgoFgSmcr+SDTQJ5fiboOX+6R2pshnt0MWLhucaqJD0HYkgMQs1ouQ+cb3+w60tlyrxNmv7Zpz9JoVVcewoBET3yDQig0dQEo/yzf7fJrsv0FF7DaYWNnVJsF7EMCmhaVypXaYNBcoshSN0OGZoOpZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+SCgGSw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748639546; x=1780175546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vhNtsPlnrgj8dv5G8ecLNisX57jn+IeFQ4j4vNlF7vs=;
  b=m+SCgGSwLnid8cx8qWsO0jt544Io4TLjlfaQ/7itcOMOg5WkSLYhveam
   LFeN5adlgG89oDr/AwrnbezzEfFIzjyg3vQFUixqyZINg6qubpt7hAtcP
   a5c/buzyNRJ6ULCbBL+s6Ka4Kxh+ESEA+iR5PusYOzwbxgyKgY9ThUD3/
   fbCQggGv8nw0ducYZoCq0ibG32LsIrBasNjKzt2Aynij7ZM9HjlYkQz02
   l7usXYJXT+LFQZoI0i8kPDZDRbKMolvqrZ/QBfnZlVKfKO4RujPD0uOFz
   XNcTvWCDmIKuflPmfXAIGRpctixHmwkGJGWTcF6qylWTBpvdcG05HTYvV
   w==;
X-CSE-ConnectionGUID: YYpBNDTrSgapAqu1YJrn1w==
X-CSE-MsgGUID: QW1tdAvJRQGSnrwb9SPp0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="49862590"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="49862590"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 14:12:25 -0700
X-CSE-ConnectionGUID: Q5TJu9mvQtGRZhlIefeYzw==
X-CSE-MsgGUID: nX4kAk8VR/2tx28f4529Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144621669"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 30 May 2025 14:12:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2025-05-30 (ice, idpf)
Date: Fri, 30 May 2025 14:12:14 -0700
Message-ID: <20250530211221.2170484-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Michal resolves XDP issues related to Tx scheduler configuration with
large number of Tx queues.

Additional information:
https://lore.kernel.org/intel-wired-lan/20250513105529.241745-1-michal.kubiak@intel.com/

For idpf:
Brian Vazquez updates netif_subqueue_maybe_stop() condition check to
prevent possible races.

Emil shuts down virtchannel mailbox during reset to reduce timeout
delays as it's unavailable during that time.

The following are changes since commit d3faab9b5a6a0477d69c38bd11c43aa5e936f929:
  net: usb: aqc111: debug info before sanitation
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Brian Vazquez (1):
  idpf: fix a race in txq wakeup

Emil Tantilov (1):
  idpf: avoid mailbox timeout delays during reset

Michal Kubiak (3):
  ice: fix Tx scheduler error handling in XDP callback
  ice: create new Tx scheduler nodes for new queues only
  ice: fix rebuilding the Tx scheduler tree for large queue counts

 drivers/net/ethernet/intel/ice/ice_main.c     |  47 +++--
 drivers/net/ethernet/intel/ice/ice_sched.c    | 181 ++++++++++++++----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  18 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   9 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  45 ++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   8 -
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   1 +
 8 files changed, 218 insertions(+), 93 deletions(-)

-- 
2.47.1


