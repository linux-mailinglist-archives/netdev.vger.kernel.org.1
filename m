Return-Path: <netdev+bounces-294452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9qfpErhgH2qelQAAu9opvQ
	(envelope-from <netdev+bounces-294452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:01:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93860632BCE
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:01:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="m/q2KqWR";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294452-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294452-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FEE3304420F
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 22:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D43BC69D;
	Tue,  2 Jun 2026 22:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D933CB90F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:55:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440924; cv=none; b=PtD/pdx5GXlMGV7Bbfe6vrb26uWlEfAkvm8r+F65u8QAvGewH41qstoBd4QuaV0tDa0BHukpWpOfGFp687FM7I8b0h93NBIF0wSZhZoqbpshS/eqFlNWcimoPLlemWAsBEVXZRcuvRoRvs+XZqoWusHnn/xpOwxgRxL7GUFRNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440924; c=relaxed/simple;
	bh=1gPXyX9qlf669pfyosoehTWje1p/dsWF6pUPzY8+Rz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjnCmDoOPvtjJ1plyiFp1nn/AgQhoRb4WkZtooYmaSy1qE5dZC2l7qdDc9WvVFHvoBWI2SyJpIUzC4dkFzBKz7NDe23JUt64RWfnqR8IfTgXy5CMDioGCRGxCq2ELb26qSEcBrfZkzK4pHLtykAo5g+yiaawGvhuvgfR1wkTWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/q2KqWR; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780440924; x=1811976924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1gPXyX9qlf669pfyosoehTWje1p/dsWF6pUPzY8+Rz8=;
  b=m/q2KqWRkATXInt7OHExBD/5nj7JMsC3FMnESVZtIj8htd65CqYQzr6/
   h3d26/UzkQJUsP9f8HXy7e/mUJ/wqXP31hOcCW8R77Z1xB9hz/bpLxJZe
   TDxpaLzF2WwHf84wVG//MG7rF4cAvHrYC4uAmY0g6TR6pJUZ8jomLEF8q
   slX2d6/bmf2Icp9zmFGxY3PlsOZ1OyQjjhtV54NOGNGILbUhl3SyUbDYZ
   J48s/O1uT9iDipJCDFnQNnYyNQBOJcZ6+l8n0Wa80Y55ygewXMPNBsc3Y
   UfIxlUAiWLZRqVsVzvYBMYgSf78HTE4dmk0fRa7SXdCrGZtcYv39Mn9bG
   Q==;
X-CSE-ConnectionGUID: ApbHdtk0RpSQJGIvXXEmZQ==
X-CSE-MsgGUID: UTqDVLKzTcuYkIVldAWPxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81421414"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81421414"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:55:22 -0700
X-CSE-ConnectionGUID: 7pp43W8UTmuVClM+lKfmuA==
X-CSE-MsgGUID: ytb5/fDHRfartmLxNQvA8A==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jun 2026 15:55:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	willemb@google.com,
	horms@kernel.org,
	Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 3/3] idpf: fix mailbox capability for set device clock time
Date: Tue,  2 Jun 2026 15:55:11 -0700
Message-ID: <20260602225513.393338-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260602225513.393338-1-anthony.l.nguyen@intel.com>
References: <20260602225513.393338-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294452-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[oracle.com,intel.com,gmail.com,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:alok.a.tiwari@oracle.com,m:anthony.l.nguyen@intel.com,m:aleksander.lobakin@intel.com,m:jacob.e.keller@intel.com,m:richardcochran@gmail.com,m:willemb@google.com,m:horms@kernel.org,m:Samuel.salin@intel.com,m:aleksandr.loktionov@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93860632BCE

From: Alok Tiwari <alok.a.tiwari@oracle.com>

The current code incorrectly uses VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME
for both direct and mailbox capabilities, causing mailbox-only support
to be ignored and potentially reporting IDPF_PTP_NONE.

Fixes: d5dba8f7206da ("idpf: add PTP clock configuration")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 4a51d2727547..71fe8b2a8b4e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -51,7 +51,7 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 
 	/* Set the device clock time */
 	direct = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
-	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB;
 	ptp->set_dev_clk_time_access = idpf_ptp_get_access(adapter,
 							   direct,
 							   mailbox);
-- 
2.47.1


