Return-Path: <netdev+bounces-252551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO5OHWimcmmMoQAAu9opvQ
	(envelope-from <netdev+bounces-252551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:36:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D696E341
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D93F8300146A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F13B4C81;
	Thu, 22 Jan 2026 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLiKXCc4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041F393404
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769121374; cv=none; b=RMoio3XeZ5dyBQJGpwQsZs9C3Td9BHdc/gQYddu8GEjMb1VRT6l1DxLuhw0B4/pf9HHgA7WhscWYOv0wZPLBWd9c9rKAEIWEOx9QIUaKvJD0OFwzNOPyh+t21J5Suxvoo4jgv/eUDSwZ30vc1eWeSbPm8CBv64zSzDO59xi/Zzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769121374; c=relaxed/simple;
	bh=QVSsG7QeNb2ZhqOJZdfXRoExYsLhPV8Lf45ekBO3SR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BK0CIrycRwJ44Z+VavcKjOS1prWYoX7YBRfw4MNWsywAM7UIYdDazayJLm5UIg7Gsk9oj4xrA5tE/+maX8JEH9u8AT0KTOINBdTszIBIev7fRjHm5f9YmQIgsILyzFqggTSTOFhsWDqxYtFAmiLaY8GSeVA3OOTttEn/fZbFlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLiKXCc4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769121370; x=1800657370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QVSsG7QeNb2ZhqOJZdfXRoExYsLhPV8Lf45ekBO3SR8=;
  b=GLiKXCc4s2uHLRijIxket9D1OBov9yFnHjQ3OugCT8asZBvkCzFWVHR9
   XR0CT9DRQXy0YOqJjqtCV1a86zIOh5MQz/NwMtv2mRt7dxjIZp9/C9QUK
   S25dLmVvpOnFeLrpEjT7IxDf29gtw0Pa7uDAkUV4DoWqkv9KzsB+Wgs72
   koEozFzuMsbH2Mpb5Drgz5e6N3yj0orzgkD2wOiLvD3Frv5YjOWe1BKO0
   Qra42IjeHbKyDOWg0Jw5olquOHs3YIOnMWNkdRdhOn4ZOBBezTpvuwfPV
   YAc0ppGpMn+rsb0i/rrGdQGxTLQvefM4rmHUzmuKcqOfAkv3xycjTHMKq
   Q==;
X-CSE-ConnectionGUID: obu2APvHS02Yu8FHi5ox1g==
X-CSE-MsgGUID: jSE5JuJfTAaMH7DcVRV51g==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="93039243"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="93039243"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 14:36:08 -0800
X-CSE-ConnectionGUID: aCLfPs1pTCu8S1U4ElQO1w==
X-CSE-MsgGUID: TuhYw6U/SPqJYvutJT2U4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="206670441"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 22 Jan 2026 14:36:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	samuel.salin@intel.com
Subject: [PATCH net-next v2 00/10][pull request] refactor IDPF resource access
Date: Thu, 22 Jan 2026 14:35:46 -0800
Message-ID: <20260122223601.2208759-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252551-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07D696E341
X-Rspamd-Action: no action

Pavan Kumar Linga says:

Queue and vector resources for a given vport, are stored in the
idpf_vport structure. At the time of configuration, these
resources are accessed using vport pointer. Meaning, all the
config path functions are tied to the default queue and vector
resources of the vport.

There are use cases which can make use of config path functions
to configure queue and vector resources that are not tied to any
vport. One such use case is PTP secondary mailbox creation
(it would be in a followup series). To configure queue and interrupt
resources for such cases, we can make use of the existing config
infrastructure by passing the necessary queue and vector resources info.

To achieve this, group the existing queue and vector resources into
default resource group and refactor the code to pass the resource
pointer to the config path functions.

This series also includes patches which generalizes the send virtchnl
message APIs and mailbox API that are necessary for the implementation
of PTP secondary mailbox.
---
v2:
Patch 1:
- Defer assignment of q_info->num_chunks until after allocation; set to
  0 on alloc failure
- Add check for error in error path of idpf_initiate_soft_reset()
- Add missing 'struct' in kdocs
Patch 3:
- Add backpointer reference to dev struct in qvec_rsrc for persistent use
  in free functions
Patch 8:
- Add check for NULL on idpf_vid_to_vport() call

v1: https://lore.kernel.org/netdev/20260115234749.2365504-1-anthony.l.nguyen@intel.com/

The following are changes since commit b00a7b3a612925faa7362f5c61065e3e5f393fff:
  net: atp: drop ancient parallel-port Ethernet driver
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Joshua Hay (2):
  idpf: move some iterator declarations inside for loops
  idpf: remove vport pointer from queue sets

Pavan Kumar Linga (8):
  idpf: introduce local idpf structure to store virtchnl queue chunks
  idpf: introduce idpf_q_vec_rsrc struct and move vector resources to it
  idpf: move queue resources to idpf_q_vec_rsrc structure
  idpf: reshuffle idpf_vport struct members to avoid holes
  idpf: add rss_data field to RSS function parameters
  idpf: generalize send virtchnl message API
  idpf: avoid calling get_rx_ptypes for each vport
  idpf: generalize mailbox API

 drivers/net/ethernet/intel/idpf/idpf.h        |  179 ++-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   18 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   93 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  225 ++--
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    |   17 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  716 +++++------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   44 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   21 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1096 +++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   88 +-
 drivers/net/ethernet/intel/idpf/xdp.c         |   48 +-
 drivers/net/ethernet/intel/idpf/xdp.h         |    6 +-
 drivers/net/ethernet/intel/idpf/xsk.c         |   12 +-
 13 files changed, 1417 insertions(+), 1146 deletions(-)

-- 
2.47.1


