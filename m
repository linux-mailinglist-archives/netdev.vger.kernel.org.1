Return-Path: <netdev+bounces-295390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jlrzDj3LIWoYNwEAu9opvQ
	(envelope-from <netdev+bounces-295390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 568DA642C4F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:00:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=b2KHvH6Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295390-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295390-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A22300B9FF
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF839B482;
	Thu,  4 Jun 2026 18:52:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868D37EFE2
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 18:52:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599177; cv=none; b=Jupg0GxbrG+Cx1NfziciqK1EQSv3VYjdTubRl6Hmk0d80UNLDB7a02yEhGNoUoHOqJnZn3XIWaf+0tFRYtxiHyTDuBRohMdU4DhF9ggB3edJ+sfzTc7GnPpJkQs/cTiY00Lr5UDm1OAI8znp5cl8uFH42StutaBjP+LFZzcrUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599177; c=relaxed/simple;
	bh=9V4J+FoVT213VGkNyI9OrxpGl04W7qd2bIPubdgI0oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJfBfm9/XPqsZjmheVByyMa0fGav1Tx2C4GLzKBTd/F2PcgEk6o6VrvbNW3U/1dGTARCJMy3jcobTTlix89GrkGbyhHC2JXfGBfbCtRLoH08X1uBnKEhdJvLVRV4iRxtyNrtOrAheU6oV791FXEu0+fOLo8PjHNpP224aN1d4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2KHvH6Y; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780599176; x=1812135176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9V4J+FoVT213VGkNyI9OrxpGl04W7qd2bIPubdgI0oE=;
  b=b2KHvH6Y0+A1tW/dzanOrPnO7omhegsiJI/vAbeOVh5XhnrhX5Y+qYT/
   G+gFypfEXZH4FqOvbcH+a1MSqgKjyL6KIiLfr3KWOoXBhTHb4h5jPjhmi
   yH7PN+5NK86Rpz4/VBUg3dLv8R4alNzI2WI+npn5T8J8kyNk9jgVyRYJx
   b8mPmKGArgKU168UaGMILOuWfuHfEwnQDxWJTc97vjpbY5AhNxAeah/tM
   E3gH6rHGD09RXP/Kd7QQ5630Jq1wvu+D4LIVA2FnxxNU6/5rpW3QNxZLr
   chwwGd3/xnX/d9i0yKcdR+5/QFLl9qc81aSBkDZ59l3fr5TxwIp8qO6a4
   Q==;
X-CSE-ConnectionGUID: KBnzKzqTQze9p2sAdPkfng==
X-CSE-MsgGUID: dQKRhDMfR+uq7OqeMcxS2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81467776"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81467776"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:52:55 -0700
X-CSE-ConnectionGUID: gaVV8JknQ7WpjbxyXaKbbA==
X-CSE-MsgGUID: 8xV9yXDwRyOyiUreFb2ieg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="240162025"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa006.fm.intel.com with ESMTP; 04 Jun 2026 11:52:51 -0700
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
	dev@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	mallesh.koujalagi@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 0/4] Introduce error threshold to drm_ras
Date: Fri,  5 Jun 2026 00:16:39 +0530
Message-ID: <20260604184849.1011985-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	TAGGED_FROM(0.00)[bounces-295390-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:riana.tauro@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,m:raag.jadav@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,patchwork.freedesktop.org:url,vger.kernel.org:from_smtp,intel.com:mid,intel.com:from_mime,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 568DA642C4F

This series reuses some pieces of [1] and introduces error threshold
to drm_ras infrastructure. This allows user to get and set the error
threshold of a specific counter.

Detailed description in commit message and documentation.

[1] https://patchwork.freedesktop.org/series/164393/

v2: Document threshold definition (Riana)
    Return -EOPNOTSUPP on threshold callbacks absence (Riana)
    Cancel and free genlmsg on failure (Riana)
    Document threshold bounds checking responsibility (Riana)
    Add RAS operation status codes (Riana)

v3: Move documentation from yaml to rst file (Riana)
    s/value/threshold (Riana)
    Use goto for error handling (Riana)
    Reuse status codes and uapi mapping from counter series (Riana)
    Access request/response counter using local pointer (Riana)
    Mark unused field as reserved (Riana)
    Return -ENOENT on info absence (Riana)

Raag Jadav (3):
  drm/ras: Introduce error threshold
  drm/xe/ras: Add support for error threshold
  drm/xe/drm_ras: Wire up error threshold callbacks

Riana Tauro (1):
  drm/xe/xe_ras: Add support for error counter

 Documentation/gpu/drm-ras.rst                 |  18 ++
 Documentation/netlink/specs/drm_ras.yaml      |  32 ++
 drivers/gpu/drm/drm_ras.c                     | 167 ++++++++++
 drivers/gpu/drm/drm_ras_nl.c                  |  27 ++
 drivers/gpu/drm/drm_ras_nl.h                  |   4 +
 drivers/gpu/drm/xe/xe_device.c                |  20 +-
 drivers/gpu/drm/xe/xe_device_types.h          |   2 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  71 ++++-
 drivers/gpu/drm/xe/xe_hw_error.c              |  13 -
 drivers/gpu/drm/xe/xe_pci.c                   |   3 +
 drivers/gpu/drm/xe/xe_pci_types.h             |   1 +
 drivers/gpu/drm/xe/xe_ras.c                   | 297 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   7 +
 drivers/gpu/drm/xe/xe_ras_types.h             | 102 ++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c       |  28 ++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h       |   3 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   8 +
 include/drm/drm_ras.h                         |  29 ++
 include/uapi/drm/drm_ras.h                    |   3 +
 include/uapi/drm/xe_drm.h                     |  11 +-
 20 files changed, 811 insertions(+), 35 deletions(-)

-- 
2.43.0


