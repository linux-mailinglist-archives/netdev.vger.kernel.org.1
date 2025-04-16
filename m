Return-Path: <netdev+bounces-183500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FACA90DA3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DCD46056F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93622A7E4;
	Wed, 16 Apr 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbgN37Yy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB65DDDC
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744838343; cv=none; b=Ev9yanFih81otcFVc3YG4GKqGYe0v2gD9PVeSgMAg9BD7JCNMfUi7CiGzkY9YuZIfj1X8tigh6FUkcfdcGeBybRHATYeB1/p34RU/q7HiYS+GJLYmkX0YQexS7D/zQ2s0uLZ/+LEE0w2pOws/po8b1RZsRYbV4w+EafcBiekU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744838343; c=relaxed/simple;
	bh=crjEXK1GLqH9WsE4qeAoY0vFHzVz8ZvUou9JkfnD2hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRwlAjCtgqBSD4uL2viw1WWIxFkW7+HYHe0MWKVRtSY1wKQUAdzMis4zp8wHYLy0x1sqR6OO3PIzp7SBHbOBmm8W8pweGxo7fn5ziM231c7IXpOfjl1DUhZx5YBCAs8u7W7s3FFX22lH79lEXXe1d1Yh2aY1Tyy0K/7r7NbS3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbgN37Yy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744838340; x=1776374340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=crjEXK1GLqH9WsE4qeAoY0vFHzVz8ZvUou9JkfnD2hE=;
  b=BbgN37Yy6Om2wU6aW/GDqmcesaWA9B1hmASLvsLPNKaQwjBq/CXHzt0a
   43VABEFfqSFLTa8sGmkDIpyLxWflTRf7cXGy3T4bOYMB+TdvzdOBS3P5I
   uJG0t0i/0j725ztft7bJSSJewGBMvLhRzAo8npYyYOtRluhqv7FniPqJ5
   9WQjTXz9fUrhpBa3FY9Cc2z2OCA4Ws2QgwgVunVxM70acpfdms61gjVrC
   ebhEhGRh8kXPqSkVKjd6RtSO0HHCy1Am6CIixSAJoFIeSLqID3m/lWmxR
   ylSSQLZRVYGgM7/bZTUYvY6HeRykEOYbABQSf2gdvuCvk1B5UAUC6mJqu
   A==;
X-CSE-ConnectionGUID: diPjaiqwQ7ySeGjKb84bcQ==
X-CSE-MsgGUID: vYuga6MNSOGpaztUoeeqUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46496228"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46496228"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 14:19:00 -0700
X-CSE-ConnectionGUID: meZ7QWaaQ3m0ofeDDIFNaA==
X-CSE-MsgGUID: aNo9Fvq0R9mj1MKPXA0xcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130909730"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by fmviesa008.fm.intel.com with ESMTP; 16 Apr 2025 14:19:00 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-next 0/9] refactor IDPF resource access
Date: Wed, 16 Apr 2025 14:18:12 -0700
Message-ID: <20250416211821.444076-1-pavan.kumar.linga@intel.com>
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
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  639 +++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   36 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   15 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1127 ++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   77 +-
 9 files changed, 1239 insertions(+), 1139 deletions(-)

-- 
2.43.0


