Return-Path: <netdev+bounces-259983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vsINN3sqnGlgAQQAu9opvQ
	(envelope-from <netdev+bounces-259983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:22:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C65C6174C42
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D05C8302AE37
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09B34F244;
	Mon, 23 Feb 2026 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5bVgICU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799D1514F8;
	Mon, 23 Feb 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842166; cv=none; b=TZ5wdq7tQ3ACGz4Rp7bcjcb1t2rzegqhVq6fBfcTeHn5azbSsq+ix4wATNuWocy8L+89NVw/mkWF/yLI5lUj6xqe66adVJXndjQUsFP5J1xW28Djh6lP3Apg5uiPecTZtdPoonjUDwgH/O/NRJqF7Wkg6CrtwxI0Lahl6d5u8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842166; c=relaxed/simple;
	bh=l+MBHZeoAJKuGomA3vp4AjGUwAnaEYYc7K+R5iWjZRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwShf+W3dqmH4aDnqGfeLSTZNXKtFU2CcA8sVAqK92yVSAFnjyLqx/tF3zoPlfV6+vwyNTsa0DvzX+RRhWIQyMKuXmTrTF1H3yivcZX/+jrlweufMchqvi7zjDGwsbQtxZgu4NzcJNQ93D3QY2ubUxfn38QwDkne+cM7kSiOb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5bVgICU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771842164; x=1803378164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l+MBHZeoAJKuGomA3vp4AjGUwAnaEYYc7K+R5iWjZRo=;
  b=D5bVgICUlL9Rm8mrz2Kts2qkgZTo+H7se6Jh6ufvgS/BPRtJ+A04XZVI
   dOt7UK1tsOdjxHFU4sa7NftzxZ/f4ZaGZRuKh+cCViKgnHEHOClqG4FFO
   zgaiXc4bTD3VxhieaNVZxyKEO5HaZKT6Muk/EXSERFwuE50hHdhFHGVQ8
   hI8IFLjKSs5KKWq5kcTnN6V+1fJIbMl9Bh2/X56IvojrFkTu21yI6C/QG
   +yOzxE26k0qx4If7b8EqhC8ETYACpevb00SCxJ+ZeftXvOdL4jtkUZDDv
   VOmr7YWeTmtbbDJeWHWT9zfDltG5xJ6VueAXn4sB1H/JzwUhv0H1WHUB3
   A==;
X-CSE-ConnectionGUID: 2+BRJGnnTliSnxSUFnFAQA==
X-CSE-MsgGUID: qSElgCw9TdSoIiAIFENamQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76444672"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76444672"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 02:22:43 -0800
X-CSE-ConnectionGUID: qmw+eeu8QJua+8CK3WWvOA==
X-CSE-MsgGUID: BvMecX+9SnqhBlLI/WU4vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246121703"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 23 Feb 2026 02:22:40 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5761628160;
	Mon, 23 Feb 2026 10:22:37 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 00/10] libeth and full XDP for ixgbevf
Date: Mon, 23 Feb 2026 10:52:07 +0100
Message-ID: <20260223095222.3205363-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259983-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C65C6174C42
X-Rspamd-Action: no action

Update ixgbevf with standard XDP features by utilizing libeth library.

First, in patches 1-4 refactor existing general and XDP Rx code
to use libeth fill queues. Then in patches 5-7, add support for
XDP multi-buffer and XDP_REDIRECT (target and source). Patch 8 addresses
particularities of one HW type by using a software header split.
Patches 9-10 address page pool not being reconfigured on MTU change.

Larysa Zaremba (9):
  ixgbevf: remove legacy Rx
  ixgbevf: do not share pages between packets
  ixgbevf: use libeth in Rx processing
  ixgbevf: branch prediction and cleanup
  ixgbevf: support XDP multi-buffer on Rx path
  ixgbevf: XDP_TX in multi-buffer through libeth
  ixgbevf: support XDP_REDIRECT and .ndo_xdp_xmit
  ixgbevf: reconfigure page pool when reallocating buffers
  ixgbevf: allow changing MTU when XDP program is attached

Natalia Wochtman (1):
  ixgbevf: add pseudo header split

 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/ixgbevf/defines.h  |    2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   48 -
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |   96 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1104 +++++++----------
 include/net/libeth/xdp.h                      |    2 +-
 6 files changed, 486 insertions(+), 767 deletions(-)

-- 
2.52.0


