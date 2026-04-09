Return-Path: <netdev+bounces-276854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM0bKaNO12mvMQgAu9opvQ
	(envelope-from <netdev+bounces-276854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:00:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C843C6CA5
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEE843008984
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B43081BE;
	Thu,  9 Apr 2026 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSKG1jV1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266CE36214C
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718044; cv=none; b=SYyXVh84vdJhIJlXO1I3DhlVEvpJGCJe5Sw8uLQ3jM6jWn/YV2SnAAcmhFTdY/Q0qXFtZ5b42+I83b8THBe90jR5ibmv0Bb6w0NYHRaeESLpzKhCyaz35fdrleKEsEn/Wb0V7ZJHwZAv+qdmoezay2OlVx64R4WQ4JEoCj9wLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718044; c=relaxed/simple;
	bh=T4M9Ilus/mDBe+iZLkGYCpJEjvL/6Z+DbmJz4pcsGAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1dLBg9Z3Nmk6Eu4GClPlok02c4cbfotv3F2FvmGJ95wyq/UOeJ97DQEIKvZ3UO/yGtmlopRMyekqjR7XKd/KQMUebOQAK7v5BZQfY1LJHteYCfFVkcNLMTmP/ffPJlN06E2sY2yW2ot8unNAB0LNUYyDwMo3pWCXD5ObapDU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSKG1jV1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775718042; x=1807254042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T4M9Ilus/mDBe+iZLkGYCpJEjvL/6Z+DbmJz4pcsGAg=;
  b=aSKG1jV1TbkIePqI5bKhYkmdMT7AqHKIoyDnmevSHHmSO3IJeoeuMnYj
   gPUn/phwQ52qOWCDTcoeZBm5Kuk5sSR6WtgPLpZFdGU48HQyCoYMdyLTY
   jXsRe1l91jLl7Dzge8GNe1rVJHHtsnY2NSp+pgyn1wEPPn8FkraOn2Jdi
   Uri9JxzKgSiWLFwfXFQcu50Otmc30sL1ml+/HuCz1Su1y5ySeG5rlkTiR
   qvHjVU61nY9nKbKhyCj358se3HEiPJqq+LvBZRBm/Vvlo0MK1ITxqRrik
   9eZQTr8Y6UeSWhN5nN/4qJ4yF50R0+k7NwuoyLfzUUoytwoXfdGlv8YbD
   w==;
X-CSE-ConnectionGUID: SIS4teGXQo+M+5b3StU7dA==
X-CSE-MsgGUID: 4ntafryKQh2EyVmnhEWGeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76836415"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76836415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:00:42 -0700
X-CSE-ConnectionGUID: egu1r6z2S0GbnisB6OAfQA==
X-CSE-MsgGUID: Und1Me7LQvGy6U6mPegjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="233576390"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:00:37 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	anvesh.bakwad@intel.com,
	maarten.lankhorst@linux.intel.com,
	Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v2 0/2] Add clear-error-counter command to drm_ras
Date: Thu,  9 Apr 2026 13:03:18 +0530
Message-ID: <20260409073318.2909379-4-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276854-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,ffwll.ch,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[intel.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87C843C6CA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add clear-error-counter command to drm_ras to clear a specific error
counter of a node. The request parameters for this command are
node-id and error-id and no response payload.
Implement the callback in XE driver to demonstrate usage.

Usage:

$ sudo ynl --family drm_ras  --dump get-error-counter --json '{"node-id":1}'
[{'error-id': 1, 'error-name': 'core-compute', 'error-value': 0},
 {'error-id': 2, 'error-name': 'soc-internal', 'error-value': 3}]

$ sudo ynl --family drm_ras  --do clear-error-counter --json \
'{"node-id":1, "error-id":2}'
None

$ sudo ynl --family drm_ras  --dump get-error-counter --json '{"node-id":1}'
[{'error-id': 1, 'error-name': 'core-compute', 'error-value': 0},
 {'error-id': 2, 'error-name': 'soc-internal', 'error-value': 0}]

Rev2: Split patches

Riana Tauro (2):
  drm/drm_ras: Add clear-error-counter netlink command to drm_ras
  drm/xe/xe_drm_ras: Add support for clear-error-counter in XE drm_ras

 Documentation/gpu/drm-ras.rst            |  8 +++++
 Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
 drivers/gpu/drm/drm_ras.c                | 43 +++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
 drivers/gpu/drm/drm_ras_nl.h             |  2 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 35 +++++++++++++++++--
 include/drm/drm_ras.h                    | 11 ++++++
 include/uapi/drm/drm_ras.h               |  1 +
 8 files changed, 122 insertions(+), 4 deletions(-)

-- 
2.47.1


