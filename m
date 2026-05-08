Return-Path: <netdev+bounces-285595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLaQHBpV/WkYawAAu9opvQ
	(envelope-from <netdev+bounces-285595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:14:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2254F10B2
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A52303FAA3
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F722D8795;
	Fri,  8 May 2026 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIsLoWxV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD32D738A
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 03:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209961; cv=none; b=HXEMb0fMGGakkZPg2UAhbxUVbw95A5XzOzofZ13WJFnUGaIp4ifFCLq3DOZJLDx/7Mdm+VV5ddeJxP1xtq6bNSCpyPyqBgPQtdqfePGzCsr1atRSimnOGj1gZXXCMapNwJGcbqE2tDRCY+x25+uCvhJo4X9ZPC13ZCLixE/CAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209961; c=relaxed/simple;
	bh=eC/N+PKSldiwuiYBHXeNZDIr7XUuCPxaNishs9wb0RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYFnapiwOaDs9OaFRGoV86LCcFNh4la3+qCNcTdT6nAzb5ZXAHZCygVZHCgfWOPFDhQlrqij2lG94TTUL8jhdniyYe0QDn2k7M3O0iPY1W2zGc+tY4HT2wT7cflNFRA/uFTzCEVc8WRb5HP2DjYmWQ4z8ufTLGNXCoCfvYiSQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIsLoWxV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778209960; x=1809745960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eC/N+PKSldiwuiYBHXeNZDIr7XUuCPxaNishs9wb0RI=;
  b=mIsLoWxVSz9QcU3mG6A4QI926Z/H7je4EQd2m4D1Eb+O6iBQmpSLeA0R
   lIcjfyjMpuk5dLrBR9C4jvUszku8ewmQIj0cS0vHbGPAu0TB2YSR2bBH0
   FZy7SOImC/sRJcccGDEWA6HPrHI8V7vFj/+3a3mzu2ed6QVKlS6Cv3WUi
   7G9zJfCDpivB2E6BnBcL7TAOuLPl0mSGoEmHPeqbo7z9ad6D9PYDQKCLN
   g022rW/5YpHgHPS7/xZbUrfIzCDoxGsw8s+CKikeljmNY6bADUDR+wSTV
   7m0gM+SjV29LyhEHWDi/IRQikwyA4n9gAFkg/unmKqDH7Dnv4ltT9FRtJ
   g==;
X-CSE-ConnectionGUID: anVQ0JEASqiVuyLyB9RAJA==
X-CSE-MsgGUID: Sonq8hTETl2tiHNBmeavQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027519"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="79027519"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:12:39 -0700
X-CSE-ConnectionGUID: OZ8l68wTRnSuHmKWn7WR2Q==
X-CSE-MsgGUID: LfYGDbFNQwKeHE7SAfbYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="241623218"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 7/8] ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
Date: Fri,  8 May 2026 05:12:25 +0200
Message-ID: <20260508031226.3601800-8-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA2254F10B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285595-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

From: Alexander Duyck <alexander.h.duyck@intel.com>

When operating in latency mode and the computed ITR is lower than the
current setting, the algorithm can reduce the interrupt rate too
aggressively in a single step.  For a TCP workload this means the ACK
stream (a latency-sensitive, low-packet-rate workload) can drive the
moderation down to very high interrupt rates, starving CPU time from
the sender side.

After the speed-based ITR calculation is complete, check whether the
result is in latency mode and would decrease below the current setting.
If so, limit the decrease to at most IXGBE_ITR_ADAPTIVE_MIN_INC (2 us)
per update.  This ensures the number of interrupts grows by no more
than 2x per adjustment step for latency-class workloads, dialling in
smoothly rather than overshooting.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index aea76b3..ba7b013 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2888,6 +2888,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		break;
 	}
 
+	/* In the case of a latency specific workload only allow us to
+	 * reduce the ITR by at most 2us. By doing this we should dial
+	 * in so that our number of interrupts is no more than 2x the number
+	 * of packets for the least busy workload. So for example in the case
+	 * of a TCP workload the ACK packets being received would set the
+	 * interrupt rate as they are a latency specific workload.
+	 */
+	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
+		itr = max_t(unsigned int, itr,
+			    ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC);
+
 clear_counts:
 	/* write back value */
 	ring_container->itr = itr;
-- 
2.52.0


