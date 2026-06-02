Return-Path: <netdev+bounces-294007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qErFBvJhHmrCiwkAu9opvQ
	(envelope-from <netdev+bounces-294007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:54:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 705976283B1
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3039C3012E90
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB302D94BA;
	Tue,  2 Jun 2026 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2DVViLj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7929ACC5
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 04:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376003; cv=none; b=O1Dkml13oyno/iQ++HBETDTsn6l9X8aPMUIVMGPMAQwbqIgX5Ny1ZmBl69i+K9QoYH+dYttSgKNFfPvlj1uochZqo58us+acJaRH5RZceKghA94d4mLtidxla4mAAR51mMOsTsJPCDFghH+TJ1OcoxhovP0U1UUWvE/7a1i1ucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376003; c=relaxed/simple;
	bh=TZYrvbjldw+1KIlBDi/TDmjZVFVUX58xridHRA60fD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pipz+vHCcrzoxGXH8ySfbVEzDYF5eBTHEAEIBnCUoEk/d3KjXlZ0v6V0rFTcRMkIVxwiwlckL2BhrWjG+OwsjjWmipxXLKsAKK6i/VEwNxv0Fp8L0O2t/5lWjf4q03wTewFRR/5EvEcxTJX4xCD5igb7huVXfQgs/tHEsATtsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2DVViLj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780376003; x=1811912003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TZYrvbjldw+1KIlBDi/TDmjZVFVUX58xridHRA60fD8=;
  b=m2DVViLjTJQrV/H2xZP6lspnJQ7cYuJbQZSFThGYCScM6e6ge9lT5ZK2
   IACkof6SzSNcfBY1HJ527lt3ZCNm8Vf8vhAvW6Ov4pDbE9FKSQjDP84WB
   eToH9aCZP8rhRyrPvGXUdmu9KWqWeCZaiUwDNSYKhVwEDPONwgDZKyT09
   dBB0fKusVJ3aizsRrMFCagkXsnjYJKmlas0QXgDogZxDuffhGFCS+A+Oy
   j+uLGuDRmxfkMwPIqHExuCV8iAQB0BODalEmaqsgt9AqKT11ihljvar3C
   JW97ypwVQ4qvnxX8lEum002fOkSt0WJFw4h6UkcRtP41kDjSBNzHjj3Te
   Q==;
X-CSE-ConnectionGUID: heXR5a7qSDOHx4cHTzHwhQ==
X-CSE-MsgGUID: 6qjT4gA2QOCAEwaOc2+77w==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81120462"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81120462"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 21:53:22 -0700
X-CSE-ConnectionGUID: t1GAsqJ3SMm08A3nJzDtnA==
X-CSE-MsgGUID: xRbz/FeRRKS4WmDZjFvF0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="245604097"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 21:53:19 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	dev@lankhorst.se,
	airlied@gmail.com,
	simona@ffwll.ch,
	kuba@kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 0/4] DRM RAS Fixes
Date: Tue,  2 Jun 2026 10:18:40 +0530
Message-ID: <20260602044919.702209-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294007-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 705976283B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Detailed description in commit message.

v2: Use goto (Riana)
    Retain info as NULL on failure (Riana)

v3: Prevent double free on drmm_add_action_or_reset() failure (Riana)

Raag Jadav (4):
  drm/ras: Cancel and free message on get counter failure
  drm/xe/drm_ras: Make counter allocation drm managed
  drm/xe/drm_ras: Add per node cleanup action
  drm/xe/hw_error: Use HW_ERR prefix in log

 drivers/gpu/drm/drm_ras.c        | 19 +++++-----
 drivers/gpu/drm/xe/xe_drm_ras.c  | 61 +++++++++++++-------------------
 drivers/gpu/drm/xe/xe_hw_error.c | 12 +++----
 3 files changed, 41 insertions(+), 51 deletions(-)

-- 
2.43.0


