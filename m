Return-Path: <netdev+bounces-303826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yVaaCJWARWokBQsAu9opvQ
	(envelope-from <netdev+bounces-303826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:03:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1EA6F1B96
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:03:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TSddoast;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303826-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303826-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F1643004C94
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590F13815E8;
	Wed,  1 Jul 2026 21:03:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F92431E73
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939791; cv=none; b=iCkn/cv/PpxXVQduzXEvVgVvJyRkWAr5wcFH/m1HQkJiUxuQ+uQJK9SLRML6hDatiNWfW8nwRvnyeL2C87MsI6mNjmRvIKYtROkic4RdjN7PI2EtU8a2P53KaIIiDUHOfbj5HSfU5bVg9JtVdNDRy6FnG+gQPoSbWk2h8aZgN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939791; c=relaxed/simple;
	bh=MhiEQcncI9a8eN6XzEb60IZTBj9pRgvfxFj2NXZnUKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HroKhR6HFRMpexRBYjcp5p9FGlHyPT9RjrTRRNl2CywIdIJmGgaBBMCLIFZ9OoL7I5kI24oQGvDoVQBBUEhOwVtzcg9/awqiB0Jy/tdW+Hi3V73Uw0XkpWDoceYEmVV10XSpyCRCsofn6zSysUjXvh6Ws9Ywx/9U/ZbX0gU0FQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSddoast; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939790; x=1814475790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MhiEQcncI9a8eN6XzEb60IZTBj9pRgvfxFj2NXZnUKU=;
  b=TSddoasteMS9iQPv4An5Ezb91Umm5JIjRh7JqQmXYSp4YrQhe3b7kmCI
   6gNJ2lBSRW3tQ6K9vnksK9ynvAdq5p3r6T49baCHuS8cQKnhMol7sszxa
   3FYL4W4L+UwksOaAndqmfBtqaE6jNpSNix0UN7oLVhq7FAM8FM30XVhVy
   QfO06rznXoEVOzWQjSlVPe2N9H4WC/gMWFLnaC1ERqbmptgaDsMTQjfwC
   0nLMWGLYpd7z1iRdW2+BVXpJVYvLumNzix3OOYHP/XOkvU7ASwLf5ueyM
   P5M8TVspgJgvKOSeGpfXjYthBgrYb4DQtRHHZMKZLPfJ2v8niSPaIbskE
   A==;
X-CSE-ConnectionGUID: qXtKV3urTOaYBBmgAc109g==
X-CSE-MsgGUID: TS4tSaa2RPq0dF2pTa4N/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069070"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069070"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:09 -0700
X-CSE-ConnectionGUID: iQIK/YWbS/S6lw4LUHIggw==
X-CSE-MsgGUID: ZJ1O0BxDT+6nhYj/f+8jaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561389"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	horms@kernel.org
Subject: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver Updates 2026-07-01 (igc, igb)
Date: Wed,  1 Jul 2026 14:02:49 -0700
Message-ID: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303826-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E1EA6F1B96

Kohei Enju adds ethtool support for get/set hash key on igc and adds
setting of skb hash type based on values from Rx descriptor on igb.

Takashi Kozu adds ethtool support for get/set hash key on igb.

Faizal adds support for forcing link speed via ethtool when
autonegotiation is disabled on the igc driver.

The following are changes since commit d6e81529749190123aa0040626c7e5dbc20fdc9a:
  Merge branch 'net-fib_rules-rtnl-less-rtm_newrule-and-rtm_delrule'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Faizal Rahim (4):
  igc: remove unused autoneg_failed field
  igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
  igc: replace goto out with direct returns in
    igc_config_fc_after_link_up()
  igc: add support for forcing link speed without autonegotiation

Kohei Enju (4):
  igc: prepare for RSS key get/set support
  igc: expose RSS key via ethtool get_rxfh
  igc: allow configuring RSS key via ethtool set_rxfh
  igb: set skb hash type from RSS_TYPE

Takashi Kozu (3):
  igb: prepare for RSS key get/set support
  igb: expose RSS key via ethtool get_rxfh
  igb: allow configuring RSS key via ethtool set_rxfh

 drivers/net/ethernet/intel/igb/e1000_82575.h |  21 ++
 drivers/net/ethernet/intel/igb/igb.h         |   3 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c |  85 ++++--
 drivers/net/ethernet/intel/igb/igb_main.c    |  25 +-
 drivers/net/ethernet/intel/igc/igc.h         |   3 +
 drivers/net/ethernet/intel/igc/igc_base.c    |  35 ++-
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 277 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_hw.h      |  10 +-
 drivers/net/ethernet/intel/igc/igc_mac.c     |  35 ++-
 drivers/net/ethernet/intel/igc/igc_main.c    |  10 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  65 ++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 13 files changed, 425 insertions(+), 154 deletions(-)

-- 
2.47.1


