Return-Path: <netdev+bounces-270734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBKZMLOpwWmUUQQAu9opvQ
	(envelope-from <netdev+bounces-270734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:59:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3F2FD804
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23CD23034E21
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30FB3E5580;
	Mon, 23 Mar 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WH3aJCBH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C53164DF
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299531; cv=none; b=g/zm+ysG+jQdvLQyL1uRE9u5unosKHRppDbqfcMaoU/oDzP1SMdOxgEhsAbljzpXgySa84wZ93tGAcRuNoApiPvoH1X8Ycxyf2Subun7UxRHl1dqFWK5/t8BwZmEtBAlRtxil0q2k04jmKoJ3P0I9fECiebW9k8I5Xyl9kfhl2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299531; c=relaxed/simple;
	bh=CQXcTut3zOdqhTiLqReZ493j8VAU1xfOepcfCb0NOjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXgMEQqlDxv5vI82Ow6jRsgG9ECCrKjoqatpkDS0mAuU3r7XlyF2sJO/nMoYHRsLmSIxQZo1hjvikCjdGKFaS5nHeRd4uwn1i/ksghJdDfALD1Ni2gxsaweYfXr1sryXGknC09antwVFe/uM4uWNSxc117qR4Ypciwy8ghSDslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WH3aJCBH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299530; x=1805835530;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CQXcTut3zOdqhTiLqReZ493j8VAU1xfOepcfCb0NOjk=;
  b=WH3aJCBHgxNkJjl/gNSLSviItU0dOb532u/gYxGS0P437uH0v1xQPUdL
   lv40z+KYNSfOvUWdYZnYWKeshx8HMJAjU/wKs5N5YqTv30csLC5+5kUOv
   et6rkI+Ts4YscpP+KlJBvtdNuQCcJlexgyxh6LoiskXkrANQSuhPK8QKK
   cOiesszzl7ZDQ5HF4o0Sd3QAGRusoqVJPnbYXeqkn7E/VzJCxKm7ivhh7
   xxaSFrDBIijF8XlbyL1+v/Hd8YQ2Haw8SWMtXRF8U/fp1y/+L6yfCE9hd
   GUJ/IXiufZIvGEHxMFpd3vMBduXuYhu+ow1qgW52PTnzv0b8Te2Hi+JQz
   g==;
X-CSE-ConnectionGUID: o3/2EUXsQm2FWzYsm4BSqQ==
X-CSE-MsgGUID: jftEJmC3QFSHGyTO8In2vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75375498"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75375498"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:58:49 -0700
X-CSE-ConnectionGUID: wiAlRF0/SkekkoRj7FHxFQ==
X-CSE-MsgGUID: dYSGw0uTQ3+EJtBtCXjL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224114410"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 23 Mar 2026 13:58:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2026-03-23 (ice, iavf, idpf)
Date: Mon, 23 Mar 2026 13:58:35 -0700
Message-ID: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270734-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 44C3F2FD804
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For ice:
Michal corrects call to alloc_etherdev_mqs() to provide maximum number
of queues supported rather than currently allocated number of queues.

Petr Oros fixes issues related to some ethtool operations in switchdev
mode.

For iavf:
Kohei Enju corrects number of reported queues for ethtool statistics to
absolute max as using current number could race and cause out-of-bounds
issues.

For idpf:
Josh NULLs cdev_info pointer after freeing to prevent possible subsequent
improper access. He also defers setting of refillqs value until after
allocation to prevent possible NULL pointer dereference.

The following are changes since commit bc0151c59e639c1311ee573434af74b4e2c81de4:
  Merge branch 'net-bcmasp-fix-issues-during-driver-unbind'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Joshua Hay (2):
  idpf: clear stale cdev_info ptr
  idpf: only assign num refillqs if allocation was successful

Kohei Enju (1):
  iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()

Michal Swiatkowski (1):
  ice: set max queues in alloc_etherdev_mqs()

Petr Oros (2):
  ice: fix inverted ready check for VF representors
  ice: use ice_update_eth_stats() for representor stats

 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 31 +++++++++---------
 drivers/net/ethernet/intel/ice/ice.h          | 22 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 32 +++++++------------
 drivers/net/ethernet/intel/ice/ice_main.c     |  4 +--
 drivers/net/ethernet/intel/ice/ice_repr.c     |  5 +--
 drivers/net/ethernet/intel/idpf/idpf.h        |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |  6 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  2 +-
 9 files changed, 60 insertions(+), 46 deletions(-)

-- 
2.47.1

