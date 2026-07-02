Return-Path: <netdev+bounces-304066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EiibLok3RmrQLwsAu9opvQ
	(envelope-from <netdev+bounces-304066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:03:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0746F59CE
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:03:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=V2zpXtl2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304066-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304066-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EA4532110B5
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DFE47ECE0;
	Thu,  2 Jul 2026 09:35:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33442B32B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:35:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984913; cv=none; b=WVlE5NYe12LN9Vpp5M1FXRcbmRJLDrMxDGsqzKKEdWQbxCrsk+uPe9IYEK0EkiMKB/7il5SFKW5xPhWW0OhpzpSvP8iVEj1jBY5tx6gfRnEReqDSuyVoeKJ1nYOopcgXipY2iFW4zz3emyf3cTTvQQ0K+4gg1H96VShOAkEYPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984913; c=relaxed/simple;
	bh=+3smbMZN9q9hfDM0psll/UkMFyPSBbzwLxtftVIxZSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SOYubze34JyAjhQpv+d5Ph1oIgLouzDE87v1dfMT7U9il8fP/te5HhEH00iy5zWFS+kM0ksRaWoIyNx3l70jZjpIkN9qmuQcnZjF3nk1ytK3Vd2cB6Vcx4WTfHVP3h7uIcoJCOl3RZHBvUVlU5Vtw5UxvK9l5Fszg0wOCcsTG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2zpXtl2; arc=none smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782984911; x=1814520911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+3smbMZN9q9hfDM0psll/UkMFyPSBbzwLxtftVIxZSY=;
  b=V2zpXtl21hado1hNbNUSQ3HYdp8qUAfbvFoiTl9+sBm8zXsThfaxi5ib
   7JeEhdmgRROUwAIHQ/XL3tdM2lZtuVpnHb4lsx7G2AJMdihu1UpdQcUGb
   7QVyvkB3gJvI87nwIBtUQZQUjWMg+1RPspFGLGUUdqrPyqeZYlc2fnRky
   bftiYeuVbPf8g4wx6Hs5qSEip9VaTvSArCaL+ATZIwF/8OLTZwUz/BpA0
   MkIn9vQcKIQqIV2tBVt5HG9xE6bhwMGQ3h1dnRgaPCvjWQ05EEvU9hi50
   n7cu64IxV+jn2lMJzJJ1RbNDglDmjvlv8zONsHorgtS1u1GhfZ+UtDiJ/
   Q==;
X-CSE-ConnectionGUID: ES5cHfoYS7O1jHgIk9pWTA==
X-CSE-MsgGUID: 1mGvxQbeRleQrLRs5EyIyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87649799"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="87649799"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:35:11 -0700
X-CSE-ConnectionGUID: 8CcPIbC2SbywBWf03FR83A==
X-CSE-MsgGUID: bhC1K6BYSMWnom7kKuS2Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253476401"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2026 02:35:10 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1 0/6] ixgbe: improve FW/SW data synchronization
Date: Thu,  2 Jul 2026 11:15:47 +0200
Message-Id: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304066-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:jedrzej.jagielski@intel.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E0746F59CE

There are some possible discrepancies between data shown by the driver
with the actual NIC/FW state.

First 4 patches address problem with link state correctness. In some
scenarios FW may not be able to notify the driver about link change.
Along with fix, refactor the whole approach to LSE (Link Status Events)
enablement. As there's no any reasonable argument for disabling LSE
during driver life cycle, make them constantly enabled.

5th and 6th patches address problem occurring when FW changes MAC address.
There's no any kind of notify/event accompanying that change. Therefore let the
driver to poll for the new address.

Jedrzej Jagielski (6):
  ixgbe: E610: init Link Status Events mask just once
  ixgbe: E610: prevent from disabling LSE
  ixgbe: E610: do not disable LSE on driver down/remove
  ixgbe: E610: re-enable LSE unconditionally
  ixgbe: E610: add MAC address runtime refresh
  ixgbe: take rtnl lock before ixgbe_reset() is called

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  49 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   4 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 100 +++++++-----------
 5 files changed, 63 insertions(+), 93 deletions(-)

-- 
2.31.1


