Return-Path: <netdev+bounces-281727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOFaOJB48GmiTwEAu9opvQ
	(envelope-from <netdev+bounces-281727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:06:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F76480E77
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E1AF310B5A0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD983C73E1;
	Tue, 28 Apr 2026 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jqq5ptdo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EA3A7F47;
	Tue, 28 Apr 2026 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365966; cv=none; b=lBvQ8nwoCXwjmFjFcfwRNTRIN9dwprjUPrIJVU60t08mFCF36oTFXXuJBF3NtFS4APcWjzzbb6JDxtF1No394JEu4VK95aGufChJ0pGRo6LMwdEj8gkSvRhNrKpnoRJdtn0hez2jh6GRA6mGqG5GhS61meu4EnBcJvLCopuggdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365966; c=relaxed/simple;
	bh=5oFEzi2ZAlzlLxxWSINB4AWhGAI+ETKfgF9SiFdp+FM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWgeyKRcbFsWt86iQ9SZrXcm8soQ1sE8byi8Up5SID3oYpaAGG5KF4DG38iBHyKfik2fGnwD7o27NYXF5LH5R3WVD8CIQIREZytxT0gm5n34fsD7H0lTQSAOLM7Hjan38JQ78AmA+G0XWZhvGfvTR04vM1hy9PmnW3lnlEZMA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jqq5ptdo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777365965; x=1808901965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5oFEzi2ZAlzlLxxWSINB4AWhGAI+ETKfgF9SiFdp+FM=;
  b=Jqq5ptdoE92AvWPbmYFAC9+XhwPzXCosv6NfPOb2gtK9K0uA1WQtA3tE
   /VRmXp9I0lq7ucA3c7W+OK79yeW2IlrjE5pdNidAmbVQso1utN1CFQFr7
   vgjX8LvxAnVCm//SbnkhJTSyhpIuRsZRXvJBsY9cntUT8pcO2PigiuNaR
   Pk8VJ9dh5agQBQkfyDBo/+MEQeoJhV3u8urwr5zwTMzPAue7XwGWe+ky6
   nM95yIDS3PEjSWB5b5R3ogTDVIBHMl5Awph/hAyl0mNRRDqUTLMkH1us+
   oDmm02gmFD0UYs0KmZKpsRAqeTwvzXUtt7kEGzsrxfLHX9MOljKlpZePu
   w==;
X-CSE-ConnectionGUID: JfNLVCVCSOCQeJEvlttW2g==
X-CSE-MsgGUID: JMyryfZqTo6w2MwhbSc8yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77433235"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77433235"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:05 -0700
X-CSE-ConnectionGUID: BkRci9I/TyaSUJRvXcun8A==
X-CSE-MsgGUID: 7dbZ4OEdRLuIWVLsCO6wkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233027277"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:01 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH 0/5] selftests/xsk: foundational UMEM refactoring
Date: Tue, 28 Apr 2026 13:33:11 +0530
Message-ID: <20260428080317.702124-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53F76480E77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281727-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series refactors foundational UMEM handling in selftests/xsk.

It centralizes UMEM property setup through helpers, removes ifobject-level
UMEM ownership state, and normalizes umem_size/mmap_size usage across the
code paths touched here.

No functional behavior change is intended; the focus is internal
consistency and maintainability.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Tushar Vyavahare (5):
  selftests/xsk: Introduce helpers for setting UMEM properties
  selftests/xsk: Eliminate umem reference from ifobject
  selftests/xsk: Remove umem from pkt_generate parameters
  selftests/xsk: Use umem_size() helper consistently
  selftests/xsk: Introduce mmap_size in umem struct

 .../selftests/bpf/prog_tests/test_xsk.c       | 195 +++++++++---------
 .../selftests/bpf/prog_tests/test_xsk.h       |  33 +--
 2 files changed, 119 insertions(+), 109 deletions(-)

-- 
2.43.0


