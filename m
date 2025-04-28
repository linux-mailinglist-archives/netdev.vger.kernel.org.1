Return-Path: <netdev+bounces-186496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE6A9F764
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55B84633F7
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2B2949F8;
	Mon, 28 Apr 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7mKbxM1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090227F4E5
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861774; cv=none; b=qzS57E02Dm7OHMs2xi/qx9zoFS2QQoAFii2Z5Ih1KdQA/SmIm5NwnL4vMX9mQeOHIQql0YV4btuzu1hgeLDChfNHbivDKlmt12wyJKJGBBqHGAVs14Pd9CKNz59KimiSxhaEO+hopQjEezxD+R4eFXNGvqOwuDGg34NpgsYrIY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861774; c=relaxed/simple;
	bh=z+f9DxelzQ/kStLYGXCnqtAx62i1gnnSuzlHnC3GjRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLVXShG4pP1dOjC6cRI7F8OLpuGsyyutOtPE/JQt/XOnfCYG0g+C+08k0juV6aeeCHQXWMYpmcqFZtYpoxofBlEGP5IiE/4wPB3HmOdD0PGuuju1l5v6m3lhIFJxN4qyOi8mmfo4kgyzetrEuxqyVlQ3ZuEjBG+Kfm+EdVGo/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7mKbxM1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745861772; x=1777397772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z+f9DxelzQ/kStLYGXCnqtAx62i1gnnSuzlHnC3GjRo=;
  b=l7mKbxM1uQThki5GdbLLrDnqfieLq8IoiQ2CN7OPm1RTHes8nfrW/aDb
   FQ58+iVpwYpgwKZyCs2z7wXbOY1XUrO0e9LENUNCK7w9yFTbbFSRsMhLI
   O2TbmjMRO9u1ICDKFOlGcsGfY8VWVOryHaknBigF0u0v/Xe7ms4ZeFoce
   Vhbrnl/fy8s4u/kfOc4Lsga+g/6Wgk9Mwa+iaXBlBrNCa74Ovl13yeliX
   JTArlkRIY5a/yTtwLswYvTDHtGpIb/BGH5GaMCTYOLkB8AYh2P0aMzEYm
   F8q/A0IEiG7+bHatbV/Zz2hZaM5FVyCUTCY6NIZVHWGgfvo7/KG5ea/Dm
   A==;
X-CSE-ConnectionGUID: rl8VOFppRrazVyMDyYM/dA==
X-CSE-MsgGUID: /7GUv4eVQk+6wLyDkq7tdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58452149"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="58452149"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 10:36:11 -0700
X-CSE-ConnectionGUID: Od3fpHeCQFSoyDbsxUB1Ew==
X-CSE-MsgGUID: JGdMBqnyRyqiatnsrkNcPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="138679006"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by fmviesa004.fm.intel.com with ESMTP; 28 Apr 2025 10:36:11 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-next v3 0/9] refactor IDPF resource access
Date: Mon, 28 Apr 2025 10:35:43 -0700
Message-ID: <20250428173552.2884-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

---
v3:
* rebase on top of libeth XDP and other patches

v2:
* rebase on top of PTP patch series

Pavan Kumar Linga (9):
  idpf: introduce local idpf structure to store virtchnl queue chunks
  idpf: use existing queue chunk info instead of preparing it
  idpf: introduce idpf_q_vec_rsrc struct and move vector resources to it
  idpf: move queue resources to idpf_q_vec_rsrc structure
  idpf: reshuffle idpf_vport struct members to avoid holes
  idpf: add rss_data field to RSS function parameters
  idpf: generalize send virtchnl message API
  idpf: avoid calling get_rx_ptypes for each vport
  idpf: generalize mailbox API

 drivers/net/ethernet/intel/idpf/idpf.h        |  152 ++-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   12 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   87 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  233 ++--
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    |   17 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  639 +++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   36 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   15 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1130 ++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   81 +-
 10 files changed, 1252 insertions(+), 1150 deletions(-)

-- 
2.43.0


