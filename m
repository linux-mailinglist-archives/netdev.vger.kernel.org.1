Return-Path: <netdev+bounces-279237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO3uLe3T4WnQyQAAu9opvQ
	(envelope-from <netdev+bounces-279237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:32:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D70041770D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6038C30B7BD3
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D642E173B;
	Fri, 17 Apr 2026 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/5HcH/j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0C29B77C
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407400; cv=none; b=fqDRGitGh6NQic41FBGDTPFEjJYpZ4nkiuSTxZ4165kfwf76HYAE8c3kD51ExuB3hv57PjeE5amAdnzjAYu4WogAzbzZeLZSlCfbt6nCT1DphiA0SnC/pI6N//0L9WKOwbAXwbGmIY6YDQjph+m5fsguQizAk/ZBymY2f3CezbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407400; c=relaxed/simple;
	bh=DzYVyl+UxGxHQKTpFAwP3BM3hQD64CpjO5PiAUi02gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8qf7X9KsWoNBw1ziPc41RJeJK7M/vS5I7c1EVain2JgI1U2FwQ53aR8LvlmApGvQV5pEpxcvOwk3xY7rIOnylcsd8V/Zu0N4UnBJIgK3xSK+x5GTrpF0cBpaXEWOq72xuInGU3DjBv6T5kthgBpR7REfnxGd4yvqJ+XQZM44yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/5HcH/j; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776407398; x=1807943398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DzYVyl+UxGxHQKTpFAwP3BM3hQD64CpjO5PiAUi02gA=;
  b=H/5HcH/j3cUaXMZNJW3VMDCdi26Se8V/Z7uNufiGpyVdY9WCOK/D5S1m
   jSDp+jYdMhLcZrdHBAfH7pUqlpXNMIqXommoLeubV/LjCXfT3WREfo7TC
   gjd7wQbvyvs7PHGwcdZTm+O9iJnODY+wtrBj35X1NZ0905G9PnUPsdhH5
   2kFMErEbn4Ih08bvxlooQaezuu7D8oXLkmXX+qwRV/Jj/dq5CoxPklFo5
   dzEt6YK6Q8jGwUNkXAne3PPSwAZydyAJFwwAxgCpSI/pP4EevIpdAOprM
   Dk8FFwgaOpridH99rgl5HO1fU04ognIHorj9+HIToyS59JIDq7o0iYL8J
   w==;
X-CSE-ConnectionGUID: dOST4HMiQYe8vIo4VFFKFw==
X-CSE-MsgGUID: 571irYttQfe8ixc1WyzC2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="94987399"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="94987399"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 23:29:57 -0700
X-CSE-ConnectionGUID: KwjDxTPLQpy+2db6yA0fNQ==
X-CSE-MsgGUID: zLZawi1ISGWnVsMte7Gf/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="235329560"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 16 Apr 2026 23:29:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net 0/4] ice: fixes for pause reporting, autoneg, RDMA and EIPE
Date: Fri, 17 Apr 2026 08:29:50 +0200
Message-ID: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279237-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D70041770D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is v2 of the ice fixes patchset for iwl-net.

v2 changes:
 - Dropped patch "ice: fix 'adjust' timer programming for E830 devices"
   as it has already been applied to the iwl-net tree.

This series fixes four issues in the Intel ice driver:

- Asymmetric Pause capability was missing from the ethtool-reported
  supported link modes, causing ethtool to always show Pause as
  unsupported even when the hardware supports asymmetric flow control.

- Autoneg disable was only attempted when AN had already completed,
  ignoring the case where the link partner does not advertise AN ability
  at all (AN37).  Both conditions should allow the user to disable
  autoneg.

- RDMA was incorrectly disabled on E830 devices with 4 or more ports
  because the generic port-limited-capabilities path capped maxtc=4 and
  then cleared the RDMA capability bit.  E830 does not have that
  limitation and must be skipped.

- On E830, Ethernet Inline IPsec Engine (EIPE) decryption errors trigger
  a checksum-error path that returned early without reporting the error
  to the OS.  The packet must be forwarded to the stack with the
  checksum error flag set so the OS can handle it correctly.

Jan Glaza (1):
  ice: report EIPE checksum errors to the OS on E830

Konrad Knitter (1):
  ice: fix autoneg disable when link partner doesn't support AN

Lukasz Czapnik (1):
  ice: support RDMA on 4+-port E830 devices

Tomasz Lichwala (1):
  ice: fix asymmetric pause negotiation reporting in ethtool

 drivers/net/ethernet/intel/ice/ice_common.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 30 ++++++++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 ++
 3 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.52.0


