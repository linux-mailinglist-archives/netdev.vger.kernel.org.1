Return-Path: <netdev+bounces-250346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158B0D29545
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A533043F6A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D03090E6;
	Thu, 15 Jan 2026 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgW09AeK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967E24468C
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520881; cv=none; b=NV9arPr1JvWy2GcBZpAxkPw7l1UoMq6Meb25zvO1bdOb8z9agrlkywz415iO2DhPXO7aOhTnVtubSI4UBtQiZ0Bm9h/+tInQlMMVw1V8LtUdljGZaN0uci0l4yUtS9JDLIR/cZux4F/PYiboZa+TnybT3AImjuZ2Xj6l+V63uWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520881; c=relaxed/simple;
	bh=FvBR7qTYddlX+ttmOHD1KtyWSjo6sBC6BQHAdACpwbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/9H3vPQQqE3nT+6UznZySDZWmAV+3qwW3ue/sG5h5spBRl5FCbSldcA9wnuoZFFRHtDotXbJoPZNBJU2Gz9LnOYKZvVr/CLSu4HueP88Lrlp3af2hOQWiM4mSXDe5xUBpi/igPifKf0vJuAeozD1V0n04uemNan6tZqbYXg4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgW09AeK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768520878; x=1800056878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FvBR7qTYddlX+ttmOHD1KtyWSjo6sBC6BQHAdACpwbA=;
  b=QgW09AeKP+ZjRWxQuqKBcekUOlsAUyaQY2pYKdeWTJXbJtGx/AAaiJj3
   grC1m3zedDtLKchLAz4ZsTzpsCbHkXabaQDoAMJJYuGcMEa9gmWV2pnvM
   8Kw1YVlixokSqnMa7F0JZ6yJJn+qUb4j56Fwj6NF7KcbF72Qm/027Sumx
   w9AsUu6oKmlgKAxtWxa6pOZ4qiEixOWzXqgNBdt6Ym3AyfGLOkdv0nP+I
   xnsLuM58RiWEZ6wSpfb/jqPKVXxVMAUqq4sVhjtYD4IYhwcCWQ9YFy13n
   g/ichmJs3hGlxtbcl7E22ioRACS2zPgUOBk3dycGO42xhVSxDZ2CuloN/
   A==;
X-CSE-ConnectionGUID: igitPiBSSaaXKwI3x4R42w==
X-CSE-MsgGUID: JUPxWn9aRfysxOFZSMI9lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69892329"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69892329"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:47:58 -0800
X-CSE-ConnectionGUID: zFxBSkeWT62WoUZwnAlJOw==
X-CSE-MsgGUID: e/wlWytOSSGFtIUg7sFO1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="205501989"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jan 2026 15:47:58 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com
Subject: [PATCH net-next 00/10][pull request] refactor IDPF resource access
Date: Thu, 15 Jan 2026 15:47:37 -0800
Message-ID: <20260115234749.2365504-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pavan Kumar Linga says:

Queue and vector resources for a given vport, are stored in the
idpf_vport structure. At the time of configuration, these
resources are accessed using vport pointer. Meaning, all the
config path functions are tied to the default queue and vector
resources of the vport.

There are use cases which can make use of config path functions
to configure queue and vector resources that are not tied to any
vport. One such use case is PTP secondary mailbox creation
(it would be in a followup series). To configure queue and interrupt
resources for such cases, we can make use of the existing config
infrastructure by passing the necessary queue and vector resources info.

To achieve this, group the existing queue and vector resources into
default resource group and refactor the code to pass the resource
pointer to the config path functions.

This series also includes patches which generalizes the send virtchnl
message APIs and mailbox API that are necessary for the implementation
of PTP secondary mailbox.

The following are changes since commit d4596891e72cbf155d61798a81ce9d36b69bfaf4:
  net: inline napi_skb_cache_get()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Joshua Hay (2):
  idpf: move some iterator declarations inside for loops
  idpf: remove vport pointer from queue sets

Pavan Kumar Linga (8):
  idpf: introduce local idpf structure to store virtchnl queue chunks
  idpf: introduce idpf_q_vec_rsrc struct and move vector resources to it
  idpf: move queue resources to idpf_q_vec_rsrc structure
  idpf: reshuffle idpf_vport struct members to avoid holes
  idpf: add rss_data field to RSS function parameters
  idpf: generalize send virtchnl message API
  idpf: avoid calling get_rx_ptypes for each vport
  idpf: generalize mailbox API

 drivers/net/ethernet/intel/idpf/idpf.h        |  177 ++-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   18 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   93 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  219 ++--
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    |   17 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  733 +++++------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   44 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   21 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1090 +++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   88 +-
 drivers/net/ethernet/intel/idpf/xdp.c         |   48 +-
 drivers/net/ethernet/intel/idpf/xdp.h         |    6 +-
 drivers/net/ethernet/intel/idpf/xsk.c         |   12 +-
 13 files changed, 1415 insertions(+), 1151 deletions(-)

-- 
2.47.1


