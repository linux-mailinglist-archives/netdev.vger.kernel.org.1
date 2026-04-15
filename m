Return-Path: <netdev+bounces-278653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL8rIO0m32nmPQAAu9opvQ
	(envelope-from <netdev+bounces-278653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:49:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A07F400944
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95781303262A
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35CC372ECD;
	Wed, 15 Apr 2026 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPayYKbf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1BB3016F7
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232167; cv=none; b=gnWA22VC2mC3yGdsMx0qW40j9a7tB+XnFFtMmDVLqwSl19XNgd0AX7U8iRQMJCxF9YHbb0j0gcTk8E317+TRzri6z9GMxtURWbyz2MCs+jktb2sDDtohroQzNfhwV5udIPySmKgyglNhxOSvCASSqhhx9e3V7LqU2ygme09Wr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232167; c=relaxed/simple;
	bh=F+pCx9q6iaoviWnoCOWnc0+owlRgs9dY0jkuAjy9Wbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCul4oJ6n5ftF23inVWzxFlQqb6mzm5/jCvqyC5KatY1a35vQ3Ub2CI1PWw+kqYYbwr3GnWzmja206d9r/ozeLPrHIqTpeqTBKZd8VUHzoK0Sc1UXCd15nc6AT69QOblOMrFwc0z+94saThZuJPlqp+t8fjtdNs7oae+OVDdPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPayYKbf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776232166; x=1807768166;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=F+pCx9q6iaoviWnoCOWnc0+owlRgs9dY0jkuAjy9Wbk=;
  b=nPayYKbfayMu2RVKp1ZtSr7B2yjpovsw5474eKVbObNkvD3K4Iu31i5J
   tvzm5x+eu8Zy4T/JxMx0702ltMGKI0bIDPBgC2roA4PwhLWrSyE78d45C
   LNeKtUBqwaYC52RAOr89MhyudgDcFT/abjEDxF3Ir06auSHkQuPbdoAxU
   qxqq1c925vvD2Jrwhn2bDJeCIV/EsXADnaGHYD76I2FM77Xd2Sx+q692P
   khY649ezlXMShDAYXo+ucE54s0EgbNpft7aNPvkexwE0ckiXSgFuwPIcR
   HDIQdKjIROTm4mx2LZh6LlilTQkc1tDsJCA7XSncIrPwL+Yfl2HOuhU0n
   A==;
X-CSE-ConnectionGUID: h4Pn2bUwS2aZebqDV2APcQ==
X-CSE-MsgGUID: FypljWEySwewinwdyAu5Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77105913"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77105913"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:24 -0700
X-CSE-ConnectionGUID: zuEvi+NqSFu5SLmrSdOcGg==
X-CSE-MsgGUID: LGDyJPr/QJSC6+Rc95q/fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253714788"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 Apr 2026 22:47:56 -0700
Subject: [PATCH net 01/13] ice: fix 'adjust' timer programming for E830
 devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260414-iwl-net-submission-2026-04-14-v1-1-852f38e7da39@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
In-Reply-To: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=YT7rBeaHMM8vuYH3UElHDwqB8cGDh9rOieBU1cTBobA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsz7ag9cdtrHix1rD9R6qZmia3fxwaZzeQduf71z1q7cZ
 s7xN5NOd5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRf84M//Nbnz+3an1esi1s
 0RbPczLhLxacv/7qQp/mw142mdfXBTwY/goG7Vw5z/F61/qqLG3DrO3rpb9c5f/y1fy8gJrZNpO
 71awA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278653-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:email,intel.com:dkim,intel.com:url]
X-Rspamd-Queue-Id: 1A07F400944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Fix incorrect 'adjust the timer' programming sequence for E830 devices
series. Only shadow registers GLTSYN_SHADJ were programmed in the
current implementation. According to the specification [1], write to
command GLTSYN_CMD register is also required with CMD field set to
"Adjust the Time" value, for the timer adjustment to take the effect.

The flow was broken for the adjustment less than S32_MAX/MIN range
(around +/- 2 seconds). For bigger adjustment, non-atomic programming
flow is used, involving set timer programming. Non-atomic flow is
implemented correctly.

Testing hints:
Run command:
	phc_ctl /dev/ptpX get adj 2 get
Expected result:
	Returned timestamps differ at least by 2 seconds

[1] Intel® Ethernet Controller E830 Datasheet rev 1.3, chapter 9.7.5.4
https://cdrdv2.intel.com/v1/dl/getContent/787353?explicitVersion=true

Fixes: f00307522786 ("ice: Implement PTP support for E830 devices")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 61c0a0d93ea8..5a5c511ccbb6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5381,8 +5381,8 @@ int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval)
  */
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 {
+	int err = 0;
 	u8 tmr_idx;
-	int err;
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
@@ -5399,8 +5399,8 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 		err = ice_ptp_prep_phy_adj_e810(hw, adj);
 		break;
 	case ICE_MAC_E830:
-		/* E830 sync PHYs automatically after setting GLTSYN_SHADJ */
-		return 0;
+		/* E830 sync PHYs automatically after setting cmd register */
+		break;
 	case ICE_MAC_GENERIC:
 		err = ice_ptp_prep_phy_adj_e82x(hw, adj);
 		break;

-- 
2.53.0.1066.g1eceb487f285


