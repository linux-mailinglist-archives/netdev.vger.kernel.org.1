Return-Path: <netdev+bounces-303634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3dR6DZcPRWrp6AoAu9opvQ
	(envelope-from <netdev+bounces-303634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:01:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA346EDC19
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:01:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Kr3D3+JC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303634-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303634-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9A1330FCBFE
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA3481652;
	Wed,  1 Jul 2026 12:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F748123F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:45:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909934; cv=none; b=aqFsgYnc/xN3eKkgLmiBpbhZB/uHWLmKwiz+N+PWyIHPLJ7hYSXSMjF5UatUjK68kMLpqGxmaHn2kNVw8i6rKuOkmz+xxgeQV4y5le0Y/h/4TLiWsxXlDktkoXzGj+75KCE2VV/Rqa8Wn+HcH+6u44QY/yaL5tGpL0fDZWavAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909934; c=relaxed/simple;
	bh=MuMCGAKuSURSGZ99zUqZ6MIKOG38p+S2gkvkQ9ek3SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mbGDWYFovbQZ7jaAmmb/ZhLobnSeRuuS+1hd31aAcJ59aBP6RcZhFQP1J8oPjwFY7SW0ui3XgjVzOQO3ubPf5YjRVNMIIwCP4edfrm4raZWfsPuNl+s8GACiWi3ANB+vwzGCPWlcX3rF60lPf+tN/V3qfWA1FNkuhiZbr4lmgSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kr3D3+JC; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909933; x=1814445933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MuMCGAKuSURSGZ99zUqZ6MIKOG38p+S2gkvkQ9ek3SE=;
  b=Kr3D3+JC0vj4qHqo58fG7X6FP6mUd0yyXe2WDTqDzFU8X3F53clAyVio
   g/Qgf0myQoD2pYFhXnF1XUixxC5bIhuDpsmw/Y8I/aOQI1yXPO+x2qo0A
   EiFNGi/b4bipvMPR27KNCPkSz3AEROf5LmPr/OjgZqHD6IFZbc0uEWfM6
   Ss/slmEncD7EtskA6UVJC3OKDO/bPngLAoht4kY3R1FIQfU5zSWPkJJuE
   lSUOoFeIzknjllOUN5CpseEo1FZ1OHJ0/vsCPqx37cB/ZHOb9hOV4vVM1
   dirAF/g270ZhqwRWO5x6MG0sdV3CzP8BZlBeGTIImHu0g0k8LvsJjN6LG
   A==;
X-CSE-ConnectionGUID: GBbeAqASQ0yM85Kh1A04SA==
X-CSE-MsgGUID: xzFq1dTdR1W+uzuq2iAuFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839228"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83839228"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:45:33 -0700
X-CSE-ConnectionGUID: SYJ/FOJZT0ql9g0XrJ51jw==
X-CSE-MsgGUID: zPZCRhowQVWeltK5uRG2Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276864896"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:30 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH v5 net 2/7] i40e: avoid null ptr dereference in i40e_ptp_stop()
Date: Wed,  1 Jul 2026 14:45:19 +0200
Message-Id: <20260701124524.13644-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:maciej.fijalkowski@intel.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECA346EDC19

Sashiko reports:
***
If an allocation fails here during i40e_rebuild(), i40e_vsi_clear()
frees the
main VSI and sets pf->vsi[vsi->idx] = NULL, and the rebuild will abort
without
stopping the PTP clock.
Later, if the device is removed or unbound, i40e_remove()
unconditionally
calls i40e_ptp_stop(), which does:
drivers/net/ethernet/intel/i40e/i40e_ptp.c:i40e_ptp_stop() {
    ...
	struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
    ...
	dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
		 main_vsi->netdev->name);
    ...
}
Would this cause a NULL pointer dereference since main_vsi is now NULL?
***

Check if main_vsi is not null before calling dev_info().

Fixes: beb0dff1251d ("i40e: enable PTP")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index ff62b5f2c815..ca93df4d6785 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1556,8 +1556,9 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	if (pf->ptp_clock) {
 		ptp_clock_unregister(pf->ptp_clock);
 		pf->ptp_clock = NULL;
-		dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
-			 main_vsi->netdev->name);
+		if (main_vsi)
+			dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
+				 main_vsi->netdev->name);
 	}
 
 	if (i40e_is_ptp_pin_dev(&pf->hw)) {
-- 
2.43.0


