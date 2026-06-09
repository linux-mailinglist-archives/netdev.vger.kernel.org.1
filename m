Return-Path: <netdev+bounces-297306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id opdCCCmJKGp3FwMAu9opvQ
	(envelope-from <netdev+bounces-297306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:44:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B76E664502
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:44:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=EKR9dzTz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297306-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CB4C309C557
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8970C4ADDA8;
	Tue,  9 Jun 2026 21:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F223EC2F6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040979; cv=none; b=gzg33MMRy9uzwI5Leziuu5i4fgWDEhXr/kEa7MOI+PI7DOHvIV5E30VC/dDojtNiqNOGpJHAHcR9o6v5xgQHH/cmqA4CDZBZp3jCteAnsg26dG6YhEGh0gr9/TQMlmvIiowmqw01dAh1uGuD422wbUmI13UM917EDfyJzxE/tM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040979; c=relaxed/simple;
	bh=EcDCYECK5+j6+XWoLy2vqyg/jx4aQKxpVgTkD3yuB2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljH5tFLVcVtWG8MWMZ7sv/nw5AQYnE5w2zH9sqKFEiyrhSGG7EcAEC2REl39bTIvvL79CWvEdsY/2dj8JdtxOCj37iJphCTw9vKVSHTb+uEs8tOy+vdBUDBSXASSzEzqmOPSg4xQFOgUInzX3ksSKa33aBHnkW7VhdvLh4rU/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKR9dzTz; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040978; x=1812576978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EcDCYECK5+j6+XWoLy2vqyg/jx4aQKxpVgTkD3yuB2s=;
  b=EKR9dzTzBbmqTJN+MhAu6NBFKv2BMTuprst3Lf627l/g8vs3ZvtkgwUx
   zJhuLfCRUqZeNXWX1aPaPDL3bz2T9zGknAA/XJqJQcGt28EQOougmxR44
   9VXv1SWxq29u9A5A8iedEfc5rgpeT4tkMjd148WZ6tz3jf7E9GectwtMq
   DOZzlFJmjiwwoHP4gn4cX8Qs0f84+DYA0uk6IPXkivvCt2qXqwGIDNKuE
   GN6AXTSRMKb3Jo9wGRTJJJFR+GjzbwXfCBcstMD3xlN8LGkeAB3FymBkQ
   gpEUBeeqo5GqXejPZk25/pA2Vswm6gfJwEWoHBXnPCK3rd4PnvauYj2Od
   g==;
X-CSE-ConnectionGUID: beTPc9dSSJOzSX84mHEGVA==
X-CSE-MsgGUID: nXnDk+0pTzqqgCPXUTR9wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568584"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568584"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:09 -0700
X-CSE-ConnectionGUID: a99heZZJTrO7fUtjUZLGSw==
X-CSE-MsgGUID: PfFnbpMqTAWKGfdY2JBiMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838598"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Daiki Harada <daiky0325@gmail.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	Kohei Enju <kohei@enjuk.jp>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Moriya Kadosh <moriyax.kadosh@intel.com>
Subject: [PATCH net-next 10/15] igc: use napi_schedule_irqoff() instead of napi_schedule()
Date: Tue,  9 Jun 2026 14:35:51 -0700
Message-ID: <20260609213559.178657-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297306-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:daiky0325@gmail.com,m:anthony.l.nguyen@intel.com,m:dima.ruinskiy@intel.com,m:kohei@enjuk.jp,m:aleksandr.loktionov@intel.com,m:moriyax.kadosh@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,enjuk.jp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,enjuk.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B76E664502

From: Daiki Harada <daiky0325@gmail.com>

Replace napi_schedule() with napi_schedule_irqoff()
in the interrupt handler path in igc driver
Tested on Intel Corporation Ethernet Controller I226-V.

Suggested-by: Kohei Enju <kohei@enjuk.jp>
Signed-off-by: Daiki Harada <daiky0325@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 89b9e1d00fc7..9143d591083f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5688,7 +5688,7 @@ static irqreturn_t igc_msix_ring(int irq, void *data)
 	/* Write the ITR value calculated from the previous interrupt. */
 	igc_write_itr(q_vector);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
@@ -6059,7 +6059,7 @@ static irqreturn_t igc_intr_msi(int irq, void *data)
 	if (icr & IGC_ICR_TS)
 		igc_tsync_interrupt(adapter);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
@@ -6105,7 +6105,7 @@ static irqreturn_t igc_intr(int irq, void *data)
 	if (icr & IGC_ICR_TS)
 		igc_tsync_interrupt(adapter);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
-- 
2.47.1


