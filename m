Return-Path: <netdev+bounces-283878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKxfLjux+Gk6zAIAu9opvQ
	(envelope-from <netdev+bounces-283878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:46:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F067B4BFFBF
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 780D3304591D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381523E51C4;
	Mon,  4 May 2026 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/sfJ9CA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E033E4C9A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904697; cv=none; b=PsOpsmCE6uivSCnDLsMv7GZgDt1nNMGSmEqfmHzfe2apaThkYhYLJpUhbGigGN0/enwRNTRElqJfruRNtBv8G+zHB87xdiC0VZaW4q6bFxh2+vatamZEuXNSw+e+DTuG0Xw60qsDBz6Txkh6eZ7fmn4iswQRhW45B3YHsyzEXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904697; c=relaxed/simple;
	bh=Y1C501JONhNNAVfQFgCHZpYKC+oUFWqSXemVKft+MIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J59+Nj+ymH7DdKDkfaPE9hfhZdpNIg6Qjs8rNf+MqHbZPUyLZDJiLW/Wewra2qm+ngMz91SvWqImIHKidhDnTP5vcy/+ZVv+3ymwDmvftWZGQE/xEMbuRm9AoquM+kM+f6Yx/CW7J7aFESE/OtmQP2slvYabZ9fCGBa+ukvubgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/sfJ9CA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777904696; x=1809440696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1C501JONhNNAVfQFgCHZpYKC+oUFWqSXemVKft+MIg=;
  b=O/sfJ9CAVCWhEE+Rf6PhhBeZZJWF+n/wSw1GuwIR4LxzxRfCf4Us4Zc+
   qCF7f0hwMuozbTKvVjouVSQvq1XInwrgV9Z55bGSw9btGybsduCv1MNEZ
   20lmTwHZT05HPgSM0lsNs6xaWKdwGjrCSHe6Zf9mRQ37ceo2inkoFiUGX
   1+rl8Cyanw60c2l1BWlXubjvKzQKWsFI89H73DfG5jA1hcnRaMsnf78Xp
   COLjH7Yq0IYINFj1L4pLlBGL2cAHtfyHEkgbvMXWMb9bdj7CQd/Z0K+4r
   B+4gJwhy0Sxxz/FZHKci2eGde/2qK84S3QeHxN9XCrQ225v4p1FgJ2FYn
   w==;
X-CSE-ConnectionGUID: 9EdTFs/ZQ5ecPDmw5qc/sA==
X-CSE-MsgGUID: xVvRWcu3QtyT8qjChNKO8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78691605"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78691605"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:24:56 -0700
X-CSE-ConnectionGUID: DtNeDCJ5QO6cpHa5Uf28mw==
X-CSE-MsgGUID: 4+F3EXs1SGysiJaM5A9EOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="230935398"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 04 May 2026 07:24:54 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 1/5] ice: fix ETH56G Rx offset type description in kernel-doc comment
Date: Mon,  4 May 2026 16:24:47 +0200
Message-ID: <20260504142451.4161845-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504142451.4161845-1-aleksandr.loktionov@intel.com>
References: <20260504142451.4161845-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F067B4BFFBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283878-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Karol Kolacinski <karol.kolacinski@intel.com>

The ETH56G MAC register configuration Rx offset field stores a signed
integer, not an unsigned one. Correct the struct comment that incorrectly
described it as '11 bit unsigned int'. Also update 'unsigned ints' to
'unsigned integers' for consistency.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 9bfd3e7..c1aa408 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -144,9 +144,9 @@ struct ice_vernier_info_e82x {
  * @tx_offset: total Tx offset, fixed point
  * @rx_offset: total Rx offset, contains value for bitslip/deskew, fixed point
  *
- * All fixed point registers except Rx offset are 23 bit unsigned ints with
+ * All fixed point registers except Rx offset are 23 bit unsigned integers with
  * a 9 bit fractional.
- * Rx offset is 11 bit unsigned int with a 9 bit fractional.
+ * Rx offset is 11 bit signed integer with a 9 bit fractional.
  */
 struct ice_eth56g_mac_reg_cfg {
 	struct {
-- 
2.52.0


