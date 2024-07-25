Return-Path: <netdev+bounces-113099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBD093CA9A
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7047A1F211BC
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E70013D250;
	Thu, 25 Jul 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN27flaw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA921F17B
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721945304; cv=none; b=sfc7eKO/Uqp8kokB9bXZZFiOBzkDRATtNqAvY82O0Ld1v2EjNpSy8x036W63piZ/JB5XPlNYPOsDXz2MxgoOkyaReoDBVEIsUvhikxY9vRvZsFTFGCu+w68I6QxXdaky53OnsxWIK3ZypvigtQvmr1wkUZo5QonLN2WBWYxQNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721945304; c=relaxed/simple;
	bh=lDklgwiOW+noyyg7qs0R18e/kfSQm1K6dE2DtWI/v9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M5XzFzmWfO0ylGyavk3DDVMGKneNnRMuN8IrKg7RhxPtzmH6SorOchfqI0u7rSlkl99jql7lbIY5tF9lgNwNB4rM1UzMXmuII+NJ+sh5uAf+LKlaTOOy9rUQ4Jy80De3yoIpBhaHfM1e/2n0MNqjgq9WBB+TkAqpjQaGjwmWlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN27flaw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721945302; x=1753481302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lDklgwiOW+noyyg7qs0R18e/kfSQm1K6dE2DtWI/v9U=;
  b=bN27flawTQBT55M3cGfp4d9PBdHVp6Q5tck35FJSlFy5ZAr5yEtc4Mpg
   HeniwQeKkuwdh6Flrqpi2DgnzWa4N6FdBYcEKalj7HHvoPANeghhNTM96
   GwDVUw6cnnxJESGV97ruPsrz/WcOONC12jEu3FeQZeaUHFm+6SBDbZhSk
   VaaYGSjVvaDt0sWvderyl6ztIfxEcAIp+Zi5lbpFmcfTP1JTaCfJnAY0b
   4Kq3U8YCD9nVOFS8thLt7DB077uwz75wWYTCIfdB8XzUCI78MonGgUDfB
   7hluXm217P3ISp3QfZvjLOBB7JHRYACbjR9FkYPYFUQDOgy3QGUYfmApT
   w==;
X-CSE-ConnectionGUID: +ieXuv38QNu83HzhqLrsbg==
X-CSE-MsgGUID: yKEDfJhHQj2efaNaGUJl+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19520483"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19520483"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:08:20 -0700
X-CSE-ConnectionGUID: IX3kFnzqRPWwjyrfmbVRAg==
X-CSE-MsgGUID: +/ppeZj+SJqyWzk9xtiqXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="52955974"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.246.33])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:08:16 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	hkelam@marvell.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next v5 00/13] ice: iavf: add support for TC U32 filters on VFs
Date: Thu, 25 Jul 2024 16:07:56 -0600
Message-ID: <20240725220810.12748-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The Intel® Ethernet 800 Series is designed with a pipeline that has
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

[1]: Link: https://lore.kernel.org/netdev/20230904021455.3944605-1-junfeng.guo@intel.com/
[2]: Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20230814/036333.html 

---
v5:
  - Add queue ID validation to iavf_add_cls_u32() (patch 13)

v4:
  - Fix idx init value in ice_parser_create_table() (patch 2)
  - Use non-fixed width types for iterators in ice_disable_fd_swap()
    (patch 10)
  - Do not cast return value of ice_parser_create_table() (*void) in all
    callers (patch 2)
  - Add kdoc short descriptions (patch 11)
  - Add description to patch 12 message that a minor bug is also fixed
    (access FDIR list out of spinlock protection)
  - Document return values of iavf_add_cls_u32(), iavf_del_cls_u32() and
    iavf_setup_tc_cls_u32() (patch 13) 

v3:
  - Remove header inclusion re-order in ice_vf_lib.c (patch 11).
  - Fix couple of errors reported by smatch:
      - https://lore.kernel.org/all/202407070634.aTz9Naa1-lkp@intel.com/
      - https://lore.kernel.org/all/202406100753.38qaQzo9-lkp@intel.com/
  - Add "Return:" description in kernel-docs for all new functions.
  - Use new macro ICE_MI_GBDM_GENMASK_ULL for better readability (patch 2)
  - Remove unnecessary casts in ice_parser.c and ice_parser_rt.c. 

v2:
  - No changes, just cc netdev

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
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |  101 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |    7 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     |  108 +-
 drivers/net/ethernet/intel/ice/ice_flow.h     |    5 +
 drivers/net/ethernet/intel/ice/ice_parser.c   | 2428 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h   |  540 ++++
 .../net/ethernet/intel/ice/ice_parser_rt.c    |  862 ++++++
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
2.43.0


