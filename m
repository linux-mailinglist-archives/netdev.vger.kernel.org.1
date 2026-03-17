Return-Path: <netdev+bounces-268741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULIoIHHFuWmcNQIAu9opvQ
	(envelope-from <netdev+bounces-268741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:19:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DCE2B294B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A875A3034289
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B6E38F93B;
	Tue, 17 Mar 2026 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC6F1RuL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6932E121
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782361; cv=none; b=exf7fjG6sw+c8Rn9E51n6gtldz7+nFdb8Uj0tWmQQ5YKl8aob6S8kw+Z+YyQ7PLP2q3jaOjTSc1uXt4T5owap5AiYGAPoIikbF52Pr7UP/Nm9C/9mG46ucUE1SHcvw0l9dPfkjzuA5FPTIEfeKg+KXOjBDn+PL/GFGi5snzb9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782361; c=relaxed/simple;
	bh=zkYdbfmdrcIKYpzUl1+b+JGnCDLTbSlWTXdz8lul9+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPmQkrcaKLpobi80GamSD8x09u84mhP2rKp9nswVYXcCAglEKJpHuiUNWTwHvxiN+5KuXRMswesnwdTcoFGNa2mCfSDRoIOIlgUHN3fTDLfP33tHVWMdq0IwJyYwP8x7N1RZ67Hhg/f6Fr8pYgdfdFpX3um9fEpV/hAQww+bfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eC6F1RuL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773782359; x=1805318359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zkYdbfmdrcIKYpzUl1+b+JGnCDLTbSlWTXdz8lul9+s=;
  b=eC6F1RuL9YoUeaN2+so036njWSd+ZornvhJLIlPgd2Sy70PM3imGilgG
   Sv/Q42z9V1mC8ULYOCBU3IqQGIkS+9PzRIHz6minzmYPWgv0/IitFkr/N
   emJlZbX0gUNS1f+5GjJiJ+F4dXXGRqsL/Pn48T4kM4HzjffU9V0J37Io3
   P4DHZWoO0qI8vW+zh3cS+pfqDMVRs/zstIqvpTmRlutW0PZrsWs5MFiwH
   31tI5Zk2gUMMSB8lu2iMO1lWIMroSdxymjFl9diaO0a/+1kwN4f3p6ZJX
   KhWTasBICN9PxXUFxC2wtr/Qu+GOenqzzUIPlLimTyjsJM4TigrGT9Z1E
   A==;
X-CSE-ConnectionGUID: MYCCdXHfQ0uyZqZWEUMFhg==
X-CSE-MsgGUID: OdEB7ejzRJmZAFZ85Jqosg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85524754"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85524754"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:19:12 -0700
X-CSE-ConnectionGUID: bOna9mFDTMilE0HpiA78uQ==
X-CSE-MsgGUID: VW8veLJKRkeiI6LNOh6fMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="219477568"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 17 Mar 2026 14:19:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2026-03-17 (igc, iavf, libie)
Date: Tue, 17 Mar 2026 14:19:01 -0700
Message-ID: <20260317211906.115505-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268741-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D0DCE2B294B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kohei Enju adds use of helper function to add missing update of
skb->tail when padding is needed for igc.

Zdenek Bouska clears stale XSK timestamps when taking down Tx rings on
igc.

Petr Oros changes handling of iavf VLAN filter handling when an added
VLAN is also on the delete list to which can race and cause the VLAN
filter to not be added.

Michal frees cmd_buf for libie firmware logging to stop memory leaks.

The following are changes since commit 069c8f5aebe4d5224cf62acc7d4b3486091c658a:
  net: usb: aqc111: Do not perform PM inside suspend callback
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Kohei Enju (1):
  igc: fix missing update of skb->tail in igc_xmit_frame()

Michal Swiatkowski (1):
  libie: prevent memleak in fwlog code

Petr Oros (1):
  iavf: fix VLAN filter lost on add/delete race

Zdenek Bouska (1):
  igc: fix page fault in XDP TX timestamps handling

 drivers/net/ethernet/intel/iavf/iavf_main.c |  9 ++--
 drivers/net/ethernet/intel/igc/igc.h        |  2 +
 drivers/net/ethernet/intel/igc/igc_main.c   | 14 +++---
 drivers/net/ethernet/intel/igc/igc_ptp.c    | 33 ++++++++++++++
 drivers/net/ethernet/intel/libie/fwlog.c    | 49 +++++++++++++++------
 5 files changed, 86 insertions(+), 21 deletions(-)

-- 
2.47.1


