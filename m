Return-Path: <netdev+bounces-306513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fs57N4/QUGq35QIAu9opvQ
	(envelope-from <netdev+bounces-306513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:59:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A0739EAC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:59:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="GpTgqZ/K";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306513-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306513-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B253055932
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4D411682;
	Fri, 10 Jul 2026 10:54:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE6411675
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:54:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680850; cv=none; b=uLAUZmwzjeELGUmnwcLUm+/gWF1Rgqm65Zsq1FsmFOEm6PBXYzvqU9NUpsMbpDpvCX+aGC5iJiWeRSUSxgbAIMD0Ip7aPQHS9Lgx5sjUvPk+ju78hyzZcq4M8EMxcU3M4h8YPOsv3boWND5f0eaSO66Gan8r7U5oGz51Keet8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680850; c=relaxed/simple;
	bh=xGzgHIEvWioMJ3fkiFs2XDNJ3kJUshkAsCOMvGfBvAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWSkgLWPQGI7XNq44SpO5HfNWb5UmaX3ov8UIa6Rf4uzzx8eg36DPrB1Fhl2UAcaPkgEymXu+FenIzalkcXliHFD9FAF8Llt6jWVY5WflzQ6KJpe7lQNhoW0+3QsyHOtH0aAZ/NDzxMPlf8ECIVR9d5BWUv/qRMWpxyOd0NRr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpTgqZ/K; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783680846; x=1815216846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xGzgHIEvWioMJ3fkiFs2XDNJ3kJUshkAsCOMvGfBvAg=;
  b=GpTgqZ/Kf5WlicHLkkmpsaH/UBv7Lmu48mZSfnhPcjj8xduHC6YIZnOl
   UFBufqB/tX9BikQBD9GfSCRCI7mheVLnpvjzEQ+brNaY1DTNlCrcmbWJc
   w0xZ3hy4EkR1UIsXoN5Lx+dHrF17+wQb/q9IWTQb5sVyOnemd4h/FiaRt
   WYfi6fYfE86914ckuoF6h+wZ1+VvnjJAU+ZsN1C7eP3UUvGetVEoVdqL5
   ss9ofy+dvwPCAExHZCHDH0lTlG3hqPfJwjd41FZacQubgQ6N8BEYDMWHY
   jbwHaLPPynDWr9/WJUF4llZDmqH3hESMR30v/+YP89nBqLWTG/od70277
   g==;
X-CSE-ConnectionGUID: fCdFJwM1R0WoliMqpPFwPg==
X-CSE-MsgGUID: 08Vh56HJTtSUILvlwt00zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86920265"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="86920265"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:54:05 -0700
X-CSE-ConnectionGUID: NNZh9D0wTEuxLzFA86UMMg==
X-CSE-MsgGUID: 4sHwm16ZS5yC4ATfrqmazw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259750952"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa005.fm.intel.com with ESMTP; 10 Jul 2026 03:54:04 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v1 0/2] Implement ixgbe PCI reset
Date: Fri, 10 Jul 2026 10:54:01 +0000
Message-ID: <20260710105403.1050025-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306513-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B9A0739EAC

This series adds an ability to properly perform PCI level reset
via sysfs to the ixgbe driver.

To achieve this, several operation handlers are refactored to
check whether the netdev is available during the invocation, and
the actual reset handlers are implemented which prepare the device
for the reset and re-initialize it afterwards.

Sergey Temerkhanov (2):
  ixgbe: Refactor device operations to check whether netdev is available
  ixgbe: Implement PCI reset handler

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   5 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  13 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  34 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  20 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 112 ++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |   4 +-
 6 files changed, 159 insertions(+), 29 deletions(-)

-- 
2.53.0


