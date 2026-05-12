Return-Path: <netdev+bounces-287030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKnYKUv1AmrpywEAu9opvQ
	(envelope-from <netdev+bounces-287030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:39:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA54251DE35
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D341530536C7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9333815D9;
	Tue, 12 May 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6qMRO69"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58443A542E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578275; cv=none; b=dWfYUn6I0ycwG/V/yKewfjd1g8dTEqm4KGgJmQZmwH6bHdqtJ0U8qwnzHmdZOg6nWnoRBcdzFkYsK9vlOTcUF5WAgZ6BjY3ugS6vP3+mlTZntIHIAqFi1drcdcox1MrVw/b3XSAJhKB+CHTmLImKwJtl1lT3e/lT7/NS16fPYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578275; c=relaxed/simple;
	bh=j/vnRdBUw140QYqM2h8/QOdevi4qqQ39qEJwrDFReuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uAWjKByVXwY/uzNb1VgzI59pNbDroUM4NPF7vB98QC3ohV/7bIqJXtOvWxMUczDOZqUg+aHWM/MdCZs/qcx9/zAtqcpGBAhcYWC1w4VpNIEXSNA6ik1n6udW7de2O7leX82vzpYrk2C+yIKnlj6DustcO13mwh9If5fmKwpVEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6qMRO69; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778578274; x=1810114274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j/vnRdBUw140QYqM2h8/QOdevi4qqQ39qEJwrDFReuI=;
  b=E6qMRO69B2sHznjqhdpHI7/dPjwPPt6wsz+2R4fS/GJ79JsSlPhZyc/N
   FgsuXtWfNZQaIu491ucGG18ALcza/6GTEI9zOlvBapiBIpIFcA66LJxob
   T5baMHL/dU/IfXdM+sybJJlhoxndk+2td2WnVbb7czlCnQe+CAa37t+Kp
   XRwQ0UMzWs0dYyZezA+NfVU0no+3MJnGIloxYrJs3GGPbhuHFWZYEeEhJ
   TNMPxgKckMctgRKYj16qGPJCnOfkh0crnYJID/Q23NSUwjlIvNSenCgay
   X/+Jh9igriNDYCgEaWUKrGJPQliOR3yO6oFel2zeucTHu6SLR8aXMoCif
   A==;
X-CSE-ConnectionGUID: AMXyuuy8RfOzXZbIID6PTw==
X-CSE-MsgGUID: hAINsK5SRRahDUaLp/m/jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79663240"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79663240"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:31:13 -0700
X-CSE-ConnectionGUID: 7Q1uGT2FQ82tUUG+244+Cg==
X-CSE-MsgGUID: ohyL/FO3SRCGr7Exts/FGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231323201"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2026 02:31:12 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 0/4] return value of skb_checksum_help()
Date: Tue, 12 May 2026 10:47:25 +0200
Message-ID: <20260512084729.1338557-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA54251DE35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287030-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Hi,

most intel drivers ignore the return value of skb_checksum_help(). It
can fail, so pass this value to the caller, to allow dropping packet
without correct checksum.

Michal Swiatkowski (4):
  ice: pass the return value of skb_checksum_help()
  i40e: pass the return value of skb_checksum_help()
  iavf: pass the return value of skb_checksum_help()
  idpf: pass the return value of skb_checksum_help()

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 18 +++++++--------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 17 +++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 20 ++++++++---------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 22 ++++++++-----------
 4 files changed, 34 insertions(+), 43 deletions(-)

-- 
2.49.0


