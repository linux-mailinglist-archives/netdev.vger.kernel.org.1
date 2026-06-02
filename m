Return-Path: <netdev+bounces-293924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN3gBqcgHmrmhQkAu9opvQ
	(envelope-from <netdev+bounces-293924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:15:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 738286267BD
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172DF300B471
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664CC1FE471;
	Tue,  2 Jun 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsTHe0RZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDA72617
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359332; cv=none; b=sGLP32oKRdcT8Q8vqwnZMCxdRyy7La+uvvXxgNN0mKvZ2SbGtWhJFn9Av2uKmrMBjSAkF6MsWJhqQwaohGfP6vpdxNi6ohJwBJdR0Pie7ppNfQHR/f+rIooo7mwpWsmEjYWZpoFIRVjyPa/aPx7jUvtOQUjRR+hOcLYMCw9FmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359332; c=relaxed/simple;
	bh=Np9Oy0eEY1O7hnRLPuE1Qosu3zQBNrGSuIkeRzjtgG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SntFS32Qg9K/tjo3K+mCqQ7e/dKffCaVTid5ay3CtVYKe4fRZpoLvDB225s29/qxdSmywW4EY8X6g66tCK5n+xhMyZBBX3f3kt8vLoUgtWK26zI1vAc0au6Q2fwAH9zraqC4hB8APqJuvEQQPFnLmwpTUumf/GoJmqPM1Iqaw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsTHe0RZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780359330; x=1811895330;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Np9Oy0eEY1O7hnRLPuE1Qosu3zQBNrGSuIkeRzjtgG0=;
  b=UsTHe0RZv4vC6GMnvnMS3IXyn1Ys2ssawCtL4vs+K7PDo9H35lc/TGK6
   K5GA7xQQI2dVHdYRq3JfZrLF870kXNIKzXBvnfcDwdNxMzoQno8b5eboN
   rOTgPvnJWHkJ7SSu9EDnkFxgIiiyty8SLRIfiIjrgqZafW3Aijv6RV5YA
   ZN67BaAw8oBZpx50K+Xgief2dy7wB4M3qiiV5w/h3CxaL2+/B+QA6nIJJ
   QrZkH0bKQQTeYiSxST5vCKqV3xDVgUWnVwkO1iQUTLF9n0TeeUL3tCU4e
   8tP4YvGEqZmuZgfXin8QlaDENagNTQwaY/brzVctjnzIsqrZ6CUHVXWSZ
   w==;
X-CSE-ConnectionGUID: xlKOivswT+KVaniK9kaPhA==
X-CSE-MsgGUID: dSVzNYXzTaOioxAxzfNBIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84755417"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="84755417"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:30 -0700
X-CSE-ConnectionGUID: s8U0i5LzQTi1651U6eO9EA==
X-CSE-MsgGUID: 1wUnmV7rTfenHFQmfRxnzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="267598712"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next 0/6] ice: refactor aggregator node logic
Date: Mon, 01 Jun 2026 17:14:17 -0700
Message-Id: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XRzW7DIAwH8FepOI8JHL6y095j2iGASenapAop6
 1Tl3UfSS5Qdoh0tzO9v2Q+ScIiYyNvhQQbMMcW+KwV/ORB3bLoWafSlJsBAMckkPX1Rd8amu11
 pTpE2bTtg24z9QLveY6K1tRKMdA6tIEW5DhjifUn4IPH7TDu8j+Tz+ZJu9oRunAPm3mNMBfpZh
 smw/Hjmcr6bm4EyamsuHLNeIrr32I14fnX9ZUnL1dqr9r1q9lRgPIgavA5bT/zTE8UzNijktdY
 Q/swn157Y92Tx0HGwUjptkW89tfb275ZV8TjzdYMGOAi79fTaM/ueLl4F2pumDjY42Hpm5YHa9
 8y8P2/RC8aY8GLtTdP0CwYuNobKAgAA
X-Change-ID: 20260505-jk-cleanup-vsi-aggregator-nodes-9bb5285cceb4
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev@vger.kernel.org, Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.16-dev-3fed5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2714;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Np9Oy0eEY1O7hnRLPuE1Qosu3zQBNrGSuIkeRzjtgG0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhiw5hdm3l/xcHHHG93BymYrfxn0/LVzqFi+N3K0a/3k9H
 8fXihc9HaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEyk1YXhv8flHonmjgKFwBXc
 q2bOf2hvdPOxeL1v6qzg87uTxBV52Bj+yu3+knAo+OqmwtvbVlxnWxbgcHhyWUqHr07Vv5tWMyX
 3cAEA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293924-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 738286267BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ice hardware uses aggregator nodes to track VSIs in the device
scheduler tree. The existing logic used by the ice driver results in a
two-layered tracking approach where the VSI has an ice_agg_node structure
that wraps the ice_sched_agg_info structure.

This logic is done outside of the scheduler code, and results in the driver
having two sources of "truth" for the aggregator nodes. If the two places
become out of sync it could lead to imbalances in the scheduler tree, or
failure to use the device resources as effectively.

In addition, the tracking logic requires each struct ice_pf to contain two
arrays, pf_agg_node and vf_agg_node, which track the ice_agg_node
structures. This wastes about a kilobyte of memory (~5% of the total PF
structure size).

Almost all of the information required is already stored in the
ice_sched_agg_info structure, so duplicating this information is redundant
and unnecessary.

This series refactors the logic in ice_sched.c, converting from a linked
list to an xarray, implements a new ice_cfg_vsi_agg() function to replace
the ice_cfg_agg() function. The new logic better integrates with what the
driver actually wants to do.

The result is that aggregator node information is tracked in only one
place, preventing the possibility that it gets out of sync.

Note: this depends on a bug fix that was spotted by sashiko during early
development of this series:

  https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com/

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
---
Jacob Keller (6):
      ice: convert hw->agg_list from linked list to xarray
      ice: count number of VSIS in agg_vsi_list
      ice: extract function to allocate aggregator info structure
      ice: remove ice_agg_node wrapper structure
      ice: remove unused aggregator node functions
      ice: refactor ice_sched_cfg_agg to take agg_info pointer

 drivers/net/ethernet/intel/ice/ice.h        |  23 +--
 drivers/net/ethernet/intel/ice/ice_sched.h  |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_common.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c    | 114 ++---------
 drivers/net/ethernet/intel/ice/ice_main.c   |   7 -
 drivers/net/ethernet/intel/ice/ice_sched.c  | 290 +++++++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  22 +--
 8 files changed, 218 insertions(+), 257 deletions(-)
---
base-commit: f2047b9d846f79959cbb1fba812b967a86a3f024
change-id: 20260505-jk-cleanup-vsi-aggregator-nodes-9bb5285cceb4

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


