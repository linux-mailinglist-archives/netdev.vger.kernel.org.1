Return-Path: <netdev+bounces-175879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E14FA67DA9
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC1B1711B8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13161F4CB4;
	Tue, 18 Mar 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmkjxhPE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602861DDC30
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328322; cv=none; b=W/wJJmK4iRoTe+4fhhBGKjI2gc/QX/8zn/snM6d0E6SrIzO7ST3Q15fvdXbYz3l8zEVxyhmQywXTogc6GQ82utr3L2BZbuxR0I1H/hpXhXSly3CbcAjXC7SDclEm0gU34rxBdGRqm47CULzr7hqNbEw1TZJ5LXq5BMNxrlBLp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328322; c=relaxed/simple;
	bh=RHa3H32evRQJ+ceHlo6xoPzXWYeNJavF8whW4pXmk8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RyTc0OTElhX/iz8YQGehdxVI8EAUd5UStTE+dEOn4Qc9B1qy2gGZl0CuLEVWAtCzKDv8N1T7Fb1ENATa6AnUuJk8U8t9FkMcg/Idfw4jqssAjV6XntyPr90EpYilEITHxQvm3IlPKdYhkEPQxoZPGIo7BQAY4a1KQIDlRl5rQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmkjxhPE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742328322; x=1773864322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RHa3H32evRQJ+ceHlo6xoPzXWYeNJavF8whW4pXmk8k=;
  b=HmkjxhPEKZIWAbBWsF2YE7jQdqHpgJBPcr4cEwkghTRlH0rtYVfnoWlI
   VQYoK0hDtKnZqcfAWDOKpowJ/tnYuiNZDP+J/fzoRgf5jpQvn7wpjHrJW
   m+VosoovlI6FbF+RpOcefkLp/OlPweUUNSx8HuqFh4nCr4Ai7tVKTxk0t
   mKfReDg0Z/5P9TdaLLKNzsWwT63iW1zKEGmYWvPla9TXKQe0OKbFAKg+9
   U7L9BtN2TcvzQWUkiC485EjarTx0fRMCfoYXi6eCx9d5/aOOyGVuwrnnw
   U9wf8y/J6Cvydje5L0LsM5RMIQtB3kD5oJE91kDXtSsXA6nBIR6gNo0MT
   A==;
X-CSE-ConnectionGUID: IbUZeU5HSDS4pv52NDBbzQ==
X-CSE-MsgGUID: pqOtjAlbTcqPZ3FZ334/7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43593001"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43593001"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:05:19 -0700
X-CSE-ConnectionGUID: Dy0wwvnDST2/mxv57kMFHA==
X-CSE-MsgGUID: Z2V2lZN3Q+mqoTn7bOSGDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153363118"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 13:05:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/9][pull request] Intel Wired LAN Driver Updates 2025-03-18 (ice, idpf)
Date: Tue, 18 Mar 2025 13:04:44 -0700
Message-ID: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:

Przemek modifies string declarations to resolve compile issues on gcc 7.5.

Karol adds padding to initial programming of GLTSYN_TIME* registers to
ensure it will occur in the future to prevent hardware issues.

Jesse Brandeburg turns off driver RDMA capability when the corresponding
kernel config is not enabled to aid in preventing resource exhaustion.

Jan adjusts type declaration to properly catch error conditions and
prevent truncation of values. He also adds bounds checking to prevent
overflow in ice_vc_cfg_q_quanta().

Lukasz adds checking and error reporting for invalid values in
ice_vc_cfg_q_bw().

Mateusz adds check for valid size for ice_vc_fdir_parse_raw().

For idpf:

Emil adds check, and handling, on failure to register netdev.

The following are changes since commit 9a81fc3480bf5dbe2bf80e278c440770f6ba2692:
  ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Emil Tantilov (1):
  idpf: check error for register_netdev() on init

Jan Glaza (3):
  virtchnl: make proto and filter action count unsigned
  ice: stop truncating queue ids when checking
  ice: validate queue quanta parameters to prevent OOB access

Jesse Brandeburg (1):
  ice: fix reservation of resources for RDMA when disabled

Karol Kolacinski (1):
  ice: ensure periodic output start time is in the future

Lukasz Czapnik (1):
  ice: fix input validation for virtchnl BW

Mateusz Polchlopek (1):
  ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()

Przemek Kitszel (1):
  ice: health.c: fix compilation on gcc 7.5

 .../net/ethernet/intel/ice/devlink/health.c   |  6 +--
 drivers/net/ethernet/intel/ice/ice_common.c   |  3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  6 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 39 +++++++++++++++----
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 24 +++++++-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 31 ++++++++++-----
 include/linux/avf/virtchnl.h                  |  4 +-
 7 files changed, 79 insertions(+), 34 deletions(-)

-- 
2.47.1


