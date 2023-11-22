Return-Path: <netdev+bounces-49926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 129837F3E58
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 07:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68AD1F2292C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 06:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB82125D7;
	Wed, 22 Nov 2023 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUf4uS7T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F57110
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 22:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700635895; x=1732171895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lnk0AR0iJLU/GDfM/FT+r8pH4x2MEkHin41VaFUQH9s=;
  b=BUf4uS7TeD7ef1ikLMLk9Jxo4u/eac9ddtMHwW6cRMDLnRd+OwUNk9Eh
   Vt6qPNwh9ESY7viia57OsgdEOk6Ggkom6WOqx1loNDjFwQLUvyyxSNbwr
   rziBl797CC/kjT8kHc5v/2D1E1iCo80QEmUXzfr62MFsUqhZLpsbSkSgX
   yijSiAT+f81JtsPbyRYWa4u92TdTj4tq5Cwx2i8+NnR6tg6pOWaBLvgo1
   SSANf7uSy5p1D4HBp+Gif8NXU5euhkZqrjYanw5f+v8gp/pvHg8kgfoi8
   b1LOgQ6WjLw0oodGzki5FEb+upIDutKQa1AmWE7v86dnW8d/mhk5Hib74
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391764120"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="391764120"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 22:51:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716746165"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="716746165"
Received: from fedora-sys-rao.jf.intel.com (HELO f37-upstream-rao..) ([10.166.5.220])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2023 22:51:34 -0800
From: Ranganatha Rao <ranganatha.rao@intel.com>
To: e1000-patches@eclists.intel.com
Cc: netdev@vger.kernel.org,
	Ranganatha Rao <ranganatha.rao@intel.com>
Subject: [PATCH iwl-net v1 0/2] Introduce new state machines for flow director
Date: Tue, 21 Nov 2023 22:45:59 -0500
Message-ID: <20231122034601.38054-1-ranganatha.rao@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes current design flaws in flow director by introducing additional state
machines.

Piotr Gardocki (2):
  iavf: Introduce new state machines for flow director
  iavf: Handle ntuple on/off based on new state machines for flow
    director

 drivers/net/ethernet/intel/iavf/iavf.h        |   1 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  27 +++--
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  15 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 107 ++++++++++++++++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  71 +++++++++++-
 5 files changed, 198 insertions(+), 23 deletions(-)

-- 
2.41.0


