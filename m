Return-Path: <netdev+bounces-240589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23101C76BC3
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1EAA4E3EEC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22D1B423B;
	Fri, 21 Nov 2025 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0YzzOVl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F581EDA0E
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684356; cv=none; b=sMdAaSzcrRBgEOSZ5d+UIBm7ouDyt1NJlM8S6Is/XrJC0Dz6PDpSYZ60Hbqn1tTTgrvKVyQkYaHDcjCBbOFbcX3IzHsz7AFkQES54ucOW02vMoLcci3WoRzR1qoEBv4kcd69tPZr2LTwHTVGQ57etPHNmz05pAnXn7V2N2Xmghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684356; c=relaxed/simple;
	bh=qWROP2XSUucL+gmsULmuhI3tNKQmpDMqCa8m6+MfTHA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=M4wc3zeyyK1GmZ5WEjbfiJqwlK6dhQI5R3gUN9iNGIz2d+yI5dCWK1+WTdItlgLupI9+pk9DeGrdYMUPNC0ojokXUno537K/X1wal4fsWGmnyX3FA3ZqzNft0P4s6Om+JVy1DtgXdbBeis2YAE0eaFof1gfqx3gEOVXALXn+aNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0YzzOVl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763684355; x=1795220355;
  h=from:to:cc:subject:date:message-id;
  bh=qWROP2XSUucL+gmsULmuhI3tNKQmpDMqCa8m6+MfTHA=;
  b=d0YzzOVlu+p6zsOlScD6KKCYX7dyfC4VgFeUF14RaYQadZKse6Xvjr76
   IaR8f9phV/lG9TJRD3nXMuFhPHYy8n8zd7lFf+BHpt+4sulOfD6CSXlGm
   QGhz88eNsaC44H1Rq2WYEqYTCG2k5XC8gJUhV10VWVIXdEKnLEvIqlp3h
   f0D7xE7Owb3o+DjkbE45rEAtyoUN0iOpQIQSEPBi0Bk2AxmpZErK5OYW0
   63KLc9D/5AiV2zf369I1WGd7j4F9awQY18L4TQpfprEqHErxDiXM+VzAn
   fymBkfbGT1b7yCRDrigky2OMnJTuFtKok+RhihFrsEGTX5gLktXGP4/xO
   w==;
X-CSE-ConnectionGUID: 7kxG+b2bR36MM5Apytim/g==
X-CSE-MsgGUID: ORC+U0ceQ1m52Xzqq0qfhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65704044"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65704044"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:19:15 -0800
X-CSE-ConnectionGUID: 4ULaXcr7SmqKbg1VjSd0Xg==
X-CSE-MsgGUID: LM2ocbsPQ6iPtkKTGsRe/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="190815165"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 20 Nov 2025 16:19:14 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: [PATCH iwl-net v2 0/5] idpf: fix issues in the reset handling path
Date: Thu, 20 Nov 2025 16:12:13 -0800
Message-Id: <20251121001218.4565-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Resolve multiple issues in the error path during reset handling of the
IDPF driver:
- Mailbox timeouts in the init task during a reset lead to the netdevs
  being unregistered.
- Reset times out and leaves the netdevs exposed to callbacks with the
  vport resources already freed.
- Simultaneous reset and soft reset calls will result in the loss of the
  vport state, leaving the netdev in DOWN state.
- Memory leak in idpf_vport_rel() where vport->rx_ptype_lkup was not
  freed during a reset.
- Memory leak in idpf_vc_core_deinit(), where kfree() was missing for
  hw->lan_regs.
- Crash on reset following a failed init on load, due to the service
  tasks still running in the background and attempting to handle the
  reset while resources are not initialized.

Changelog:
v2:
 - Patch 1 - No change.
 - Patch 2 - Changed the check for vport being NULL by accessing it via the
   adapter struct instead of idpf_netdev_priv. This avoids potential NULL
   pointer in the case where the init task failed on driver load.
   Updated comments to clarify vports can be NULL before the call to
   idpf_attach_and_open().
 - Patch 3 - No change.
 - Patch 4 - No change.
 - Patch 5 - New to the series, to fix a crash, following a failed driver
   load due to an error in the init task.

v1: https://lore.kernel.org/intel-wired-lan/20251110180823.18008-1-emil.s.tantilov@intel.com/

Emil Tantilov (5):
  idpf: keep the netdev when a reset fails
  idpf: detach and close netdevs while handling a reset
  idpf: fix memory leak in idpf_vport_rel()
  idpf: fix memory leak in idpf_vc_core_deinit()
  idpf: fix error handling in the init_task on load

 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 156 +++++++++++-------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   4 +
 2 files changed, 96 insertions(+), 64 deletions(-)

-- 
2.37.3


