Return-Path: <netdev+bounces-293633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCQWLqBQHWooYwkAu9opvQ
	(envelope-from <netdev+bounces-293633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:28:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA9361C6A9
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6525A307E9B6
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD738F935;
	Mon,  1 Jun 2026 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrzYlwbJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959C390219
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305595; cv=none; b=gsYMCYAGGIkKm9GvXRGlBXDLAYXrvr1Nl6mC68jPPMkKMx2qndrSkXU+WGwC3ARNgfgxM/AfkFXLm51+hG3HDXUNkVXcvmSFtS5ssfbmWVzjb0JYMBX+boCLsbdM3gNXcl2lUrUEkvr4F92Xagm4gozxuGivTpYfXTbhq0jvzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305595; c=relaxed/simple;
	bh=Ewsugi7x5bALYLq3VAEl7zO7p5iDH/402TKmzMxyUI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBt/AVW1MUdB0bl++lMictrgqorfd0ALOZfWXBvQfenbfwODHVtmfFG196NpIT2i2RThHYIdB6jNMHW+fo5vUlONZlKPQHnMztigFBrabN9JUCl8GI3bn2cPKyN/yGRhEnhVISm6+dUfnSmd0c7/ZhVzqh2q7mSxu4BGlc1+kt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrzYlwbJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780305594; x=1811841594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ewsugi7x5bALYLq3VAEl7zO7p5iDH/402TKmzMxyUI4=;
  b=mrzYlwbJQ9gb2b90Vo2BBckxQC7qLNQNOKItSx49sLwf9/SkdM1Sf3IH
   f4k8tFzrxnAplZXO3JESLD61nrGM4tADZ10m0VJp2p1HeNo24NbBIAg0F
   jzQpisacfD4xBSAJFDUavw3mIs3vGFkXdTjg5pvwd4QvYu0yK9eL2IVnI
   rAbOvo9uw+oQhh/8aWtOpT2f3/7WmCPsSF3idOR9x0V1F6FAhey0zFltQ
   7lhKRnFpc++cyyVLdlPJiAgHcefymR8eJk0mC/i6ECg2nLsGttgu79wXa
   hnw0lPqtvRYo3JT2slQ66KHoW2GO55l5jhn280yuNEn+IRVXw8lJ+/a6w
   g==;
X-CSE-ConnectionGUID: wOE80xH6Tzu7ogwMwyGJuA==
X-CSE-MsgGUID: 3qW4+PPZQ8CURsm3jWSXhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80791617"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80791617"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:19:53 -0700
X-CSE-ConnectionGUID: NEX49fVIQDKT0110sd6LTQ==
X-CSE-MsgGUID: E7PaYq+LQ4a89SfFue5GbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="247802569"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa004.jf.intel.com with ESMTP; 01 Jun 2026 02:19:53 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v3 0/3] Rework ctrl_pf pointer usage in struct ice_adapter
Date: Mon,  1 Jun 2026 09:19:48 +0000
Message-ID: <20260601091951.3017848-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,osuosl.org:url]
X-Rspamd-Queue-Id: 0EA9361C6A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rework usage of the control PF pointer in struct ice_adapter, so that
it is always has a consistent state, since it is global for an adapter.
Utilize RCU for reading the pointer value and atomic operations for
changing it. Zero out the ctrl_pf pointer when the control PF is removed.

Previous version:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260511/055077.html

v1->v2: Rebase onto the latest dev-queue branch
v2->v3: Cosmetic fixes

Sergey Temerkhanov (3):
  ice: Convert ctrl_pf pointer in struct ice_adapter to RCU
  ice: Zero out the PTP control PF pointer at ice_adapter cleanup
  ice: Cache struct ice_hw pointer for split register reads

 drivers/net/ethernet/intel/ice/ice.h         |  10 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 116 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  26 ++++-
 4 files changed, 114 insertions(+), 40 deletions(-)


base-commit: 03d0beff9856a569d0da91ea0ccdc28045c2b2d0
-- 
2.53.0


