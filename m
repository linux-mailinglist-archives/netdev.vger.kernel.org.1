Return-Path: <netdev+bounces-173524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78173A59484
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD3D3AC685
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B07226193;
	Mon, 10 Mar 2025 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nm9OIdmc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF9227E96
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609713; cv=none; b=P0c+D+TPjzwWhD58DRsL4MzffjS6r2zJaZCO5xLYfEqpki5+aTCDkWqebcqtGljyIYHWFN8y105zRjXqBxPZ10jfehb1XzeNj2Sex/O1WqxEFK3coz7/37rSnhhjMaC2fdOlSWO22EgBwSBO4/qW8nFuFUbcYInQ3jJVHvqnfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609713; c=relaxed/simple;
	bh=5GH96/frAS9nSuB3pPuT1iTt5BPHU3MLmaqmyJLzUQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sj4ODJa818Z34hzCid90qy5oEIJ4EfFQ7fvf2AW74eAS1/Qvao1rVxW2Ip4Jm9RxC0ZZD50OsmlwvZ4I3LxwWL4ND947tpFq4aluQWCOMnypEy9H0PnU3UaNkSd0j/l3fnWBSJP4r+Awxs+lXiBqEZJG6Y5/xBBrCnE1Tkeq6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nm9OIdmc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741609711; x=1773145711;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5GH96/frAS9nSuB3pPuT1iTt5BPHU3MLmaqmyJLzUQk=;
  b=Nm9OIdmcXLekdWsXDKPjOE6fUJM5CaKkTAxf4/0bD4PMuNCioSdKQnSe
   vafJ2xYd9JG8KKnZgvRFlLNf09ZBBn28MhBpP2XTUSDCwDlUi1SQWZNTt
   PlbxN2c54VSuu1opkJNzQGPd2c0RgJKIxofSrXgevq+sPSzOEWL1R/1zb
   V0Fd/2af6gcZ/lTEjaAsz99Degy5Ln2+AXQwiZEfk8NfZ2gNCjrL+yLbi
   BXuhYV2iBpk7A4L5cpdVCbunHcu18D0B5gy9/TzECI0xtbGQFpKctODNs
   A4Khiah6ttgTa2U/j3/L7wfieCZ1qDr7l/8A30nRqhhWk8hgsWz54Ban9
   w==;
X-CSE-ConnectionGUID: BHbqH+z+TZ+gtoyRPNYbVg==
X-CSE-MsgGUID: EE4xosYqSYqTlul3sNhxYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53981084"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="53981084"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:28:29 -0700
X-CSE-ConnectionGUID: 1BNFu7ApStCZ81TK0l3thw==
X-CSE-MsgGUID: C3m5+/IpQfS4zwmopqke6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119698177"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa009.jf.intel.com with ESMTP; 10 Mar 2025 05:28:29 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v2 0/3] E825C timesync dual NAC support
Date: Mon, 10 Mar 2025 13:24:36 +0100
Message-Id: <20250310122439.3327908-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds full support for timesync operations for E8225C
devices which are configured in so called 2xNAC mode (Network
Acceleration Complex). 2xNAC mode is the mode in which IO die
is housing two complexes and each of them has its own PHY connected
to it. The complex which controls time transmitter is referred as
primary complex.

The series solves known configuration issues in dual config mode:
- side-band queue (SBQ) addressing when configuring the ports on the PHY
  on secondary NAC
- access to timesync config from the second NAC as only one PF in
  primary NAC controls time transmitter clock

v1->v2:
- fixed ice_pf_src_tmr_owned function doc
- fixed type for lane_num field in ice_hw struct 

Karol Kolacinski (3):
  ice: remove SW side band access workaround for E825
  ice: refactor ice_sbq_msg_dev enum
  ice: enable timesync operation on 2xNAC E825 devices

 drivers/net/ethernet/intel/ice/ice.h         | 60 +++++++++++++-
 drivers/net/ethernet/intel/ice/ice_common.c  |  8 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 49 +++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 82 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |  5 --
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h | 11 +--
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 7 files changed, 149 insertions(+), 67 deletions(-)


base-commit: daa2036c311e81ee32f8cccc8257e3dfd4985f79
-- 
2.39.3


