Return-Path: <netdev+bounces-118221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08260950FA7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBE72815FD
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66491AAE25;
	Tue, 13 Aug 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XO9GxeIq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4756766
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587776; cv=none; b=ECRKHROKTkX0dt/P0COKvM9fXHPW04EuzrhbHUnCNfHmwOC0U9YpTKO8Ly76OiLiYYywMA07dBYLbyT+FL3Wz0MWPwc+CCbWnQKejPPyo57Q8WViFGWheDSIKwuBuqdrT8R7+dsb9HtoBDdX4FTQnHmfvDgwaa3tZQ4MLh/mjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587776; c=relaxed/simple;
	bh=phMzR7+ioTz7l6JEkFB0TBB0P6PGSnLn8ZtKR2/AdIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWdodMK/2GnJjN8vplAb+Z6nEo9hPzjlpDRKVgQl0XN3bKjd2sfeiUQ3rAbYzK0xD3KV5vjBuJiyAzNGfDTHNThZbf2qBknhsZbCVCPTfJIEWLXUKAopJ9IVyfKEVroPtwpd+RaeKY6wnF89+Hqea58GEifKcJdNoZNwi6s+Xw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XO9GxeIq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723587775; x=1755123775;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=phMzR7+ioTz7l6JEkFB0TBB0P6PGSnLn8ZtKR2/AdIM=;
  b=XO9GxeIqHstLaULXMDFXg0x8Y9WEvcMweJdI5+IZ3WUpd63TFv7F05O/
   L1BOkQPcq5iNZogKqxQ+9/pHqUUmMTcjtHv38YHZGURrmJcRGtzQmizOa
   ZcNjdBM6+G6bH9sqV5nBviFiSsHu2cb6LbYRzHEVpzK+y58Vlf2iBS+ig
   t3F2wNU8nPY80ZJcrDbB8KAR79c9GMKXedV1cD56hAxYH4RG4wL4r9cR5
   /mKfwznaLe+OSCVy1nzQ4tkpZTMl+Ud/zpOtjTrBaEcCpiJXuUC9/FBov
   HRS6ycxSFjI4sAqsYJF5m3YS4JD9UvBZinxB0zHCjy37jeh3UzkCPd62J
   g==;
X-CSE-ConnectionGUID: tYtpNc8PQhS5eC7air8b6w==
X-CSE-MsgGUID: yb2SKxgqRQGTXeYxkaV3JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39287068"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="39287068"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 15:22:54 -0700
X-CSE-ConnectionGUID: M6ufxz/fTHeEqw+XbCAEvw==
X-CSE-MsgGUID: C+ySxeGiR5mccNtznEg9LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="59381046"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 13 Aug 2024 15:22:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	ahmed.zaki@intel.com,
	madhu.chittim@intel.com,
	horms@kernel.org,
	hkelam@marvell.com
Subject: [PATCH net-next v2 00/13][pull request] ice: iavf: add support for TC U32 filters on VFs
Date: Tue, 13 Aug 2024 15:22:35 -0700
Message-ID: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ahmed Zaki says:

The Intel Ethernet 800 Series is designed with a pipeline that has
an on-chip programmable capability called Dynamic Device Personalization
(DDP). A DDP package is loaded by the driver during probe time. The DDP
package programs functionality in both the parser and switching blocks in
the pipeline, allowing dynamic support for new and existing protocols.
Once the pipeline is configured, the driver can identify the protocol and
apply any HW action in different stages, for example, direct packets to
desired hardware queues (flow director), queue groups or drop.

Patches 1-8 introduce a DDP package parser API that enables different
pipeline stages in the driver to learn the HW parser capabilities from 
the DDP package that is downloaded to HW. The parser library takes raw
packet patterns and masks (in binary) indicating the packet protocol fields
to be matched and generates the final HW profiles that can be applied at
the required stage. With this API, raw flow filtering for FDIR or RSS
could be done on new protocols or headers without any driver or Kernel
updates (only need to update the DDP package). These patches were submitted
before [1] but were not accepted mainly due to lack of a user.

Patches 9-11 extend the virtchnl support to allow the VF to request raw
flow director filters. Upon receiving the raw FDIR filter request, the PF
driver allocates and runs a parser lib instance and generates the hardware
profile definitions required to program the FDIR stage. These were also
submitted before [2].

Finally, patches 12 and 13 add TC U32 filter support to the iavf driver.
Using the parser API, the ice driver runs the raw patterns sent by the
user and then adds a new profile to the FDIR stage associated with the VF's
VSI. Refer to examples in patch 13 commit message.

[1]: https://lore.kernel.org/netdev/20230904021455.3944605-1-junfeng.guo@intel.com/
[2]: https://lore.kernel.org/intel-wired-lan/20230818064703.154183-1-junfeng.guo@intel.com/
---
v2:
- Resolve incorrect type warning
- Add kdoc short description to ice_nearest_proto_id()

v1: https://lore.kernel.org/netdev/20240809173615.2031516-1-anthony.l.nguyen@intel.com/

iwl: https://lore.kernel.org/intel-wired-lan/20240725220810.12748-1-ahmed.zaki@intel.com/

The following are changes since commit dd1bf9f9df156b43e5122f90d97ac3f59a1a5621:
  net: hinic: use ethtool_sprintf/puts
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Ahmed Zaki (2):
  iavf: refactor add/del FDIR filters
  iavf: add support for offloading tc U32 cls filters

Junfeng Guo (11):
  ice: add parser create and destroy skeleton
  ice: parse and init various DDP parser sections
  ice: add debugging functions for the parser sections
  ice: add parser internal helper functions
  ice: add parser execution main loop
  ice: support turning on/off the parser's double vlan mode
  ice: add UDP tunnels support to the parser
  ice: add API for parser profile initialization
  virtchnl: support raw packet in protocol header
  ice: add method to disable FDIR SWAP option
  ice: enable FDIR filters from raw binary patterns for VFs

 drivers/net/ethernet/intel/iavf/iavf.h        |   30 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   59 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   |   89 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |   13 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  160 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   25 +-
 drivers/net/ethernet/intel/ice/Makefile       |    2 +
 drivers/net/ethernet/intel/ice/ice_common.h   |    1 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   10 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   13 +
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   99 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |    7 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     |  109 +-
 drivers/net/ethernet/intel/ice/ice_flow.h     |    5 +
 drivers/net/ethernet/intel/ice/ice_parser.c   | 2430 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h   |  540 ++++
 .../net/ethernet/intel/ice/ice_parser_rt.c    |  861 ++++++
 drivers/net/ethernet/intel/ice/ice_type.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    8 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |    4 +
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  403 ++-
 include/linux/avf/virtchnl.h                  |   13 +-
 22 files changed, 4792 insertions(+), 90 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser_rt.c

-- 
2.42.0


