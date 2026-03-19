Return-Path: <netdev+bounces-269655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADn+HSJnvGnQyAIAu9opvQ
	(envelope-from <netdev+bounces-269655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:14:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9F2D28E3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9C653012CE0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127823A2546;
	Thu, 19 Mar 2026 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQTVhlvc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D740243D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954846; cv=none; b=lnbXCHDY+eyjrhbazWc9CcB6+bXwXMcCft6aJvqjk7icFNFsyl6hHw8vOFHi7Q2UUfljPCn9yq7JVBU61zO1yQt6irIpx7EQTe4+zJeNBDl4sfHD+4iNtRY/EqC6QL3gOlE4Vjm3sRBkNugwG2On6Wk/jIU14LBRd+I7KENVbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954846; c=relaxed/simple;
	bh=g6w+7/HUstfdDlcFG0XXPxnCcV+gCuI/3fPis9u3Wso=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WsjJun6MKoxNMMWn3WQReab3w1L3tWwZG383AZXfD/ifvsiG6WkFAv1XQIbalo7g4gl1I9hi1uZg4VVTItdK8jaN04rXhzZKv9/hAgSwkuQB9Js+6XRD4Y0TfIO1W/HKyhHj+XSDF3fZNDdFLHEant4UDiZVXF8DhTe2X8VYNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQTVhlvc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773954843; x=1805490843;
  h=from:to:cc:subject:date:message-id;
  bh=g6w+7/HUstfdDlcFG0XXPxnCcV+gCuI/3fPis9u3Wso=;
  b=OQTVhlvcvMM/cwQFSGAU1mBmpXoVFaAQDoloAvbTyY6MWoWjBdXGtiDA
   wp8VGOYx8oz2E8ICE33Wxo1MUvIUQt9pyetGsFy8x9ck11lgNHVtSQDG+
   6hFsNoh3msp5k9nBgh2Q0rceWhdTb5kWKNrX6dkFXLd4wArlN02Fmc2sv
   1lii5IWK96UAwk0bgUEHsgxYak1AQ1DdVq2d1yXFxuy15T0xePBsQ81wG
   7AfhqZQmR66CC3+fXV/B1aNQDRqDNoCZ1yI01CNADWRbiLv9rn2HLuUf4
   bnNMQviqu+2WQbzUVyQeND1XOsf/yXL8o75hHhWyZ1JtN9db9lESMLfTd
   w==;
X-CSE-ConnectionGUID: xR7Q8hiYT1Odg/PGikYqaQ==
X-CSE-MsgGUID: 4858lgIpSqCVdfHXWKdmTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86116354"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86116354"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:14:02 -0700
X-CSE-ConnectionGUID: WXM2WaaIS4qrYTicVnNMyQ==
X-CSE-MsgGUID: YOQskBR4Ryqvkx9OeGomAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227221170"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 14:14:02 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	sgzhang@google.com,
	boolli@google.com,
	Emil Tantilov <emil.s.tantilov@intel.com>
Subject: [PATCH iwl-net v2 0/3] idpf: virtchnl locking and async fixes
Date: Thu, 19 Mar 2026 14:13:32 -0700
Message-Id: <20260319211335.23236-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269655-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.927];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBB9F2D28E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The main change in this series is the introduction of local spinlock_t
which replaces the previous use of completion's raw spinlock. This allows
us to make consistent use of the xn_bm_lock when accessing the free_xn_bm
bitmap, while also avoiding nested raw/bh spinlock issue on PREEMPT_RT
kernels. Additionally, we ensure that the payload size is set before
invoking the async handler, to make sure it doesn't error out prematurely
due to invalid size check.

Changelog:
v1->v2:
- Avoid the nested raw/bh spinlocks by not using the raw spinlock from
the completion API. As suggested by Sebastian Andrzej Siewior.
- With the above change, the ordering of the patches is changed to first
introduce the local spinlock, then fix the locking around the bitmap and
finally make sure the payload size is set for the async handler.

v1:
https://lore.kernel.org/netdev/20260316232819.6872-1-emil.s.tantilov@intel.com/

Emil Tantilov (3):
  idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling
  idpf: idpf: improve locking around idpf_vc_xn_push_free()
  idpf: set the payload size before calling the async handler

 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 20 ++++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  5 +++--
 2 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.37.3


