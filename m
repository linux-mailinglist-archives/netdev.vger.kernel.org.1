Return-Path: <netdev+bounces-283891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BuHHm+y+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:51:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D304C0177
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEFBA30650A5
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109773DFC8F;
	Mon,  4 May 2026 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a4fpQEqV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5573E0249;
	Mon,  4 May 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905851; cv=none; b=Y9HhK3aPeUf7OVn0lm6o4fSlr8KFgkgB9AFpPFzuTnaVTeswPM5VWImjMUMPYde3oKrmB2kyx8LbfDBJM9bG9d3Caiqt6nnQxfMqyVlryhrCY55mtW50coH0NoAznRsRqb7Gfor3cih4ReB1tRNUJeDG0IlnQrsPYiH/7qfvqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905851; c=relaxed/simple;
	bh=ij6m2Zw7qmqJMLa1sxeBDVQogIFh4XZl0pqMXbUT/vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oQKw6ZVsM2s/xgll/GcZEc33c987lXz9UWMJiA4vj/EbSqVu+qCkqaCSRo6nUZhDtGtA1MEaDnYF3JLesKLDULmG8kc7jtuSMoupYLWBYENEsAQQfUmKfxytLsY1viH2EJCuq5XNpmOGwzg03XEVvzLdcUoNFuhQrdu70So/S80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a4fpQEqV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777905850; x=1809441850;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ij6m2Zw7qmqJMLa1sxeBDVQogIFh4XZl0pqMXbUT/vw=;
  b=a4fpQEqV318VjuZtEM59NL4AnqHHgwvkTQLUPAQ8gOACjECiWAUB2ntA
   2HpJp1R3l1DlqkSWlTajAF9atS3nR9DdgN3T8RWZEDJPWtRK1XX80PI/q
   T6uF3JvdLKW/HUnSARFGWwOj/rQ6c0KR+xsYpXdwffpmpSfkLcPz3yTGr
   OEDnnOzemj2xe34/eWotzPamWsTpKpsekAShBbPOANO1FXnEw4XZIMTrc
   iYLt59OWpaNr4piepGTOdDfZljfALD75djSfXIRlmoUlIvVdGjfBfJ2cl
   2NqMKcouGIXojYSvbPeMfZPCvn4ZriiTZe6uWtbsnPnFk0J/plp2VBUtC
   A==;
X-CSE-ConnectionGUID: T41Wt9DfSqeTX7IawbYxdQ==
X-CSE-MsgGUID: IadO+9T0SGyphG3GdFXGEw==
X-IronPort-AV: E=Sophos;i="6.23,215,1770620400"; 
   d="scan'208";a="288370927"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2026 07:44:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 4 May 2026 07:44:08 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 4 May 2026 07:44:05 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 4 May 2026 16:43:44 +0200
Subject: [PATCH net 3/4] net: sparx5: fix wrong chip ids for TSN SKUs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260504-misc-fixes-sparx5-lan969x-v1-3-6604306b5743@microchip.com>
References: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
In-Reply-To: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>, Andrew Lunn
	<andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 00D304C0177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283891-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,microchip.com:mid]

The TSN SKUs in enum spx5_target_chiptype have incorrect IDs:

  SPX5_TARGET_CT_7546TSN    = 0x47546,
  SPX5_TARGET_CT_7549TSN    = 0x47549,
  SPX5_TARGET_CT_7552TSN    = 0x47552,
  SPX5_TARGET_CT_7556TSN    = 0x47556,
  SPX5_TARGET_CT_7558TSN    = 0x47558,

The value read back from the chip is GCB_CHIP_ID_PART_ID, which is a
GENMASK(27, 12) field, i.e. at most 16 bits wide. It can never match
these IDs, so probing a TSN part fails with a "Target not supported"
error.

Fix the enum to use the actual 16-bit part IDs returned by the
hardware: 0x0546, 0x0549, 0x0552, 0x0556 and 0x0558.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Fixes: 3cfa11bac9bb ("net: sparx5: add the basic sparx5 driver")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 8ef4050ceecc..70ca707b5ce4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -31,11 +31,11 @@ enum spx5_target_chiptype {
 	SPX5_TARGET_CT_7552       = 0x7552,  /* SparX-5-128 Enterprise */
 	SPX5_TARGET_CT_7556       = 0x7556,  /* SparX-5-160 Enterprise */
 	SPX5_TARGET_CT_7558       = 0x7558,  /* SparX-5-200 Enterprise */
-	SPX5_TARGET_CT_7546TSN    = 0x47546, /* SparX-5-64i Industrial */
-	SPX5_TARGET_CT_7549TSN    = 0x47549, /* SparX-5-90i Industrial */
-	SPX5_TARGET_CT_7552TSN    = 0x47552, /* SparX-5-128i Industrial */
-	SPX5_TARGET_CT_7556TSN    = 0x47556, /* SparX-5-160i Industrial */
-	SPX5_TARGET_CT_7558TSN    = 0x47558, /* SparX-5-200i Industrial */
+	SPX5_TARGET_CT_7546TSN    = 0x0546,  /* SparX-5-64i Industrial */
+	SPX5_TARGET_CT_7549TSN    = 0x0549,  /* SparX-5-90i Industrial */
+	SPX5_TARGET_CT_7552TSN    = 0x0552,  /* SparX-5-128i Industrial */
+	SPX5_TARGET_CT_7556TSN    = 0x0556,  /* SparX-5-160i Industrial */
+	SPX5_TARGET_CT_7558TSN    = 0x0558,  /* SparX-5-200i Industrial */
 	SPX5_TARGET_CT_LAN9694    = 0x9694,  /* lan969x-40 */
 	SPX5_TARGET_CT_LAN9691VAO = 0x9691,  /* lan969x-40-VAO */
 	SPX5_TARGET_CT_LAN9694TSN = 0x9695,  /* lan969x-40-TSN */

-- 
2.34.1


