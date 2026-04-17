Return-Path: <netdev+bounces-279421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNLKDWuk4mk58gAAu9opvQ
	(envelope-from <netdev+bounces-279421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:21:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A374F41EA6F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8660E3028C0F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54DB368968;
	Fri, 17 Apr 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIrIOe85"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD7364E9C
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460877; cv=none; b=apeAommxQaQb/Jjn1NQwUtNFw3Q+bfAu9a41erNwBduV3LRsmd9yMkveTpQqe6A8SwMQwbMB7DiBkxraYgyPsQsjstZflxc3HyuRb1m3FGxhWOPqCp5eqxJ4P7xg4EGWcBHh+nYmlGR0OzsBd+IgogjrDzmOrhcgFH49vVuSG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460877; c=relaxed/simple;
	bh=zinImahNnQ7G8Aah47MMc2rdGquA+bSjr2q6X8QR25g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLjuIB0caGVZ1MR4x4Z81fEGjUmDp3Dgbxowi63DYt4Un/yl0ZbhzifYo+ut/v9eqFSDLo6xBtr2lROL4le5fS9+Kr+PTN6OnvGn6klEsIsai8kUpZ1xWBI1gfYcOKbV7SclH2IU8rNRQJZNeLzo78gwNn3aSrB8C1MBNOqOtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIrIOe85; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776460874; x=1807996874;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zinImahNnQ7G8Aah47MMc2rdGquA+bSjr2q6X8QR25g=;
  b=GIrIOe850TQTu8VfbVj1XNmY4K44AyKch6Tyga+dT6v0ffaZ56HIFvns
   tquoSXVLxIvaKqkprV7bJrXiz3YOuPPW3ibkHWfRNRnpJC5iIqoxpdLzg
   MFSxqT3KrUJ8FMReuSXtJwOwdelTbXQH/1piG7g9ME0pOtSSj10eL48j+
   ALLKIrzm4wr5apWzDexFysTJNzB2ADlB7zRPFAO2fj9HgVT+3yKBT8qEn
   gM01TYk/Qt6htQanGKXWoP71vujxFlrhfEOLJq9TbqSgKcOULo5GfvNec
   Uh2JCQKjGqps34jOxf7Pe15k9nFahFBaIoxKsNnX5kLL1N9K0UBtO7IpQ
   w==;
X-CSE-ConnectionGUID: XqZVW+PZTuOFPO38nc/X5A==
X-CSE-MsgGUID: FUgRKV59Qd+DfbBacc2Jsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046055"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="95046055"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 14:20:59 -0700
X-CSE-ConnectionGUID: MwtYXDOWQUyeNjvc1Pi/IA==
X-CSE-MsgGUID: k5pcRkPYSRSBd7NZSrDrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="235503751"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:20:53 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch,
	airlied@gmail.com,
	kuba@kernel.org,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	maarten@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	umesh.nerlige.ramappa@intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	anoop.c.vijay@intel.com,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 00/11] Introduce error threshold to drm_ras
Date: Sat, 18 Apr 2026 02:46:35 +0530
Message-ID: <20260417211730.837345-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279421-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,patchwork.freedesktop.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A374F41EA6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series reuses some pieces of [1] and [2] and introduces error
threshold to drm_ras infrastructure. This allows user to get and set
the threshold value of a specific error.

Detailed description in commit message and documentation.

[1] https://patchwork.freedesktop.org/series/164393/
[2] https://patchwork.freedesktop.org/series/160184/

Raag Jadav (9):
  drm/ras: Update counter helpers with counter naming
  drm/ras: Introduce get-error-threshold
  drm/ras: Introduce set-error-threshold
  drm/xe/sysctrl: Add system controller interrupt handler
  drm/xe/sysctrl: Add system controller event support
  drm/xe/ras: Introduce correctable error handling
  drm/xe/ras: Get error threshold support
  drm/xe/ras: Set error threshold support
  drm/xe/drm_ras: Wire up error threshold callbacks

Riana Tauro (2):
  drm/xe/uapi: Add additional error components to XE drm_ras
  drm/xe/ras: Add flag for Xe RAS

 Documentation/gpu/drm-ras.rst                 |  17 ++
 Documentation/netlink/specs/drm_ras.yaml      |  49 +++++
 drivers/gpu/drm/drm_ras.c                     | 165 +++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c                  |  27 +++
 drivers/gpu/drm/drm_ras_nl.h                  |   4 +
 drivers/gpu/drm/xe/Makefile                   |   2 +
 drivers/gpu/drm/xe/regs/xe_irq_regs.h         |   1 +
 drivers/gpu/drm/xe/xe_device_types.h          |   2 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  29 ++-
 drivers/gpu/drm/xe/xe_hw_error.c              |   2 +-
 drivers/gpu/drm/xe/xe_irq.c                   |   2 +
 drivers/gpu/drm/xe/xe_pci.c                   |   3 +
 drivers/gpu/drm/xe/xe_pci_types.h             |   1 +
 drivers/gpu/drm/xe/xe_ras.c                   | 207 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  19 ++
 drivers/gpu/drm/xe/xe_ras_types.h             | 123 +++++++++++
 drivers/gpu/drm/xe/xe_sysctrl.c               |  46 +++-
 drivers/gpu/drm/xe/xe_sysctrl.h               |   2 +
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |  87 ++++++++
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h   |  57 +++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  22 ++
 drivers/gpu/drm/xe/xe_sysctrl_types.h         |   7 +
 include/drm/drm_ras.h                         |  27 +++
 include/uapi/drm/drm_ras.h                    |  12 +
 include/uapi/drm/xe_drm.h                     |  11 +-
 25 files changed, 906 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_ras.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.h
 create mode 100644 drivers/gpu/drm/xe/xe_ras_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_event.c
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_event_types.h

-- 
2.43.0


