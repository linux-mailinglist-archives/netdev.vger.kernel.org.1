Return-Path: <netdev+bounces-105310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174549106E5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DC61C21884
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CF91AD49B;
	Thu, 20 Jun 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcvhT40C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480131AC782;
	Thu, 20 Jun 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891784; cv=none; b=C3uRtDDPJdpeJ2IeJDI4XW9v7GNJbZfrx2NBM8yiCwF0TgPKBDY8eQyL9xp4HFjvDp1Q7/jxsc6hMFv3xfUFJoT5S+oGmDM5dDPtoCqXh8a00NqAsGhT5pn55e30COsXb0ojCIiPnj7657pNKma/vBDW6OcmmL8wEv34frHjveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891784; c=relaxed/simple;
	bh=l5CCEC9MovHn87sutgB7KfaIHIgWDh73rpUM0x5SHjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WD8zLDsVl3dKamPVuBk5tSO7U1EfW15d2rjmj8KE0/fe+Sjc+6M6LGYaGZKbCmKo1hW5kaODxqVAyo1meuUaVv7pL1crv+G+fppqCcWrmGT+4H2r2/P4C3ujdkvJ0yvBcajumZ6V6P8RO3KHveAclaTyyYyfruFETO/FnH8L5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcvhT40C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718891783; x=1750427783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l5CCEC9MovHn87sutgB7KfaIHIgWDh73rpUM0x5SHjk=;
  b=bcvhT40CHtBl6PpB1lCcAhffoZcJ6ARETHjS6fd4hAnwARkMJge0fv4g
   cirJRv258Q00FDUTSunzRCEA0jr/ZXJZrrUjy8P2I5tm1/IAS7v2FHEja
   oBvOpmYkITaS7Qkyf0D0UWrRu0/KUlc0PgrDCDAVa6V4LOrTktZG9WQUS
   uVHw4z6druDsVOLEgJyqE8R9CFaJNHgljIVroN38ZIX6zzeKtKsKAeA68
   KojOzCT9V7mEUH/CKhFQwuMSZn9PkwJlcJJFjrR22NZFEBpBFiFjc42iQ
   +ButB2Zw+Rrxe5XnXEm572BN3ftnjzoWv7F5iaTlG4FW1W6Fr+hTYlbw2
   A==;
X-CSE-ConnectionGUID: swKrtWD/RZmJzIypXFmQZw==
X-CSE-MsgGUID: 9/eKUE9YRsWA4vp2uPuufw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15987766"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15987766"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:56:22 -0700
X-CSE-ConnectionGUID: LgJEYDKKSF+XcN9BD0ATpA==
X-CSE-MsgGUID: DzuNFawVSnGs6JO2uwcUWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46772031"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jun 2024 06:56:18 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 00/14] idpf: XDP chapter I: convert Rx to libeth
Date: Thu, 20 Jun 2024 15:53:33 +0200
Message-ID: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP for idpf is currently 5 chapters:
* convert Rx to libeth (this);
* convert Tx and stats to libeth;
* generic XDP and XSk code changes, libeth_xdp;
* actual XDP for idpf via libeth_xdp;
* XSk for idpf (^).

Part I does the following:
* splits &idpf_queue into 4 (RQ, SQ, FQ, CQ) and puts them on a diet;
* ensures optimal cacheline placement, strictly asserts CL sizes;
* moves currently unused/dead singleq mode out of line;
* reuses libeth's Rx ptype definitions and helpers;
* uses libeth's Rx buffer management for both header and payload;
* eliminates memcpy()s and coherent DMA uses on hotpath, uses
  napi_build_skb() instead of in-place short skb allocation.

Most idpf patches, except for the queue split, removes more lines
than adds.
Expect far better memory utilization and +5-8% on Rx depending on
the case (+17% on skb XDP_DROP :>).

Alexander Lobakin (14):
  cache: add __cacheline_group_{begin,end}_aligned() (+ couple more)
  page_pool: use __cacheline_group_{begin,end}_aligned()
  libeth: add cacheline / struct layout assertion helpers
  idpf: stop using macros for accessing queue descriptors
  idpf: split &idpf_queue into 4 strictly-typed queue structures
  idpf: avoid bloating &idpf_q_vector with big %NR_CPUS
  idpf: strictly assert cachelines of queue and queue vector structures
  idpf: merge singleq and splitq &net_device_ops
  idpf: compile singleq code only under default-n CONFIG_IDPF_SINGLEQ
  idpf: reuse libeth's definitions of parsed ptype structures
  idpf: remove legacy Page Pool Ethtool stats
  libeth: support different types of buffers for Rx
  idpf: convert header split mode to libeth + napi_build_skb()
  idpf: use libeth Rx buffer management for payload buffer

 drivers/net/ethernet/intel/Kconfig            |   13 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |   26 +
 drivers/net/ethernet/intel/idpf/Makefile      |    3 +-
 include/net/page_pool/types.h                 |   22 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |   11 +-
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |    2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  734 +++++----
 include/linux/cache.h                         |   59 +
 include/net/libeth/cache.h                    |   66 +
 include/net/libeth/rx.h                       |   19 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  152 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   88 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  306 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 1412 +++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  178 ++-
 drivers/net/ethernet/intel/libeth/rx.c        |  132 +-
 net/core/page_pool.c                          |    3 +-
 18 files changed, 1824 insertions(+), 1403 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/Kconfig
 create mode 100644 include/net/libeth/cache.h

---
From v1[0]:
*  *: pick Reviewed-bys from Jake;
* 01: new, add generic __cacheline_group_{begin,end}_aligned() and
      a couple more cache macros;
* 02: new, make use of new macros from 01;
* 03: use macros from 01 (no more struct_group()), leave only
      aggressive assertions here;
* 07: adjust to the changes made in 01 and 03;
      fix typos in the kdocs;
* 13: fix typos in the commit message (Jakub);
* 14: fix possible unhandled null skb (Simon, static checker).

From RFC[1]:
*  *: add kdocs where needed and fix the existing ones to build cleanly;
      fix minor checkpatch and codespell warnings;
      add RBs from Przemek;
* 01: fix kdoc script to understand new libeth_cacheline_group() macro;
      add an additional assert for queue struct alignment;
* 02: pick RB from Mina;
* 06: make idpf_chk_linearize() static as it's now used only in one file;
* 07: rephrase the commitmsg: HW supports it, but never wants;
* 08: fix crashes on some configurations (Mina);
* 11: constify header buffer pointer in idpf_rx_hsplit_wa().

Testing hints: basic Rx regression tests (+ perf and memory usage
before/after if needed).

[0] https://lore.kernel.org/netdev/20240528134846.148890-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20240510152620.2227312-1-aleksander.lobakin@intel.com
-- 
2.45.2


