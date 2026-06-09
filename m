Return-Path: <netdev+bounces-297189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7BnnF3RMKGpHBwMAu9opvQ
	(envelope-from <netdev+bounces-297189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:25:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0361662EBE
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Q9HHVLee;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297189-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297189-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A24E301EE1C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38D48AE04;
	Tue,  9 Jun 2026 17:25:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4B36215E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:25:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025906; cv=none; b=ofhfKP8vqn1o+hvGSyNnh0zFf83PPvXQnDmsZgsNAmRFTH/+efjsVvBtb29/xCSKHRzEbzec2ZEl4ECkmVikFSO5ySB8EK6WS9H1TDCV/Zdbt9GREVEG0DIAcZ+safg6GYJ3l4wRgMYnhiComnWrkDTNZ+9Ph+VpoLmsBL/eaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025906; c=relaxed/simple;
	bh=VuvrZhOahERiPEnoR8psCGdN87TZg7mRsVFM0v28rCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuuL5IxA3DZ/rNVZv6SEv3CjaX9pdeSHH+BblG0r/3PG2q5KZCoCXa9F9Z/XQUVaUD76sSc3Tbt5oHUl4m/eDeFfdaIVvx1v1EacWasjsevvE1k9otNkhMvJyByT2eby2ihjqd4PyHp0BSc4hEAC6ILnxsnHlyFHOF8EqO8UBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9HHVLee; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781025904; x=1812561904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VuvrZhOahERiPEnoR8psCGdN87TZg7mRsVFM0v28rCo=;
  b=Q9HHVLeeA57e99kOhGJ18S2m0JOG9FDqzleyS6cpuMieI1HL7+4pmly5
   bixngQvMZDa9advtcrfwVHW+BhbIyhE0LrHX2zQvaaRkXqIbWehfYz+qU
   UteIyUMlrUXhm+SrtXZ3/8ksgnclnDoC90NHNB4n9Xqi36/UMB8nA78Fw
   qo/200Y1+IFz82B5q4NnE3bqANd6Xa4GTzvVV9wo6QxmIYzqG45J+6FSp
   0qYmLX7xMdxBJmnIVmEqug6Aq2+4jA3DJ65irVyh9jKPe4mZBiUTFNjGZ
   q4nlKpYpN9XWyRGHvAd1jouAXvMoB9BdnctQIXDjoEeaue0W8tRDWPJca
   g==;
X-CSE-ConnectionGUID: FDPJma5cSf2QtZq4StzF+w==
X-CSE-MsgGUID: XYmcYyAoREOYtzZfc5Ze2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99373415"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="99373415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:25:04 -0700
X-CSE-ConnectionGUID: w/fQcriPQl+FRhqH+oy6Ug==
X-CSE-MsgGUID: cJoBymkQRUCxUHc8EFVgCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="250995084"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2026 10:25:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2026-06-09 (idpf, ixgbe, igc)
Date: Tue,  9 Jun 2026 10:24:53 -0700
Message-ID: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297189-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0361662EBE

Przemyslaw adds needed padding to idpf PTP structures to match firmware
expectations.

Larysa bypasses XPS configuration on XDP queues for ixgbe.

Khai Wen corrects offset into packet buffer when handling for frame
preemption on igc.

The following are changes since commit 0aa05daef7848a5ac11158949dc73cd741995dc1:
  Merge branch 'net-mctp-usb-minor-fixes-for-mctp-over-usb-transport-driver'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

KhaiWenTan (1):
  igc: skip RX timestamp header for frame preemption verification

Larysa Zaremba (1):
  ixgbe: do not configure xps for XDP queues

Przemyslaw Korba (1):
  idpf: add padding to PTP virtchnl structures

 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 12 +++++++++---
 drivers/net/ethernet/intel/igc/igc_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 ++-
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.47.1


