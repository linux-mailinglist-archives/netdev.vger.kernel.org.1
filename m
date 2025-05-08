Return-Path: <netdev+bounces-189087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC2DAB0586
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 23:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472DA52385A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 21:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C174223DF2;
	Thu,  8 May 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2jfzIH0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFA22332D
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741052; cv=none; b=H3YLWXh1ErumTJ10fU4NjY5qwrMvrHhRigbRxU5jJI2QzT98ehMrHxuU7+ant0Axs6KukcySUlQVVQ3XDK4Cq5MPVL5qKUEWOgNS125j9KSA9uILWbwxY8Oetr7a0+PzJtV6JEnUS4XbX9m5Jr/ZGy2QAC4fGJbR0iDbFRXuo9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741052; c=relaxed/simple;
	bh=QKrDywDbuFUKtgOHlIuQ7LMMUreYpsFJHTwC8r+T6Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrxUzMO5hJHPRTynkAJrPgjUsmr86tz13PB2rpomFbjnURpEjE6qF25yeuaHuIxH/E7JoqoM10sg8TuqzXkYe8RpAkxVgMCjGAGtYlm0Va9qSbKfj2yrA5iH3wUlmTQnkvnM70OuaMzSg1Wa4UcNT3C5r97ArljukrhKNugMbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2jfzIH0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746741050; x=1778277050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QKrDywDbuFUKtgOHlIuQ7LMMUreYpsFJHTwC8r+T6Dg=;
  b=c2jfzIH0Xda9IPCz78vWPtYQnOtAOYGWHIIOEdMDF177NFjQBsS6HBM2
   61l2YGYgpu6c4c7ZbQAjty5OoSRoneOalSEGpJEz3sAU7WMk7wHX++3C/
   RyL973X44W58eRMW07Te0eA8OA9KwbEup1hduhMJMy6HZ7i0KpbwSN6Bw
   tgFuu9i6o7fHIyxswUqvIeQ3t4j5MQobeCjujCc1ntvD7AyhXhsHF71SW
   vryqirkEPGiNWxycm66Seg9Lz5+DF4qW0Nq2Luu0l9PmBuCr876/8Oqsz
   +AYF0ga5SIVOnx8erj6vuRZvGi8S4zXnx1MYES11py+LKlSN31U/pGPs+
   w==;
X-CSE-ConnectionGUID: ZUW95ndwS1OUwKf3eI+4uA==
X-CSE-MsgGUID: BFwrvOM9QtqY+ma4dCsIJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="47808312"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="47808312"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 14:50:49 -0700
X-CSE-ConnectionGUID: BJe7//yBQPyGVxmxil6ZTQ==
X-CSE-MsgGUID: HAPlfAI9QzGCptfkdwxFlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="141534265"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by orviesa005.jf.intel.com with ESMTP; 08 May 2025 14:50:49 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-next v4 0/9] refactor IDPF resource access
Date: Thu,  8 May 2025 14:50:04 -0700
Message-ID: <20250508215013.32668-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue and vector resources for a given vport, are stored in the
idpf_vport structure. At the time of configuration, these resources are
accessed using vport pointer. Meaning, all the config path functions
are tied to the default queue and vector resources of the vport.

There are use cases which can make use of config path functions to
configure queue and vector resources that are not tied to any vport.
One such use case is PTP secondary mailbox creation (it would be in a
followup series). To configure queue and interrupt resources for such
cases, we can make use of the existing config infrastructure by passing
the necessary queue and vector resources info.

To achieve this, group the existing queue and vector resources into
default resource group and refactor the code to pass the resource
pointer to the config path functions.

This series also includes patches which generalizes the send virtchnl
message APIs and mailbox API that are necessary for the implementation
of PTP secondary mailbox.

---
v4:
* avoid returning an error in idpf_vport_init if PTP timestamp caps are
  not supported
* re-flow the commit messages and cover letter to ~72chars per line
  based on off-list feedback from Paul Menzel <pmenzel@molgen.mpg.de>

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


