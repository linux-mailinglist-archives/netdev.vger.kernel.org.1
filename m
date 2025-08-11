Return-Path: <netdev+bounces-212439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A80BB206F4
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 13:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A218C21C5
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7202A2BE7A3;
	Mon, 11 Aug 2025 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrpVl/Sk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0B23B627
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910742; cv=none; b=BA7oDg3+9xKYVmnyPdIcyarNoIKFH1HgU86VAYQo7CtFs2Rm7UmSI2l/pQ0FhyvL+c/o3+DU82rgQ0U1Lwk5+ASi04x6WyjDH7pE2S/UqhT4jQo67Mik9ZZuyOuVnVRqlyBcE1NIaAfSStZ416ec+atFWMSGoofoOQEED1S5yYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910742; c=relaxed/simple;
	bh=+dyA3DX8N3OKT1wbnM9QfIuw/HhMNEtKWhAcx9/saiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWNYolQmvFT++Ug4DLPxoWL0fbug9RnTWciJqdwmiMw1w+ekatggzr5Os0+viHwP1P6HQUnMHh0sfZX1Z2Q3OaI9OUInrvrtTLAVpX3zeWkNVdqKHVr18no7qvTLoT/+jlTxAXkmiaC+LPnhZEm4Hft0dvKcjUIKkVCSZD6OCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrpVl/Sk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754910740; x=1786446740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+dyA3DX8N3OKT1wbnM9QfIuw/HhMNEtKWhAcx9/saiU=;
  b=HrpVl/SkKzYMuyaPz09BAbn48/dCwu9i+1uWPtS0/P1p1dpIJY24d1LU
   /HcYqntvIEf2kFESQ+kVPiwcvFXkUb1/lnLzoxiSRKtTW+YAqmGC9u0aT
   FBDXLTfkMFI8r4k+cf9Mx6Lyv0Romany02NEfUVzD88l8X4BCZG/gyJ0/
   HPe8eYtkQ6LzaVhvbpG5Q59yVd9CV6BScsvKB7C89we6o6FSJKzuQU+ff
   e48cQagOc4EKkNjGdeTTohzRMQzgwQZaetl/m2ncihvFVv7bzJD2K0lD3
   lRLQ5MUrjuTEFSOrrLVsoIQwBcAMC+nu5FF8omYoBV1Eb7Op6pKmKIMIv
   w==;
X-CSE-ConnectionGUID: q1S/0zSUQ7iMk03SnW//kQ==
X-CSE-MsgGUID: eV0yYPRLQHy1mP7NLNaLVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56189506"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56189506"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 04:12:16 -0700
X-CSE-ConnectionGUID: fTr6v+kASFKa8zUq7yvSFA==
X-CSE-MsgGUID: //sAu/+cR6GcvyH1dBn7mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165532733"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa009.jf.intel.com with ESMTP; 11 Aug 2025 04:12:15 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [RFC iwl-next v1 0/5] iavf and ice: GTP RSS support and flow enhancements
Date: Mon, 11 Aug 2025 11:10:50 +0000
Message-ID: <20250811111213.2964512-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Receive Side Scaling (RSS)
configuration of GTP (GPRS Tunneling Protocol) flows via the ethtool
interface on virtual function (VF) interfaces in the iavf driver.

The implementation enables fine-grained traffic distribution for
GTP-based mobile workloads, including GTPC and GTPU encapsulations, by
extending the advanced RSS infrastructure. This is particularly beneficial
for virtualized network functions (VNFs) and user plane functions (UPFs)
in 5G and LTE deployments.

Key features:
 - Adds new RSS flow segment headers and hash field definitions for GTP
   protocols.
 - Enhances ethtool parsing logic to support GTP-specific flow types.
 - Updates the virtchnl interface to propagate GTP RSS configuration to PF.
 - Extends the ICE driver to support GTP RSS configuration for VFs.

This series depends on Przemek's [1], which is still in RFC state [2],
but we expect it to be merged soon. I have tested it on top of it.
[1] https://github.com/pkitszel/linux/commits/virtchnl-split/
[2] https://lore.kernel.org/netdev/5b94d14e-a0e7-47bd-82fc-c85171cbf26e@intel.com/T/#u

Aleksandr Loktionov (4):
  ice: add flow parsing for GTP and new protocol field support
  ice: add virtchnl and VF context support for GTP RSS
  ice: improve TCAM priority handling for RSS profiles
  iavf: add RSS support for GTP protocol via ethtool

Przemek Kitszel (1):
  ice: extend PTYPE bitmap coverage for GTP encapsulated flows

 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |  119 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   31 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   89 ++
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   91 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.c     |  251 ++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   94 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |   20 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   48 +
 .../net/ethernet/intel/ice/ice_virtchnl_rss.c | 1404 ++++++++++++++++-
 include/linux/avf/virtchnl.h                  |   50 +
 11 files changed, 2070 insertions(+), 128 deletions(-)

--
2.47.1

