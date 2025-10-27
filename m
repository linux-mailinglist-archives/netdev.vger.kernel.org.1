Return-Path: <netdev+bounces-233121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6BC0CB1F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8423189C7C3
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094532E719B;
	Mon, 27 Oct 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtvTxJiS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9582E62A9
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557860; cv=none; b=C+cIsKxeJlaJs8K/e4dwZKLBG548ImT9qdFbP+S4FPk69/NS2qd0+9V/8vPLXDIUtMwnmr0X6NlUEbMnqsSTxGgj9IGhn8W0eXHFgeAfOmOLGieonk/tg9YhEY7zIzj+Ue8HDK5TxpCJaQqqhs4kHyocDL9smn3g6Sd/QGY2U2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557860; c=relaxed/simple;
	bh=42RsqUTPUbIOZPnLf+HdFFP6npJl5dilXMS7DLvN7e4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AwiyMnduIrf95GIOQ0F+f5edA4mwFyik5Dye3JC0EUVp33JbRn7OV/L6ZQRrEOaIeMG3fKJvUiOAkYz8q3UX4ItW/xC0V8a1EP7UUUDe6vVp7hG8jZZD5zS45i3zwQHNQIqVb8m/SQJCCvQ/zdn+lc5/Fmmy+5pQqlqxImWm0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtvTxJiS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761557859; x=1793093859;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=42RsqUTPUbIOZPnLf+HdFFP6npJl5dilXMS7DLvN7e4=;
  b=JtvTxJiS7xFpc1n3uh+u8q4B+G6elR4Cj6mkQA8exozhILERNJN4pop+
   N3lX4OllyItNx470y4ClRPBBCwp1ANLIvCpKE5UMN8cbIJZs4qDnpULEF
   NNOqYWvLozHflKnUSBQoITuID2LiO51lYAEmSsFmebxD1DDta/gcYzhMP
   Ig0xjc9I72wsD9LytCUVwnLp/FoC2Ut5UqD5j1jUsSH8F10GTAskOMK9O
   Kf/NTcoZXtvvMlq8drpoRbumWpee73iKcUJG/VfMpATf9Lr+Y2LFp3b7Y
   gKoZ8zfcF+6TI9qHUEQ3pnDn96511YREGSv6ALsnCPJb607JfazykOuYm
   g==;
X-CSE-ConnectionGUID: hGf0DKybRJG50twbXYMdBA==
X-CSE-MsgGUID: poUtDH/5SqCr3xyr4L09bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62663145"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="62663145"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:37:38 -0700
X-CSE-ConnectionGUID: S5g4BYwASyCy0Nx6PTrHxA==
X-CSE-MsgGUID: Qj79KHNeRhOa81c+bz0BAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185349349"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 27 Oct 2025 02:37:37 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v7 0/6] iavf and ice: GTP RSS support and flow enhancements
Date: Mon, 27 Oct 2025 10:37:30 +0100
Message-ID: <20251027093736.3582567-1-aleksandr.loktionov@intel.com>
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

changelog:
v7:
   - refactor ice_vc_rss_hash_update() to use int error codes
v6:
   - split patch 2/6 int static data and define changes + minor fixes
v5:
   -fix NULL ptr dereference and minor improvements in 1/5 & 2/5
v4:
   -remove redundant bitmask in iavf_adv_rss.c for dmesg
v3:
   -fix kdoc-s in ice_virtchnl_rss.c
v2:
   - reduce much repetition with ice_hash_{remove,moveout}() calls
     (Przemek, leftover from internal review)
   - now applies on Tony's tree

v1/RFC: https://lore.kernel.org/intel-wired-lan/20250811111213.2964512-1-aleksandr.loktionov@intel.com

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



