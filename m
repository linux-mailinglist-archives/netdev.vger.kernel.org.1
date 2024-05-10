Return-Path: <netdev+bounces-95510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196FC8C27A8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B651E2879D7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB727171668;
	Fri, 10 May 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfMKvJKZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9917164B;
	Fri, 10 May 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354842; cv=none; b=q1nZ+aovbIVuTtHltuhqLWQ+vPpcUszEfyrm9F3iTirCkrZiIjrym0QsA1y4P9zSMNHUksF/lcd68aof0AvTSFnqWRNMoi68dAunQEsyP2rTTPP55CS7fmOy6u8IGkNWRp6QJlgjisSWjvIkpADfuRNU5hbnzsJVbGVgKd8Zl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354842; c=relaxed/simple;
	bh=Hvmu0qmiPj5Ycf5xm2DItJEUtysjIM+nHDnEiaTAzEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8pT49YkA//epJLCjT/qHqWSB0L4+4T8ReiD1ypvk20atE+PhtkiZ8aRtT9h0h4HAhEji1ytFPku/soAr1vEdenc8tUJxAa2rZhxCA8InwskSnamayGIzhI9E37KTz2oU4WSRDEZJ6cDDKck7+S0M6/kAGxGTSE1gTsTiybqJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfMKvJKZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715354841; x=1746890841;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hvmu0qmiPj5Ycf5xm2DItJEUtysjIM+nHDnEiaTAzEo=;
  b=OfMKvJKZ0MJkvu7iACby14smmxuYHmuKusdDYh3YSoDn8IASQdHDLmhV
   9/KaL7vLLs7cEhepTck1sNP3U/Z6fK/Ogih5zEC24MMKtWkSb/yWC4zqx
   erzLNSkIb2ppXYsiF5UWf3YD9ivKqhBu5HuP5b2gUQUoDlgXzl72+QJgF
   4JCclu5PuINjErKuE5n3LVJs2z1QHneGEe50cBBdYphOgl6281XPyf+zF
   MU4a8ldumlyF0+B6PGEczdi2t0O7aYqlUac7g09lvym8UZxwJw1OUpy/K
   mHWH7azhl7h8ND30ug05fg86qvbcR2bkzg5okbMGZ1xjnF5sdvapEkd4w
   Q==;
X-CSE-ConnectionGUID: 5C1KLhOBTPSTz0UY+ES9rg==
X-CSE-MsgGUID: CXpt7swhTP2lv0vbRUV37w==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15152536"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15152536"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 08:27:20 -0700
X-CSE-ConnectionGUID: mJnKh+05SiCO4F6dz7jhHA==
X-CSE-MsgGUID: e1pJtLvwQ8S1QqPIA4qM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30208229"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 10 May 2024 08:27:17 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC iwl-next 00/12] idpf: XDP chapter I: convert Rx to libeth
Date: Fri, 10 May 2024 17:26:08 +0200
Message-ID: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applies on top of "idpf: don't enable NAPI and interrupts prior to
allocating Rx buffers" from Tony's tree.
Sent as RFC as we're at the end of the development cycle and several
kdocs are messed up. I'll fix them when sending non-RFC after the window
opens.

XDP for idpf is currently 5 chapters:
* convert Rx to libeth (this);
* convert Tx and stats to libeth;
* generic XDP and XSk code changes;
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

Alexander Lobakin (12):
  libeth: add cacheline / struct alignment helpers
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
 drivers/net/ethernet/intel/idpf/Kconfig       |   25 +
 drivers/net/ethernet/intel/idpf/Makefile      |    3 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |   10 +-
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |    2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  746 ++++-----
 include/net/libeth/cache.h                    |   64 +
 include/net/libeth/rx.h                       |   19 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  152 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   88 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  311 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 1405 +++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  175 +-
 drivers/net/ethernet/intel/libeth/rx.c        |  122 +-
 15 files changed, 1726 insertions(+), 1410 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/Kconfig
 create mode 100644 include/net/libeth/cache.h

-- 
2.45.0


